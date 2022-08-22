Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56AB59C5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiHVSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHVSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:02:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C713EA4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:02:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkOcs022935;
        Mon, 22 Aug 2022 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2rFRcSYRn1mfMWBof6U1xhOZyw0k/B32U3tjaUphTXA=;
 b=HizbutvOqIxBh6BJ0iC72u0gPZhIvEND3TYcjhrf8GndzaZerQvnOEeRAY2Hby7TH2yN
 DZb3P8W4ic2A0kfZCCanM762p40WEdJL1U+vCHu3oH1gsXj16j6jWJK6Idqf8S75TDqz
 gzgiNRVzXXlz1HRtwAoPTqE63dKXkVRxrKjLRtRzrHvO8j9I/SjFyp+WzxUpuaQw9ZZ/
 oyTGu/QkmfSHKsEAsKLrCl9v6mzGfY2GO5YO0+tzwNc7I6Z0cvGppG/eRyNYQ2nJpwj6
 hWvh4fXPuXS8pglK28Hz/bQoLDGG1pdZoFgG1zfjHZcPlfvuzEuG8m0MgMxVx6GS19mk PA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NM6031836;
        Mon, 22 Aug 2022 15:06:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd395m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqOzfEt+WUIcw/iMYaMOnc40MLJQ+ZFKyJISTO3iPT5jdtwpMzbqDn0Xd9vQ7+CVn9KpeNXdlmWwPZJ3kCD4vD0VXXSlWq4OHK8UzgQvrMaPZsdjBHkIxzETptWnT+jN+iaQzdz/pHrHRgJb5BlkCViJpnyTEMN6QjGU9wVQmNi8GL8pPGSu8yOoMIMOWKc0a3d/zaoeZ45tuzrJRM/PzSNwOlZ7gO/Mwh7O/ziWo2yYzVghMEyjrc4xRpVqxE13yWx6Q2mVgjUfOq2RQQaTy5li/qCBmy+VnTAjgfWIDt2qRD6OFAObQGThsZdr1YUzqPmnmRluSj/MkIOm5i8FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rFRcSYRn1mfMWBof6U1xhOZyw0k/B32U3tjaUphTXA=;
 b=go90PJX3BmEhXt2Vme+NPrOHBlsusjFmbezdKpualPbAGkYFPLF3hkOKb1p3QKuNBKD450xKUlLAoU9l0YPNCaBA7jatiaC/WbXLxh3zRozWHsYDu5SYxiphxfRDM9siZvJjX6gPtW5b37Cbbw2ascydvpM4qyBKE9OU+gMN4z/oNmp5noUmfsx57pRW0MkGsT6SdhuPOlkBId4iY3D0/0Lh7ZFY1naVBl6JT+DrYqw7roF3iLMwdvvRhquh5Hv5AbcYXsdh0+Eg5tIW/nRrOCD9WDFfvrO2e4J0P0mHmviEG0I62VpaqubW1JunC/qBkK59hq240lzKKAmncNqnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rFRcSYRn1mfMWBof6U1xhOZyw0k/B32U3tjaUphTXA=;
 b=a9jl+UZHRNGu7ezxGrtb/3PQFqsUjRPnpOg6fndugN6qIh0WvVaUbu8d0BmMXQwi/3vgTjfbO3b/wp0s+Qoub6Jp3eXcrGsJ6CydfkW41W1no3HmV1sFxyoCEbkH2uJJjY4VaAIhOx27h3tUCquumQE15WPLTXEHNciWpNsojgo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:06:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 38/70] optee: remove vma linked list walk
