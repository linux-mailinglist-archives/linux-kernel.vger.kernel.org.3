Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB651935B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbiEDBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245310AbiEDBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7459443E1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KvDsf027626;
        Wed, 4 May 2022 01:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E3DE+Kwb/pVhOuXhZpFjAXwBRuRbumxfeOXhUy0hjwc=;
 b=Js7d//SHSFLBiQNB/VFr3lvKIstyXjIgCRvrcUtFkxvzh40+DNmj6FIzSjq77N2whLAa
 RdE+lpYqIw3V/72D5dBCC6+CW7lIHOsI2UPmWt/N2aptxtCz3Wiz2iIdBL0DOaHXF8y5
 /YlmB2TYi5yWv3qPvR753h3I76H8WFa7rwbXHM2tULYJgpYQALrm1ipsmXrzjZ0avF0p
 jGelc7ubNTcolJ92JN7KjziQq795tZfEIjT69WVcanyp93mRW8BmFKk/hUQIyhYNfNZ5
 tjZxpHG2oR8Vvt6AxrX/GGNDIBk3+QSJQ3b7PRsEf6/6FMvYGtEm79KY+G2iOF3XsTb8 Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT4001264;
        Wed, 4 May 2022 01:14:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBAiS0zh2YcxcA5s/XtBt4XesTYKz2+kolobTN4TYIsR0a1oIoUBhbQC6RHVbtlow9gDuEGo3+cQ1l4pFbPGYWV+fV1ZWIpeTS5IN4RMkQvhPfdeagnEWftkJgysBJnB7cPOKxsKLfY/7ClnYGrp9lIZlTsGdIdmC/kKv0Mtm1GTWdZGMwgsrJZZYPHi530C3VRZvAHgMJ0IoGvdllL/OUt8iAWYdjTPQSYHJXE4L7cwBxLCwToHFSbftgkQsNqe8tEgC31fRGYGLDSpy51EEI2XLwCoEis5YHNSgwzkYMfG7VRFCfrpjoEbeDMJFcI8lbH4bISsz0ub7ebGGPngsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3DE+Kwb/pVhOuXhZpFjAXwBRuRbumxfeOXhUy0hjwc=;
 b=V3CJ+6ut8QJ880eWvPlwZz4PaYBSkK2dfAwWS8FD7H4MF6pYqdg4Z07jPqdUU/IPXmf/6ML+aKA10TQ+fHsKG1yUxlJ9Yozm/W3oppvlG5ZBsCAdTsZpZoaVuOWQ9n3Wehz8CRgmRXqa8x1cgE8KgUUab7KF4ZYbi801BJwiO+58MsrEDgMVHiyZKO4bcTu8D4KgBXre1/rT0P5dJJHoLuPdfUQ/vnedBTvvQpIQXCAI4d0ZEy0m0JNEiEzOtJoAeCPn+8jNGhyWiFxs9hZju/A+S98D9A0kpxUVcdAsZuakZKf/XcwNNdOGwe09JJORv3CrBYDRiRuCAgLh542XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3DE+Kwb/pVhOuXhZpFjAXwBRuRbumxfeOXhUy0hjwc=;
 b=aDVcotCa5DeE0FNsfezm1Tmwx7jJBHLI0wox5ldiiLQz1epkfoDDogGfZoJbsBp/00mS2Um+uuPnVhiloKvXloxlj2OSxRvtunIJaz9kLv+PmIt/vovw31uG2iI7RohoTl2c844ZCMJ/WiJFJAuCVxvpika3bpZFBdj1AiOwKuE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 65/69] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v9 65/69] nommu: remove uses of VMA linked list
