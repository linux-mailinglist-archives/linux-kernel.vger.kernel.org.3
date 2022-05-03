Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188565191BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiECWzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiECWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:54:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4630F6E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:51:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a10so19681942oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smHHkahDLJ0acLP7DLUzLkFULvBN8/Yg0IilsfO7DSk=;
        b=Rd0xn8pCdyflUp8iv8PL+hOzjuYLoQUpDQeUbJ4CuKkuJ/xDbLDFsmya2VVCgSPmyu
         U6P9I835s9pcSFzBSVJttOGBMN3flEtDkvFYl2zgYzv9a1sOSOvXw/CgSoYlVXLlIjlf
         5sy7gAA7KBWCjVifdEXZFd/62dL40XCf4vPCYpi8QtUKWqSOBQgTm2uO4gENx/BohwE7
         P5N50xGnM9joFMbJDF0q3UO6q4ZDqjQoRVSq3AO1AND5bTluToGujMEjvAoLHr5sYqEQ
         VD++nnnUhXU7tYPX/b9T4HWAkd/5llskVCGxd2Wd9jTTOwyoPIF+Ik5qGW0E4le/PIMv
         iiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smHHkahDLJ0acLP7DLUzLkFULvBN8/Yg0IilsfO7DSk=;
        b=nBdOzg7ghwNm7PBw1G8dhbXavF/jEZ/xWZ9ci/BTXikPJERJbYLSFCOuLsUlyqxd9W
         IEYbEhMXBdQu150a0HdiWNjFe71eVvE7rebV1s0o1VBPMyMWsATI+UA53onME6vXCfjP
         mT6/cTRHNI+IWd+IyorwvSOx42YAvkchOK7JT2QRitajKpWXR+cL/HGav/x/yDSk8plq
         UQgC/0UuKkIYw+3Y0f7uTZ29JM91Ha6PTEONURO0USc7FFXwbAWXBrwDk6muix2sEUDP
         EyB9zHagDSvfvdNwAKUwUxGqe2HHhSmu9zQ00QgV8DCsuQeI8meAnjSR3PMa1CZ+tPGT
         e0KA==
X-Gm-Message-State: AOAM5323PxJd4+O/In/WEYKN3G1iEPS9TfX1T11+NyK1r0FP4TO057BS
        0h8JCXOJrkpZmB4KMQ/Lljm7JQ==
X-Google-Smtp-Source: ABdhPJwVZ3T1zNRX+13Vgh4Z+2lwBC8KH3RgNV525N2Er9jUnyofrTRiwYwHrt+afpVKGRu1OPIWsQ==
X-Received: by 2002:a05:6808:14cb:b0:326:4b14:35e3 with SMTP id f11-20020a05680814cb00b003264b1435e3mr418388oiw.61.1651618274366;
        Tue, 03 May 2022 15:51:14 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m4-20020a056870030400b000e686d13890sm7298561oaf.42.2022.05.03.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:51:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/4] interconnect: qcom: sc8180x: Reformat node and bcm definitions
Date:   Tue,  3 May 2022 15:53:00 -0700
Message-Id: <20220503225300.1141814-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm interconnect providers started off defining nodes and BCMs
using the DEFINE_QNODE() and DEFINE_QBCM() macros. Unfortunately this
results in a block of long lines that are hard to read, a transition to
explicitly stated definition has been made for newly introduced
platforms.

Transition the SC8180X interconnect provider driver to this style as
well, to make it easier to read while debugging interconnect related
issues.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Adding this to the series as a bonus.

 drivers/interconnect/qcom/sc8180x.c | 1740 ++++++++++++++++++++++++---
 1 file changed, 1559 insertions(+), 181 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qco=
m/sc8180x.c
index 6a9d9954905e..0d70062e576e 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -15,187 +15,1565 @@
 #include "icc-rpmh.h"
 #include "sc8180x.h"
