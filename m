Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4098352A27C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiEQNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbiEQM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:51 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A554D9F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:00 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125858epoutp044c327c9244b397dc1878d0f92fd58602~v5eAI2c991668916689epoutp04N
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125858epoutp044c327c9244b397dc1878d0f92fd58602~v5eAI2c991668916689epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792338;
        bh=9Ulim04NqlgqsmgMTHqB534xiBBhfbB8/nQ94NlQwb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQhxWTTA3raNc+594kG6ikhudZPGMD2FXCTXxMoj6iuvdb+FCTmn4UJ5waNxRLy9k
         EGgAqydQ32DLuJD+ElEybLTNP5THR+GY556ti3fiSdZbdE9psoCj4tXWtbkQqfABUB
         pVtg9rNAc+WLRrdBJtk38dRgXk+oGTYs5nWSMRRs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125857epcas5p3757082fc392a5a4a2ed28fb8329b4cd6~v5d_16IU60661806618epcas5p3C;
        Tue, 17 May 2022 12:58:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2blw31Fzz4x9Pv; Tue, 17 May
        2022 12:58:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.EE.09827.C0C93826; Tue, 17 May 2022 21:58:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125637epcas5p4f691d6c9011d3e82f2d776c440816d98~v5b81l8nN1555515555epcas5p4W;
        Tue, 17 May 2022 12:56:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125637epsmtrp2bbb20df07685bf9a3975a37f233a0b42~v5b80tQ3N0914309143epsmtrp2P;
        Tue, 17 May 2022 12:56:37 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-4c-62839c0cde5d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.AA.11276.58B93826; Tue, 17 May 2022 21:56:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125634epsmtip1e2e3c8187ec18205f042d059132649b4~v5b5y6ngP2352323523epsmtip1i;
        Tue, 17 May 2022 12:56:34 +0000 (GMT)
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
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 14/20] media: s5p-mfc: Load firmware for each run in MFCv12.
Date:   Tue, 17 May 2022 18:25:42 +0530
Message-Id: <20220517125548.14746-15-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe1BUVRzu3H3cBUVvQHmkwp1tdNACd5FdDoyEJtalLFFncNIpuLB3dhmW
        3Tv7SGyEVhbYRCm0sZAAGR6mREDLQ+IRuEIQAYVskA0rDwWUpAgUTWi3hV3qv2++7/v9vt/5
        nXN4LM+bXB9eglJLq5WUQsB1Z9df3+rnvzbfECe093ij0cJ6Lip5PIWhkZJ5NjLX1OGo1vIF
        C33Z2cZBF9v7OOjqtXE2+uauQ+2/YGWjqYuVAN3Lu8VFptuDHDQ2fRgNNOZz0ZnqOg76ut2K
        o7KhfgxdMi1hqLjuAY4yWtpxZG2uByg9sx3btYGsKKwAZIO1FJBDpXMs8ts8K06WNN/DSFP5
        KS45PNjMJWtKPyQzOp6wyY9rywFpSyvAyaz2IS45b/Ilux/O41HrjiTulNOUlFbzaWW8Spqg
        lIUJ3jwUsydGLBGK/EUhKFjAV1JJdJggYl+U/2sJCscGBPz3KYXOQUVRGo1g+ys71SqdlubL
        VRptmIBmpAomiAnQUEkanVIWoKS1oSKhMFDsMMYmyifPnWMzTXjyX7+34npQxs0CbjxIBMH+
        3hmQBdx5nkQTgNNXFlYET2IOwOxJuVNYAPCh+QFrtSI3/RFwmlocwhXGaUrH4J20YnxZ4BIv
        w4U/f1zp5E2cBPD2R9plzCIWWfCCxXcZexH74OKlsRUPm9gMJ9PsKwEeRCg02PpwZ9gm+FV1
        m4Pn8dwcfIHt3eUsSNh5cKS8zXWECNiTc9WFveB0Z62r1gfO/9Hi4mVwZN4AnJiBBfpazInD
        YZsln73cn0VshVWN2530C/B8dyXmHHkdzF6847J7wIbCVSyAxT1drigIf5mp4zgxCQ2FAyzn
        TrIBHFsswXKAb97/EUUAlIONNKNJktEaMROopI/9d2fxqiQTWHnj295oAGOjswFmgPGAGUAe
        S+DtIUzWx3l6SKnjH9BqVYxap6A1ZiB27O8sy+eZeJXjkyi1MaKgEGGQRCIJCtkhEQk2eBD2
        k3GehIzS0ok0zdDq1TqM5+ajxxRaXWWj+UbxAY5hc0rTiTUN0a03f/07V3Arw73xwEb+9fD9
        VFdRjv4ty7HPxDOtVM1z8Zt0n5gvP7tlotP+uvGobbA01nLwrnLPVCrTNy0ODI8SmQZiT5c9
        zUz8NPuqPwqtrn+8VB5/9KnT7NFx+4gtcX3z87KK+7tDB3bITpRlRmalErO7lUv+1/w6ftb8
        cEr43sz66N96jxvGZ43Dh94RmSJTpVXRmWsk1UZ25PfG3EcHM1IzVfv95Bz+3rcDK18Mnks6
        b02s8a2a3DWxpShXv/fG4fvDgSj4n8sdR3rXFmAWY5blidd3i12DiuSJiNnPmfDdKaS0cvyl
        FHzAyD9r+7RbwNbIKdE2llpD/QtF//DFbAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnG7r7OYkg9ZLyhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLhq3CLy7vmsFn0bNjKarH2yF12i6XXLzJZLNv0h8li0dYv7Bate4+wW9zds43RoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYwe/5rmsnt0HbnO5vF5k5zHqa+f2QP4orhsUlJzMstSi/TtErgynk2axFKwm73i4+v97A2M
        S9m6GDk5JARMJGa0fGcEsYUEdjNK3HirDBGXkFj5exIjhC0ssfLfc/YuRi6gmiYmia8XLrKA
        JNgEdCS+vT/NBpIQEWhllLi+spMJxGEWmMgiMeX6L2aQKmEBH4nfyx6CrWMRUJV41vQfLM4r
        YCXR/O8cO8QKeYnVGw4AxTk4OIHic//FgphCApYST/dbTGDkW8DIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzjWtDR3MG5f9UHvECMTB+MhRgkOZiURXoOKhiQh3pTEyqrUovz4
        otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamMK3SfucyTC/IWn9hU+lUT7U
        wtXslYBukHUX7/vajIvLOlzmCfIH/L7ovHTP7U/R15tcZCRO92VvSVu+oaDYliertZLzJPOl
        mSsNrn9m4ml/8TS08MD9aVyHWhvczBT3TD7kaRP3MGTjfK/Ch2fj920UlOLecE87f8UMVvXH
        nXPD9/07LD9b/WnVfcOXbG/Kkg4ZXuJ86MC9ktE19+r8G5PTQo097weoGgtk2/CLaKz/5Mm+
        QmZf1smv7bbr2UJ+N5+u0w9lljLn27v3vdzxl+/4Zv6+bVeTvvxFwcX/xcXRCkHVKV8OsEis
        kCh9Kahy2fKIvO7djqjoZEmj/p6Ln+b2bqnvVVml/JbDQ7VUiaU4I9FQi7moOBEAtHl3tyQD
        AAA=
X-CMS-MailID: 20220517125637epcas5p4f691d6c9011d3e82f2d776c440816d98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125637epcas5p4f691d6c9011d3e82f2d776c440816d98
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125637epcas5p4f691d6c9011d3e82f2d776c440816d98@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

