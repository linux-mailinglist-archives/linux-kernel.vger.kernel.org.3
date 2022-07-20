Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184757ADBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiGTCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbiGTCW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DF6F7DE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0Kfc6017922;
        Wed, 20 Jul 2022 02:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=wZpsPhdIfklbcI+VJuqQ/IyOj5oZkr1V9Z6G9FAXP4GfsqmYlNo1a3y7hLsN8k2HxYZW
 VES289LYahDVblO52bMSgfT26p/aUUwuEbZxt9spQyHFW4PeuahI44RFliw2PZncg0od
 Tk4dBt5h/r6+bwqb6UGwonKexSqcC7AhDbhvR777zRv9en+WHm+vkaTzvC6tduniU0Rn
 b4mkHG1xuIPpI+ycGLTpMV3kduYF7sy5BfNHJd3oFIW9kYhg1FhbGma1Bq4s9r+OhvZC
 zP+6m7N81SJxiQpX5h7J+7n+0IdmGS+dWLWPvswG8WTJl95hTOmYw17FRBvRPIbgJ9uo bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMn039258;
        Wed, 20 Jul 2022 02:18:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBRjTk9803rUvNyH0/Xmc9yuU/KgEB/+xY4YggKkLGAlqtPTHwrpmYJkD4SEQVS1XBD1mz8gcaLhrVh3dKUphuDGiZpewyZ0xh2Hu0eXWp/WBu3/9CYxyqtuinJHzGPFF6m14ozYgeOg92vUjZURofQdJLZmctraYlTzn6Tr5ix6F8ilsuyYHlNqx1b6Xkjmu6/4DUHdml4yTPkoEbGkMsJwnCS+VtUOzVp/gXKyCL5aWzNwz+5LSimWEnBAQNcsRK1dGbh6AaAKZr/DhVWk5QxFIMB9TfKVvC127RtdAV4aghrRVzOnuzYg9qegmmWaNpOCW/9eolALgEPm3AKRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=Ou29JbVMnbJ4pHp5shLS1mNoQ2+iEzy8cnZuwl6pOLjm/VxzhHGh7l2rXblXUGBB3neSd6NxJeU8LzrHfHdP0hDeBqbMpmiBz1PNxRoKy9eyWogyrQXKKDbByarcv+KImZSMYU2KXKIsy47/Ui5FLk8biJZYwSWdJEpGb+4675iiTnpPPMPw4IzJbkbC4qnV8xqzgnBMBL6hNXWoi8y3WwSvl5Eg1mn9XUBfU5k8LtFbCVTqBxuQNWOO6u4F9rykyYQN2grt2M8iMQrDJqmobjg6Xsp59bO7m3/lqCSPhmUvuuGXSkljy9wYAlfNEFeumJ1x0dZ59J2m1DjnTCP1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=GNu4IxnqmmdjlksO1aM3yd0e7sWbeYj4FtNSDPgYUamCNyMxydKb0pxP2+I/Ga68+rBOrLbtFli9J5RUsAI5wmM9RfrME7TodD+HkeEhj2i9DL1+934pOZn+iMHH79C23iwYCvhslWtzHerdAPn2QPiqFWFesfs2/bK/AqhbmxA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 52/69] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v12 52/69] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYm97uCPAR09mT5E6gqFxpLKbjfQ==
