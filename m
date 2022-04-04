Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23D4F1759
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378343AbiDDOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378135AbiDDOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:41:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD88403DE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoQmB006381;
        Mon, 4 Apr 2022 14:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mQ8D2optmsg0wgvaWnxYU6TFL+oBNMYmwNGVOg5Ocnk=;
 b=mMQ24QiKO6wEDH6KCI0ZD917Bsz1s+W/KEsUXdjiB60TxaWCKv9iIkIE9s6Rh0BQeXjA
 Ok838iBl2/YTD0hdjQdyo/YMlHG3cK1OxW06poDk6i24ajV91L6KJUrh0rSWa9nXN4Bi
 wDvH9BbAaijfSrGptOLBK5FPBiIHpazbg/JyfJjJ5SJvyhVidnGSUZl6wCoZW6jlvwxf
 YXX6l/leH0FF3zP7kCufry+2yAXiWEn2S2nhZDDt+UxPrWmu2AUGQ4Db0eU2mlSQmGvJ
 7utM7ho0uPLsCvaZLZDuK1iBXUje3TXhnZHBB7KbpbP49hAQBJ0KkUFjG0A4jI2XY0Ru 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcea027671;
        Mon, 4 Apr 2022 14:36:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7iQkHgtQxSadFwDcmQ5AxAaXtwfYMEeGjjS9D+ERHYD/b9hnM70jYZbafLXItsAK8EkpLpwmnHN7xi4j5ZCzlVoH+UJMGr8j+66g9dC/OYTnKCYBrCqFaBUyPyFK0VnD7xIbkoi9iW4znzHTu1vOXmpifEC9P10RXI/yvIIgZuDQUc8meNeGd5Ncr6pQH1DeWHvLIubQdV0b1oTAEk9+/HbL1Ypiyeaq/GLN1nuYO6+BY88ZJov50GB2nfrFzNO42VN5DsBE0xM2z2DL6DL/LmZf9or+Dsgcca7wfmwe4c4du3xPthxTTzjc10jHM8dcNSS4UtZsSbfhQXStq3D3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ8D2optmsg0wgvaWnxYU6TFL+oBNMYmwNGVOg5Ocnk=;
 b=iSw59C70qYLGsoRdWV2X3koN7TsSDbes4fbFaXYfJdATsLMoyOw8gY31vo/jXTGND7Haqviqh5dM8thB9oPQjniclbmGNh6Gqq7jdErrfGG5y8LSenhs1TExFX0Ixb298uCkHcLGl7O5joaqrgqaAdXojpwNfjP7Jh8sxqsEt5W5oEM+VC7mHFAi39jinVxwqC2JsIW+2tVaS1TsVsz64dtt+HibptTcajVy+iXZIw5MmJeEmX3hdCpEVfDc2yDvVYjdT6t1ozjRW7fl5gp/WnksRlYooFYeG/r0UG+5W1/x+KNPypJ/Xy8yhWcxedjq1UJpIeSlpgoC+cji5z3Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ8D2optmsg0wgvaWnxYU6TFL+oBNMYmwNGVOg5Ocnk=;
 b=LGUXpNlR4ApEOmGplvS0N0EqEZY3Mx18PJiBYILoYvLDQRW0gNKdnY1PQNWw/ZsTvarVMN9oKrm/bM2tyUVZ0Ixr2FHUD/UVeAYOPdzijFOjrqj0Q26peBRBWr4p7zf69QXJIrrvuCTU3C8mQEcgugqSMWvg3128w4Rw/9mjrkE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 49/70] sched: Use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v7 49/70] sched: Use maple tree iterator to walk VMAs
