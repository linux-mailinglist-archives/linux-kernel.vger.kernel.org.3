Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D95AF508
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIFTw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiIFTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC87FFB9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id90r024660;
        Tue, 6 Sep 2022 19:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x1PG8mwAB7xd3Yjc+aslFwuy5lw4nLRy3s499xqRwJE=;
 b=xFpMCvStjnShctz9EX3mj61WS2cXBmdYOlFaqgPGD1ItvqMBw7YB74wAbTnM+JkiM5rX
 r1zinHNU20GkEEv79kkT/TPSss12prpbmwgxn8Sqz2SpdF1ftzUd9gddzeCTrL5m07cM
 BhhMcAuZP/cJrymEPFJwieh1ix46W6SxwKsg7EptFpijlzItL/v7ZXUnlHQR2QaojU9e
 EBEYeOH870Q5b8gxWs4f1rCCmo1c1vBaxL5hMZBN1gr8nA+zyKv9zbHHZMtj9qKgsZIg
 SVaE+x7mqZ+W+JXnC/d5DDwjfcEQAtk7ExyZwEIt8//F2/opl1X7BS2iptHAXeQnBAng bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WS039711;
        Tue, 6 Sep 2022 19:49:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvF4D1xS8qAciSD2t7RY2p7x9a72ByhLTjbHcqMvKjojCULAd9EGQ06XN6IY3vBAbbBCjzK285GzMiKw6aUzLBkvtdjsENRIpn2p85G8O9fC2qPj3szzrOsY9ms9Iuy+UDxa/VirUD1P9NS/zp21x45EM7I85PRlfaUfhbjvG30a7C9o/1/Zcosj6zvO/q7ELvrMLPJjmAnBgLpFoHKymstJ2mDqq3RZDARd6bvGYbQffAC0/6eEeX42MPT6o9sFbGD6eH8TOV9CKNgZVieQe76B88U8LlOGrgkwYAIbNPfcVKXPewf3zbySMxNJZ7mynvmHEecnHmwRVidSj0sPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1PG8mwAB7xd3Yjc+aslFwuy5lw4nLRy3s499xqRwJE=;
 b=Hf7YrLMme0NzdcQ/G2VQsesFu2oyJMsCAR7C3omKvK9mqd8yO5bq4vPgi58888CaxviIg/uc1DTb0yt0sm3ZBZriz9V7KuvouCw3sMCoigJF8TDslliljSRDWMpSHcab1QQgTb3k1iKDu/qBjRxSaskWLslnXfojDTAa4wZvacrgcmLAptQwnIjwbiUtykwBJScWqS7vqVYp+Akgns4KlWxTt52pQ4qGMa79jsQVJRxHknK4Cft/FhEorFYRYaSp0YdcvecGsH1JRiCJxcLUQBvHgqIU2lRchC9wB3YaIs507OQ7yUcxSi94NOSGHV/RlC9f2TD0fWkSABTD6SG9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1PG8mwAB7xd3Yjc+aslFwuy5lw4nLRy3s499xqRwJE=;
 b=uzF6KBibaLIynso4vafLd/ODKllaB2MSRfjCmz1nFElmuNDFlgkAOoQ/GaRRP3L+fP3ceIypNovPp0EprvPLnyGVdgw1PtQAquB2FLl6hh/LB/hsDOpqUpaM3/X5TQVYt3mvzHiWpcNvcvA1GuHfs125bLATv7BHFiVytyxJ4bY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 38/70] optee: remove vma linked list walk
