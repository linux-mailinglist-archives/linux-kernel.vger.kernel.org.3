Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3124F1739
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378087AbiDDOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377998AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED83F327
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl8LS024505;
        Mon, 4 Apr 2022 14:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LcXhWvMSmhjRFEuGKGvgFB7pqNDRAd8mXS5O06aGJtk=;
 b=07FkC0ZPqXWdLp38EC9+p55POmeLbRIwneu4RTbjz+AlOqNq2P1FN3BfX+IVmzKq+jhU
 GEQSGc+JnJxM9MmwbXo5rxmXVRgC7m5+Pa2pX2MDkuISQCd8scBzqdaNh8XZcWWV9NL+
 SlWg5jc7gz27+LZvHgK+/V8iGIqXgUKfzhoEq3zzuuZr8l48s+CrPDgGMPFJtPta1W7l
 LcMHSnKYdDARev0rEBNGcqjx9scZvhYuUYdamPP/fm5ReIYIa/HrmhRkYsylHS6dBcDQ
 Vt+RagXaat8zVrSLYHASGZf46SSc71Ex0ru0mXiyVqxQewBE4msO1TGYKCLs7T6wDXYv PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcG9027665;
        Mon, 4 Apr 2022 14:36:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRkffugmGPu1NXe7h2fYffrkzoJTF7xq4+VsmxzJJeJAIKvAYiH4w1GSH61uosgxV3h39MjHOSPhufEEYOOfTbjzBsOhgeJdq13BqM2uKz3A54BjBS02Vvc8TCblkBp8H6J1y4iEDIctYJiMS302PyDuLzi6uddngxrtFq1D43OH1QFBQSAPoLr/gusfAowZjLCXdIeiSL2QArt1ezbZzqHpVfDQSj5Qt7Bb1vbU87aSXjixcvmSQ2576fPtZ3wkNShvzr4kcaKFmy6U5PrK2x0Te8mWAqqWZ6X4QVlQoo8/Af5agdHktE3VA9DJtuJbsOqH4XrA7v8xnwLC84rnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcXhWvMSmhjRFEuGKGvgFB7pqNDRAd8mXS5O06aGJtk=;
 b=ccmYaL+lTRWUAmsIW8CATECWXpzum5O/Gh976Zut+1ftuoBpOCbaFpajkCVR3Q1vRllI2/7xLtbzKV4JHayvQDtg/AMYYvsdZCYdGmkUeqeBTmiJCLUhvE+Gl7eITu/kA0RBiJ+QhUcJSS12Weq5hKtqZ/XYgba2Qr3otW0gKFVjXRaKrYg0tr927gpzsRu9UNsrDpiygeVIeZbhbJiHR1ywn/G0KL5MzVvPI1D2SNtAT++Pkp6znL7rNkbF+ShcV0tIKMAZ+kfxFAw4qSyQeT4aP5xHIs1PZi786PHvl6fTRQwp/YDIhIfO1NUSwIJBQWU7zFOkPq7CSTYmjozSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcXhWvMSmhjRFEuGKGvgFB7pqNDRAd8mXS5O06aGJtk=;
 b=Rdev8p7bjtt0osMMsDPp9gFoIjR+P5Fafh0TBBBnRi5O4otRVmBpHqGQ9DKwH+YiIAZ8Gy0sQe3oqdE8LzmW6LH9AIGfD/BFWR1OjTFLXuxmNuBKqLHh1zWZu9plvBEiYlFrPA0WqGuqtZ1W21aeNnSCMslw/kbOVumaVAz9V3U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 33/70] parisc: Remove mmap linked list from cache handling
Thread-Topic: [PATCH v7 33/70] parisc: Remove mmap linked list from cache
 handling
