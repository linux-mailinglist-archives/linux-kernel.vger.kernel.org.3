Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472D5101A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbiDZPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352019AbiDZPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A149D160979
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT12U003733;
        Tue, 26 Apr 2022 15:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mw3pene2lUxZBx3Rf6BYyBoyA9OPyuv3tBfujXnNXi0=;
 b=0V8p9c0MBZUYxTkz4YfEcOem0U4vfP6GLCBxt2OzrwGKw1gw7Ht/tRrY6Z36XkdAy75x
 7gZlytwqom5vjrY2yL+aweFzyw9hZrOpdr7HhbbWlYhQc7kK7YzAqhqYJrbo/E+z8L73
 ShyOlZdt+X11kJEFmDnSk1uYgJ4qqy7cBPMYldg4STSVYDgIDslfspUugE4+X0PbQGHE
 yfuuOCNbljvc+cD+mQUyaMHda52tI8uLWxs+AACuWdnyc1izaOaKJatiQEI84SOB69lN
 DmfH6L/hNwHxx9KhMsbOrb0CUhwXo9K8r12r6FnXTGq4V5KEdVNavhoBbwFptSaZFXTb ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF56kU019265;
        Tue, 26 Apr 2022 15:08:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ffs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcyqiPaK7gqXB4j2x0q6B2JvWYGZXyUfTWvwGF8TsCP9xe813Fg5NQp5WQSYzzXxEIr7Hu4wYQLcNqub8/S1wLvf5Ujlp//1jW6V60XlQfBfAtreM3WUQ+MBSUGtzHu7zc8MKZqHTsnc326Qrn15kAAM/ucqs3BdVc0qF57pb4xIZLtouM2lgQnxuaEKI99Gqct01CvJLQVQsICA7QrwVZth3eFFo0yLRNmBI/Q8Q51VvwnEpbFt2RIetqlTZBjhkUq35I5VlXzS9tKoeIewkACc1Jh+FvMjeZgEexqFhI9q5CZvyFq9KIoDQbrThZMcj+ScGoQNR0OUABCgA/BrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw3pene2lUxZBx3Rf6BYyBoyA9OPyuv3tBfujXnNXi0=;
 b=mwiHmUA8xJapG0pZfZVN9zVsjAsnhqA5Vo6TEEbqpodbbBlWP/24FSEfTGPrP6faz/cV/nPPabKtmCtdTUEwsY7o+lV+slcBeoNQc1ntMvfsuU4vK7ccskLQxf5YhEf+or0roeyIzX6g6n/W0LxMTk2zS0J7Th3h9fdLsENq8Vgmc40Eqb0NRNUV16kAu32bSAKiklD2f8VeRITdWPI9sYsvpVzm/fWO1cE3+/46IR6el/9hixvFa44cG7uyuftN/FD+RnEiLBDG+h98f+jMUGuNlCnzSWY4bnIu5xQfbF8ngUM5JOwVyIb306ekRw2gEeMLJbHlQnwahFmv9sqQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw3pene2lUxZBx3Rf6BYyBoyA9OPyuv3tBfujXnNXi0=;
 b=o1YW3PojAVyW6NtrQ5fypu88G8s64+WydsJU4AC92ierZt+qQ8zFrIS+ZXzyUxrGSrTA5kyc5DTuphPHFRkDrEFgCEgmOOrB7j+wG+uyPj7XHSa5g4Mq/Gq/2/rLs3e+25PgnbRe12i/lGjRxL+GGm11Sc+av7+smTdYSUdPutQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:08:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Thread-Index: AQHYWX9CVyzty2Dd7U2RBRimBz8bUw==
