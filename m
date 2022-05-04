Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92A519342
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiEDBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbiEDBRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05E424AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MIwYM026114;
        Wed, 4 May 2022 01:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EiolpuTturdroffWGoqMZ+psv//C5G23qSxUPNKeq3M=;
 b=WA279rx/bKIEHJhNEK8/jB4EIcbvrdQyj8bqnAuvg058OcE8Q/3EUA6U022IBlpJHvVu
 VcNPw3x8scz5LQfekPc8iM9LVM0ElgSNmoDBUYG1nH7kPXvnR6aPh00l2cPdNy++2TlH
 K+A8h0K4tZuBgW6dGk3H7HqZ8Cd4jqJXwDYuXGx8qM1/O1Lom9D7W5dpOCmgN/se0WfK
 fLtCUe+QtrltaD0V4RSrIxnp3d3oMho3q9qN5Ia5rWSDY9gHkOVr9oQpQJA75snC/tbZ
 Ic1K2reoM35878I5ccBCEyZXQXyg3It2gbSX9cRDvlxkALXFudu6l8kuqjck7vfScpo/ FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJc013094;
        Wed, 4 May 2022 01:13:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0p9UCQtHFOSAdymbmLLzQQELMPM3Ue6r+8sd4sbdezdBDEL1841TaPVY0J7AcmqPX32g12nnFYDxwjG+PGx0biKEKc2J7JDBtDv+ukxXcEOPfvHvS7OT2AfNidc8aG0y985AE+4M3FMP1K2ms6Xt4E3s/IkoKWgktNeX3THhvJzDnCYFgHoBwDFd9e8r3BWFMFddoA3TPGCrmWhmJj224U7qm77GxbCm13AUUO9j4aGdTmkxCRZcOgjbDCMYiG/QBLjssHlVabbgCeyHqMlP3E+SOZC0ly2dBbIwtA+LJH59PcI73MbCb2+n86h2AIYYpmS+nA3vsbNUSGYEQLWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiolpuTturdroffWGoqMZ+psv//C5G23qSxUPNKeq3M=;
 b=oUfZrGVxGX56GK8klFbwOBxVPDH4U3SFKMOmL3ahWKv8AHZVV6AhCHGPTyrvQSfMTfe/zg+iLxVWxpvWwcLF+okY9+wC6NtlEOUTrbBcfGo1qCNCFYPT6VtUVlvShsnQiSN65MGGHRk90f7/YYdHpofCFYkOYfRF0+gw9TMbBRFnCguJE9FnIf6FMLfQR/iMLCUx0tGfKGDqm9GVVOT++ghowA8ZFjVihwab6qeFCB3iKmsCXamH2weCyuHrR7q52iOBqH+nVxOIqFOtyOJDFm2y9LZDynlkBcN0AFWlhL3xZPPKEe0kiJAi6NU+XwLhP6k6qN954u15ubmrpcQM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiolpuTturdroffWGoqMZ+psv//C5G23qSxUPNKeq3M=;
 b=J9QKZ7yI4taVd7rrf24Xv5rGgDG8jAw4ObMQwPXka0M+dsL4F+Y/pWAgVof4+O2LT7TqqYOX3xZxE2VPZMWJyXFcf7co2VZEw5dRAsk7xLOxSbxl10rSMF/dVjOHzq6WaSFBwIk/tQbj5h2c5OgMT+F4Mb1o28i+U/YddTwZvx8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v9 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYX1Q4Q5Zz6tCE+kqwHUeEPTTlYA==