Thread-Topic: [PATCH v13 38/70] optee: remove vma linked list walk
Thread-Index: AQHYtji+UvtUKloglUiphYl4frxksg==
Date:   Mon, 22 Aug 2022 15:06:24 +0000
Message-ID: <20220822150128.1562046-39-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d02fd697-4ad1-4598-f4f3-08da844fe19c
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42XQE6mUrJZsbV4C/T7K271L69lrhnk5+0fYBECpYBMAFzqrAN3dKTCI7eDrpxCnQHDlnVPK3ehgWfMI3BiWXp6oy9r2kLbCIOieyq4baI7VdxcIuMVjyTVhp3R9UcgeNcn3zQQAMRvAQhJ8kwqKkgwE0YQl/yvSFOBd6ziTZYecsP6G/I7CY/KCuM7oDwVPZ0HZ7cO5B+dNcF4BrC6vsh2l4XGAiT+7DD8dWl5p2l8Xk/KSyMxSCpWd+Rd+RkbfFKciiIHv+hP6/AjQvA85t0BPCIaNJANniRsqTGx2J6bPZ11F4VvjdpBubq52tB8TfzOu2m+SAa6oPqcGoL+ZoDquAz0XftZYg6CHIH3VKDmapT8UD/XhpEUbwcIw6B6Lkoo7E0/lzvMmGKg6qrkoiaeQ9QPBRqwFLmfG0bZ8prdERBQ2gL7VY4BIMHtD/WNYFtaq5wfLAYVktjd7Kagzn7V/g7Z0fMOtqzAD84lI6NohB5uPIOKka+eNbZmcO7fmy7YYHH23Zqa8ZcQJ+WHdswKhQzWZgipli2nAz/dzMC+3IQSTHSNv/e84CmJ2JIX9NGxjw0SsA8jOfKutWtLcF2AOPNoIATlRjmRtl6+1/KQd+diRphb48zmsFIFyO8pRTKUO4qJd7YTn4cWFJoUuN09y68rB8W5WQcxxRSIWB7KTfk04UHHGANWu6ie9fDa4PzZYo0gOPc/SJEirQZvLjS/pSrbvm6t3Wy2Fhm+42vYllEzjvzIMYYjrqEgKrceADWK3eQN4Qfv3YNGZOVwRqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zoEmOKLjTKwtTeADsyhBY3kk+/677INwkDCHt1+eb18JfRPnUJthNhHv2K?=
 =?iso-8859-1?Q?1OJyF0nRmvXI8JbCB2yPkRMGEah2yLO6+khKoW3X3wtG58MDz94giOadCV?=
 =?iso-8859-1?Q?cV1daKqqCVFX0AgLb3lmIc9NVd+X+JT39SBXIco5keLoZ9Qu9kEE8qqIRY?=
 =?iso-8859-1?Q?tZ+htm0FM1DdWlMkk2/1Soe/2wmM7r+3IFv3KHmrv0sAW8rEuwFsZe4Tcc?=
 =?iso-8859-1?Q?hLlGcx3m2+x0gMwCi89zsKpBGhBWbIZx01Lb8IdRHBsol9V6gtMdHGYKKn?=
 =?iso-8859-1?Q?bQK4m1KGL5Ga0YlK9bMFDj1PRokhYyCWaF6yeT04YR7dj6AJvgxgzwD2W8?=
 =?iso-8859-1?Q?NmpcybN5KRPETq+33dFwr+iaZGZTyFVaQUEx4KZefx6WffZqUx7uq/JU+3?=
 =?iso-8859-1?Q?mD2+xwwIct/O+IuhEmibDemF2ZGBFtnwaJs4oa+RZJA91g44GJpyGqEbg9?=
 =?iso-8859-1?Q?YTAwPn+IolUX6faHMzb0jZtFOeOiDvlj8DJZ2PEt2qNmXJHtbVsFB+29Az?=
 =?iso-8859-1?Q?JaYvruCVa4wt+QmFVx34ugO3pk6E/ubU45kJKMCl+5+XqBoPBMK4JH2i3b?=
 =?iso-8859-1?Q?UQD4YpwcGlaJaIZ3rLiIk+7ubyx1iyzLY08KRL0VEmQIQhhOEwVgMWycbM?=
 =?iso-8859-1?Q?eqtiOMlcV+QVKV1RPoJywk1nzifiMZroAyW/9t5+rr7p7x9Zoqx83r9/3z?=
 =?iso-8859-1?Q?OyegwvIq/TwQ1CKfcOKXnLgo80Mqg9jtSO965fYe8ZA3zfe4NtSsuLOP5F?=
 =?iso-8859-1?Q?H1eG1yenVOEIAEeChJfMDr1DHjDsohPALmBDe0/qayChxlT70LuEAvA7qV?=
 =?iso-8859-1?Q?LYZdlHDc8S80jtdbEWbSJpFTtUMML5e0TE21udeyo2z55vx+jIOS2o/Xj5?=
 =?iso-8859-1?Q?SbVvY02d+3AfaS7Sq7coX8bgVu+a5UiqcWsOFXK/mDpKLs2Pm8PgMEbOct?=
 =?iso-8859-1?Q?C68ry8+EUm+s9wzYPQqgWf2DCUszTPiANn6YwiqKrOTRreYM4LYQ7fQ4I6?=
 =?iso-8859-1?Q?QOtla9LdXsRCya4r0OkjNE3KudjDkC7yjmCKX47TOobJBiMeF5k+tBJmX0?=
 =?iso-8859-1?Q?2z6B8N1O0N5efhrq9PwC4jPbxyAjp+mCtgu3XF199k8xw8FqArL1fUrCSq?=
 =?iso-8859-1?Q?QyCgo3GNTZpbrr50HGm9WrGL3xoz7NOPv1EruMPO1KlvCUAqxyXnZ6ulr3?=
 =?iso-8859-1?Q?zEk4zlGylKWnknGWd9AKnqICWDHwztttW3NpzAi115uqm/tUrq6huS15c1?=
 =?iso-8859-1?Q?FcdnN1tPuii0/k1+EK98z8tFYdyc+VkXiqSqweT3VTJB3YxEjFlY0QDWzS?=
 =?iso-8859-1?Q?o0ytiHMvBKe8pvvbYBThwx+lTU0ziuuBcGjqGGcJLYrRJYfDKfe+9QrJjV?=
 =?iso-8859-1?Q?7Kewk/SxEBzyS3I0qStoSodzswjXMcq/t+K5hLbfAx22LVeEetQ+1mFWGl?=
 =?iso-8859-1?Q?+PkI+MPK/dJAH83dS/doY0EdJI5sEXO37yTKHDGbVZmqtXviUP4T07qOrW?=
 =?iso-8859-1?Q?igeRmPf80KxsJNhrFdRqocFx4VZjHc7Ic43avudB/EnrIQtYlRicyHrzY4?=
 =?iso-8859-1?Q?lZ3kpEttpVY8d3cgrt4Bs2+Y9K7mufi/9fLedkgIvp/fo0D07nKXmqiD4c?=
 =?iso-8859-1?Q?Xos+8RszzEJ1nKV39B5siuPhP++BWfifw6nBXunIkKxHtDCyJu3ICOSg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02fd697-4ad1-4598-f4f3-08da844fe19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:24.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAYH0Ope8/qzX8vuG5bIaJFOBCrdGuBtuciYHMMnuKZgszWiZlZkf++fjlVYw5/sw3xjadb2l8uu5cPyMF5xhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: bLLEYXGOIm5Zjr7dOTYzzGjVhTn_PNhd
X-Proofpoint-GUID: bLLEYXGOIm5Zjr7dOTYzzGjVhTn_PNhd
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

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 28f87cd8b3ed..290b1bb0e9cd 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -492,15 +492,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -516,8 +519,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
