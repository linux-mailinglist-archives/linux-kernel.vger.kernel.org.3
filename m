Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1904F174B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiDDOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378024AbiDDOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE03FBE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpNEJ014737;
        Mon, 4 Apr 2022 14:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gnrFzaams6wFatVMzQ7jVxBLcLFODZBsAv1yDLQgPaA=;
 b=wPHF2zUgcU0lb9AKmfiIVHoURn9eqQJb4cTTdpox20Kw+tdTg2Qg3Zxy8pkATw2YLaFi
 xmqLmnvtABjwq8ba11u42x0Qd9sdIFNOZ5wgbU9JorZ0COx8L4B6VyM7B7IcliIjMUwA
 WrQcbNTueoVVzB//FyhEEYdI1fWe9hiRlIblcjQryYod4Tm3AJj3BxUEcBdi9TYLsOww
 EsPpRkH/RZctVIuGAi+5im2N/3jJmr/H8lfJEwRuPg3HC+UEqKQPfz4AyHydqI1ipmCX
 CJ5Y3y5eo8Rz6M3Lzap5xFF0FuIcw3NKjVjXESxNwoCYBkmRDA/7hxqe/j+Z4h/biV4R WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGI027665;
        Mon, 4 Apr 2022 14:36:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7qV7yprH52ciRn+u707LBnC/v++OHK6Ct1NTu7wWNq3VXVAOcCJq1XGvHu6IHrVUpCg3DscZTb0+PInZSK4jm+V4AwnX1YK08WF0gwwvbO/Y403qMLz6eGpbyc78aQZIqE8ea5lG40Pbe6iPkKdweCTVwHp/+w+c0cRiJFXgXY60whRWo2inWga07I7vyn2liPybigRsonsn4rCdIWUf0c0fg9YHDDJJ+pqsHa476XhVtWSTx5M+B44t7Qz1Oj8STLLB0atYSVDPfjgBU8IxcMrCF+3daFSal/BICIEiOlPMEzrnzWp6yjce9fGkdMDhaJ0ofbru9n/yP+LeUDw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnrFzaams6wFatVMzQ7jVxBLcLFODZBsAv1yDLQgPaA=;
 b=kfqeDDwyIIIut1C3u6PE3g/2UMEE5jBBFHL3PqA85SnOyNWmywrS5Wm7BBMoh/c0AE5jUTjq627I0jhSSDkg/iZwAWbUDlLBbKY6ta0ePTV3hQNsAXi6ws9taZ7iPtP/Z8JpCIJN9Gfr7lsLWmW7cXZTOGl+7myVenrXT5LoE8oH2NvjuV1mYcl/C2Ro34X+OG/WaQYaRGhfYLNGNMULPIdH4yMj8O5kOSDsDwS/61nHZkKjnugGY7Knw8h5CSsStDUEVmHkgnNGdSJBx80WRCTmSL6z0YWHK5IN8lC4atsuXa88gsoNUlMdcGqFpYkWSJ27PHA5KMk4YXtG3gT6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnrFzaams6wFatVMzQ7jVxBLcLFODZBsAv1yDLQgPaA=;
 b=Y6ByMI56GpxAfRwxqM7kRXDryY6Ibb4hTjJ7/MUjW6V/CXwoFPD0NwReoKLTbI6jkx7z9bxzoTde2N3fImzCoVQSPocT5iV6NGF5kd8rm1zLKBWjmInoezBKLD0Do1lCVHkbIxcwKfB261mm+kkJHgVJKktFGAdLIwHESUdzihU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 41/70] coredump: Remove vma linked list walk