Date:   Wed, 4 May 2022 01:13:54 +0000
Message-ID: <20220504011345.662299-14-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d51491-6f6a-4ae9-db30-08da2d6b5b80
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB583047FE87AFC2DED6701255FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYoiEOtfDRdp7QoeClXpBrJNmFQLAvLuW2VAL8MhrW3Exxavgya3TbWS8lxW+2/kRQSJ5Rj6Jl4mMfoqmBq2OFEScXvP8uFlH2Azh0ZAwbg2/3AzNw3uDuuVxW3mafvM2MwraDKFxQTG2o0H2RutiROfacVbXAPgvOLiZXxI7rubIH7vZmh2+rus+9ETDgt7CAUW0O4Yie0Ar3DvtDUf/NvhN9DELaXKpqWx/nzf63w2YPpRnAqKjB/+zC7SSCmUY+bc7yxMiVsKZztD0nko+uDVG9h8nKvUJz3wXThstwOfQ7nSOBaoGbSNhxBXezFCb7dhWOJaFWaSzar+mVF6vFGVvJc3jrP/XplhDo6EAwhfsGJwefHrwZk+Hzuci5Rkz0TPCt2NvWZMxs23bfb2zEabL1M28ITi7fuO1R4MOmPWavVQmUOoFLsTBcV8W1Tx/UH8acxPECNUNlRq5pkpIPR9QhM3zzqXiBePZ5T6FBVAyIyNWTb+AM1FhBjITHijV6OYQZ5D4mXFw1tAjaglGADjf3PAHcSeF8Y/IHKj+Ko7S+WnCvIHMgzn5OutnYMlfEknBVPdte3ncLTWzNhCHuiXZ7jYgsg6fHoyQSWRoSbiRrDFFv6QAmZQ2KxFnVLwUUrFCrindIpvvjNs8uGdvoay/F12Yp7OxfSu7qP+J6o5jOrqZCzTW7i+9a+TLet+neuUsqp2J/KZBAvh3Yl3Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dG/fBgKDVOAbh9nEauFmhY+OMXl0fsp4oYryxRa49dqygYzOdQ1JrA4Ztx?=
 =?iso-8859-1?Q?sxiGuUezf3DHm9Z1OtZe/w1xq+vFZerXMuwieckpOBveiYiKB741MKxpHl?=
 =?iso-8859-1?Q?y6kP2xUmNnSkENhiBS99CDbQ4JOVj0iuWpLt76nMANoXV6Y5fKCfFSIaxT?=
 =?iso-8859-1?Q?HSgcygslHfqhI6elxOvqvvjx8wbfLzpz8uTBTNfm5H1L1UCREr0v77Beho?=
 =?iso-8859-1?Q?iIHCBFC59FmkUKwt8I4ipLRTsC/OBZyOKGSjCKkzRshZLJ3caXycy6t1DF?=
 =?iso-8859-1?Q?vhrXIvENR2T16Jnho2k+6mKMEtHk84idaq4lq76ZDkQt262BFpdmNN4ltO?=
 =?iso-8859-1?Q?XikIECGl+bI+akxCZVeRcFSAR1i5ugm4xNzmTx9VHlZdjgNciB1+i2L2MC?=
 =?iso-8859-1?Q?wFyplWPQlj4PSYHVWik9s1X3F6fM7SBnzlu8DCdWVcIOGyE3ctiA7Cpd+d?=
 =?iso-8859-1?Q?9hYhTs8DKUzXrHIrx+AgEcoF75m85msftmUE4BulQdMgtA7as+7mEfMgXb?=
 =?iso-8859-1?Q?hzaOd8AqpddytrmeaDfQMN/USMAOj/I65zHKJO0UZ3P7QKld4+V8n8aZA8?=
 =?iso-8859-1?Q?ltJyRPQYZiAEuZhHVveImoYr6EdfO/SBWCft+oF3sHinyKUp12hy+hLiMn?=
 =?iso-8859-1?Q?RXU+OoSjJhaX0oO5e/TuXwgkyVews29fvcgcFwKDnI4yEFZFvtXakMOacq?=
 =?iso-8859-1?Q?jDbnkWc/LLPUM45WN655Sg6IEArvnHRbbZmwJq2KuhbyZcgktHCyHUYza+?=
 =?iso-8859-1?Q?iTVt7TEyZSvD9GMFR8ABpfXTFMHvMKdrLplGHAptUhth0BTjsprwSvN/Sp?=
 =?iso-8859-1?Q?EqWGj6HsB0yvVmXDGKbBL3HLoTgV1/UUnlFeZhFxcn2rf5gIcxXUCvr4qD?=
 =?iso-8859-1?Q?6HIK/BQvwPKdLH+Bwi7Vn/ikjpMcMITZ1srKSh3bTdonqBEpX8D2vKIQnQ?=
 =?iso-8859-1?Q?UfAl2W/+opKnNLDq2mDQITMGu4SwVSz1SYsx3qaekQMazLbcyZD8HJoEdI?=
 =?iso-8859-1?Q?DdvE+uiJo2ZyvARBQvq77t1LxWoKDs8nePy9ZcX61dTFBdG/uxkdYMnF5X?=
 =?iso-8859-1?Q?Sq0lXCQGTptSAIZkcYIlCgMhA6qnnRDFL0qfLmFnaO+i0DH83gBQhxiOPu?=
 =?iso-8859-1?Q?6ZOHvWh5rsyHAtpr7vAJqIjlx/Se1MRJlev3f5/S3qP4U/M3ONHJqO29HT?=
 =?iso-8859-1?Q?NlZEhqu5xkErLg1Y8kFNDo8T3yrTJ0yXApJ0UMz2uErBskvgWer5s/ozv4?=
 =?iso-8859-1?Q?eH1JvGMTa5ib5ReeHlWSBu9dr65whfs47n1G9idFqE0w9ZfSyTWepYUIdZ?=
 =?iso-8859-1?Q?HNA3R2Db/0NnABRWmjCL7PE0xpI8p5OU1gXbXqgo/Wd62NghkhJk/zoOeb?=
 =?iso-8859-1?Q?cDw1ESBS2Q+oZ7MtZJ51YoAnmtgCAanMQxRbmhmdgRcwU/VgGdaEysHrTf?=
 =?iso-8859-1?Q?PD5O0SKw9Awb9uuX2CXMnMniT5pJjqqOtaMEQs0BphUDXxQf/LMAwmEEkh?=
 =?iso-8859-1?Q?X11ToNQEs9cIdw6wHbpCcLYgwBZB0aw6pLW+H3/DcizbMP0DaBjSGqjVU3?=
 =?iso-8859-1?Q?CcU2z9BAEGkBjwjoH8A+GIbFk6/MmhhKk+FH26rAtth2DMpWIFAYKEGaT4?=
 =?iso-8859-1?Q?ux1NIygtkR5F155BqsuV1NkOQ2C6d1KUuaSERunwQVkvzQtKgUg3+Gi5+S?=
 =?iso-8859-1?Q?STOl7wnLioHC5objvXTPZR/Yw5bHVhLm3UydL531SVbD+hsnNN6ZYKTIv7?=
 =?iso-8859-1?Q?bFRnLmkoFNlmrhR7AAZKnrL/OPgC2pO5+8QBLfNL3ulCerW4nexmdzy6+j?=
 =?iso-8859-1?Q?2xbL45Zj4cnBCH8dc49T4VuQeuhL2RM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d51491-6f6a-4ae9-db30-08da2d6b5b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:54.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaT5q9mvhki+FCnAAY4mP+Dpw+4OAJhCHkIQi3nvUxkTaVg5YvO11gHWISz00df0gd2jsX0rPVGWm8BvNDPJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: z7TOrrAAlwvc-c7jZzCgAE-yFnVczCAT
X-Proofpoint-ORIG-GUID: z7TOrrAAlwvc-c7jZzCgAE-yFnVczCAT
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

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd21f0a3f236..c3609e4e6f12 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3041,14 +3041,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.35.1
