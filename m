Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D5510184
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiDZPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352116AbiDZPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674721597AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2ba015530;
        Tue, 26 Apr 2022 15:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iB0Fr5lg6+1UlQU2ku885y+bw62h1kX7QFrIktA3g+E=;
 b=huXMb53ncB9h/0pYsVnzNVPtVOe5Nx8b5OXuba359MPmV2XAYXTqe/mt8wzRH3i2nx6f
 1zJS2YNWvH6EzTmJduuV6YVoLjNxoFxctQklRKtvXsiA0XroU0hpCR4YCCNxOtVuNre7
 Tf2kIpdIuTolVawLzz9ymyovYG8ovZ5+WdvzwlkKywCKMDFWaNiddwPHWhaCjhRVp0nv
 bGrKmq0DC/xCLTVVZO6Np70mH3ATQF2yWkuV1rnQIp9+OPInOPEL1Ol3vS1wuOwuQDjd
 k4BuBY/AaTKcDFpNcy30b66K5lewuuym3SVJkMeYGVNsKPLZENGGQkzPt1UWiVxynIzZ 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UST037884;
        Tue, 26 Apr 2022 15:07:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU3gaivQqmu4UM30pKiemf4zWqQsH/NONSIJm6c/AhKMlEQmc6chpLDs7uamJvEvzapaLIicUtDgMDr6OgEYJfh7I+LsoHyGuT5uddFkYwwNKXRLfM1TfyjtdKzKk23Vc+2hCWJYKh9jU1AEqQosKCXY0wQNvWlqzZvKXQ+9txOMh0V6Xw0rpIosDnSag3aaeYWFTkCQ/1mE4xKmYhl1VSq9HzpJeJwsiEAgDSZh6l8fRDGDgoKgHeHC5PFgdHrNWaCWMmES2y1XhORFUMRTBdvbEdS4otxoj9/Ogcxd7rpNWCLpC+Cv+VMEn1FpnxViMYeZqdWdVbxQsTXQIxy5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB0Fr5lg6+1UlQU2ku885y+bw62h1kX7QFrIktA3g+E=;
 b=Di/3Q/rBEl4h+gqvTBLQwwuHYPiRPtXwdNH4q8VvTtWM2aHZce2qZMXKpLvO0jBjR6S8ASYFKm93rysVlK89PR5F4FjSHRBreIgGq6dlHZvOWIWprKywxG9zDH695xa8vn7qqeXixmSVPPlK9fuoyM2TJI5Xb6vYxW9+Y5hlEKpacA2rSbd/HcZ9s9xeP24UJdTFJPAMioAj4A2MQnGToexC302Rd7bAG5mOtKNHR20Py8TJZo46X3obKNzOXgmVnfLyS/6iHL9KPd7O87sQwU7FQRjLcqBbD14pjQuHOHQhg9VyExTri2Ko7iPJ6Xyvhi4MUgtAAgqtXgNFDJenDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB0Fr5lg6+1UlQU2ku885y+bw62h1kX7QFrIktA3g+E=;
 b=tcVzEk+FqbNFYe6V8ykXmxxYxGdPia22Cg1DZ5PWzElYEIlip8hdKr75QTJjTHEX0PI9CjE7GpB3fEpDuxrQtruX3UYhtQWXSbqQWusf5f2c+wYw4NvrtSnGUpGjX0zF1FxcT9UsMcSeVtyx8ZpWHdZUdRKOZ2uitFCjX756yqM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 50/70] fork: use VMA iterator
