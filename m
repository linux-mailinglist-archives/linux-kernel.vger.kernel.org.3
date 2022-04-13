Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91654FF002
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiDMGne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiDMGnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:43:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886D2C673
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cVjTed+m/zuV4GzvtsHxD5HPvMS98ExoUR0HmNDdnaY=;
        t=1649832069; x=1651041669; b=hbYPXjFs8k4LOFbdOaxLDLc0uhQAbCSgOm8tpoZIUuwa8Zb
        DJtHxwQ2e/MoPCJ72ksrGPL/o5KDdx1KBXiwAwgm6dbBX2pOWIvJoBKGii1GNf62US47bzq4rUjdA
        Ogg9+7ypymbGt/cJtruzjNctIxxjsCldepg+ziOIVgJZbp9Qr4Dq1kVTJf4zSK/FYQM7b84DzmoPe
        W/1BGAZ+pGo3Bn2+YbkNN0bTyR2RIe06juz6rh8VBfglDCMsdd78/WqxXWyawNSGe7wKcWtanuf6H
        Xq9H2WjGM0F62/EEbyV1+MIPcY8c4oS1Ju9Ws1pXYgR7IFw5JY3BCgZjXAzLTIEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1neWga-009IOS-EO;
        Wed, 13 Apr 2022 08:41:04 +0200
Message-ID: <785a85e05838bc056db734a35fb833083c5201cd.camel@sipsolutions.net>
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 08:41:03 +0200
In-Reply-To: <YlZg4KkiAgODr45d@kroah.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
         <YlZg4KkiAgODr45d@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 07:34 +0200, Greg KH wrote:
> > 
> > debug_object_fixup()
> > 
Also, isn't that a debug path with a lot of prints or something?

johannes
