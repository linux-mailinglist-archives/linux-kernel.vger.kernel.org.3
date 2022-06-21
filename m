Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E5553C19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbiFUUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354705AbiFUUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCA2CDF3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5hUg018658;
        Tue, 21 Jun 2022 20:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sbnWPfNSWG2TxuWZY3W60AQ9sTOrbHLjcnXy9zbjNKI=;
 b=H1TBM0EGeoFt1HBbK2PyFRAwM8WvpVUo+AhJPYRwpKeGdt55w7Ca99ZU3JQRl1U4UMmf
 Azd/1NXTwmmXcXrc/wYyJWQYmCFlveN+44Ca5qVP8kaMoi6E0B6DV7/xKva2Cly/Wr89
 Md+xrr6z/oKM1SBwfyNzveQCUg45AOrQWi/tqw3nGPz5efM425p/zUO9qw6JTXL+3Tvs
 oPJAg8XynMUnTNVU8TS2lDQVUu9BOP7ZeqahQvh6t8g75KeILfQ2HWjbg3ZS4ktevjJb
 KCEfBmR5HbkvoP1Z1Nk9MmHFrUiSSKTgdYPJDJaoI/KQ9QKwxMbyVFnYdt1Qy0LFFrxZ GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYP001682;
        Tue, 21 Jun 2022 20:47:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKs2XPoD88RgOIRaZ2ZjLK7jz2COAEi239fvRv2qXOxwkhp+W3vj1YFoYagt3lnEF55KiGna9CF0ogZip2F/Luz7W6I+yqZpKZPUtL6Mc5WKK7zyuxustwaZTE5xPVQByQhAuo/5cHfIjlElSxS6vnlQm6v8d94ka3HF4sqnk1PSyl3M7RLPZSgj0F5HApEayEHWf619mCgTuwDMBHLL7eIujI3tDH+OQKJsa8rBw3+VXItcT5Wj4XZ+k1Am6+IsywB3hPE4L01GeNRuzpID0/e3ctFNAu7y0JQK9xhfEDZ24OpI0M5vAyHsL3qGbg1+KnwYShhHbmhoeT7eCs1Zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbnWPfNSWG2TxuWZY3W60AQ9sTOrbHLjcnXy9zbjNKI=;
 b=ZRXYe7L7nM/Q0kzbMAoMFPbBQUtln/MxCCSnQtApbRvcyENPRteVgujtuObG/qsRowTuPl+TfeU2WVZkqihU+0m9FAhg0aKo+gV16siwGdAjjXLzwRzsq2ixjmEQSoZD7/RMY+QcGkn1sMDmdw4mjykhqRv4n+/ebouERYv9igLyq2l0E4zeZ1D+kUJ+gqx4aZdj2ZhYUkypSbFygCrTQzaKASQGg/tM1CEBSfHYWu2kqgp+3eFXbskwIvzreRLewIlk+d5H/A+kPUU4VAM8m73z0vali57w0a9hsfO70njeDybzru0FxqeBjLs60BFwIEblRbZOJReCkj59tvnooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbnWPfNSWG2TxuWZY3W60AQ9sTOrbHLjcnXy9zbjNKI=;
 b=gA5LigHtEXyFcNIth4DyDAVUYE/8frn1gECYvknqfwle6JDFfNiSTEiFGILRlvsx8VqoQO06QFDrMbOIiPPf4H2uo8d/hzpfwDnCnWb9e15CGQ2emYCYil2+/YFi2dMG5/QrUZdsnEjHLOEnUnJSaHUnmIzksHe43qpeRp8LldY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 53/69] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Topic: [PATCH v10 53/69] mm/ksm: use vma iterators instead of vma
 linked list
