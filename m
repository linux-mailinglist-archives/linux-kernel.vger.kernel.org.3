Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D658510182
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352267AbiDZPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiDZPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34AE15AE38
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSu3l018603;
        Tue, 26 Apr 2022 15:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IvRJcuHAa+EYg5qkqbat6LnzuehR3iGyvP9x+a7qmws=;
 b=mcXvB5ttUQI35sjxtR7aC2KHCNw8xZpU392//NFTTJWXzAwCcrxa9JxO0rPAIDK7/ghL
 AI3xpKfZ80WWdBwDfAP8y79IRYd3ywU/MEufNM0mwnfxQUmk2gIXb5RSMsSVhNgSgld6
 ons2FEcWsCduixpMi3EgRD3ymHRVfd7QJrEq3gZEM+KY8qGvkWHq5n5WMbTlMqJerYwi
 DhxtTPHxArJGl9wDkSmf90N1ChKk5aq7l2V2ozV/TKrYvcJajrMrENZYi+0uB64XI9Cq
 bEOQOEAwyl6NlYbB5/4Kouo2PTVsR5iy4SJzbvj4YHExhsUzS21qTWTzs1O6QX4sc+16 yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxejd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UNN037877;
        Tue, 26 Apr 2022 15:07:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkute-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxHL88kNvrHA+mTlnVOaZPFli1meddnI15QMk+rRcbJq6Ry47HmBQgVr8Q1SDoRHldCtmodWw9j965eY5QHphUlS27OPhrDok0HXDvBab4+1wcIzhgsE8uznWYWyYs0uqw+yY3PwBrSE0T+5hKVvZW3vawFMgtA556hF65ckjJDGZXfFRi4Z3x4na7U3+aJv5oIeOb91TnHD8IIH0VNxGuHYjmR5P4DOhvwHhobNoPHzTfMMCy7P2X82gbwtXbj44nIkJ54Fjgg3g8wBucbQ+s1lWjkXhSyiW6rKlYCPDox4L7mDBf0vvh9Ru00rtI0MiJG3ZB4smLNb8WhLsBhviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvRJcuHAa+EYg5qkqbat6LnzuehR3iGyvP9x+a7qmws=;
 b=gVgaftPsxtmYGMXqNL5b0fx2En1Cn87atTcOxc1M3xsn5qWt+5bW8ZrZmyBfucUkVVL78RoOmiFCt4T8462SoQCCrJd9b3unoh8Ca1hdPSyQdmEqPQVRNO+e/iAhaaiNSRRICtX85zjrTv8GeYjt8LIBxyxIHuyKoii2NBkp6Fx8otOpejs4B8SZblm8PlP4kU9KGEaYsp3vujEktD7GeRselUTbFYteG92gEI13+TYKFX4OTXFX/VXgsWRp/VZGXODsdeV23ceDNvzwiK3U29LFUvgkCcGEAmaajjuu8N/XQad47TfgJ8CJ/WbCxxMxVc+tl/Cdm0P026FQimTBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvRJcuHAa+EYg5qkqbat6LnzuehR3iGyvP9x+a7qmws=;
 b=hreMh4z+nx8IruH4JCnEdnSCLKJkZl+gNjkEIvZZYiGi2tXA+f6qLLqFg3zuqWMLEKLj3dMb6E9512HfsopMwc16129szC4bpOxY5gKNFV1H/v0NaLHtIPRbXvzLAxR1R1e9V+HV1XzAWwWqJoBwAN4Rg3Z4Ammn3YcaIDNhYfs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 59/70] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v8 59/70] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYWX9BidFAYYV53EuHiSxllpYqhA==
