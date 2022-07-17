Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD8577345
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGQCrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiGQCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6D1A3A5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8gpo031743;
        Sun, 17 Jul 2022 02:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=ltw3NSOGRnf1E1xaZS/HpuwvWiOCAo5DsfigPV+jva5BZUP0GtXd9U2AE1xyOBhiuX/v
 RITqBV4YeVZrFY4lkTsOLvjawa5FT8Z+paNDRjydAXUxNlbWwAYotEItgNivQwO9opWG
 7yMbqsyfgKeMNgSwkhqRXuRP8yoPnqM56ePndgcuKJRBUw4YJE7WZcHOx5bRd5YehM3N
 IBqhvB05dZoD6+RvycMVJHttmvHXs7MUMxaEXq9K3iGt4gBGcOgrPAeQbVrTVQBEerm9
 YMvb2UOHonE5iOB7f1OTz0c32jozefn87S7DD6XH2nmkBp/YQBrEoVFe+k/rOtz6s/81 TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImd036151;
        Sun, 17 Jul 2022 02:46:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS/3zYWdFfPc208v9kObr796I0C5r1hzQnUiZKwSWyE7xZ6VYJ7SVm/d2qHFYpOoJSGOvM9mFWG3p8SZ9Jg6PT5/Juv0tULIOIP+vfHMQ4yKjqPrWFkLatrJJ7Yfa193hclxGRDtgExLsFQQDyRRGUJfFhhtQdvyorFEdPHiOec+QDDgJNYE1tDV2x3keOEFsDh6rc/Op3wvNqDJzhYf2V7d5SfaTk9ftNZDomWj5i+CTSuW+fEHAgExPAOZzTPeeaprdLkjq2QrBhiAz7ANJM9ynYebqPnPX/YoAnjh0bBft9l6h2m0oX2Bh91Dj4/+kJ3ajpDWIlzJ9LtWGg94dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=Qxgmr5SsEGnojtQRWPyr1ZVKIEdzavs5B/47ImFnMZfQkB+Abuoig1mGuySdFt0hSoSrUuyCeWjeppGosGNSxESMUaugxCv7WRiuhAy+rQlh6le3gdUqujxiboH69b87aB/MHDTiV3Qip5z3T7jrr03iWqu37WXPC9xvT7fWod8XPCFyrP9DSd3N17FUDFIR5uJrEgr0rzLeABfG5I/WlU8IIxkRnfaQOnrbBohqMIIBPkk0J9guzHaUmceIvU2mJbrqqPjIBM1927nrp4utPZOXaaZGyaNH/2xLkK28WREqiNqu1bgn767XGeE1mHuLxh+7Pt+Y6tRBeOlchf85oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=Bk+5ek8k2+Mm7AE86o9azLALLE3C5ZmHWQIaOMbt9cbObTce/9ImCxJjk9sq264TmRWxUlnq5QchVwR9QH6RKaqeLdmIeWf/WYPHFXzCpLsZ2hmzwmUv6UAfum2JICE4nRH8AOHITlU53ZXEbpkSoUglSieZFYc9MF2kTjd+Djk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 21/69] mm/khugepaged: optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Topic: [PATCH v11 21/69] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYmYdyg8T8MJyMFEKE92zDC33Z3w==
