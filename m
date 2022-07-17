Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B15577371
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiGQCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiGQCtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C520BF7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8mWU009468;
        Sun, 17 Jul 2022 02:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=iTuL47iQE4HvicYtJsDu+ZfsbK+XmextwRDaH4bPrEXpSyi9eUnx8Xhj0fLN2+dmTkzM
 O86l7XdxSuWffMnvEbZnKyPix8ZltvdZgQXeN8aV+lrxNOuPOvHSHgnf5XwXyHMx1JRQ
 BVzQVOf6UsqL9hIZRuIRw9T1ilcHtN6zQOx5pM37sBoR+kiaBYRmcFZ4/3//0JL/+icg
 qa221jqHTZFSGXwXPDiuZSRyp+/6lLW+cYIqDwg4xE4WnW71amv2YdBYpT0XXwu6gupF
 eth9YZOxqqS+22YvpHMs9efYjj1Lb+YBo3YgalinbbxqJeaJFAlA0JMwGgrC/NsWcNwk SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISO036113;
        Sun, 17 Jul 2022 02:47:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI0o1o7rAiPAFGgL6oEIrTTRBUj6qCSdIs2tGOGY2CvnQIG97yufpr1CK9rYX7yesrocvIZy4n9oSnQA+tvNic0yCS5k1ZAotMtV40Yrc8yJZz2W2T1Z/pUzSvNb4SezATGjeeI2m7DREZgJCVJUwBO3oGuWlaefnF0jWhWJ9tgiPoE9f0oCqkI5atLpWtlAefRuSjj7F503oPToomtc8NriabYyLtXWxZ6sSrhZW5Yt89Nf+vYIO8T4wPgj+xUDzc2ruuA+AQnbUhF8Of5GZ9iIESqjxBoDwIFJ+d0ZQHNoPBOY6MtgNjwAIjzA08akrzwK6BSS94M10ihGXdbIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=k9v1+MKqcFxORHSu3G7gzY0C02taRKXrZYBuJ1GNTdcIcHNXuyBA4Fa3y7wRb9By8S5PTjYp4zuaWK9hbQvt5jCaK1KTMhDM+f2x9UG9tXjjQFM/jPOMBZE43z8S1mzKI51metn5Qu+8JlfgLEqxWIAJL25LMz656VBZRJE2FPQ0vMCtKny9bzrZW3dbXtXa4SzVAxCVBblzim8bAhe91Ia+wY8Nmqe7paWpBkW0BsgqZGMpBb5DUMrW9JtGKif/iE8zJbb/Vdq2VL1dV/hMQsclyPErOJw4FzrhPLRKKtBfZJ3ep80tqqMKuLO2CqkKPR2YmcGYMVqGKij5tew+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=yVafz0EhwWuhLrdUoiwcdCZvp063GkMedfJqWNkp3GY+ZkQvcG0UD6k6m6KZqzkk181TzsUWWgRtceZS9d92YOCDYSvJrYgSVR/d6LedEOj43sa2FvD28TJQ0gVGhPZGIqPYcbDRLJmEoTbhzk4ZQwF8GsIQEQTOpuUW9PDkoi0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 41/69] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v11 41/69] exec: use VMA iterator instead of linked list
