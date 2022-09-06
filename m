Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0C5AF50D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiIFTzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiIFTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCD6AA02
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id92Y024655;
        Tue, 6 Sep 2022 19:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=O+ySm32AQzrsQD22De5QscpOSjmz2oR8nuxI3wO7Cyi6pxSXg2XWy7t6t4bDtWd/w9MQ
 N75uLCMFriJ1omm2Soa7prr4IDz1+k0/sGvO87bjfitCrpPPRdHY9DrzOs0jeJOZyUSU
 YnTlgf/Q22ScWm0hMf+7G2HZrfaX2lLHQ5/3HX8pHGIp7xVD+VQa6T2Ol3hHDgR7IiDb
 UsCwp5mauAIgkh5n1QAFZex/LaRRnaSZGEAMdY+Dpw8S7tuRI8BEIg22aYwkkNwqBnDE
 12991RruP3iVtsdyIV0Q/xKBF8PYKGkFZWXTpyO+l15ya7n4FxZ7ePqerbR4sUelVA8H oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H893b031227;
        Tue, 6 Sep 2022 19:50:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajqe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3IgeXxMvlIPdG42lvwBz8u4frvk8LxzHQSb612qLfUCk2ly8vkKmIMy3MLHidWFzP8mmYMi6Xi+j4jE7xvQAGVSo7oqaUl2AMC2zwHPYJN8tFZVHSVicNnvVNcb7POlTLtWVBEWsycR3B6M/ecN6ZUdlNKPgyRhKcWjOWME5vpA9SZgqQla29LueZRe6mKLwNAwh654shfk7HCYg30ssM/Jst2YE9apkQahDAD1h+Z6/9cVARBVYf1239ijjr4TKQ96evGFhPYxkAZGxW/ms7DuCpP21qOsRfCw2NXuaLELvQchh9QjAeAAVNPwqHNhb1b1tz+sDfDE3T5rnR+Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=fiTvOMhaibLW52VTqRK9/uLyDcWsF+QdbeUBqrn9dETzp35RdowAqQUpJo2pH/C9X8k+57y7Hk65tYkbFjXIuvkT93LBKXJy2+lIUn/p2CNps/Y6nSOtl27aGMaZiSCiy9uL/92GDy6l5t3wRUD6QKwk554sP4bSFXOCob4BYhtxdxFnQQqq3XW7Qx754cqebegWraVW2LLfTjZAuzZoeJ1ujXCCEhEpVJt0hU0Qke7aOkwZscu23Wu+wqGEdnkHbR+n+lZbaDCMxT/HT9ymqbWa0OD2B517KO9sDwgRYCc4TrVLnIfJoL7wO6Q0m3b+Hq4+9xvJcEOwOvD1YEOfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=EN7iDsrUZJppqBuMBGKYUKotV85+Gnt24TbUWTWdWF6hIw9ZHFYORWWWZUd9PN9GLQLfr6JvcINBtX18E4mAACTpN5jqsoNhF4/Z/MsKXZwTqg6Ulk1+d5cm9LHULf8X2Zvd1ve7xgr1H9d4bHfrK6cKsKIUeVGMgYVg7f5+Rgg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 69/70] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v14 69/70] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYwim5ISWiEjD7+EatyUi1eyo8Gg==
