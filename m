Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96B54C839
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiFOMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiFOMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:15:16 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6CF3B00F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:15:14 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220615121513epoutp04fdf24f8d31324749ea98c121df78694e~4ylEqh4iz1956219562epoutp04j
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:15:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220615121513epoutp04fdf24f8d31324749ea98c121df78694e~4ylEqh4iz1956219562epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655295313;
        bh=45EVsfyKlrStPGc+fbkJ+/PhzRWuoeaPcj31oX5+kQI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mU9Oeqb6ZVI3tclV2ODaa0GOcJqLVftQ3vHvVzNCagmrUu1PBfvd7CwuzPSyHOAAQ
         4NyVQ4+vuRCCuUqr9q/K9H+BjZnPfT4ZDFx3NwPPW4ML46+gI7fTfYNAFrgZ90wWeQ
         Dc7fUc7xOmEfWeWL8fiCBQf1RQfjspuwbcbzZLMY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220615121511epcas5p3619574d4c9ea0cefacc447dca0bc8390~4ylDofWAz2105621056epcas5p3E;
        Wed, 15 Jun 2022 12:15:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LNPQ55SD9z4x9Px; Wed, 15 Jun
        2022 12:15:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.87.09762.D4DC9A26; Wed, 15 Jun 2022 21:15:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4~4ylAqOeyM1809018090epcas5p3W;
        Wed, 15 Jun 2022 12:15:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615121508epsmtrp25980d86e295ce4be58a76bc40688f8b0~4ylApTicz0134601346epsmtrp2w;
        Wed, 15 Jun 2022 12:15:08 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-a4-62a9cd4d9fed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.72.08924.C4DC9A26; Wed, 15 Jun 2022 21:15:08 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220615121505epsmtip25af5427dbaad4a1ac93d29b318c37e44~4yk9oJ11A0845808458epsmtip2g;
        Wed, 15 Jun 2022 12:15:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     beanhuo@micron.com, krzysztof.kozlowski+dt@linaro.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 1/3] ufs: host: ufs-exynos: remove unused defines
Date:   Wed, 15 Jun 2022 17:42:02 +0530
Message-Id: <20220615121204.16642-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmhq7v2ZVJBls3a1o8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni8n5ti74XD5ktNj2+xmpxedccNosJq76xWMw4v4/Jovv6DjaL5cf/MTnw
        eFy+4u1x59oeNo/NS+o9vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCuCIyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcX2zUMFLjooHp1Ma
        GG+zdzFyckgImEg87znMAmILCexmlLjdJd3FyAVkf2KUmPCxnQXC+cwoMe/0URaYjtWdy9gg
        ErsYJe7/7WKCcFqYJF5P6WIDqWIT0Ja4O30LWEJEoJlR4mDHLjCHWeAlo0T7kwuMIFXCAo4S
        3TNXgHWwCKhK3D1yC2wHr4CNxP4/Xxgh9slLrN5wgBmkWULgHrvE8w0fmCESLhIHPt2BOkpY
        4tXxLVAvSUl8frcXaCgHkO0hseiPFEQ4Q+Lt8vVQM+0lDlyZwwJSwiygKbF+lz5ImFmAT6L3
        9xMmiE5eiY42IYhqVYnmd1ehFklLTOzuZoWwPSQ+f7/BBgm7WIlFt2+zTGCUmYUwdAEj4ypG
        ydSC4tz01GLTAuO81HJ41CTn525iBCc6Le8djI8efNA7xMjEwXiIUYKDWUmE1yx4ZZIQb0pi
        ZVVqUX58UWlOavEhRlNgKE1klhJNzgem2rySeEMTSwMTMzMzE0tjM0MlcV6B/41JQgLpiSWp
        2ampBalFMH1MHJxSDUwVIV+zr84LrDrwn2m99oILvsXRm05e9ZHbdGH9xJu6M3pmmiVZ+DK8
        tZrDHm73LLltfsWEhcYr3/4+vyJ1y9ozF536+m6+6d8g//2Ia8pXY/vnDWc+dty7NUuauYIh
        5eXi/Mt5RhFqnu99d02Y8dA+tj57wd8Zbg3lXz3vPct5P//cjWIuU/eVyplLuPi/Jq1wnpty
        5U3v4axf8rWpvIy27WmLJ138tC7E+FbfuvS4ZVbS3/rZZ7Pdnvnu/YF9b2LEfsrc/eKVOPmE
        VveNC0ll/2dlSFj87vLKEfbbvutSGMPajxMnPBK88FTt45IzZvnHuOo6lEP3FMu0lKas5nu5
        fV3bOqm/3EF+UrJRu34tU2Ipzkg01GIuKk4EAKO1kj79AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvK7P2ZVJBi3bVSwezNvGZvHy51U2
        i4MPO1kspn34yWxxeb+2Rd+Lh8wWmx5fY7W4vGsOm8WEVd9YLGac38dk0X19B5vF8uP/mBx4
        PC5f8fa4c20Pm8fmJfUe39d3sHl8fHqLxaNvyypGj8+b5DzaD3QzBXBEcdmkpOZklqUW6dsl
        cGVc3yxU8JKj4sHplAbG2+xdjJwcEgImEqs7l7F1MXJxCAnsYJS4fXAaI0RCWuL6xglQRcIS
        K/89Z4coamKSmHLiJxNIgk1AW+Lu9C1gtohAO6PE/e1gk5gFPjJKvOxeAjZJWMBRonvmCjYQ
        m0VAVeLukVssIDavgI3E/j9foLbJS6zecIB5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnF
        pXnpesn5uZsYweGopbWDcc+qD3qHGJk4GA8xSnAwK4nwmgWvTBLiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBybJEOpBTWW/FnYIlqe/MCk3Tt7tU7pkx
        IS3K8WPXnPTHK5QDy04cMProlZ+98E3HO57raXbLr7Ju+qUnv8brtMmPq802P3d4vJp258xS
        HrMtVpnfpvUtihD5Xx8UzRlQkWlbx/NBUOveob2Tdpg9bYl1nuZXEV1lonvbOfn/bkuP1j3L
        Q19rXHm95ItvxJvNua+COkKvGFxj5M9f/aHtrK+G6cEega8yn4X3s9++4Xw2SWrKuipn3vl+
        RRK3QkOiuwvWOAjzuU5NPfX5TunXnl+ZWXskuM4lSsit614+gd9UtUe1SntiuPm2dbPTZW+k
        fTBz4hEvzti1eJeB/ue92WsVy/2/vdyaMH2bwCF7JZbijERDLeai4kQAXsX+ObYCAAA=
X-CMS-MailID: 20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4
References: <CGME20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #defines as those are not used anywhere in the driver file

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 068f881113ff..04728b5da040 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -136,16 +136,6 @@ enum {
 /*
  * UNIPRO registers
  */
-#define UNIPRO_COMP_VERSION			0x000
-#define UNIPRO_DME_PWR_REQ			0x090
-#define UNIPRO_DME_PWR_REQ_POWERMODE		0x094
-#define UNIPRO_DME_PWR_REQ_LOCALL2TIMER0	0x098
-#define UNIPRO_DME_PWR_REQ_LOCALL2TIMER1	0x09C
-#define UNIPRO_DME_PWR_REQ_LOCALL2TIMER2	0x0A0
-#define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER0	0x0A4
-#define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER1	0x0A8
-#define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER2	0x0AC
-
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0

base-commit: 6012273897fefb12566580efedee10bb06e5e6ed
-- 
2.25.1