Thread-Index: AQHYmYd3+/Z9xa1P3k2m1RKeh6nxew==
Date:   Sun, 17 Jul 2022 02:46:50 +0000
Message-ID: <20220717024615.2106835-42-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d156b165-737b-48a1-1505-08da679eafbf
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gknaAF+fBtYTNB9SjppLhF1P0ObIyv0qGcW8pCtGfQpLAWWphb7VOqd5SMBbQAL5cgkbWEItCl0vjE+XfQIH1wScJatsgIAg1/W/gMTJNvc3J3IoeIIPjFpD/rKqbzgWYy7a1NYZLF5T1gX0xGMYxQcRcVxLLL65eMI4WK6LJ+FNQa5trVjJVYupfa1nrRLoqEtPaHIC+QJvLNF+H5nP5YaRV/Z7T1D0nOrxocmOEEwWzkzxZaQ0+HAWKBByelM8n8vO+H7T6mHeIYn12qEXT0JAXocaO/HPFSWjeViOPaVVHZwhe7wheLREPzE7/bb97sQH0titXi6i/CXsOlseDU6XTuaEWSzg+FNqEjurM9bsrIaS/eY+anxTw5Ncb1JK3w6a/aeIzauOEEQeiMHrn9jKoqRaGnu/YryaP2EIReMWeP7zc5T/ujpZUoSHxkfJJNzz9PT+r2gT/po0w3yrCMQRue+z5NhslzwzVRZye38GazpelbqpnqBxgrQdDTr0rQJiiAdeId/4sPSWWIhkQG3cBiB4h7u2z7tAtNSrWwjTF3zJrk0Izepk0TA7Q1RrcTlrj2Hn6+oiGH/Lq0RMpPCx0sVeZMoHscy9/IRZ34HqcPqrJMbOuv6MtAIAMITKLAs/3rtF+/a3yWJfOmm4TL+LgZrY99JKA6NHmwSuTuxeOG7Xf5WRUaT1kVSZQ6DciXs+5IZVma9i4g7dtjpKBA/P6HSrFFC7l/D3MLg2UOLCgHvKtVZST9DXV7FRXHMlOUcj4yMa+7I42zlu6YXYbDOF3dNnrP9QWsk0qByBRm1JGWJacjbBOF00CWwfyP2nEUHk3NeoyD62KCXWR9GudDIBFUu5v6CgOyLNzkBfw15PhggL7fcbhP+1zJs8U9pf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F2rfM3BTp/KtgJ9webJcbgK2by5tQ1P4mQiwvmIqOh3xfUH9Ai1vB6IOi8?=
 =?iso-8859-1?Q?kDCtJqqs4UxkNGAC0GTwnwjE7SGHYcxTgM+aVGyKMcEgYDm01pKtHsKfp2?=
 =?iso-8859-1?Q?f6TH2rpTiaYP9EqizLBKWyTFE/ckVnpa8A0MQ1ElX1Jat/xqUyWDeEJvkd?=
 =?iso-8859-1?Q?ss0Sb88Vu/lyLWnNJrqFtYUxfFqUbNkLxtl5FjM+YduUXghGg6FNhfQkM+?=
 =?iso-8859-1?Q?RDMm+GCf3PKLyWxm7B8gsRRyzSQC3hmr5ztTvJbQMiIK4PjBoHiU/7TQ5G?=
 =?iso-8859-1?Q?kD1enkyheZ/8/0bDeKuTpboD6f6d30w3//assGAZIJttvE4jEwTdQ6T+N8?=
 =?iso-8859-1?Q?clxrARO+crdseJ/4rELaMBQ0+HZgnNGq6BdeADg8/FeKnlv1QafHA/FE1D?=
 =?iso-8859-1?Q?oOUUkGu8b77lfjmFRUT9zOdPaiubHwJi/qbaVsD1Wka+9ThBSPQDX3C24G?=
 =?iso-8859-1?Q?06coa5012tF+2o4zmQbWJDM8Co6oYzfFtw+WSTZIis8giktsTfzFFAO34a?=
 =?iso-8859-1?Q?D5e3MsYTVi45YJLi+xnO6yjCx46LwhBvxpMiJRLFEnvv8qoqsKAttFixh9?=
 =?iso-8859-1?Q?mGce8NMCVTPpyaArQ+iy6ie96sEnJNvdR2z7PBMHU7hqSkK+R+L5OZ7Fnh?=
 =?iso-8859-1?Q?Wfj/RrTubu7t63YjGQIbFCzHdlfa5Kf/DyzqTg9OR8VpkSzcNMBlFcasSr?=
 =?iso-8859-1?Q?6q1V4Ou+zX2J8Csxj0MXYaJJXIKY1dqOGcAcijd4vtSenp4yOZjvI9sPLh?=
 =?iso-8859-1?Q?qDxt56XrMHUP/JdFuAoCr10Po54qh75wFqcAifH2fd1B6SBA1LiOpipiwm?=
 =?iso-8859-1?Q?CvNUGtjnBpBbVInnzo70opuz1/xDR7ri8YJNB5bwNlZw0mFtlDgFkTNynj?=
 =?iso-8859-1?Q?Pq8TcQNZyAgq4pSpIEYaoDxpWl/0zGc0EUlZV9nzk8YOjo71IOuoBA/2Da?=
 =?iso-8859-1?Q?ar7yfP9s9TLNncb1hhHlQnOqEYYDGhfLPuchBPTDIM0i4+rwVdXEG3NNkX?=
 =?iso-8859-1?Q?WUptNUtJ5SKwFI21aMRR0LrvXGeaxxwYcZnV6cn93Tv8rXMQG2vkngT8nC?=
 =?iso-8859-1?Q?KI49UhhOGdzm1qTEGsb6V9HDKWf3A3MvUn0IPxedvw/lXxk9mjwa8Ae2Zi?=
 =?iso-8859-1?Q?c+oeubGiJqpj7O5EA5n+MHNU4yvwzFsrJ3LV+mgVJSUTIOoH2G9qMuiTZp?=
 =?iso-8859-1?Q?Wb2mdAHvEePZHqr/zlv7eQ9nf0ONLLzgRfzqIhfdQkhUBa3WJwOx1Q8p9w?=
 =?iso-8859-1?Q?hQugJBXFaLq2feE748OgBarWmheDebLNMm6U9Tf5gOh/W2tRPku/JKN51b?=
 =?iso-8859-1?Q?ougI9Yrr4mI0cy6CPXC7cHb7B6yUk3td4wK88FxPhhg63LuOU4yub5Ruku?=
 =?iso-8859-1?Q?lFSJMfAYpdcwuGuCA2Sh/qjInlX5bxGJvHdRINFGWQnfUQRDo1YJBxX9Ye?=
 =?iso-8859-1?Q?W4TSvOonCwB1WSn3eFg3jPm/frb6MBzmhfNXEeSaennuQ/ZYI9ZGCu0ggy?=
 =?iso-8859-1?Q?6wSWPQiCREgIuXOMZNJH/QvipfPQEhmwfiQI3cgP4Io4UXM/ZvJCY9g69q?=
 =?iso-8859-1?Q?BP1WZfBYqMaKHRDILI2ZeKWBx1xo0II+Oid3S3HFv9vjQ9YzHCPcAsLQu9?=
 =?iso-8859-1?Q?RowomcwRHVb/sJMSkGPHmU9kJZ+rzYPhLJsJ/9kKRwzlqpDmM87931+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d156b165-737b-48a1-1505-08da679eafbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:50.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/pGx8NTap7EYzGTeZtBhO4d7AWXRQDjG/OEGwhXJIUMgKykZtY9eO8Rp7pMogqKyZABq66oYeS3bn6IV4eZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: EppspJFsBORAoNk6ES2whIe5Cs1gyV_6
X-Proofpoint-ORIG-GUID: EppspJFsBORAoNk6ES2whIe5Cs1gyV_6
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

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Link: https://lkml.kernel.org/r/20220504011345.662299-26-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-42-Liam.Howlett@orac=
le.com
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
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b97afa682ffe..9843cecd031a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -686,6 +686,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -694,7 +696,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -713,12 +715,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -727,7 +730,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
