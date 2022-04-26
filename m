Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C539D50FD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbiDZMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350134AbiDZMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:45:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5D178F69;
        Tue, 26 Apr 2022 05:42:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1422E5C0179;
        Tue, 26 Apr 2022 08:42:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 08:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650976926; x=
        1651063326; bh=argo2djj2FN0G9x5dXx6YuIQEztfe7xJv9qt4LumU4g=; b=Q
        ZNqBbgVGJcC/mYZKyJCEGTckkFXVL2qu8XZslhRfwsr2fAi03ruPnRzDpeyPDvwA
        SwbTlCuw1jv6zxfb6DapvJwmst9m/q/xW3bX1A7WdetQ4F+jeXYVSrLoQGzVowVR
        ER4MczRWUyAVvbun5U9K8egFtC4g0GlO6uEr25sB21NGy/q5xQbihE+W038d29Ij
        y5qs3LKLke4jDzf3CjgoUwLqx7uMZVIaPgbHadRUcX4MKHUrlDjTEV3ETq4q6ryt
        N8jLCbt0RqvjZPMe9qsFhQeMwWVUBSyl11b9/Qn49GY9WCbesbelqCkgH8qpgoQC
        JLzVTdAsEpRhw1SzwGy2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650976926; x=1651063326; bh=argo2djj2FN0G
        9x5dXx6YuIQEztfe7xJv9qt4LumU4g=; b=WvoiiKCrlFG6QC0F4Doj6FoJPo0qi
        nuEAeMsteJwrSHsxhInzfE24roPeRFw7Pspx9/D2G3BnHw9ATjoseO8/rt5OYSn1
        L1UpRqSQqGKQ9ov7QOU3rCNiNAW/1Fhaczv89sH87kCZqjZMBJwso0pswNs5E7yn
        1tN+y3ed8wJWtry7xcbfP4sL5RKhyVp3dOgIUn+bnM7vtT+WgfboOb9u5DkUPlVk
        K8iN58AA4acKB9I6Yrgjpg7ZslpIgxfQlsvYk3zWDN3dRUYY0iXEfxB87VBlexaZ
        nlRkOmtM5X23eZIGisPNfWo9gntAo4l8zG0wOzJyXGvG3mo4XGiXHeSkg==
X-ME-Sender: <xms:nehnYo0Kp6MoxVWxm0P8Yv22Zz3K03_aIydxknAyKMOeVXwt8W_TJw>
    <xme:nehnYjFIjAkEZvysweLf42K-UStrIzTaprtT86Eljq9tUICaQb377N_ytvLG7zZW9
    T8ECscG19Ma1hYO2jg>
X-ME-Received: <xmr:nehnYg4bIxxBmANtZEzpcqYhJLQLCtyabMFbVKtCnxSciMO4i-jchFBGSFCrPyhfOUpFVCEQBXVT2nsy0ybh4Ud_Yw11f8oLeh-RHPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nehnYh2FDN-ubuzacyiP9ea3DHsuektyS5KXU_AfzdTLUC-0e3Gk0g>
    <xmx:nehnYrF_7FDjVrr7mTLDjXQsrC9CBWiunleghHb29wGUUsTACEjVTw>
    <xmx:nehnYq8AfqXRkBdHJNY9FIbNt4YOiRnvqPUzXIoZ37nyfD0R9S10Xw>
    <xmx:nuhnYqeqZjsd2BYGQeGfKseyR_Y7C_UZpslPgL26JvBY3MR0RE8fNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 08:42:05 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: (subset) [PATCH v3 12/14] drm/sun4i: Add support for D1 TCON TOP
Date:   Tue, 26 Apr 2022 14:41:41 +0200
Message-Id: <165097689886.514433.7737681396018260793.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-13-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-13-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 11:26:30 -0500, Samuel Holland wrote:
> D1 has a TCON TOP with TCON TV0 and DSI, but no TCON TV1. This puts the
> DSI clock name at index 1 in clock-output-names. Support this by only
> incrementing the index for clocks that are actually supported.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
