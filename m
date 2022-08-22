Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3359C260
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiHVPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiHVPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71E3E762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEphqL016577;
        Mon, 22 Aug 2022 15:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=W5UAYuLNn1oiomCpv3T/jh6LymRoMylzjJ/gR+xjoSRea2rO6FgExcY1es7nnPTrf9M0
 5oRcOxwB6BGZlrJFVA9BHQR1qQDmfbpu/F6SbAeL7iAGZZcUWwhQ4Jcvpc8wPYYmflGo
 5cV4UZDu/qZr/f4pMg3T6pA7YBcu3n/qP57sXDC2WZuAK4W6VUyfgUXcaS0oBVxHsb/4
 FDqma0fZiRxrSsjsu5/kp5W27s2Qksp+QwUxuxp/+YfF+ILl/5KlvG5MbQNDS/cbMUQU
 qcfBMYVyllc8LuXcUIGjT76mNvipqH7PXxLCEU2ABIdWaMmRGrNR/95o2/0noZ6C+r85 BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NdH035436;
        Mon, 22 Aug 2022 15:06:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u0y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFFE3VjZNE0wx0f8EIhVVIK3/vybmFYaqa0rx6FQsriJ0tHdDe6WE1Qqvl5kcbe2kdthaCzg3DnzypxH5fFVW+Kg6RJqruJqTw5ZW0/fNFK3IUBCxrT/BJuFoc1RE6T5doR9EefkmPAnENw4yRcKWFnQhObY0e649/ssUE9k5NK6yZ/0bZJbybr626T36lp11lVXXq2MraPz3lDFca+TjJHDHxOXEhNd0Ra6S0NWsfJrwhs5V3Zn+gWRDUKRXjTyYTny3jsRdxTCWtu3wYufQ/ywv5wB60OQIq0xH5hUb1udd/uxjF1AhPs6ee6JvqtpwemSpjlCRMKxICB+GVHXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=ivGBUF3VPvVaf2taAS6WM5ITet5lmdiGHuHDmVPwKhhXkoGRBcdt2fxOJYZcjZFS443wULkM4lHAnZJhDwEAvDB97gVC41ATbhV33DkHZVuP8CnI41wRFVZ8YpPLo3yUQ/g3KaiND7/mwRwg3oOypCx1t2DRGlivgW/536VoLBXZs5DbfV4G/RkMzQ011WLJ+Dxeoew1AG1169VziwZ+2iGiDRxgjiR68fBpTyRHjIWisfshKkoeis6By3BF6z39ud5/1Aye5SsWM2z419+JIlmInTTykIc3mAlNstI/N7vCPoGZbj3qnWyrv0tt+5+Mu0D1mdAdJ0QNgbgLHAB27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=BHsA2hEGvPzxP+tBIC/HC7z9HDDcsciFl0UHIsHigIGBP8rkT8qfeiFtEAXYgExnC5fixLC/4KGJkONk0GI1IgUAeVHZ5r2iRPKOvqZSKtNHe4fNJnxzf5TomutDme2G0u3aq5gR1zCbB4mE8fiSprM/zcuqiHyrX//Cc2AB+OU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 36/70] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v13 36/70] xtensa: remove vma linked list walks
