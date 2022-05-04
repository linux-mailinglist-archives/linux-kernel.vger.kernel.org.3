Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5EA519366
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiEDBVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiEDBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB4044774
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjMlL013507;
        Wed, 4 May 2022 01:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=Ue7sG48bTGMr9AdDT5oOE47k4+QLW2YwNzNMpBPBxsGehVOSMzz1l5wE1TOWoMLfW1cl
 iWbUALkRUqj0nR8z8ma/jG4LUyg2Qp9svuYwzUxXJQadbk42A/fwOruisK6GWUzY5/hv
 puN3ii7oR2lcCZfKH/fNjvwwwzrPGHOzg2awbnWXGOBtF3lYzoDnQiw/iSVIcZtK95ME
 9eRIFFlw6yPMOOW3uJJiqRnugca1+uyny0AAgo47P5iYmNjak1jUUYElmVLnXp5/0Liq
 P1VRJdys1rXEw6kKzT3UZbd8+qBKY/lVfS6cEAH+rJxYGljDrXqDLQfW38K/H9S1Nx/i sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR3013207;
        Wed, 4 May 2022 01:14:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp1AbtHr0mZ7CdsKW3tvk7S4nGIZ14bVOZTi3TALkRMR5WK7KydzAy5I1SLKzkzlHDHODaVvm7f2WUUQ4qI6OQU6P4J+tuY/Dd2UasyCAWUnvIb9Tt/4NZTFUwdo0c7KOvlPKhYAqFMez+cFSUUGFKffIrdOrl/uqhJr7BQJfS7PBZ2SoLwKIdtPkNI/xCAVmLKEBIuMp/CNQZ+Uv39M8c1ivH9Ki9Ii/R/zjMaU5P265RAk8r4V6eziz0QWYsCLhazB/pc3D5miE2toJV0gEFYQO8JK6OOdVGO8IJYisRxe8Kek6rwkUtS1DO/Zf1hx2GK7/v5BKTx+kxDWk3avoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=PjCzB2mFOLgA1euVYf0XFRo9YbbvV42kUjHywI0uQhbDWaXVKypJeIdbBoe/HbMolj7mhS09pHONlguwLM2Wz48VRLvA+OYSzArDtDdLZSLlNjUrTF/CPUYylEOIHtmRyy1QB8RDOs1RF78xXw+RpgAUhavHA2B4q9N230FYP9yfqVRD6V7UMcAdXfvD3s87WWtol/IbGsTQyI5Ut2TzLPacnbIg4mvQwL4cC4axz4ly4TUG+hipQxw9ntYgc5c68RFjtDZ5Ci4pVpdl1vlmcIVfdn2pz0m4Bc41B7MM5xFoQByBYKFkG2pQsCwx1EJ4r6gkuA0Ytrx8PsEbMIoHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=bAM4omuwBOQqKCDTO+2Uocp13IOg/+4+q0UgmxxWHqE5D4R6PzJZoTRZaeicKOPudvaZkUx1EgMWdYMkFtZgy+gabib/KucXZN0IgtbNAcO/sG5JIFUMtUeO62y13KOioNVoI5A+iDT7pKZAajFkSdnzU13GUHrEt+H5BcXYjd0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 59/69] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v9 59/69] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYX1Q/yjQG65dHJUiOH68fc0G8/Q==