Thread-Topic: [PATCH v7 41/70] coredump: Remove vma linked list walk
Thread-Index: AQHYSDFHe3VtZt6q3UuxBcb66ODlnQ==
Date:   Mon, 4 Apr 2022 14:35:49 +0000
Message-ID: <20220404143501.2016403-42-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea834503-31c3-4040-23d5-08da16487e56
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381E02889910EC3D277104EFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWPGBVHmVj9yL+6z4SQzo6xoOJ55B0h1V7z9Pz+kuj3CU95cdj3RMOaMHLzt1k5MjbaPcyMDWHIaH5PlT+6pyCUuCkgvAhcNAlQPU7bNVfmfhzKRY7wbcUfzHikfJu3EQev6yNWPEo3NMyw0pgAlPs94P1dTKlcdxMWx8dDa26krIAKojBGHPciYdPD0DYZ/ZyY8NFxBVVzov5gBOoKp6gf4lvmTpEMxpbtqdV9S6RYva3xq0Tl/lEhNDDPK+snAdXmwDvbo66G/Arp7nn47vXBCZhUE9Oqa15Jvt1ks81O0X4tR76bJTYKzN7JXZeCzsgJk9jub0BhEG3q5l240QgXfqiZGihbhvM2srg0SouNHEZ/hPJloPImjCVLkBfP1zQCT+oI6BPBN7QJC0kFIXw+siDcrDsWGAq9uX2aa7f+UbNXUKHCY1wOyywbosAGbk1V1JXH5Iicm17qZrwlmlPXNNEYui70Cve2vFWwVLRNtgjX9MYHO1GHzyGA0jbRsWFb7Es7qVplMUgJyENKkEl7PnwOMTSdhXmdDdlB97rXC0nINaosngbEvVkPZEYRCUWCWH1oQNNJ8alGA2uLz1fkeMjTiJzNGwP5JM6ZowcZxZXsSSjB+ylExPeAhCDhWzpek+tRjMsBJUjPk6hsjtmQXWoLLOzHhDwzRIVMZHToTHHA9I/Ttn2MigT7WPdFcAm9vR/wA1COEzp7KekZvQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ozJpfk1lID57WlswiSK6jLA4WeFONin+QtTl8NF1PLab0BL2LKmuVzUJV?=
 =?iso-8859-1?Q?owYrcGv7yHCvfsS4PAES5Nd+NsAuo4Tsan6nWXQLQu2/kQJqI7/VBqG84p?=
 =?iso-8859-1?Q?N30b3sMn5uP3Dwr4PQU5dDJPFw2WsNV0ReehPSZMOpU8iHQfiBHyqBzrW8?=
 =?iso-8859-1?Q?oFN2gFX+LxRujE5LDdpy27gI3gQhl0oSyFlj6AraIdHI+gXcFbqep8hoOW?=
 =?iso-8859-1?Q?fn9QiVVTiQAl3ufSGtb+HK6PsAFPryiqOAluHBV+XAKeP4aUaq6iFDJtRO?=
 =?iso-8859-1?Q?LtyuXTFa6hdobK0sbe9nv7PIzEYHv9wE04aivXyEdVkz+GpzggHeFWm2Rv?=
 =?iso-8859-1?Q?O1X+s3acl0lQbu2jfHQnbjxJ7GXxRLSOHPPOaRsVSMdodU/oixTQsnryO5?=
 =?iso-8859-1?Q?JmWMpESibkQpbZs+oILo2Tpnt/f6c/zxobxjTlxMtevLUNSMCoFsJy9PSg?=
 =?iso-8859-1?Q?O+6ieLUaH03kQGCD8Qzyy9ooZ0WQYt+PfanPl4SsNxHYMGRMKU1KmANEuC?=
 =?iso-8859-1?Q?VQyBD6kJNMnB8ZsvEhWrh6Uz/OY1b2iE4ezGRia5rhEDc+mfn1rPzl49q/?=
 =?iso-8859-1?Q?0PI5B1eJvpoUIhyujCElG5XSY+Q8tOYe3J+G/ZF0MJ6229JWRI3LIT4WOk?=
 =?iso-8859-1?Q?n3bS3M5KBE00ty1OWt/o3J3f9KEpAwo2GeaKU4cDH/ENqaFGEsGP5d02lp?=
 =?iso-8859-1?Q?CsceP4A3qjveIzIA7MUlYFOc44eRH17srL1U71ZQKeBaFcmDO0baUYt2fi?=
 =?iso-8859-1?Q?ovowAHEHv+JGNEPRrRH0OetjhvX804etDZilZ/wsUU5h3A0muiyHHtopJo?=
 =?iso-8859-1?Q?SSBcILADbnXHH27Ct6zoMTgDNQrri/3LrzGH7e9fe3eAH+PsYb5baaiITk?=
 =?iso-8859-1?Q?kfKfWitbkv8ZlTKeqeOuwIWlN3uhHvN+7Ice4wHzaN+VV0ZM9H6+9n1QJM?=
 =?iso-8859-1?Q?TqglEntPorACq7oyzrVK+nBTERKOlyvKlOKXI7eNjPZyU0BhvMOH8ZREmb?=
 =?iso-8859-1?Q?gAr05WSnA3uaeBRuF3+u7CcYLGM5/N1c1xRmPQtUwhNFOdNacD0ekvjOlX?=
 =?iso-8859-1?Q?z/n1Pkhgu3PLBl1eF7GsGtU/WULUPNxKyL5KW+vd5omZHPWu9Sl/EQYNa0?=
 =?iso-8859-1?Q?xOlkxROdxU9RCaCYeqgtHhbIJQRynEoRac+AFUrna+49CZZcBlE4dzoLAW?=
 =?iso-8859-1?Q?33YZezNOPvlgsWR7h+sPy3cTXnyn/6G10V/ljkZQbQtuoN15DeG99CmWnw?=
 =?iso-8859-1?Q?7LsrwaOvnhuF3bXgvp0XCh8qUzkV88chLgMz+DnpoDjC83Tx0JmbtgTGtD?=
 =?iso-8859-1?Q?8W5w8kwtgq78JYJ3PglFcvD7PFLkvNHU3JnXNZYIIwHnzrTAro2iqT5ccs?=
 =?iso-8859-1?Q?IW9J6fWr0Q/RePKO5mLt0IcoMbXswyR3H/Er9o6CBZHy+gMzKdFU0WVmoU?=
 =?iso-8859-1?Q?MmJ65aWk4y5YcFKd99LSQXUdpbtpnO1MouLswhRPnK6qnx7y8i5RsmpmLs?=
 =?iso-8859-1?Q?W6zASVZlL0ncfmHRoZOTbJmeqnzYql6DB+cdYhGahPDgbodPQ6lAUOLZ6A?=
 =?iso-8859-1?Q?v2E/XuxVIEdm5K2GglzsPK8C5ABgJ8iOs4352E0etJq42d8O2I0WigXgTB?=
 =?iso-8859-1?Q?nL3ICStn5E93msuyv5UvoyRPw9xZEuUvs4t80ntjQRqcZjSWvs1Ng4U0H4?=
 =?iso-8859-1?Q?lkp5OvUCYXKCqNbWkO7CxS+5ihdUmk7lcgmBUKrphWWxjuqUgfrVnUd4Y4?=
 =?iso-8859-1?Q?Or38+OqQ88YN31ofgMf03AFWu9LwU1tzR9nxok6gsIHQlHHGU1KlMiq8ca?=
 =?iso-8859-1?Q?tROnWSciZBJLZlrxG3cWYvpXvLNd/lo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea834503-31c3-4040-23d5-08da16487e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:49.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQW0jw6CCDblnSg/2Wywjxa416Z46tX53O9+TugzSpf2d4n2almM0xyZdcGkL8Q4awtoq3sFwXfG0zZu+WlPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: iSSHeCdEKAV9qujHdOEt5r9aNUqAWNJF
X-Proofpoint-ORIG-GUID: iSSHeCdEKAV9qujHdOEt5r9aNUqAWNJF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the
VMA iterator to handle, so let's open-code it for now.  If this turns
out to be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.34.1
