Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93317484831
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiADTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiADTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:04:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2DhaCppRWQGPWcr/nm/x95SNiVggsLhkIma5/VYD5xg=;
        t=1641323070; x=1642532670; b=klTVguWqCR+dJ8SspHrHBdB+mNeFv2A5sQP+mrgUPsirbx0
        swAGgquzDPxmdTYkkFnBG/K2Au5m3sZM3JNmzMi0Kw9OQ412EQWRoV3MSFtkYbkqbBc0k9/VANwKj
        rDqBWi1NbAlVWNk5gc8OXJ/T40WtedUz8Yo6mQscGnmAV+RogGSNGdZuDUdzUV5nEJtVInXtSOOkL
        TRefrtwTZf+bnRtAtkJGQLL4PFfdHnnQ43HVdKB5iGFodv1NT19dLHjfTxiiuDqFuRDucjUAoDfFI
        oldhY4ceRoibKM36pONAE7V6T7yRVBYp26RhQ9dSCWmAXJYpGj9L54utJ0SAJg7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4p6f-001r7M-Vi;
        Tue, 04 Jan 2022 20:04:26 +0100
Message-ID: <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
Subject: Re: Occasional hung with UM after enable VMAP_STACK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Walter Lozano <walter.lozano@collabora.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
Date:   Tue, 04 Jan 2022 20:04:24 +0100
In-Reply-To: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
> Hi all,
> 
> I noticed that after "um: enable VMAP_STACK" [1] I experienced some 
> occasional hung in my Gitlab CI jobs that use user-mode-linux to build 
> distro images.
> 

Did you actually *enable* VMAP_STACK in the config as well? The commit
just makes it *possible* to enable it, you still have to set it
yourself. So you should be able to easily check with/without that
setting.

johannes
