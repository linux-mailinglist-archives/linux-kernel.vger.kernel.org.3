Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B400351934F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiEDBSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiEDBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE532B75
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7fe030616;
        Wed, 4 May 2022 01:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D8VHAXCDBNr0RFlC0KBVEEX+3S3/yCzOBs8oidqFoJA=;
 b=RkMoQBbIwtBu0X1JOZqtZwY5geVmjGzVQROqtoh4f3N0aMG1dwn0BbG1ZzOBLf3W9s2k
 a3Yk9zVjMX6J50dYyGhWLQBmLaiUQnure0MPVOnp2QihmlRxVOyNZAL6dE1/+f6ooj+b
 w0ebt/6DoZTr51CZWffZsrjjf14UqPQZJtVZS2OhtjQiEhtJrjzr6JSbtqxNNwwrxk2h
 8UZaKVtvRkqobgaDAyeB62AfNyXNlprMNfw9qcOTDm8yNk0F2MM+GTIx0G22+KQb5dk4
 hthOXg1v9cn0p/Ry+OMVnguW0H/Xp19km7GXSYCyJ/uDzlEl843pePPEvSTboQk1A6px fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f60q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJV013094;
        Wed, 4 May 2022 01:13:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6YYiZzz31c2N1JKIte+CZZnvaNxBJrc+NeBBKxyPzmw0+c+4KMew9kn5U2Cim240Hdw4mNaV+bT4w9ZKnJuS2fXxkf4GTMdfmrGOF0sCUcvuzMyPE6akXzxknUsandexM1o5/ndkJyQhe8am2VQ+RVB8Vaj8v6SkYdiAJc89JFVSN0BhZwCs2JeqPHsaIh6ROGlXNwEdtgPeBfB6KZiEEfuEhO+ZaksxXFZ8mm00JL8yCFFAfGWBSzyy44BlHJ5FSU2eoM0MuR/tLxaHRAybOdHmep2J9sILgEHsyOjGvjLWH2Qv2pJQ6PnRx0H6HN5c7LwE9cb8LdHq+5Zg9Rm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8VHAXCDBNr0RFlC0KBVEEX+3S3/yCzOBs8oidqFoJA=;
 b=a7dRB28uub7JFtg9rXvcXmlg3bpjsJbTAFUcdxfwAsUcPQ1KaBaPvmFAV8MYXjyNbgB5KamLiILJfRjmOzAsc63FpJqw6D8IOn9dJi+FtUjZVtQb62Ty/Kek68lUTpJZvjBJMXyxBkpqWEoekLLDsg9y4gqIQQU6xMcKjl3ijAC/3rIBfHFNClTBu3OUqwyi8BROzX5KQbCri6WjCc6tA4owPPg30/Fobz5TCkIVcoY1AlTpx4gd9WMYx+CciW4kka5Ps2nAET+4bsSYEydu+r+W/A/zgd47x5KwsYpPn+zI1IGMDSkObs3S0GA/3Ho0W6zkT4WAUbj4NleK6osVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8VHAXCDBNr0RFlC0KBVEEX+3S3/yCzOBs8oidqFoJA=;
 b=XZnwxQ13Z8HI/Lehpwerjt5osH5zjoBI1VMs3qNS1wfXOLujaG5gLzLJskqmYT0TFcBs6BneBQyd1DmLaWzW3h77par5y6h7MiMM0v72y3GM36NQQU05aK+H1aReDr7/XshABFjkG3JrZd0Ogc2kObqK9ZXlYCq7lqAG6JEKjpU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 22/69] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v9 22/69] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYX1Q3qHW9WWgfokCG7Iu1AYFFBg==