Date:   Sun, 17 Jul 2022 02:46:43 +0000
Message-ID: <20220717024615.2106835-22-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfa41552-5be5-47f2-128d-08da679e979e
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuPNsrhWyQelYJeMhaYBC5nhe5BAOxnBYrRY00KdsI3OJmxTLvU+ElvJYZKsvEIC6q9GF39vvsHFWeFxrvcPhMiydDnup/CJ314LonHFamVMMZnnDN38oam52Kb1EfhlHJGLRmePctnWYOOWcjtpY86ti2ukdOTxOBV6ObsBcfuhvR9cSYnyW3LcxGE3jkKaYhJCUIDWN41c8EyEEk3BvsHMreOMTKI68m9Rj7UKAk4N9GAKvnQg9Bid8FTgraQ2BjPvPYtBvQySfDGI0bObHcaV40j9He32sPIiLJ1s9l4m95kD0ZJcgJynNkU/dMZppoa8pc7nx8HZQmQI4gyxLRzTEyAYk01KDLL2Dshi07gJhM0Vv1vMPn00qE3gFWuOaMTpQa8VNdhprhomqpOF73X85P5iKfLlbkYtPuPNyi99l+GumR2aLZ2NW7NJJTEt1stXwJCY+VAMpAeVVssF4sBQ0RjS21bC4bYp2u9v1N9AxJCHfT5vJd0VAmhQ985A2HWupqCqCWYtFuBY2sQr2gxXuPRg2sZCUVJqWf6gscutbjbeJq5x6RYCY2vVv+It3iUDXrNsz98h3dHE+2M6i2lTKtetT4ZYV977AcqJwxqzpoJT9DfiZGUdMcIrvnT6g2RHb5aXMkyJlTmLyHJl7cd/qImxDmuIhCbDE+NYPbM+sEFcCQfjzmEb89ibH2VO1VgTvvm5eHWlfryGTp4QDRb7lVk0wrLkU2sfTh0JegAV5p8hKWNvRYIrtpbhDJaefzSBaVTGW5lyl2LUR2PJrunMdcmPRR7PciiqTHzF3a7CQPdwikMujsJd+O1iSCgBh4JxbUojeGoVu69eRw5JjdOA23MuyM3cTOtZpLF+mrkavTIjxlvr/WGwfxwuJneAgDoyfmtZyBbbVKx3qzxRxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F8evcD8u6vU1MOFRgz81z/7OH4GIRAPrfNY29gB7qVBzsrLeC+1Kb/UYkC?=
 =?iso-8859-1?Q?J1D8Gv2+69x3Z+k4BUMWXz/Zin+kLWkXuM6CR7DndP6c/muDd+NGRPdHSy?=
 =?iso-8859-1?Q?anGK9f/4cARkcVY1oenjKVFk+Vz2dQBA35VT/F2NCEDHpDJo/RbmIVEmeP?=
 =?iso-8859-1?Q?pKgoGp6bdHvaO62OTBG4u9DrKns0q8AOEporRCaukx0w7Des2VSc+7BrcQ?=
 =?iso-8859-1?Q?g2lkQNlaxPnVhTmbMS3w8TSrezB0m6jGKYOsoQxtwag6zlwV+d5uJroABf?=
 =?iso-8859-1?Q?jsGGctVWUwnPMu+wrWwClHn7LSBDWHC3ZNI2QL3M5pfxAKW6YlTD0N0qk9?=
 =?iso-8859-1?Q?RCCjg6MkcMgYMNU4g6oUcwHXEqX7o3ROmpwJttO+ZtPNuLs+VU4Ozp38h9?=
 =?iso-8859-1?Q?kLz50u/4CQrJK6mRa1pS8vfmA3d19t5/XDZiQdPIljTVqEzcyU1PXbXL1+?=
 =?iso-8859-1?Q?0mKcneYMIKqhYP7ffOAAZjb6UvOmMsm6/s6joQtUDh93k2s3ZJ13TDt9Ah?=
 =?iso-8859-1?Q?+NI3qR+YfkJwWaO1GGfuFOD6YWEdiTyvdh1S6kH6wRjaSUpIUOyqQXsqbc?=
 =?iso-8859-1?Q?ZnHWwlV+d0i0v0UeOTm9oSr6UeG0j9cp11sVg0tOAmV2I5Twg7Gn0kCpPe?=
 =?iso-8859-1?Q?fWiN0ViGzExqqvDOmJrhMmiyd5PraMF69ZKs57YYRuEb7FV+knu+ytcEhN?=
 =?iso-8859-1?Q?CCSU2MFmS8wxthA12bJWZNsIS3tjngkttUeyRXj4ItGlJ1Xe2QokfVg37r?=
 =?iso-8859-1?Q?6f2gk5Cj0l2oq4RB5ZMGa8CRDsd3iLrGm194iD6f7STgjidALn63Q8QdS8?=
 =?iso-8859-1?Q?eYFT6n8ynYBZ00yprdg2FTGbIS+PMUqwC4qJms5Tt6UsNwwV/8Ta/2heoV?=
 =?iso-8859-1?Q?QaGMv9D6e8a8DG4u9ybekSDIiatsHrAZnTlBep0S0b3wIPdKAKuCPVXHiO?=
 =?iso-8859-1?Q?fuwiFrA8XLjaIa6hDKuz63C42Pz4Y+67SL2SSFIjTM9x24+wEshuxU4y5a?=
 =?iso-8859-1?Q?NqX2XHWsQKPqecDlwzDmMtOtgSc8x9q9+Uc75HDw308rsEK7yl09iePMHo?=
 =?iso-8859-1?Q?rNxG0dWc9u0W6dSyNXovMVSNWCwTyKQEcQRa8REM0lq+y82QrZXYla8pMP?=
 =?iso-8859-1?Q?QzKJnVHz1Ei4/34sZxYAfP7rdHcyGAb1m+/AmS2y83aH2zju0bhxmsBxfU?=
 =?iso-8859-1?Q?ZmDl/jOdeunLNphId0+TPtcnf4vTG7Inieyo9JaWEGYK2qc6UOXRKUWly5?=
 =?iso-8859-1?Q?NX29HUXWlNMDqDgbnRIgDahYhQtZy229Ztz5RAdGDHW2KdWpqR5XYncM63?=
 =?iso-8859-1?Q?Mgl6XnWsPacK4TE9oPQvT32UBdpou8bwVo6bLprYsIEyrEbcxYXqKDyS54?=
 =?iso-8859-1?Q?EPBbGbrMoCHpYKDAJZ3/sT4XItkxNYa4GqYjfzYiTCxehX7UkfIT17g8Yg?=
 =?iso-8859-1?Q?X0fRDosxFveP4kCbKuv6i8cKJApYrsoG7y1dmTtm/qrdZPnC7KaX1ui+DV?=
 =?iso-8859-1?Q?KPSp/pYw6iKGo3Lngc4BxQ1+IhplLMUVGrzO9IEAvJe0skWQL1aRyAd+x+?=
 =?iso-8859-1?Q?HxkDffwiMotXfl4GF2o0i2K+z+mTQvCrPm3hlCkWfWPDMhsufLM3s3LI+r?=
 =?iso-8859-1?Q?65JS+u2ViRIq/lNroF0qGjF5vZN42I08YLm1v4NaiT4/FIihlKPl5Zuw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa41552-5be5-47f2-128d-08da679e979e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:43.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7cRIrMd9qlpUAvS/Gvbi0XJkSCQBg3YYN7Hka2XwJP8IaDe3JQjB4bu93KSOG3k8NcuIIcnJBjMDgZI3IrlvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=842
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: LgR1PfQ_qgD0doIsbEUqnYSFvRNO4FyW
X-Proofpoint-GUID: LgR1PfQ_qgD0doIsbEUqnYSFvRNO4FyW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Link: https://lkml.kernel.org/r/20220504011345.662299-6-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-22-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16be62d493cd..8dbd68c414d9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1426,7 +1426,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
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
