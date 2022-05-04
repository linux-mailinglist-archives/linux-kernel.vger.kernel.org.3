Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87851933C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiEDBRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiEDBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC1A2E9E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:13:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243NIL3I004092;
        Wed, 4 May 2022 01:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AsrOvEw+rNqDojiVyg1nxdaglDBANXREzfq5N79ptoc=;
 b=GoUi6YhAMWffD7jPmqcwujavKImUDOcW1reKRfsAkt2iIcNzBvgOsHzVCx4CgEFtGdwT
 wdSd1GegETP/ha1RA161fM/EHFwweC9iF1AKtxDPPlQsTmxz+U/0oSR9nuLWTK3K1t9/
 7X6rdteRmozo/Aixn7CTAUA+1TouP62XrAN4u5Jyyb9lGuOyxYFcoQlgZdtW18leO3vs
 9oFKIFr1HlLW8xcoelkh4TpPRHXPlljXUgiCGk3ZHMioQZkhVxn/5Aj49GZga0sF1wZJ
 BVOKsqQDseZuqgO5ozs08RTBX10jUvsyl7Yh8mXWWMNRBZAr5X5JbLUlxKNUPMBh8vyI Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJU013094;
        Wed, 4 May 2022 01:13:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqK3UOGbWboTQCe4yC+iGWH6Y1BE3xSMfUSbU/DpvJEEJIeczfOT55DupdKRhZr6mr58ULurgsgYsa8qxdOKnTgMInjQJIGa6TyhS6h35ACH6N7hA6LTBJ80ExqyvKMoLWNPLDu52WBxlCCLS7FstTuQufaotFzL4CGneYtdc2AGP6tisf0AtiyEQ2O78dob5GciNSweIVqUY6uxKxtsIC512ITpkFj4KLOYtwK5BB2Innjju+QagHdzBNOAjrSRGzzwpAbQkIDH3WQC0l2xTob+7sSg1+qgC41ybDO/wumjA5DKS8zLv6PVDbJCVizwfHM8+fQrV1g1qkAWGXrMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsrOvEw+rNqDojiVyg1nxdaglDBANXREzfq5N79ptoc=;
 b=oRfV1tHbmteeTg7SssV/MRewedUMhTXwZQlfFuDxBMMQ/3VGG04b9WGHyluq1pqanmbYF9ATqCzlyhVftLD7nUAYxVItvqIxo447BDWjIm0VnPIH3NNPGIGPVJYo1X7PrYNhJ2qmpTXvPYnDj3kUVq6HQfI7dQKYWRpSEmzdpXCm5s0+aJZjACoWzM4fk6UOtNWVQX6VffzMyCeXoCEtZbJRLaz89+hFf22uDyPiqzOqOZZzosstrGEo80R6fGq+hPz1d3QZj+8ioy9K7GeV5aoYKmDgdRUtd6OfzbpkYYjJwNwuHBXlbUrBTq3v4eIK551qTTGqjL11Jh+DubuRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsrOvEw+rNqDojiVyg1nxdaglDBANXREzfq5N79ptoc=;
 b=gXAOLiXHan6E0CuOIVTZbPaQMud8RtCMC8IiRqYUm9ZI/atYC9oudSEThi2xQy1SV0mGmmxS4kyjfBLFQ2blP8VPFyumKseGjJphJULxUvkVXx1D7rkFQlUavEMHMcH/6T4X5pvtxqgImlwX6D8NYHfTObrcRNrfjIw3avCPgOs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 21/69] mm/khugepaged: optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v9 21/69] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYX1Q37scr3TuLAUawfkN47cITRQ==
