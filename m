Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63E519356
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiEDBVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF0443FB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KbxhH013665;
        Wed, 4 May 2022 01:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vd+EViapjIwU61bwAFtY7bToAuuWicyFsyVlWY0nIUk=;
 b=OBd5iweCO05RWBG23Lew11Z4l9ZmpggPVAUD+O7HuwpZLc34T/eGiZs35YU5hax/qsZF
 Hm+g4NCscecgzIh3DfOr7iOOsxDwtlwxsKb/DE77ZVcSDC/DZeKZBA5BEHqQ5zIreR9I
 kaWHueMW4TDNsjFHKumiHqkPkAHPLOnX8LnUpvNFVE45Su3/IYlbIRaBzeveJg8vNr5H
 1mGNYAC20BOSmc0lf1PQb2UOvVNTAbxQNXs71fY95cDhKWFN2EAg1ecjPuT0fHO32Inu
 e2tCWIBjm8WnH+xjl8FWQrxcLMNRo4JyXPHkUMGHqY6YdVvXGOmWJHizWeK1oyqWwHcq 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AUFb023411;
        Wed, 4 May 2022 01:14:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9g4fp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7f3r5MqEyqXnmwWzoFynETup3blaSHdQHiedaRbZGAhvmSq1QEsWWsLWZfLPyWLQsv563UXw1Kqrwk92YjCq9q+DWKh0GHGAg7eatFGnvTNAVrxpcC6EynXp5JufemcDLQi1nz5xRly6LAKGWj9EDSzSAT3rcAmXUqwAvFv1O1/cCmkWPbn0G+3UmXl+oBHlIRkZrtCgD6U9Abib5TBuCn2bjU6dXL8rhzHcnDAB3YLZhyhlGhDBPQ/Puh7E3fp2ynOYOingpTx2Z+3MHTGBB0NKC8szXOizO7HM6S1OUvI3iOerRtqqHLGZuIyY3GRG6j1tNHWSe3rLDIHfmHoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd+EViapjIwU61bwAFtY7bToAuuWicyFsyVlWY0nIUk=;
 b=eiIkN5gcaFwYm8+u+Abfe1n+JLSJnXDl2uugGwXw52qrVDhx4gN/FhKdz33bNRcp5+5c/lsKYeXttHGUmTjWDfd47r2aWtVdeKsJHbUdI2DoLR5Tst0DlI30oN/jUBkMQKyMXnCu4h/oIvoyXWIGMsvD6IjlKWl9nQT/JWPDg/ZOeNZbvEGdzIrq5Hw6QzvH52TbXxDICddgdxTkJtPqv3mDaOShkG0MzMSdGCEesxROOlR5w2gWs+Y3EnEGgdnvSQffKiMf7x7S4Nk4DW8sgKVrPLt+i7qSOcMqcEdNqvlAsyWyzoV8h0gjpCRLNaLK8Iik9Nk/ZiuduMXhMIsHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd+EViapjIwU61bwAFtY7bToAuuWicyFsyVlWY0nIUk=;
 b=erUPZKqHj1vOvYVY2wajca1FPbfUx7ZIjwFyrxNiFPRO8NKAxT1m3Wl1SytgYbmZQDuyWSruv4pBfIdZHhb6QZ/ovsFpzc9wW87wSplTfVgQNSsAwROrdSwlGF40SNbeVK0oocJYnLNdma6lDvm6+9LV7SqYg1afDhBg9ymEkiw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 49/69] fork: use VMA iterator