Date:   Tue, 26 Apr 2022 15:06:52 +0000
Message-ID: <20220426150616.3937571-67-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f423d29-7f2e-4b97-d1a3-08da27969324
x-ms-traffictypediagnostic: DS7PR10MB4925:EE_
x-microsoft-antispam-prvs: <DS7PR10MB49254505FE7215EE2EDF931BFDFB9@DS7PR10MB4925.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYC/8AEb0qjWr5ELEYO2N36qp68fHnScZnxMvUGwEsN19O2ENvdVQRXZ4pQByRLs5006k2dx1RYhCvB/Ymngz7/rjVPR1mzDR2Z6tretBsTEI1IwqUy/BOrGnCfPmYzuhgXzxEdJ2e9evTfBHGipjhOkmGZeR59JValxvJDjLib85UQbu6B/AeFI1DI8eEGFQwIqyZyiPjyeuujZ4sVfPsocWhSGdU+eV+ZZCrFuhyk5D+/4m+AwHYA3aRSYDA8iGT3fHIQ23j3uFvLP44ZiUBRuIlCLl+reKk2hA+D613fbZTndx3cRf9qdDHiJM4KSZ3KAONinqoBZC7GpPnSQgyHUpYZ3SFM200vaBxOfosQCO/rko65ilbKoFGeBU1N8kiNvUaFwwrn2Uq27GqkzsICfsbHxpQcAHC8yvv5wUEHD+jlKR8t5IKQlXg6Frl4X2mVBfpsMRGHNUQ8YdmxRC8Su9LzWmGBcK+933hlmSOhAW067m4ieIYcwlcT8YiWcEiAyBQBHPqSHbU0a0sWSj3hP1wE5sJWysuYkVBDTYwUYtLHuiI7wxi3FwmZUPN54yKteQaCtbobwaM9O485IDrZH5IGnIXe3lM/V1xpqUimzsEgf6ApfPQBNuP90Ju1GrPatgsILDFF/jGI79IOHdfHqIiNTXRzV7cYUam91W3DI581XeiMrnYG+DtS3gDWsT4yMMZL9zbpIHKlajHICZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(316002)(66556008)(508600001)(38070700005)(86362001)(8676002)(2616005)(6512007)(110136005)(71200400001)(76116006)(91956017)(66946007)(122000001)(6666004)(26005)(5660300002)(8936002)(6506007)(36756003)(83380400001)(1076003)(2906002)(44832011)(186003)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TgpyIGGAvQ7pLOhAKMYR5Db8BFOOe+b2ITXF12mgzGd1Su29XeDKlmgTEo?=
 =?iso-8859-1?Q?O8xiuxsrq5Wi4xlnPlxBdVPzZIn/KRFd+G1ZkGY1buznZw8YAWz/I8hg1x?=
 =?iso-8859-1?Q?xz9RcYBIBFC/5RfuGRWAzrXEpsZnoTVbLRA4AX8ML9acSYKuV36KFU1MTJ?=
 =?iso-8859-1?Q?UoIIyvQKSUlGpEvH/ZKGEoxjtVCA0+dPZhZRINYxrCn+9joH1opxjbUb7S?=
 =?iso-8859-1?Q?8AgIGLDPzRBPAsnNOtMQpc8uwRDKjpIYMfRGOu1U54fcb0ilfumnjnUHNi?=
 =?iso-8859-1?Q?J4XYcZstC4FjYch0qqo1ZDKQ59Dl4xzBdk7Nhx3yl36t4v5LBV3QDNmlJP?=
 =?iso-8859-1?Q?ET2db8pDFUZuuGNNw/hosbI7XEmFZOXPBHDndMXGckk0/DLN/CsbDGZ1is?=
 =?iso-8859-1?Q?auhCEs1IXUtE6G1Uln321Rsy7+Ln/wrCv8I6WeIu29is63VHt2oyfk4Pjb?=
 =?iso-8859-1?Q?HSfGj094OWcwRk/JrZSWu9P/Avx5wc56hMZcuWxVohoERCGisjH2KFYMSd?=
 =?iso-8859-1?Q?4R7nEFOYdePsQJ7eEoERpRODwyNx6bqcZT8NkAYZ6U0vbxSDpm9kzhxYI6?=
 =?iso-8859-1?Q?NVLLisGFujZELRNN8M1J5tzANWzvTrpZK76hNpTY0IhvrOzvan8P1jx/1G?=
 =?iso-8859-1?Q?uLRyKggbfDMr+PdC1dgSx8XF8E6En6Z81hd2nd7b4fyttmX4hzRh4X7/cg?=
 =?iso-8859-1?Q?XF3mEJ0hMHE1oiTgSG9bkTdeDg4CqgmKpluN2xa0RATwmR5On0zPR41hhs?=
 =?iso-8859-1?Q?t7C49NGHLtEpbYZLGuGsEXgjt8UNR7d3CH/yxh/mUZIacBJrYGsYFDQ9qv?=
 =?iso-8859-1?Q?EtFYSecD0XGV6zDhd7WIQAetewT94G8L89e17efXF2L3/fX126edbKEJeX?=
 =?iso-8859-1?Q?EgqbNHc1oqGU4yHgzIDWh9F+YizalmPeyDV+zms0H0P+ZkZJ/2VB/F8Dau?=
 =?iso-8859-1?Q?rK9sJ858iI2p/P0PekOba8lMe6Q0DeCs5WLkvymyPAuE5q8fiuI7qvhwsJ?=
 =?iso-8859-1?Q?tAR6gXNsP2aERCgzLHrQC4Vzte/j886n2n3Jc+KbvImFzeTW3mbqpjdObs?=
 =?iso-8859-1?Q?TaxogiC3yc6+Mm+5A6+9lqoPCQvdl75NLY++aOCj6JdWXtdCm6wn6NGj2e?=
 =?iso-8859-1?Q?2In+tiCIe1RPx2+u31XkuOMCGLYF3GnC5F6JObf74RwTCD9tSzFQjGhx8s?=
 =?iso-8859-1?Q?wGG3Ubr7nxEYEpipt8WY3r2bUUqxGpFKCM4aOaAXMeEw0yCG+YnXT59Viy?=
 =?iso-8859-1?Q?tjP4iIO37Vykndsh8edqn+vJd7jbluU3N2c1R8nb5ZVk4C1hd7Sf2UHmhy?=
 =?iso-8859-1?Q?yagM/n1IsTqv/vl49dVmxKlVDuUbM5oj4lDo1Bje/+1TNQPs8L7ABZXjUg?=
 =?iso-8859-1?Q?9PJgVFDvmLZhTK9v/dxIdBsNExDuFg1xZ6Mwr30rJv49XBoG2YPp5ILmVS?=
 =?iso-8859-1?Q?yNqpPOnjDX9lFfzeunP9Du4+HK52HE4kMC+zyNlkekVjQLpJzsPJEGeNyN?=
 =?iso-8859-1?Q?gmJSNAvQWAEbpeXYpc+8iObMVy7bYjpcVRvy7IUwf2/Xjk9IBBAfOvCiB6?=
 =?iso-8859-1?Q?iJXQFklZr7r/4qxKM2MAJYNzx/nuQML0UTmw6gNJ/Rv5O1Lq4HEHYgK1yL?=
 =?iso-8859-1?Q?/aRSLIFbSL/nKFqMj/dc0s3NmLUSrj69FXWBkFruisspUgkrVPpCTiWVHx?=
 =?iso-8859-1?Q?kcAyF2gOI1cI+E9lYuHwnDDA7Z2H+xcPV8FjuutvI5uPl032ACd7mA21F8?=
 =?iso-8859-1?Q?UVeca65xv+4w46NPY9Zj6yiWZVP5L9oWPUg7FDWAK/jA2NFPylgJAf1RLB?=
 =?iso-8859-1?Q?pAuRj4Nl19chiXk2eBhXgyUpoeZ4sAA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f423d29-7f2e-4b97-d1a3-08da27969324
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:52.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHSQHq/y0LanZNN5x42sacfS4zxABbgjv8OsN+zdyNNC7b7HVAu/NO7fj0IwFIZWI7DdxDuDa9mfx2iBoLpIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: jvUaCH9I3Xd_2aX-Cgc_PWW7NX3GTgTt
X-Proofpoint-GUID: jvUaCH9I3Xd_2aX-Cgc_PWW7NX3GTgTt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/nommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 26a9056e508f..645d11d3a8ab 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1381,6 +1381,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret;
@@ -1392,7 +1393,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1411,7 +1412,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1460,6 +1461,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1467,12 +1469,17 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	mmap_write_unlock(mm);
 	__mt_destroy(&mm->mm_mt);
 }
=20
--=20
2.35.1