Thread-Index: AQHYSDFJse0euuiiW0WUZm9rdM7K2w==
Date:   Mon, 4 Apr 2022 14:35:52 +0000
Message-ID: <20220404143501.2016403-50-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 062afb13-4035-42d0-b29b-08da16488075
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329C25F0DF3894BC15694DCFDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOqFWSfsbikzTeSEyNbAzetOVdqO+Ng8K0KZyi+j/YyCOh3REvez+i2fNSmh2hIZ4YagZIcaseU2qreJsqgWVb/7oxBkoimxp6Gl4tmyC9719kPmKBttn5TFnpWcC4IhSVVwKjg3tZziW4rmKFilmdcbsa2WH1PpMMW5f3yptxkijhlHPRrWqvjmQTt6DiyGuc6mgs0pWailAhQiJHPHleti2cAbFjqOml/mWo6mIbTHFyzI03IQUi6j2lUGEO4eHGuy4OcM/Kcr6xr4LCxZxQ8hC3Fz1fp/YwyOWGiQZZVK8fe6/GSo39E7UYMFKsiBpCgq+dfrKeojIB398IJ3ZeqreNPJC/IPAaNAi3B1tVttozFwCdOW087de0MBNmITgqe0vAYhW0LIEOn1lpEp9TrTNNIKl1bfTc6fI64wziq5ZFc3vFNoXOYZnaiNF/ccmIeokaNDdwqRMGHVLwl/VLXwGzbworZeD572uzYXDtxZXRD84aAt+HWGyk4sW5IdbDbwCz3YDz63HQC61qX+q96QVD7Tev1gXTQkcXAJzLRHa39vYEVl7LJR/kC0Zbxbt7K2UO1C5C+bMq/z09frrOQw7WnZd/6XIpc+4iuQiLyfaiOpLhrTKSgQgKwMj4OQmwjOdtV4GvyR90qF34eLtiZbY/8ayAQHlTGeLXWr9GJe2tFrirYI3kSDdqt5lCWgmD1EUsyohnnlqE4xZZBaww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MYg4V5GPYb6eiVwlfk3e9LY83tBernOYPhLUrUzsdMCMDZ1wvXnUlskmXH?=
 =?iso-8859-1?Q?TCjgr1V0oh9mci6Rl+8LUCPb9T/ZngvFCk22VW8PQh/LMTcZmFHhDtkHrb?=
 =?iso-8859-1?Q?lwIJisyAjIWIlGyB5KfSwPn3kBhqrjIAAdtCnwIgI9oZF5uWBeWQvzDJeB?=
 =?iso-8859-1?Q?Tt2Yq4JPospp8A++PZg1qq5SB10HQLn/shmJk+H9M439emMB2ni59qQnby?=
 =?iso-8859-1?Q?mNj0J34oBTWWiUME/BO2zrViq8y6t3XLGp+MtYqNHCqBzrvRwBn7g07WMY?=
 =?iso-8859-1?Q?aXB8LxoZzzGU5uY1zLjQU3U71Y9wjUU1l+IoHh62ih+sphGrNS2QLoUwK6?=
 =?iso-8859-1?Q?iZ/QLDrANM1RUDlKKW5dj9M4OQzz4MbK8m+CWoZz7ZrRoH5JYRPT7CQb33?=
 =?iso-8859-1?Q?EGOmJ+W+AOyBrNelsP7nKFJCSqa8jzE2EDGK32xpTU0pTRNja2nc+AT6Vs?=
 =?iso-8859-1?Q?acfY3/dwFBL6j9aYdGUyTtgcvpzvg25pIgQbss8uR4juRpps+GPqQvaFfv?=
 =?iso-8859-1?Q?YbT6nLPxizkd9MqnYiQC0rAHwXwDGP7WoU4U6GvtoIjoSY/t6cVmZ5wXVt?=
 =?iso-8859-1?Q?8OciKZ3aEJ3ozi62KiJlPIVb1qmy7/iTSDWJJnkj3AtCT4JCIW25Pj2spC?=
 =?iso-8859-1?Q?BN+gRupxrJGbcGNBKUIxO5OJBcLyWSgH1YPjIRoQcKMAWIH0w6q6IVDXMA?=
 =?iso-8859-1?Q?jhKma6GzaGwcBOp2e7M2j+BYhx2RLGgScyt50XDo6wUlHEFJK/664g2Wbp?=
 =?iso-8859-1?Q?T2x8QWdKfqcgFqR0hjMr4Bsf0o4u2YBcPrZ5FJD2mkc961dY/YaBPo6Yku?=
 =?iso-8859-1?Q?+8ONVP2kUD55l9949w5QlW6/r1eO1OIcEX1HyaVOPmL1vMoCeUUu/88Jn9?=
 =?iso-8859-1?Q?lUJ/Af6h+02gCBUga05Athp5Ptt2FfaeRcoRY9DZQ9t/qXxEcDzGFrzmYV?=
 =?iso-8859-1?Q?qAVSGV5DsSVJBfVvySGSuktc8CWTOW1S4Nq4jcnWTa574sm+n7lLKuBNKn?=
 =?iso-8859-1?Q?pQ2VFXIPbtHvVPYyRp2UNAmzHC6ELD8+NAI8OzN33Bz34DX51sdTDMv+TW?=
 =?iso-8859-1?Q?S8W1HKunqaq4fpPPiiB+vdCMosNstGIcuWDP1cDzIWyXAsdGpE1L8Gh6Eo?=
 =?iso-8859-1?Q?ddD9vIvxEqQBgtiZOENhjjEWL7sEA5JfS3kzhR78QQUbgwjOtYnRWUVFl2?=
 =?iso-8859-1?Q?SyQ7OWlJw2kP2W7PGOrSeNiwgnRD1JUQPA9c4Gfxidxo8aZjc1Q3M/uvIm?=
 =?iso-8859-1?Q?F/kfSf2PlZZXRHc2mOD0VQqpABAWvVOf4/TPfU1tk90NcBNwbjJFXLlNYu?=
 =?iso-8859-1?Q?c4M+qIp17sE1iMSxMX6obsvZgS0sKpaVJZhgRugekFXJyWHy0TNmW1tcCU?=
 =?iso-8859-1?Q?44nBaDhbCtd9YShnxrz7nHn6t/6ziRsikfqPaNbwq38o2wRfFyoy3wUCxq?=
 =?iso-8859-1?Q?REv/iawbJa8+EUsMxmqw1C7KHPqUDtDJq+Jkv3Pffj1W25oyZilrkfe1Pi?=
 =?iso-8859-1?Q?XktmixughntzfcTCs7mxLJGxXojTiv+Wevir1BcvPV0/hqO9y3jvZCgGxk?=
 =?iso-8859-1?Q?5cwCq50JUSnEz3qy1w0dXMrVw31J/jyOCSm1C8AdZ81wJYA93pwjwQFNo/?=
 =?iso-8859-1?Q?D8IUULIPQrW+BgYcWOVcVYNWEGGlps6awc0CccNlz9I7RxNicQlieh/kIB?=
 =?iso-8859-1?Q?ah6Xg/8gIPt/z92DsYFbS92V9Y4zqh+9qzt5ZgNMjyv4T7SaR5gsnU9hLY?=
 =?iso-8859-1?Q?fh+Ynj4LtxtrucARJ+4uRtwzS2SmEIpcTJWdtaBBS7MbldALwq1IhRXaPT?=
 =?iso-8859-1?Q?dNYqYzfdHimbx3hX2l/2qZCkdCwccYw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062afb13-4035-42d0-b29b-08da16488075
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:52.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdDacoF6atS/EyDR6wmrCt/P7ZLEQ1/nLhJQMdutwEl1o9gNJPk5h7QnNzmqHdCZqJUSkB984r/zqTL6y0GIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: _Pjgb6k2apC2u5hmtvXb8YN0NNcEVIWO
X-Proofpoint-ORIG-GUID: _Pjgb6k2apC2u5hmtvXb8YN0NNcEVIWO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The linked list is slower than walking the VMAs using the maple tree.
We can't use the VMA iterator here because it doesn't support
moving to an earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..b8b7962b5832 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2722,6 +2722,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2778,13 +2779,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.34.1
