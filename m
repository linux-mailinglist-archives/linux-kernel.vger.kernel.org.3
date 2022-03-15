Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38C4D964A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbiCOIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbiCOIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:33:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6784BFFD;
        Tue, 15 Mar 2022 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XvFNllMjXqE2uJ/FiYaesrXoFBwh6gj7NI26XPZO2Kc=;
        t=1647333132; x=1648542732; b=Qjv37k+9GyyZhQ9W1ENTvugF3BBs7iTf+uBcB5ce13cY0Un
        BCdx+3OPPXX3xdKo+D5gqI9jd9iCrP5cfhdKt8omv3FrNvI658HQYcGjH/fu9HvmTePPvT2IGVbfq
        FXBYGQxnZbap/e01iaeFJ/MSMn/xbSkGcaW+6OOjCAhM/FATIG4VMs/xvW+OQZZQMKZGga5fj3XM2
        d0PeJa+pJ09v7Fbikcxg6ERDvZDNo8aoqjaWnQIlesBLnyosSqRw0bxWd6YYyFCjwR0zhzEvA9Yrr
        f2hUXh/NLbdQ9Ya/ogmrBmTTT78BEeB/eVh720X/kjrAPgt+PMh8ZFRq0nlZkCCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nU2b8-00DQca-LQ;
        Tue, 15 Mar 2022 09:32:06 +0100
Message-ID: <20b7f8d9032e657d132f37b59b32f339308cb289.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/2] mac80211: Add support to trigger sta disconnect
 on  hardware restart
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Youghandhar Chintala <youghand@codeaurora.org>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pillair@codeaurora.org, dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org, mpubbise@codeaurora.org,
        kernel test robot <lkp@intel.com>
Date:   Tue, 15 Mar 2022 09:32:05 +0100
In-Reply-To: <20220315082944.12406-2-youghand@codeaurora.org>
References: <20220315082944.12406-1-youghand@codeaurora.org>
         <20220315082944.12406-2-youghand@codeaurora.org>
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

I already applied this patch, and sent a separate ifdef fix ...

johannes
