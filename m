Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86B4F1769
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378017AbiDDOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378224AbiDDOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F15F3F332
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DkEtJ004895;
        Mon, 4 Apr 2022 14:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bn9tUALoH2ZY2EYipSJTGjhFGBzH4Utifu1oTRL/XA0=;
 b=PAWRnKsEoKe29MffebNrqFq9oAti4HllGnehSWxEdvYADlHgy9/FqWBLI1ir8XEtLVRu
 nIg5hwQqVrYs9IaLdhfJq4YySuiA15I3EpUXA0GMiADnim8N5DE+Ct6d+E8u6Fk3Kc06
 WL+EmssJ9pu0JHgULMWEGZWP4r/sMHr/O+wIIhHSqqqpJ41SSSfSgOdf1Op3Noj/TicS
 jWFfcySGtJC7T5JKa2NH0xhVr2gzGV1jQ6Bx0N/vO7nWdUKMSeWi2tQnIIuXDnnBTIas
 UA8JAt3qnXkosvJPLMbvqA7lK13vuCTv94WRzk4+y6fxYgkP6hRbiagXPcYBc/p7Cuoa tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoU011889;
        Mon, 4 Apr 2022 14:37:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEx4+YqdmgjX1aJ42dcOR3kN3KdzKGJ2aifHeNy07L9Crb7F0gCD7M+qFz2a9Q8eg24XHzzYfPARk3Z4tLhBizXKLnYAFbu1VH538ng0qQCkToiOqptBwvreEPYyMAhWKsMQ8Rgkxk3jVt2vihDds21q/kTeobOEdYuiwfHl0u4phm/+My3tWrHskf1Ea9r1smUVJNdodM2xG5CdSia24FSijORRX8v6hTGXLZpuFaCv2R6pQ+NhAVG9jQW0A387iL2mwIBpNTIiGi31sup07eLhTUW8rQ5OenjDiqRdfTa/weFmDGuCXzqGHClvYGEfcVecHzaw485W6UEFkmsy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn9tUALoH2ZY2EYipSJTGjhFGBzH4Utifu1oTRL/XA0=;
 b=loRTPXhMsf/B+uwi9HL9iimhb3Z02m0ksbXR2SPHhREo9fvSprRP6cqa+HlITUujfkNkYN9Ce7d/HyPKxiHBAJllmO2SkpIBFS44TVnhHBogiNQTN84Dfu44SjPDDAW5daQitU+byHNtqN6rW/Me09bm1rcsfnmuGU2aUDyv9bhfhfuuyz1LZ+DfDjZgbm9b5lm2ZE4MV21CIx+G7BG6/zMVdoovCdM9Dg7VrX2srTA2YLftXH/DI0+Gi3xBcP0QDlx2RH0C/Pu75uQFAGFTpQjWEPlFXUHIO5bQM+dpXlgzf/3gL3gIwp4MW5BcjQmve111DAZEJRbvYybvLSbr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn9tUALoH2ZY2EYipSJTGjhFGBzH4Utifu1oTRL/XA0=;
 b=tiqaVHb55bzNrZBi0riqy4G6vgr+fk7HDmuLSuHYEAQLj5H9uEACRCA802TFZv4azvvXevw0DO6a419+tocRah97m/nQaYRm/8/j4asVjVFhIM5xz3IBeoiycCjNBD0uQV9rie9jQM2cNKDtMuCZJtCnqku7r/hcd2rCL53Qywg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 60/70] mm/mremap: Use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v7 60/70] mm/mremap: Use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYSDFLVsm7vjgVj0qx6TFXWJ4gUQ==
