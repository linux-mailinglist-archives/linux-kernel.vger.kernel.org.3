Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3E4F1743
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378194AbiDDOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378058AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87913FD85
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoUwS014716;
        Mon, 4 Apr 2022 14:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D6rusBblE58JEB5yfR6LdXEeuDomV+iHuHK8mzsINlQ=;
 b=CSwlgfC4G6f4453AbT7OSs4Cah9yViuiX6gXeCzHyQQiDIgVplXhZ9ov23SGin9/gS4V
 SqAWMPMrY3mlvrcJCaRV8136Xqh7xXP4PpkapurNSuGTRC9/t+snwsvfHvEnhBPQbkRC
 EOaoAxVNmxqgIg/Zk2ZidrQunlNBJ4ZG5uJtkPkqCNCdoWM6te3L7oJ/tN+TN6y3xlvA
 ydfNVqYdAYlOQgT4sqXgwBQI1V3eLAva0XxV8gsFX9AGaFt3r9oUhWPjQN76v6iTchZG
 fc+LLZFoJJ0D745x86smDCv5W214aUqVvTusdJj/0sh2f7wqZAvREZu5gB/DG6/Y9VQv 5g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGced027671;
        Mon, 4 Apr 2022 14:36:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhesQp2floeeze9uoW7DqcxNZ687u74SaEuJfcrzpo9jDO+llVW3i4nRid/hmZiXFk8GY5XPWr3zjXhezVZ5m05ALtybVjoyE+3/cN4nUs5SIyrU8dIgoUltKuW3rKoJ5CjXzdxRyUoDnSGuyC6NchQMm+BpfWq0CuMdMnNpYp3CIEzOy1OMHtqBNHqyqiHA8LVUnPogzz1+o8lV2ob5RcJXiKwGTp4bOxvMzrygKQ0nvVQl8mi77vazEImqiADwVwyiBgKOYa2Mpprrb8lckmZ1IvgdQbmX4WuqYzD9TKl15EYBZk89QpHBtAataGUqSxR2EupMTZ0vew3DplR+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6rusBblE58JEB5yfR6LdXEeuDomV+iHuHK8mzsINlQ=;
 b=TvaVPjH2TqXhfHoL9lY+w64Caw7lzp0CEZA6bzH8+4yoFK/2RUSP/uZzWGl6gb0twm2eyirfuZJEpJTlFixKbcja/7wL7UYD5/dpoSwsAa4IWDObzVNK1rAtY23jLaPMM5e3mg4icYgehiN9NmV+bfhJXDrTUWDV/nNVcrNKQEZKhEqu6+uI33ZruHrhSU8imMlM7h6j4E6ybaLKJ73QFziv/FZ6U3+4zUEaW6YProRbPcGaA8F6zMvfk+DBdq4lLsdz5y+IvYY19kcRKRq8wF+JreAsiLNtGFXG6ADDaTeH4SzU8C2Ro35NYW6zXpammg65V/pW3Ozn7BognFw3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6rusBblE58JEB5yfR6LdXEeuDomV+iHuHK8mzsINlQ=;
 b=RTpocmnEaiGP6cvnLm/BLs24W8Zkj4pNklu5uFy/TSRXEGoIQlug5utCy3t8Q4Bt435ciak5LQ+3j8WZ/1zung3AlAszwF3gYQiZV9/bWBsPwX+0ivD6K4xPg0skt6pKoThlGPS8+3hQkEEJ/tNRyP3T3hKyRGqKJ74KBjYQXUc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 52/70] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v7 52/70] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHYSDFJXly4Cf+iLUWO2mC6oRebBg==
