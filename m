Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451164B21B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiBKJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiBKJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:33 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2311083
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:33 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MfnzW-1ndRU226ke-00N9dQ;
 Fri, 11 Feb 2022 10:24:14 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adam Ford <aford173@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/12] arm64: defconfig: build r8169 as a module
Date:   Fri, 11 Feb 2022 10:23:19 +0100
Message-Id: <20220211092322.287487-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MFlx40zwNSODjArGcvqwJ9w1oR/n8nN6sCAacYEhspQ9MzbrDwm
 ECnOflmhgccbMNV7X8l+bZVfcmtjaa8HcuGeiZhleTbUtguiZbuNWTd29n4QhGa2UopRJKE
 gim/zFbO6xtttzXjc1NqwU4L8LtH9I/4o+SmvSt4g1G2k+O7QqGrpw+SQ44MqriolK22CJg
 pLAa85yhJEomBs5PLOMOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JsbmGeVIUtE=:8uSn5ruLpG1WZF6DpBrCj1
 hj9uJUq8SQnmf1wjm1Fol1QKJEfUn6vQ+DnUWi8OeUTCDzuhxIhQ24LA7YYg5qvAKdAR4/nI8
 pETWFDbXBnwA4VEADFyrUYEWR5OKlHly1Cx+otyy8SDimeBjvH+bkphgkF9ERSabD3SsLmIj+
 KWUWU0+CvTRSFeckEBMawcj77fm4kTVNWr9cDlTwoy7F83zVm35zWNu18+7T0kMNAxSR9exBX
 fCO6xlWKCGG96HCtul6VUoj4bgQYItuU30mci1SUXMFCr1kq9AKcrz0scf+4NCZi99IDcOZJB
 rxpdiK+Pc1FJUsoQyv5mRIGpk/sH8pT7J9U3MKZzfyJFF0iN80TLmfg+Vp575CJu5E8yTknoz
 YKBDYHNZ/eptq3Jvlrj75lAvKoBVH5ujbE1YEpDkAnQ6RGQd5QUI3ZgfCybQ1jmH68R8JhphV
 r4bp0OBVCpJtRlN/X4/vkKWWcCUwM1QoaQWUWDBsi7zN3QsYWUTDzXm9puMDxYrDN1PL7rGjm
 LV64P65dZBwt4gBTkU/4Jj3a3Cqk+DRNobZtwhvNq1/RsrvHCQ9Ts8Gb2PsEIm9IdogGdbNbq
 Be41gRgUuOdMIMxv+zd828HYV0AeH9Ok6wB2gaJ9bCgAemGYHqxT+rQe/Rdm8pG6gWIfDv2xf
 Lur6Q2Eq14bCo7v+Zr6/GTh7sj1pf6pXwAbcqWYJNxVQ8CTwEPClfflxNZsZUxlvXxKlrpMyt
 nR/Xp46s1pp/rqI0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Realtek Gigabit Ethernet driver as a module.

Network cards based on chipsets this driver supports are ubiquitous both
in regular PCIe as well as mini-PCIe and nowadays even various M.2
formats. It is therefore a suitable card to be used for any kind of PCIe
and/or Gigabit Ethernet testing. As it is not designed in, just enabling
it as a module seems most suitable.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add Krzysztof's reviewed-by tag.

Changes in v2:
- Explain why enabling it may be a good idea as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 27afe24a025a..76334cb698af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -339,6 +339,7 @@ CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
 CONFIG_RMNET=m
+CONFIG_R8169=m
 CONFIG_SH_ETH=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
-- 
2.33.1

