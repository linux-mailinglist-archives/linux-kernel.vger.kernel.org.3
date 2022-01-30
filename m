Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE094A3451
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 06:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbiA3FiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 00:38:09 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:34729 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbiA3FiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 00:38:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id D361D2B000F5;
        Sun, 30 Jan 2022 00:38:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 30 Jan 2022 00:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=1rqu8ovDt5jiEOh0FiPzujSwve0D621YxOMlp01bnM4=; b=OCZIf
        MqvJwBzV8jNbNhO36jIma0XYv4cx2Y5Az/MCkANREnDw/Vukv5MhFO4/w1AgHNAx
        asCJ5SC8VrrsiF/6gnPQTeIVX8TmNWzbY0EIwddtQ+3HpivA2uqPdVvWSy5qpc+E
        KI2NjRealuSm5lyDm8EOaWdlJZU58N+5IhEr263wA7fj4SFKLAu1WtR22rHF/JvB
        z9leBUMNRI92UvPaeaxlYnkBaE//8TY7Y9MDATegDr2s+fDiC58knvEAWRBwnoU7
        Tg6bJeouw9DHr3nuM1jDgtgwHRbNFyvAMjLHlCvXGVakIhrQB8T4X8FegxsWJt7U
        mX+1YX2Iyb+mqUmxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=1rqu8ovDt5jiEOh0FiPzujSwve0D6
        21YxOMlp01bnM4=; b=Epl8d4/wvl6ckFAimMTXce4VZP/KN1mlNku2nWandZu66
        UnbwrQywzeb8AJThv/R42ohVOGNAd9msrbiXdaYiGA9tR7062q0auGWQKG4LHvQm
        uGvDYisaCKq+FyB+bTehIibWkFxhoX23p3EJCAdx2TXVbxC14GMSnSZt7/46P9xl
        mTj1TsV6S5JI+IT4zkOuRA/9fXC+hYiK54THCF+rHsD2lHyIa9cFQngLk+ttftrT
        JRF8MMp7P3T1KDz83+1lQKKqLaaYRI6sxN+pH/B9WvpHnNk4iM7IPgE05e+M+76S
        LktXsQrjW/zEFiV/WcGbhoHXXAt0hlMxIKGBgOqaA==
X-ME-Sender: <xms:PST2YUj_ldDhKcqkVD9r16yl8NEZuIHZoWkAbAbhNA8BfdahmNmJug>
    <xme:PST2YdB9jqGgpZI2iq2k-1taSGOabBYg8n2nhh6xxo1cviPiig_xLl5U0x8QYOGAB
    gMNOx5hMiCgW2qIcw>
X-ME-Received: <xmr:PST2YcHJ1CEIicnzYS5ZgXsSfQDwJhjMzjRDLtbNxnx-7li9jmkvoeM1VTJv4ipi6Lqrw_9k-Zoox6LMtHLxzhrc3Xeaf-7drUxqV_umh7o111lyoWntP4WXMsLEvKGwbZpxww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:PST2YVS5rDUbhcZdKn3YjLUn7a15DOn5t078au0v-B4V37kLmpNrwg>
    <xmx:PST2YRwlwPayaDeYzr1EWMJ8hFpvZGoJ9hf6F7tPJkNTUhH5KFmHlQ>
    <xmx:PST2YT6R3a9x41q0_vf9P3aZ51vTa01bL7aLyq7FwqmeffxxPFGumA>
    <xmx:PiT2YX5vErESfvILDb2YP3kKHdEGTiGTV1zLe28_2EyTkCWPEwveUCDaNQo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jan 2022 00:38:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: Add Pine64 PineNote board
Date:   Sat, 29 Jan 2022 23:38:01 -0600
Message-Id: <20220130053803.43660-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PineNote is a tablet from Pine64 based on the RK3566 SoC. There are
two existing variants of the board. v1.1 was contained in some early
samples, and v1.2 was sold as the "PineNote Developer Edition".

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4aed16176434..77fedeae8d2e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -481,6 +481,14 @@ properties:
           - const: pine64,pinebook-pro
           - const: rockchip,rk3399
 
+      - description: Pine64 PineNote
+        items:
+          - enum:
+              - pine64,pinenote-v1.1
+              - pine64,pinenote-v1.2
+          - const: pine64,pinenote
+          - const: rockchip,rk3566
+
       - description: Pine64 Rock64
         items:
           - const: pine64,rock64
-- 
2.33.1

