Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7F4F1778
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbiDDOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378263AbiDDOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651440E4D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Do9Yt012570;
        Mon, 4 Apr 2022 14:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FVCJWSsPE4Lecd5EUaEqty1EwursJB0dc8RXYVrp0kY=;
 b=ZvQnXrej99CVM3AANd36YP8RXUqCwJZnT+H/rJtoyIoJ4OOUz60JiQ1tfsru3Is9lcmL
 J5vSr6pcYV28ljE4GB8r4hX9u33EtOI0hkSQ08HGqDvnpZqPPHgc4LZ+uyl3HP5nX5rQ
 lxzHAl6R8ArRno4WRzG6OcajMr+b84TNwgBq3HXf7weUDvgRJZVVQ48t9oPr6B/Dyjpc
 V8ODnLnI3MI9dxR4tGu6fihN/kiI3hKwsD7P+eatKSJqol29bJn/tU+AhlwxjzOEjR/E
 HYvl4d4jlBaBmLDrA6zYM7EM4y3L1ymVPRKUs0Csx+ETqyNkPvVhjtPhAikrDcQfOR3W 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Eajoc011889;
        Mon, 4 Apr 2022 14:37:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThSE9fM1fEAwGPvUFnWEm+XABZF/S7Hovin8P+f6s017icZMVKxqEelNudUleltuuaNCR3Z3cCupjojPuGtM216mtMFSdMiElxlSQCABCuXJf681n5tMAhjZIcwMlL7a3fUslve3h3zHEJKwAx/aPGG+4SiYgFXl3XghYz1n5pi2eh/s+NwlHlC2ZYFZMZVgaCF4ufRLfCqieRJH2DOTP50AhP+sT2RaHKEW6/hqOdHgq5eD3xY4ikXuW3BJNOvS1k6St4o6PZ8gDSMOFHXNi6/z9/P8mxBVfDXvYKdEZCzGUcfLlLf+lqr+MF2zvO1+u1gQkAwvh6jeYWqkc/346w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVCJWSsPE4Lecd5EUaEqty1EwursJB0dc8RXYVrp0kY=;
 b=ntnbYU12OafcyDLtHgde2q5dLbHnlDOuDXMhoNKvK8Sxz3b3uud0VnR43aVw1nfa2GsTLGr+0c+37OsqRbsa4LsAP20IpflhifnskT+zeHzm854qFn8fC20uyUYTbZq3sjQIugUe6+C7QavrTg0GMEIqd9stKgDeUgtUvsiXN14QnxsrFSH79M8rVn616nS/aepSVGZpKd6O0Kg54k8KStqMgr0SrRD/YUkw0nRx7rmSoXIVUjrjpUPu9u0qFOa7cFFAcwD77C8p5H4i1SZuhXKTzKgfodofFyZt0RcBHA5ZXKeLXujesZO6V0edydPNSvC8/zABzC4cvuzUu5tOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVCJWSsPE4Lecd5EUaEqty1EwursJB0dc8RXYVrp0kY=;
 b=nqetBfp11NQWpD91CoObAY/w4bd+uP5qmh69kxWi+9l8PCQvw4MJy4MWosO4h0eqaU/RkiBRRN1Kko5D0QVBXNUNKlZ9JUJDJYAP5TXJCgk72SjLBY4KAtsyjnXRVQzGUIZ7cHnbXDpCckvODPv5mfpEOOZdntSUpGoPVJiRB3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 69/70] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v7 69/70] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHYSDFNNe0ZHJYu2Uma/rpDvPYYIg==
