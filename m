Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A24F176F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378171AbiDDOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378227AbiDDOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBC3ED39
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DquEd012558;
        Mon, 4 Apr 2022 14:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y1oo/3B63a7cnq2bQh7MhMgqhlbLwP7eLWu3Bh/AfVk=;
 b=r9Jxqnl6vzXVBdbSEQX8k2jSBom1OgzvKgYRvl88VYKtCbrGXbSf0Ia4vsK/rh3zoMyj
 CpvEqf2EWh+Ud/rvGy/xZ33TfJDpx+t2+q5JsfPXjif5pxRc25Er+1VdKDLxC+11g3Bs
 BxPHpi7vB6W5Flo1p22U8ICTTsnsH+STexwVZnpZz/hMBZE5jNWBjcfJvFHlABNNoQjx
 qM85WthhUNskNYPYOhX+9fNUG0CrIE0ajMvaGUnjXA/FzcsLoYVQTmqx7bo8enotykDM
 FZrzOt/PGKddGQGz5mvydxNIWzPn07UkzVmCvBjj5p37ODeB0Y2wsJeFJGKYuKdQERoo /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoW011889;
        Mon, 4 Apr 2022 14:37:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhkT7cG1wD69WYKHfp2J7h204XLTUc6silnIgkL9hctcIMORJF8kM02vPBSkyqRxvf+ASQrWc7RY+bj3ukztnWt7S375vLZ72CbOGAnh9Pk71Z1Rxjuobo440AawzOrGRIfOdu8HUFiJywxBc8Qr3Kvf97DRcOflKUWxbAtZ2D2ZLEfXbGkT4+D/ASpbSiNdgGTdEA6Ybj7WZDYNuCjjQbrWx4/sB80RmtKIlH0x1QsRvE/lFKJYhaGOPRcS3tO982v3IaWoOyI4cu9tYW6/ql4WrhBWbN281gMO41CcIiHDACE8U04UBmdD5zgUdqJjjRYhD/u452jsJ7dP/VD2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1oo/3B63a7cnq2bQh7MhMgqhlbLwP7eLWu3Bh/AfVk=;
 b=BUd7D5IOmy3IuQ6RKY+axlMOOxFOdniOTKWjJrixauF/6MOGMusG9Bj99869vlGBC9VQXlm8T8sWdI/PrEWF9JjOEGUbprgxdg2k0yvRDKjnNmx1B7daqP/JmU3kDRvVZE47biJavXJiI02b2kgTMRZ97X1wW18pOv8GZWBSEIhfJuvAt96y2BC7/Hzla0M9wav1PoyO7FaAVudOwOOn2jLv5Ke20iW15KOKCOIBQQTFsXJF6YUdu4yPZdPhQIM9OjVo+sUKaAhiW5W1vI0zG6v1aERPBomPrpa9GnusFIsYRPFeVT6gcQrhXRIeIqeDCfZgddjVJTMLslTgpoSgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1oo/3B63a7cnq2bQh7MhMgqhlbLwP7eLWu3Bh/AfVk=;
 b=RU7I2oO7pR23B4zuaKoVWiNEiOUgu3OATN6w/hjmTL4tc0fjpyx/dAIemaNgQhRUi1FKWu/h6q/D9q19KBt8dvz3SdFezF9HOYR1Q2V64/ZkufJBoL67fD6wR14dC/3eo4sl4EhUjrzvhYDr4vNal1yCjwCLneYldLv/8zbpSpg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 62/70] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v7 62/70] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYSDFL1++/vJu3SkCe0otwiAUsUQ==
