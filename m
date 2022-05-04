Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA32519367
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbiEDBVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbiEDBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF544778
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MIwYR026114;
        Wed, 4 May 2022 01:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=JpcNrpSzIo2mnNftohqxweOusl75wX6gXZ104dArHnlt3UjfZjO1UJqv9lBcm6kQtFj+
 rzm1++t3anvLnMbFSPAP3QHU0ySG7R79h2Opmz/rwxHHHob3MY4LataihKVKWtj5Ew5S
 2JnD2aYoPx73+uDo5vZNUjVIm/BYRiDYtlQtgAFv9PmVUTVKHHUTk2RpvFV7EwHl0pB7
 0xVk5/xrO73or3UW9Enny7KBKTeDtlin8cwjnN0Sl0nX1SpU71c4bpQb6MCsFZlYi8AS
 zRDmT4r5YSA6RbZ5FSOSbpRllODHcRiwuqp9djFhQeZSI30D4MoKs7hGAw5Hpx6sZAhv yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR7013207;
        Wed, 4 May 2022 01:14:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heaw1UXLr9ebiuyZ5YkiB20bKKJ90dzTwDOEca3kDKsX56DHc0+O4Ns5+xjyDN7KVtUMpsCDoGidkf2ENQHV1SCH3O21uikdSZQPWSah4phDMI7EDlZ+XDmmpWaq5cDTnnGSmPOnbQ7pewA93Ts9clbTxF7+p6X1BYVf+G1Kvn8VJxCLP53mZLS6QDJeAwNAK0MqvmpFXcQ7cl39prQj37WvNhBA+3xVdaWZTwkIBgWydCbhl0Atuev1+KuOBB3cuDznEj1YcfFGHTvLYVeANkgixNkxGkWJTyd0EgjHj7Yhc9Y9M1XVrJkwif/D5bUE9uI1ZfMGSp0YOh4g14lKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=CB+qj5vwCVemSr0pyFiRGG4HoYIi8b3YPWMurNaO0G/HgH56S0zWcFqNQ6US5q6BzBfYra1W2S4FHS8w0NLyaFzL9AwBCGwYJxF16BcMrgeFaFas1G3SzKHzS8XaD0vUzBckWCNsjxXurPM/+Ux4J5vrjvt4IX9M33H6VyRh/kKEtDCg8sULrwGhuALzlsZNEypd9HXHnfSjjDOeAj1vktGdwRxRyhudT8SpYe+eOpFHnVFiNcVY7zCfZKMVX2wR3eD0g2DKstsQP4gTJrP557jBebEJQG5R/E5ITC6TEQHRrrGLd7u25uUaiFIw71NkP5dY8GGXrl7H367otaz4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=zs91+DNrvUf8IU1aETENERlI1IEj9GijR/US45U2EvFL2qkHYPWIVDK+fD69sLhRauQHMNR0OMe/JLOGkWL/5hyVsA4Qd6nP4gXoawSqqHinoXDKdnY8kuCyk1bui0nKHhx6MBzFUm69/9MubFZK0eF69AQXurVEFfoFR1MT2+I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 66/69] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v9 66/69] riscv: use vma iterator for vdso
