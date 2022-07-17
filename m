Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6157733E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGQCtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGQCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D391A3B3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8e2M009395;
        Sun, 17 Jul 2022 02:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XJDN4g53VbICcGsuzm/hXgUbeDxgCW8Xd0dWdD5biwg=;
 b=X7+mRm68dgd7rXDxZv0C040sJviHq7ZAdKOI2CXv2eFfi8a5V6WBMN5mBOT5UoqGFC1B
 pCZwP88IGYo9EUdcXLJl9sYEBcRS0jtI00MtI3bdSoABoq1mrsQscjdnYCpqVtQXCTJ2
 9bPfUP55cQ2eCueSD1yDCcDOn9zdcMCtdwYl/K51AiOIDgHQWmqeXvFrkaHJRbGmUwLT
 za2bi3q6VP9DbIF/25YZRmlrkTehsHfwgmJUQtS9uShZn+rN1XgZ8JePAn1p2Yn4Ap+w
 1TzOotrv+rdfiuX/4T4KOAMDZBBvN9IXfUM7q73zMbapYdbSYdbPCFX8AduHh31t2Xk4 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38h005941;
        Sun, 17 Jul 2022 02:46:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhLFh5Hred9JF/4lArx1pz2iRWgBBw3Uf8nFbdunAuQ3yu23RHbhK13SUqlolxJh6+pCuh+pLDtj5bvs/uStAxt7zJDg+9Fan0ADESTuJ1eDW4aG1FZ+ZxA999khkVtge0IDQ48QVHB4bJ9fGcDVDXhEX0mylofyO+w4Y8ZjsSefeiXtnnjMRCjr7Nz68Q/9NhG+dc9v5AX2+8H69l7vXlUgQsPj4qAWdFtx4aa+19FN1OcE1utFXkAELbdCgsdWnBlkfUeKIHHkcIk7KLyLktPpZe/pgbAHgtpGhuwebVK+TVZa0PRKvIpm3VEFI3HCAFkFwJrfMD1I5g8HL2eRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJDN4g53VbICcGsuzm/hXgUbeDxgCW8Xd0dWdD5biwg=;
 b=lusg2Yqq0um+DqLNJXEvOSTLGsLLqHYN8X/MaLlogScG+Wp9SR3KRfTBSuVCp3hIxU5Rb9pGfkRsKUSfFC/CR14YoVxN7WFxkXTBcmf5ZEOl4MArMZ7PaF+CHM9oiA/zuE+1co2QU8SQr5N8gkpP3QX5cXeQQdJzpba0fGrP6bcd1C1bzuqTfyTn1ipCjTtR10n6zE4a+vFBEH0vqBwUtioBddkrUedil26L+QmBHJbnb2s20w5bgWeRQHflufFAH8Fk77Appv27qPOtsTt66sCSq4xsy64EeSV8qr/vwZT2WjNqVSfLE4LC48C8Hj5pttFecnLHq2u9/P2ykDH1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJDN4g53VbICcGsuzm/hXgUbeDxgCW8Xd0dWdD5biwg=;
 b=sjbTClQQ9wV90GQGb96ZoRXQ14ZYiHAjFE8OfQ/NQu9UinWk/Y+N26Yr4jkYFvcPkzSvm+DFcQxQiOZabThOCMhUEQMHQUTlfZw6jYtjLkIpYUzmuoITVRbJ9kDCrJZa5eQuc7zyvJLsQ9CF66EZYFAEr1Ddq/poPY8Q3skWUWk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v11 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYmYd0JvVjCNTkMESmyJSstW8RBw==
