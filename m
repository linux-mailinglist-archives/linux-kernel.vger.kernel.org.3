Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A509B51019E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352046AbiDZPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiDZPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607A1527A2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSw9l032176;
        Tue, 26 Apr 2022 15:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m9Y6c1/AuCFVaRvEWvPx448Upvn5FcM9WSTEbBXQYaY=;
 b=YGuHEMIWLMiuvatDDhHGPzvnvDbjeIOuRFUxa9rjX9yl+ntfVuRJm8Vi5dxd/bcFKc5y
 jg7vQJr3E/f54kIfPY/saYq/o1zeE/StdyBsnKfRb3qLpK2KW4llaVbQwVS7bombiYb9
 sFlIW+eIHGHoC0b7LpVF+aNYJ05VeQf590eZZCSMImW6db4R19DCuWIWIwk4d2ubYOR9
 wSZVvTMb31kxIb7NTMIdovqLluT8jiZqpr6PE6S0kCshexiAY30Ajn8H7/T0VuR9jkpi
 f4Bik3OxwG0PmgDyzVrUOzKm22vT0OJ/bTXwOrP7j/Ov0apOrIrXrGBYG3NSyI4GBDMh Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx506-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Us5037859;
        Tue, 26 Apr 2022 15:06:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO6LFkCorZAmuMmtF3QCBem8XeH8/QQJ24NhKWs9ocj4GSw6cE2RnlmbAHyr7hHKIXYVR/PwSD53E6wcUKpFt1+pP4IPxv8Z6D+OSsxM3dTFZMDkZfYF7BaqgBZVY4MQHa4AjtJdo17NCUSgEbK5TJM8gTh9fzP+D8m28bWZcvX60W2YV5hIcBQjjhn6AUwqS2luFjBMOKUoBklhfejCsrSXTMcsw1gttUvdorPY2eeU0/mtaolBlA6R78bN3YQy1yhIFAj+P7t8uKNLldym9Uy3NgLpRAI4u1d++i3B2YPpzc5ZRHNg+kPQSiC24baMfXz360cP58y6YhmMyEOfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9Y6c1/AuCFVaRvEWvPx448Upvn5FcM9WSTEbBXQYaY=;
 b=LYIw/bhT9MwtjNX052n5lCWKEvCnsqXciUqrw/SxPUOXAtkAVh/P4Gmc/JmrljqK1HiTVV2Q5RQWofAaSJBTtyiKi+UBFulTgiOBcmZB9qUsdo7Sr5e9NWEJIfPevYYnNZjuWoyQ+hOZoTfstOtWabWZ7/OiMqsRurLMIETDeFZBvM0lMnZ6u6+46R0JPSSnYau6HkjYRB7HNNtto+1s/mZUMjX0jg+dLfwlEpFTlbsoKw/SizaKL3yNq7lIhJ74S68kYcNuKwC/sjbdHbrAW4T8iovHWOBTtecQMuZ7XqDozvbqDIUUdzHmAiPxwA9slLqB+qxrUk9o3BUG2jxS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Y6c1/AuCFVaRvEWvPx448Upvn5FcM9WSTEbBXQYaY=;
 b=jqY2RtqPQeUAymkIfX8sQCOQz+zCpstcB9VQ3+vaoPN6iKm7Q9+gsb1ayETNT/mntuYlh/rYgP4O04Um0IL7RFNJq5C75kiDXas4Xugr9yaGlx3qQ6sr78vBDtaMdKxwOQaAgQKsU+xg9wdincAhuFXm+slnXH5Psn1hfsB570M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 27/70] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v8 27/70] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYWX85NEspwAHy0EiqtZzwae5PCA==