Thread-Topic: [PATCH v14 38/70] optee: remove vma linked list walk
Thread-Index: AQHYwimybpkPdOjfJEiVWqcHTsa6PA==
Date:   Tue, 6 Sep 2022 19:48:55 +0000
Message-ID: <20220906194824.2110408-39-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e7e59a-8a7b-427f-9741-08da9040eefe
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYiElD4FkGaQQqilVBZ03hmkkOVA4024esMkjRBjD6FYLJ4/YsnoMUUjoh/SU5f6DlVM7rWpOKUVhc0AvEgsYiNg7bRmMJn3RDQKFUl3f9YQKVR8afdnYjs6E1A2FMZ7DK4mRpOYcuiTNtHjUKoVNS5J7EeBjy/MCccCol6rbCHu/E+NFWXzcNjMpZaASKzLT1I/0nNkZf+Z1izqgKRxYiAGfDvmflhGkjC7Tn2MxoB3Q3fzkvb7Anfe8T9ugOziGE4Klr6WbR2MUFX60jZ94XFhWGpbYC6lGNsrO9p7PYV3Bxoduyi2alUIc/bM1ilVqWpTNRrM71AXD0IyrNdWYMLE2S8AbnMqORhEEdU0DLITNsfyo9FvP+arxlAUL0LgIEjXiEvBCws63s3PXEyEmBSwgzqHgbVgCeJN6JI6mbz9rBeiGmGftykwMqZaMZoz+g1klxE91qWme7hp6nAhlqoQE9gQEk4zEr79v2jZZVfwqdwWmHR2Ze0dt7cmXvPFGzIuxcLQ0xPhtV/Ab/3cx1DTWDZgCUqcAnrd3TclZaVxR9BpGADON5ehwdp9RtqFOodaR0L8M9I/qG9IOyOPa1yFlHUkVaW2ZQGEurXHN8PwxpDzlGLafrRiudHryoC5Mmg4U4CKn56i8us0SRN3z5s9P0YasB+CctlWP8E0BKIYMbMz/ey1G9iPnW6ww+sJnLF+eiP6iQN1EWeXpjRtB+H7HRYnrRDjkkU46bHAHoDGW3i+ftHD1AZ4ocSEmUwAdocZ3zzrp/Od4XDxlRo/Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aSFaEIvvCv125qyojZwH/4vL2+2R7KAn3KiJEos8recbzkzT71OHV9g9Cr?=
 =?iso-8859-1?Q?/F3OfvDO3Ppr4wpuizb220g13pFMoVchMwQruL+RB7YaYlIBp4d6piA+RN?=
 =?iso-8859-1?Q?vH/ya6jxfKykO6Cdh3AT5b1Sa2L4sLckzN+JJDArnrSaaI138/rs+MKfNE?=
 =?iso-8859-1?Q?X05N9ncSImPlxn8tg6bxf9j+de1aRAN5cugGOMGvVasSFwnCcXS+lCcabx?=
 =?iso-8859-1?Q?jUM4o7KCkVKXcSvd+32e4wHeXEb4abNluQzpuYIw9qb6oB5Esvo3HCxC72?=
 =?iso-8859-1?Q?LTwX0EFDdOtgPa4raH3kIFWkpw9jSHEc6aYcvUhr0NqrEernvxC1+GF3g2?=
 =?iso-8859-1?Q?YUT71nDeDUfIfJtDMAdpukAV42S/ESNca19rzlPBcdWrXhP+F8v5AJafOP?=
 =?iso-8859-1?Q?0ZsIhjKEyd7xDmwe7mZ2IuZrSKKrGKViEP8RGJJ6w8mbIgbTyLpFosDiil?=
 =?iso-8859-1?Q?yMqLu9L9bZLTFDgm4xDjLtoK524tEvm7ZwAhgz034x6lq8Yen5cFXePyUq?=
 =?iso-8859-1?Q?PakY1D/U+9fYQBJIsmmGpA5mcmzwhrxOd/nIIiKT+98WhxnoFuBPyMTv4z?=
 =?iso-8859-1?Q?mXAapwk/PjAHec0p/kM/j5E6LlJ95bAvZ9117wB0A8/VZzjnIExID2brbG?=
 =?iso-8859-1?Q?GegiNAgbgrJNH6zfakrsHAnt0+cgMGznV08wK0yeM1AQlhbI1XvI8fOV0C?=
 =?iso-8859-1?Q?VJt6hGt8RYWMzG3FmMHoI5vNQyVggc7i9O6CiombMCkCKUjwfjL2iq8UxH?=
 =?iso-8859-1?Q?0TzwxYmgbfX5wM3tE1xYHLtJPtHQAIQFrYBeEFz0MUQ/FmTwlg0//eZ6mB?=
 =?iso-8859-1?Q?7CpJCKt9UG8eqlEhi3pWyTc9okGu2jKXYG+qO/ZXqNUnbzDZwLIQZo8lhR?=
 =?iso-8859-1?Q?87+m9FN+qHvWE03J19Qn3GiLHyxkmVsHHkUy6MqQDMmZ/MngH+3HjPK+4O?=
 =?iso-8859-1?Q?n3/l0xaI+NyXodJ5YS7rGlYY7r4GEB+8Ui0pXWCercRmAJh/BFMaJUuroL?=
 =?iso-8859-1?Q?wAuDjJMr+baTWdwpy/9NOHxbzgARZ813jeNh70NETfZi8FreaQMX7HTlwk?=
 =?iso-8859-1?Q?3/k8EScOzOBiSgrLIuc+kAgZ+/BREX0wxKr5ZG2Jlp5mqgKHVg8vb2MKmj?=
 =?iso-8859-1?Q?1XyHgkzWzx9f+xzq8xAAnFcv/vpkduw8fwIEPh8jmue1r+XnOc1rcb2vjF?=
 =?iso-8859-1?Q?qvi4KRJDoin4RK9bASerSAW6JtP2NDk5IFugGNIMYojxXaq/JqfzWziksg?=
 =?iso-8859-1?Q?qy/M79S4JbJBntcQRsp9xh2UO5WFMSyoFnaWdOLJE18ZUkhImr+qC+2o/v?=
 =?iso-8859-1?Q?JnxMJpJF+eNbh393tUmwfZIy6osTASTsIYg2mEaC5vnVa/uf4VmuQqflzy?=
 =?iso-8859-1?Q?+NusS66kgfcHNB5vO9HZzIhCCUD1JbOFYFmYtrqUrhdv1vAsonVtSYbTbR?=
 =?iso-8859-1?Q?hP8QfKPDuORabE0DmICX+0MPedmkuCFeTU2INcALMtNNr2BDIEQ1FkbECU?=
 =?iso-8859-1?Q?KX/CnQPZ10fmyuFOnxekmri+QTncHi/HDLI/SoUdoqqaunb4BuUCqRfVHC?=
 =?iso-8859-1?Q?f1O/68inGuO4ErRZUBnpNlyINmoeN5eBP9xwCRRUpv/EnSYRL8C8xzUDyy?=
 =?iso-8859-1?Q?ZKgeOskSJImTD3NIe/CSsMd7/j/+YplkKVHX1KetWj24t9BLdZBqOI6Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7e59a-8a7b-427f-9741-08da9040eefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:55.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnaOgI3qE3yFIZO1iZlttikNRA38HwP2InhmcCVWlUkGvY91RAG+FeC2d7edY5eyYkxS76n0rmAGB2CS8ls5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: V3k-lmfXXmRBWoLuKTsPDXtd0pN5aJAO
X-Proofpoint-GUID: V3k-lmfXXmRBWoLuKTsPDXtd0pN5aJAO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 28f87cd8b3ed..290b1bb0e9cd 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -492,15 +492,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -516,8 +519,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
