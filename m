Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F253EBDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiFFPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiFFPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:22:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393453899;
        Mon,  6 Jun 2022 08:22:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 15so5900634qki.6;
        Mon, 06 Jun 2022 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+RKIOBF1OQyUNrZYbnbVUIUGYZ5O+hX0E7GZIjjSWI=;
        b=Z4DdLkdgtIojvPksRc1nRsDAhfDBzi2t4FpFde7mk1uVMzqpsfSCZAND7jQOARYrj7
         ywmaDIXJ5jpLMJPYvkwao5ALMAtErh0UGZVXmdMDyTEDfNF+dyq5q9RglZf0+wSK4le5
         ME2qKQnf4vkuCddfAbROLrOUoSrJBnpro3Ch+pvINf2rcMboq1DO/z+7IfV1+ySaZcTF
         5LK01Y3h3yXMxuiqOkWuD5Myoq3OXXItuWyCr8L1H6QWJpZ6MMI3dW27g9t9pGYm5Jq3
         wp6SONpuHytw3hmxpcIcD+Zt5WzxrCt1kbPn3KzEPx3YR6VMFdYnQeyjHlpYxQXmjUlv
         I9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+RKIOBF1OQyUNrZYbnbVUIUGYZ5O+hX0E7GZIjjSWI=;
        b=bejMdqMnq9ZK0eMljeA6otJp0D5X4sf7HO4dp/ZEZkNMXaJRf4n62DkRA0o3pPPhHY
         RzU3HU1wfGM9TKF4YJnqZnl5d3RYlxFYATS+Ut4RAMzsphxKbMO3J4gE6Jg8/pN4HJTx
         Je5QHACYkkhX1apdNQYlLeFgWa6nhZrEfgEkJOjS15EWb3j90P980R97LDpVjUxD3BID
         1m2cWjHaXUIZVO1hMEZEHlmNiYfo6MfSYhlgmCyc+yC6Co35Yk+oyeadF7zk4PCv4K0D
         50ms+c2T4kzx+Fej2JF3BWXqLHGlzqOgK+oC13rVwzQNtlERLD8NpzQZJuYq/CmdR7pW
         oapg==
X-Gm-Message-State: AOAM533cIMjKlApVJ7l3oWD6VNl9KuKEfBrP3mPkGmzx1dRMaKXI9HTR
        G0yLWEm27z5Mldk3qFSxOZY=
X-Google-Smtp-Source: ABdhPJzNZVI3s+nxt6m2FFvXcQvwZ0jgqwi3ZUNIyXgPjRgXy261jsfK6+B3tV7qSBt4YCbJPSmSlg==
X-Received: by 2002:a05:620a:4305:b0:6a6:50f8:17e3 with SMTP id u5-20020a05620a430500b006a650f817e3mr15315327qko.389.1654528927273;
        Mon, 06 Jun 2022 08:22:07 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id e2-20020ac80642000000b002f905347586sm9784635qth.14.2022.06.06.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:22:07 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fixup! arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
Date:   Mon,  6 Jun 2022 11:22:04 -0400
Message-Id: <20220606152204.3671113-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a gap in the address space leads to read issues with NVMe SSDs.
Fixup the address space.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

It seems this address space change was lost in one of my rebases. This
fixes up my original patch to correct issues with NVMe SSDs.
It's based off Heiko's v5.20-armsoc/dts64 at:
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/?h=v5.20-armsoc/dts64

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 99ab013b8ba4..cc1c5a65c5e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -839,7 +839,7 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x00000000 0x0 0x01000000>;
+		      <0x3 0x3f000000 0x0 0x01000000>;
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -868,8 +868,8 @@ pcie2x1: pcie@fe260000 {
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
-			  0x02000000 0x0 0x02000000 0x3 0x01100000 0x0 0x3ef00000>;
+		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
+			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
-- 
2.25.1