Date:   Wed, 4 May 2022 01:13:51 +0000
Message-ID: <20220504011345.662299-6-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7950e136-9575-4cb7-2167-08da2d6b5998
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5830AEF7ED6E2142D016DE12FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RB3YNzNXr3azIQc87zY2WeQASiQOvMTmJI6Q+Sy+LMXHScUfI0NZK+AdwToWIujJ0Y6D4oDsVILWKggtjG5hESQWLiowY77xvrMNcCrlVNttzhimJGeBooWMrxPLtNlvIq3Fsdzo1KwSJHC3VhRtz5dIlXaFIW71GSHr5aWiShVky6b8NhWEB3lZaPifn2ucGpQ59tJHnIP5IVYsT7887qVnxnaVRCgRYKVew98wgThv0tR9/3w9Ez+ZfknOjDISUQoAoCdrkrbUfUftCwfsWKn/PrTGsqiDNvchGjWaEvMEbmp/nRctB201W8Agn+cgLAL85IEX4zUeiFTD43OiMkZsKv7Tul3TbcFl69+AbJf/3B9jtxEf+tfRT6Ej62kuPismRCKHxKyfuAVPtzUMezOn8B8BgLoQBt7FHFv9IDn7+6XEoF5BS3oY+hwl0A2OO8amh6VRCGshjC2CmKXgFn/WZ/oVMqbMz8ug4YXn3fQ5/0HB8yYpRg4oO8lZRfOadYJ0oUV1M0A7uJsoDipEE35y7wIREQPaherjrjuPGs+m8iwINO5LNzDm6Uzy9FAOfeIhG42V+1zDrJx28TNt4fAlSXXFq8YR6X6jLbb9SkKuade47lopqQ75Aik36n5WXSOdx1+5kvB+gv8R0liqUj6Gjv/EGPhBb0YYfesr5G16n92XPmvUI8BtCKoFP6ihq7SzkO2QBNB4CZaN2xSFDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cWphXOyi0TNuyCGfCljXJaqFnNn10rxWetZUgUcE5i4hJlzzjbF3wN6e0S?=
 =?iso-8859-1?Q?j6Mh1TmnP1oQllDE1ndoJFcjzF4bdGG9h6LdzejmX1ZQJIykWsFHKtooHz?=
 =?iso-8859-1?Q?mB4LmZ/Ptm+cAs18DgiCIt53GBJK9kmSoh2cn48Ek6Ej44oA+fudqj9SB5?=
 =?iso-8859-1?Q?fhqaHa9z97Yee0aTbh6O3i9l4PbxO/YH1Jpyvc6EdfkxwUMZcCaH5Jlbh5?=
 =?iso-8859-1?Q?aT57bAzfBifx2XwWHbKVGOKIRs808N5WRDFZ4220l74xE1RSf3GWrEZnRO?=
 =?iso-8859-1?Q?yTcp8ZRoM1jVMNcV7Q52SHFKbr06cNFzZ9IIotAOxcq1XiaTWaIwXTx1JS?=
 =?iso-8859-1?Q?1E/j2j1SDhSdKMz1TpD+oHM8yxwCfeG6QSBPFer/34dkYv9WmupGg0PcFN?=
 =?iso-8859-1?Q?+/zOpMFCC4giS2++LpApJgBKGuR2oeACaae7JD7HmTfVsKNXJ2uS+Lub3e?=
 =?iso-8859-1?Q?xSfpaBXb98EDp7HP7yPM8OHfqb3nuB8V3xzbweu+AECVc9V6hUTtBoKA7n?=
 =?iso-8859-1?Q?SgOsB30Er6FKqBLZH2KOB8KZDsPM8GDUKuMxbm0OP2+cPEtLvmruQfzdzy?=
 =?iso-8859-1?Q?vMzks9i7NSZRz2rO99XBLNkVRSKS22B9VXvDvHxAW3byrjFgMKou3P2PkZ?=
 =?iso-8859-1?Q?9P84rSbdXmGAOLcHcjfuLkUPNIu+aueoGu3IBvd65rybGuSCNyqng8HNLI?=
 =?iso-8859-1?Q?bRmEE7ne8pdA2SIAFp9RNurVaIEjCMvGBhiBpBZIubwbupgYTTfDTEB7T2?=
 =?iso-8859-1?Q?3WE7paPaute1CNFdo9kbd+W6H/M0OyBUF5/zHlDPjfxQAyZA0SAU0+/l8G?=
 =?iso-8859-1?Q?zq5TINYlwVmez+OWNTW01exgCeH9mYjpa1Omcdyyd0HQl2ZaUOlPX6Qkwo?=
 =?iso-8859-1?Q?rzG/8qrrO+HAx+aS3Mtiw87pIeCkkS8ZYBREZJp4I8MhAJluZudXmkZIMd?=
 =?iso-8859-1?Q?r6HeWte61rCuTl654Xwi7m+MN66x3jIhweOQybFjGzqa3Rxev+49KPHtKO?=
 =?iso-8859-1?Q?D+Efx6XnyqSwriKs4sZhdNzOc8MXVZHyurPLz9+s04voC8GbjcKdqQcG5J?=
 =?iso-8859-1?Q?RIEBiIU71Ysfb+PPb1+3H50gFcKkc5zJInfNnURKgfedpUCzxWKrZ2Ja6V?=
 =?iso-8859-1?Q?6Cp9nGnpBegUkyvX0jJQyepaLs7dOYsY5MvjBQl2L3D13Reg7+ASvL4235?=
 =?iso-8859-1?Q?/aU2KglpxVlUW3VsaIm4rKdyVoRntS4lj6QOiFMg7x44MGj4n57HGdC2kX?=
 =?iso-8859-1?Q?VWVkazKf83dFGzYqQx4h7W8Ez0IiCp/ykKc7976Dx6Mm3MTq2SSJkSoHZS?=
 =?iso-8859-1?Q?7xUWr7w+4WFGGXg5a8jeZegVb4r+YVkRRoaJqsH1W14CRk/RJcfZcdqeZr?=
 =?iso-8859-1?Q?iaEUM4A7qClPFJWH6HngU1KzopXBmSXo+uR9Aj+oOLqfCWRq7g4eWghMTO?=
 =?iso-8859-1?Q?KdLUjLun5NjD3+NTqab281zKfOfJigM8d7sYvzyR/sqYtgCetzE+tC0VCh?=
 =?iso-8859-1?Q?OcPuo4Mpq4QmrgW39kwD+9ksyKvBpH6YvyYCNUMg85aocU18pFTIArrDWq?=
 =?iso-8859-1?Q?S+LH0EmiGtd6XfjC4AYA7CMURJpIqbZ0QiS2VqPh3PKR7N7rZJNgIMgnmp?=
 =?iso-8859-1?Q?pD+jJjTdFFVAm/QRw36S37eK5wDIvn6EuQtZSobDoPcoO1hQn8z2Io8M0y?=
 =?iso-8859-1?Q?QhByICjyzDxs5XZYPIMrzwuJW41nUClnC8qw3Ft1zAm9DPV1yGJfYig1nt?=
 =?iso-8859-1?Q?1GbgVuOko9fvrrTwJx0uvD3AgTBYXPoUqzf1rl7p5bFgoBw4IE4vNYUxld?=
 =?iso-8859-1?Q?ZwP6t6jxFfUKYh+mRXRuOOahjak/US8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7950e136-9575-4cb7-2167-08da2d6b5998
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:51.2364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27fate5T9g4hfaWwV6XGBY2fr+DelmBkV/QpeQ6v6tZSbT2FTdcHNIMTuxoZXv+aHidzs42Vd9Wfjw5CEUmInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=865
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: t4Tg2u5qXGycMDLgLu_nChMYO5L42VF6
X-Proofpoint-ORIG-GUID: t4Tg2u5qXGycMDLgLu_nChMYO5L42VF6
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

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ac53ad2c9bb1..03fda93ade3e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1435,7 +1435,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
