Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78A59C255
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiHVPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiHVPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B73FA30
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVMB022015;
        Mon, 22 Aug 2022 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EvGgR5PM5g2LEcMo7UfZy69CBnjng3BH6/Tvny+qrmY=;
 b=q+Iol9mwoB5nCoHM8M3CPE0S5qkTj5Tin+befIE58U87215ehhnE7R3DmDqnksDY53He
 YT/F1Edr1jIMft7R8IF6mayVM7RUEcVrkFuZTPSaY8N58NvJ5yzMOcz4Rau1j5hHTdEu
 QXKbRZMdov8wOxU9+K3efXgUircfqDudTih94PolJsCsDKKvThmpUVJtwi2St5YMQj8M
 GaQ5/TiKGjr1aI/cC7yauFD2MEyCIDFoUww29wYsS6Z3v2IT4zszD+jk9jTT8shbjldr
 2FJELDLjPQEB602vIwINIeEaMtxDOU3Gp7dJU2WbTLzl2HTa4tUoB6IYZRzYFWtnC8+P Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg38q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ov5031910;
        Mon, 22 Aug 2022 15:07:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3afb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsU7BmCIdstpG8R47XQcAEaw3sI+QOrJuBFkUY1F7NhNFgV20+pbq80yPqlvjm0pLjCDxrHcn8ugk17mNAMIcQplLQnXlgqo5jD0hcwleCs8kdy05x84pRx0l2VVh5oUpzixv3ZNYl0fxQWWxnLn8/yde7wr3ppwTyapv2Kady82WybXt6xrXXoaKDFFqGiWSk55RgArGCsq5/KQHKs9a192GOkbcEZV3X6OrMYI1DXh0UkzkqanPOp/5dnbDYtD990p3xwb52d+O9PdUFRFYyYpPSc1CQEFg54WQpEByM2E9qjEzmDcDJMno0jVrQeWpeClyBQk6xUIgIVlg5hSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvGgR5PM5g2LEcMo7UfZy69CBnjng3BH6/Tvny+qrmY=;
 b=JYLqRPu54P7Zh1CEFEo6a/3BmMUoR1c8II8ZtDTPToNbY5TrUnkN8YFnXLmPw8bE8LyfyJzcw8+a59sQ3F6n3xzkrp11bvvGJEymKhSQWqIZQd/lonIGZDmubG7pBtGy1JdiiMpAEG30wL0+csjj2B894H85AqI9BbsChXCcnb7I/qYciw9aZFleCh2nvh7pRW0wRQmFMZe4zxaz/YAMhmmgoPs+m15PwbYOkcV669Z9l2y3VGdTGLdDu5DtFSjUp72UElQrpP70tbSskCafwAICv3c7BwTRx7rnkwTiS4mueQpVKmIiQYXGT8bRpBSLFOxBYKqjucl+qd0aNKonWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvGgR5PM5g2LEcMo7UfZy69CBnjng3BH6/Tvny+qrmY=;
 b=xiTG/+3YM6eoa/kq6h1nVMqetvAdxJDZ2qAvtnHrunFu6akQCwuAIKYt1CouOSCn/YJ4ar9q9Vvk21Nnlf11VRwZfcYKFb6cPFdDbDoZY4yLlBmw6zD7BcpFmlPTiGLgYPK1aWpq2Hrkmh/Lx+TyFNeiYjFojJghh2s0NDwhEmU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:07:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 63/70] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v13 63/70] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYtjjDCgL9g6e880+/BQyJLztGZQ==
