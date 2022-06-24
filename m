Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B51559209
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiFXFah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFXFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:30:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687CF69254;
        Thu, 23 Jun 2022 22:30:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O4V81H031413;
        Fri, 24 Jun 2022 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=EL82Zw4UBGxixs4lmtljY461szm/7FMjbS04iXFcNFw=;
 b=BnClxTPy7XRX1lGuDijAKlsI9hTMZ+nNxCBqbda62Ldr/ClG3JUnUGL/JRk+O5aEIIfC
 XpIhJt8AOrdUhfN4XD6lJZN8IxBMCSlwk0qQ97qbyszHfFvtN0fBYniOlcp6kmmJ6OIY
 f8Cbb0OkAycCJn6wEAuAupmP5ZslAOI0IOxq+kB9NUEZTI0VUYZDMVHOt+/11Hpd4bIX
 K4hZiGdtoZq6CC5k5F476ghKhk8H/1iI5WKhnQTRUiPY1oxFiYGrF4eCog1ux9TPQZLO
 mnyQnANnl7LJabe0gGfAYfUeUfI8WEi9DMN9x2KxCI0pX4DQ19UXaynOyav5ERFp5uss gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u4uey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:30:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25O5A5OF010859;
        Fri, 24 Jun 2022 05:30:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfx8thn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxlf/wi0DpO6giM7QfIXxjSK8LPt/jBqFwl7+cAAqATTszat9aOiC0ZqkDMYKdaoBUl1a4U8ncCpfUctZ6XvuKH8UKhbb0sPnvD2Qce+4f+ffuGRXRv53xOcRcU3sPHiokIYNyrthZjDCvqcLcTpZLszPF5sc6LuaO0erylS0gfO2pzEO16rggwAnAN5D6fXFuKlj3qNEMvWWUzR8xF/JoiyEOLvVa4orsweGBDmUs3LMwrjL2dyenOb0eKkN1zcfjHdhsWrioneW8P+oaVcGH8LFqF5Ujj5laDf4PBZTWvi3Kj9EojDHrx0sa8QHgt6t9D+wAjrHg9bFcNSPlNFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL82Zw4UBGxixs4lmtljY461szm/7FMjbS04iXFcNFw=;
 b=STDVkF2hyspZbAXlnX+xXdXTNm8fPiMqaHia/u3ULKgqFvnUiE3YRyd88fQLJ52LTFG1E1lFtk01pVlJFOYV2FX4HGoicA65SSMULxs7n/s21wCIM25A4cPYgQ91D4qIevMtCO7PQA5HG7kep16HTjr8nwqMDU4t0WKV5aENbkjY3gVIV79k7T1fP03UqsWuPMoksYCS85YQybdZ9M16wGAdJLTgfcMwU+BUUc/caRBSVn/sw5IFyuKNpH7uTJLLjuaCYTtatYKbJDLWKVPKynx/VVAcxBOxzXPaA/ks8V93epRmbXFfx5Ji6rgcEZTD+cZYyHUsrMHC4m47++3IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL82Zw4UBGxixs4lmtljY461szm/7FMjbS04iXFcNFw=;
 b=tFRStAD/QSTYPPksmBRoo5pXmQr9TBsb+uyWhABvZeBNXGdeEayak0EwtGZJuWi4eNt3HN5NCZag5uGzGoPY7/2UO6whcisuMqcV9cexD20z1MVNj02iFSJrJJk7SKHAgQBCn6etFUjpnxH6biXqeIveu4hLAenU4rWzMHdgOH8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5646.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 24 Jun
 2022 05:30:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Fri, 24 Jun 2022
 05:30:15 +0000