Date:   Sun, 17 Jul 2022 02:46:46 +0000
Message-ID: <20220717024615.2106835-29-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d7511a1-d79f-4cbe-831f-08da679e9a64
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+6t2qyslMHOYugDMyWzCDDn5vmnPAVKjYPJuVKbmn3W8C7LubVfeeaXWUYxw6VjK+NXqtgIVGDxwaSbcQ3ja9VC9jYSCVxkQ8OFNSihwLOWgocmajx6jO7SdNugvrTkeo//1RL1dEKAj/Jx5jznOHVVVB4PVyx//4ix7yYr7kTCaNP8TbPClKDfmWZntZGBesTR46646R27Y6h+j+go/+b3h7QZbIZnvFgzYwsd0VrNRjB9GznTEPN2ikwKekd0ywhT5LucECUoswU5vyS6WlTXPNWrIxoVRoQU73v3eVl9diaMs8BOp6ZfZcFop84uPuJf1eOHUfeoZFUiZPKwc/K4BQtHlttzZY4Nf+4m9L+MNecJNPE7sYeHNa4yE1mxk0V3qExY6AZkdHoktDhxp4LtUSHll5VJ3xrzfOxGM2aoBL6abP+68IaBQNYKn4Z4EgsIQEgX+zwZVh7bq7mkSY8vs/jg/5yfrRk6WKz3uDM2oBk6MmQ6eNukOsUadHy6zXQkJRqQLn0jUKb3ygIJWXFfyIlE/NdRHrRS46vcZu9f3M3SWHgFvHeusvVA4ilG7j4w2zKeElI0f7/6Z/IOZQ3KDAujaTC9pUSwiB3wYbxaFFVOWIcx7GvaHY1834AiO7Z8F46LIN4HnK7JLjZT9Bzv3Un22PQ9KMNb8+mTPnhvdbQY/ak2qu++ICZSQxIbFhC5EJXeLXLisBHHjNBXvNiCbt/DVt3Uf8xwEzxuswYMloGKxOPw9YgiaZTrN62LQuv5zqOhm1qkMLsyDLDGhGRnMitFqUKwqQIIdmb4aDxjFJvoLpF8BUmkCMwllJ6JtQ2zHQhehYP/mXtAKN/igSRdUSpFqDq2difXEZFVo5z9BMGIIYAyvg5HrJvxJp2J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ITaXayQfibPueMdeghV5Fho/YYSjJGX6nrNtX7rCnP8sXeMxwbellOJRKg?=
 =?iso-8859-1?Q?WeGiPZ9QaO6tloTNa2Eqap/mIomvfIzjCpQpmHOg3c2PEk1CimfwUVA2hE?=
 =?iso-8859-1?Q?cC4yqJSJmbRSPds1D/S3jKqCa5Phhm9+Ltw2Jc8e6ygC5A4bJZxDkvkkaQ?=
 =?iso-8859-1?Q?1e521/HsLWXmYTmCEe/LKOKdMHPGMPIjI/5aTTReoUiXsAzYFLiI2DBwsK?=
 =?iso-8859-1?Q?lepC9YJpG90LwpaeRlXmCpRDELFXfa+ufzYSvZkO93LJ4ViKebwbbmLCiA?=
 =?iso-8859-1?Q?bXAnNbuvpULTEuWwqgK5mjyHZc+gxp2MlhD2BR6vnuTq6iwPCainhIoVgr?=
 =?iso-8859-1?Q?aHLNReT4yblhFX+K47X7q8W2tqFAwmVwMxys9Ib0ITeTGopKmlO7BVuki1?=
 =?iso-8859-1?Q?fv0QZwtXyrGsPs43DPYdwbXPhdfQOSkuvFq8qAkx6XIS59+rMp1orDuOO0?=
 =?iso-8859-1?Q?s4lwxfzheBEFpp+Xh2Xyhdk9Usfnuwer2EIS7Fl5+i01iwkr8KWHcBCl7t?=
 =?iso-8859-1?Q?KyIIvfXXfN/kUQOWIkTSTfsnzCXSzGwcS8iOvbt9k8iqWBoUW6Ixt75QeW?=
 =?iso-8859-1?Q?QRgEJgtc65NSYAmScZb77N+1eE+h/LcPgI2pnV5quuNecip4PzrhZ/qvVs?=
 =?iso-8859-1?Q?gwEp3aWnwp0OrKt4VK9z+F/DZp+6ZyFUh3J09iXr3qYlcEDXWg/0RJYPcN?=
 =?iso-8859-1?Q?Hrl5sUvfnyuK+nXBUC2o5WIGFdX5HL7swU0tGLTI4GQYdcv+lks7c+aLFg?=
 =?iso-8859-1?Q?YhhLwa7L6vUPXd3NWevseXB72gXHremx+1dVuVPNr+9oFMJAD6PVjFZQET?=
 =?iso-8859-1?Q?dYiAUBgCq1+FKvbmbowCvNSKj2f7zAgl77IHfl6D/+A+fgamONDcmvfUug?=
 =?iso-8859-1?Q?FtVXMxdFlQA1J2aLyKrZp4zOgCeLtwKpGrvqvStk1cngGlmXQLXFu3K/yp?=
 =?iso-8859-1?Q?OEjEo+5fh4dp7w4B/HxT7ABG7JB1jQ5YykphPVmBe1LD6epiHdJtStW3r6?=
 =?iso-8859-1?Q?sYnRQT61/+pVgW/xLIbemiF/kwjwg2gtH52sWdcZ82J+GR+bTIy6wias5g?=
 =?iso-8859-1?Q?UyiymhjWi1nrnj+DrXrSEP8Odms3NxQpEqKmNBCA8ahnVe0FwVA7yYGTQw?=
 =?iso-8859-1?Q?qKaNDS95qDlCaFdqOqPHy3QBdsAruKRuXT6xsBGdDPXpg0mYcp1dTwV6HN?=
 =?iso-8859-1?Q?cpiP8EVUT26iD8ND3YFGLJhW0fCEfbKQrvzT0umtov0A6grJDxEqPbBJYX?=
 =?iso-8859-1?Q?a24ABVcDBWxIvhoPhY6mztmkqB3R1bIpNBrR40cvE1UJUsaIMOMHIVyRCp?=
 =?iso-8859-1?Q?ef9ASl9wHslShR5IYqYAgIq9A71TSyKdhIKbuLtWm8m03nuoW1DV9Jn11n?=
 =?iso-8859-1?Q?S1Xmu4qibasV1yw5BO8ag6qNR6bd4IUX+YjAl4QvhLTZZ/a6igw+ol7c/Y?=
 =?iso-8859-1?Q?1oMmGfdKkg3Vys09uxoF7gD3V6XMBPARUPihVHwGDz7BPSHv5aNyihaE9g?=
 =?iso-8859-1?Q?b9CKeiy4kIFKUO1z1B2wQpPbMpb2y5IHT6qkYiMDj4ZxEZ+sCzezfuTl+h?=
 =?iso-8859-1?Q?p1p9JYGNHVA6Xq2+5nJpZSSUuyKHdq4cw/2Xr56bs9g5BA64qfMFwQSU6Q?=
 =?iso-8859-1?Q?ZJ4JxMGD0KgUvDk7QpOPe2yaTRsMBb79dnl/ByFsRTA6MO6acJg1/r0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7511a1-d79f-4cbe-831f-08da679e9a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:46.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWy2Zg2DuhevLu3GYemS+zbhSNh63shB8s3aQZEfa6DakHECgjP9kfMm8omXw/P37WD9IhscXucWucqjr7zAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: 6xqlXcUCCgHl5LAjOFwHLolK5Uen5WAH
X-Proofpoint-ORIG-GUID: 6xqlXcUCCgHl5LAjOFwHLolK5Uen5WAH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-13-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-29-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 231 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 95 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a250fd86fde9..75ac5664af69 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2724,8 +2724,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 582597391899..7f5301ed0213 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2415,47 +2415,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2535,40 +2494,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2589,17 +2559,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2612,16 +2596,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2635,14 +2649,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2676,7 +2739,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2896,11 +2959,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -3035,10 +3099,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3225,9 +3286,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0..e0fba9004246 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.35.1