Thread-Index: AQHYX1RAQYCMo+m6q0aPhvPA7q6gqw==
Date:   Wed, 4 May 2022 01:14:07 +0000
Message-ID: <20220504011345.662299-51-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d339de-5323-4ba4-b0c3-08da2d6b77b3
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26885E664916A8938326B103FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dx2/g9C1Tq2uDI49PEtLG1the3qHghQeuBM9/78fEjVt9Wd81mYoyrd9O6iIWCbY1GDQFaCPB60F1OkhyyX/uOFl36DTcJa//FXOT/mrWlQI35IjWxorLpD+7AAZKXKUYuh2AA9HX3zqTkY8s338WoWlRxpDyZABts4EMhmu5/LpH+Ie1qP28c9vnRgXieQ/oM4iurB4UOwBthR7pSCm/GUNoOabfi8qo8VMGc8Za0jFPV826jH23nUMPXaUr2Cb8XyDATb9wjDtb7ICkeWdpR8Ggy+u6uj0CsT9JyLHSd5zQYGLbjqoRfDZKCn6W5D0tCcdevovm3zkjQ1cXlHI4cG/7t7rCDBtBZwo3uPwHIcyNlJZW+gWR1Kkmrbdv4VfQi/rYZel4CYfFamfaZFJYLpS7rjHBR8enFrdWY39Ufyox8W5hzHkRq9m0PmXsZibreB3yvxrylV4ij0oHxGVqAEBsYTLbfszPSRZgmcbgJ5J/32gbXIEnFUls71TcMOH12UZqiPqj+Rl+Xi8f1bgUnU05Y6avBYsCxKRiriagAomzls5ECaMGuJXDPDMcTNpP4VmQyU2C+igRJDIjgSIGf0O8aUTDVcPfaemSJ1+4IsnQ68ZDl8AVD6J7QCPJ0eJcdQndelYpGcaw4hPnIEQEUm5YKHx63Nzt6vy66Sa6fXHIpF9PX6fFAmMMQGOBV1eLOH+KQnygTEMc770lE4mcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ON0AAt026b3W6yAJwud9YwFcF4IS+iodXPI4L0wwjooB5XlGuLc5L3ZhJQ?=
 =?iso-8859-1?Q?093NsEVReOBls4IJdsbiWooRT63EgF6ltCBMu3pq0y1WVxQYAuxkkliZt3?=
 =?iso-8859-1?Q?gK8hXx5FXogsz/xYFJQrM/d3JA3K35wtLrLFY4PVbFOReGAK4bJ6Juhq7G?=
 =?iso-8859-1?Q?3w8eyL5QHWI3EqRz8yCnrY+FC9xFfmEF6sZsgGIPtqaPDJ5s5m+wJCnToo?=
 =?iso-8859-1?Q?OjGh9BtH21UNNwY6TMkW+JdvG7g8ar0gN/4q9+6FV58ixsyGNG11g5C5uo?=
 =?iso-8859-1?Q?8DO8m9ZFj4uD/hNJ6V50tBwjyupNoG7yC0GhYNei3F9SaTyr2mKuqlS7pm?=
 =?iso-8859-1?Q?GE94y6/1wvjUqsFFfRz3KJIa01r8dGCBTftimZHmdEXocY5eF0AKgIIA6j?=
 =?iso-8859-1?Q?aXHyOwHZ4N4nBmWhHemQArAnUg+0Ttks7PMVzBzOuxImYXpA0M9Lyz9oQx?=
 =?iso-8859-1?Q?A14AmJDiEmfuKkIGIF0PC4Pcb8Y2ukzPATd9GeV6hGZJMJrVoq2dNmWFOx?=
 =?iso-8859-1?Q?Yn/KiYt98D54qo1lBjJPV69ZpYhG2tUGaAm/bvyn78recGHcU2Bl3CjoUR?=
 =?iso-8859-1?Q?uLsRbQblW+kuiwVBE/3EX8nh8OVzTk/l7n1ONKiUWuIhklkpqCO3MJUxcg?=
 =?iso-8859-1?Q?6ayswRsGSghofQjR9j0nYIOL7dGL+CEFOhGgJs39IXXxTx3H3jcxtwWBZC?=
 =?iso-8859-1?Q?Cb7ALOc5auf9HQLJaA5pudmwARgrLMgmAsgqxypn5hxBfLHU0oe0YyNUNb?=
 =?iso-8859-1?Q?DBI4/bF1SY0X+TIdJPE60bV46LVDwpJcVxiVvvyI7TBJvy7pp4MniO8H+Y?=
 =?iso-8859-1?Q?d8vmwqEsKZkpqE/nDfCwgSOjx135A5952eyPNkGQawq8yYAvuxjCfMLd7r?=
 =?iso-8859-1?Q?t4DJ/1doRrG7YK7xtyVwpeBvr7TLh87Cjk0bfpVAGOJpfE1ANeYcYg911x?=
 =?iso-8859-1?Q?sg0JXkb1SOYn4GtK7tnXP4cgeLfYbR57CO/v78UEagO5+PDiSuKKBtqSKq?=
 =?iso-8859-1?Q?ctdmd6mXdVqeMMAk58qPiP75m/lNOFgRclqyULMle1cEIUVbi5q0Ef67u1?=
 =?iso-8859-1?Q?gKDOXkXbE8C2c2iRXauiVMSdH6RE0aBrvbjGxdD2pOymOI0BPE8RtEghVY?=
 =?iso-8859-1?Q?0qDasQSmC4x2N58uQOBYE1NAFtZish8ggT/2sRld8HA0EfZ91DDvn1I9w4?=
 =?iso-8859-1?Q?6rLnSim1xenzaBpFuB/tMorQTxiLk8Xa17vawX0gIh/PIEe8dwAxQ98ujf?=
 =?iso-8859-1?Q?LEzl1if2zvJJp1Ixd47MDZ2+zOFgf2ItwlpJJEdWUp3ujiXOunLkI0II09?=
 =?iso-8859-1?Q?Ku738wX/LmkjSME8La3dfPO0O0ixfs4/ycJxfN02Ay5nn88GrdZlI3EmzY?=
 =?iso-8859-1?Q?0/QF61siMqn7hggEGkWaBLM+atOdVzkKeb1IRKIl5f9hYulOrQCt5jP0bE?=
 =?iso-8859-1?Q?cDMS+OplQuWD6kYfussNKy2P0svRvQzmAdm77vm3R0uX5kAtEktyT6ILqS?=
 =?iso-8859-1?Q?Z3R1zQr3sHs7J7dIh2RgtkD4fNZSujtCgUnxig1+ANFPWIKh9tzMwQNesI?=
 =?iso-8859-1?Q?1RfKua5pxPqZHiUIXmGatkxT5ZOfNF0L5p3j+/NtrLEeMPNli/2g681QDd?=
 =?iso-8859-1?Q?fYz+6Q+pIAjzdeFJ273kJFPEwcWtM/zA2z5puaDj2e/stBJNj+WlHfKRDk?=
 =?iso-8859-1?Q?CJXKlSRnOs4WHzLVd9+JhD2v56PS50qtINSOwjoQZxqAoFHzDyy9AWFqtp?=
 =?iso-8859-1?Q?MWOwEh42p5YEvL/NcTtq+5xWIkGruOmu+HnrurBjDIjvVnfIHqe1UuuOD0?=
 =?iso-8859-1?Q?ggPv6aQ8dTYgZcrskrshDAlvR0kGryg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d339de-5323-4ba4-b0c3-08da2d6b77b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:07.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fy1pTUca6bYpddLmM/ypE/ZRy1+1l6yicYiJ1bR3I6SXRx4dLqnnxo9YBzyb2OzRZ1DqhxWTRL4Fym3mdDXUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=865
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: ex1EGt0nh7QDR94zsIzQJZlJEb6R822N
X-Proofpoint-ORIG-GUID: ex1EGt0nh7QDR94zsIzQJZlJEb6R822N
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

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..20e2ae135fb9 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -116,10 +116,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info.dm))
--=20
2.35.1