Date:   Fri, 24 Jun 2022 08:30:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefani Seibold <stefani@seibold.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kfifo: fix kfifo_to_user() return type
Message-ID: <YrVL3OJVLlNhIMFs@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9365b50-3b12-415e-2a6a-08da55a29dbf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s/xCbcv1CSm21rTXoF8qmFkrEWOYoI1vsgYDWDnR1Oqzndh+CUzSefW4s+BeOfY9Kd7RWA0NGTOKfn1wLtRnDGcDT3FXm6eSBDwhi8ner2dvyNc6Me10f/KTSCqxvN6F3T63Ztpbs2B/30mppuUdzFoaVyxrA7GkzQMuLlitPqNUoA64vkhGX3QSCIo2YzBgzoPQc5VHggAilW8TMkuY8YTu9T2dveU2nMMFKzbmHfmNRpfh8NSc23lmnKmOTQ9in9VaSYb17OomzeugFjEMDNTR0Q4Ec5efQ1n+CODa92wcCvVF4RXGTcuBVP5P5oKT9ylZzzj11yW0B0EezZwUalKDvOHuo1XfB+pLYPUqS9INC7nTGZkfFY7qGm//VNMm+EABALafTtg72l/QLQEu/jRbjPBLBwrpr4JZBDQVZ2I/1ZnlI8Zx4MrLeWuxAISh0vp+XHREJbcK3hTkoDUO5W4Lyl36rU8mBgMkHitJJlW18qgaKdFIjiJn52oHKR73io+7EBVcw9dgiEUnXl6beMAyDdIIWXKrKTZx5xdoZTxwAntZLrbOJR8T0nZcAHdpY68iyu7CnGDul/tcN9Wa1EzwgCkSjEoBhpWjUsbHf7ZWmUV7WlzNLDCIUHY36iw3J95lHn13A+7HhvS+g34yEaJYC7pBb2Bb75Csa6+SbqaPiAae8zz6YoB6DtTAY7myHkwHF24knuJv/p3CZUTEM5lMGA6gqMwziMmVIAHpE2iMt5H2UTewq5esWQJnBb6/U8V+nQ4GUa3RM3zL16U9Bp0qSHnohK/WNcLKi4are8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(33716001)(6486002)(6506007)(2906002)(52116002)(478600001)(26005)(4326008)(86362001)(6512007)(8676002)(44832011)(5660300002)(9686003)(8936002)(6666004)(6916009)(41300700001)(186003)(316002)(66556008)(38350700002)(38100700002)(54906003)(66946007)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l7Zx+hMXLPKmNJtZJEJPd6fr+BHXSLx5IPbu42rPUIyzMF1Q1YyGQK5EUjGC?=
 =?us-ascii?Q?vFqlnZD66HylUoew5jn01JYKUak1NmtD31Yw1aRiTFjmIlssI7howJLl1KJJ?=
 =?us-ascii?Q?EwX17VztDZn/ESU/XbDaBAP81aQQSlW9J8WBCx1L63p8zGh/wqHGlniG+kBg?=
 =?us-ascii?Q?Axvk6iBMb3VzW/ku02ezUyd0YzYXoMGuexAvuqOFUyfXBzENVuMVt3LZEKe0?=
 =?us-ascii?Q?V2C3id32VWvbvBmf3SRpcr/5bBE1kIxUCqC3+v/OSAvx+HUfVf246cgDRkr0?=
 =?us-ascii?Q?bplmHfZIJA4pSV5vNoTrvSr4BMBlKjxGPtgbLWlUFIpDTbl34seke8DwWvCk?=
 =?us-ascii?Q?90CH38dxD2IXsHvBRSoELnoKAZOVxcLE1JjfPgTWiMp1tK/ctrDi1x6RdN6i?=
 =?us-ascii?Q?SW4xZ16+7iyJ/W0KVsm1uSERMR2HPuNSR/O70DOCHg+0nXBJyt4iDOAomvnq?=
 =?us-ascii?Q?iTbc+2NSvKgkPr/80AtJ/2n/GerTohah/X4t7U6Y1p6r+XAs0eaantjFtor9?=
 =?us-ascii?Q?3GvI0ewgsUOQLvcAmG3ZVdCxN+Vm2xKEdtrPDvLKv4Eov14g01YwgW97L0De?=
 =?us-ascii?Q?wP6TbhmK4wWOmGXHloWsP7I+6MJtS7OSn6jy/OoWlTeqNlYUSrqW793w0ObK?=
 =?us-ascii?Q?VKCH6JsG0KvfkIxxgI/qwODOnqINHJY48mXlcouMC+V7fYbIHJfXXNiZaDw4?=
 =?us-ascii?Q?Jx09eyOyai9lHRY9bkP6XvWwuYcgeciLnyhYwWY/kOyAdn9CGgiL77lWh3It?=
 =?us-ascii?Q?C2lLP8IUisI3FpxLpDnqwSEWsfALPNsQyfOjg9FLD/K4/9oZqPClNyRrP8jq?=
 =?us-ascii?Q?1cj+enWv0lmDQLh94sc5ek45/vaSN6FfsF++HWXFzcYi7CU1+H3XDvzU0sb8?=
 =?us-ascii?Q?XHeKuogydoSglzS72cn6ONIfZVpEmX5r/NbTBqCwc/yc2UOAYZNCd4Wu2Ack?=
 =?us-ascii?Q?ZArorm3D3A4MMvR9tFU/3+KiF3bUU4ZgsX8O/KPruP207lC/rZTWrGeOR0bd?=
 =?us-ascii?Q?TnkloT4qiAe0TTGeVQLZGI2FrZnK34JPRyjwsVmbUXGCiQXwjCLzXh9os8Gf?=
 =?us-ascii?Q?AEmCJbAI3etseF3wZDsg2G90TzVZkUNX28dXAovS4b/V9p12L9JgPs1mYOOk?=
 =?us-ascii?Q?j0a/SWeb190neNT4YpSllvFaiBFhHoSu51Z9xNsxfJorhLCHmvsIpJY+rqE3?=
 =?us-ascii?Q?wptrQcAoCVIsntbbTnSv50RwMS4eZiclhDbvjJ5QSA+EgIRLcUyrehIP+z42?=
 =?us-ascii?Q?uRGtGqM7YE9xrAcY4ahvRdfTdfzI9tcjLjZ1uRU04LlcnazjBIKPySi4vuJP?=
 =?us-ascii?Q?i0ucNxOp1XKZMcs1ez8V0RfL7RwzA2/00OMnWxaZGcldkbCgVeYyO++sdMEy?=
 =?us-ascii?Q?7KdzUxkPxUtE3ZaVONGB3RebSejc+dnYI0XO703f/SNTeOGy7TROkNba73eP?=
 =?us-ascii?Q?s+TillkYeWpHcehqOAQhb/WXLjZ1o8PpX5J/Js7l/1ka2klInCYY5jbKSN7L?=
 =?us-ascii?Q?C+hcLm6ZWynT+Gg1eHo7m/AXrgdqoGg8vQ2SqBwhjadDMlXJvymDY4fixNvI?=
 =?us-ascii?Q?eb+NiRr+mQZ7n2J/9t2IbL8aCd0QZuYo868/okXMyngmXcdYb0x2ws8zrzhV?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9365b50-3b12-415e-2a6a-08da55a29dbf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 05:30:14.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P24WKDXtwc9AyGTozwmi6IQA3tkNe2kS8nyk2DgZEvISMmf56YWDCX4vUi131MWX4QQvN0+0EqVfPjtviB2pBHDHmgHyykFhtfb14jQJqp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_03:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240019
X-Proofpoint-GUID: RG2ZkcXX-YokKEZp-brpJUmervNVpi-M
X-Proofpoint-ORIG-GUID: RG2ZkcXX-YokKEZp-brpJUmervNVpi-M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfifo_to_user() macro is supposed to return zero for success or
negative error codes.  Unfortunately, there is a signedness bug so
it returns unsigned int.  This only affects callers which try to
save the result in ssize_t and as far as I can see the only place which
does that is line6_hwdep_read().

TL;DR: s/_uint/_int/.

Fixes: 144ecf310eb5 ("kfifo: fix kfifo_alloc() to return a signed int value")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 include/linux/kfifo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 86249476b57f..0b35a41440ff 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -688,7 +688,7 @@ __kfifo_uint_must_check_helper( \
  * writer, you don't need extra locking to use these macro.
  */
 #define	kfifo_to_user(fifo, to, len, copied) \
-__kfifo_uint_must_check_helper( \
+__kfifo_int_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	void __user *__to = (to); \
-- 
2.35.1

