Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A34BCEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiBTN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:27:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBTN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:27:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4C1D0D7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:26:52 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220220132642epoutp041b12220f19609aa44e9fee5d649099e9~VgXqaQ1r41280912809epoutp04Y
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:26:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220220132642epoutp041b12220f19609aa44e9fee5d649099e9~VgXqaQ1r41280912809epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645363602;
        bh=+HD+D2BQMpJSVzjCz+rHhjvbcjam5OKuDzCH7joqwW8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=l5PVy6J4AuFpVUoRNYoR0Htao6iFNGLNMnFzP0U4G9DygsPjQsy3vZFU1lHyS+MGm
         dkclNdbFRBB2mi/UTrMDk28LwLOiW+uYiq+5V5cYN3TQfvo6x1Z7mhB/S0sBBeKWOT
         3/Hr+xS9nTxSZxf57VuWjKJ8Fzy7dqMSdF2eoqGY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220220132641epcas5p3a51612aef12f9f3f7bb784be42478ac4~VgXpv1YiG3031930319epcas5p3C;
        Sun, 20 Feb 2022 13:26:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K1mRd5JJlz4x9Pp; Sun, 20 Feb
        2022 13:26:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.EB.06423.B8142126; Sun, 20 Feb 2022 22:26:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220220132636epcas5p4f320ac6dff9621b75481bd71b1f33183~VgXlCPyWX2553925539epcas5p4p;
        Sun, 20 Feb 2022 13:26:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220220132636epsmtrp1e71b6060479be13e4c8b6a4e351abb0f~VgXlIoP-w0610706107epsmtrp1Y;
        Sun, 20 Feb 2022 13:26:36 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e4-6212418bc4da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.AD.29871.A8142126; Sun, 20 Feb 2022 22:26:34 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220220132635epsmtip1402bbd39080b2d5b2f56d2cbed28a9b6~VgXjsfVTd2735827358epsmtip1O;
        Sun, 20 Feb 2022 13:26:35 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 1/3] clocksource/drivers/exynos_mct: Remove mct interrupt
 index enum