Date:   Mon, 4 Apr 2022 14:35:56 +0000
Message-ID: <20220404143501.2016403-63-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 974253b4-10f9-486c-807c-08da164896f5
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742C09E9AF5687B69F00ECBFDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTazU2eCRgdsDc3Ptm6p5zeBBYlpUPnfgmIvc86JuzuOw7NnNB5b1o80S6V0IzOnj2XvpJwQy+zJRAZfp8VvLq49nR2+Wfhvy0rYP51Vv1HLPWTFLl5mUxYmPUm4U1FWFHr41rTece7O1MDqcZp7LJ/HZbQ8wXhpF3PtWF7vfyDrUBxC5clyIEk1wxUGim5NnWdbmfUbhX4fti6TA47Hwv7dlN7Kyb23UNiP/fiNIG35xRxHQ04IQSHaF8ei5gYgJvfqcjbaHvOUglLRO+eqq+IVM8LIAfOzJERYt+IT0ku7N7H5VXkWcccDNlgDsAjvdTOHoH+VxfX/NGYZTjGdC/Yo+v3IjBEpTV4Bk2m6bZbcTJ7xTDlkibMokZVL0hnjXb+QwYmOb5xOAB+7Q2GEdxtvCHi8KCo7hL41XuLVCNGK6iMFJHBe5fUrqOoE9nxF/tAG62BWPrL70d9ZHrKb1/rk5etU74RSwbFaW7JY7vYGyKSr2r4Woo+OwOJeoHGGwGjBXCX5803XSLQ9zVqCJfhYqGGxjW/eyHnLOnxYe+n6+C561xI5IfVYsMhRFYyUlZYqkvhxqfnYBjFPc5GZFgE/enzjxI4xcOvKkr1aGrezyh5nqEKY0ncsISqJL//QlDU7mlw3uDC+FM0dVQNnLo+Dg9MdQl1HRsR27kofNGj8VrY2VZA9jo3nEkZoyNgXsIq8S10Y4a03M/JpyLHOBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(4744005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9l70gyL+VaeNVizmWUunMl5Y7A4HKn8Mp6FF1Mm/6iAsUlCtS62D21x468?=
 =?iso-8859-1?Q?yh3c2T//ysCdD74US5UYMPe547h7akCKYTOhr1RADYYbPOvWgZaTi2ajrw?=
 =?iso-8859-1?Q?mG4m8/lUbaT6tGbPnlP5mVExOlAyo/xXi+U8eQ5iAJ/zS/KXWmMXjO5L7X?=
 =?iso-8859-1?Q?4fhBD4a5Krilg18YS+qe5Ck6h4FI80srr99eqaRHTAlfyaUBL6gW542EKN?=
 =?iso-8859-1?Q?M+vRUqmNIydP0zMO3mqdLRLZ7MPBvl7jbQiCTNRNXeKUqMWmu6OUslf2ps?=
 =?iso-8859-1?Q?/LNLYr9yFgtPDRyKlkSmoxWAWIhQCTI6D3Vv0ttgzeRT21C6GlVe9C9tfW?=
 =?iso-8859-1?Q?/eJJJq+v0zYBbX2sVCB0nDvyxGaAFzEIVgBf/k1pJTYJcZZahLkuMIPNLa?=
 =?iso-8859-1?Q?aVH83nnTO/mwVn84+7NONPE7zhxWttDyc3nee7/IUP/J9hCbApb7TDfk6S?=
 =?iso-8859-1?Q?DBGzP9KLx8mXMjFkLcMIhMyBU9LKOXSPsSq/YMEiaOPcGb8Mvor+9oqjfd?=
 =?iso-8859-1?Q?oE1cHZ2yGNa4STyaJb5jleZ9R2CX6TQ4Vefp6EbKHNgB7Y/ksRy9lP+HXs?=
 =?iso-8859-1?Q?v0SRZWU+mEgxMxhKTUx0zzDFeNFWC2uDAIs0EZG6IdlvGbx8Oekkj61aaD?=
 =?iso-8859-1?Q?kgzRqaCl7jJqjApe8RWHPbPcyvio0bFiKYFy4MDF5ZV57THV9RGin62kgp?=
 =?iso-8859-1?Q?dvlO+lYLorePK50nnMFLL0l2Yy48nrYdsFejJG3I399ZOxUwhv9jAciqJV?=
 =?iso-8859-1?Q?ZrmEt78zU3DIn0Q/AqEkGqWZfyzImToHVM5fX6BgIvU/4x/O7+Zt9+zj9Y?=
 =?iso-8859-1?Q?m5Fha0cr02yTjNbF5s/JBrrYULU6DYKfPIdBqUk2QkaF74DyJUCmWStmFV?=
 =?iso-8859-1?Q?3GXJBdWNiun0T0r6FWMC7feOmKx2WMlYTBN6/3vn3v6jxx6hjJxZUv9PBc?=
 =?iso-8859-1?Q?tLUgabocvaIXTclNfb0sbuljxqdLqO1vlFtytAVwuTJKpE2ezXSgPHOpYP?=
 =?iso-8859-1?Q?Y5imd0nzwGyVlnhmSVzyU7WjwpLunSaWXDAlIopLfJ8N+Htfac2c/Yckyx?=
 =?iso-8859-1?Q?DQ6NYNcAqqbOliLjB+PqBtVus7eMJHac3TgXEyfL2rUnsmEuvirVIZjFim?=
 =?iso-8859-1?Q?yTM+xvnpGjlyHPhLa/i3pJwsDOl9WMyTOMD2KNLuhv8R6lsxkoRcmMCzmw?=
 =?iso-8859-1?Q?Cc7St43DWLH8m9Z3iIPMkyMLzfZCL3BCjvrqK/4JubWjEzfs/cTWrQsAtI?=
 =?iso-8859-1?Q?KJaev8eSIFWuTHC3g9nkNCXKGKnQLyI8fCI7EwfJ8GY2rtLKXMzebtcgXz?=
 =?iso-8859-1?Q?eBXdJG5ftJUlmhwqu2Af5Va1o2gBJMbiBNJ/WfdWVjPfcggTfr3qCbUPfH?=
 =?iso-8859-1?Q?Ea6kFGQFP+nG5uYcfS5ipaJIHwwUe0nKGqSDnIDyJ7iiKcs1TovaAfvyXD?=
 =?iso-8859-1?Q?NOrfcrK37R7BedMJ6wH7JyMsxC48LL5wyTATAA42DGBF17czg5HFinrZwF?=
 =?iso-8859-1?Q?Ai5kJS3Am815WPUGG+n8YskfOER/z34YloeAkn+9UUr3aTWfVSoCvsfTUa?=
 =?iso-8859-1?Q?o90BPwGWK5IyE1D2krJY6Zj0qE69HvJ7ak544dtJhq5zVEq/dgN9aW6TcD?=
 =?iso-8859-1?Q?D5x/1Fy5hk9l9+nI4AxwOhc3O8qNrVcU9xx97krkHgAu3TgvNpPuL2Lli5?=
 =?iso-8859-1?Q?ypRhF0lIETvAySEjUvtTEtoJobbT3L/+5udj2f3i0R/LriGh9FNfcsxtHP?=
 =?iso-8859-1?Q?UuKev9t1O4OJiMklhIBzbaaE0UJvKt13vxVR00/8PQLoZEPb+t0o5eTexu?=
 =?iso-8859-1?Q?No2DnfCDT2axPmpb/ax2hfT/ewNDgPo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974253b4-10f9-486c-807c-08da164896f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:56.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9waumDgJ89GSKpD85LwiYLEbiYhPkOZfBO2S0QX7H1ffcaOTYQBfBh5Hmr1lrZNWA7D2BpKITOR37v0r84Aq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: GOIAFWIdW67iMx9-mjUzE023CR74jJXz
X-Proofpoint-GUID: GOIAFWIdW67iMx9-mjUzE023CR74jJXz
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
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..cc25bd430b68 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.34.1