Date:   Mon, 4 Apr 2022 14:35:59 +0000
Message-ID: <20220404143501.2016403-70-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83a4cfa0-f3c4-4ad1-4aa5-08da16489910
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742BE46853E7C2CD85D65CCFDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1KB4dz67V6SwTFsr9Z/vsTa4dvz69kJpHMWInpeOn1OEt0lK5VtHYMTMjA2SaTEZpTQLjzVVsowcbOf7+9d9hNsdlD87qCD3mV0GXMvuEwZ8qFb1fo2N0na6KdxJ5lvPpgF8vtZYMtaXoX0P6pWwLwjZRUNnlMVpSBnSuh5esQrOiUMTMW3wh6ih/+pwwAISYBR1wduY5GeDTi3+qJRQ/euTn/wyvK6pJY7MqJNsqX8JPb7YHvLP0Tj/6on+ZcI4Vls3/DlbLYoNwVg8A2f7l+xxVdo+UQlmjrjMVor6LFpweX3tsFHMHxXLMcK9PJtlLXr9trSWBNAyND2vicfIq38iAwkUwQp8VxiGfNheC+87AUjq6YpQEqItE2lZgVQhUi0ElF7xmRouDgiRm0F860IxkNcaFbvn7adE02wpPrsXBThMH8/W1TyTdp0bY6BZoR/XMCoVUSNwy+3THjMhXjn0dcuyzrmL9pOO57w5j68ED3iFiJKTxvNgNYDZRrQ5Yz9KUZUiCze/B3IBfECRiZOqTq1Jv//UX0ykpDbkRgcPpXAwk5mSGNs3/O8hkgYPo4rv8sdJmY817DlUwAt+3Fam1/bn/PuRxaOccT0V1iR9LYkoGfE69xAFQSAvqewUPsPRo12VdKJMuFNuPNu1x793b2Fh+q2gUmUg7Dtw/+JsjwBC82sDyvySLp7PtQusspDzWiiikef+a+5a8XGdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZhF50fFMrRdV/tJLgOlAGqNjU6wwcO9Y5mQFoR9Dhsy7CrqNOH0v+Fgn+C?=
 =?iso-8859-1?Q?UAlPyggz33qktmIaPKXIc+ouaj4kBgcjcDCea+GIV+rct5SfiIdccYgXdW?=
 =?iso-8859-1?Q?7xNkmuoi2gokvN1y81UMa8VcUAgbM1xSW4Ptcclb5mbZ2meyJkUf9VDEBk?=
 =?iso-8859-1?Q?R9w5ClGrZayJNziW0fY53CJPByr+mZdIH5i80KmFMChpj03XM1zQhDkQd3?=
 =?iso-8859-1?Q?nMSgjHHSvE6nIxT3MAVwyIgvF4y8C1WzJByZgtxtPBneKX2GUoN1njJvXw?=
 =?iso-8859-1?Q?jQFN0uc0d6VXYPHH8LHbwb3/7SJE1YK+IbmrIb6lgkEPiPVK//gMhU34nk?=
 =?iso-8859-1?Q?0sEJC+y6k0nTJhjuXYetQgFk7A8mM/TR87Cf3jfmI0de2rZef8yZHmI4X/?=
 =?iso-8859-1?Q?EKAW6rben2f72DkiIgq+VygjuAtHxCI4+YyJvLaeCnxZTQWwyobekUwc7n?=
 =?iso-8859-1?Q?+TzYO3TE82W7iCihrcexDM7ERs5lHJ07kRYAFt5nUobg6xeDCJE2A15mEr?=
 =?iso-8859-1?Q?0MfVMnKI1s7j+mr9VnHyq1YPAiayS3+q4Nmjg0VqyJwy9cBnQRfuwyIRzD?=
 =?iso-8859-1?Q?jlSN5SkzAltUS448O7SwNqtRIQnlxNG/DDg55LIYhF9j4O2NBkciYtQ8E9?=
 =?iso-8859-1?Q?KVI6vmXIYgixLj4znWQyDzdhJ8ShqWH3uhVOC4u7AD2MgxNgu+Mg49u9c0?=
 =?iso-8859-1?Q?VwsqQ0ukT3TYGF0aYRyiwQo7KDqA4ulr1FWvv3GpW5+M6pLXSAt3Ghy1DL?=
 =?iso-8859-1?Q?6ZlMI8obIYao5Aqy66V2ljM37GHKz4pbactQNMKP+xEHeOx6AAg6LnZcGG?=
 =?iso-8859-1?Q?5ww83K5YmYhJjxCCzKO4sA/WXDttbmMDsTBDlN+2qaCFODcHPwNcHn51Vd?=
 =?iso-8859-1?Q?9sYDncA5UgNpWV3wFprTJnJrBltu64RR0x8wQQIF0J0ug8R4asUhnJt3K8?=
 =?iso-8859-1?Q?CetMprUYfA1rin2lo79loIJYun4S9vkfU94RWIWbNTVw7ZOZGkbVdbjy9O?=
 =?iso-8859-1?Q?rc8AYdptAuEFyhIn2I3Ba7GuF9BwReOc/n682yFMOXfUeYMdstr2K5HAU+?=
 =?iso-8859-1?Q?JaJhATEKyzg1WrOqIhXwRvIcoeKTHhEubkDPV5S0GWR2TIRuh7Ecgmx7AY?=
 =?iso-8859-1?Q?USJMsrSQo3qy0xPGzwgrRQ4n7P7DiGSnZFZSEdnTVWWniDGaHxsX0QlRIo?=
 =?iso-8859-1?Q?w5Mh9jBYoAFJdo0C4tLCyzm+opyAWxUrX2PmWjT6JYQGHrfMjngk2U4DlH?=
 =?iso-8859-1?Q?TLYLSkgRPGSdmi0ptiAd3x6uuqXTodFynBE2pFHknemDX8hxfphNxYyEWb?=
 =?iso-8859-1?Q?eY+pB7SkcO5XOElUvj9AaAZIqaWTEOO3R9x8Juoyscnpp1KNe8b0iRM3Xx?=
 =?iso-8859-1?Q?gTfnefPzkRHwTXIKOMqiM2KQ6h2+cpo2d9Cl0mLgPIK/h241F1Qn371CBL?=
 =?iso-8859-1?Q?KmMiDCKCw/dwQ7VxoGHD7tCOql/AGgp3Ova+nl5KrTNiyChAHD0q2RABrX?=
 =?iso-8859-1?Q?XaZuuzd0eQ8+f3YTKHtcaBu27kTJHnLcFnNt2STLbB3v6ab0JhUzym9zm7?=
 =?iso-8859-1?Q?XLqroae0RKbTembLJZmjPAEmOtMSYJHitTndikV/Gbllg61+hzBcmitRC2?=
 =?iso-8859-1?Q?FX55BpVZs5O8xc8tn4W2JdB5Znm500LOxGhfg0ojVKFGNdhuATdarc7677?=
 =?iso-8859-1?Q?tqeJ6O+ezIuz5JNq+wOytAN/TdMFB5YjYh6iF9R3D0FBuPP+rZp9/eqtYf?=
 =?iso-8859-1?Q?jXgQlLOTGTUsjrlVyl1sKbYxirethjf0pQhmHXdWjylIRdDr5bJtn1nXW3?=
 =?iso-8859-1?Q?cqFZpGBU+KGMXsk0OVOnf5fyXejiI4U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a4cfa0-f3c4-4ad1-4aa5-08da16489910
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:59.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsUaYPPfSjcBpO8e/D9OqQLdeFQlPq8kcIAvuWuGtrkRZCgdkZogkFOsjK4Lk3PIY54/Acp3i8gfvLziurMYdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: VhDV8Hn4G2t9BdbPNep9sRQPsXq883TO
X-Proofpoint-GUID: VhDV8Hn4G2t9BdbPNep9sRQPsXq883TO
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

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1b2916a38196..119251fa2d53 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -432,30 +432,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
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
@@ -3194,9 +3170,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.34.1
