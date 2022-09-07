Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFF5AFC94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIGGiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIGGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:37:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C894857E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:37:17 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220907063659epoutp0189dd1fd94167e87cd6efe7188304adaa~SgJv7beY70547005470epoutp01H
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220907063659epoutp0189dd1fd94167e87cd6efe7188304adaa~SgJv7beY70547005470epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532619;
        bh=QrwgRF8Qrx0EDQphUA8YIVN+b01WVyCCN3WTPSBOk6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEhqSpMe8NHL/r8+4HN+RcVVxuRIaaM67KhvLbXwRkT3BNYQb/TvmfF6lW0jd01Oi
         xjqm4G2cg6HzvMNQIK0HQ74sNF6BL7x1MyDNA0/kkYTAGVMcq5zolcRhHZxSSIMbE5
         Mv3bdl/bTpDylHiYaXhxm2FrNQx8Nfg0FZpKe54c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220907063658epcas5p42e7cd286c01aeaf23b47b91487938cdc~SgJuX024W3173331733epcas5p4u;
        Wed,  7 Sep 2022 06:36:58 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MMsx268jVz4x9Pt; Wed,  7 Sep
        2022 06:36:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.D0.54060.60C38136; Wed,  7 Sep 2022 15:36:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063348epcas5p15d482a6f03f21489aedde74f93c64ae4~SgG95A6Ts1824518245epcas5p1Z;
        Wed,  7 Sep 2022 06:33:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063348epsmtrp190de2606b8f9671f6d3f4d7303682145~SgG93sh0K0507305073epsmtrp1E;
        Wed,  7 Sep 2022 06:33:48 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-a4-63183c06c377
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.DC.14392.C4B38136; Wed,  7 Sep 2022 15:33:48 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063344epsmtip1929229c3dfbd42a64dc308759b19a404~SgG6Vcsse2625726257epsmtip1z;
        Wed,  7 Sep 2022 06:33:44 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2 09/15] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Wed,  7 Sep 2022 12:17:09 +0530
