Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6196C59C251
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiHVPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiHVPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:11:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11037F6F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpmTq016597;
        Mon, 22 Aug 2022 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=UoFLcs2hGOkd6auDFvNUHli+crtLxbyatf05d2c0cU9btqPqPzIZykzSz7HzztTRt9gJ
 k0CnNH4hZLovyJMMUlyQ02GA8s0KypiBmUYH0OhUefGGGq7Z41pMGOT0sFCV1l16JEBh
 jBiL0kOAfMkApiMFB8GOEU6o6aGBOd4EetUQqGYuV/1JxshEvsogiOWVXseA1LPjt8k5
 SwqP/nWeqjtg0z1zCj9xUjvXwlSLQv5zCxFddoFNlkp4k/L+TWYODL2PNOj68NoROBQr
 87ajkX8vzkP7t31Ptgsjr5+GsWN6OoqxAjXaJQyWKHIP7hMAJ98uAZOn6U5QaQlLLZWt Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Na2026712;
        Mon, 22 Aug 2022 15:06:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bef2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLPgJ4DOPqc1og34iozeNeXDwbDZVDbrUyX7cFuVIxRyQ1VQlIrRsKquqnU4OIzg84Kj8SxUqFGKZKIX1PXaJ12yEjvjaNlRCNSat+ytwdQGW5wQGvMGWLqIfq+0unqqaDCLyuuPbouf+0nM4IYepx50NGVOR52yZfeu1z6EptRNzZovLV4xjxHtiBOi8uRhuBj+7ujGALtr0xD9Ic72j3+N14x0oC7kw6ztSmhAQSi0UTIJ4ROc7/E8xx6dWE19kHKWogKrJrclFWj3PcZ+KKig5bkxZp2oDKv+ITJQQxfThIK8eT/D9fMryegl5r1Ks9CS8GdG8FOrl0+VR9O/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=NRM8TK3FmMcbzBGjWcqdAb3xnwFS7kOwFkWwppmpQwocFCtbM60VdnHPlT4KDxspbjDV01ZaBfHHxq/15Tk21KtDaw/yH1dPMQhxpmE9Vr8za9zfYl60LbfCbghIxYUwXbgSV/sXFwWB2sr3VSAHznjJ6nnEE4xY9+WYfOT1jbSKogPYqyP7ZF97TP1tH5eO41WDOgid6NW5GN2fmMUjHevtFesVEt9pOw9ZAyRRnpOJttnAjXM/dqQSU0gQvqa2k9EUYr5GeFvVUKJiyWK7bVL8HwhuPMl4ZJwagFDRhcutmrT74C5u0BY6whHzCTGI4NxmpckUFdKv26vVP2YUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=s3mAn7pE6igowR5gC4DuQskqxl1c1dWN+DGjTxF0dhwLA9fhsd/zSkfeaqQ8W1YW3Cxk5uDN7uSUZsHYI2hOKbvn3c1p/hD8UWiaHt2i5Uc+prQWY4He3fShvPcwG3ETcyrVIBDtDgAQlF2smAsIPTKJBpf7ohOjxfo2iam+enE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 40/70] coredump: remove vma linked list walk
