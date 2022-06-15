Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671154C83D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347458AbiFOMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbiFOMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:15:17 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8999A3F8A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:15:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220615121514epoutp03e35bde113110040028bcf72015cbec90~4ylGaCMBu0102001020epoutp03R
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:15:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220615121514epoutp03e35bde113110040028bcf72015cbec90~4ylGaCMBu0102001020epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655295314;
        bh=rt7zu6YaW3JrRH+QsNmwSsIeJCoaGLY0mVqfGMMxmHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+woY1plLl9c7cv1MARO95AlZCOKPWpnMGvf5opotRToezvDjQnHmEK2xHwl0loTZ
         00TsjdS01vYWFGULRANLA9X6RUbu8g2KkILl+p+fWsoYk6k5dt5n6B/UBpJBFyyl86
         hPFbhHD77C5VnYbfT3SKc6Jm1JQF0GpLwbCrRY38=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220615121514epcas5p2c33b9729b5c3174c189e152b931d8e59~4ylF_z9su1721917219epcas5p2D;
        Wed, 15 Jun 2022 12:15:14 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LNPQ81mBjz4x9Pp; Wed, 15 Jun
        2022 12:15:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.85.09827.05DC9A26; Wed, 15 Jun 2022 21:15:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718~4ylDjvPLJ0984109841epcas5p22;
        Wed, 15 Jun 2022 12:15:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615121511epsmtrp2657511d404b22246222217d412ea7019~4ylDi6gD00134501345epsmtrp2z;
        Wed, 15 Jun 2022 12:15:11 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-83-62a9cd503179
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.72.08924.F4DC9A26; Wed, 15 Jun 2022 21:15:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220615121509epsmtip27245aa9e522984cb1a68b3a6b8928371~4ylBvNRxz0845808458epsmtip2h;
        Wed, 15 Jun 2022 12:15:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     beanhuo@micron.com, krzysztof.kozlowski+dt@linaro.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 2/3] ufs: host: ufs-exynos: use already existing define
