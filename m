Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6F57ADE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiGTCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbiGTCXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C47098E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1VWv2002405;
        Wed, 20 Jul 2022 02:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=LxrQr6xopuG/6Lhie0F6sSZKW8sgQpecMYYc/jDF4uC51k/8r93oOLkzcsklGVlIlCCB
 krBzspQCZYqJgdgxZjAdOdAveA9Gw8ZRRfGNzY0nmhCcPe3YYhxYIt0+o/L+LV60xiqh
 BP53sCxFHOT1s+rEKEkUmnH5eacPGPaQ9elMqP6oGjEH8RzOwPTPNFMXwX34MGXCRrTR
 zIGaEG42e0lVW+6yGb6K82rYXlunGlQVZugFMFTVgW0DA5KmUW9EDxxQpvH19GbXxbka
 W0Y0I9Uiao3zNGgseVaZCVCYNTDoipMeHPdzIuMiIQ5NcG9hXsU97KtM+vli1LKACDgm Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNeDsP022213;
        Wed, 20 Jul 2022 02:19:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseb6k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGQAnqFd2BjXe5ax239n90mnMRyr4KCKeSGty53Vg4Zu7K1BoKRhyZCOgvw9H6JmCtmb8mBbgsLOdB0VNc9BIdqNTztPga2L/lgB1vf9JlBkTkFWHtkXDUdsS9kmTbZH38aq1qU4bid0s6f7WWsZTy3DSrA9k75nWw6i3fHJbql4b66qTVC0StQeTai17np9MD6/AMLxHurXTkI/LRb+wHXMSC1f39pAybmZ/RVzSvHeP6FBd/aKaDbvSTxpODxu11j0sV4WMiJ4QD7ip8XkZvnM4m4BZHPBHQNWcAuuB+IG/v6FbgITdCh3Ic6bYgQMHHTygFSg+wRIJabPU1XMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=WVzyYLVbrJqo6+is208fatmR3T8XJEA6H7OYuQSUkkjMPnfmQKEW6sQFHBcEIOTbQpY3oY39/hY8Zm+lZi5Vmfo6TkWbdQOvTHudUqJ0+D7uvPJX4k0dtsRo3GOsbSb9ttc9ftYEgstrNjqhmz8f+CEyFf1lZodEN8030v03oG49ftoxp52EMpa5/GSwNWRHWgOystncZJHYlV9PXgAPgra+UjmG/PbZ4M6G6fY+oFCF9cybPYiXieTGAa1pduH+dar8dBf1t53BRbGeJ6rcv1BmIZ2hJdFIxaEsjEPiKfD4guLhAtvKnsmPM7r6fery+FWjMhDOHkDd/RvPtkG/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=a12KwelkYY6+3fSg6+Y6jihzJn/3HHwzTGE5Vrtxuiyfb/v0pHMrT99p/7XfP5lH4zDEj3NEH+8d3GwQSXdb+nwQbO6TbekahKaoL9J4xPwtwQ4F6eTeYH2ZtfQGv7AaShHsPxHDcXZmTujAA2GKQAz9zNbNjpWehREGJ6HQwYs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:19:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 62/69] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v12 62/69] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYm97wybvu17HwNUe33mefJje+tg==
