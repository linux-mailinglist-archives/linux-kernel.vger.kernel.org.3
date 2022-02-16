Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2C4B853F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiBPKJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:09:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiBPKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:09:03 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2E2B7618
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:08:51 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9A76D3201FEA;
        Wed, 16 Feb 2022 05:08:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 16 Feb 2022 05:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=1FMOJ9Hsby6+vC
        NKbH8TDqnGPVVr5E1r2KGYfIIa3mM=; b=CDQA3YZYoLCp0EJpXzRG+mnkWcHWgL
        Wc5yh1cesHtBvUeYIKVDGpkUErCCZLMJZSgQJTWN4+e9e39eLRSsTBJ5xkO/9tvh
        R7YtYNowtpaBxQCy9OGMdL7HRG8xJEmK3RcXvuADHLuSykVq5m87GGShfO8YI2L7
        NZovLgo0ZbR6OIGQcMiSawgWUI1qVv2qTGZIpby/iXI62yrbvOgf7oVcR+NzVLJ4
        YSmC1DzP/8bLCsNL9Dk20vK9SRMh54D2qVyTp5JnkGD8niF/Pzr3lI0SyaXHrKhc
        so3qZBqsoSiUX4fzbrXfJv+HrJTr53g92iNwfa6U+YOqBgEv5Ush4TTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1FMOJ9Hsby6+vCNKbH8TDqnGPVVr5E1r2KGYfIIa3
        mM=; b=CVsFF5OK+e5ZpTsQGHHJYw7uT9TBilLKUP75bytItVflxN0Beo+nGOY+f
        a6tDgLYjf1t6nD7iYtuw7bEonPjsnai1Xn1IF7tIq9uNfkX+8/n/tfS29SfyqaA1
        mY10FBMo4YbUB37rdAxTCmEH4jOhUED8R9EGom3HXXbTQnUWC2Wgjm2FBbvEr6gK
        othmdGLrKGPbQ58d34GR0miOGPLsHluYyheQW6yNlSkQl2hAzZzkpToBsPaErGCc
        eLkx0TYj+sbNl69Gpz62dFIj0f5YO+lrZvq/U3pIERHJ/wlan1Encd1ESjH2loX5
        kIA5vZQIBGNL9c7tgZN131ZYMOBmA==
X-ME-Sender: <xms:Mc0MYmDCsgiV-mUrRvU9oDQC3xmmQlKDuW1hzK2ABYJRQTNgEkQlzQ>
    <xme:Mc0MYggfNQfA6RMjmb5Ce02f9yYKwwVb4jVrJ5O9CBrgTR52zupnXyL_ylo8fsRfB
    orxZGwGThsohjOBGmo>
X-ME-Received: <xmr:Mc0MYpm-P06Z1Of7xjrX-B17BsqZ97fkqJK60CLKjE0bkbNkqM71jvRtrEYFAK-ZEU0nmsQwME3P8j4tXHbMJAz8aE8baK4cjTyHl1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Mc0MYkwJUT4cYzoVhm4ZwDGCRkp4aCxR_V5OFuVOfPMM0GaJ7pb1Ew>
    <xmx:Mc0MYrQBLw3Ltkf05HoZahjcHI9k35YW2VTJWNor3RuZ7w719KxBqw>
    <xmx:Mc0MYvYNYgPIER3HLxrXZuvNf_m98KVZDz5u7JPXx03SxNYmWWTafQ>
    <xmx:Ms0MYmF_r1K8DKw45f5mJAiEbMIivZAZBhMpyLoalWcD-wN__T-blA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 05:08:49 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     cgel.zte@gmail.com, emma@anholt.net
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        Zeal Robot <zealci@zte.com.cn>, airlied@linux.ie,
        mripard@kernel.org, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>, daniel@ffwll.ch
Subject: Re: (subset) [PATCH] drm/vc4: Use of_device_get_match_data()
Date:   Wed, 16 Feb 2022 11:08:46 +0100
Message-Id: <164500612144.612087.11811919459235760311.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214020530.1714631-1-chi.minghao@zte.com.cn>
References: <20220214020530.1714631-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 02:05:30 +0000, cgel.zte@gmail.com wrote:
> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