=20
-DEFINE_QNODE(mas_qhm_a1noc_cfg, SC8180X_MASTER_A1NOC_CFG, 1, 4, SC8180X_SL=
AVE_SERVICE_A1NOC);
-DEFINE_QNODE(mas_xm_ufs_card, SC8180X_MASTER_UFS_CARD, 1, 8, SC8180X_A1NOC=
_SNOC_SLV);
-DEFINE_QNODE(mas_xm_ufs_g4, SC8180X_MASTER_UFS_GEN4, 1, 8, SC8180X_A1NOC_S=
NOC_SLV);
-DEFINE_QNODE(mas_xm_ufs_mem, SC8180X_MASTER_UFS_MEM, 1, 8, SC8180X_A1NOC_S=
NOC_SLV);
-DEFINE_QNODE(mas_xm_usb3_0, SC8180X_MASTER_USB3, 1, 8, SC8180X_A1NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_xm_usb3_1, SC8180X_MASTER_USB3_1, 1, 8, SC8180X_A1NOC_SNO=
C_SLV);
-DEFINE_QNODE(mas_xm_usb3_2, SC8180X_MASTER_USB3_2, 1, 16, SC8180X_A1NOC_SN=
OC_SLV);
-DEFINE_QNODE(mas_qhm_a2noc_cfg, SC8180X_MASTER_A2NOC_CFG, 1, 4, SC8180X_SL=
AVE_SERVICE_A2NOC);
-DEFINE_QNODE(mas_qhm_qdss_bam, SC8180X_MASTER_QDSS_BAM, 1, 4, SC8180X_A2NO=
C_SNOC_SLV);
-DEFINE_QNODE(mas_qhm_qspi, SC8180X_MASTER_QSPI_0, 1, 4, SC8180X_A2NOC_SNOC=
_SLV);
-DEFINE_QNODE(mas_qhm_qspi1, SC8180X_MASTER_QSPI_1, 1, 4, SC8180X_A2NOC_SNO=
C_SLV);
-DEFINE_QNODE(mas_qhm_qup0, SC8180X_MASTER_QUP_0, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_qhm_qup1, SC8180X_MASTER_QUP_1, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_qhm_qup2, SC8180X_MASTER_QUP_2, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_qhm_sensorss_ahb, SC8180X_MASTER_SENSORS_AHB, 1, 4, SC818=
0X_A2NOC_SNOC_SLV);
-DEFINE_QNODE(mas_qxm_crypto, SC8180X_MASTER_CRYPTO_CORE_0, 1, 8, SC8180X_A=
2NOC_SNOC_SLV);
-DEFINE_QNODE(mas_qxm_ipa, SC8180X_MASTER_IPA, 1, 8, SC8180X_A2NOC_SNOC_SLV=
);
-DEFINE_QNODE(mas_xm_emac, SC8180X_MASTER_EMAC, 1, 8, SC8180X_A2NOC_SNOC_SL=
V);
-DEFINE_QNODE(mas_xm_pcie3_0, SC8180X_MASTER_PCIE, 1, 8, SC8180X_SLAVE_ANOC=
_PCIE_GEM_NOC);
-DEFINE_QNODE(mas_xm_pcie3_1, SC8180X_MASTER_PCIE_1, 1, 16, SC8180X_SLAVE_A=
NOC_PCIE_GEM_NOC);
-DEFINE_QNODE(mas_xm_pcie3_2, SC8180X_MASTER_PCIE_2, 1, 8, SC8180X_SLAVE_AN=
OC_PCIE_GEM_NOC);
-DEFINE_QNODE(mas_xm_pcie3_3, SC8180X_MASTER_PCIE_3, 1, 16, SC8180X_SLAVE_A=
NOC_PCIE_GEM_NOC);
-DEFINE_QNODE(mas_xm_qdss_etr, SC8180X_MASTER_QDSS_ETR, 1, 8, SC8180X_A2NOC=
_SNOC_SLV);
-DEFINE_QNODE(mas_xm_sdc2, SC8180X_MASTER_SDCC_2, 1, 8, SC8180X_A2NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_xm_sdc4, SC8180X_MASTER_SDCC_4, 1, 8, SC8180X_A2NOC_SNOC_=
SLV);
-DEFINE_QNODE(mas_qxm_camnoc_hf0_uncomp, SC8180X_MASTER_CAMNOC_HF0_UNCOMP, =
1, 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(mas_qxm_camnoc_hf1_uncomp, SC8180X_MASTER_CAMNOC_HF1_UNCOMP, =
1, 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(mas_qxm_camnoc_sf_uncomp, SC8180X_MASTER_CAMNOC_SF_UNCOMP, 1,=
 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(mas_qnm_npu, SC8180X_MASTER_NPU, 1, 32, SC8180X_SLAVE_CDSP_ME=
M_NOC);
-DEFINE_QNODE(mas_qnm_snoc, SC8180X_SNOC_CNOC_MAS, 1, 8, SC8180X_SLAVE_TLMM=
_SOUTH, SC8180X_SLAVE_CDSP_CFG, SC8180X_SLAVE_SPSS_CFG, SC8180X_SLAVE_CAMER=
A_CFG, SC8180X_SLAVE_SDCC_4, SC8180X_SLAVE_AHB2PHY_CENTER, SC8180X_SLAVE_SD=
CC_2, SC8180X_SLAVE_PCIE_2_CFG, SC8180X_SLAVE_CNOC_MNOC_CFG, SC8180X_SLAVE_=
EMAC_CFG, SC8180X_SLAVE_QSPI_0, SC8180X_SLAVE_QSPI_1, SC8180X_SLAVE_TLMM_EA=
ST, SC8180X_SLAVE_SNOC_CFG, SC8180X_SLAVE_AHB2PHY_EAST, SC8180X_SLAVE_GLM, =
SC8180X_SLAVE_PDM, SC8180X_SLAVE_PCIE_1_CFG, SC8180X_SLAVE_A2NOC_CFG, SC818=
0X_SLAVE_QDSS_CFG, SC8180X_SLAVE_DISPLAY_CFG, SC8180X_SLAVE_TCSR, SC8180X_S=
LAVE_UFS_MEM_0_CFG, SC8180X_SLAVE_CNOC_DDRSS, SC8180X_SLAVE_PCIE_0_CFG, SC8=
180X_SLAVE_QUP_1, SC8180X_SLAVE_QUP_2, SC8180X_SLAVE_NPU_CFG, SC8180X_SLAVE=
_CRYPTO_0_CFG, SC8180X_SLAVE_GRAPHICS_3D_CFG, SC8180X_SLAVE_VENUS_CFG, SC81=
80X_SLAVE_TSIF, SC8180X_SLAVE_IPA_CFG, SC8180X_SLAVE_CLK_CTL, SC8180X_SLAVE=
_SECURITY, SC8180X_SLAVE_AOP, SC8180X_SLAVE_AHB2PHY_WEST, SC8180X_SLAVE_AHB=
2PHY_SOUTH, SC8180X_SLAVE_SERVICE_CNOC, SC8180X_SLAVE_UFS_CARD_CFG, SC8180X=
_SLAVE_USB3_1, SC8180X_SLAVE_USB3_2, SC8180X_SLAVE_PCIE_3_CFG, SC8180X_SLAV=
E_RBCPR_CX_CFG, SC8180X_SLAVE_TLMM_WEST, SC8180X_SLAVE_A1NOC_CFG, SC8180X_S=
LAVE_AOSS, SC8180X_SLAVE_PRNG, SC8180X_SLAVE_VSENSE_CTRL_CFG, SC8180X_SLAVE=
_QUP_0, SC8180X_SLAVE_USB3, SC8180X_SLAVE_RBCPR_MMCX_CFG, SC8180X_SLAVE_PIM=
EM_CFG, SC8180X_SLAVE_UFS_MEM_1_CFG, SC8180X_SLAVE_RBCPR_MX_CFG, SC8180X_SL=
AVE_IMEM_CFG);
-DEFINE_QNODE(mas_qhm_cnoc_dc_noc, SC8180X_MASTER_CNOC_DC_NOC, 1, 4, SC8180=
X_SLAVE_LLCC_CFG, SC8180X_SLAVE_GEM_NOC_CFG);
-DEFINE_QNODE(mas_acm_apps, SC8180X_MASTER_AMPSS_M0, 4, 64, SC8180X_SLAVE_E=
CC, SC8180X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_acm_gpu_tcu, SC8180X_MASTER_GPU_TCU, 1, 8, SC8180X_SLAVE_=
LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_acm_sys_tcu, SC8180X_MASTER_SYS_TCU, 1, 8, SC8180X_SLAVE_=
LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_qhm_gemnoc_cfg, SC8180X_MASTER_GEM_NOC_CFG, 1, 4, SC8180X=
_SLAVE_SERVICE_GEM_NOC_1, SC8180X_SLAVE_SERVICE_GEM_NOC, SC8180X_SLAVE_MSS_=
PROC_MS_MPU_CFG);
-DEFINE_QNODE(mas_qnm_cmpnoc, SC8180X_MASTER_COMPUTE_NOC, 2, 32, SC8180X_SL=
AVE_ECC, SC8180X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_qnm_gpu, SC8180X_MASTER_GRAPHICS_3D, 4, 32, SC8180X_SLAVE=
_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_qnm_mnoc_hf, SC8180X_MASTER_MNOC_HF_MEM_NOC, 2, 32, SC818=
0X_SLAVE_LLCC);
-DEFINE_QNODE(mas_qnm_mnoc_sf, SC8180X_MASTER_MNOC_SF_MEM_NOC, 1, 32, SC818=
0X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_qnm_pcie, SC8180X_MASTER_GEM_NOC_PCIE_SNOC, 1, 32, SC8180=
X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(mas_qnm_snoc_gc, SC8180X_MASTER_SNOC_GC_MEM_NOC, 1, 8, SC8180=
X_SLAVE_LLCC);
-DEFINE_QNODE(mas_qnm_snoc_sf, SC8180X_MASTER_SNOC_SF_MEM_NOC, 1, 32, SC818=
0X_SLAVE_LLCC);
-DEFINE_QNODE(mas_qxm_ecc, SC8180X_MASTER_ECC, 2, 32, SC8180X_SLAVE_LLCC);
-DEFINE_QNODE(mas_ipa_core_master, SC8180X_MASTER_IPA_CORE, 1, 8, SC8180X_S=
LAVE_IPA_CORE);
-DEFINE_QNODE(mas_llcc_mc, SC8180X_MASTER_LLCC, 8, 4, SC8180X_SLAVE_EBI_CH0=
);
-DEFINE_QNODE(mas_qhm_mnoc_cfg, SC8180X_MASTER_CNOC_MNOC_CFG, 1, 4, SC8180X=
_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(mas_qxm_camnoc_hf0, SC8180X_MASTER_CAMNOC_HF0, 1, 32, SC8180X=
_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_camnoc_hf1, SC8180X_MASTER_CAMNOC_HF1, 1, 32, SC8180X=
_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_camnoc_sf, SC8180X_MASTER_CAMNOC_SF, 1, 32, SC8180X_S=
LAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_mdp0, SC8180X_MASTER_MDP_PORT0, 1, 32, SC8180X_SLAVE_=
MNOC_HF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_mdp1, SC8180X_MASTER_MDP_PORT1, 1, 32, SC8180X_SLAVE_=
MNOC_HF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_rot, SC8180X_MASTER_ROTATOR, 1, 32, SC8180X_SLAVE_MNO=
C_SF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_venus0, SC8180X_MASTER_VIDEO_P0, 1, 32, SC8180X_SLAVE=
_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_venus1, SC8180X_MASTER_VIDEO_P1, 1, 32, SC8180X_SLAVE=
_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(mas_qxm_venus_arm9, SC8180X_MASTER_VIDEO_PROC, 1, 8, SC8180X_=
SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(mas_qhm_snoc_cfg, SC8180X_MASTER_SNOC_CFG, 1, 4, SC8180X_SLAV=
E_SERVICE_SNOC);
-DEFINE_QNODE(mas_qnm_aggre1_noc, SC8180X_A1NOC_SNOC_MAS, 1, 32, SC8180X_SL=
AVE_SNOC_GEM_NOC_SF, SC8180X_SLAVE_PIMEM, SC8180X_SLAVE_OCIMEM, SC8180X_SLA=
VE_APPSS, SC8180X_SNOC_CNOC_SLV, SC8180X_SLAVE_QDSS_STM);
-DEFINE_QNODE(mas_qnm_aggre2_noc, SC8180X_A2NOC_SNOC_MAS, 1, 16, SC8180X_SL=
AVE_SNOC_GEM_NOC_SF, SC8180X_SLAVE_PIMEM, SC8180X_SLAVE_PCIE_3, SC8180X_SLA=
VE_OCIMEM, SC8180X_SLAVE_APPSS, SC8180X_SLAVE_PCIE_2, SC8180X_SNOC_CNOC_SLV=
, SC8180X_SLAVE_PCIE_0, SC8180X_SLAVE_PCIE_1, SC8180X_SLAVE_TCU, SC8180X_SL=
AVE_QDSS_STM);
-DEFINE_QNODE(mas_qnm_gemnoc, SC8180X_MASTER_GEM_NOC_SNOC, 1, 8, SC8180X_SL=
AVE_PIMEM, SC8180X_SLAVE_OCIMEM, SC8180X_SLAVE_APPSS, SC8180X_SNOC_CNOC_SLV=
, SC8180X_SLAVE_TCU, SC8180X_SLAVE_QDSS_STM);
-DEFINE_QNODE(mas_qxm_pimem, SC8180X_MASTER_PIMEM, 1, 8, SC8180X_SLAVE_SNOC=
_GEM_NOC_GC, SC8180X_SLAVE_OCIMEM);
-DEFINE_QNODE(mas_xm_gic, SC8180X_MASTER_GIC, 1, 8, SC8180X_SLAVE_SNOC_GEM_=
NOC_GC, SC8180X_SLAVE_OCIMEM);
-DEFINE_QNODE(mas_qup_core_0, SC8180X_MASTER_QUP_CORE_0, 1, 4, SC8180X_SLAV=
E_QUP_CORE_0);
-DEFINE_QNODE(mas_qup_core_1, SC8180X_MASTER_QUP_CORE_1, 1, 4, SC8180X_SLAV=
E_QUP_CORE_1);
-DEFINE_QNODE(mas_qup_core_2, SC8180X_MASTER_QUP_CORE_2, 1, 4, SC8180X_SLAV=
E_QUP_CORE_2);
-DEFINE_QNODE(slv_qns_a1noc_snoc, SC8180X_A1NOC_SNOC_SLV, 1, 32, SC8180X_A1=
NOC_SNOC_MAS);
-DEFINE_QNODE(slv_srvc_aggre1_noc, SC8180X_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(slv_qns_a2noc_snoc, SC8180X_A2NOC_SNOC_SLV, 1, 16, SC8180X_A2=
NOC_SNOC_MAS);
-DEFINE_QNODE(slv_qns_pcie_mem_noc, SC8180X_SLAVE_ANOC_PCIE_GEM_NOC, 1, 32,=
 SC8180X_MASTER_GEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(slv_srvc_aggre2_noc, SC8180X_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(slv_qns_camnoc_uncomp, SC8180X_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(slv_qns_cdsp_mem_noc, SC8180X_SLAVE_CDSP_MEM_NOC, 2, 32, SC81=
80X_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(slv_qhs_a1_noc_cfg, SC8180X_SLAVE_A1NOC_CFG, 1, 4, SC8180X_MA=
STER_A1NOC_CFG);
-DEFINE_QNODE(slv_qhs_a2_noc_cfg, SC8180X_SLAVE_A2NOC_CFG, 1, 4, SC8180X_MA=
STER_A2NOC_CFG);
-DEFINE_QNODE(slv_qhs_ahb2phy_refgen_center, SC8180X_SLAVE_AHB2PHY_CENTER, =
1, 4);
-DEFINE_QNODE(slv_qhs_ahb2phy_refgen_east, SC8180X_SLAVE_AHB2PHY_EAST, 1, 4=
);
-DEFINE_QNODE(slv_qhs_ahb2phy_refgen_west, SC8180X_SLAVE_AHB2PHY_WEST, 1, 4=
);
-DEFINE_QNODE(slv_qhs_ahb2phy_south, SC8180X_SLAVE_AHB2PHY_SOUTH, 1, 4);
-DEFINE_QNODE(slv_qhs_aop, SC8180X_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(slv_qhs_aoss, SC8180X_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(slv_qhs_camera_cfg, SC8180X_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_clk_ctl, SC8180X_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(slv_qhs_compute_dsp, SC8180X_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_cpr_cx, SC8180X_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_cpr_mmcx, SC8180X_SLAVE_RBCPR_MMCX_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_cpr_mx, SC8180X_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_crypto0_cfg, SC8180X_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_ddrss_cfg, SC8180X_SLAVE_CNOC_DDRSS, 1, 4, SC8180X_MA=
STER_CNOC_DC_NOC);
-DEFINE_QNODE(slv_qhs_display_cfg, SC8180X_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_emac_cfg, SC8180X_SLAVE_EMAC_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_glm, SC8180X_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(slv_qhs_gpuss_cfg, SC8180X_SLAVE_GRAPHICS_3D_CFG, 1, 8);
-DEFINE_QNODE(slv_qhs_imem_cfg, SC8180X_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_ipa, SC8180X_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_mnoc_cfg, SC8180X_SLAVE_CNOC_MNOC_CFG, 1, 4, SC8180X_=
MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(slv_qhs_npu_cfg, SC8180X_SLAVE_NPU_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_pcie0_cfg, SC8180X_SLAVE_PCIE_0_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_pcie1_cfg, SC8180X_SLAVE_PCIE_1_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_pcie2_cfg, SC8180X_SLAVE_PCIE_2_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_pcie3_cfg, SC8180X_SLAVE_PCIE_3_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_pdm, SC8180X_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(slv_qhs_pimem_cfg, SC8180X_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_prng, SC8180X_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(slv_qhs_qdss_cfg, SC8180X_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_qspi_0, SC8180X_SLAVE_QSPI_0, 1, 4);
-DEFINE_QNODE(slv_qhs_qspi_1, SC8180X_SLAVE_QSPI_1, 1, 4);
-DEFINE_QNODE(slv_qhs_qupv3_east0, SC8180X_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(slv_qhs_qupv3_east1, SC8180X_SLAVE_QUP_2, 1, 4);
-DEFINE_QNODE(slv_qhs_qupv3_west, SC8180X_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(slv_qhs_sdc2, SC8180X_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(slv_qhs_sdc4, SC8180X_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(slv_qhs_security, SC8180X_SLAVE_SECURITY, 1, 4);
-DEFINE_QNODE(slv_qhs_snoc_cfg, SC8180X_SLAVE_SNOC_CFG, 1, 4, SC8180X_MASTE=
R_SNOC_CFG);
-DEFINE_QNODE(slv_qhs_spss_cfg, SC8180X_SLAVE_SPSS_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_tcsr, SC8180X_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(slv_qhs_tlmm_east, SC8180X_SLAVE_TLMM_EAST, 1, 4);
-DEFINE_QNODE(slv_qhs_tlmm_south, SC8180X_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(slv_qhs_tlmm_west, SC8180X_SLAVE_TLMM_WEST, 1, 4);
-DEFINE_QNODE(slv_qhs_tsif, SC8180X_SLAVE_TSIF, 1, 4);
-DEFINE_QNODE(slv_qhs_ufs_card_cfg, SC8180X_SLAVE_UFS_CARD_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_ufs_mem0_cfg, SC8180X_SLAVE_UFS_MEM_0_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_ufs_mem1_cfg, SC8180X_SLAVE_UFS_MEM_1_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_usb3_0, SC8180X_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(slv_qhs_usb3_1, SC8180X_SLAVE_USB3_1, 1, 4);
-DEFINE_QNODE(slv_qhs_usb3_2, SC8180X_SLAVE_USB3_2, 1, 4);
-DEFINE_QNODE(slv_qhs_venus_cfg, SC8180X_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_vsense_ctrl_cfg, SC8180X_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(slv_srvc_cnoc, SC8180X_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(slv_qhs_gemnoc, SC8180X_SLAVE_GEM_NOC_CFG, 1, 4, SC8180X_MAST=
ER_GEM_NOC_CFG);
-DEFINE_QNODE(slv_qhs_llcc, SC8180X_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(slv_qhs_mdsp_ms_mpu_cfg, SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG, 1=
, 4);
-DEFINE_QNODE(slv_qns_ecc, SC8180X_SLAVE_ECC, 1, 32);
-DEFINE_QNODE(slv_qns_gem_noc_snoc, SC8180X_SLAVE_GEM_NOC_SNOC, 1, 8, SC818=
0X_MASTER_GEM_NOC_SNOC);
-DEFINE_QNODE(slv_qns_llcc, SC8180X_SLAVE_LLCC, 8, 16, SC8180X_MASTER_LLCC);
-DEFINE_QNODE(slv_srvc_gemnoc, SC8180X_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(slv_srvc_gemnoc1, SC8180X_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
-DEFINE_QNODE(slv_ipa_core_slave, SC8180X_SLAVE_IPA_CORE, 1, 8);
-DEFINE_QNODE(slv_ebi, SC8180X_SLAVE_EBI_CH0, 8, 4);
-DEFINE_QNODE(slv_qns2_mem_noc, SC8180X_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SC818=
0X_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(slv_qns_mem_noc_hf, SC8180X_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SC8=
180X_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(slv_srvc_mnoc, SC8180X_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(slv_qhs_apss, SC8180X_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(slv_qns_cnoc, SC8180X_SNOC_CNOC_SLV, 1, 8, SC8180X_SNOC_CNOC_=
MAS);
-DEFINE_QNODE(slv_qns_gemnoc_gc, SC8180X_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SC818=
0X_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(slv_qns_gemnoc_sf, SC8180X_SLAVE_SNOC_GEM_NOC_SF, 1, 32, SC81=
80X_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(slv_qxs_imem, SC8180X_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(slv_qxs_pimem, SC8180X_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(slv_srvc_snoc, SC8180X_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(slv_xs_pcie_0, SC8180X_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(slv_xs_pcie_1, SC8180X_SLAVE_PCIE_1, 1, 8);
-DEFINE_QNODE(slv_xs_pcie_2, SC8180X_SLAVE_PCIE_2, 1, 8);
-DEFINE_QNODE(slv_xs_pcie_3, SC8180X_SLAVE_PCIE_3, 1, 8);
-DEFINE_QNODE(slv_xs_qdss_stm, SC8180X_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(slv_xs_sys_tcu_cfg, SC8180X_SLAVE_TCU, 1, 8);
-DEFINE_QNODE(slv_qup_core_0, SC8180X_SLAVE_QUP_CORE_0, 1, 4);
-DEFINE_QNODE(slv_qup_core_1, SC8180X_SLAVE_QUP_CORE_1, 1, 4);
-DEFINE_QNODE(slv_qup_core_2, SC8180X_SLAVE_QUP_CORE_2, 1, 4);
-
-DEFINE_QBCM(bcm_acv, "ACV", false, &slv_ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &slv_ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &slv_qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", false, &slv_qns_mem_noc_hf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &slv_qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &mas_qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &mas_qnm_snoc, &slv_qhs_a1_noc_cfg, &slv=
_qhs_a2_noc_cfg, &slv_qhs_ahb2phy_refgen_center, &slv_qhs_ahb2phy_refgen_ea=
st, &slv_qhs_ahb2phy_refgen_west, &slv_qhs_ahb2phy_south, &slv_qhs_aop, &sl=
v_qhs_aoss, &slv_qhs_camera_cfg, &slv_qhs_clk_ctl, &slv_qhs_compute_dsp, &s=
lv_qhs_cpr_cx, &slv_qhs_cpr_mmcx, &slv_qhs_cpr_mx, &slv_qhs_crypto0_cfg, &s=
lv_qhs_ddrss_cfg, &slv_qhs_display_cfg, &slv_qhs_emac_cfg, &slv_qhs_glm, &s=
lv_qhs_gpuss_cfg, &slv_qhs_imem_cfg, &slv_qhs_ipa, &slv_qhs_mnoc_cfg, &slv_=
qhs_npu_cfg, &slv_qhs_pcie0_cfg, &slv_qhs_pcie1_cfg, &slv_qhs_pcie2_cfg, &s=
lv_qhs_pcie3_cfg, &slv_qhs_pdm, &slv_qhs_pimem_cfg, &slv_qhs_prng, &slv_qhs=
_qdss_cfg, &slv_qhs_qspi_0, &slv_qhs_qspi_1, &slv_qhs_qupv3_east0, &slv_qhs=
_qupv3_east1, &slv_qhs_qupv3_west, &slv_qhs_sdc2, &slv_qhs_sdc4, &slv_qhs_s=
ecurity, &slv_qhs_snoc_cfg, &slv_qhs_spss_cfg, &slv_qhs_tcsr, &slv_qhs_tlmm=
_east, &slv_qhs_tlmm_south, &slv_qhs_tlmm_west, &slv_qhs_tsif, &slv_qhs_ufs=
_card_cfg, &slv_qhs_ufs_mem0_cfg, &slv_qhs_ufs_mem1_cfg, &slv_qhs_usb3_0, &=
slv_qhs_usb3_1, &slv_qhs_usb3_2, &slv_qhs_venus_cfg, &slv_qhs_vsense_ctrl_c=
fg, &slv_srvc_cnoc);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &mas_qxm_camnoc_hf0_uncomp, &mas_qxm_ca=
mnoc_hf1_uncomp, &mas_qxm_camnoc_sf_uncomp, &mas_qxm_camnoc_hf0, &mas_qxm_c=
amnoc_hf1, &mas_qxm_mdp0, &mas_qxm_mdp1);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &mas_qup_core_0, &mas_qup_core_1, &ma=
s_qup_core_2);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &slv_qns_gem_noc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &mas_qxm_camnoc_sf, &mas_qxm_rot, &mas_=
qxm_venus0, &mas_qxm_venus1, &mas_qxm_venus_arm9, &slv_qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", true, &mas_acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", false, &slv_qns_gemnoc_sf);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &slv_qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", true, &slv_qns_gemnoc_gc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &mas_qnm_npu);
-DEFINE_QBCM(bcm_ip0, "IP0", false, &slv_ipa_core_slave);
-DEFINE_QBCM(bcm_sn3, "SN3", true, &slv_srvc_aggre1_noc, &slv_qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &slv_qxs_pimem);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &slv_xs_pcie_0, &slv_xs_pcie_1, &slv_xs=
_pcie_2, &slv_xs_pcie_3);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &mas_qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &mas_qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn14, "SN14", false, &slv_qns_pcie_mem_noc);
-DEFINE_QBCM(bcm_sn15, "SN15", true, &mas_qnm_gemnoc);
+static struct qcom_icc_node mas_qhm_a1noc_cfg =3D {
+	.name =3D "mas_qhm_a1noc_cfg",
+	.id =3D SC8180X_MASTER_A1NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_SERVICE_A1NOC }
+};
+
+static struct qcom_icc_node mas_xm_ufs_card =3D {
+	.name =3D "mas_xm_ufs_card",
+	.id =3D SC8180X_MASTER_UFS_CARD,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_ufs_g4 =3D {
+	.name =3D "mas_xm_ufs_g4",
+	.id =3D SC8180X_MASTER_UFS_GEN4,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_ufs_mem =3D {
+	.name =3D "mas_xm_ufs_mem",
+	.id =3D SC8180X_MASTER_UFS_MEM,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_usb3_0 =3D {
+	.name =3D "mas_xm_usb3_0",
+	.id =3D SC8180X_MASTER_USB3,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_usb3_1 =3D {
+	.name =3D "mas_xm_usb3_1",
+	.id =3D SC8180X_MASTER_USB3_1,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_usb3_2 =3D {
+	.name =3D "mas_xm_usb3_2",
+	.id =3D SC8180X_MASTER_USB3_2,
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_a2noc_cfg =3D {
+	.name =3D "mas_qhm_a2noc_cfg",
+	.id =3D SC8180X_MASTER_A2NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_SERVICE_A2NOC }
+};
+
+static struct qcom_icc_node mas_qhm_qdss_bam =3D {
+	.name =3D "mas_qhm_qdss_bam",
+	.id =3D SC8180X_MASTER_QDSS_BAM,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_qspi =3D {
+	.name =3D "mas_qhm_qspi",
+	.id =3D SC8180X_MASTER_QSPI_0,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_qspi1 =3D {
+	.name =3D "mas_qhm_qspi1",
+	.id =3D SC8180X_MASTER_QSPI_1,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_qup0 =3D {
+	.name =3D "mas_qhm_qup0",
+	.id =3D SC8180X_MASTER_QUP_0,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_qup1 =3D {
+	.name =3D "mas_qhm_qup1",
+	.id =3D SC8180X_MASTER_QUP_1,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_qup2 =3D {
+	.name =3D "mas_qhm_qup2",
+	.id =3D SC8180X_MASTER_QUP_2,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qhm_sensorss_ahb =3D {
+	.name =3D "mas_qhm_sensorss_ahb",
+	.id =3D SC8180X_MASTER_SENSORS_AHB,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qxm_crypto =3D {
+	.name =3D "mas_qxm_crypto",
+	.id =3D SC8180X_MASTER_CRYPTO_CORE_0,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qxm_ipa =3D {
+	.name =3D "mas_qxm_ipa",
+	.id =3D SC8180X_MASTER_IPA,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_emac =3D {
+	.name =3D "mas_xm_emac",
+	.id =3D SC8180X_MASTER_EMAC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_pcie3_0 =3D {
+	.name =3D "mas_xm_pcie3_0",
+	.id =3D SC8180X_MASTER_PCIE,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+};
+
+static struct qcom_icc_node mas_xm_pcie3_1 =3D {
+	.name =3D "mas_xm_pcie3_1",
+	.id =3D SC8180X_MASTER_PCIE_1,
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+};
+
+static struct qcom_icc_node mas_xm_pcie3_2 =3D {
+	.name =3D "mas_xm_pcie3_2",
+	.id =3D SC8180X_MASTER_PCIE_2,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+};
+
+static struct qcom_icc_node mas_xm_pcie3_3 =3D {
+	.name =3D "mas_xm_pcie3_3",
+	.id =3D SC8180X_MASTER_PCIE_3,
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+};
+
+static struct qcom_icc_node mas_xm_qdss_etr =3D {
+	.name =3D "mas_xm_qdss_etr",
+	.id =3D SC8180X_MASTER_QDSS_ETR,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_sdc2 =3D {
+	.name =3D "mas_xm_sdc2",
+	.id =3D SC8180X_MASTER_SDCC_2,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_xm_sdc4 =3D {
+	.name =3D "mas_xm_sdc4",
+	.id =3D SC8180X_MASTER_SDCC_4,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_SLV }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_hf0_uncomp =3D {
+	.name =3D "mas_qxm_camnoc_hf0_uncomp",
+	.id =3D SC8180X_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_CAMNOC_UNCOMP }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_hf1_uncomp =3D {
+	.name =3D "mas_qxm_camnoc_hf1_uncomp",
+	.id =3D SC8180X_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_CAMNOC_UNCOMP }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_sf_uncomp =3D {
+	.name =3D "mas_qxm_camnoc_sf_uncomp",
+	.id =3D SC8180X_MASTER_CAMNOC_SF_UNCOMP,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_CAMNOC_UNCOMP }
+};
+
+static struct qcom_icc_node mas_qnm_npu =3D {
+	.name =3D "mas_qnm_npu",
+	.id =3D SC8180X_MASTER_NPU,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_CDSP_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qnm_snoc =3D {
+	.name =3D "mas_qnm_snoc",
+	.id =3D SC8180X_SNOC_CNOC_MAS,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 56,
+	.links =3D { SC8180X_SLAVE_TLMM_SOUTH,
+		   SC8180X_SLAVE_CDSP_CFG,
+		   SC8180X_SLAVE_SPSS_CFG,
+		   SC8180X_SLAVE_CAMERA_CFG,
+		   SC8180X_SLAVE_SDCC_4,
+		   SC8180X_SLAVE_AHB2PHY_CENTER,
+		   SC8180X_SLAVE_SDCC_2,
+		   SC8180X_SLAVE_PCIE_2_CFG,
+		   SC8180X_SLAVE_CNOC_MNOC_CFG,
+		   SC8180X_SLAVE_EMAC_CFG,
+		   SC8180X_SLAVE_QSPI_0,
+		   SC8180X_SLAVE_QSPI_1,
+		   SC8180X_SLAVE_TLMM_EAST,
+		   SC8180X_SLAVE_SNOC_CFG,
+		   SC8180X_SLAVE_AHB2PHY_EAST,
+		   SC8180X_SLAVE_GLM,
+		   SC8180X_SLAVE_PDM,
+		   SC8180X_SLAVE_PCIE_1_CFG,
+		   SC8180X_SLAVE_A2NOC_CFG,
+		   SC8180X_SLAVE_QDSS_CFG,
+		   SC8180X_SLAVE_DISPLAY_CFG,
+		   SC8180X_SLAVE_TCSR,
+		   SC8180X_SLAVE_UFS_MEM_0_CFG,
+		   SC8180X_SLAVE_CNOC_DDRSS,
+		   SC8180X_SLAVE_PCIE_0_CFG,
+		   SC8180X_SLAVE_QUP_1,
+		   SC8180X_SLAVE_QUP_2,
+		   SC8180X_SLAVE_NPU_CFG,
+		   SC8180X_SLAVE_CRYPTO_0_CFG,
+		   SC8180X_SLAVE_GRAPHICS_3D_CFG,
+		   SC8180X_SLAVE_VENUS_CFG,
+		   SC8180X_SLAVE_TSIF,
+		   SC8180X_SLAVE_IPA_CFG,
+		   SC8180X_SLAVE_CLK_CTL,
+		   SC8180X_SLAVE_SECURITY,
+		   SC8180X_SLAVE_AOP,
+		   SC8180X_SLAVE_AHB2PHY_WEST,
+		   SC8180X_SLAVE_AHB2PHY_SOUTH,
+		   SC8180X_SLAVE_SERVICE_CNOC,
+		   SC8180X_SLAVE_UFS_CARD_CFG,
+		   SC8180X_SLAVE_USB3_1,
+		   SC8180X_SLAVE_USB3_2,
+		   SC8180X_SLAVE_PCIE_3_CFG,
+		   SC8180X_SLAVE_RBCPR_CX_CFG,
+		   SC8180X_SLAVE_TLMM_WEST,
+		   SC8180X_SLAVE_A1NOC_CFG,
+		   SC8180X_SLAVE_AOSS,
+		   SC8180X_SLAVE_PRNG,
+		   SC8180X_SLAVE_VSENSE_CTRL_CFG,
+		   SC8180X_SLAVE_QUP_0,
+		   SC8180X_SLAVE_USB3,
+		   SC8180X_SLAVE_RBCPR_MMCX_CFG,
+		   SC8180X_SLAVE_PIMEM_CFG,
+		   SC8180X_SLAVE_UFS_MEM_1_CFG,
+		   SC8180X_SLAVE_RBCPR_MX_CFG,
+		   SC8180X_SLAVE_IMEM_CFG }
+};
+
+static struct qcom_icc_node mas_qhm_cnoc_dc_noc =3D {
+	.name =3D "mas_qhm_cnoc_dc_noc",
+	.id =3D SC8180X_MASTER_CNOC_DC_NOC,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC_CFG,
+		   SC8180X_SLAVE_GEM_NOC_CFG }
+};
+
+static struct qcom_icc_node mas_acm_apps =3D {
+	.name =3D "mas_acm_apps",
+	.id =3D SC8180X_MASTER_AMPSS_M0,
+	.channels =3D 4,
+	.buswidth =3D 64,
+	.num_links =3D 3,
+	.links =3D { SC8180X_SLAVE_ECC,
+		   SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_acm_gpu_tcu =3D {
+	.name =3D "mas_acm_gpu_tcu",
+	.id =3D SC8180X_MASTER_GPU_TCU,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_acm_sys_tcu =3D {
+	.name =3D "mas_acm_sys_tcu",
+	.id =3D SC8180X_MASTER_SYS_TCU,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_qhm_gemnoc_cfg =3D {
+	.name =3D "mas_qhm_gemnoc_cfg",
+	.id =3D SC8180X_MASTER_GEM_NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 3,
+	.links =3D { SC8180X_SLAVE_SERVICE_GEM_NOC_1,
+		   SC8180X_SLAVE_SERVICE_GEM_NOC,
+		   SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG }
+};
+
+static struct qcom_icc_node mas_qnm_cmpnoc =3D {
+	.name =3D "mas_qnm_cmpnoc",
+	.id =3D SC8180X_MASTER_COMPUTE_NOC,
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 3,
+	.links =3D { SC8180X_SLAVE_ECC,
+		   SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_qnm_gpu =3D {
+	.name =3D "mas_qnm_gpu",
+	.id =3D SC8180X_MASTER_GRAPHICS_3D,
+	.channels =3D 4,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_qnm_mnoc_hf =3D {
+	.name =3D "mas_qnm_mnoc_hf",
+	.id =3D SC8180X_MASTER_MNOC_HF_MEM_NOC,
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_LLCC }
+};
+
+static struct qcom_icc_node mas_qnm_mnoc_sf =3D {
+	.name =3D "mas_qnm_mnoc_sf",
+	.id =3D SC8180X_MASTER_MNOC_SF_MEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_qnm_pcie =3D {
+	.name =3D "mas_qnm_pcie",
+	.id =3D SC8180X_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_LLCC,
+		   SC8180X_SLAVE_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node mas_qnm_snoc_gc =3D {
+	.name =3D "mas_qnm_snoc_gc",
+	.id =3D SC8180X_MASTER_SNOC_GC_MEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_LLCC }
+};
+
+static struct qcom_icc_node mas_qnm_snoc_sf =3D {
+	.name =3D "mas_qnm_snoc_sf",
+	.id =3D SC8180X_MASTER_SNOC_SF_MEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_LLCC }
+};
+
+static struct qcom_icc_node mas_qxm_ecc =3D {
+	.name =3D "mas_qxm_ecc",
+	.id =3D SC8180X_MASTER_ECC,
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_LLCC }
+};
+
+static struct qcom_icc_node mas_ipa_core_master =3D {
+	.name =3D "mas_ipa_core_master",
+	.id =3D SC8180X_MASTER_IPA_CORE,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_IPA_CORE }
+};
+
+static struct qcom_icc_node mas_llcc_mc =3D {
+	.name =3D "mas_llcc_mc",
+	.id =3D SC8180X_MASTER_LLCC,
+	.channels =3D 8,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_EBI_CH0 }
+};
+
+static struct qcom_icc_node mas_qhm_mnoc_cfg =3D {
+	.name =3D "mas_qhm_mnoc_cfg",
+	.id =3D SC8180X_MASTER_CNOC_MNOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_SERVICE_MNOC }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_hf0 =3D {
+	.name =3D "mas_qxm_camnoc_hf0",
+	.id =3D SC8180X_MASTER_CAMNOC_HF0,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_hf1 =3D {
+	.name =3D "mas_qxm_camnoc_hf1",
+	.id =3D SC8180X_MASTER_CAMNOC_HF1,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_camnoc_sf =3D {
+	.name =3D "mas_qxm_camnoc_sf",
+	.id =3D SC8180X_MASTER_CAMNOC_SF,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_mdp0 =3D {
+	.name =3D "mas_qxm_mdp0",
+	.id =3D SC8180X_MASTER_MDP_PORT0,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_mdp1 =3D {
+	.name =3D "mas_qxm_mdp1",
+	.id =3D SC8180X_MASTER_MDP_PORT1,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_rot =3D {
+	.name =3D "mas_qxm_rot",
+	.id =3D SC8180X_MASTER_ROTATOR,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_venus0 =3D {
+	.name =3D "mas_qxm_venus0",
+	.id =3D SC8180X_MASTER_VIDEO_P0,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_venus1 =3D {
+	.name =3D "mas_qxm_venus1",
+	.id =3D SC8180X_MASTER_VIDEO_P1,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qxm_venus_arm9 =3D {
+	.name =3D "mas_qxm_venus_arm9",
+	.id =3D SC8180X_MASTER_VIDEO_PROC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node mas_qhm_snoc_cfg =3D {
+	.name =3D "mas_qhm_snoc_cfg",
+	.id =3D SC8180X_MASTER_SNOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_SERVICE_SNOC }
+};
+
+static struct qcom_icc_node mas_qnm_aggre1_noc =3D {
+	.name =3D "mas_qnm_aggre1_noc",
+	.id =3D SC8180X_A1NOC_SNOC_MAS,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 6,
+	.links =3D { SC8180X_SLAVE_SNOC_GEM_NOC_SF,
+		   SC8180X_SLAVE_PIMEM,
+		   SC8180X_SLAVE_OCIMEM,
+		   SC8180X_SLAVE_APPSS,
+		   SC8180X_SNOC_CNOC_SLV,
+		   SC8180X_SLAVE_QDSS_STM }
+};
+
+static struct qcom_icc_node mas_qnm_aggre2_noc =3D {
+	.name =3D "mas_qnm_aggre2_noc",
+	.id =3D SC8180X_A2NOC_SNOC_MAS,
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 11,
+	.links =3D { SC8180X_SLAVE_SNOC_GEM_NOC_SF,
+		   SC8180X_SLAVE_PIMEM,
+		   SC8180X_SLAVE_PCIE_3,
+		   SC8180X_SLAVE_OCIMEM,
+		   SC8180X_SLAVE_APPSS,
+		   SC8180X_SLAVE_PCIE_2,
+		   SC8180X_SNOC_CNOC_SLV,
+		   SC8180X_SLAVE_PCIE_0,
+		   SC8180X_SLAVE_PCIE_1,
+		   SC8180X_SLAVE_TCU,
+		   SC8180X_SLAVE_QDSS_STM }
+};
+
+static struct qcom_icc_node mas_qnm_gemnoc =3D {
+	.name =3D "mas_qnm_gemnoc",
+	.id =3D SC8180X_MASTER_GEM_NOC_SNOC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 6,
+	.links =3D { SC8180X_SLAVE_PIMEM,
+		   SC8180X_SLAVE_OCIMEM,
+		   SC8180X_SLAVE_APPSS,
+		   SC8180X_SNOC_CNOC_SLV,
+		   SC8180X_SLAVE_TCU,
+		   SC8180X_SLAVE_QDSS_STM }
+};
+
+static struct qcom_icc_node mas_qxm_pimem =3D {
+	.name =3D "mas_qxm_pimem",
+	.id =3D SC8180X_MASTER_PIMEM,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_SNOC_GEM_NOC_GC,
+		   SC8180X_SLAVE_OCIMEM }
+};
+
+static struct qcom_icc_node mas_xm_gic =3D {
+	.name =3D "mas_xm_gic",
+	.id =3D SC8180X_MASTER_GIC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.links =3D { SC8180X_SLAVE_SNOC_GEM_NOC_GC,
+		   SC8180X_SLAVE_OCIMEM }
+};
+
+static struct qcom_icc_node mas_qup_core_0 =3D {
+	.name =3D "mas_qup_core_0",
+	.id =3D SC8180X_MASTER_QUP_CORE_0,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_QUP_CORE_0 }
+};
+
+static struct qcom_icc_node mas_qup_core_1 =3D {
+	.name =3D "mas_qup_core_1",
+	.id =3D SC8180X_MASTER_QUP_CORE_1,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_QUP_CORE_1 }
+};
+
+static struct qcom_icc_node mas_qup_core_2 =3D {
+	.name =3D "mas_qup_core_2",
+	.id =3D SC8180X_MASTER_QUP_CORE_2,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SLAVE_QUP_CORE_2 }
+};
+
+static struct qcom_icc_node slv_qns_a1noc_snoc =3D {
+	.name =3D "slv_qns_a1noc_snoc",
+	.id =3D SC8180X_A1NOC_SNOC_SLV,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A1NOC_SNOC_MAS }
+};
+
+static struct qcom_icc_node slv_srvc_aggre1_noc =3D {
+	.name =3D "slv_srvc_aggre1_noc",
+	.id =3D SC8180X_SLAVE_SERVICE_A1NOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qns_a2noc_snoc =3D {
+	.name =3D "slv_qns_a2noc_snoc",
+	.id =3D SC8180X_A2NOC_SNOC_SLV,
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.links =3D { SC8180X_A2NOC_SNOC_MAS }
+};
+
+static struct qcom_icc_node slv_qns_pcie_mem_noc =3D {
+	.name =3D "slv_qns_pcie_mem_noc",
+	.id =3D SC8180X_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_GEM_NOC_PCIE_SNOC }
+};
+
+static struct qcom_icc_node slv_srvc_aggre2_noc =3D {
+	.name =3D "slv_srvc_aggre2_noc",
+	.id =3D SC8180X_SLAVE_SERVICE_A2NOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qns_camnoc_uncomp =3D {
+	.name =3D "slv_qns_camnoc_uncomp",
+	.id =3D SC8180X_SLAVE_CAMNOC_UNCOMP,
+	.channels =3D 1,
+	.buswidth =3D 32
+};
+
+static struct qcom_icc_node slv_qns_cdsp_mem_noc =3D {
+	.name =3D "slv_qns_cdsp_mem_noc",
+	.id =3D SC8180X_SLAVE_CDSP_MEM_NOC,
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_COMPUTE_NOC }
+};
+
+static struct qcom_icc_node slv_qhs_a1_noc_cfg =3D {
+	.name =3D "slv_qhs_a1_noc_cfg",
+	.id =3D SC8180X_SLAVE_A1NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_A1NOC_CFG }
+};
+
+static struct qcom_icc_node slv_qhs_a2_noc_cfg =3D {
+	.name =3D "slv_qhs_a2_noc_cfg",
+	.id =3D SC8180X_SLAVE_A2NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_A2NOC_CFG }
+};
+
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_center =3D {
+	.name =3D "slv_qhs_ahb2phy_refgen_center",
+	.id =3D SC8180X_SLAVE_AHB2PHY_CENTER,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_east =3D {
+	.name =3D "slv_qhs_ahb2phy_refgen_east",
+	.id =3D SC8180X_SLAVE_AHB2PHY_EAST,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_west =3D {
+	.name =3D "slv_qhs_ahb2phy_refgen_west",
+	.id =3D SC8180X_SLAVE_AHB2PHY_WEST,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ahb2phy_south =3D {
+	.name =3D "slv_qhs_ahb2phy_south",
+	.id =3D SC8180X_SLAVE_AHB2PHY_SOUTH,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_aop =3D {
+	.name =3D "slv_qhs_aop",
+	.id =3D SC8180X_SLAVE_AOP,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_aoss =3D {
+	.name =3D "slv_qhs_aoss",
+	.id =3D SC8180X_SLAVE_AOSS,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_camera_cfg =3D {
+	.name =3D "slv_qhs_camera_cfg",
+	.id =3D SC8180X_SLAVE_CAMERA_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_clk_ctl =3D {
+	.name =3D "slv_qhs_clk_ctl",
+	.id =3D SC8180X_SLAVE_CLK_CTL,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_compute_dsp =3D {
+	.name =3D "slv_qhs_compute_dsp",
+	.id =3D SC8180X_SLAVE_CDSP_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_cpr_cx =3D {
+	.name =3D "slv_qhs_cpr_cx",
+	.id =3D SC8180X_SLAVE_RBCPR_CX_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_cpr_mmcx =3D {
+	.name =3D "slv_qhs_cpr_mmcx",
+	.id =3D SC8180X_SLAVE_RBCPR_MMCX_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_cpr_mx =3D {
+	.name =3D "slv_qhs_cpr_mx",
+	.id =3D SC8180X_SLAVE_RBCPR_MX_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_crypto0_cfg =3D {
+	.name =3D "slv_qhs_crypto0_cfg",
+	.id =3D SC8180X_SLAVE_CRYPTO_0_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ddrss_cfg =3D {
+	.name =3D "slv_qhs_ddrss_cfg",
+	.id =3D SC8180X_SLAVE_CNOC_DDRSS,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_CNOC_DC_NOC }
+};
+
+static struct qcom_icc_node slv_qhs_display_cfg =3D {
+	.name =3D "slv_qhs_display_cfg",
+	.id =3D SC8180X_SLAVE_DISPLAY_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_emac_cfg =3D {
+	.name =3D "slv_qhs_emac_cfg",
+	.id =3D SC8180X_SLAVE_EMAC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_glm =3D {
+	.name =3D "slv_qhs_glm",
+	.id =3D SC8180X_SLAVE_GLM,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_gpuss_cfg =3D {
+	.name =3D "slv_qhs_gpuss_cfg",
+	.id =3D SC8180X_SLAVE_GRAPHICS_3D_CFG,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_qhs_imem_cfg =3D {
+	.name =3D "slv_qhs_imem_cfg",
+	.id =3D SC8180X_SLAVE_IMEM_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ipa =3D {
+	.name =3D "slv_qhs_ipa",
+	.id =3D SC8180X_SLAVE_IPA_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_mnoc_cfg =3D {
+	.name =3D "slv_qhs_mnoc_cfg",
+	.id =3D SC8180X_SLAVE_CNOC_MNOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_CNOC_MNOC_CFG }
+};
+
+static struct qcom_icc_node slv_qhs_npu_cfg =3D {
+	.name =3D "slv_qhs_npu_cfg",
+	.id =3D SC8180X_SLAVE_NPU_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pcie0_cfg =3D {
+	.name =3D "slv_qhs_pcie0_cfg",
+	.id =3D SC8180X_SLAVE_PCIE_0_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pcie1_cfg =3D {
+	.name =3D "slv_qhs_pcie1_cfg",
+	.id =3D SC8180X_SLAVE_PCIE_1_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pcie2_cfg =3D {
+	.name =3D "slv_qhs_pcie2_cfg",
+	.id =3D SC8180X_SLAVE_PCIE_2_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pcie3_cfg =3D {
+	.name =3D "slv_qhs_pcie3_cfg",
+	.id =3D SC8180X_SLAVE_PCIE_3_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pdm =3D {
+	.name =3D "slv_qhs_pdm",
+	.id =3D SC8180X_SLAVE_PDM,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_pimem_cfg =3D {
+	.name =3D "slv_qhs_pimem_cfg",
+	.id =3D SC8180X_SLAVE_PIMEM_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_prng =3D {
+	.name =3D "slv_qhs_prng",
+	.id =3D SC8180X_SLAVE_PRNG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qdss_cfg =3D {
+	.name =3D "slv_qhs_qdss_cfg",
+	.id =3D SC8180X_SLAVE_QDSS_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qspi_0 =3D {
+	.name =3D "slv_qhs_qspi_0",
+	.id =3D SC8180X_SLAVE_QSPI_0,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qspi_1 =3D {
+	.name =3D "slv_qhs_qspi_1",
+	.id =3D SC8180X_SLAVE_QSPI_1,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qupv3_east0 =3D {
+	.name =3D "slv_qhs_qupv3_east0",
+	.id =3D SC8180X_SLAVE_QUP_1,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qupv3_east1 =3D {
+	.name =3D "slv_qhs_qupv3_east1",
+	.id =3D SC8180X_SLAVE_QUP_2,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_qupv3_west =3D {
+	.name =3D "slv_qhs_qupv3_west",
+	.id =3D SC8180X_SLAVE_QUP_0,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_sdc2 =3D {
+	.name =3D "slv_qhs_sdc2",
+	.id =3D SC8180X_SLAVE_SDCC_2,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_sdc4 =3D {
+	.name =3D "slv_qhs_sdc4",
+	.id =3D SC8180X_SLAVE_SDCC_4,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_security =3D {
+	.name =3D "slv_qhs_security",
+	.id =3D SC8180X_SLAVE_SECURITY,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_snoc_cfg =3D {
+	.name =3D "slv_qhs_snoc_cfg",
+	.id =3D SC8180X_SLAVE_SNOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_SNOC_CFG }
+};
+
+static struct qcom_icc_node slv_qhs_spss_cfg =3D {
+	.name =3D "slv_qhs_spss_cfg",
+	.id =3D SC8180X_SLAVE_SPSS_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_tcsr =3D {
+	.name =3D "slv_qhs_tcsr",
+	.id =3D SC8180X_SLAVE_TCSR,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_tlmm_east =3D {
+	.name =3D "slv_qhs_tlmm_east",
+	.id =3D SC8180X_SLAVE_TLMM_EAST,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_tlmm_south =3D {
+	.name =3D "slv_qhs_tlmm_south",
+	.id =3D SC8180X_SLAVE_TLMM_SOUTH,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_tlmm_west =3D {
+	.name =3D "slv_qhs_tlmm_west",
+	.id =3D SC8180X_SLAVE_TLMM_WEST,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_tsif =3D {
+	.name =3D "slv_qhs_tsif",
+	.id =3D SC8180X_SLAVE_TSIF,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ufs_card_cfg =3D {
+	.name =3D "slv_qhs_ufs_card_cfg",
+	.id =3D SC8180X_SLAVE_UFS_CARD_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ufs_mem0_cfg =3D {
+	.name =3D "slv_qhs_ufs_mem0_cfg",
+	.id =3D SC8180X_SLAVE_UFS_MEM_0_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_ufs_mem1_cfg =3D {
+	.name =3D "slv_qhs_ufs_mem1_cfg",
+	.id =3D SC8180X_SLAVE_UFS_MEM_1_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_usb3_0 =3D {
+	.name =3D "slv_qhs_usb3_0",
+	.id =3D SC8180X_SLAVE_USB3,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_usb3_1 =3D {
+	.name =3D "slv_qhs_usb3_1",
+	.id =3D SC8180X_SLAVE_USB3_1,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_usb3_2 =3D {
+	.name =3D "slv_qhs_usb3_2",
+	.id =3D SC8180X_SLAVE_USB3_2,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_venus_cfg =3D {
+	.name =3D "slv_qhs_venus_cfg",
+	.id =3D SC8180X_SLAVE_VENUS_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_vsense_ctrl_cfg =3D {
+	.name =3D "slv_qhs_vsense_ctrl_cfg",
+	.id =3D SC8180X_SLAVE_VSENSE_CTRL_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_srvc_cnoc =3D {
+	.name =3D "slv_srvc_cnoc",
+	.id =3D SC8180X_SLAVE_SERVICE_CNOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_gemnoc =3D {
+	.name =3D "slv_qhs_gemnoc",
+	.id =3D SC8180X_SLAVE_GEM_NOC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_GEM_NOC_CFG }
+};
+
+static struct qcom_icc_node slv_qhs_llcc =3D {
+	.name =3D "slv_qhs_llcc",
+	.id =3D SC8180X_SLAVE_LLCC_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_mdsp_ms_mpu_cfg =3D {
+	.name =3D "slv_qhs_mdsp_ms_mpu_cfg",
+	.id =3D SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qns_ecc =3D {
+	.name =3D "slv_qns_ecc",
+	.id =3D SC8180X_SLAVE_ECC,
+	.channels =3D 1,
+	.buswidth =3D 32
+};
+
+static struct qcom_icc_node slv_qns_gem_noc_snoc =3D {
+	.name =3D "slv_qns_gem_noc_snoc",
+	.id =3D SC8180X_SLAVE_GEM_NOC_SNOC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_GEM_NOC_SNOC }
+};
+
+static struct qcom_icc_node slv_qns_llcc =3D {
+	.name =3D "slv_qns_llcc",
+	.id =3D SC8180X_SLAVE_LLCC,
+	.channels =3D 8,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_LLCC }
+};
+
+static struct qcom_icc_node slv_srvc_gemnoc =3D {
+	.name =3D "slv_srvc_gemnoc",
+	.id =3D SC8180X_SLAVE_SERVICE_GEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_srvc_gemnoc1 =3D {
+	.name =3D "slv_srvc_gemnoc1",
+	.id =3D SC8180X_SLAVE_SERVICE_GEM_NOC_1,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_ipa_core_slave =3D {
+	.name =3D "slv_ipa_core_slave",
+	.id =3D SC8180X_SLAVE_IPA_CORE,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_ebi =3D {
+	.name =3D "slv_ebi",
+	.id =3D SC8180X_SLAVE_EBI_CH0,
+	.channels =3D 8,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qns2_mem_noc =3D {
+	.name =3D "slv_qns2_mem_noc",
+	.id =3D SC8180X_SLAVE_MNOC_SF_MEM_NOC,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_MNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node slv_qns_mem_noc_hf =3D {
+	.name =3D "slv_qns_mem_noc_hf",
+	.id =3D SC8180X_SLAVE_MNOC_HF_MEM_NOC,
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_MNOC_HF_MEM_NOC }
+};
+
+static struct qcom_icc_node slv_srvc_mnoc =3D {
+	.name =3D "slv_srvc_mnoc",
+	.id =3D SC8180X_SLAVE_SERVICE_MNOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qhs_apss =3D {
+	.name =3D "slv_qhs_apss",
+	.id =3D SC8180X_SLAVE_APPSS,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_qns_cnoc =3D {
+	.name =3D "slv_qns_cnoc",
+	.id =3D SC8180X_SNOC_CNOC_SLV,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_SNOC_CNOC_MAS }
+};
+
+static struct qcom_icc_node slv_qns_gemnoc_gc =3D {
+	.name =3D "slv_qns_gemnoc_gc",
+	.id =3D SC8180X_SLAVE_SNOC_GEM_NOC_GC,
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_SNOC_GC_MEM_NOC }
+};
+
+static struct qcom_icc_node slv_qns_gemnoc_sf =3D {
+	.name =3D "slv_qns_gemnoc_sf",
+	.id =3D SC8180X_SLAVE_SNOC_GEM_NOC_SF,
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.links =3D { SC8180X_MASTER_SNOC_SF_MEM_NOC }
+};
+
+static struct qcom_icc_node slv_qxs_imem =3D {
+	.name =3D "slv_qxs_imem",
+	.id =3D SC8180X_SLAVE_OCIMEM,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_qxs_pimem =3D {
+	.name =3D "slv_qxs_pimem",
+	.id =3D SC8180X_SLAVE_PIMEM,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_srvc_snoc =3D {
+	.name =3D "slv_srvc_snoc",
+	.id =3D SC8180X_SLAVE_SERVICE_SNOC,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_xs_pcie_0 =3D {
+	.name =3D "slv_xs_pcie_0",
+	.id =3D SC8180X_SLAVE_PCIE_0,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_xs_pcie_1 =3D {
+	.name =3D "slv_xs_pcie_1",
+	.id =3D SC8180X_SLAVE_PCIE_1,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_xs_pcie_2 =3D {
+	.name =3D "slv_xs_pcie_2",
+	.id =3D SC8180X_SLAVE_PCIE_2,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_xs_pcie_3 =3D {
+	.name =3D "slv_xs_pcie_3",
+	.id =3D SC8180X_SLAVE_PCIE_3,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_xs_qdss_stm =3D {
+	.name =3D "slv_xs_qdss_stm",
+	.id =3D SC8180X_SLAVE_QDSS_STM,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_xs_sys_tcu_cfg =3D {
+	.name =3D "slv_xs_sys_tcu_cfg",
+	.id =3D SC8180X_SLAVE_TCU,
+	.channels =3D 1,
+	.buswidth =3D 8
+};
+
+static struct qcom_icc_node slv_qup_core_0 =3D {
+	.name =3D "slv_qup_core_0",
+	.id =3D SC8180X_SLAVE_QUP_CORE_0,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qup_core_1 =3D {
+	.name =3D "slv_qup_core_1",
+	.id =3D SC8180X_SLAVE_QUP_CORE_1,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_node slv_qup_core_2 =3D {
+	.name =3D "slv_qup_core_2",
+	.id =3D SC8180X_SLAVE_QUP_CORE_2,
+	.channels =3D 1,
+	.buswidth =3D 4
+};
+
+static struct qcom_icc_bcm bcm_acv =3D {
+	.name =3D "ACV",
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_ebi }
+};
+
+static struct qcom_icc_bcm bcm_mc0 =3D {
+	.name =3D "MC0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_ebi }
+};
+
+static struct qcom_icc_bcm bcm_sh0 =3D {
+	.name =3D "SH0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_qns_llcc }
+};
+
+static struct qcom_icc_bcm bcm_mm0 =3D {
+	.name =3D "MM0",
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_qns_mem_noc_hf }
+};
+
+static struct qcom_icc_bcm bcm_co0 =3D {
+	.name =3D "CO0",
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_qns_cdsp_mem_noc }
+};
+
+static struct qcom_icc_bcm bcm_ce0 =3D {
+	.name =3D "CE0",
+	.num_nodes =3D 1,
+	.nodes =3D { &mas_qxm_crypto }
+};
+
+static struct qcom_icc_bcm bcm_cn0 =3D {
+	.name =3D "CN0",
+	.keepalive =3D true,
+	.num_nodes =3D 57,
+	.nodes =3D { &mas_qnm_snoc,
+		   &slv_qhs_a1_noc_cfg,
+		   &slv_qhs_a2_noc_cfg,
+		   &slv_qhs_ahb2phy_refgen_center,
+		   &slv_qhs_ahb2phy_refgen_east,
+		   &slv_qhs_ahb2phy_refgen_west,
+		   &slv_qhs_ahb2phy_south,
+		   &slv_qhs_aop,
+		   &slv_qhs_aoss,
+		   &slv_qhs_camera_cfg,
+		   &slv_qhs_clk_ctl,
+		   &slv_qhs_compute_dsp,
+		   &slv_qhs_cpr_cx,
+		   &slv_qhs_cpr_mmcx,
+		   &slv_qhs_cpr_mx,
+		   &slv_qhs_crypto0_cfg,
+		   &slv_qhs_ddrss_cfg,
+		   &slv_qhs_display_cfg,
+		   &slv_qhs_emac_cfg,
+		   &slv_qhs_glm,
+		   &slv_qhs_gpuss_cfg,
+		   &slv_qhs_imem_cfg,
+		   &slv_qhs_ipa,
+		   &slv_qhs_mnoc_cfg,
+		   &slv_qhs_npu_cfg,
+		   &slv_qhs_pcie0_cfg,
+		   &slv_qhs_pcie1_cfg,
+		   &slv_qhs_pcie2_cfg,
+		   &slv_qhs_pcie3_cfg,
+		   &slv_qhs_pdm,
+		   &slv_qhs_pimem_cfg,
+		   &slv_qhs_prng,
+		   &slv_qhs_qdss_cfg,
+		   &slv_qhs_qspi_0,
+		   &slv_qhs_qspi_1,
+		   &slv_qhs_qupv3_east0,
+		   &slv_qhs_qupv3_east1,
+		   &slv_qhs_qupv3_west,
+		   &slv_qhs_sdc2,
+		   &slv_qhs_sdc4,
+		   &slv_qhs_security,
+		   &slv_qhs_snoc_cfg,
+		   &slv_qhs_spss_cfg,
+		   &slv_qhs_tcsr,
+		   &slv_qhs_tlmm_east,
+		   &slv_qhs_tlmm_south,
+		   &slv_qhs_tlmm_west,
+		   &slv_qhs_tsif,
+		   &slv_qhs_ufs_card_cfg,
+		   &slv_qhs_ufs_mem0_cfg,
+		   &slv_qhs_ufs_mem1_cfg,
+		   &slv_qhs_usb3_0,
+		   &slv_qhs_usb3_1,
+		   &slv_qhs_usb3_2,
+		   &slv_qhs_venus_cfg,
+		   &slv_qhs_vsense_ctrl_cfg,
+		   &slv_srvc_cnoc }
+};
+
+static struct qcom_icc_bcm bcm_mm1 =3D {
+	.name =3D "MM1",
+	.num_nodes =3D 7,
+	.nodes =3D { &mas_qxm_camnoc_hf0_uncomp,
+		   &mas_qxm_camnoc_hf1_uncomp,
+		   &mas_qxm_camnoc_sf_uncomp,
+		   &mas_qxm_camnoc_hf0,
+		   &mas_qxm_camnoc_hf1,
+		   &mas_qxm_mdp0,
+		   &mas_qxm_mdp1 }
+};
+
+static struct qcom_icc_bcm bcm_qup0 =3D {
+	.name =3D "QUP0",
+	.num_nodes =3D 3,
+	.nodes =3D { &mas_qup_core_0,
+		   &mas_qup_core_1,
+		   &mas_qup_core_2 }
+};
+
+static struct qcom_icc_bcm bcm_sh2 =3D {
+	.name =3D "SH2",
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_qns_gem_noc_snoc }
+};
+
+static struct qcom_icc_bcm bcm_mm2 =3D {
+	.name =3D "MM2",
+	.num_nodes =3D 6,
+	.nodes =3D { &mas_qxm_camnoc_sf,
+		   &mas_qxm_rot,
+		   &mas_qxm_venus0,
+		   &mas_qxm_venus1,
+		   &mas_qxm_venus_arm9,
+		   &slv_qns2_mem_noc }
+};
+
+static struct qcom_icc_bcm bcm_sh3 =3D {
+	.name =3D "SH3",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &mas_acm_apps }
+};
+
+static struct qcom_icc_bcm bcm_sn0 =3D {
+	.name =3D "SN0",
+	.nodes =3D { &slv_qns_gemnoc_sf }
+};
+
+static struct qcom_icc_bcm bcm_sn1 =3D {
+	.name =3D "SN1",
+	.nodes =3D { &slv_qxs_imem }
+};
+
+static struct qcom_icc_bcm bcm_sn2 =3D {
+	.name =3D "SN2",
+	.keepalive =3D true,
+	.nodes =3D { &slv_qns_gemnoc_gc }
+};
+
+static struct qcom_icc_bcm bcm_co2 =3D {
+	.name =3D "CO2",
+	.nodes =3D { &mas_qnm_npu }
+};
+
+static struct qcom_icc_bcm bcm_ip0 =3D {
+	.name =3D "IP0",
+	.nodes =3D { &slv_ipa_core_slave }
+};
+
+static struct qcom_icc_bcm bcm_sn3 =3D {
+	.name =3D "SN3",
+	.keepalive =3D true,
+	.nodes =3D { &slv_srvc_aggre1_noc,
+		  &slv_qns_cnoc }
+};
+
+static struct qcom_icc_bcm bcm_sn4 =3D {
+	.name =3D "SN4",
+	.nodes =3D { &slv_qxs_pimem }
+};
+
+static struct qcom_icc_bcm bcm_sn8 =3D {
+	.name =3D "SN8",
+	.num_nodes =3D 4,
+	.nodes =3D { &slv_xs_pcie_0,
+		   &slv_xs_pcie_1,
+		   &slv_xs_pcie_2,
+		   &slv_xs_pcie_3 }
+};
+
+static struct qcom_icc_bcm bcm_sn9 =3D {
+	.name =3D "SN9",
+	.num_nodes =3D 1,
+	.nodes =3D { &mas_qnm_aggre1_noc }
+};
+
+static struct qcom_icc_bcm bcm_sn11 =3D {
+	.name =3D "SN11",
+	.num_nodes =3D 1,
+	.nodes =3D { &mas_qnm_aggre2_noc }
+};
+
+static struct qcom_icc_bcm bcm_sn14 =3D {
+	.name =3D "SN14",
+	.num_nodes =3D 1,
+	.nodes =3D { &slv_qns_pcie_mem_noc }
+};
+
+static struct qcom_icc_bcm bcm_sn15 =3D {
+	.name =3D "SN15",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &mas_qnm_gemnoc }
+};
=20
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
 	&bcm_sn3,
--=20
2.35.1