Thread-Topic: [PATCH v9 49/69] fork: use VMA iterator
Thread-Index: AQHYX1Q94dVKbIEfLU6O2Y33bOeUbg==
Date:   Wed, 4 May 2022 01:14:01 +0000
Message-ID: <20220504011345.662299-34-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 027595fb-d6a8-4139-3576-08da2d6b745e
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728F331AC75C0F5AC379CC1FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkZc5DP1bcbrEWFD0F9X5JZUkkhnjGZxSflZVH6sNiUGzb754FiZ6rqfrRToDpw/cwePLs+7NZtaQIes4MIIGfliN6Z7CWncINY9FlkpQb+kzUoxwelF5YUwmIz2GUzzNHC27e5feuOrSPmqFhfKtli/Z9Paqg9Xi2/pUL+GBwFuvvucawgSbUbGmu5DfxryCQkjG8n4p0shoIQ+UW9Uwmyx8IuIK+nzs7ivPSH9mUNigaFkmP48DEXbgAeVjRXOHXtv/wmudhvvEBHp+qgFJqeypCv+67ZnF3YzXgxSJSsmuZF2JpHm5+yenJVEYHGAXX/GH2lTDqvmhyjvW2zbncWWPd37IIwyd+fcBjGLmjaQy9i2WATWlqfj9DCI+G9+lYFlLfpf01En/wmEPi7BAmRybcGWlZnAaOFFUv2qWFnJFNc8DYIfr9FX887S0Ot3k1rV5BzOKOnlZ3HnOtpe75CcRkHP4kXCrqu33mJxiL6rzT8zduQUjOwmmB+D0W1qyUVk3yJ1jflGraenS/3EEz24lNKStoBHbqZP1PQXo0pQ2c/z9T0jn+xP15w72kn9uC6TIR8B7dHtv8VSGn2kDPWhhA+CCy982nG4knxgSK/GxUWaKQ/Wx/MacL4qljvmkZFYWbpUGz5iax/K84jwL/bMCk8CuIrtTXtHv2ybL6xChF71cQaJHNbj7IY0492L3j8SBTPTnZ4vVmYcHuD3rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(4744005)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cIT4982oHhFPKl3DhfcZdP+7YBWc6L/Jo8P2dseFMF7+xZRUgWqGi0TbFI?=
 =?iso-8859-1?Q?MD9GuNhItmCFlY/0oxov0zgvJAk8NtkUzVxC4wlkVocPmgmg/Owq9rrcvp?=
 =?iso-8859-1?Q?cggxSFHoG60yoeN0ETyPL4vidjSwL81Olog8A4NfD1MEOCkcZ0Jrttjtv1?=
 =?iso-8859-1?Q?6yA8sYlE4VulQjEphZgEsnBWOur6CMQhd4W5IX69Oh8kBZe1bTZEj4i/4w?=
 =?iso-8859-1?Q?EBcBy4cXpLvGUNjZvYLKbjkNF9DEkezMBfq0gmKV0NaRRQE3mbkxAEoku8?=
 =?iso-8859-1?Q?G3Mi/dJeaogNtGhmIWLtkmCvSjpFUqfBRze5FuOiILS3NWMVNlyI55ar0X?=
 =?iso-8859-1?Q?JK/fy7avtNq7EDItwWpiSwPituK3R8vgVbTZThUyCDwK2WafLMVOPCqgjP?=
 =?iso-8859-1?Q?m1UBCSO0gvu+NbX25DbX/ZUVTHLRt+VOLqw1vYCUKJIvtHMw3KADaPQAiT?=
 =?iso-8859-1?Q?JpovPugqmXycJ1+i854sPW+0qIaZ7NuBX2Yi2ce4TuCH5Hc9sK/AUwcBAH?=
 =?iso-8859-1?Q?Y0rnjJV31iLIcjKnwt1/i/egKzXB/jxputFKKY3T7AH6X31+dBmcX8RmVn?=
 =?iso-8859-1?Q?6SqgKWvJTWysThIWRla65/IuzOzey1e8OmGb/l/Hnmy0buRr7EzYQ6/WH3?=
 =?iso-8859-1?Q?2CICebrapbJDP+/G3Dn1YU47i3Xh2VKiL18cOd7ogQSsJjf2DctP/XcoKY?=
 =?iso-8859-1?Q?0pR1dSFwo2M9oyLClb7f00lBWecgA8bITOrISkpyKFR3RhCtoh3XzNPx+J?=
 =?iso-8859-1?Q?JRoysJVWDLvcC1CwxeZh1BcPZEjIUsllaG5kH3o435kMsP+6FUjuITTbIH?=
 =?iso-8859-1?Q?EChbhHoni0dCmqIngTcaQyXbgp8k8yGs3K1QuSfPtzkC4ZbsFHu0XnrijH?=
 =?iso-8859-1?Q?xG6GHFYlq0RcBIb6A/i5tmo0Ly4hkE7Uai1iv7GTKQF4gZzIyo3PwIZxqL?=
 =?iso-8859-1?Q?pAzU3woHD1o+qM8DXKC6lDkmoGa+AUcivZ//JePJt8B8GFHsXirpw4Qj4r?=
 =?iso-8859-1?Q?cYYh7SSRmpkKu4DDCDZEnzLNlY3y1uIkos6TIwjbIQBM1ChHWyNXEb9+G8?=
 =?iso-8859-1?Q?bP2BtoAaA6WEAX/rkVBzYEUfk6z4A7e9+bwuo/ho4yiW38JZ8ljAelNEam?=
 =?iso-8859-1?Q?lpM5J9w5DA7U3IG+8+dMd+uP3/IYo4W3Fl2Y2iizDhU8XLnP5dH/dl2tI1?=
 =?iso-8859-1?Q?3ouMqwIDxZig2GRbXxCXid9iVTxNQAuWSLmFF7Mg8Y7iWY5Ogr60gtRI4g?=
 =?iso-8859-1?Q?m/BC1WiVkQ8X1u3lWbUStvmn3UR4J3QYvzaZ3c37tXFAkuC610aonc5S3L?=
 =?iso-8859-1?Q?vCLBPGfV2RcITncEvTgWxrEbuAeludxthOC7OT4Kh6UIQEJSzKFNeILvpT?=
 =?iso-8859-1?Q?3oADSPlIMX+Gc84Tn9t6/WJ33WI3UPD0yIYm8x94ebn3LLtVrwkw9CqR9l?=
 =?iso-8859-1?Q?Jj3Hh+yxVvGG7or/oM80uZD0ZKMjUTQsp8StzUZORCanYApxZt4abhKIVg?=
 =?iso-8859-1?Q?QTiHhgkOljrnjkhTdphxLQv8l1v7Tlq6VBMWsTmpu493pJ8Y3clgl3bteW?=
 =?iso-8859-1?Q?i0QfDn8ywVky6X8zXi2AcM3vB9+LsJ8lFazSJeIGDxjP7mzs1yz+Z4UlGe?=
 =?iso-8859-1?Q?PK4EFiiMoOSyWqjZKQjRTXyUEn4KBqVMKklwDjY4hLKj86OvzJb8z7e2bt?=
 =?iso-8859-1?Q?Sskq/3kF76YDQaP/zonH9KmCAWJPesr33DMIzOrqZzfAEUm2sehTGBWZ9y?=
 =?iso-8859-1?Q?z3bsWkTiBsdC31f0B3YL62LHfpLJ+pgorvAYGODc2Aavbumk/C/qjX1AzG?=
 =?iso-8859-1?Q?jCSCA2VmWZ42+HDsxPo8iFJLyFPbR7E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027595fb-d6a8-4139-3576-08da2d6b745e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:01.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/vgGhai/SPE8d4jQmv/v8zgwDoClvZFMpfToXINwSC6aJpyY/Jb2Ehf5vmvpP5S1x0KpumP5dDO3ZXvUuxMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: Mdc0G9VX5HWA_YGa656Ocwo8hReRxKFJ
X-Proofpoint-ORIG-GUID: Mdc0G9VX5HWA_YGa656Ocwo8hReRxKFJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4af22dd65fc6..9fcbd0b5c0be 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1291,13 +1291,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