Date:   Tue, 6 Sep 2022 19:49:06 +0000
Message-ID: <20220906194824.2110408-70-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9667a243-ddb3-4405-ba35-08da90410b20
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BF6Pw06uyVqqR/U0MEWSaWhkMYQ0ol28DuYBuiWEFrdOTbkCU3Z0THV/0S/TpIaWQruLtVaDhfC9J+17LzP7oJodpbu/Ppoc7upSXte5D9pDCYKNOjvpWsG7+AEuRmu0JSOE1xp5YhKpIhqoGrawl0oT82HPQdfg8h6hXgQYWmrAjhf3rdSt0Zo7J7vZdqIDh1C0/MPy7c/SC62TWclBL8FTNYIhY5k81vaw12qDguEdXc5xULcOF+ajogs8uW7xum8Ams4A1sKkcx7442Jt9yYpl4SMvNE3L3wR66bfH5ELebEjab+jKQCp73QY3sCZRc2Fkc6twyNph4ob3ZVpxjwvULKx6xnnWKA/o6Xmn1AayNBQGeZwgBb+f+Ly4ovrHOc12cd85JPa9SIJKl6Hy6fJgvgIbzvNLGZMoIMCS2hjqcjjUlpT8g5CjL+xEvVkgadO7782KDtW6syq/1Tp7c3Bzbv/Gj5pytRZc5yjpbA4hkOtZ6A6/XHvMrab2RBGVw5Lr90oFT4fMIgb+NQXjiiOClaiK7c3Ywhls0jpIIMIBDd3KMxuBfCW8jOSuOYPrteefEiQydLU8Y3XaxnSlW+BoDVSpFv9EyWPJSNSkyhI0Xnz33yva6ba/YctH8BQ7t5V0lk32HDhYdtgai6ldxZxiskhm5suYVMhGrhGEOsnKuox448qh2npZDxOogwTr4GugeEz2Q0ohrQugierFIDjp6X/06CczPWHU1BTwITrfWy1oLQ7M5Q8YtGxD7YjA6YqtfHOiUesIScFzcGqBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IMFNRLvnvNKSDj8OdqPt1DpVF+10sRSV6duWg7YiQGKnVsabwPzAGa9Z+w?=
 =?iso-8859-1?Q?lLpkHChDahpU9b+2dmneCJYuQZYg1HJ9j/Dv3NvB1Q+4pu4kLofF29b1zo?=
 =?iso-8859-1?Q?eIf4ZdF4UiSRbYIiTmK6281kPVa7OqhP+acnmELE9Tr+9RwQmPAoKu/8MX?=
 =?iso-8859-1?Q?DPK3e9QKLV+lMXj/6zCBa1Fv4vGIGvntQRGtz1931AU/gHmrq3mcb4js+8?=
 =?iso-8859-1?Q?lM5zToDksocXRgDSZr+afvNEs2atbXDdCjYk7hXymEx+0GMy80n5pj9PvE?=
 =?iso-8859-1?Q?fUcgHULjauQMmrADH3CT0L2Q5HPmVoCpiJFtlExolyUSeMRSIR1HRkHl/p?=
 =?iso-8859-1?Q?9xZGO0zggWD79k4YOKQoISlIcLNZUahNekjw1+waNv4t5zNLb9FGr/lA1D?=
 =?iso-8859-1?Q?hXv+imdxd6KXUvHHR25ZMqL7o9IQKKZMhRvzWV0sg8ofUjrFitoJXtI307?=
 =?iso-8859-1?Q?Kz0d1BkHABcBhC243ACSG+6pZ48mvJhaRwyTx+xEdnr9zXeihNNZvhqJml?=
 =?iso-8859-1?Q?vyTTdIlWJyNVvlWBcOtQboUx3Vjd88rQ6fjjFCYvlQgBrCGHxZh6LLZNNR?=
 =?iso-8859-1?Q?9H8iCT26OUj1JwwvWhPN1ddo/wr0dznGtzSn3hYsLLSRO180y29tegA+6K?=
 =?iso-8859-1?Q?SAERIJ8br573Ktt7TXAV+SAjJvi4m1KSzVOcEnDzpeTYmtoShDLVLniyBh?=
 =?iso-8859-1?Q?MbvwTApuDnXeD3Gc6oAYwa86Hzffu9D6DieLzpV1PrRzLUnqwWECLCbcJF?=
 =?iso-8859-1?Q?toPBkfpz4cVYstSEs7Zq1o+6WdwcfhuE9QIPSis40mlX460x0ltv+MTrjd?=
 =?iso-8859-1?Q?0L9KttjBw+ghpuc5Oz3YGIzo4/TPkB4vkIw/hIYfaZwg9QzN26bBEmNu2l?=
 =?iso-8859-1?Q?APhCG780dTp++8qxT1AsGwDRnreM0aP6RjOy2zm0LJvyo+zTCLBEx0spqy?=
 =?iso-8859-1?Q?AN76NzrjOfn9VWchQTQvJfHK0+INaDacy+wNZv/PR2ramL9qjXKoe7bzEE?=
 =?iso-8859-1?Q?TyfJRzKRwBo5nSd6fEpIm8206kJPTZYd5pS0bTbGKPFR41VNZuZKDeJGkP?=
 =?iso-8859-1?Q?hPt0e3n6HF+jzPIfNPciMuzbTOhmtTQQM19JAJAK79pNviKSWwaX6JEPTN?=
 =?iso-8859-1?Q?mcnGyBj8i9CBe+U99mx63MUlRDtT+i4Pm6HbKc/7WybwuUujrZF8sImw0J?=
 =?iso-8859-1?Q?1ZzusNf+9Wy5p5aMh0BXLKwBJBbKVmjqYw5rCt4fJWMWW9UOM+FxtLsMBN?=
 =?iso-8859-1?Q?t9tWNREoJzrUZzq/gaWwq1duTlZsOiiMM8LdDLG93ClqipuwtjooHHEMqG?=
 =?iso-8859-1?Q?DHG52/V8Yh1kCAza1GxMeH6a4oTT9zI3t64I2n+CazQX5Gi7QUiJFDXdWk?=
 =?iso-8859-1?Q?xiOfrfzf/eXUuOd6d8lDIZkv/1ku82aDSmS0sL1SsjmQJ3BosZqA0pbemY?=
 =?iso-8859-1?Q?QztAEKJw+CIFqqcIK9LTQ/59KYw7boP30xuwtTFCLClslo+jboV0XxxfA5?=
 =?iso-8859-1?Q?O0JDritb1HJw6m7oaQUkHFebf1NabcSm9WtbOrmguTDuo6YiKYkH5YVfzD?=
 =?iso-8859-1?Q?psR2JhczKgxZVw78PPMPu6Ufs2SvhB5V1fQbLRibWHlghrtECJOAcHaU7v?=
 =?iso-8859-1?Q?SCUAVZKMMdhTRvM+K9y/T2sKPljtY3kbDYOsySjUwNiOgxULWOvMYV+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9667a243-ddb3-4405-ba35-08da90410b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:06.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/iDr1FhcjvyT53nrEjxiKwT5wA+v92zRc0y/0rgpzLmeKEbt+Y6BQP9PWuJk3vuvMA1EnJtuByecAqtKTZ1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: dT8r3Srsb6IOcET03Z7-CHPlK83hbL8n
X-Proofpoint-GUID: dT8r3Srsb6IOcET03Z7-CHPlK83hbL8n
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

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4441f7ed197a..5070af64b99d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -390,30 +390,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3178,11 +3154,10 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
 	unsigned long charged =3D vma_pages(vma);
=20
=20
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