Thread-Index: AQHYSDFFgsNNonV1ZUaaDcdPdsSRGQ==
Date:   Mon, 4 Apr 2022 14:35:46 +0000
Message-ID: <20220404143501.2016403-34-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad3ecaca-1477-462f-bc01-08da16487c3d
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB138160E9A438FAE8DB20305BFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cb0kaPoqqRuOSuHyJWaIL5MSOCjUMvk1s2Oqu/lAT+VlzG5WhsTMFKfdg3zsi7vfWFYsu87qsRbFSWc1WhtvZcMLgKteqaOrhEFlik97hQqW4KEE0FEnfGIChY4e9YBbZJWvSD/CoH91ynlJvMJiIYn3UDLpIAuHAZgpYZVC8mkEaY1uG5pNzGMZNJsEByx/Lf04Nt/OsosYMN8CNwGnAOAhORsuAlLWjXAQDfUavh4ft/31yo6kNPd2m3o0AgR324kI5u3awJscZFWA6lo9Cd26klVi2+aX9rRxTsMFCOLGqPhwag+JPxYWv///JhEsEsinEPx7S3hbezpnjrAmRDXeFKRePJyFpkbHkxsz0hXe3X8BOokvTK7E/Fzum1p87aB2txOp/NjbabiMzztWUNXNf3GrDNDY3VNH+Op7Y1fVWBJmX/mSpvoHmgO3YzAomUhtvGwPirn0Ye4WIFbJbLy/O2OxpWJmBaV+/UANHs2UQsQQgimfL4pJ0/+SVCNMdXVxpZ8jAjVlDi8zUnI59otnYrp316eNgSm3ARab6aQaZprKJh2FdyDm07hDf3vD7BrAUpo+gr9gwXFkGHweH7Xx0Rxkuf/jZXMRKe3H2uWYSBKpqYofWXOVtSfC2wk1eVjcwhy7kApJ35rqvZkba6fOkHlapn1RZ8KODouFZ/AzeE8KzUUrmsRYP/nfmRyGR7/+i87wVBoQAwmIYKe8ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0YCgdtzt1hqv+d9eXV3UN74KS+Gpsi0SmaWcKSMDoLnlgE77IWKbabNDmn?=
 =?iso-8859-1?Q?07IXc0yskLfSPAFJWlqInoNAokO9yzJZlI43OQaW8C6Y28Y180zad4BwHa?=
 =?iso-8859-1?Q?XEQ4cABtaypOhSYjUI+c3UDol+DhdAMLsQg5TauofBNmHi8ucl+OtDRyjL?=
 =?iso-8859-1?Q?HqQkq1xzjJD3hcjUn/Xpgu+R1ENV8lefFC297Py9o7OAKWqDmPWL7h6Zxy?=
 =?iso-8859-1?Q?NUCqmzfpay8CXYHKELyKPqP5qV87g1Pkzbeo96NsmfwWJTsVoPwbV6pmuv?=
 =?iso-8859-1?Q?uEJ3G3iGUL6NdQjqtq3htFwPLipY0aBo8yaBh6uu3Nz13uBplA3KiJJxQZ?=
 =?iso-8859-1?Q?m/R6OEpLDAqNLcn2xuA8DCba02bRriVYcmfIZsInbWYGSvpzOmNhTZJaW3?=
 =?iso-8859-1?Q?TW0PNKbgoQTq2LoZSLqX2/BbKA6lteFXSqs1ErRsssB0vF3WOd6ZvsSJJz?=
 =?iso-8859-1?Q?h4F9PxgKckUSnYmjmnciuYjRglU3c1gibTfAVGv6WwXxqEsdcxd8LzHX0N?=
 =?iso-8859-1?Q?fKy3D2K2cHW0F/sQ4i2apwk+ofEPMKEvlKSGwiEaEiT/MzA4Ut45IeiccC?=
 =?iso-8859-1?Q?7ZwCzlLgKyvhKke4xCjJH/iC2lbtVnUTmPiFDOi3+SlMh0cnYkZvycYn7e?=
 =?iso-8859-1?Q?BPGpfxhiIEqONaumQGCHVtuwZdNpH2qsdDFtycuXqWjYjmQhjY62cUo4zk?=
 =?iso-8859-1?Q?u6ewngAi15odYH52T2MUo8GyLyeqiUYZQxPsmKp1G9vEYsKmRHZ9QsiCly?=
 =?iso-8859-1?Q?nuaKEJhfyMUajscOAF1SEOvQ0EuD9H/QV/8B+N96wFVQMy4LlGM731N52d?=
 =?iso-8859-1?Q?n6JFSPhM35qLPhuG/4eqlEfUmZItjR0ChLQ2RMO/aKcJJdr9rvv3wnZZdK?=
 =?iso-8859-1?Q?wAfTx3MTFzfjeerSyloY/lGfEVqsFX5zSktErnRxbcsEIrj4Hi+TxcJC4i?=
 =?iso-8859-1?Q?t1Ob9+Jthq3nFrzpGBRXBayLB4uzjJA8vVLRytEArPxNL7V+p8Xr5juEe3?=
 =?iso-8859-1?Q?nXlNj8zPXJnPiFHJTN2Vf/DWtslY6aX9JyT8RiviiQHsKpupYGTOwPpJ+o?=
 =?iso-8859-1?Q?F/FTRfhveqIHGr9Z1W0lFi56Qb/MMy1pFerYAfKlqGIf5MSZbWfNUHhKCS?=
 =?iso-8859-1?Q?Ig9Zsw4F6H2JoKSf+nl1pbrIqID9PKqHaa1lMOH0Pm1fJmKmiwoNwizTrU?=
 =?iso-8859-1?Q?4k3NIC+g3sUtgwL1Qn4xSmY3rvnEssBdeatOOMJKvcinmo6zfLIJpY5UUf?=
 =?iso-8859-1?Q?Li76Xp0r+fHSosebPdShfg5r/w2n/VxQm9JkAKkDkGu3MdaX3/aOsQ/mph?=
 =?iso-8859-1?Q?xaUf0pvmPBi09BrW6vzQB0SIBgD3KdYBGeCczT6jRMW6dvjqZsO4CHocPW?=
 =?iso-8859-1?Q?vsLwR0wSOjgx7XxQeMUKM79hFLIXWhAZ3IcaGkuz2KjH5ryZrvSWgEDhjw?=
 =?iso-8859-1?Q?G3Q2HN3d+uxRl1QmqgrLrief3+mu2RQf/EbEbogvmd3C969kxAUq1abfzI?=
 =?iso-8859-1?Q?CmRuqtIxBTdP+N+bJ7eG6W2O5xPaHrbFL4Eyjoaxg2+Hcq6/ryGjBXw339?=
 =?iso-8859-1?Q?J/7wMOz3sRsH64Xs4OWGK7oHxNjfwmBDP3dSgpwdEH5BuodMDDq4/FLDrO?=
 =?iso-8859-1?Q?qV5BCiNXxGO1UYHSaNfUWFDxSYi200u30JMzoo4Kq0IZqcPEuhPLEarJYB?=
 =?iso-8859-1?Q?zRvWarq/FK2fAzEb254HoVZIsbbeRHemjUD2lPrno8cWalSPGLQTEPMHSr?=
 =?iso-8859-1?Q?HKmsHsnB+3XfuiUz0xgLdUZvQNNdXaWFjD5+mO8XB2w9S46AV2QYgZVOsH?=
 =?iso-8859-1?Q?/6UrIG2yO+yr+DWmhcY+HRZgrfQ+22Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ecaca-1477-462f-bc01-08da16487c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:46.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpgOT/IynoTOpK7Hv5lhEcYKfmTIp1Lz7GIc+0qwSpvoDK/9aFyVdj9QJkCFgdmSgTsRXS21XQm2IXWs0EHFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: rCuTw0UO8vYfUoI4LED1Hs8B5Zb2xZ8_
X-Proofpoint-GUID: rCuTw0UO8vYfUoI4LED1Hs8B5Zb2xZ8_
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/parisc/kernel/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 23348199f3f8..ab7c789541bf 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -536,9 +536,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -578,6 +580,7 @@ static void flush_cache_pages(struct vm_area_struct *vm=
a, struct mm_struct *mm,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -589,7 +592,7 @@ void flush_cache_mm(struct mm_struct *mm)
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.34.1