Thread-Index: AQHYhbATANxQriLgNkyU/QdGfXnb7w==
Date:   Tue, 21 Jun 2022 20:47:10 +0000
Message-ID: <20220621204632.3370049-54-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7176e293-a9e5-4d14-365b-08da53c75065
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392DDD644EF95D9E2110314FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfx/Yb58Fq/R9dfhQcPud+OIaagGHEqUfTyhkI8OYrbceBhD9k14eOP0FGCIDSNoS/eFleDgRQHljQLuvI+72Rq2wU07fr42QD3G5KOBQOgRcVh96fDjIs8covsbadYOMo698rcOY+gIMPdRmCiZ6pQJsP/uxJkb9lnvsmJW0fWJgc74QpW3T3OixMjq4bVCpNIlIPAsSDmGpAIEZxXybHea2hrm0V+qwZGYkLoqtl+UEgbGk4EyVxhsU5BKX0J56Y8RW+rvC3N6gfoz5jWcXE/wVVEeUXCg03yd1LiQ/MUHgCS8vKgsssOvuHVQ/HUZEmTlUjbqPjgspZWl7L50QY4maJnvdZ+OuJLCfKtg1+LtDH09TAWolCfUKdA5p/wIiLMoYgtTJuyW2VWwe4gXs5MXG5Ehc/UKnErktsXzTLI6+wJJIeKHtmf2q9//frupBaSGk9prpkD82V00MHX4LGyoqE5m5IWgDBmU8H+vsLZz4jLbol5KHJhKEGBn7c/qJGQUNsqaKkQdV/St7o6Ff0pVzH/X/NnnX4CWkCVbVaG7SoHNbO/JFUy3iW1C+yYqbKcn0b/D1RPy/ZKF16Mdcb4wcF9bg2aCVHyxCgg6Sk/3o29hcdesOxegAlvFYXokaMEy2RRcbFT46YXTMwC1olahZ1dWiHAHhwD39IVrMO2/fq1jEX6SPDcFQcbrCH8NxzUSSSSoc7XgJnkkzkPXwQ9DCVBw4DoMOI2gTOISZW9zZqnqwQTifbC0NYeHNlChfoh6ZTSziB4anTZTuCww3PsnCDNhcSDBc+NpMUZr3rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q30eDUrVclFIpNmMqiiNTBOQyUdbO6Y/Ibpeps8XyQb18atHcfSS5iUA5L?=
 =?iso-8859-1?Q?1wyUg8CpSwbcnJkzPcs8OcQ5u4WHn6L/Gy2hDanolhNQDjgQOGcdVRYwYL?=
 =?iso-8859-1?Q?+HwQ2lTKo8i/Eohcqgufzv36BAIodWVTlv0oOrgL+w50cehbJYfsMFIX1u?=
 =?iso-8859-1?Q?vZTmvzZq9X6aYtdevymXgRJ8EV52Wj1mdTIiRvDYed4dX9o5eSvInG2q7v?=
 =?iso-8859-1?Q?kpK+/Az0bMn0crW8E46PgjlgeUlIDXfEt6A5MTS1OdxxfqoKcnDe16Izyk?=
 =?iso-8859-1?Q?SQXvyFqVjU7TFobwzfpvLmYQfWTymLTtXfMFk5Uuax4Nbfu/a6enNAyRIu?=
 =?iso-8859-1?Q?D+uitVpkrlbGRgzdDujdK6fOE26Ab3bpwvZJ1NnbP/rfNrsonSpDehwcHC?=
 =?iso-8859-1?Q?uf0IbQQmVhbpNsAdSceszhCTk5Ah+Slu2F/MsxJy/ZPZmJkTqd2qNlmiJv?=
 =?iso-8859-1?Q?7V/Kl21Dtgoo5bGpneq1hH6CqHtdIjwLLlNMlnE8bl+qhKDmegShZXd9zt?=
 =?iso-8859-1?Q?Wvaw+s4ns0cafCUREEWon7xp6ujpD0Khy818mmhSy4GT9akckb19VbP7I/?=
 =?iso-8859-1?Q?HcxvhRV47gzAERs8XOgRgdGz+u43bGBIjwqthdgQVQo7kAIZ5rh1DWVZ+l?=
 =?iso-8859-1?Q?cqV/umY39dcQnetZwS0ASAIvtzSgbJxeTz2N3GcVEwVJdPmx97rjUwNB2+?=
 =?iso-8859-1?Q?bSYSu43Xi+yg+rixR/v92kqKTAfwaADXfVdb3ua5jGI0WA0SUTfaswVuCl?=
 =?iso-8859-1?Q?vNXgh8luTXLtOEPXPt6MmY3yXUAyNPyNNY8vFNndQRNB2MirHB7uB9T6I1?=
 =?iso-8859-1?Q?qZH9FNEzuP3sscFGpxAcr0SChMG67WLqUn2j64G3F1ej5qJZYu39qaARFV?=
 =?iso-8859-1?Q?sLzihborlVx8hSDo0Nk9nOuMFDg5PzxBsUdN1ESHzevyNGeQvQ5cfmHbPi?=
 =?iso-8859-1?Q?YVqWD2cG5j6v8UJLbiFYMI40cSAdKnF8/r6xeHXjBBQUbaVOhdyeuLUgWr?=
 =?iso-8859-1?Q?2q6ofhyHtKmaanMb5DXXwt6J+NLT9e2VPdYCZuJODNU54PdS4efTTac8Iu?=
 =?iso-8859-1?Q?7HofLYuSd113xTu5XvZ0nCj9W0dH281mFzmLCT4uL4Nptt5ARh8BcLVg2c?=
 =?iso-8859-1?Q?OwLj29k71o6HpUScuVW1HfP7wYi6sxyX325OelUXN2PfxrQ7UIlwqtuafU?=
 =?iso-8859-1?Q?IAtAlIC6h3l5H+MfiG+VJb/1pE8p6nsO9DXgbOd8ckpSl1YarOcdEp30rz?=
 =?iso-8859-1?Q?Ki1WPMvAzFP9OiaPqDOzmowM/mpZ76hoxPDJgLp3hG4a5uIJBH4JhtGLro?=
 =?iso-8859-1?Q?iZSAW4rtpNF4FxUdDnzlRNIl83x5K/oWlWc+cTHVEbNQQgazHj9qMUViw0?=
 =?iso-8859-1?Q?qADWjsEC+PYrr6SnZCT9iCuLi1Vq59fuWJEak/9iS5nCYMS8hQZ87lt1Yg?=
 =?iso-8859-1?Q?LWIqkE6ONt0I0NqW+pDC6qMKSQKy0WL0swFGw+ncX3Vf+Xi99ZuM4FCGOe?=
 =?iso-8859-1?Q?vSD+abhlw2tZOVUY6pkSDbFE4gVJKWb5mgjtxoKlE0xpPNqdpTbyhpcc1O?=
 =?iso-8859-1?Q?wMu/sMPyDzykVxaqXGq9GNnE6bCRGMhDt5wZ+OL/r84UJiVp3uWSPm/X+u?=
 =?iso-8859-1?Q?ou/EM2v8vfBb4QwHJ7w4mOzOvSM0pK+4OK15jI3joWR2aFHaOafPPqOBMH?=
 =?iso-8859-1?Q?Nj1qT0eeR9N2ntImd1JNUG8WvwbHDJ57bS5Nqkpv8Cb08UVm460MjRpnoM?=
 =?iso-8859-1?Q?fazmNf2r0nWmPrDZ09XTjNv1mI7pUmzHidrB/SPZTOKAO7qL7I5faoPuur?=
 =?iso-8859-1?Q?6gntVIGWTY8yHg3+CKa3m/Q7z6T/FOA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176e293-a9e5-4d14-365b-08da53c75065
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:10.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rg9rrUrl0qTJnF2OasblBMlhEgKH0zOmPiGuM8H58TOiEwc3JrVdzN6jZ+IY4BZV7pIe837PHFDIDJ2CGNA9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: Ctp3G-7dUkuq0mw5lKCqmeL1hUUAfjqc
X-Proofpoint-GUID: Ctp3G-7dUkuq0mw5lKCqmeL1hUUAfjqc
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

Remove the use of the linked list for eventual removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-38-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 54f78c9eecae..4e3d794f6b09 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -981,11 +981,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2232,6 +2234,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2290,13 +2293,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2334,6 +2337,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
