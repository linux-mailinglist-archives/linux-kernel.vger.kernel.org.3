Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93582592874
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiHOENH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiHOENA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2013E3C;
        Sun, 14 Aug 2022 21:12:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 15F703200344;
        Mon, 15 Aug 2022 00:12:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536777; x=1660623177; bh=Ei
        w8KXKMFkR9PlzvE3481gnHml1c/VpGw/PSxEQXCug=; b=H4H/9c5uBqHvjpu2iI
        J6Dck3vHHew96Aaapc1jvqCUrdhgHxp2/l8iN/NjBEC/GFkybMfO5I90Uvz7gs13
        LewqlLsvdVFwFWGabPggDNkDf2Xaf9BrKzA9wAVlxm/eA2jzQKWoT6cpyoma6HyI
        9rAVOnOWuHseQ+cxJA3Az+0p/OBUmrehAM8dWmRvYPYuTllR8Nt/09DKeVVAVcYj
        8P86IhlJNoiUWp1ULUl84TGUWEhmjkQ4kP1Jjoqy5Phem02S0hwN0TL2dkCyKvIa
        dUk0TN0BR+geBis4A1UI6BigHabZjUNc5N9KEork6oZwyP4bTtF9PlFpfPwiuxD8
        CdeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536777; x=1660623177; bh=Eiw8KXKMFkR9P
        lzvE3481gnHml1c/VpGw/PSxEQXCug=; b=5HTwiTfuwKEDcPlv62IR1cReZRhAH
        hzcazI5HaT/Rr0niNbHU4tKA9XdTI1VDruW2VHo0qVKjpUNG8fMIJ8wsCqAmESrJ
        KgZFssroK0d7h0g9KwSGvNMHaJZHKiUZhWtY1wl+2VHoxHoScLaaxHiEsS77W9MJ
        dmJIi4YBn+axQ3qV/Fr3lk8++scGbX6piNR3VHc7aegYNbD+pEGeXwEpYS2OfrPF
        Hjj06io87mX+GvLk6QgWUI912AQJGZA5rmZjYUA2z2BcxfoYfjZ1iCPz32qsAs5x
        HDdQDfexHvHXyStaFkP62bddaDl9fPF5IVVLV/SBZE7JDB13VGWRCLaHg==
X-ME-Sender: <xms:ycf5YgHyWwVHnLpNCVh5I7V2KBcmiXvDN0kmirrZX13naeWlOFRghg>
    <xme:ycf5YpUMdSLnN70NgbcMX5oaY9wj5TOzl6BzJF2f9ASVGmERxW9aLgfJEDG7CVQIA
    zWgdrxbQKN4WT278A>
X-ME-Received: <xmr:ycf5YqKR4JtkUBRpxC30fcignc3OHShvsdUlREIFLTIGIAJ_tIdNlhewJ8kmmvtjWE6hhrByVYT5M3Jmt_XBGxqAGHf9VVep6nrwlHfBg6HxXyu43dLd86ARnC7nzXxa_NSlkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ycf5YiH6sCPxmXVGY8wOWK9ve422S_OxEHGDPDvWzACpI9_AhBmopw>
    <xmx:ycf5YmXqw6NPwu3gzVApdzv1HOhZ-Ac3y9jymsc4Asxuo2qWirTpMw>
    <xmx:ycf5YlMnBOu12EwEta4FvCQQxFLyJhyxJwrlkOaJBH-kV8QZW6su6A>
    <xmx:ycf5YtO0juTGUdw90wNb6EE8CUMlTg1jseyy4YcXR4u27KYiauT_Dw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:12:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 02/10] dt-bindings: sram: sunxi-sram: Add D1 compatible string
Date:   Sun, 14 Aug 2022 23:12:39 -0500
Message-Id: <20220815041248.53268-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
MIME-Version: 1.0
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

D1 needs to export a register for managing some LDO regulators, so it
needs a unique compatible.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 5055c9081059..d64c1b28fb61 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -33,6 +33,7 @@ properties:
           - allwinner,sun5i-a13-system-control
           - allwinner,sun8i-a23-system-control
           - allwinner,sun8i-h3-system-control
+          - allwinner,sun20i-d1-system-control
           - allwinner,sun50i-a64-system-control
           - allwinner,sun50i-h5-system-control
           - allwinner,sun50i-h616-system-control
-- 
2.35.1

