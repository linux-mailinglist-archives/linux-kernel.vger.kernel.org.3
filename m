Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B390E510167
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbiDZPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbiDZPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9F159489
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSwlw003693;
        Tue, 26 Apr 2022 15:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=wp4X+1wyKEzEN+WgOhMzajQvD8UpHusTeuXDyGXLvp/WPhkK7VD5EfTXAfpb6YkwVMIH
 UYd7kzpgvsVdJYllY2LiBO2HXPWW7+Xe9dY7PtRemiCVLO0OziWzwD9pJBzpyMteArWe
 k5HjSRtrTzmqMXzsymt3CefL1/yKzm3EJV1xx5Y80JBwYXiVzg/mm6vGdI+5mD8p0hW9
 2LzMmWI29/Cj7MeA3CkeG9pAQ6VPu6znHhdAZ2byBWgbfIaUWhZZ+icjZjDO3JP3nRcx
 PuK6hgbQ5H6rP6cACWE73bHKOQMrkBzxJnTWShDAuU5/xIttDZljGqiDxgtclpHvd8/e lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p72t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF5553019202;
        Tue, 26 Apr 2022 15:07:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ff1x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDfLOTp6Ixb+EBZkeSS48EJXCrwoNRLUmT2fJlX0hyfeOdZCN1520f//qeB7jdg7yDXqVZ6/f5Q7CgryVBBmhR6b+tvHUYb0K8xK7TZCigKNPLMZ1PtpvHskiaqRRQvPUhV0bUL+piOVCjtbfgaIVKEnz3tbn3EBlhD/s1mvQcrS9Nf3pbel999vi/5fPrS1msmmrXJfpOYyB7NL7NYJLjtFZmTNbmIhQYTbIvLrnmR+meiVdxupuTrZu9X7yeWsX5IxCxoGMiBlaTuspaHJ/xm/of55WzVIMkpj+0boFC+ypa5Us/dKQqt4FFl5gLP+YTeim+puB2GIqr8sx/9EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=dCiBzcFl4llvIHhVYUOrlzh1FCfDKjuYTzlgUn+04tjQSDvxJRMNjM3Vtn0RhyCq+pu8hWwpxe5+fQaaQAKklEDL8qrAUnGbaxFzW7+AjB8G28LOUYjKZLqrQoGgdY1oYjDa/9Rkl+UeqjMMWoaqcyVOhe1NHg56lmJk+KjV3mg1eT1g9Pgvt/d1EUef06xNRodN7lNRphpF7dwsI8jCKC3GsDucII9lkc75kqwbiPnPY9CRMvzp0IoOfifQb7/BvPuwT1rQjhvCMyCxHlbsmsqEsrYeUzOcwoSz4SFt9C3jpHgmnd7NcCDhXb4v9j5yCUaI0HRadvd4Xqf6GV8rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=MdexKYYJph75twnaMrTppEXfZRDJHWUnZIoz6rGF8Af1wYlJ/02YP2Ja9wC3EB12tz+JRisH0GBy3e7ILbZ19r4A09Ejz76wi4UaRGlHJZTIiY1XgOZAm9g12y/WQgOCL31us4gqay4TfwNynMkCIMDscv7MkAX8PKqbX21fgBQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 47/70] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v8 47/70] acct: use VMA iterator instead of linked list