Thread-Index: AQHYtji7VO75ZrZrfEmBZe0guaVJog==
Date:   Mon, 22 Aug 2022 15:06:19 +0000
Message-ID: <20220822150128.1562046-37-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 804e9fcd-4564-460b-0266-08da844fde51
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSMP9O3WIHjm2FMJ/8wRCNw0U4NhM04TgPOKopRMhPD+92e+baqol8J4F4cbgCsVoRXgJfIUQYhquaUeoBPrc53ADNSOduoUPdmszK+wG4pMPXFMgV8f6M7yaTOpYogwIcBCZPCGexVmISc3RvoKPQUhooGyJdW4AfZkjMi76XJ7ABKRfeGXvziCH9EF0+VTtLxB67dhPWh+HKigIXixMkrZHouv1HUP0njHjat9eq3RnIF6A2CHWOaX7mI2ZmrwhyQK0Lt0Xt8niePua0eHBLNEHbqRLU2UH2cwCgOHnZltsmE5fmi6mMZY9wAhXNo89iHwDxNp+pYR+tuIhEG0qrPsD1kRtjzO/wSYjnWWanFzdgl4q2SmJfBKerj8zxsEp5WII2Mq0xvduf+QLKrBfbRdgZzBa8NiH9/FPXSD6GZsPYaxZf/PIUQUph95VKXW4StXPqndUZJ/SsxgtcjOYMOXl0co10rNVOSMJLW0ecEE0WQaPoCwlgXitbjZXGv23WuV1sgFvAqCpHZ4Ua8R9e21gZAUwOZtvu8hEbQjlhxllC1A/20AmvHtAp1eUmuOgWjywpmuEu/UNE0RggA3avVOmTAAkp+BHYVTheHziRKdr2xqXkw6p6HUn0AVQAuZMlEZHzn9krgp31Q8yYYyN/QGE5PSlfrNMWbySTdnS0eixjILv1iiMg+1khiUUP0Cn5NpKhmv73t1hahJTJV32Kw791gjLxfDeVV7Z3lUnzdwqwUf3LS/MWFAfSgEsXIVSN/WkLQLI+sTWIwOJSXOwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(107886003)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aH+ZVcTvoW69cy3WCmZwP4OOQGo/wCo/cGlg4/vZaIFFgEgcmhcHib27ti?=
 =?iso-8859-1?Q?fG8EY3xS70Lq+c3Y5FDll8giISzjSHR2f65UqvtlriUF+yfO4JUgxTPF6v?=
 =?iso-8859-1?Q?W3wUW3lRQL7rLX8uelIy6AG3GO3K0LNgWYK0t4xCe2iR6ZqIrkw20EnMxv?=
 =?iso-8859-1?Q?0jOitz62rRfDaVxoXlrqTuXeeVjF2unlgVjUICg+MaSI3fqWMjLiTpmjxZ?=
 =?iso-8859-1?Q?zzMrL4NXfJQ2F6n8NRfruNir/Gxho4Cg25hvt93vKXfjSUqaINInktopa9?=
 =?iso-8859-1?Q?cWaMiQRrTGWF5VXomMLkHIf8NAzr/xpaP01Z+cfIuRJeTJwHgu5Q3qSIq+?=
 =?iso-8859-1?Q?MlxP5ZT83d3b2M1YAMhFBevvguZbA6vgtCd1gcmG1I6a6pYNoJAzOSX8eU?=
 =?iso-8859-1?Q?trlAHprBsXWhtbXltOlJFq9sOhKhEbs/dNahSWtIfXIi30q/jttuBM9p9x?=
 =?iso-8859-1?Q?CXjoLoL/tNgRx4habhzHW8lMgHBsHWVkx4WnemeqluD8RLARt7M5TlJEho?=
 =?iso-8859-1?Q?NT1tgiBP1tCVkvL7YvfTKkNi3krOYdDmMf/Mr1qWme6kiHnpqOpX7C/pU0?=
 =?iso-8859-1?Q?JxnY3ykTmfmnjkt+DNKo6VygmQu+esCMq+UttGpFLB52+Tc/oEzWk1Axvf?=
 =?iso-8859-1?Q?2w6GE0ijI5ndDxdSzfmYKokqaKePQKauj7cn70X1+O+akzhJJc5Jjkc3ut?=
 =?iso-8859-1?Q?4HU2C0e2J7kEJWYKkd1Z3Xo/VfeFtD9dCgFxPc45I9rEzty719jvM+aCH+?=
 =?iso-8859-1?Q?MmaL5CWYy4nj+7NjjiiAju4KP6N65ZbqanxaxaXLIZNbdgM0ga7qoOaC8N?=
 =?iso-8859-1?Q?Ssh12YdW+lkjncXV+g5PU8la5rbFPvSek0Mr8MZQ4E3wcSiBrftHnHYxto?=
 =?iso-8859-1?Q?Co5/a4CnXXTGtHBK+/K4CUuuc6QJrYEzy4zdjD8lyVzq4J3r7guwc9bPiU?=
 =?iso-8859-1?Q?xRNyBqBwAL+qXGqcZh4lot7JufadsdyhConhjM3TdBxC0ajEPTfZpB2BCW?=
 =?iso-8859-1?Q?4O8bBqRGK3MN+a29+hSWgpXDQNrQBUYKbH/U7/ZYfWCt2TKsikyBTYe0Zi?=
 =?iso-8859-1?Q?ipkfOvKfY2ZiHjg2/LmCpysafCzy2Hr1SQyvHEgMCGpXIlVoCVqlrVX6ja?=
 =?iso-8859-1?Q?Owjv3p/rIM39ubFcfzJJJigsEyxSMUPWgkDchd7eqxHhs7Db+z7o3K1fgs?=
 =?iso-8859-1?Q?mPWTEYxEfN+QntEdNO5DkgeHgAPMTIFXMsyMja2gxOm6+LbDaWvn/2kZzZ?=
 =?iso-8859-1?Q?d8kVvoCZPtYGLsBIZzO7fZn73nWWnHmHBKLnv3nj0JVeL3NMQoJpubg/QN?=
 =?iso-8859-1?Q?rwDUOKSwVYVklDUTWfnxQMFxY5yY8uG6BaKPi7sSPdRg7sg433uKzl2y8H?=
 =?iso-8859-1?Q?i07fDavG/brOktpJ3RogG5T40a+jzlbKYvq5feKDPCnk1byeEAywlHgNZG?=
 =?iso-8859-1?Q?/3Uzv6cHR+VHzRrIPZUJpQNq1F6vI0mJRtmSYxWM23c0LNyjZr6MI1A6Oj?=
 =?iso-8859-1?Q?JaKDOKlad0WL79seWKQRpcmW+KVx8PQZ/7KO9ww6fiCH4Wf8qiJIjwc2pq?=
 =?iso-8859-1?Q?FonbmBcyI6lA6P3fOPxmjKwOxsrfsMBNUPuw+qZmj9MXS03Ti+FpcFRiSY?=
 =?iso-8859-1?Q?u2GfieHWXZCVYivuZOgg4WzzVi9xB3e0wtJKEivDBM6TD52elNngxevA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e9fcd-4564-460b-0266-08da844fde51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:19.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pffSpZU4hN/ZJOig+/5lZ+ppCAwDpAUe7wgWGNaYeaAyLPdHXKA+tAyTENIzI603OfisJkOKodRQifqaqadaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: OREOiOKylNaH3T46RgbssGMre4_hCRSt
X-Proofpoint-GUID: OREOiOKylNaH3T46RgbssGMre4_hCRSt
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