Date:   Wed, 4 May 2022 01:13:51 +0000
Message-ID: <20220504011345.662299-7-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e82e1f4-d4cb-4ec2-1d8a-08da2d6b59d6
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58309B5F5B0CC40A4E62ED57FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxHMvBFhGqdo8pWRJm2G7D421akMr8nwgiFxg3BtfjXygoMdvFhWynlY3F02GmibRDy86vPuUv2WKQ/p3zmabV/zpN8RVYyHqn3ZPMs+aOQJA3O7W57z6/EfDhC5JilaydowU3zhhuWJU2ytg6uithrb+EG1qD7cUgHOHA8OHYjEYRHWEtijtxKLPPnt0KZRoxlaMXYp6WZoIvzg8JG/qHObTwi7LdpwlK8x+KZ6MAb+OqlQ3AcO9mDtviDdL9h1WbT9306nXnGmVsEwGT0yVk0tu3UrZg+QNe74LiY5BcsO/PAoYnA0mj7u84K0j3zL1VKlTP2xYRux7J4xwlBmgK6wEwHMEzXwvoF23EYVGy7h9hY6B+DvPqTGbq1FbvBGv0Oi4CqqrZprU8T/v4HnWF0DdQa1ypqdKco3+pROL3T0QpjhvOu2jvLLledGLC8LgxQBn5lChuS3kIor3UViXyVP+c9sOVHH/a/vH/QNNCg8ytT/O8655nSLpCftVfXvofHzcPGHTNgoQ/k3qAcUiGq7fyqoC2rv6t1KhD0f6ja1nbbT9Hi/8bUeuCo7DWXnSXbPy6pFIgxIhbSenXitkG+fTkQUN3O0p3jG9ZRnfMABRw+kMhx38tm4T9Kckg4NbC2pne/Ybx0J9Xj4aS6lV1PtdeIRjIaFVxI23wvd5veLqBfxjBrdJ4fDrFt0FnK5E+MfYik3dVHcWiSyCINxvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(30864003)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+Bgyx2dqen3LrJr64kQE9AkTnGdJ0k1VB4/n5E7JeaMdv5PUXSo+Yyq+5U?=
 =?iso-8859-1?Q?2SiLGXu+xDQB0xSh4WQh3epOBIj6pQibQQszleEKakZH/m6lL71Gnp3IG6?=
 =?iso-8859-1?Q?dK8zxVCId4S1w3N1g/B5AgrEkPUjOZeA+0+1OTfoBntoHlU/YNRC1E1HT4?=
 =?iso-8859-1?Q?atss/hXxD9zsqRU6KtS0EUHKIU0j6T1iwT9gh++5vujoCSombIKgHbM4mc?=
 =?iso-8859-1?Q?vt65dfhyaXwJr/SH0WfyuSL90niXUwEgU1xXZ37ZaNY4JtzucN2shixbUW?=
 =?iso-8859-1?Q?XoYG2innHW7bELWGHjIi/B/5/ulozkex/lvnYDW2GQBOjPlzw44CWXtd1D?=
 =?iso-8859-1?Q?Arc2CiIzbnJLzjLqgqoK12VnIwlO19BYsW0pNcGeG6tEqlVrwx5ostyCa9?=
 =?iso-8859-1?Q?YCvZS0y6y93aVBj/nGoi3QyE5xI/e+NEaGrJjzrvHttq9PdEL9poPbUa7n?=
 =?iso-8859-1?Q?4IYRrjNO+AyOAEqt3J2X8wTpvKTT0z/yvP+r+FHjO8Y3kFjDPFPcNBo2wD?=
 =?iso-8859-1?Q?r093KCBTL9dmem7VZsLNBLUHF/nHvLRan+1FisHkl3SSzwNSmEwqLjUSiT?=
 =?iso-8859-1?Q?Aoi2LfheApD/6KVpwD0fQlGwjkO9qmhlih2JVYumAWstbcB23sVqWY4EJ9?=
 =?iso-8859-1?Q?2ddSiAKz07FoSqxQkD1ANbnLIOk4acG0XkHVOTRmV9BJ/dzb/feuxYw5MP?=
 =?iso-8859-1?Q?uES8tBkiqcT3gIHn3Lp9FkqzZ21CUorQKb37uZUfDLHKdsaQTHcDekY1am?=
 =?iso-8859-1?Q?w9QD+AK0/TAITfNZzjzjJtT0sgtf2I+fblN+Rwf5oC6Q/nS0wYTDL6kCH+?=
 =?iso-8859-1?Q?ycL/FVucidgQrD8oq8HmSlGDC/f0+3AZxhSXx37e2JprktLCnuwON3rWMd?=
 =?iso-8859-1?Q?J6W1HHdYBlvohaIAxp3m9Ga7Kw+gmea79cTJ8TwiG+ncZRRVRiRd5hRIK3?=
 =?iso-8859-1?Q?6JKuM2U5QzxwcCY3emz50XWOoYTXPxRWnxewXvjpkzklmqWaOdp9NHC8a2?=
 =?iso-8859-1?Q?Nuydv3JwpxvoiWUUjb4h43WLgfQq3jcIMyNGB0QUN7ahCkqko/6PlX/h/f?=
 =?iso-8859-1?Q?/xRoxe+gKsF+59NSf+Z0rIg2/F7K56xdEHJAs/bWp5N5XwPX0DqzZTebC6?=
 =?iso-8859-1?Q?Qd8relbloXwzcIJ3VM6dVvxqyeuYAnJXwkdsYujGlaYqNCM9QQmVr9OxrT?=
 =?iso-8859-1?Q?cqxIhE/gttjX0SxQJEhW3hNQKZZzQ/hgv0NXGeD8yHROOhoMPLGfdToUu+?=
 =?iso-8859-1?Q?CU/4TMGch3ydoEridN9YMa0JAazH8XaWVvzf26dPU6+QsHaTfngcgxHXSc?=
 =?iso-8859-1?Q?O18cZwM2xXN/nFHl95n39YXdk+vj6ipNt4EVc/3P4nTqT8l56hRsH5JQm4?=
 =?iso-8859-1?Q?w0rs/ipOiW4q3JpYU1U5bTlfDeaFsOIn9uUvVeXhrV/2fiL/H8FLhbZfFF?=
 =?iso-8859-1?Q?kK8MLbc1z/sezOjCempElGqqUN/AnjR0khCbL5SR6CUleWgpaLc4bW1RRU?=
 =?iso-8859-1?Q?HBLMQ5EDL0ALHULHZue1hS/jPEg7+0CVK5SkveEVKi8hulPDkbeB1A+u0U?=
 =?iso-8859-1?Q?6KZlTRMLWM9OqrFkNNkQmCPi81VfF4SdHMjRc0XHgSIn5r4KaJUUTri1ZG?=
 =?iso-8859-1?Q?S+4uJBpe/Jol2rhe8MoUQt/Qb0r+5CO3tiMZHMm1xal9PSHW9YtZWZGe8w?=
 =?iso-8859-1?Q?M3eSg93lX0g1W0H07+yGrA8ze38ByYMT/uPeuvQLmciCkLmtARR62pMTM/?=
 =?iso-8859-1?Q?pfLRh7NdYKRpcIY+2MGNt8lQSjC4tBRRym6HsW+OFtZfteKJNn6yWCYYnd?=
 =?iso-8859-1?Q?7pOzFHZUrSABt+cagpCyMSeuoZvCjbk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82e1f4-d4cb-4ec2-1d8a-08da2d6b59d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:51.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xewVWnJ9z5/Jh4y+x/VcdFZyZdC/oowermHYlZlvxJdlX/z1bAlCYdEdQ7Hwo5FZNGjU3xQGu63lgohiYWSwVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: pJOQA47OO0ci-HO2Yn6kJpm4znwHQUEi
X-Proofpoint-GUID: pJOQA47OO0ci-HO2Yn6kJpm4znwHQUEi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 286 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 228 insertions(+), 58 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6f1d72172ef6..ec4ce76f02dc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -194,17 +194,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -246,35 +269,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2766,38 +2806,113 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		return -ENOMEM;
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	vma_mas_remove(&unmap, mas);
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED)
+		mm->locked_vm -=3D unmap_pages;
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
=20
-	/* Check against address space limits *after* clearing old maps... */
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2807,30 +2922,56 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			return -ENOMEM;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma_merge(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if(vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if ( mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
=20
+	mm->map_count++;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2841,18 +2982,22 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2863,13 +3008,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