Date:   Mon, 4 Apr 2022 14:35:56 +0000
Message-ID: <20220404143501.2016403-61-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7263c1c1-8d17-4f89-1394-08da16489664
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742B10EFD4C03A0CB1A1C82FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSERjUphpI7G3L7ZB+kk3wWXpSOMoquiPt8W4js636Y929YKtCtwCW+oY9p0BGNT5Uu8k/CwI9bksrYzcVcz/F2x0VQvP/EWOysaE9gS9c1zVI/XwGxC3R0n0O/U/cgGRi9bQFncFEsDbY7CecMfQnECMY9og36fYZtu8ttkhKBuJUOdDmq8tUcXIEiq6adf2KKd3DoBLpiDXNsC4B9mL+nhwMdl4GOeVmmvSOMM+Qah8FquGOH++7jgJE7euKU/YBHYBDuaupAy5vwXtRHWNMs3MgCCs/TxmcQve2wZnaZ/ERWrM/kH3iWuPifNOCYOLZxiuo9XufOk1JqyDEf3v6I5C30xgnmZ/Uc5U5CWCouWY6WLNkAqtkB0IK7PfMtjqhrsxIIupilZSt/BO2CIeOxpyT5B1yeU1bMuqcVs/qvZ2okvz5LaZeudqF3JvuBva6KW0zjMJnDOIGDJmDyoKFeC7Yg4yp/Ul7tebgB695flP6KHB+HfcWducX0aFZyCXAqEMFQe9mbJFpm8c83K0z5q9TJ2RSMV9irEAHAGKrd7aOy/fjCmo0YqNHIj2qhhZ9WHvdZdNcdC1/m2Qw/cmxDJsUHto3Wnlw+UGyJ4e9GNhV9Xs1s7RK5/7WogFScIHBapW/5zsgWWKm2Do5d0ptsjTPXCUimMo4y6fEdp46Y3xatXLi7gershqs6zY+8pGzoEgs9kTpmEExGGUTrU4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IxBtNKY1aKEOASqLlMLHbTwDFC8R2Cfh3syxpN7wJx+RCFtT84ABiM4FSP?=
 =?iso-8859-1?Q?HJVDoYlRlPrCrhh8aY0tJNChLDUJ9wSCfRFxTkJ0H0aMwnxHImknUKNs0O?=
 =?iso-8859-1?Q?4bjVV7qLhNtNXkfiBlFckKlh/lFnSlSaYnXcXEEsQUESD+YumKuB7YDDZ4?=
 =?iso-8859-1?Q?xV3iUTc3q++Sh5OdaqK1ZltDQnx+qaVQ5fa1aSPPcFRtqFmJoYjhbeE+br?=
 =?iso-8859-1?Q?a5dn8RHpncYnYb95AEarWHm+BlsX0bDj6SefaBujWx1paruKQgibrc1TuK?=
 =?iso-8859-1?Q?O9S1gWQowyiB8HypAvIhKzewaRyAyPrYq6c3eTNqQD8zKWbbjkUtH7GTKj?=
 =?iso-8859-1?Q?boAh/aI5MoiYYc0gHOlKG2UUzvvep7fXxTnuBUTSfqobQffscLSvCXXBWY?=
 =?iso-8859-1?Q?SHNGNeU7Q4I0OuZ2nGNbOBviHFAW6dIVCIN5QBuwPhK4u/D3RkSxkHsqoW?=
 =?iso-8859-1?Q?odoYpVuE003iaIPc74UOnUGBrHa8FXVAVadcT+VglF6vYLnPoxGTCM7b/v?=
 =?iso-8859-1?Q?gorEuUYHV/31oN6JQ84Oe7ugqvbncM653V+rLdYqCMUBGPXgbGZakDYJh5?=
 =?iso-8859-1?Q?dkChwds2VDNWP0xwZarBNMFaXboj3urVTvnc7UeIITDEudlB/1eDbYxkYA?=
 =?iso-8859-1?Q?qFB+vj1p23K9l9cVP/DM4gxxFzJuXltfbHfl0747Gj6rjG9PmQlZ6AEymL?=
 =?iso-8859-1?Q?wOodK7g9rNKCrWJh/JYRrVg9eWjUurPjh9yy+u7pQKDmcstFvek/kN0tgS?=
 =?iso-8859-1?Q?KnLsRHbKWXLtkZt6ZIxwlhv3MyyPg2A1jpEX+egmA3W8g/claN721oHHQw?=
 =?iso-8859-1?Q?OSXWudNiP72s87VU/u9b/T7ZJ3uWODR63W49WpsfBLY/NdaHY9Xch8irrY?=
 =?iso-8859-1?Q?9DO26S+MtstK/yH47CRb+TLUZoda3UcEb2j51sfh3ua+4RyjRUH6QyzN+B?=
 =?iso-8859-1?Q?0tqalRxcHXFHrWfJ2nydPgGpMxTWoFFQ1RiduyDLIHnytXlp5nsfEYUr1g?=
 =?iso-8859-1?Q?oKjToJk8gJBU5hTASJxCdEa48pDbS54cDczFgqdy4m7oCgmKwlMtP2Jorc?=
 =?iso-8859-1?Q?A54s984RtnAdMUF0LUSwLonsxu+eonYVKhnRfXYY3V0qiE+7nI4SNq1Le4?=
 =?iso-8859-1?Q?8JKgnHYFSUM7EOdtXZ/JKsuigp2eEzorLilS9Y6mT23+mite1tMr8oey3a?=
 =?iso-8859-1?Q?+xZ8DMDQOfOwepARRrML2TfkdEzpH1GJ+npzW2GQ+baPjwIKi9SST+MIEe?=
 =?iso-8859-1?Q?/fAuFAEzR0ND+s8ilz3xe3KEdvFnu1KW65uH87atLs/j/yEe942S3mbJ6J?=
 =?iso-8859-1?Q?Y2a2tfqcP6JOiefNDTwV8zF26WMhRetkKXhQMA7Phv4+WmN94oJLllubKU?=
 =?iso-8859-1?Q?O6YMPaTin+ElvQSTRfdSNA2GnD9nFcbed55824k8gPb93j84Vj9ESpPZkw?=
 =?iso-8859-1?Q?CANSd/PHzUSimKRdKNu9oNwQ2Rt6JBnTjgsl19J4BtG6pnxFuL4TdSevpy?=
 =?iso-8859-1?Q?drSPGkR0pgtIJROHDaPrjG9sNkufDXgGY7oZNK1D0z3dYvl/3QsSlpZnPc?=
 =?iso-8859-1?Q?lZuxZ7bP1AwwLpXVb8Y1jg5jUfQfnQYSCd6/HWZghHrNVtno1v9cfJNrtj?=
 =?iso-8859-1?Q?ba7D90Wsviwasi/45uP+SqE9IxQjTwYjg5p7wF/Bxi82iVjdLXNRF3NXUl?=
 =?iso-8859-1?Q?t62ghKpAm4chbWwpA1SPft8h3ddoiso3MN2HcS9OS2oseeMalNtVRgq32j?=
 =?iso-8859-1?Q?3rJY77QUZsLB8HPvsXtq0Z9fjA0PCGK6+Y1ZoiXjkZWGfwkoxqcbHmyyV8?=
 =?iso-8859-1?Q?lvpQLt+eiNvU0K9RwJpL/KOnQKzoitg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7263c1c1-8d17-4f89-1394-08da16489664
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:56.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y74F5f7lR2/EBRAb1cnt92gvsIf4k5q3pioMXQzYPV6t6Dmzcgo+qbcfrH67N2S3AHKxN4FC2XlpbmH44Sj6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: yq9vsVDqxnLGK9JaTZtYLxmnz5WUpYBJ
X-Proofpoint-GUID: yq9vsVDqxnLGK9JaTZtYLxmnz5WUpYBJ
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index beb86e6455be..a6f192deeb7b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -869,9 +869,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.34.1