Thread-Index: AQHYX1RAFKkhMsx7ZkmEY0IXoTZ4TA==
Date:   Wed, 4 May 2022 01:14:06 +0000
Message-ID: <20220504011345.662299-50-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 242309dc-9c2a-47c6-c72d-08da2d6b7788
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26887662FBDCC29EC42F2C54FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UO7MvWxClhvfp3zawWaL7lbgi7lVoRVjakEYG5lbpO0vVo2VAdCM3iS9USYLHwovo8gYc8D1EjkCfRZegoxAQumcT+L/GL+1lWTK/u4JvrtSiowsTs3BEqU6IOysofO+GjjkdzlPDpKOMEjMmV7tXhLGZQglJeL2+MzoktzTA8yruIVMT0iqh6vFL7XQ1ZzXrKNeg84gPA2DMp/o+/1byrkCj7d9pZRQEguo6Lo5YRZ7kjSY04/KzM7326zBAh8LBD6C4F/+q9/UKLoBx3dsMQYbrxHvdRvrwGdmzn3k/oeb0xoTp9HIQslEF3oOerj5ThboyhOCJPvsoqR6wwTno/GZId192NLV7Vr1OgzczxQA7vz1LQW3T8AApZEiW6vuOt9DGunQtSNFc3/+QPv2SGtqsoRMRYrqDKJirgqeBzQzrk86JUL8Jc2FNBKdFVs1flQBA8MDsB2jbi5FISfweUeWBwF3v9BS4buIzqOAje+BUeXe3BOXP1p24iMD8/xNID6pufVGoGyTmk+9ERHhU3jtuc4/NA1yclV4eX8zneh8ea9KGZz4PBt4+xlxFw1DRKY7C5KSpLepjv74aGeVIOrwSBD8Y+F1rfZXFvdG96OEGZjwvGo3hh2B/nOobbz2T+nfo17dm/eSdpqDR409m1Ckhqjrom1SnvdkBb/LLoKJ8MDgzU01d72FqLIcvTAhE/wBHFye9RXgSAe2uyNaVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X5OPcP8IzUG+GrP1cSyG73VEtZnQasEkp/19qDFumzFb44luuTmPRgL5QP?=
 =?iso-8859-1?Q?PdCUrv9fT0masHD0QCDdO5BHztFSYlvmECDQ+mP+qjfqsh0yqt+nBAakRw?=
 =?iso-8859-1?Q?DZJ+CqEQOpcrWaoPaYbKju+pKU2VcLepQNYyNsrmM14pmLoBu5Te9V/FfM?=
 =?iso-8859-1?Q?Jy7PIEsIYfC2o3BXrkkigUfFkr2oZC0ebMRYpYDMgYfK6pB9+PFMazyGPS?=
 =?iso-8859-1?Q?yzn6iphwfrhUFh9j04ul0BX2kC2NrijhatskF0rx+DI25dm7epwWUC30/l?=
 =?iso-8859-1?Q?d36TwsglmCpioGThNHQSohIG2HCSNsuLBMushpprd2MlT1QnRUmmEnTccy?=
 =?iso-8859-1?Q?Mj6ieg1fL2gY5XG1+KhQiH5C42EgY/jrv361FLGDlQTCcErX6Cc5IPo9pG?=
 =?iso-8859-1?Q?OzLxd6HYca7gCwm/HvfzodZxX0Csqp2kj9dkYOLkmbEJKnkCy8kS3EZlnW?=
 =?iso-8859-1?Q?Pn36EvLnL+bkkBEcTOD4FKcvPOT4oZg3xd0Ysr7D5etsY/Cxk8zGbLASXL?=
 =?iso-8859-1?Q?VUqLqUnZidZMWbn20dMaQRjubZltLEXWjMCJ/B2Bh2ah5s5NzqEawyMfgz?=
 =?iso-8859-1?Q?WMUCXD3kLkMYhxAqqe1pT0YkYb8WNbdSPvlP2A5Ze5lbRd9OgX5fSas/Es?=
 =?iso-8859-1?Q?Q4J6ZU0WRyrSuuTkDiqN5dFVHoSymJ0KBmGeQRyHUY6FQO4IXyuNmZ6pgd?=
 =?iso-8859-1?Q?d/li8hExQ0f0fC2tpDOjirvEvifevjghF2WX0NAiHGRUMyY1R6nceKyrKX?=
 =?iso-8859-1?Q?xA01EnbCg+/aUpmOGzUQGw3V+qo7M6xaQjcXbdjCGsO9NM8lfwkEj4Z5Er?=
 =?iso-8859-1?Q?RhgaGE1gyicIv3BgYPM1IrwFEMy0zUGFn278UuTOv5ga97thWZa9UjKpfG?=
 =?iso-8859-1?Q?Dx3RnKWjB1bwk39pZpNu5EcOoLZSst0IEZ0BubaX28iqSZVytQl9cEiVu2?=
 =?iso-8859-1?Q?HHds6bwrZodr0qygPeoOYOErd0A7t5H6SY5bHr2Z/pGrtzbVUfFA3GJ7mv?=
 =?iso-8859-1?Q?0cHXsUK+k1qQ1qBy6HwkQA9vY2hnWGXzlbA6vzNCpX96Hv1VkRClmmG0w/?=
 =?iso-8859-1?Q?9AQoOymAsTxaOA5mvA1oh1Qn3XNYSpoTSHmMPMxiBzyuoEH3AG+mgb9o+C?=
 =?iso-8859-1?Q?HWi1l6+ayxadyiL+5sMJgKy9EZjN+RC3BcsUO3x3ZhkPhR7jv52MZMJVc3?=
 =?iso-8859-1?Q?rYz2+cgmnMgXnsN3icD2cOKIHzSBtbj2YEGPKtyvXbPuLxB0CphM98SljQ?=
 =?iso-8859-1?Q?qn3jaT2CZDklalXFEOghNhWhSKS4fyIYZ9yBnexh3nzWR1SuS0ceRydhKP?=
 =?iso-8859-1?Q?b0TnvpxFnQK5bReSokI2guR3OhbCbfjAqCR+2XH1QIG5zvxjlSHJlomk4K?=
 =?iso-8859-1?Q?rGNPFvJB73GFv/F/MY4R/XX1XLFxWVErdT96xR6XMthh07ltyM9NzGHuC1?=
 =?iso-8859-1?Q?0bOCq/nFIIc6Wqxk/pG88zYOMBdBa2fGLTtVRKP+08mhMH/8OTMWdNiKxi?=
 =?iso-8859-1?Q?WL1kK8cuBpqUAhwTguFIn2HnIerZ0466ZVOyXYYXcajFKfT8bayf+ghkan?=
 =?iso-8859-1?Q?W+okPt2XxabfGoymTkylGTbKkqULoHWvttsFqumcWnMcXBZQYVLwNDW6C5?=
 =?iso-8859-1?Q?4i93wummWfm9z85KwkdG1nvb7NPRnBxOzxVQG/3jgKd/hF/4sI2UbYhjSX?=
 =?iso-8859-1?Q?qrcldJyF6xoZ/Jj07taxlsgkOabADEfPkhlLiRKjfyFAGoozwV3qj2R2R4?=
 =?iso-8859-1?Q?xXNzMMdC6gyrbIVGn79k0cgjHQGxGzhMcyhwW1T3DpEwGp6nbSlcpyz1mV?=
 =?iso-8859-1?Q?QUdvPV7U+SIY6spgC0ostDJgEMSnqnM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242309dc-9c2a-47c6-c72d-08da2d6b7788
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:06.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+ByLk/urMqpe/IHh5LMB7/sYy5GkyGEZQlGrxvn9cfm2g1M6Q/BCgQVXoc/P1MpzR5fI3eM31WIJXkWJD1JwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: G_zEQaaDAeELj57btoA5a1WXKSA1Wo73
X-Proofpoint-ORIG-GUID: G_zEQaaDAeELj57btoA5a1WXKSA1Wo73
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 1c9b4e8c4d5c..d94f6adf9c31 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1383,6 +1383,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret;
@@ -1394,7 +1395,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1413,7 +1414,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1462,6 +1463,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1469,12 +1471,17 @@ void exit_mmap(struct mm_struct *mm)
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