Date:   Wed, 20 Jul 2022 02:18:00 +0000
Message-ID: <20220720021727.17018-53-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3321d93f-07a4-4602-a4d1-08da69f6299f
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHpPrh17GSrzIw9ozg8MwiQhgATPPsThP9dMwVYl07KDLfGBGJJcZ3OqwMgIZvpLjFFmL1J7C2VdbLPawOsEJe6NKAipSnf1fL+dV/y2K99a67Tjc5pLCz2YJL7IKhNmdpKecq4tDeHfN+331OL0VavyHfzXfFpzf3AubMx6xcgT6eLgkesCY086LnZnpt0bep4XtqfqKqOonZQe6pioYNd5wQnysmI9fa02zYTXRWquTsdtI60IeNVKD2/NVk7c2xx3PHm6bsV/LyfQbZsdfEdsicjJwOuFI7naWmzjByh5NxObwjp0ulGoZfBIjQy33lL66/Qb1ppNj7P5dt/UJ4mqY4w3V+4O1Abf2JlwvcN3k8nY9iU5rQuoTtXR/5eFfyBYWRPvj1aU8RF3WdLsHjMutKo/s+BqGNn+jHK+wdrXhjDOLz03lMIR0S45s+RxKe1IoPGDST+3I5aais85dqlM8+NprfoJGJk3MXgv+yVXS+c55LQk+1yJApbA5Mt5MJdsvCnsUcibH1SvO8Gd6xY35ycaMo22v6FSNxopOC0Pm8OqZEycUlccJiQvY6n5c72briZo0vZq3GM2lL4/fITAui5eAWf0skoSwH04eHBZ8uAGtICB41Oz1to8JMDKe/gIlFN1dkN1nB8/HQN/LBrQUbxqK0XmiRnGMxQ9hxTde71mRvFUyQNkH/EWQKFBZbuasiJTwuPy87J4bvkjGKDZWdZhvb65+faphnkeaRTAeXpqwAusXnSvidXVSjhgexCcnBP/cn4ZTpD+/Cgkcm6C6Zg1UiD9tkSKc9+SAPwcsKVXUnFiGOVrS6B5ONYrop6PqviabC0D5tPJmmUKoSBeaJJBSzhz8QU2ynOPz1erDG1xvs6OgBzvTk3yC/Ib
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qNp71GGBMz7byvKAi83siM8Hj6TLL+ARZnDde0kaDYj87skb2D4MbEA3wV?=
 =?iso-8859-1?Q?Z4zedQUoTRmJOMaLxW202M/tGYkz6YQMzkhx3+vVu2/2GQ8AIPDLkNQxw7?=
 =?iso-8859-1?Q?YNDSZidU7POcKPf8mM2lA2T/VjO6HEto9BHstfiEZcuHs5XSfTsLGt9l+L?=
 =?iso-8859-1?Q?fbg+A87npd1UObtgyaxBydCGotEBxJuY0GQp9u/7p4NOG/iOCDyed91rM4?=
 =?iso-8859-1?Q?Sms0eXKg5KE3UzURtaLLSWtm5ut3gY8ZokFqCKHP2HgXUYVGGCxmhmCe1c?=
 =?iso-8859-1?Q?vUFP5uFTSdTkdp1tw3zT17yy3KfuNXgnehMoi2OnciuZ+cDZL0LqJ4hsy1?=
 =?iso-8859-1?Q?GM2gG4aCrnUE19K3HSokxRutkTyPFzo3EktojY1UIgTnqtFnmQ3cn0I7oE?=
 =?iso-8859-1?Q?LTbGWn+DWgXJgHzjOk0KnSh1Y8n3DZqE7YC2zuFJjktiFD/OsS6zhDk8NO?=
 =?iso-8859-1?Q?I6dNURuwyEKkwEOx3XiLhjCvcIwn8SaUVUuha+QVwYPxSjl6o/nRPSk9DX?=
 =?iso-8859-1?Q?PGyzjybtYJSARRHrMP9S3g58dTiBfWSQB05HD1oKygxF80Yl2bjnTw4/hd?=
 =?iso-8859-1?Q?kBCn8SMuzczYyA+dW9qxBYNdNexchxsuwUKcfelRvrUMaR2IS+glX8UQP4?=
 =?iso-8859-1?Q?L017GHD/BLvPTu42dnLimTipma+yRjNEjo1X5d/UdgNfLyQDUX2tle2ZZ/?=
 =?iso-8859-1?Q?nPoD0nXPiFU+vujAFh7m/cYuYFegU5kPRWA8I/xw7uuNduazGa+YhpIho6?=
 =?iso-8859-1?Q?sjnXwF3vXNNGBxi6OGC8nvCBfXbgJCDjdx5gpnWen0RJWYE9U06yfeB0gX?=
 =?iso-8859-1?Q?chZ+PGiOwfvaJyf+/2gDnYFaKUAaAPUjkzIVkEQACBpLbTzXjqPyptV2Sx?=
 =?iso-8859-1?Q?VbhhL6BOpfPQC7r615hqt9deINIQKqZWFW8J0kcgz2rsGyIYbVt/KEbPQa?=
 =?iso-8859-1?Q?VzyWkPOo/Gr5BXBkPWsDRs+f1r8s2XXWnn2bMPE/qCxhn1BKcPTDcQZGA9?=
 =?iso-8859-1?Q?DQCesNkqUpz+8bl98g/wFDZwJf3lpnj5ya+RYdjYabYCvrofoR/wSuh0DM?=
 =?iso-8859-1?Q?zKSZRiodNXKs5/D4432dx0CYuU8CC/1Ao6M+pLARFcZ/HUaqTKPrp3VEtl?=
 =?iso-8859-1?Q?CqWOlqYHhvhRKNDgorQ3Kc5m3754Yz6WhChctfZn+zcEnuOJCabMlA/DYS?=
 =?iso-8859-1?Q?bmF7q/it/X1e/PZ3OLri3iFm/HfjpZt4S4cANpSkt0MvY7uDVju8M1awHt?=
 =?iso-8859-1?Q?9soid7MYZxlcFKdeuoaNb0fCr/xCSD2OqAlD2sTAHb9j9Y2Ybc92m5Q1QM?=
 =?iso-8859-1?Q?q+iheYUxJku6OWML3xQ4X51s+P74DyVPCA2ogzuffwZ71xlALfPz8Sh8RW?=
 =?iso-8859-1?Q?e4VpNsn3TyjUNHhs0G4F5mLpX8QCMySFLSXjdbqF8ALcJkZ79X5K1cLrQ+?=
 =?iso-8859-1?Q?kukxRs/FHgS9vEl6ojW6C2C3r3hWTEqZWxAPHhCjl99KvK5D6cdqQEHSWX?=
 =?iso-8859-1?Q?LMAJKHi9osCP0WOunho+jwfvl4tybo25NJpDaVKqSmubhWVomEVmocJcNb?=
 =?iso-8859-1?Q?qYuKM9BE0dGypR07Ytn4C2pcLcQ2ClksErdjc7EXfYHFkxCiyTYrzelWby?=
 =?iso-8859-1?Q?+WFhZYRp8WvubHGJCs4/56JVUQjdAio/CmbUpnZb9RfH0rtjaNl0Rzgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3321d93f-07a4-4602-a4d1-08da69f6299f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:00.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqm5PIyNn8SRwU1bj7SbkiEkRudCsguepdWtkJ1BdZ41hcjEcmZAv3NeBnVSLu0xtHVSlTH1dGdzfODLFVsLdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: 5cimcP_UWSe6v0Ydn5b1ciGakUQohXR3
X-Proofpoint-ORIG-GUID: 5cimcP_UWSe6v0Ydn5b1ciGakUQohXR3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use vma iterator & find_vma() instead of vma linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-37-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-53-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..f44ffd3bbfae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2266,11 +2266,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbd68c414d9..637bfecd6bf5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2092,10 +2092,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2119,11 +2121,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
