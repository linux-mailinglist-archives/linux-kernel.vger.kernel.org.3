Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F385AFCA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIGGio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIGGid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:38:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134E8274A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:38:18 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220907063731epoutp03c9dd4edf18fe873392ac37418e6de6e9~SgKNO80bU2318823188epoutp03n
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220907063731epoutp03c9dd4edf18fe873392ac37418e6de6e9~SgKNO80bU2318823188epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532651;
        bh=9Ulim04NqlgqsmgMTHqB534xiBBhfbB8/nQ94NlQwb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGwr9sXNSusO3cGmF9a2GUQBC+7DeaJQ+u9Gjyp0f+nKTq8W4TiZS9CbXYZlJpu5s
         sNQA2g7yiW2jHgXiPYM23EbnjAnRvD6iP+qhnHVdUx6ywH7jBJA3w1eaqvcuzLzz+9
         Om+tIM8ICE89UbmyA0QeKekri+TmkG7iKAfjINiw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220907063730epcas5p2498946eaab64f34e94180ec1896b0052~SgKMYaJV52160221602epcas5p2D;
        Wed,  7 Sep 2022 06:37:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MMsxf6njMz4x9QF; Wed,  7 Sep
        2022 06:37:26 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.B3.53458.62C38136; Wed,  7 Sep 2022 15:37:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907063404epcas5p2e300613155b910ab587d015e77a2aa0e~SgHMds3U-0898708987epcas5p2U;
        Wed,  7 Sep 2022 06:34:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063404epsmtrp235ce1895f0b8d808325c34056360a2d9~SgHMbYBbb1916519165epsmtrp2c;
        Wed,  7 Sep 2022 06:34:04 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-10-63183c26a31a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.EC.14392.C5B38136; Wed,  7 Sep 2022 15:34:04 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063400epsmtip19c583cdf2873d408d03ccb3d80d3a342~SgHJIFjOE2638126381epsmtip1L;
        Wed,  7 Sep 2022 06:34:00 +0000 (GMT)
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
Subject: [Patch v2 13/15] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Date:   Wed,  7 Sep 2022 12:17:13 +0530
Message-Id: <20220907064715.55778-14-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTa1BTRxTHuzc3D+iEuQIdVijK3L5GEEhiki6vVlvGXvsS61Rbx4ppcicg
        IYm5QUqdIo8CNkArDHYAEQVCqbxUJDS8BoS0OAiODAj90Eh4KEVHMaZQpojThED77XfO+e/+
        z57d5bG8bRx/XqJaT+vUMhXJ8cTb+re9Efp6NJQLcscl6J65jI1slW0cVLM8h6HJGgeO+q6Z
        uKh17BwL1Q30stEFyy02+uX6NI6u/umsjpRZcTR3oRmg+fK7HNQyM85GUw8OotGOCg4quGJi
        oyaLlYtqJ0Yw9FPLMwxVm/7iopxuCxdZu9oA+jbXgu2EVGNlI6DMViOgJoxPWVR7uZVL1XTN
        Y1RL/Xcc6o/xLg51zXiKyvn1H5z6vrUeUM+zznMpg2WCQzlatlCDiw5unNehpOgEWqagdUG0
        Wq5RJKqVMeQH++PfjZdIBcJQYQR6kwxSy5LpGDL2w7jQ3Ykq5xjIoBMyVYozFSdjGDL8rWid
        JkVPByVoGH0MSWsVKq1YG8bIkpkUtTJMTesjhQKBSOIUHk1KuF9cjGs7uV/ZH/ZwM0AtxwA8
        eJAQQ1NhHcvF3kQngPfG+Abg6eSnANrmzBx3sARgbVYpvrFi5ceNQjeAzxqmcHeQjcEzs1lr
        Kg6xHS4t3Fzz8CUyAZw5rXeJWEQ2Dq1DK1xXwYfYB3uGrJiLceI1aLt9ERgAj8cnIuHg79Fu
        t62w4UrvWn8ezvRIyQ22ax9I5HnAu4/s64eIhQU1q2w3+8AHA61cN/tDx+PudY0STjqygZu1
        8HxGK+bmt2HvWAXu8mUR2+DljnB3OhCeHWxek7AIL1i4Mrsu50Nz5QaTsHroxroVhHcemdZb
        oGC72QjcQykEcLG0DZwBW8r/t7gIQD3YTGuZZCXNSLQiNZ36363JNcktYO2pB79vBlO2J2F9
        AOOBPgB5LNKXrzD7yr35Clna17ROE69LUdFMH5A451fE8n9JrnH+FbU+XiiOEIilUqk4YodU
        SPrxS0KA3JtQyvR0Ek1rad3GOozn4Z+BlZoTVY1VryZW9C1v5WV+kT+/+beVDvNHMz90l90K
        UBt9Mm21nqpsr02HTWX9UcYZ/tjBv40FuY5hbKBxb/Cn6XdMVfagkyWfR64+4emyR4f1j/M9
        A68f2DW5cPrlq4dWyZs0FITEiNJ37qt7kRy2TDcsHN17qencdGoUMF/afntE2bQkDjzcw0wV
        Tcwe6+/Md4y0Fi0G7irWPNeIDKOm49W28MnlpvksyeWonz/xWD7yTqDcuONAM9qkCz2e0J22
        58Q3Ke2rC6mGL+2nZhUBomU63NKcExlwUp6nE70QO1N15LP0Vz5uvC98+J5fmnR3u9fK/jw/
        Y8h4sz02PPTYor0ujsSZBJkwmKVjZP8CD4vUdXMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG6MtUSywaHXvBZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXxbNIkloLd7BUf
        X+9nb2BcytbFyMkhIWAi8XvaDiCbi0NIYDejxPZnPYwQCQmJlb8nQdnCEiv/PWeHKGpkkjhy
        8yc7SIJNQEfi2/vTYN0iAq2MEtdXdjKBOMwCs1kkfkw6wApSJSzgL7Hp7R2wUSwCqhIPLiwA
        sjk4eAWsJE7dsIHYIC+xesMBZhCbEyh8ccoJsFYhAUuJxzO2sU9g5FvAyLCKUTK1oDg3PbfY
        sMAwL7Vcrzgxt7g0L10vOT93EyM48rQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6UHSLJQrwpiZVV
        qUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBpsv89tUvU91LTyTNb
        Mxb1GG4Sm6Nns+17m/G/XVWfOj6vz5qlrjszMOajQ02i+qJncouDvNgl5D55MjCJzpq16N1G
        R9nMb4VMG8vWXbE6qLe14MJml4T0+z8eFu1n4d/4PfFyTTjPR88PS76vMOdeVaE451f3syL3
        m2/452zdaP496NFfq5nlay67eN/QLvskdnPq0QSbeUdm19q+vHZtKR+jS2VtRPrhbV8K03/e
        mKEtIbr9/uJAD64+2Zcnblgfzgx25fkrtCzPz7stYTFPUVT4ls1dsZ7X2uf93qcZO1f1gaBM
        /UXFTwXyy6OOTjgoEar/8nDx6qUHunZyvp+WvnTi+YkLvlx4FPjSSz/qphJLcUaioRZzUXEi
        ANeW9BErAwAA
X-CMS-MailID: 20220907063404epcas5p2e300613155b910ab587d015e77a2aa0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063404epcas5p2e300613155b910ab587d015e77a2aa0e
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063404epcas5p2e300613155b910ab587d015e77a2aa0e@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MFCv12, some section of firmware gets updated at each MFC run.
Hence we need to reload original firmware for each run at the start.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 877e5bceb75b..a70283d4c519 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -51,8 +51,9 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	 * into kernel. */
 	mfc_debug_enter();
 
-	if (dev->fw_get_done)
-		return 0;
+	if (!IS_MFCV12(dev))
+		if (dev->fw_get_done)
+			return 0;
 
 	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
 		if (!dev->variant->fw_name[i])
-- 
2.17.1