Thread-Topic: [PATCH v8 50/70] fork: use VMA iterator
Thread-Index: AQHYWX8/WgwSZ5migky6MNEFtghL5A==
Date:   Tue, 26 Apr 2022 15:06:46 +0000
Message-ID: <20220426150616.3937571-51-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac948d5-3c89-4532-8aac-08da27967ba3
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377541A11C1A2111D8A29C1FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HeTsW64frphj54vht+DT1Wx2MLTTM1O5noM6HT5bwKw8z1BeYkhCjXVsTIFcqXiUEmI4z5dWG4ogIpB8IYb6zXMrU/ZiHIZE7hO5AQH5mJYp9cJ3JpY4tx9GXXu39r5VT07DLi1awCuRwDxhmPzKi8E6rilPb5wfra5MVbFYykLuGE5+kdjAT0sRX6a6O4NokUAebfPzGQGzPG6/NKEUnt8lcpwS0z/q+GjjD08PBBpLxXG9ueRvevEsqb4RVWuUGhd1SbpXtZfdiz1qgsoiwxuXKRb1ImSx9pF/cJJBTdXnwBeIxNpAbW9XkaB9lijq6DVvBgZrQx8IHizZf+p+baUnarwXVQnvPaiqcEc2Dzhwi4GgOaFY7DxeMgUB2CqriwanT+yuwBvWg8jynCjxmzI5s3Fsif/Kv6rGOLn5G6tR8RDeNZmkJjj92M5B/gruRRwYsnPF3WG0xUBm3Uv/6hwZ2XlH3kW9CxJPEEyEy2JFX4UWTC1PPk+gePPu3APDABeJ9q3dt84J6fPIupF/SwME7Jn/RN9aI9EcL6sSPDyuQuJwPypcU6gEOaQSJysWarDUpgpd/icp+oDielwQP+EcY1GU3GfiDjj7q4eCo7yBMiR8Bt3KP9FkvKPFnA6gqioD7H245vfMNQ+QpqAlaHDXChgMtD4eYvuQwHoB1CpajeFzq0b2ynkGtUdPVCIWuzX0UxJOFXwICV+BnhgSjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(4744005)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EUB6N3nXyjV8OK4igAv1BMkT4UeIsfG+Rti1HwoMYIYISM2pjeg5ak7zgp?=
 =?iso-8859-1?Q?9SR1mb0B9FceL5pEzOipysYA7HIPWC1cNrYXcijtZjsNhU7j4ej8WaRgVf?=
 =?iso-8859-1?Q?xnLbuleAGFhBIhpZmzgF+77s0uLUCMBJhS1oUWPZFu7erhZ+urC+4eIMX+?=
 =?iso-8859-1?Q?rl895ZGnGFk2TiJn/1PlwNPg3I8DpQuc3af4mbStad4p+vBOc+8+TqdIaI?=
 =?iso-8859-1?Q?PqCbBXeEcHJykMaQH2tENzUCc6kcv1drt8vgg8eAirfPcgJq8pCnJx/PGt?=
 =?iso-8859-1?Q?Dy1l9669wRebK41KW+E8ZyEjPYLDAzsrm2zf3cNbEFE9aUM3oU7qu0Zvra?=
 =?iso-8859-1?Q?+2p5vu+Sj9Da9tSYVNQQ7l092iHdRYWjVojVz9z98mo7Uwx1U2lVmfhQEp?=
 =?iso-8859-1?Q?jGvKBzjc2GvXW/FuiXp31ucRP+tghbGr5drsZk+SbsZ6CQMcEoZRGNYHvm?=
 =?iso-8859-1?Q?nOygQFvmbyAe6jhxuuN00BAnUke0zk8YUygCK1JaFlciAYasfTaoWPGGQd?=
 =?iso-8859-1?Q?HQcYA/T+w+1RFhn9dQKiTuFpSSe3pnwJuOE0KBh2MryEnZivsVVzyQ3vQ4?=
 =?iso-8859-1?Q?m1kNN5zE0hmrqtr4BA5IiGWDKMeOEw+Yge/zEnP2X26FukJSKCGPa7dnpj?=
 =?iso-8859-1?Q?Zxct/SV2U0JHdXfxPOldYMRhRURZB/ow/f4xUjDIxad588exL6xBc9HgFS?=
 =?iso-8859-1?Q?SWLiApstxRQ3Zro2z1iDGWul0Pu4XgUj7qIT9Z8uBJvnoZo3zXLTmYmjA5?=
 =?iso-8859-1?Q?5133iaYfA+fLxBDE7sQuhsbGRlVZVBtcJs0pSh8Z7hKhhOaWNU1+L2Qw9d?=
 =?iso-8859-1?Q?hTglji9M1RFvfhziAxB0azRhCsK4VD5RGIW77ACJesVhKZkfPg8tnWjDON?=
 =?iso-8859-1?Q?oZiYxk5NRXVnZh41xOvBk7ZpsxZUCbTDkbt0A+Ex3fN0OZJ3wadqdKTGGo?=
 =?iso-8859-1?Q?8OZnPrcORtauKzHxUgWZfUPXzU0gxJvjwfWLwEj4v67CmQDw5Z9zpsiGIx?=
 =?iso-8859-1?Q?BhY5l6hQ7mAW5UUt7uRP+N5Ybv2USksbyRw4M9gU0+Ikd1cLyot1HPiXgR?=
 =?iso-8859-1?Q?cJ1zNsKIYrXhM6mXQkm3eruuVzZXkoalWjwYoY7VqGm0+HqDGc3HgazEgr?=
 =?iso-8859-1?Q?YpT0z+5RSZJPIZcLafVg0y3Ha45TNbjrrWGwEAiYVyaq1Y3cV+qZyJImSa?=
 =?iso-8859-1?Q?n3YBo6vQEelhclAmPPdtfebartbzRuZa9ipWkToH+aBDLKRhGBY2lDMkQl?=
 =?iso-8859-1?Q?0WDWZUaMinc0SKGzOI/lsLqJM4T/KtYkrnHq9/dXZfgi9edn8H95N/V7gz?=
 =?iso-8859-1?Q?FcTh32ww+9x/WlLXhDjpHuTkU1tuf3uC4kFHvpapG5a0PMfLnPK3jlN3xw?=
 =?iso-8859-1?Q?qfxAjpup8NaCznbKma6gYMHXxyXUwc3/a1dqhjAWiWhlPVt8/ftdN8lszf?=
 =?iso-8859-1?Q?kmvbmhP23FtdHw/bUg6waHbAVEBneKgJbYwote4QLnV1ZiABJ/RrBKDA6+?=
 =?iso-8859-1?Q?tqYdwNt/25ibAutu6QaeoUgAN4P28uqW2YCkuSwQ7JrgFjifLszdOcOr1d?=
 =?iso-8859-1?Q?c85++9S2uvAoNUBJnUe4SUpnzQy05x1spcoovDmaGNBQW0k64+BjjTaMpl?=
 =?iso-8859-1?Q?xiV5SUHlxMmUWh3AXW7umLV9aA5BSeRPEnIR63o6UWrMe3fshEeZKiJv2j?=
 =?iso-8859-1?Q?L4baOZC+iMFaFE2nPeGiI8cI7rvBGaWa5opWantuVjPeIUJVlH0xAmTh+F?=
 =?iso-8859-1?Q?HPp6JUAl+FAP/6EpWgJ+2OXjPqn2+9ZkU82jIa9w71UPeJt3ZGfWcOskJK?=
 =?iso-8859-1?Q?IL3GU9S5yUEKBezV1Nspi+B2L6C1iyg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac948d5-3c89-4532-8aac-08da27967ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:46.7393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgcouWf+8QXH7MVp790JjWiXA0vXasqiGTvABkVDiUTB6UYId1TdJhfp3+ooGFa1a3g1MlCCgZWQCl4XzdG2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: CaJE0l_KHi41smCBPaNjMTnRQ8L2ZsNq
X-Proofpoint-GUID: CaJE0l_KHi41smCBPaNjMTnRQ8L2ZsNq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 20890be1371b..fa0ec0783784 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1288,13 +1288,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