Thread-Index: AQHYWX8+ZwoIhkdhFk24Oy0hqsh2VQ==
Date:   Tue, 26 Apr 2022 15:06:45 +0000
Message-ID: <20220426150616.3937571-48-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8503fd6c-8c5c-47fb-3bfa-08da27967a6b
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929E3763A172BF0281974FFFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmjyuIqRghFcI//dp9hi4Jh2q+siqTeTCmk/A3sH1rrsxSaQQyQbCFhAKX1BRjRIYgTmOSkYfzIu2L8fKoHN6bgxtiI0iFvedbljloKJ+aThEuR9sx246AYsUvq+RDha9hrHUMc+kqnD4MbDCTJg2PoA5FoDdkhL67PzhcgGg2XQrPs2nePZLE8m6u7+igiFxxCJkphI776F0UJRfC0gJdS4WjCwU1Z32nyFp1XtHyJUcvhd2hVOGDzHvJcgQNm9sKgrt2r98c0nZWae/GQleceplspv9q3oGPWO7bGpKUSBcmlatZvKANpZLtrpUf2jWRVBlGWvd4iRCJDAESRoSBXxGWS/SVmmS9+35Xrs+C9HRSPWnr7HA159+0D+7upNSaQZMVswUTtv9rSXhvav1urczHSfmUP456whC0nAMU8yF3bB3dV2zjrk5UamurEEq9LMDpcrxykt1dqdTB/vnwwLJDy+oWuUOlmmBt7xq4kBave9TYmzgO6nt4UlcQ9oSrAZkg52z1L1+MFwtD3xicHDBC2iN2ma6Bcz5y6u3OHbNstsCgBhehq2a/+yxLlmzzKZTxe05s6nHAfI50jgCggfrlVuOb8OPTbm5jZu+BjBOPUNQx+Du2PzjiNxGw1VENP1Z+TybWoazMinAGlht9tm6bcJ/PHNg0RYmLPGuHXm2iksuoDqgWW8IT0rZyuMu+dmPMDbnQXImwZaBHLF2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dqs4KL2Af2GHDZ8fimLJ4EULopwGDsX97i/vEmsv1IJ5CUcUFqt1XKuNvI?=
 =?iso-8859-1?Q?TPcZ3RTwDEF1ED/qf/cLFBOyHJaH3HMpfbqD5efFu/V50juQiUCcAS0dGh?=
 =?iso-8859-1?Q?4mAW9szGv8rb2ItxxuvrRPV/4hGOuzoOiSCfEpUgPij/N0yxfSIOMwhfNr?=
 =?iso-8859-1?Q?2wQwRbwDoPBlb4iwk4Se2SYiPKNTnSIheilXVL8qp2YHuxnvFMWgJrNouw?=
 =?iso-8859-1?Q?lGhfMlLzBvlI9AY6yE7K+OmGnqQQ3wuLJ1rYoTrsfF0YCBn7MRlQX0+Kz4?=
 =?iso-8859-1?Q?99YEUiG5tblh0tK7afoqGL7V5gc1ix89GBYzAuOZvu6fdyw3TmLR1sCSpk?=
 =?iso-8859-1?Q?ltagGX2auL0RzeNaNgS6PgV52t5Vbp/tcMobEDpB1wBuEYwCCzv3i9Lisu?=
 =?iso-8859-1?Q?186Uk4+wIwfwZptZ5zirhe2YM9MrLdXf6SASqLDo7Z2wtKeP2psmMedo1J?=
 =?iso-8859-1?Q?4rzZtwOQoDUBpWYPjfHFrsFmJi5cEpbLleYDWMYwoml7dRaJ35YQTa/PRZ?=
 =?iso-8859-1?Q?dphQ9qZtrJ0gVso0Nu6FrhwhKgN9seP3akeidjdYcgu1AypRMJYln454TJ?=
 =?iso-8859-1?Q?uwwNVADYijW+zdYC0Cad3cDx5g9IX4nJhN5Y+E86xceM55VaFNICsCagmk?=
 =?iso-8859-1?Q?5/mgpmXtyJrhcJlJblPteo1TUg9oUcBW38MuilGuZzxnHCvqBwjcgtSWU6?=
 =?iso-8859-1?Q?rFZrY71ScH65uKToH/K9IDTbPWpzxTaPZ9cakqHWaFJxrCzVmyh/jkgv9j?=
 =?iso-8859-1?Q?KN9FFRmM1saDui+UVIXCyqA1Lwvc2DEt7742tZ2hif3c57XLwAyzvqufvH?=
 =?iso-8859-1?Q?BS97+U2NZSMrbte+ZGMLBnA9n3vtfpwdp8dfYnUimYYWUobN3I9G2y37o0?=
 =?iso-8859-1?Q?WPClDGAb70EkqpmWt6IqwreU17pczbdIz5nERuit2i26conPYaRjSLObov?=
 =?iso-8859-1?Q?jEnmPD6+H+2FoxqcjEC2sU9WA81kK5r3uaWJeoGUv/AfUTNKdh/K9vxsJI?=
 =?iso-8859-1?Q?4B1hnu4UIuoEmkn3Vp1f4a68wXHltxm1Md6LcJ39a0FuZ544aSCw/zB+lJ?=
 =?iso-8859-1?Q?HhrW4yW5y/eEPzIGiyY1XP4fC7ObxAAH6DHAhLklbD2yRo9pGAmzy2sl8t?=
 =?iso-8859-1?Q?BDSRPo+XyeqKNSGVUbpFEBbyZ2zJE4daiKiMyYnLxD765B3v3DTLghcMmD?=
 =?iso-8859-1?Q?CIip08kbBZyqLSQwcqqcjfg3y2ncIOrAcQftMA81BU6FoWM8hyqqXqE3W+?=
 =?iso-8859-1?Q?FKEpZqW/zr/LtoODoFU57vZILMZR01iCM9uxqZkjCk3osqcS8J4o7HLvs4?=
 =?iso-8859-1?Q?0TjnwV3/eZpH/ZKmpSijlC+Wt/LB7xnAFbLTP2Zyj0Jva2B7o27JRQWzd9?=
 =?iso-8859-1?Q?sZiq2udJaYnIufTFqS1k1VKNBkQenZ9WkYd4xkOkhSCpFAw0rw8Kt4wyA3?=
 =?iso-8859-1?Q?s2QCR7Kpsr9uuCvg6frNt5CpV76V1eXCz6W12yXCbtl7T3E2pyHrVhPZny?=
 =?iso-8859-1?Q?YZLinAcuqJkjNYnNETwrVcIphuSeON2u73hFn4409Wp1fv6vUMamlju1kl?=
 =?iso-8859-1?Q?Lg5hgSNT4xcncf0GQUhdhUqwUpKKqkN5Ze6aqyEYJ3OshPPfrI5IYQkuXN?=
 =?iso-8859-1?Q?8dSY9ohtUmkyZnmqox8pl2/EUJlRAl96vcubIAdzmoTDhSo3/dQwYXkT6B?=
 =?iso-8859-1?Q?9mUgth7r/q4frzj74TUVHlinISrbkchbZB86mxWHgs0XJpY3+uaDRt24Q8?=
 =?iso-8859-1?Q?LwRjhS4e8rFAmM7Cjp62KY8D++WAIfwdx2GujIHgU1Kff08crGVDbWIjST?=
 =?iso-8859-1?Q?S/8FRwgkGOJGul0Lu2Cc2tIunEcy93w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8503fd6c-8c5c-47fb-3bfa-08da27967a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:45.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xawviSvbS2QruI8Sbdiyjhfa6IGvstesZujLNiQDWlt5/rDXeqo7uiYRlO8YtQ40hjr1kvEz1AXCDN63vP4E+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: dI6IXTJs-7SE1k7aNOzXfqa1WUaeoRjv
X-Proofpoint-GUID: dI6IXTJs-7SE1k7aNOzXfqa1WUaeoRjv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..2e7bf8d41f04 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