Date:   Sun, 20 Feb 2022 19:08:22 +0530
Message-Id: <20220220133824.33837-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmum63o1CSwYPdehYP5m1js5j3WdZi
        49sfTBabHl9jtbi8aw6bxYzz+5gs1h65y26xaOsXdovNm6YyO3B6zGroZfO4c20Pm8e7c+fY
        PTYvqffo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rkv5t1jL2jmrljzX7aB8TtHFyMnh4SAicTN409Yuhi5OIQEdjNK
        vPlxjw3C+cQoMXXqGajMN0aJXU/WM8O09DxewgyR2MsocWnDdyinhUlie+cUVpAqNgFtibvT
        tzCB2CICbhI3GjuYQIqYBa4xSvyZeIgRJCEsEClx9NBNMJtFQFXi4q0TYA28AjYSZ58tYYJY
        Jy+xesMBsA0SAofYJT6cOMoIkXCRuP20gwXCFpZ4dXwLO4QtJfGyvw3I5gCysyV6dhlDhGsk
        ls47BlVuL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fMEF08kp0tAlBVKtKNL+7CtUpLTGxu5sV
        wvaQ+PfsBVhcSCBW4u+dNuYJjDKzEIYuYGRcxSiZWlCcm55abFpgmJdaDo+b5PzcTYzg1KXl
        uYPx7oMPeocYmTgYDzFKcDArifB+OMibJMSbklhZlVqUH19UmpNafIjRFBhKE5mlRJPzgckz
        ryTe0MTSwMTMzMzE0tjMUEmc93T6hkQhgfTEktTs1NSC1CKYPiYOTqkGJpWTU7Q1gvP+cdr+
        jvntxK0531L1vJLy1M6KzyalPVabtx1/GmTE6lgrL8txa4LOpHi/J8vynLX93m9ZE84dMmvR
        x+LFe6R0Vs/+dH7vlmnWBtd81bTLEh9GPLf7XJBlPFUwJnW/0yrZnw8XM9vvUP5mZx157c+G
        M3uDj6YISTqHsH3e9NDNUvy64rKdvcVXv3KzHb7WlhgV8vr2yhmaf5mntls0hE9fOX/rre6s
        OLN7td8XM3ebLv52/bvHuvflzZEar9rvRK04NY9hy5Pzk98Kudz7JnreblvFrt3il7wapok8
        tBGMO2SWw9l4wqMr9sNnjlU7zwa4Nr17fu7VYdVfCWWnus/KVil4XW0Nb1RiKc5INNRiLipO
        BABdGD805gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJTrfLUSjJYMkaQ4sH87axWcz7LGux
        8e0PJotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYtPULu8XmTVOZHTg9ZjX0snncubaHzePduXPs
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxot599gLmrkr1vyXbWD8ztHFyMkhIWAi
        0fN4CXMXIxeHkMBuRomj2/6zQySkJa5vnABlC0us/PecHaKoiUni8+lZbCAJNgFtibvTtzCB
        2CICHhJt/+6BTWIWuMco8btlGiNIQlggXGLZuR4WEJtFQFXi4q0TYA28AjYSZ58tYYLYIC+x
        esMB5gmMPAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgQHmJbmDsbtqz7oHWJk
        4mA8xCjBwawkwvvhIG+SEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUwO/v3bvHNs2FbHPrGP17mZskcwtXiK/JejbS9+1zT9S4uYp5yqeShBIibjSjv/
        73My8+ufBmhud7hrc83jSt20ZWLeHNY3L13iYglamyV+2CsjeP3cns8rxLrP31suldbmezxp
        w2l3o8KFrlafWxeX3c+6/qv+yhzD/SZSj/+ucgg0sOhQOMhUYmUcrLzo0YY5obOq302+yRpv
        UBH3tH3fsr9GvMVXuQ8vWLrh38RLof7x8TtSlyruPJjeu+DH/rq9+/x5si4e3JO8Tr61p3b/
        ypCOs//D919ft9NigvWMQj5vntrz0yW58wxUd8yfdMqi8lNfYlzpUXM9/SXsd2pWZr6Lubol
        X+S4wIHqIy1KLMUZiYZazEXFiQAXywAdnwIAAA==
X-CMS-MailID: 20220220132636epcas5p4f320ac6dff9621b75481bd71b1f33183
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220220132636epcas5p4f320ac6dff9621b75481bd71b1f33183
References: <CGME20220220132636epcas5p4f320ac6dff9621b75481bd71b1f33183@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCT driver define an enum which list global and local timer's
irq index. Most of them are not used but MCT_G0_IRQ and
MCT_L0_IRQ and these two are at a fixed offset/index.
Get rid of this enum and use a #define for the used irq index.

No functional changes expected.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

* Changes since v1:
- Seperate out bumping up of max mct irq and local timer number
  as commented by Krzysztof

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d5511b0f..b3f3d27a837b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -60,27 +60,17 @@
 #define MCT_CLKEVENTS_RATING		350
 #endif
 
+/* There are four Global timers starting with 0 offset */
+#define MCT_G0_IRQ	0
+/* Local timers count starts after global timer count */
+#define MCT_L0_IRQ	4
+#define MCT_NR_IRQS	12
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
 
-enum {
-	MCT_G0_IRQ,
-	MCT_G1_IRQ,
-	MCT_G2_IRQ,
-	MCT_G3_IRQ,
-	MCT_L0_IRQ,
-	MCT_L1_IRQ,
-	MCT_L2_IRQ,
-	MCT_L3_IRQ,
-	MCT_L4_IRQ,
-	MCT_L5_IRQ,
-	MCT_L6_IRQ,
-	MCT_L7_IRQ,
-	MCT_NR_IRQS,
-};
-
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
-- 
2.25.1