Date:   Wed, 4 May 2022 01:14:04 +0000
Message-ID: <20220504011345.662299-44-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d54346b5-a234-4cc4-3b17-08da2d6b7674
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688C624EEB9485D6049FA89FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uO5jcWj9GgfdjZEKcJvh2WIAyPYl7phv9luf4QFXXpS3pMwnPXCv/+JrAdeZXfknpl9xqnwWSzPOVFKrcwaH2ID/iza04OGWmQQokwP4qcojScRR5T3KirSiJGybhvgjOL3kBrUkmKwhva5gSJsuT29LsMQrLgucUB19axP6dCWBhdPdpx4UCqY3CT7gxavET/nSzFXnbyDBUWR3+6y/OcsUYhj4aCZ3ISgooSEq0IDCQqAwr3qwdVEoODWCcZEKxehHzpG2BaIRn8FXN4hHTSkuZXAIbLYPyHpzwNfL2gAjGF42F7we+AZIDVV2ZYWQqno/DGePZjVn3AG6LqdQ2o9wWletW8E78Drmt+kmXU3XCahguBTohg1ovBe8S67+h5vPFk+1BpNztpwhtYxhaNn5OapgXQC/WHIwg4EKHwJHcLxv3zeWRyhoTM9BT8gHTc2XSB3fy66K9e59EhNZpMzfHwN9UvlqEMxuCUztFTpCp84GqljSSAGLnSMblCjFi+3bb26VJ167b4I7H16JCZleARq2bSa6vzoT+p5j9rQB6JrdDGFPCMIaomSYzLzzYCTo5J29VGtRjv/v3Zpp8ozYmwceV9ACZpt4aPXS80tJwQ76VyM9Zv+x7QNix2QCp/vzQrzjuDtgxEDbp11vEpe0CWjxo5S1OWrsz7UnxGVUCN8cwtaN5P8cdCzWdbmOfm+zG821S8GHsoJzJ/ZBxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7xArO6/LhJEx47lA5cJhXb90Gb4u3DiuJgqw83x3QcpEW09LiPgk2+50Hg?=
 =?iso-8859-1?Q?Vj/CsF0c6ZmRPUDJj3vnAtr7JJRxNrUF9nEcD4bXK2pQfga1Pgb2/qlapQ?=
 =?iso-8859-1?Q?XC5BqerKsNHq2tdU1ESOxU/LHfrAFOfZ0Ok0p1OjW2l01uu/kpHEoKGozh?=
 =?iso-8859-1?Q?wR90lE7I+ekJE1APTErisuRI0CPHqIlcL7e2C1ZMdgL49XbsrkMSRp19JW?=
 =?iso-8859-1?Q?zj02nQ2Eh9uZFhUPPA1U0n/ImSOAln7XzIHkNnT0mgdkeFSHze4gRtfc/y?=
 =?iso-8859-1?Q?qht/TZfR7qVm23q05QOOWb4IvXtk9D4wITHNgdpnkF3DQ4Y9rdglrKPgSg?=
 =?iso-8859-1?Q?HleAjjgvRsIIs0gBxbvz8ZibXpV+IDSZ6CWyLXvRvoy+L7D4eVYJp63ph3?=
 =?iso-8859-1?Q?0SG65DR3JptTPlzLf9QMz9VGVr5lBw/6UW+BarHeQ8OdT72xLUuJfIif84?=
 =?iso-8859-1?Q?FeYwguk1GNKyyzIRh7UtX6HFoMKNZaW9W2umOgg0iyw99cMwHLYM0/ASZd?=
 =?iso-8859-1?Q?hpCiirjqnnYnUKEcYxrcwWc0l6io0JqkPOmHn4Z6dEt2TUYyeg2HWrBnYB?=
 =?iso-8859-1?Q?XWrY/prapr2zrNhn2Va5D1moU+WWvxo/37EN68GAJjngB0lSjgNBpC22WG?=
 =?iso-8859-1?Q?1BjTnxIU2gxhCMz1hvOY66QYY1ZshHgkoEKtDG3phDLj+sAbKNDun8laf9?=
 =?iso-8859-1?Q?ml+DuREfwUTvsHucXMxOkUBt1OnUr190hvj/Glosd8012TyF+kmxZyex4k?=
 =?iso-8859-1?Q?mnBiJEDTkwQ4VxfIQZvfbPy9uQ3+BKlDCk8+yWQcj759Xgbzbx1QteNOtB?=
 =?iso-8859-1?Q?GwOwN15BYalYF5mfnWP+kiUX5h3I5WIATEqfFkO6fLafmbTKVUPtAIFIoC?=
 =?iso-8859-1?Q?XP5Egc1qfQfAn3trwj+7zKiSZhm908vLDxVBv7yPryn+JpkND9sZ3BRgJs?=
 =?iso-8859-1?Q?YCwLwDPqFbYidCf2D7a8VF3kXCV+a58bIQlHmwIrQa+nPtupwrEFLkgRjo?=
 =?iso-8859-1?Q?IRYziILtoVzIGS/HhpcV8hmSFM8WUfZB1GtgY8hsTON93LPCHzxECdpJkM?=
 =?iso-8859-1?Q?ON7m16Jo5Lf93QcoAAaKURpzDqtbPU0sSZwobp7MPgAeXRBZDjogiJ7wG4?=
 =?iso-8859-1?Q?7Jyk+bSazsMqOiLNwtiXLC6ejPP9a5/1WCh3MgJwqWknlL25rYc1yZCjOl?=
 =?iso-8859-1?Q?nVkC0J33PJVWaTh5d8SQl2F+GlUu5oDv7YBIGm/bb8gM1nzxvXu4VNH4b/?=
 =?iso-8859-1?Q?s00/qHR/c9nuO1yaaO+PdvnUJqxFVbztzBw4lPmD+hJpK3tBdKjRZHnvZn?=
 =?iso-8859-1?Q?Z0lDK+a1VAyF7U5uVaP3PgDFIgHWYqLb246ukIDg3maeF0beqUuEnZDYEi?=
 =?iso-8859-1?Q?i3iQr/5JiyOi8WXYXibj8YFZaV2Z4gqyd5prvAMUDQ4qkcLeALfO/3Otj4?=
 =?iso-8859-1?Q?I4xWZw3NYJN7ERjledxjtTM4KxwgWpRSPOdnjuS1oV6J03i9ZX+lNrwOIo?=
 =?iso-8859-1?Q?fKkPgavCASiIA1Rp8KrjhChOD2C8EMfUHqc1hDZWfBKTho8wLS7fTEp2pm?=
 =?iso-8859-1?Q?i5I0q5kWh/zxSrJFqLxr92W1iCKiBz1hXrVe75AbZL0vcINP+gTCgjA2zp?=
 =?iso-8859-1?Q?iX2q6UfjRQO8DakeJgPgNPegJlp8kV7liA+WY6ysqP1l0QD+n5WF1P9MuY?=
 =?iso-8859-1?Q?sLgb0qLDsk5NVlbghoWqgwzTekbg9DLLVrQkePRHAdh0c3ES3rBned1rMh?=
 =?iso-8859-1?Q?WGAQOfXunW2W5OZa/oiaXp5gf7IJjV7pV6p6vZRTcMkoKfdrN6KRAPszYD?=
 =?iso-8859-1?Q?+vRbltBPH9DjJWUO4fkfAhzAMCqlApU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54346b5-a234-4cc4-3b17-08da2d6b7674
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:04.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McHUyWCcpn/KcAw5qRrIvwM+fK7B8x8npINkkoHZ37oyij0v5V1AgTrwSC1dHRMB4oRgWoc7za77Fz0CiiOydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: K7yzf-L_kYBbiJeDjKAjJHInXMm4307U
X-Proofpoint-ORIG-GUID: K7yzf-L_kYBbiJeDjKAjJHInXMm4307U
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 4495f69eccbe..c0d32330d435 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