Date:   Wed, 20 Jul 2022 02:18:02 +0000
Message-ID: <20220720021727.17018-63-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66b25102-adb6-4026-5bf9-08da69f63e98
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00wCs++hy1ofD4xmZwLJyWMk2zz86zeJy1rI7i+/gsckir6qawSlU+KRV13eL5NhRogVOT8ILTwPIih5g62XknbNmkQ1WZFcV0EdLGm+erc6+0y4mbHU5yTwMIHAZbqy0+LIC+kqcnLriIDSxPdwJAlxIH9Oog7DoWiDY72udFHumyrTkEI+Li2gAW9hbWg6TEIMg8lPoCS2Fxpw6CYTtHOKFc6xZPC3J2TCq67jzCXxYCR9zsYVs2+jjb0SX24m1iGy5LUzjrbG3JyE3S57j2ppHvcLyjHl8MtySnznnfuqtBBvW573he8JLuBysKRVTnN7JsA8NJJaWAsAqqSzXkZJRidorbwYuewkJfC5F9yIKRzbPUN73oiP/KryPprQ4yk0irPp+tzjTTqIjkGTU84HU5oesGWIqkhtTpplAgTXfYZXg3UTBeGfK8oz96NY7EQkmaWm1b3ZUMEOMQJ1Q1eyFQ2Zk3Y7FlZMmjrjS2wt5+/mH9pUKkwfxNcSQiUEP1nOgrYrIwGyp6SejbV0/p2ivuWCP+W+Jzs0EFIxhco7Zu2Ndbhfh7O8bZqzcTI+FELXioFGHEu2vr8icmb7nQExLwQdfIBgVo27MZnJP2Ka7ZPgbXtm5E0ZKIIIT10Arn8t9psfraMmXlbjLnjvZ/4VkaGCTpg/iVkVh3XFF6VFhVEiFVhJ5HD0xW0dFPCWVfrOmKBQjsbaAcAT33Sp63VRC5XLCT0jfLnO7Tfl54aT4CMCtOLxD9YMzNf4ynQOguxtka0WNvcdF+2MUBIc6/engJawOZgOo0LCoRBDM9nQ06ztSlQPloVALRPiVJd+T768FCcHrubKo5X/L319nBBiDF+595gNLVvHb8/3bg7fIJ22t/ypu6oljrvPR7Ct
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(4744005)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9mmdyxpwkymo1FG+hmN/Yktfk6p6AlHA71FZapgLkWTeqpVj70mOBo3sD0?=
 =?iso-8859-1?Q?QTbc/2qUD69T5UBk2yvf8PnxE+ka7/ing1o8Xwbh2w+WCKHNm7/Qeoo1XJ?=
 =?iso-8859-1?Q?9dSnH/d5ODuF/kuT9h/khZ9ZX1hj7/Ybz3+ra9ukXUZeIuS2oum0PnW2xv?=
 =?iso-8859-1?Q?Lk5gSyj+tpQSK6qZy4h0S3qVByIVl9aFWydzg9v7m2tLMT+lYH49OifLlH?=
 =?iso-8859-1?Q?SVNaZXTLnwCbFOpec1PnfP5bJ2QLl/pfcSuUz+Kthp0o6DB1yQcJHttS6m?=
 =?iso-8859-1?Q?JtegD5Ri4Ibm315Iw79Z25GgwoeYIrduWGuIY+ORuY070Xb0t+UNEj4yDb?=
 =?iso-8859-1?Q?wfFFSlGmEJo7RDQLVxfqO7f0w8oHSSwNN7Bd3MfojJ7MZwiBUpoRg829C2?=
 =?iso-8859-1?Q?C/0t8/dGpEEgnW2SDs1M+TQl1KQ6AxdpX1K+mWe47w9JyCFxsFCRIUvAUT?=
 =?iso-8859-1?Q?a2bsK/hsGtVrgKrkpcq6FFCbB1aMtV+qV72H/29/+o1kdvTOgYuOHOqkgJ?=
 =?iso-8859-1?Q?XBO0JHPy3kL4pGyzE3bhiRa5JVoNIFz/VAz2YLEDyd5kNnIomZwW3ZZVLi?=
 =?iso-8859-1?Q?wGhLK7sNmksOcL/n6QbQFuY7ThZEQ/fkoKRmG7+BoC6wri+hsazXIiA/Ts?=
 =?iso-8859-1?Q?g+hx1JE4+8Jx6LwicvB4m5OA0sK6XP06gLOTyD1eqMDGt9hAx7xswU76ho?=
 =?iso-8859-1?Q?CDgD3+eBpGynRWqfFyGZjhqVHk4JFKYGQsxBeDoCa1ugdHHrwNvEOlp9ve?=
 =?iso-8859-1?Q?pbpwE/NNAjKVfkSkShoU4Bwg2Hj8Ax8VlkJaeUfzwBUsxl9CShiAIAAl/d?=
 =?iso-8859-1?Q?2e+dLwnwY3bJP8HTSxNDRTC2/jku6kWcEmXGM0MVRQ23hwV4KVsL2IbiSN?=
 =?iso-8859-1?Q?p2xzQUmFD4Y5lvmPtkCJUNKAYJDx/BkYisVFjygURtYGQ29zWk54icfhbu?=
 =?iso-8859-1?Q?CBHnamS5eqRq4833NLYvdGgXsirdutZWRfBdjFyqpR3Q+P6X8yWqlNnhhu?=
 =?iso-8859-1?Q?1fsgVLz2snxnfPnDa/+rrYEvuaCCDRD9s0ihnTgFjxfJCk9SDuqobsRPCJ?=
 =?iso-8859-1?Q?zYtckc5VpQv3aEXQykoREsF1c2R0TWViDqF+2cFVg1AFxSZrQj9ikf9Bjx?=
 =?iso-8859-1?Q?U9xo7I4S3bWMtgEzskyzIsAtPtRxAWLb1YOxHYzHBOqckXCqJFeofDks6W?=
 =?iso-8859-1?Q?Ehoi7uXh6k8HwQnoksNEWyHzNs39OYhmDfslZIGb8ij5X+N33/XJ85gXMW?=
 =?iso-8859-1?Q?xZ2rwNZx3jNcn7bnvw98n4/rPMzVIqiCkzJFVKe1vF0iU6CANf/wST7IrF?=
 =?iso-8859-1?Q?gAJSd80QDVM/y/6f+i70bi+YPCmFMvbuVndUiWHVw12bgICY4TO74jPWRo?=
 =?iso-8859-1?Q?mezIYSkk232D5TpojVi1Sz9Al/I2BtCR5SvRr1EldcNzuqXwAGoqa/AbFW?=
 =?iso-8859-1?Q?cRfnxHJXz6rzUSXvgwi4fxrN3BUkV7GtnNWMV95fBZnMUi4NWFOnI6clHj?=
 =?iso-8859-1?Q?nhosqH6oLXorDNaqGIzfpraT94GQThyqNxFJhZtyJxM8QBXRpZPzutVe0u?=
 =?iso-8859-1?Q?1DD9ANfMsUHcSeke51+88yRe9mRP14lH8GTs+PxkidyGqWoxZ/bfwvijLE?=
 =?iso-8859-1?Q?oXZZKzG9yEAXqZ9wS55inKH/ncffBYIm7Cv6gfQorxy9hMsNorF/aHMQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b25102-adb6-4026-5bf9-08da69f63e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:02.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDyC3llogP7huIcnO5+gR8ls1vn9NlBef8746DXzBKhdfoLoJy0jZhMHYrIhMQ5DyM968zwDKjxnwZH2ts89Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: A1-FRXihMrBJPL3C9GKBVwOXsAKm8G9P
X-Proofpoint-GUID: A1-FRXihMrBJPL3C9GKBVwOXsAKm8G9P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Link: https://lkml.kernel.org/r/20220504011345.662299-47-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-63-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