Date:   Mon, 4 Apr 2022 14:35:53 +0000
Message-ID: <20220404143501.2016403-53-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36fb8e78-a346-4569-6b76-08da16488134
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB532976D853D6080BE418680CFDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+qZTGyx23l6LXx3pZXqGyDUPkta0dCAqSW3pJhsfZpOsQMZ60u+npx/ZjrJ9BmBTCT+UXIJRUaiqIYPGpvK1wcotByMwaqwDLjgUKPUiLRVriHzzvjiHGUEnM6YNCGPiOQcujMvRvaawdLHQliGOxM6mTDeYwpTQYln8z5hsWMjnFhmG5qswO2GCqHxD6ermWezf9TsHXMNZe1yNkXwWBHc2NmlSFnW2wtzmOpEaczXco+kKIC++GMW17ii6fCcTmWenhSLqVY/V87lhDi7CkvaJoi4VMSPC51SLL0oZ1mD3K4YAvBWPviZCNYtuG3SaqTQ3BKroDex4Zv4N2JcYnvMYiQCm8JKuVrRaFw+PbI8jtUZGpYdfRiTDYKKqsQs6xLp82RQc1xRFyfcdyBoHepk9XzmOCn/kSBnSDiacfSbfHZHf4H+xxP2HUI9bbLV9JQdxazT7na5OndJCHeJcO7Po1lmWTltmFHtPmuSncV/75OntbSbhtcmikCQBAmdQGtSEV4Md+BrXehm8JEIlAcZ5uVQuInAvvN+qCVZLL03AizuqFkbilrkoxR/hWb2CGIhxHr72Kp6zLqQRYa29f1M3cL/B13KlqW+1xxVE1qgn0B6QO/H9X3INA5PtYEcjcKhpnjOUNtRe0Elwd9ZgU9XTTQDzAer7tsdQECJ7v8RhmEn9QKwkBNTvENpLwFD8y3nfZy9Ljd7asxw0khOBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?htnBWY/NBlFli2Gp+9EVzFcXe7Yc1cJgbV6SMgN3c1FvgzKYR2V/fXe9pB?=
 =?iso-8859-1?Q?FvLZRGvaj3VsxKvzmGcKubBmjbl8O79cwhA1zjce5KLi9p8mFX1eUf6InX?=
 =?iso-8859-1?Q?dFwPCVDutfQXLrt6q2gTjVNU/mLgreVxHSE6ccBq7+GXmS1YCABlzDtGqo?=
 =?iso-8859-1?Q?z2DBF5gGK1Y2vYC6Lr1DQhnSCqNRe1nbu9+Eb2Vhi1ojSzc8x/08U3TsYX?=
 =?iso-8859-1?Q?QXruifqlc8H2LNAHeMuVs6IQ2oqvCKOuwp/lad9uhE8sVkMgHuKzNkqE3m?=
 =?iso-8859-1?Q?8PPNDm/D3h3imJsa9sg5D9wUUaz45sj5D7Dn2k0Q+lArEPw/BWT4MoDK0T?=
 =?iso-8859-1?Q?R4RLGacchhM0yY1CUYtIagpxEplRZsCVlOrciyVDoRBQKtgvFctNHAbzSb?=
 =?iso-8859-1?Q?D0S1setTvhOSMycUKCGW/iEprI6mtDa43laTV1w51B6z3QctMi9gcVhpq7?=
 =?iso-8859-1?Q?pDof3sVTi2IIOZP67Vr59TA/LxnbEvEcxHVDtIiA407zH9ko5BYmMwSgUJ?=
 =?iso-8859-1?Q?7jUTsG5tDeSTB70RyRBYKIhQfSbmuZ3NYkILeNnj1+UXaqV5IBdWthRfdR?=
 =?iso-8859-1?Q?sW64vBMkoKhFAEATx5yazljU+SXt+ogvPdq06vPh1VbbMsytCQVnWLPkMM?=
 =?iso-8859-1?Q?6WK6EIdaii/Zwak/Hg2yrax8PcLIWB7wuKsw5MGOXLnZt+x1plj8gIez+J?=
 =?iso-8859-1?Q?F/DDT5MrzL00rK2XAFIOMUWohXPEZ5BH/3aWkFFb95CuC8N4qoaEnBwP1+?=
 =?iso-8859-1?Q?Lk3qkV5wfcS3CxN7cnHlKCszOl/l9eETGpCGMvk+PP0NK2vaabQVcjZQTz?=
 =?iso-8859-1?Q?xCdR97nU8ToOk1OLXqOtUlu+lthTobpQKJqGoNeE62YO8FFR49Fna/KGjc?=
 =?iso-8859-1?Q?qIwPRRucQ6l3lUrB8KEzhHo2E18cOhRuMWM3N2KPb52hqnIiWfjJFfyRps?=
 =?iso-8859-1?Q?hOW34C8L1Pix3ZsjAI0xxG4nlMvfl71CxLGmWphULd5slIzAuvRP71efV7?=
 =?iso-8859-1?Q?NZpb8bv2DMFwd2owhIHwEVlzLIxAoHFtEpi7iVvbe3oHKBEhlS6/dzXNSj?=
 =?iso-8859-1?Q?+6uccq4HnmEcSDt0xzDgWCPHVVEQMlkvv6EqSbIcaxl2WfD+9DOXRWFugd?=
 =?iso-8859-1?Q?30AjUMYBbFzJY2qw9pfFF2SOpH1VDP39ZE3LYm0T0NTCkM/04mJpSXjJtM?=
 =?iso-8859-1?Q?uVJP0ZX8v1Dy6bpgYjghFafvQtrRUao92mnyS9Sov9HyvHlrULhdD+TXoD?=
 =?iso-8859-1?Q?DydnbLp9CuzlDjRl6/0TXPbKqb2atv08UtuD0P58sX69j+1jhaBRm4Fnjj?=
 =?iso-8859-1?Q?/SUHCnia3HVfhFHLRgbkwYho8H7tdt6TFN4c9hb3T4CJ7MAxl7OXapYonm?=
 =?iso-8859-1?Q?c4p8Aq4n3O+L7Z4wpm07Jiqh5fc43u3+uYGpEHQQhUHYOXGvhEddsWZ6og?=
 =?iso-8859-1?Q?4yEC6JKlu570pLoU/heMCp5IlRH2cJFvKr+EI4abC8sDpL6vP52j0abmIl?=
 =?iso-8859-1?Q?8Y/V68A39zHuPqLL3FKGMS3FA/Cs3z3AcNHQIxmo458NZOERzTvBziKi/q?=
 =?iso-8859-1?Q?8pL4jr9WTfgHOMyn+8199HOIMSI8xBdKuNcFnF2YVdsiOZu55KBFWQXmBh?=
 =?iso-8859-1?Q?5UXXWWSc1eR7S3Se5iEf3B8sBJODG5jpC+UlwYPOo/PmUeQHHnpO8WqJyA?=
 =?iso-8859-1?Q?zXVMXGX+WOTM4ILlqupVpY0aKMsd36BQTb3cLGkH/Ge3JtNGGz1ANhV0Fu?=
 =?iso-8859-1?Q?Db8fwljoHT62uAzTIrrxu9SwiYPl+ruCED0NwtIk0opu7bOu2Tf7ldq9pU?=
 =?iso-8859-1?Q?6rojTEgnTPxsH5E/AOc6A/v4VKCQGXs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fb8e78-a346-4569-6b76-08da16488134
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:53.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9h0CqIxukdVf6dqkh30hnnCPXRdQSiNTQHQLRHzoq/Pa43Zfgr3RNPxidwPvV7GPlBVyz2Mh7KCI+RI+NUgRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: BEVGOTzUOjA78735_jvrE8qXrKUORe-A
X-Proofpoint-ORIG-GUID: BEVGOTzUOjA78735_jvrE8qXrKUORe-A
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

Use find_vma_intersection() to locate the VMAs in __mm_populate()
instead of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..28fd5d5aa557 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1533,10 +1533,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.34.1
