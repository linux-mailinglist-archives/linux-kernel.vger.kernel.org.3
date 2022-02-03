Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E904A7D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbiBCCBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:01:21 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35211 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbiBCCBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:01:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C44542B0009C;
        Wed,  2 Feb 2022 21:01:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 02 Feb 2022 21:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=9CK2u6ee+e0QjQkxatovO9y+1G1KA4Gn5dGKWr+mjC4=; b=ZnegH
        ZQ60vHjqTX4D7uUYXe5eqphy9Hom3Q0OMy2nkIxlMA2DdDrxYZ3DqqefN+nQtUpT
        yNXkOPQdeKyZP7jhIAJobfZ8FFSZxqNqWrVDqK6cst2uAyFZ3PkpfW8eyZxtejPL
        FOJgZjEW2/+OiJyTAeMNteQPecTYN4uLWsQA6cVjr4t5oc6dTfzkgNNOiLByxQIz
        vRWF+AuWVFMDrBvDos1EfIqxc/QQfTfqTUNtErkCPAH6mwpmc3PWWaJIPOjENi8V
        u2WSTGgtrgaC3ycJRELZlLaEu00TLYU4KBvxr+nhR+XgCBXUz4M99HDTlJ75Ubb1
        4yxd0S/CMOQRfEhXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=9CK2u6ee+e0QjQkxatovO9y+1G1KA
        4Gn5dGKWr+mjC4=; b=k+D/h9SjwYCWKitapyjE4CFvr771k8gxw7Y8BIGXhXRSl
        3BmwxtA+eIgUyRHgv75UY9/Jo0FqzFvrWRN4gkUorKLbDuYzrM3acKPJhmKH134S
        5z/4aAGAmOfuFc2//n8aEdm/ZjcGElm1p9pd9Ih7/UMsNI/u5KBUmSWM1ZNRbrfw
        P+WKUvNQsUvrE74X6NkwAnW8bMTI77EYBL3FtoYgk1ESHKTRxV+1WP4Q0P7gVdRx
        xBaev1c60GKfmA2F93IENygqGpEmSBHdB2FCFgXKHcOeobdS49qDtUwR52THaFzH
        lqomZuaRuJyFomiG3YKBGitWxLepYkIuGvuRph1eg==
X-ME-Sender: <xms:bTf7YTWTuuKlb-2J7ORvbqYz83iYnI8dE9FX0V4QiNm_qJo6jtnjFg>
    <xme:bTf7YblnhByH9vvLtIvCq01RWFgLFs8fnLxUbpQNH37z0LNjbNWItK04uFEnHw9Ns
    WDCenOTGpa-GHRJoQ>
X-ME-Received: <xmr:bTf7Yfa3fB2XRQf_x8SZC4o0PrgTEFbYewlgQcpalf5dKPrMETPMx61W2Sbo4NPpttux9Ff4s0XMzJ8HLyKgPTQCaHduwDAExUL4RT4GUaIommUvGy-u2zi7vsIM0ncVj4qmCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:bTf7YeXDDMu_6kHYY28fau6Oqk9As0BsFHH-IU1ijs457m3pHLqUGw>
    <xmx:bTf7YdnqzlUBoXW4aEgGLSOY3k7B_lYhOtW-nqNAKbnT_X_e9XAKRg>
    <xmx:bTf7YbeQC5-kdjTaVhdNw7qQnWtRB-ASPOqgoIzTa_DSCDoagXD-Tw>
    <xmx:bjf7YfnzjWVR7i8J84FPAx566rYwrVhpQEMs4t9x_SYoc3USMjfIpoQvK2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:01:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-mmc@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/3] ASoC: sun4i-i2s: Support for Allwinner R329 and D1 SoCs
Date:   Wed,  2 Feb 2022 20:01:12 -0600
Message-Id: <20220203020116.12279-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the sun4i-i2s binding and driver to support some
newer versions of the hardware. Each instance of the hardwar now has
multiple input/output pins, and channels can be muxed between them.
Since so far the driver only supports a "default" linear channel map,
the driver changes are minimal.


Samuel Holland (3):
  ASoC: dt-bindings: sun4i-i2s: Add compatibles for R329 and D1
  ASoC: sun4i-i2s: Update registers for more channels
  ASoC: sun4i-i2s: Add support for the R329/D1 variant

 .../sound/allwinner,sun4i-a10-i2s.yaml        |  5 ++
 sound/soc/sunxi/sun4i-i2s.c                   | 68 +++++++++++++++----
 2 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.33.1

