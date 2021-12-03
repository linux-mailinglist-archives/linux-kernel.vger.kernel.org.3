Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC95C467455
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379673AbhLCJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:59:01 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57673 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhLCJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:58:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 36DED5C03D2;
        Fri,  3 Dec 2021 04:55:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Dec 2021 04:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        XF066aufznsJ0VVJ2AMVED5Bp4crZLwsOB+9OwvG+vk=; b=O9s1ulDr2jcmN6+u
        bquRYNCdxId8cgdFm40tc0ply85Z2xxv5QxA3qMvQkNUttHgIpLe+pyavjfr0Jn+
        1L9+jTr835ncwrP1x0axHqwpanOvuSFRgd7F8A881DIUaDYGgIKV9oVHE3yjkQOl
        9RsKIxsTL/ttlMhXTvl+W7iOOQlAh2cAVh1nrCexXm+3pvQ3NEYtaUCKoJIT6LLo
        27WMKF2Uhw/r4D6KE2PLnaqbHUtKFsPaMqQlk+2z3BgEn/+vMjhy1czc651uztv+
        bw302ZtECl8RvZL6XoRGUQ4d89ELP4I737vcNwAi6Tw5oB/5EqcRoE8UkmdQzUbp
        MKymIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=XF066aufznsJ0VVJ2AMVED5Bp4crZLwsOB+9OwvG+
        vk=; b=gHJDgZKaSGS+e7V3q6ENLxJbTYUglMhCyIEKxdEpmvv/RuTgDPnXp6joL
        wLMfQoEAW1sRBINslbYJqJ+Duykjn0m8YkmqTxBIyHfm1409pwHhagnKGMryaiMK
        /ID+pCB4rcJSgeNK//eRPxsuKtYTZrG/mWJrutv/TjaYT8t/x8d7uBjd7eYIG3m5
        9RbX/3dPq0gC9JLMnGKClqPSfURidWd/jWzS0/xz/eCXoB76hrN7d6LJh590mu8g
        2q7DuhUynE8QOloBqRpvvXn8jWZBvaxIperrim2GtFxJ6mS0K5FFT0zLw1IgTQcI
        XgXsBP4N6Nmfq7VVXR93hTzInvU+Q==
X-ME-Sender: <xms:kumpYazfc8tvvp1EfLvhEVV8C-oLcIb8_eIIt4fVSt0gRMSQg0Yafg>
    <xme:kumpYWTg0F2vyVv3gh6GkXTWLTEMKgOHooKQiRXfHOCQr-9BxpVBm9QWpaUnB8xSR
    9fwupTDSFspGRc_Fcs>
X-ME-Received: <xmr:kumpYcW6GSdpQfU-4u6Q2Owq4aS-32sSPpvmMTL7lcxEHPlFC2GEg98O335JVZnsTeuQoAdiG6AYMi7Ft5RwgU9o6Dlxv9ebPHD8Z_I2a8sAiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kumpYQjwQAywo628Q-YDfd8yH-l6taDVNoydlLRYolN5CAi6zZKo_A>
    <xmx:kumpYcAn8QJdd1oDgWEwV2gw_Ga929WVjlRo1HLj_pYesF24C4qxpw>
    <xmx:kumpYRIJS5A9aH7k8sqqV4rACkqS5G1yf7rKEDZ_moE9NXkd5ysEag>
    <xmx:k-mpYaBLg5N5lZwYUqenfHlEhjoyXeMwaD7YTWhDb6HTdA97zAOvQw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Dec 2021 04:55:30 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: allwinner: h6: tanix tx6
Date:   Fri,  3 Dec 2021 10:55:26 +0100
Message-Id: <163852532166.564423.11849623195083021706.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 19:21:13 +0100, Jernej Skrabec wrote:
> This series adds new Tanix TX6 mini DT file (less capable as Tanix TX6),
> adds MMC1 node for wifi and enables bluetooth on Tanix TX6 (no bluetooth
> on mini).
> 
> Please take a look.
> 
> Best regards,
> Jernej
> 
> [...]

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