Date:   Tue, 26 Apr 2022 15:06:49 +0000
Message-ID: <20220426150616.3937571-60-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b6d42cd-aa43-42c7-b122-08da27967e1d
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377E96EC18B3D21BE9FBF27FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utVZX/jQUSgvF0Jj+6FNCAqXwwBdt1SP1V83irHZTDy9Vyl0Cr22esGsP2cvP9I60EOlJ46axTEgLmUgLr44rthgv3r+BJFHdJxD1JG1IxAcGCa86c5PTNmtlgkek2r+4LYYmPYWr/LgvwNA/HFZ+TvbHiQqOh5kD0YJ0spKsA+77QhUYyiA6tu+CdLc7Isw5KaJrBwoncMFliXsJ/0cLkyhLmIJWNStuC7s/rI3Fa5ZNZw+7JMJaTyN2C1fAE6b4sQx0VSM+ugSZ1wrDjNFz5wr4+ZdeVyuY4q3Okw4fPMb6AhYRgK3bHnT7zCIvKB4av/AQq5vf3O99WnrxB+MU9i93OFBhYscFzI+nbc6XC9ZQnkRWddYXqQe+3p3014fGAYz71fpEEQcybFTDCaLfwfU9MNlqsaGWG7ewGY4CDrYp+TwQy7UZ8nIRqkeYuBd9Z7Lm7jkqQItlDz5WrUIyK/jn61QpEG1fE64LJQ0X0AA1RN8oqwUuZmAVhL59kXj8ZBw29+rVD7v9x9elGfw7mXO65c2jwDTZQyHSq2Z4l/HRB1hex1yrKhlxg4bPQL4EIWUUIkY7aXK/T1OluJmnkDY8r46Jsc2oe21lXId0Thh10uUWnQVl38tTxcBKof9KEbiPTCWgV5EuVh623ff30SB+GsT4i7c26YbMTl21vFkDvCBpvJrniDsp5aLUizgIZmVqURrUwnHyfHAxS8fNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H52Q8MDPd5nHJGz+RUdL2TdGbk+ePVHY/PHENjZwEnV8N7zfwAMg1i4Ny+?=
 =?iso-8859-1?Q?LKM3N1F6VopYsoSt9AizsFjiWKTuj35+forqDp+qsn8xR9N+ubtPhnMBgu?=
 =?iso-8859-1?Q?vvTRUfeRQXK/x6lfPJgvGvqwXuhUgKqMMRuROXI170oUAslg+MEIVG+PW7?=
 =?iso-8859-1?Q?+MlWmEcRsbN/hI6SmPQP9ASCnnmlzad9G6zGqAJmnCGAdsiwVCYHg2aTV7?=
 =?iso-8859-1?Q?3kTazSb35iTItCLO3m54zAdDPRwS5VSnmj4z0RdLNhhjDc9YYS5+f+ttl1?=
 =?iso-8859-1?Q?FABXZafsxfESQi4gyzOkC1XSqgSi/xDn95w8qm0GRyZO70DTqP6x7toggJ?=
 =?iso-8859-1?Q?GcadTfNx00wqcPSzAeD9BixOOjqZhVBf1kyzaav572o48rCNa/QVtRg1fL?=
 =?iso-8859-1?Q?gVOeWFpLZHexuezDUUkH2HAzx02hoIl7ndjv3KS9FkQirpUsoY33ZRlBPE?=
 =?iso-8859-1?Q?Y7mQoBe329hq5x5996QmXsONgfHV+J1ltFUFJJAujq0A+9Fngoj3C8qI6W?=
 =?iso-8859-1?Q?P9ALhv8JL424bZXooE60DysB8dmnAemBzIMH0C8g2f/AzxMyRjXA66YW9p?=
 =?iso-8859-1?Q?iX7g7cgb44PBn7jqb3UePaeGg1cnfoF8bspwHLfbaOLFa/r6sVG5ph55/B?=
 =?iso-8859-1?Q?csGYSCOeWCMwF1tE1iXSf8cmAhy6CauQ9dDtXfYuwu8hl6J9LeoFhFjTnf?=
 =?iso-8859-1?Q?4wRD/kfn8Z9PLDyaGUPVwhDfSDyaC/p+1DB1KEl5pOVEf7duibNgVrKEDw?=
 =?iso-8859-1?Q?ZlYMQvSnhqDBDFZgNWoJSpmDYGD4auWVH8bFXcFTxLJR68i/w4Ru7a6QLE?=
 =?iso-8859-1?Q?blg0EJZIcTDCgHyC0AB816byEW5XeMqRTMGTUXW84+3Jn4FLqQwOgJL4a2?=
 =?iso-8859-1?Q?zkMU7erlh7K6nkDaz3rW//cg9GHhZWwidPOCLaGOu54bSse1VmoqxUd2re?=
 =?iso-8859-1?Q?x6prK2eoYpVCyCeHC50CtmoowaHq0UmjxVse5VBPX+KV5T9DZYscOmD4IZ?=
 =?iso-8859-1?Q?JvCs0UUSp1wcBvhM2y8B0Hcicb8IBczNv/E2ObySHdRPZCYRKO6S6rD6IQ?=
 =?iso-8859-1?Q?7yd4UhEGbPE68BuBX/ljZRHj5nr2aeaxOP+TzE9F3ntHK8eBomjWZjoL+6?=
 =?iso-8859-1?Q?SVHWNz4evgQ2Bb9laaNiaTrHYPghRTwM6J5mfiTcgnZDF2LZfcqXFjd5b0?=
 =?iso-8859-1?Q?qZmRtUikzriTnpV/05kfzbkeJRDm4qbDdKBJgiY3aHXlyLV9ohsEsszWtg?=
 =?iso-8859-1?Q?U266aBO0sB+LKGeMMIq8DgIvbqXQykkYbcGvzh9VPaGsj3xIAKhPbnO2sS?=
 =?iso-8859-1?Q?7iTJ3Y8qZ2/5upj+N/C9utm7zORlKNrq62nIhN6yFCJGjNS3L6vSPGKdBK?=
 =?iso-8859-1?Q?TOJgMFJnZRUYKma/mSV2sL8KNyUIZRI1i53k3c08qsOG9/FBXHRNt503nV?=
 =?iso-8859-1?Q?6wWScYukrzNwvaUG61pUQETccngivDt72pMSX+Ms/QWttw3TLcc6x70Qu2?=
 =?iso-8859-1?Q?cqEDa28YfLZ9b0yXwFaSdJYTGgsxn3TqnrJmRgNUplG3h/b0zyazUomw8N?=
 =?iso-8859-1?Q?9CYBSnG0R4ZFWY+6UGkpc+iyJw/eSPyn/mFnqm8B5NMX7sFxQtf3DcKU7W?=
 =?iso-8859-1?Q?hjfu+vObBTAO0UcJMmKtjQD+FrpoM0aASk2ebIMYHzdKtuGIYzJL8TMWNk?=
 =?iso-8859-1?Q?pHO3etM4MhlLgUum29wwgmibvA3UScfKFZ8qyEKH/8HMm3vUbGEfA0LRIn?=
 =?iso-8859-1?Q?XeZBWBgjlu6rfSmCLq72qewTJNgtwI7o0Y4errdm7WYBPhrSHSrgbISMrp?=
 =?iso-8859-1?Q?HJ+ukw/DcfUhezz+Z4rGT+NTnolApVQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6d42cd-aa43-42c7-b122-08da27967e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:49.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJelV4LVKp51shGvYB15odXlyRIcCQNO7eC9DYZ5Cr6/MROgB9+SHxj9e7Of4JS7E7MR8bA3QLVTbb3yYey0CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: lcfR9oHQb9i75SrNWQk0uIRw7MRWH1nh
X-Proofpoint-ORIG-GUID: lcfR9oHQb9i75SrNWQk0uIRw7MRWH1nh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 20a46f21cca8..fbb248caf8aa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -550,6 +550,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -581,7 +582,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -607,7 +608,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -670,7 +671,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
--=20
2.35.1