Date:   Tue, 26 Apr 2022 15:06:37 +0000
Message-ID: <20220426150616.3937571-28-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0192db-5e35-427a-e483-08da27965ca7
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB467963C8F159EBCE345EDED3FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14RvwJN5Ka4OMFbOLqC73n//PnIoq6wt4Zyp8UwZYwH5qGj+h8oo+cWKmZDuXTCyzBQdpyUTVnGFXglW3CLSyK3fDK9kr81dcsUlDIr48Oeeq8nN3RAz+o0ebBo8TAlk86MmrJ4O/ifuhD1faU1uToNgro64HLOrsQaZHB8i9xqAshSXgZdIbPEzpQ+wqEHKJSGH9dHJwQgd9bEUNwIwas2FtM0TD4P04/5KLFWhgSxI8M6mYZ47pMHeONk5Bk13DBNZITWv/7ylgfu9apvl4d6s89MECkbvAq+deqlKS22ItWls1Ng009RpPdyHGEE9kece4rPh6waHHDpacu6RnVZOj6RmhzBWm/dJviuyTV3Zqz+R9k+ENJFmU9XcAUMOc2NgXelZpu/Y1N+72H+Zy9Ty5EL54DP9PQLgaEHyzoQTS024PFmQC737cgaSc6EXWxGhwI6Prqff8wI1WMT0OK6Hb7NWxXc8jRHLz6ugestwz8O7KAlzmtZ5uC/WRnkIOcpp75nxuz8l/hwI4ZQqRkq2d6eI7HQdSaHWf2urZF31BB+ulaKW/GAJ8R2KopN5ELGK5/f5uIbYIEkO8XEldyA1b40Opl0iOOhxr0upTw0nl0upF57wYryBMP64JTWRrOWdGCuhTE+Sm9ImeDbDBKJDrpdRJI575jyc5x/x0XH+PfiO1i3oa6xmT9lauxqUWRQ8htZk1HYFaom6X3S8qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(4744005)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4X5KQvwrwNaRgXFJNy3yKahdEe50nBUi82E2tqEFM3bAYAjo3zwZnjpUJO?=
 =?iso-8859-1?Q?pVV9+r/wOjYrew6MlPBdXEDSBToq25Fh6fhjcTRRxS4sttwlNcG681eF1p?=
 =?iso-8859-1?Q?e2FrO50AAIKkYQMT/fFVOJO/EhGnuh7TaC/TofPVIhMm1pKy3pNgFzp54A?=
 =?iso-8859-1?Q?p62a/f58tLLTCTRrvBYQO4OBbHqrgjceFidmPnbt6uqwIS5B+m6qi9oHQT?=
 =?iso-8859-1?Q?91+tUAV8FoaYzgh8o/vqRNHTQdPHn2Eg/E30DKyZSEcJ5D2S1tmUISklnf?=
 =?iso-8859-1?Q?d+7VE+5N26IrwtEZXLGXGqsfB7TefBq/eB1tIiFuwTlp7VDN42Lrv9uCTi?=
 =?iso-8859-1?Q?MYKZqfZDZcQf30y/vL0ysAD6/uUUx0S4vKGwFFdFA0STohkWxFamGR/o82?=
 =?iso-8859-1?Q?Rj0g8NieO8LUv5Aeu6DttZbPafiOY0tj1BYX4neb5j6ECiz7RGB2rONqqz?=
 =?iso-8859-1?Q?oe0QWuPMpDSSc8JLBmG3y5Ss2/7upI0HXhrjdXKePujFct6PKJfa6zp1h/?=
 =?iso-8859-1?Q?QRNk//tWGejsqJmVPzEpXc8mjndyDQhWlBDdNPyVsONg3zOX4D3OoTEpm/?=
 =?iso-8859-1?Q?xk5Vp0QYqjFr7NMEf2f/mIetpbhUimpJluFOT9uUY8XowjenoBilGBCImJ?=
 =?iso-8859-1?Q?x8UzevrS7DhriZviwed73Mm0KHNi8DFGyJ7My6lRzfo/Eeu2mz2YDVXXZL?=
 =?iso-8859-1?Q?fBl3n4/eJvWqFsf8Rs+D9E/Cb9rHREi08wrIUZmeBmUxSI4qG4DgMRCuTz?=
 =?iso-8859-1?Q?SGdZHmEQUkhIDXkgaE79tlUbdbtUf94LzRr5efizYA/70xlfcI8R6MeF+B?=
 =?iso-8859-1?Q?GJ3I4aAv4Mqut0msyf5L2oVLjkDrK44ZEskGAYgXQaW2pBLEUQmu4THTtY?=
 =?iso-8859-1?Q?w04PkUeyG6CHqvpC1Gf/CRSDn83uO4u/EQNq/B9p/jXT6paTaeQqI0Dldx?=
 =?iso-8859-1?Q?Perrnns1yYeuqOo0eze+VHzZvhqYtPqWagd/re7xjgpERBL+agjo6TU8XU?=
 =?iso-8859-1?Q?VZJL6ZvujeNkjlXfActKvbsvSjN64TIXZQyvKdraizPJEpMyq83tRgZu42?=
 =?iso-8859-1?Q?NlVnozxK3U3BJ3kvJeVYW1Z4OQv/crjYDeb68cdbTFSvQefL4Nal7cPD16?=
 =?iso-8859-1?Q?Pq7iMMFO4rMyPNBMala0598Ojs8DOfGmXmARTtpmayp0wMTBUhClb1HuiP?=
 =?iso-8859-1?Q?NRz1TZhdCowBR4O2JY156xyZx0//m4v87i0G0C+nKefwFP+6Qmg5/hOw3X?=
 =?iso-8859-1?Q?TbnjKkvSmngs902lbqk0XHvoa6nXic9dcCMAJsC6v8kYPQDyvbJD5Cgvb7?=
 =?iso-8859-1?Q?CFmZsUAQ6NCfUoznzdJYb24jzo7vUrmxXVmpQ4w7NBcEiehQJIrnU+zyKF?=
 =?iso-8859-1?Q?eOFZ7U3c3o7hQrHE/xnLEwdfXMc05ZwNEbPpoGxk9bzAnlfIn+MjbWKa2L?=
 =?iso-8859-1?Q?tHlOey+Kg/Zq+PE7yhOEGCSMPgH2EhdGV7D0MXmb6Fwl694zyTOjJsmpgk?=
 =?iso-8859-1?Q?1jSTfBEsVki5lXZtjTu3wpKiJOGqkV2vpeighd0Ovl1+ynCkv2yJ+2WoXJ?=
 =?iso-8859-1?Q?4wjUhPTWxEWDKFdnoVRcwFZ5lAfPbXf+H+10z+p5wXizXHbRL3ceMzsl1L?=
 =?iso-8859-1?Q?lHM8n2otJ9ILnaGZAFRhKcJDaG/71CBYs/eG4078TPwUkyGDlTV2/c0Et9?=
 =?iso-8859-1?Q?j4MI9hnkxVrVNDwOAZICYxvSWIGEUeO5pkJpfPYSkSxsjDgYuB2yN4MM+m?=
 =?iso-8859-1?Q?uEHyWN7wioqEvhXyQI/lo0dIQErV+K0lTdKBMOFHrVi1SW8B9rmIsJ0cdh?=
 =?iso-8859-1?Q?Ipm6EwZlzVJXzNlw8uW7Gl/2vPemOSo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0192db-5e35-427a-e483-08da27965ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:37.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URYccE71UWiKxjE4COUKEWyeG1HPbKZ91V51YZzXDarZN9SafQbdci1pu4WOtKemhBmf7hY4r/IqNNqlcNEQzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: zx29rzFwThIGOcycY5HBE2HdT9pObGrN
X-Proofpoint-GUID: zx29rzFwThIGOcycY5HBE2HdT9pObGrN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d0d76c410e7..6bb43774a707 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2802,12 +2802,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