Thread-Topic: [PATCH v13 40/70] coredump: remove vma linked list walk
Thread-Index: AQHYtji/IwhH3xhEWEWAB7VYqLg/3w==
Date:   Mon, 22 Aug 2022 15:06:25 +0000
Message-ID: <20220822150128.1562046-41-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c2b2c26-b489-48ca-c456-08da844fe230
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmPHBeqNMLzk/4L/L5x29SH2nuGKZGwpmLr7eRlWzKVEU6aIA7j0PzLeIdqy3vY+Adoj7ih10Mpjz8U2w509zNCGJ5+2fI4mzu+LWDciH3ULh6yZsHMr/S3mertGa5pssvj3Tj9XyE4BldpO3YPxXdKVuuW0sDVWU8ztmN+HMhWIYnNEoH7qLpWF8fisD/Ier/eEwp4lzpExTkaZ1bCWj7tI1IM94d7XXXjfjOW2MD8Hy/wiixmM9LkxvncY3i04TiYCFzkkFMBJ7khKt/8l4mXwHMF2nbBQvwH1MD48C4L12KeaPpJPrS4BlueDpZ+397UUTZG1z6UQx988PJDFMmSTHgZrsAraInxrRFnNZ/ef9GZ2eJdEnU3oygc6yfp4whGryyfpCResAoAZlF3Zv4SfV9pgOBrHLZcwnYGIUedeykHhfY9Z6sxxVLHT8zGUR1reMz0nsxd2v6i1fjjpWs4XWHlLO7ddPhop2Fi8NauPSglvRGuPqt83YF2quh7AZi1JnISyDxRDuGRxgnyv78OY1hjVFKq510cK9yvRiPpdJg9H/V2SGP73WvkIUcdqfCJncS4+vnweRJp/AcoBFaQ26dkAXahgdZCEFUUeYXtTUx2j9XnH67O3A7V+93aysWPk+a81ZHayCf7L3JBt4jRWB333TAc2k+1P4O3KAOz3x1Ayq8CUmLKdhomvg48POuUHrMPET/sjB8aHP+6J9bG2vHc0o8JC8IxkA8IHbWddwUAzEX0d+FFlqnm9Yqqi+h7n5qmnuSMbuJEASACrXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(107886003)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qCKT428GaVqyU+LVl/EGmH9uf+oqfOo4eyRRDYLKvzeIn+ucRhsNRnUg+b?=
 =?iso-8859-1?Q?Z1vC/Bux83ZWA0G/3dnj40pcKOgUgCzJxBG+LbnA2YTWbnORCyjh77LKvl?=
 =?iso-8859-1?Q?jut2pC/05UEBf2F4Hpr8OZaLkcGd3QB4qIEyFqkEQiQR7cJcGeTN3w2R97?=
 =?iso-8859-1?Q?9NlYCT26wUyB6N+TwCigV1kmFmKxCeWOjYAAWYZPLkLMOs6nxv/o2d7Wdz?=
 =?iso-8859-1?Q?hLVHwej4pi6dGT9+piiim2J+pT8EaaWk+UvVxhGi/CoYBEJ0BhvrpW+b8G?=
 =?iso-8859-1?Q?o69za5/Ri19Jtc9CU6H5ctP3zCQBBUvEfaIN6Qx3oT52ya7w0rsf/oYDbI?=
 =?iso-8859-1?Q?0QJnLd6B4Z8DA4Jxv26aGKmtKs2dLYHCq2d57iQpGqAHu6PRmDQtiFqDrz?=
 =?iso-8859-1?Q?0VPkrwqC2Pj6Hm7n6Oj7rYuwXWK5Onn3cDUXd6fvlADq79NaInjVQbHRdg?=
 =?iso-8859-1?Q?gj+E/oXh4fNKq56XavymKBCNP6ZhI+CWIadCodYIm5Mq1WOq8Ye2kvlIim?=
 =?iso-8859-1?Q?EWiMmPmXCF2DYegEnI5CCXpSeMoy7fHSl20a+lGqJO77AWEjGuT0JwoWJp?=
 =?iso-8859-1?Q?XMCpv6lewcTbfNUttGkCflPZDYHEM/tFFG4Ae7XDWF1W78bZqq4Ti3xQjK?=
 =?iso-8859-1?Q?kSpaWEiegdE2xqXzPQhFeaYf+m9RPUYAnVqBOqN2jVw4ux+SDK5lZakdGv?=
 =?iso-8859-1?Q?eaSBsDEjgPFVBNeSul3ox/fokdRanVVtkJUS/iIfIOvDchlv7woE6EKomz?=
 =?iso-8859-1?Q?3uclSNweN7stl4a4/XcnfynJ7NgwdLvBuy8PH+OjXcAQlI8g4HBy07cDmv?=
 =?iso-8859-1?Q?n/7c8azYvuqakAn1LpZJv1ebqFAaiOE8Sqhdype3hacLR5DmoAACUgzQdV?=
 =?iso-8859-1?Q?I2sTZcIEjtqmbKzDYhOTha0bYKAVyuBVJK1PIkkzDEA/XMITkrgW3yPRKM?=
 =?iso-8859-1?Q?9494VhSTpT9EH7GCxcnkIBkfhJntGnZVdndzWOetdY8XxIn3yb9fDyzWzY?=
 =?iso-8859-1?Q?94HTPbykNr6xT9rosoPGMsAmFQlfDu6XhY1LYZH0dbdF09q+pJFnP+23bP?=
 =?iso-8859-1?Q?v5Jq/RJMoknG2Rqnkiyo8I6U2/CRL+4JRcc/c88ff18j97c10kNbsl5NeG?=
 =?iso-8859-1?Q?WSoeyk6HXzN7Uq2/ARpUXJr2uvKz7SDYNgO3nXpn+Gg/EGgJCFvWp+aD1n?=
 =?iso-8859-1?Q?WdLMj2pPhwbNibdMFtSG+K5hxmqbWvGC5LqUshrO2PGCH4eLerPPoamKqg?=
 =?iso-8859-1?Q?EPv8puvTPuVSf4XYtskwzdpOZZbpJELIJI6LSaHv2FyrhfB2b7zYKUj2zg?=
 =?iso-8859-1?Q?SudXNA7N5GWh5erfguE4uRz9B728IBeLrdUrSagtHbWAHZbE64cdDRYrPa?=
 =?iso-8859-1?Q?grmlHv8557atVA3o9WDV7iNbVw0aMXB+oIA+sym7mIQrD3SQG1o0ofK6LK?=
 =?iso-8859-1?Q?1fK8WPWGRQ8RDJ8j+A8oAKdPUplD2YxJg1KIp1pdb+l0irFN8tkGi5RQVi?=
 =?iso-8859-1?Q?h5rphCSajKSiL1Q30FqyqlXme6xbqqPfdhJA/u3/uwIrxkePvcyEIP+WlX?=
 =?iso-8859-1?Q?bCL7ivzO/Q03CzjiRtVwfH1aSlreT0IDcnYJ+UTTMqFYkT+zzsCkwHoxQt?=
 =?iso-8859-1?Q?qq8MMlBsVYm+PLrN5c0gll6R0dsRTe+F9q0DVsNbwvSbgzth5+Q+OtqQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b2c26-b489-48ca-c456-08da844fe230
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:25.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzZsmcbAWdFFWUW+Gq6mnFMocpzOnxalh/Vq6Ze+dOYef9rS4k2w4CQjTRAXPUuZ1i9QyixXaPfZyssuoMMs6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: dWU_BiEAmT45iHYPBBadpKdHm0E5ZHUe
X-Proofpoint-GUID: dWU_BiEAmT45iHYPBBadpKdHm0E5ZHUe
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

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..35f2af85b9bc 100644
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
2.35.1
