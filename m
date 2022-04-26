Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF95101A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352592AbiDZPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbiDZPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C41524AD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT4aQ025790;
        Tue, 26 Apr 2022 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b0rlPLKD1xf+y1ynvyhwHjtGv/hZIm5JyHvrwmdWyUk=;
 b=aIJxoHjXWhCS7s0BDIoIBAu3W2yz6MZeEUj0Y/uiEaTgSZFMiXWBKAIUh7rmzi6NV/x/
 lH2WE3J3106x2IKk4qgRXTxsZu1iwunu+pO+O6cOx3sQ2DfRpUw6HPWSXGs7brguv+kO
 z3mPdx5Nka7jAca7vW1huEGt0pVEmX09l02IptVDu9/cR6JVMJMci+Ft0NVS0bMsjfUu
 Fhlm+RqAlH8F6IHDJckhLK4yTmgsyI0ikf4WeimBCvrJeAUwttGP24TlK2KeGPIhX4a+
 XF7Rw3ZikzYHrcCKiMeXRbaIfbs96+wytNrkhsLgOXN51vbLAo7zSm7CMijKSzw3YzWs Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urn037859;
        Tue, 26 Apr 2022 15:06:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGE3KBHT1I+uDiEwtTOqayI+FaePkTrx6R5LI9vFolNFUBSOJiNLk87p+4Ax+kbBgmMbMTIWct9ZqNcrx176VOwPEq7jQaXH+0V1qpUp/Ma6QHI93s59WlzQ7EkKONWdA8YwOZxcHpyBY/LLN7kUd2Sy0FTbn3G+bpIXlMfrRHuPjLC2U3rh+iEteah4NaBmOh4yE3CgIJ+eMRL2OFUsEsrYfnX4sfZbffjHxY0GJyfxF6oW80HZLZatyWyigXOrauirlN+3I8Px0ecbKXg4UAq0V3NZv6685sfTW42Gl5zrVkWwzXa94jgsBrDvu9LCMlNYfGi/F3kYFGKG7DnsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0rlPLKD1xf+y1ynvyhwHjtGv/hZIm5JyHvrwmdWyUk=;
 b=MPikhT9eX9Nh0HquMrXhfpYwToECLpE0Eh3QC+/tvN6vNiys2FG8xRvl2wBsPm9KnK1RC/XupCcp8QQy/phri8qma2gBvYd011UwbeT6EbdL0lqJtuF0sTRgb5oZY1lgK4NeuThANTrt9JH9g/QT8eGHFCz8lx2EZy+bIhbX8nPPW4hsFqdU2odJxDJVh/LKQzPW9KfkXIyHOLCdATT8bRntaRP37zFtHhR9Hatg90j6Lbt2FFLekYc8kMYhayPygemNmlnstErcIbdwPVFi5lBKnVCGnYkJiaA2H6q4x/ZVaeMNtkqv+3O6gAT+shyGaNQrJ/WO9IqCjfRStwC6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0rlPLKD1xf+y1ynvyhwHjtGv/hZIm5JyHvrwmdWyUk=;
 b=H0uqrABcEJB+6eE6VRnXMLffaVhFw2sTFZfnqWXScsi3Z3/XBwz6OJsSTLdYDxGQBbgxkge2m+wkQi6sRH4zGAkHq3GMuDyXwqtXeFyKr/YQZSS9z8EcAj/0nqBdmRoIduiAzUly3sAXRDbyzcot2ixwDBJMHRGjj/oRFqDLYEA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 11/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v8 11/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYWX81jwz2VDYzuEC6GWYGpk9/ow==