Message-Id: <20220907064715.55778-10-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTeVBTVxTG5+blvRdgwryJtL3FCvShreyJQLwotM5o6WuxHabMtLQzlcbk
        FRBIQhKqbdksBVpGcCN1QCAWsDjIIpGwFTDQuAxVpwjIaI0iS1kUEDCojV0SAu1/v3POd865
        8917eZhghHDnJco1rEouSaYJZ27LLz6+AUQ4lAoX+gLQRFsJjkYqWghU9XSSg+5VLXFR73kD
        iZoHT2Ko5rIRRzrTdRy19oxyUdOUrdpfYuaiSV0DQNOldwmkH7uJo/szH6GBjjICHTpnwFG9
        yUyi08P9HPST/jkHVRoekyi3y0Qic2cLQN/mmTg7IFNXUQeYNnM1YIarFzGmvdRMMlWd0xxG
        X/s9wdy52Ukw56uzmNyLf3KZouZawPz9TTnJFJiGCWZJ78H0WZbIaNdPksITWImMVXmxcqlC
        liiPj6CjYuJ2xoWKhaIAURjaSnvJJSlsBL1rd3RAZGKyzQba6wtJcpotFS1Rq+mgN8JVijQN
        65WgUGsiaFYpS1aGKAPVkhR1mjw+UM5qtomEwi2hNuFnSQn92iOk0kgd0JuO4dlghF8AnHiQ
        CoF/VY9zC4AzT0D9DKD1bAXuCBYBPKm1chzBMoDdlVP4WkteewPmKHQBeKPlDGkvCKgcDmx+
        EmZngvKHy/O/EnZ2ow4COPadxt6AUTlcaL5qXWlYR8XAW/88xOzMpTbB1u45YGc+tQ2O/D5G
        OLZ5wrPnjCsaJ1u+v/jKyvkgle8EB4tybIN4tmAXvD5xwKFfB2cuN5MOdofTh/NWOR7eW8oB
        DlbC8uxmjoPfhMbBMq59DEb5wMaOIEd6A9T2NaxIMMoVFlrHV+V82FaxxjSsvHpldTyEQ7OG
        VYMYuDz6kHQYVAjgb7nF5BHgUfr/ilMA1IKXWaU6JZ5VhyqD5ez+/25NqkjRg5Wn7hvVBkZH
        HgX2Ag4P9ALIw2g3vqzNTSrgyyRffsWqFHGqtGRW3QtCbf4dxdxfkCpsf0WuiROFhAlDxGJx
        SFiwWES/xC/2A1IBFS/RsEksq2RVa30cnpN7Nqc93byZ+/RZmf8HlmzhNaHLAn5i/ef7H+cc
        xBbYzNvbvV/8+EJXRNZRqRUvOHPn7a2H3ztkFfMHjGDxIjOXGr2vMXxmPPi4Nvlr3Y6qiQ/T
        R0XbhzZlusTGOm+5XXqKAHs2L+wiVaOe3htTO++aJyvfz3qk6I7VavH1+X1+GxcF003X5D2t
        sownp12U0Zf2zhsMPuV7s/YEZWfEzIWPxw75DfhHRT6riHkVznulH9upHC7KS3prt+Bdy63M
        Joux435GZuM+b/zEhQHnpeJPTa46z+P1+cJ3dBbNK38oX7uxwZWcqrLkL88+eD3ywSxd2Fh4
        6Ycf63sa63Q1qaklRO9zj+EamqtOkIh8MZVa8i8nndPvcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK6PtUSywdKtyhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJVxceoE9oIDAhWb
        jkxibWB8wNvFyMkhIWAi0bZzHXMXIxeHkMBuRol9d56zQyQkJFb+nsQIYQtLrPwHEgcpamSS
        uLepDSzBJqAj8e39aTaQhIhAK6PE9ZWdTCAOs8BsFokfkw6wglQJCwRKHN+7AayDRUBVYvu+
        d2A2r4CVxIPbj9kgVshLrN5wgBnE5gSKX5xyAqxXSMBS4vGMbewTGPkWMDKsYpRMLSjOTc8t
        NiwwzEst1ytOzC0uzUvXS87P3cQIjj0tzR2M21d90DvEyMTBeIhRgoNZSYQ3ZYdIshBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MU9eECM7cIdA2U5l/
        gUjMry9eS52SfJRepPdvWhIkIbNcYcGxyGPdOXkOmipPq+ddtd4bX97b+CvjYoVvw/9cQ+b2
        d69vTGiU8/GXaDx/48t97zye3gR5F4fK/zOEH0rwrpI3P1Obutf6/0M20ct3OYytAmIPm0/O
        y3/1dv6Gx4s+CjXxuTMlOaVwbqno4O4QS56QeuLIr0N7aoQt9ZzmNvxdoOa8UiicM37Nbi+z
        SE8vifgdjBtPT+tQcHn+u7tbKOv6LmanKHGrr64OitqytZlvnz4xZes6scZp9lKBHLNX1btX
        7PHP9xdaFTdd56rUjcVn4qafO9Mx+XDoOcbvW89NuThn/529R+ImhvsrsRRnJBpqMRcVJwIA
        AKyzyCwDAAA=
X-CMS-MailID: 20220907063348epcas5p15d482a6f03f21489aedde74f93c64ae4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063348epcas5p15d482a6f03f21489aedde74f93c64ae4
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063348epcas5p15d482a6f03f21489aedde74f93c64ae4@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MFCv12, the rc configs are changed with support for CBR loose,
CBR tight and Variable Bitrate (VBR) added.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 22 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index eecefcfc683b..c0b8434812e0 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1039,10 +1039,24 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 
 	/* reaction coefficient */
 	if (p->rc_frame) {
-		if (p->rc_reaction_coeff < TIGHT_CBR_MAX) /* tight CBR */
-			writel(1, mfc_regs->e_rc_mode);
-		else					  /* loose CBR */
-			writel(2, mfc_regs->e_rc_mode);
+		if (IS_MFCV12(dev)) {
+			/* loose CBR */
+			if (p->rc_reaction_coeff < LOOSE_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* tight CBR */
+			else if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(0, mfc_regs->e_rc_mode);
+			/* VBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		} else {
+			/* tight CBR */
+			if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* loose CBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		}
 	}
 
 	/* seq header ctrl */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index 30269f3e68e8..24752a712fbf 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -40,6 +40,7 @@
 #define ENC_H264_LEVEL_MAX		42
 #define ENC_MPEG4_VOP_TIME_RES_MAX	((1 << 16) - 1)
 #define FRAME_DELTA_H264_H263		1
+#define LOOSE_CBR_MAX			5
 #define TIGHT_CBR_MAX			10
 #define ENC_HEVC_RC_FRAME_RATE_MAX	((1 << 16) - 1)
 #define ENC_HEVC_QP_INDEX_MIN		-12
-- 
2.17.1

