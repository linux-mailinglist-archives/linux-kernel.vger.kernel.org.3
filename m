Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DF4B21B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbiBKJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348536AbiBKJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:22 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A41036
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:21 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lg28r-1o6srI03FD-00pejf;
 Fri, 11 Feb 2022 10:23:55 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/12] arm64: defconfig: enable pcieaer configuration
Date:   Fri, 11 Feb 2022 10:23:13 +0100
Message-Id: <20220211092322.287487-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9bsxxyIaI4gmX5VQM94w3Boju8MRYssZkxcMPD6x+79tpyNHyp7
 UVEadPGEm9fcAPpQJNo9n3BdcBNMBsjaZHItB2/3JuSiqrhWBzmFB9m6nLKFPo69W5ZN9ba
 W5a2MDel9TB+yj3iFzMZggdSBRSXuKZBMICwGbIlGhk87TOtIPHYCKjVHAN6eQeZNuAnm7G
 gXPqwKQ7Dlp3txWbryIdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JiXD5727ceU=:4LVFS1vsgLkgKSxTV9eHxD
 mf3E+smglbtx8T/t9SOZ0nv9buTu0YldcSvb4IDuUiCyHJlW/UHkXgaKFEpHgFMeR5X3LXT32
 135cX7pqixBONzVqi+pfkltTaVWmN13XKdAqFNJrlFHqNrYIO4SNEZE6GWxsJ4J/ZD2k9tknb
 1Oak+TptEMVeS4oiOQKAetWrY80RRW9MqkHigMeaX/SFiIcuo4veVwN5CN0DsxY9laE2gFlwc
 qgbItO7AvI+7dwSItzp8K8eX7/o2LzE4Hzw2hG1Zi79hJZSyhtHw+bab2IJFHO4Syi4eP4Nz8
 p2zgvCqQTVXoUOnCEGuU7FCR+84nk5DvO92N1aeFDJ/HPI5v5h0XZ0yVzRQwkRc3KkgP5BrT/
 GknaNOL5uhfDHp9ReV5F4RTblezWNLnF1WJg9kpSVU8Ma7OqXxkQrbYXT2WwpyqaS7nlp3gzG
 AKw6Y2ntU0fPYZP/VAznYVoSo839atY1XJp3zxLrjfAvOJ/2xse+V+LnpbUTMROVX0JwB2v4U
 VyINbl/vgtWZNw+CFECEyk2JFTDxwQUiK8V6G0c7uDOCd86X6Om/e12ret88YjUmJTpKmtk/n
 Y3+4SIOPC6K4TmPh9LsuDbNU+sCSFpbrUFY6TgyFKrq4oORs46PR5JUDB8505+wyeY9ZHc2AQ
 qcTIAoHSK037TQ3fXgP+/NOwaA0gyQMIfQQw0poqznb4X6ZP8WgQar71tsyuj+86F1RcdiH1z
 qzLhGEZoLne0Qoal
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_PCIEAER which is required for CONFIG_ACPI_APEI_PCIEAER.
Commit 8c8ff55b4da7 ("PCI/AER: Don't select CONFIG_PCIEAER by default")
changed it to no longer being enabled by default.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add Krzysztof's reviewed-by tag.

Changes in v2:
- New patch following full defconfig analysis as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b057b08c0fc2..c37dace3e89d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -211,6 +211,7 @@ CONFIG_NFC_NCI=m
 CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_PCIEAER=y
 CONFIG_PCI_IOV=y
 CONFIG_PCI_PASID=y
 CONFIG_HOTPLUG_PCI=y
-- 
2.33.1