Date:   Tue, 26 Apr 2022 15:06:30 +0000
Message-ID: <20220426150616.3937571-12-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e218ba-efcb-4a45-fa82-08da279658df
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679CCF0626A4FE4450443FCFDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guyTg1Mqm5OLIdDFLzjG3hHD8xul6rAPly8XIyuonIPBAIp1P+qnR0tt97rR5OgWZnibnmx2583OuBdPXECNC2IhJNhsngtUNGvTBozBkmTQU1F3bwCW99qivMgF0qYm+Aa8gf3QE0ACXdNZCekuAZmCpt3PvdcK6oe/NYBDPRuvxkG72S6O9Qcu2Y3Yu/WjokTHQJbllc5qP6AIEpBQ2ytO0uGy+b2e2xqX4xBurMQq6b0IUhUZtEKaTdXvkCPYEPLCAUL96wD8/9m9pIqBh1NhwDRLV4UMj7/2oNVe2FOsIrgkipwDwwCyQxbFcLl9jUWQEG5LCraUcKNM6lxzdxOPyP7/IWqBdLByOK5yOEmAVATXRXYmU7SAobvCNvCjqPktA42Hu/NcyNRTqbeGdWtpcKktWY708lSDP7G8HM6FiXw90MxdamJG7zNKgZifrr30DHtDGbTV3SWM8La2u0XVMLhWVYVe674GWJi4Qcrod6DKgJHW9iDP6svZPijjxmVrL1HB++P8WYn2xdh6WcglZ0hVYaUaa/iIBW2KmtLD0A6u8UzJ+rL322hVrQSEZwfDsuNexGy7C38QcmRXBgi1ukeO8tSZBplCqMw1JXwxDjAkA8uf+6fS8KPWjItVGWjFml//XgmhbFCtqqOmR1JCPdVrAzXGkATu4Lfkzs+A07fdu9P/nGvfefWaBYk6un0qNWeMKGI4TukcPkTd8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fhGTa+6Amw3KGxBHsY0KNHL+AEwSZGh8MucQP/yi5+FSfJZu95FMF8ISuA?=
 =?iso-8859-1?Q?ezwrHfX0emG7QevHrOt89vIb2zG9V03ikJBZeXg2ACV/00IYaZIpSQAvxC?=
 =?iso-8859-1?Q?J5zpRorcoVZMpClDwdjcz2+BG1C/1Ora0yDF3IwKC8/6TLpht/PmEtD4ws?=
 =?iso-8859-1?Q?pRSeA5Ks/J4OWEkKBz/vLlFdYtf8Q5nVQZrdrk6XVaK+OVZZsSL+koZWSh?=
 =?iso-8859-1?Q?FbYT45bTaENi5O1axPgQ4Xlumk9967zV5qEQLNs9Ng9ym0fv7DabbYbyjL?=
 =?iso-8859-1?Q?ILu6AqxMxEcPYvA+r40f7nyrFef8JQbtuvFMcSSGM+1vJVCz77/ZTmuRaA?=
 =?iso-8859-1?Q?t2SIhEvzr6EMr79d0ZYtTXenH7lS3qIe8gePRSUr1dGpYJ0VynHMUGaFfR?=
 =?iso-8859-1?Q?ZLKchCEIO4YPVd79nnqrAvia+lSy7w1EHsbGS/MES6Qstdyz190lYu/qID?=
 =?iso-8859-1?Q?UkKGzDWhksBpKOoU8g24U13RsODM4PEWU3WG0fWY/yJb5LiVkoz62tNUxO?=
 =?iso-8859-1?Q?Yn4f0XmZp8RjeCymo9A7tF9SXtiRW0Ve7y1/RS5SLEpx5XkLnLK+vbGUPJ?=
 =?iso-8859-1?Q?bpYQtgE0nGKBo6Hci0ngRKpqLl3n9at+6ZHhqrUpSyJl1O/oqyU+3c1gx0?=
 =?iso-8859-1?Q?INAXauUho5zthgTRAXQb4sSuD5+BDUwlQysCRghY0C7lYfcAN26v/bjGO8?=
 =?iso-8859-1?Q?4CqOjzD99/9UgcRi518LdlywrIbADoChhXUPNmF/OQLChpjiY5Kgj/JcjE?=
 =?iso-8859-1?Q?n2agUKHnj1XWk2sBe7z1OiQ0KPBJsi4JftxFS7RBQidals5lNXt2AW7+9i?=
 =?iso-8859-1?Q?a2eQhTyOsV7qX3csrOpOdSIfy6XP36W9UQ+axUn5nl3PQTeVMLU4a68LHV?=
 =?iso-8859-1?Q?s0dt0+NZWTplpqJzgy7hrERFyQXRBJuLbI/cxk+nrWVJ5UwrcglKzZ3zT6?=
 =?iso-8859-1?Q?mNCUNdt9a2xfxOmcSyRDJa2jl5nLuSN9Bf8fefj9AB//tUbATX1WrA7Vrc?=
 =?iso-8859-1?Q?hD20fQGBxnsjFuM7GxhMfVrdmsl+YmpvrOpq58GtQG5QMo+d1idsqLXztB?=
 =?iso-8859-1?Q?h/hH6NfrcJfeXo2ZEeRjfZQxp9Pii70T21JcanWTNSkAbDOOKGdlx1EdtF?=
 =?iso-8859-1?Q?+VAWP0hAnodDjlwa0X6vpgTT8Uz+AWJMj/3NxpXDnovnPRNablnf/7/c7Y?=
 =?iso-8859-1?Q?Xl49Ha/n9LaHvzHuMZwyQk3irY6brt6JL1hlMmeNuETJllXgiTYTdRGJhS?=
 =?iso-8859-1?Q?uRo5X2OczRg+sLtF06jFd/2/wt4j12STEpcRvpuSw1g8Y0yg26kig8NYz4?=
 =?iso-8859-1?Q?9mTLMDBuuu4stHEJNJzfcZXJt3hvybVhBz3i6W158FtmK/Nb+OjF1U3NI9?=
 =?iso-8859-1?Q?+B6J0G8GgdwFapS4s3wZxbd5Bu8oYNsibWMVsjoiczrmuge1kD66Xr0toH?=
 =?iso-8859-1?Q?rCsNg7HhEkD5ESRAox9lZg5a1CY1HLxsPG1mXWiRTZyAkB7dn+Hcij4em6?=
 =?iso-8859-1?Q?2Co4LtOFTULCGbMaOlhQreuo6cYhL/kUr8IW9B9vJM49CerN+54h+Svwr6?=
 =?iso-8859-1?Q?zzarKHlyzTKOK2GGa5N7E9BXgz4jDjumD2YB1GEssAkRW1MKhmFdRKLeql?=
 =?iso-8859-1?Q?3kOXSU/+dOdkWkUv2ipI5sAjZUl3T1bRTMuasKG/lNAzIypL+aIvJw6RSv?=
 =?iso-8859-1?Q?a4L4yWtD1ujDPt9/WfAJ5SaU6N9ulvzoU3LzBYKp/2jR+uV7wR8EXY/C6j?=
 =?iso-8859-1?Q?bRJ/M9Dh52nkahEAzsggLNRj8ttXiR6GlxYauT820wVwRlz3f+Us9J1kn5?=
 =?iso-8859-1?Q?v+5s/GhzMca8SUNyPc7DgD1TtuHXkoo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e218ba-efcb-4a45-fa82-08da279658df
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:30.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCpN7wBAKzti3b+3S9W5OyYO6PwwMIvs82UdD6Diz7W30L4+PsF6RfSRvUrWN5T/JYDL57yUnyx8lOZjqIiELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 8Qpjxcrhffuz04CMnvLauZEKQA5BoMc1
X-Proofpoint-ORIG-GUID: 8Qpjxcrhffuz04CMnvLauZEKQA5BoMc1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 176f114c2ad2..041a706a10c1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -678,29 +678,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
 	}
=20
 	return nr_pages;
--=20
2.35.1
