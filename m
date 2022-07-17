Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FB57736C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiGQCwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65A25C72
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rJQ005792;
        Sun, 17 Jul 2022 02:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=IqZtvvYjByUYZLsDboiO40pJJAtwwin3z0sintMTJWYidRpt1fTY4x9/VmrRejqYAO6Z
 cTrF6YKQWxB4P4l87023inEc+1PLmg2gs78eyZFLV794CRo78S2SWUpWL/xFAhcgVDde
 3VxzbuP9ffb1Y5b43q2uCcUjYDaa9/mC1Xm9vBKdgtKhD915EzHR1EjPmPH2BXxLp+5m
 J9mLmBiyb4IDI5wjiKTOQdTFQJp8AUSWgbtvIZmExPXuByOLwUbgwuE87WM42utySnJC
 tWX3Y7T1N8yL6DZqFn7pL7vbjEUBzLMJHXDYKZ7Gq4nyTOGHuYMQt7Lr/JARFdoLCh+I RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgIg021817;
        Sun, 17 Jul 2022 02:48:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1n7ky-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKDSKk9Xk85CzsCSGScdG0d5HVeOuU490XyWMxcLdxIzHai7xwtc98l+F/fVtlpNfPHYBLv2yMM0o6qg0gZ2i4daAu5vB4hQ8PZayDpdHfCArv+U77k6b/ud43f+NIZ3ARpjE3mRgF+MoUzLbe02BU/VY8IJ8jymRq3cPqw8Sp2smRpqZJocUGMn0yeutPju9iSq7dnlRg9EWykOE1CzQxCjOrcKedhR+o4x636X/LfWzU9F9KVSUYC9vCLR/RqIDUdAckV8ytZs926GB1BDFElTet+5NiWZgp0yQLttFd/0X6KeRl+gQRSR1fPacpO7Iw2Nn1XgpRUHmjcpomwPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=aA92LTtQLw9aN+k0t2wuZ10SCfIVDYdCM59g3s4tQ4EvQyKoPGFA4VxWKzH2Fwyy1yc+I0HMkQm0ehMHuWz16hkPA4/gxwHAzUwDekCbyJz47dnFs30kRgX2kAPQgsdBrSJF2ckso3dgVBLukdC4JekwAaMkd1wissY4l9aH4/qzd1Xnu0RrGcw9HCsNAPiPplujWw9Lzm+yOcFp9UrloOgjCGPufDg3I8ojlQc56YOdWRdXABIThPXI07oN6iG2RWVkix4YMSbfi6EF4q33bmaPUwhLs+tKyk9UGwFlGY4G1tiJNGVG3PcJ78xbeHP2w3LCKkgibu8bUsDPE0TYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYmBzv2Yk1ifWVZlwy/CvI8vQ2xA7B8sj0nCCwUNudg=;
 b=jOTSjbev+V5XZXxl3y3fqIjCEIUP3j7kbEN8/GFmPvhBg3aSqg0VHt2oiWkgvYXrTK5vzCJY2cevRTxYh21TXc2xbXZE+9Jh/dWpecxSRctjG9iMFzq1cSCODu2L68soHaVgbqqlMjIVAeRIfNRz530Tp0jrN/rW+4k2/ftlG4A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 62/69] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v11 62/69] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYmYd77xPBbYMAW0G/ka0CrqUQKA==