Date:   Mon, 22 Aug 2022 15:06:32 +0000
Message-ID: <20220822150128.1562046-64-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cee3632-0cb6-4959-77b7-08da844ffaa0
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6EGwEXK568/4BFFIEduRpDk+jYGNowVTZ8WO7O7aF611ME+kOq68YOP6vrLc5mmDxFtSN0uUrwigR0vL9z/KOsdKQfK3HWVH3E+SLGQkMjYC3PXaI/ErQxnq8sU9SRdh4Ff8CHwjHMB4E78MbTZ698Ia2OG+lmODFU4wfHf2HsQE/YnMUM/9OTibNfdY3SaVnw7z7kFc8CFOcoUplT9jzkhzFfOwixwgt1FMMuODsN4ObwKOo3afVHVkKwKuc9uBKjUJl91mx97WsAKM3gltFUrZI5zwo2L2JFCV71yA3ZklrrBBuLcSHzefdkekAUUBZCpfblzCsr81lY1LuVQvDTu+BaNFm+uL9/M6ynHbPEn/wL0CLyCfNTvObgBTSFmuv7NjPEO0MAcCeHexDZSV0pFfKCPDK+f7p4YxTbZRAeoxfXUHL98liFk+SGSvMrZy3PGCynVH87MfRcvdnFyYO8o4ACp/iNbRvpeY8clVvUXPKKymthSHHSAahJbLW23av7ygSfni9crEcfwMSQyr3++AkND7wj7g5R+i8cG6X2HWCxasAFVL4DjnMrcAXncBN23/eJed+uAYbPVuhPD2X6a93VRrCzDlDeeLdOJgM8eModAolSMYUJGUCJNuqOfKJ/pls4+38f6l0db5DRe5lOhZnaZG/MwF3y8t2M2+RrURz39SAwYAyYhDlYTqzoW2PS65NkespGi9a6CXqTo7/2HaLQ+tDYYYr94m1i16zqYVjB1r5qImzdUU7pRHkJCGIr/YvDKsa3UidcsSYLv6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(6666004)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(1076003)(186003)(66946007)(66556008)(66446008)(4744005)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YFE27d6si2SkUFyy3HOWjwF+4tpzKJiDxf56VMVk5tDbwssuvcRLhFjhff?=
 =?iso-8859-1?Q?xWC2FTL09UKUYK1xbi34CFzY9ErrpvE2saX1ui3Rkn4P9Bhua+kiSxci2Z?=
 =?iso-8859-1?Q?IaZq0OM7g51eU3618g1ty0r5sy8M8wT2Uvlp78ZE56fDpFoJFc16FkgczZ?=
 =?iso-8859-1?Q?Q5ah9OxpdTgqa+cnIY+sNYpMR5oEvijx/ZdZ5pIHLvQ38RlEbkN9tXlN2/?=
 =?iso-8859-1?Q?KU2Uh8B4zXaUFPAdMgo8CP/KZayoED1O4Gco4jBKUjkJj4HpeSpPK1/0F+?=
 =?iso-8859-1?Q?0JG63GV6W/BwdSDDoaUWxB6kucuFZIxdLD/pHbSrZEIj+0itQsYl+eDiAB?=
 =?iso-8859-1?Q?Uy4cVQvul26cucvqh2PJmloaXIl/RLyCWDxx6qgvK5xLIM/rmE5V4kEuK0?=
 =?iso-8859-1?Q?w/WuVTHiDPvVUSFElMnAZ1kLLGo8uJNMl61eg8SphblPDKgEECEaGggkit?=
 =?iso-8859-1?Q?i3/4zpIU1zSL046qn1lRtBAfd44uQB9+2ilTc+mtJfWPbc1h6aMwmwimaw?=
 =?iso-8859-1?Q?4Zk4ke1Z4tSRGRqLjunJIKauLu0ZLSPCVoleKw+PbR8Z00j693CDNBvzQ6?=
 =?iso-8859-1?Q?YYf+u4qYgJRTIHX52RYGUfWywEvW+aWYQ1AwGmveCS+MdSMeDE5tWDwm9F?=
 =?iso-8859-1?Q?Cjo2DFj7U8kFqr1/Zy0c+rCEQsGaLhYsyzapBomOQno4E83VR8f8C6Tg4K?=
 =?iso-8859-1?Q?1cGnwUYv/121+HERrMdTqrupsS97102VRpYMXGo/IV1iS9iKI1Jx/kalg9?=
 =?iso-8859-1?Q?XOUCecfgtmga6Q57C3zKhpQzykwjjbbcmlD7RfaJ4v2aNiquRJG/nuXUKl?=
 =?iso-8859-1?Q?rapxvYSYeFy7aXmVExFyei1V1b+K0Y9NUXPgANlf+VmbXyOInvXNlBcB8y?=
 =?iso-8859-1?Q?Ot1fYHqxRNJ5/MSRZ0unEDzLuS3XMybj+yBuHfe7PwoTyyxztH+Hd+6Q9Z?=
 =?iso-8859-1?Q?YEon93fJUZrHbRXzAfOyFxqvpMu0+9XNDI22d2Cu0n9jiJhpwWUqKKbbua?=
 =?iso-8859-1?Q?xaOBs0w+V6xlIGCUrL37brV8iUP8BuRPCUiODm4gkQX2PsU9D8N0AfLIdx?=
 =?iso-8859-1?Q?zkElU1ds6m8AeVfpMX5n1g29nHQFyi227bOu9QH2NkdbkA7Jvvbwf07LbU?=
 =?iso-8859-1?Q?U1PC5SnZ7l04FypU6UfWO/19oUsfT54GSsMv9Drj3J0uAaOXg6B252C1uh?=
 =?iso-8859-1?Q?L/7pMZhbHoZhACN5skyfFlzzbBJQqt8aWbuMPfpmmPz9uoBmGMmBLNA10o?=
 =?iso-8859-1?Q?yK3cb1X3FcjW03Sb3T8UTjP1knN9fudOsvzrPSxTBOOL9dWi5yxd29aWSV?=
 =?iso-8859-1?Q?KhREyMvTqytGhel2tM1lGcQ49YRLbiJXEUH3GyWWk0gKcJpBMvgZxUqOLW?=
 =?iso-8859-1?Q?yRcS5QYNtBBBiLTdrT5YxUFpTsvvSyzEKCvhSYTDqdIwfs7ywj8RY4OLNc?=
 =?iso-8859-1?Q?8HsZpt9FKz+SAratd8S633IgLdnbUC2ba674zXQm69fa20ZFURIpJMv4ll?=
 =?iso-8859-1?Q?FMrcG6IjsdLeGeOnquS4bhQ1zwur62EjAMu5OYvMOvlaqbHr0JJ9hSyeIz?=
 =?iso-8859-1?Q?mGR8BBIw+nMNB89F96rJz9IeikuaTQZL50QNmZkqCzGr2ut75LfTgsftnK?=
 =?iso-8859-1?Q?ne4Dpfx80NrSgjT6YkYzEFwZn+eHhlcq1mrqcd5UjMAO7mPddGlKYuiw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee3632-0cb6-4959-77b7-08da844ffaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:32.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8ghTbFqw89i/c8Bp6fSo2sFsnvyJE/4Sas1mb3As18YQYaJl5Pmcyk1Xpp7jjF4AiVNDwnUXVWc9si3GBRC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: O1x2j3kVRu5UOksO3Zzjznpv-mdE4dYU
X-Proofpoint-ORIG-GUID: O1x2j3kVRu5UOksO3Zzjznpv-mdE4dYU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 263b19e693cf..469d9af86be2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1994,14 +1994,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