Date:   Wed, 15 Jun 2022 17:42:03 +0530
Message-Id: <20220615121204.16642-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220615121204.16642-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmhm7A2ZVJBr9ncVo8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni8n5ti74XD5ktNj2+xmpxedccNosJq76xWMw4v4/Jovv6DjaL5cf/MTnw
        eFy+4u1x59oeNo/NS+o9vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCuCIyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcfPxWqaCJdwVvx4u
        YW1g3MbZxcjJISFgIjHl6HnGLkYuDiGB3YwSn9Z/YIZwPjFK9M+6xgZSJSTwmVHi4jwPmI5l
        WzawQRTtYpSY/vIUVHsLk8SfMzeYQKrYBLQl7k7fwgSSEBFoZpQ42LELzGEWeMko0f7kAiNI
        lbCAu8TzpfvYQWwWAVWJTSeWs4LYvAI2EkcmfGaC2CcvsXrDAaCjODg4BWwlzjy0AJkjIdDK
        IdG0/hxUjYvEl+tzGSFsYYlXx7ewQ9hSEp/f7WUD6ZUQ8JBY9EcKIpwh8Xb5eqhye4kDV+aw
        gJQwC2hKrN+lDxJmFuCT6P39hAmik1eio00IolpVovndVRYIW1piYnc3K8zw70uDIcEwgVFi
        1qw2tgmMsrMQhi5gZFzFKJlaUJybnlpsWmCUl1oOj6fk/NxNjOAUqOW1g/Hhgw96hxiZOBgP
        MUpwMCuJ8JoFr0wS4k1JrKxKLcqPLyrNSS0+xGgKDLCJzFKiyfnAJJxXEm9oYmlgYmZmZmJp
        bGaoJM4r8L8xSUggPbEkNTs1tSC1CKaPiYNTqoFJ+75ku+ixcyJSvD+qqu3WJr1knP/sl4Zc
        RUwRY1GIpUHE2XfG3jyc4reXfzphNPuXyPu4aZ++b/p54NNur/ZfewsfBS0wz5lmnvNs1ePu
        jf7LVisuiVGV+XjoY56797rUNM/Vf+beyDraKFSb81THnj+BUfHx6ujEXluj57GvxSVFy9jL
        z535fiLj+J6L/9oVlpwNOXfc7QZPOuNmx79P3eSl/3r0xLmUH4k9H5dVs7T2v6pArBjT2U97
        Fu76bKzy53/wB2+VOP+kvVrHHX7K5nKUz/+7MC+uNv3H3o83t4oxx76q+r/vsQOP3/Q/E7vM
        +2e9lc7q1q/g+3fv7l0r7tI61V2t8RU9ujyntz1TYinOSDTUYi4qTgQAybqQZwoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvK7/2ZVJBi2vdSwezNvGZvHy51U2
        i4MPO1kspn34yWxxeb+2Rd+Lh8wWmx5fY7W4vGsOm8WEVd9YLGac38dk0X19B5vF8uP/mBx4
        PC5f8fa4c20Pm8fmJfUe39d3sHl8fHqLxaNvyypGj8+b5DzaD3QzBXBEcdmkpOZklqUW6dsl
        cGXcfLyWqWAJd8Wvh0tYGxi3cXYxcnJICJhILNuyga2LkYtDSGAHo8T50+/ZIRLSEtc3ToCy
        hSVW/nvODlHUxCTR9ecpG0iCTUBb4u70LUwgtohAO6PE/e1gk5gFPjJKvOxewgiSEBZwl3i+
        dB/YJBYBVYlNJ5azgti8AjYSRyZ8ZoLYIC+xesMB5i5GDg5OAVuJMw8tQMJCQCV3nzxgm8DI
        t4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAAa2ntYNyz6oPeIUYmDsZDjBIc
        zEoivGbBK5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
        YHKdcvNhvXjc1LW6/+bqKU5Lf/M7wdRd7tWuZqb+/Pibt+cHbzA0Oh3w1/1UosOMljImp6nV
        N7wKP2+ao1vPdMElKTrTW4lh4RddlYdJ7rt1DxyU/r77Y/gJhVjleQ5u66Pm6nGK7duTYFYS
        s/bt3zMztzmIt4QvfDN/dp3hm42bPXyuKZvsE7/sr3rjrOghjke3bv/dMy3/9fcFFe9rUh9V
        LnjhJcF0gDVo9oJNu6Rc3k//4us4aVLbC/1iX85XB/qmiV87e+JBz8pOqf28VVMapi+rM5wp
        JbA/wWNh6rm++Vwi99+dEFUNfh3eEvUpLji6RPzmAtHAw1rO089fFGV/fe9U1abkkG/nap01
        H8oosRRnJBpqMRcVJwIA/JPDuc8CAAA=
X-CMS-MailID: 20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718
References: <20220615121204.16642-1-alim.akhtar@samsung.com>
        <CGME20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS core already uses RX_MIN_ACTIVATETIME_CAPABILITY macro, let's use the
same in driver as well instead of having a different macro name for the
same offset.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 5 +++--
 include/ufs/unipro.h          | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 04728b5da040..f971569bafc7 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -651,8 +651,9 @@ static void exynos_ufs_config_phy_cap_attr(struct exynos_ufs *ufs)
 
 			if (attr->rx_min_actv_time_cap)
 				ufshcd_dme_set(hba,
-					UIC_ARG_MIB_SEL(RX_MIN_ACTIVATETIME_CAP,
-						i), attr->rx_min_actv_time_cap);
+					UIC_ARG_MIB_SEL(
+					RX_MIN_ACTIVATETIME_CAPABILITY, i),
+					attr->rx_min_actv_time_cap);
 
 			if (attr->rx_hibern8_time_cap)
 				ufshcd_dme_set(hba,
diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index 0521f887e3ac..ade92e8d3676 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -69,7 +69,6 @@
 #define RX_HS_G2_PREP_LENGTH_CAP		0x0096
 #define RX_HS_G3_PREP_LENGTH_CAP		0x0097
 #define RX_ADV_GRANULARITY_CAP			0x0098
-#define RX_MIN_ACTIVATETIME_CAP			0x008F
 #define RX_HIBERN8TIME_CAP			0x0092
 #define RX_ADV_HIBERN8TIME_CAP			0x0099
 #define RX_ADV_MIN_ACTIVATETIME_CAP		0x009A
-- 
2.25.1