Date:   Sun, 17 Jul 2022 02:46:57 +0000
Message-ID: <20220717024615.2106835-63-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfac175c-d7a0-4c18-fd82-08da679ec5d5
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4TM/fxdG2BDEgJNODodjepcGQStLxT3UUTAGkFnKuLYDEsqwLnaSJ2yFV7O8j3Y79CU7NsGrmvl4rhhPU+Xh3mgoMCiWW0L+YpU0Hd//BmIeawvFs9aw5liXvgx5gihJpBk5RpTQ6D4ESmSqWRpE9Q2RKooDZLctl/I0JRSDtM/Lk5up1KoX1Gmod4Fx6H1JpgHigMqLXphPG8k65pwepAUjRFOVJYDI5S9QV14hu5DyOtoRdg3HdnJHiVutmO5XjpmAb74O/Tq0OBlu5A4qYFaG9X0ZV/iFusgU/423gRLEmWgPqWsFHfna0iZiyUGx0ztGuIpinSADTQhqxA6UjIfTo2w2pS+vAFjHcivK22DkgyhPve7GTjNVhZ2A3iSZ4UEagUhGC66TjnfMc1CvucwpqNvxhcqwxF6GB8U0elKV6guISFI97w1oTQl4MkJOs6Fdk4ZodfnW+jCycDxHRrVzBABPuCtGlzrP3vyxDCuTHpQ9vkTztUi/WPJHRezf5FypfTbd0qKaYHWSZ8uUPPv1eRhA5BYwyc0fzP26iH/19qomf5TOgB65MW1oByFh0oQN/LXCV3bbXB/H9oKEW4JAy6whD347amK6aPJdizXUbF1l25kqxySaQCr5eTppn4IiGFW7BYkQs/GwGSE1GnIcgpZ/LZYxyEpC2Cy8xJqAU/z0pqCQagPsTn3Ll9hjE6g8W3u5OVzoqOmfdZpwcaBWbgdoWLgtHEFokOeaiRAgVjrs9mIll02KLk+u34Hh/t/ZbMGHnh1YG5gE1EraLz2zz1rbpVtT0VYl0HptZu6vMvlgIj77OQ2PJeOQi4TT/otJCC3C/46g5JGM0a+uUYULQgHhdeAlSa3sJ01bt7TUh8am0qZ+CUAuvIZI4Kz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(4744005)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sBBxYsEZ1nEnXaW/15rW+MYANxSOKEccdbpuf2ke1VuU107tshnxbXWfpU?=
 =?iso-8859-1?Q?ozTm6OTchb+esNy8iHXPlMOXK+uTbB6ByUNFSFQrWoi7bOc6dLPbrsjs8T?=
 =?iso-8859-1?Q?yPzN0pDI2+6GqsnoR1/TdWWzIO6ToTA2wDG14NXAD1cqPh1QC0xshUrgFi?=
 =?iso-8859-1?Q?1I5IoR+Kd1av5XeuNbJ/tRZxjNaNLIpRMkOqOe8PDplHS7x8Re0ty3MEQr?=
 =?iso-8859-1?Q?FlpiAdXj7nr7kQOaORN6gcHZrfxJMR8oeI3/UYasfShq8ed3xcxmA+eknM?=
 =?iso-8859-1?Q?XjSLKUAOOq5q57sAQ5HKrDsvBURpjfnkl/NiGq8mmiekX3CYsM0aYnqpm5?=
 =?iso-8859-1?Q?n3pCr+FP5TIha8saYg2w2FRmrmcGQf3v8U3A4lozfrvytQyWBaErWqvrMC?=
 =?iso-8859-1?Q?o4AsxSoun9sMWFpLomXVBi0HquPiSqGGb2IDgWLCcDL/+iqWWQYQOhFUzW?=
 =?iso-8859-1?Q?iGFYG8ByzkRQYZFfgJD3ARgJ4JbyVRAhcm3NEcexZLYsX/LqNfkcIr02EU?=
 =?iso-8859-1?Q?3z3tl8/e3x1RMIVj3nJtc5fTKwTSr3Q9j0dO1n/dLLUCGY/j9GAwMsVm23?=
 =?iso-8859-1?Q?0TwZb/F38EiDa8BYoo2kRFcow4if9V5SPwttoRArdDGRGJAKLhvafgGF7E?=
 =?iso-8859-1?Q?jrEjkPv6E5sMCA/zvCn/co/hFi2KHOCVHkHzQeNMJMqQ+3iFw4gVD4bwoh?=
 =?iso-8859-1?Q?2VX093n2Cq/anrrTCoU0l8T9FWdvZrbzLcN+8zAIWli7F7bAHxlg0tkdNv?=
 =?iso-8859-1?Q?z72oZiK+qefvIUXR1NEey4+mVjC3jm9fUlGGWPfqFtJcqFy8ztPzPGDWpG?=
 =?iso-8859-1?Q?SQvsQNy25cMMxUuhZc9Hq51uFPvz5qu7KBV3MV81HSUpB7WwsFcfw+hmMT?=
 =?iso-8859-1?Q?IS2Qu8TeM9jKKQqtFA52rFqZLr16W5t/mkQtsxofpGg7TsV86ra+aI4mt5?=
 =?iso-8859-1?Q?F7BMOBT3v5M5FQug90P4L63dYeP09Iz1TTrsWOveb6vROKnDgiv6uUcAOy?=
 =?iso-8859-1?Q?iePz0MxxFdFUdmorM0Sb7WwWQkzY3wV1i6wPawxQ71IdB7lkM/fxSZ9jYf?=
 =?iso-8859-1?Q?czovqWRvXoybYSgb1e608iIPKIFHbcUqSXorblVBa0Og68KT0WD5kR6Dx9?=
 =?iso-8859-1?Q?GFYZCbtTR5BIbjjR3JacZYa6/lZqaQfCzn3iYUEZHlRV41kLAySFW0lzsF?=
 =?iso-8859-1?Q?K4pysLbLr69CWmwq9wkLGcxNLZN+gBq2+nAe/NbNkrOOaAlUpZGZqLMNct?=
 =?iso-8859-1?Q?MGb+8cUqYfGlyprn09/iQ+j26ggb0wMbR6gt6D9AHVgXBlCAImNNYOUMSN?=
 =?iso-8859-1?Q?oGNyP9c+/mmTfzpWjAZ8a7y8WPFKgRuUdz1M0Mxhcq0dwYBBIyJhew0b2x?=
 =?iso-8859-1?Q?sEA5y6rpR0apqDbgXsR+WZSudKdSikDPyo70EowOLmqjNGmbBjDfZYVQZZ?=
 =?iso-8859-1?Q?1duLL3lFOBhgNNihBb188HDZdQBRCcPgkJGuhLHl7OQPWtAPPRM0Fd+gxJ?=
 =?iso-8859-1?Q?tFBgFgaXejGnhv9EaBqLhdGrP8QhtppleuU3sjLsWVwREu0qYKJwndBE++?=
 =?iso-8859-1?Q?KqILe4LeEjQeJcRdByF417cbZ7rOboZGoOUqtsH/78bGG7EReMJQkaDRt5?=
 =?iso-8859-1?Q?AvvzCWdOLx+GSaJe9leOvqjgwzN3LVErzm/UGQAMvZ2JA1OLKZJ33vbQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfac175c-d7a0-4c18-fd82-08da679ec5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:57.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnZ5R3AT9f+hzzQzo4GMbgz4l75tOv7CwVsWU1AB0WulI8KgxvAYl+cKMmDHvxTRzMZpczq+jGbP2B1/5pLNfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: VOWWN8dYX3lMu7Pc8NWg6LnrnlBslOpG
X-Proofpoint-GUID: VOWWN8dYX3lMu7Pc8NWg6LnrnlBslOpG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Link: https://lkml.kernel.org/r/20220504011345.662299-47-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-63-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
