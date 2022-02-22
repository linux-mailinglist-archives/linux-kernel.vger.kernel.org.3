Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D34BFF21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiBVQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiBVQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:45:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BE169380;
        Tue, 22 Feb 2022 08:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RV3r/FyWMZxOU+OB5U/7cz0ame6ae2fwMla9IbBoUWE=;
        t=1645548327; x=1646757927; b=U2Ofd6CRzMX7TuEMOliU8aeDmOLLhjPpRgzaEegXn3jEDqr
        aVy0Mis3+BYThfjYbtTRqqCT7JqltjOluFFdKBVqBwG2FIUu/WuAZf8SBQ+FSt94h2xG1KDWYmhtM
        sqEACtCu4LW9ZMmT6NFwFE8uxGqOwTyfvNdYFDcjj1VGhyS2W+RicHdgiRAAxfmF2tDISdbbeVfDW
        sfm6REi1Jgj9fZpHJb/qbGkIYJBrzO18Pj+zSUE5R7GfSMQvvHC5VGk2hZ8M/fFOpvC0J3D3p59ab
        tFARZlNv81UCFO7dq4SSTVyTiHQ77Z3MeHUDeQspRxpNSjFbtDenX+ns0pOFAbxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nMYHo-004KHx-PN;
        Tue, 22 Feb 2022 17:45:12 +0100
Message-ID: <116cc3c6cdf4d515a31848dda915b9c21ce02922.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 origin tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     broonie@kernel.org, Kalle Valo <kvalo@kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 22 Feb 2022 17:45:11 +0100
In-Reply-To: <20220222161218.4028508-1-broonie@kernel.org>
References: <20220222161218.4028508-1-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

Hi,

> Today's linux-next merge of the wireless-next tree got a conflict in:
> 
>   net/mac80211/mlme.c
> 
> between commit:
> 
>   a72c01a94f1d2 ("mac80211: mlme: check for null after calling kmemdup")
> 
> from the origin tree and commit:
> 
>   820acc810fb6e ("mac80211: Add EHT capabilities to association/probe request")
> 
> from the wireless-next tree.

Thanks. I think Stephen had also noticed this before.

Maybe I'll just move the new code around so it doesn't conflict anymore
;)

johannes
