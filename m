Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9057ADCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbiGTCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiGTCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9606D565
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K02wng031777;
        Wed, 20 Jul 2022 02:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=Tpfd7UIte4S9vfiP/ikDaBhwPRkpSe2xK8OUW7DVK5ViH62WrFHo77Ed/gek+7aGrhO5
 zYNX84rXwzHHl4klT5LmFAzdGu0+UlM2ZRW4OR69fQJJoeA/i7ZL3Metq/FEzAdOWudz
 g48HhxukuOQhOoO/ftJ1rm6BvCRWrRzyFdQLSejx6XLO4swWnryIsuxhCWoCBUGU2TiY
 4GiKoW0dx07gfjaAguRDWFWivSl/kpY7j/twZ9wt6Kup95TM7g54Xs/Qc9A0npg91UeM
 YCewC9HJW0uf+bZlozv2AMgPUEJNESMUpd2QsxSjwA0Y0MxvkCy/ona82Nd5x3XWMV3f UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMg039258;
        Wed, 20 Jul 2022 02:18:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7/Mvo7H0mWgpCVLj+9YofUWH1U7DHOdiu27pe/45lG/J70WJWmHFUqRi31ce6XiYWs42OIWHR0Rnvtqtxyr/L/BIrJZsCazp8CPND+XJNJ0uKoN3dQPXzEW7vXkD4dPsrxNJJstxG6FLY12CwVGYA68GHgsP6rydSMGFw//dgGNy40bfQTi+B/JpJ5gTgh3NFghgwshrTrs+sY3ao7sd6A7CHR+UBYcF3OKRfcqPj98aGOZpPdK+WBNHhLrLMJ+mK7N88lEFIM79Ow1ysGeCGdI/ik7G2OApKh2GX2+j9EX+3R0Ha7acxzGk0gXrKhYoUQKO4ChJXdfKGj6Ock25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=HFB2l3xLetzA/TiVmByx3x3BpW54sD6kYPczP89US23fdMHUQVhylyRY7Q+eJnjsNAPpmG/3+oOmQ/kEPWWVRk1tWMxuP3lfmkp8QVBiGoqOKM6zvgqXT15/w3iQmzH/b7WR5kVlvlxLXYabfvczJwgKf6/djjn7d6CX5OQmA06XrNfeQ8Y0pJwczH9r1iELJySvRhilsGhN+KlxjOP3IGpqW0GLjFE22CN3OkC5VFxA1R0X4MYZd6KEaMz0VoXSmcFjY6T0LTOjtcbKWEw0c1Vxt8E9ZnT1nZY1JG67OrpWVhuaNXW7VFGZgl6ubWkf6kjTvClHFkcurjMQD8COnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=O+rCydB5Fh70KMkBE2cRzgAL49zb9NeYeSgX8dr49wYb++xQDHKxPy0HqR96O8QVF9pNY6zf9R8PshAJ+lOCOnudPUVKbgGoiFqq3np7qZZLt18Sgf/95Sd6H7gVUJUOg//q1FO1kkSwmhentedaOI/m4N+H+WJ3Ojihsx21hOY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 45/69] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v12 45/69] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYm97tMZuNsxksIEuAXfrrxlEeig==
Date:   Wed, 20 Jul 2022 02:17:58 +0000
Message-ID: <20220720021727.17018-46-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8afb5347-c76a-4178-d834-08da69f626b7
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flbcyZuTt04z6tsywpVrUGQ42Z19/Jt0/kRhPt6u8Qy1uhEiYNu4Tv5VGnGTHoKXk0phCGh8Oi0/MPSVwr+tXBNfbjYzVDe7aOO/WHO9653SCxvdabLqw4wSCKa+7t23tDcSlu6hgj7198sFiRcdKxZzC+XRJUkofm8kfuZ8QsnMSrCnL4tpViWn1BJlq+MD5qwWJI+C6Od3fp7iEEi2kJO3E2HlphILFyBo8DJeFc/bNRRpgZTRmC0DHzWmkNT/WNL7I3ILcR2AUSvc5Vsub40z16Wiy+8TiQLKOJQdopJMrVph31NgU/6u7xKdRO6dbjkhtvbWY6JiKu7CTKiD8N2Q0L5LPMHE73MMHOSvGpShszTHf3CmE7fPLpIMDI0EgC8VzdPwrEIzBSIUuJ9JgmV21Cb4XUpgsp7d9KHv1tRawZau8t5AFqMXZB4RCg0Hd+X5VRNGd+nWeFZJj/Fl8BBnFVq+cCSvBrnGWAIJtZ+PvlwIbjKTiwUx8LUyowIukzN6f/+A/2hJdlJA6qzmsV2gZ/j538Vfr2/nqxyHu+YSQxGVEuevtQIiDVI+LpX4QYhhoj7TIyrpRRcJl7LuUqAn+EJdO3Q85lTA4vzi6qiOC0XEoyyjfF6Ia0wGjBNueOjQ3Y/jvWionoTmx7yMuj+4L0nUAoxVBkW/TPvq1YixfZoMW2CnJhnkwfiSoIp08FrQIrb2iMQbre//RJkIgsftKVePpFPhz5/wbSvXe7iJ/2/gTii+VTDrd5euJW3NYB86+wP9CtslzZZO5YfcHObIa9/KDbFlypj8ikFb60x9T6o5cach2vMtsw/KKGHoZgj0NDJtVttHTJ9SQVEVexL0fs57dz2wCg1z3QMIx14HoBSqkm0XCROlCnm9Uw8R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZZb14zE0S1itCHGZtAK67DktwJIo9fQvRxKg9PI6D2w2wJIPIzNe0VGw6l?=
 =?iso-8859-1?Q?Tzrn0tTCHU3feQ4RVkV8JAlw6AneuW00xPedbrATkCm2bEYomdrE74qxal?=
 =?iso-8859-1?Q?NOpHo08xkfSvihh88ISBddM7ehoLq7ZOfznQHXIEJGrfDiKfWHOahNkMVB?=
 =?iso-8859-1?Q?t0DdH9DmBQdkqSgR1lP4pXX9kwdNvpKfLx2S9DsK+uK8ztj4Jk2IF3GH8T?=
 =?iso-8859-1?Q?p6qbT1D+/+jvamn5p9O2VlqSV3dduYJ8stn1kEwZ+4QIMemFqj9pbPamPa?=
 =?iso-8859-1?Q?jvx+BkGGjGJjy1KFDgFf1x0PvUDO7nnunq9E7l6oYSZ7MzKAYFcgzUbToP?=
 =?iso-8859-1?Q?3RTmaaAvQRaMz1mUqAY7GBleKPseEJgCLyfCdSEHD+0iOwkTT8cHDGsSJT?=
 =?iso-8859-1?Q?6D5FBkn3boNXJ3rxjnWElcDY/e6T/m7PP4N3zS5vzEJqMOizeX4g8jSB4v?=
 =?iso-8859-1?Q?CZ5aD6g9fBYrr9pAp0j1qlSDCKcvmmkMpIEG7DfjbbVjZfx9Z4sSaQiD68?=
 =?iso-8859-1?Q?l5F5PdukxxveAshZBuSfbUHiUB3sqS7fyD1RKDLyoCs0it6KuHyEDs1/MM?=
 =?iso-8859-1?Q?D51lpu/vpyZAygah8DWVJUsZVFan5fM3oG5x4Mu77/8Hs2mnJvSYjgw1kA?=
 =?iso-8859-1?Q?3fSRpEnZVcgRWVSseliY+CmTHVc/9tyNyxbGrYHcUtLJnZvBuOOMeuTXe9?=
 =?iso-8859-1?Q?GAHqU1cCcptpY40wATTCM8B+MoadDBSj0As6s1lw78Ae8dMDtB0DFL3UpO?=
 =?iso-8859-1?Q?DLJJVjQfdssCwaRoDjaWsiZzEFI7vDq2IKLt26Hw4qwONiw77rHpQZLeEV?=
 =?iso-8859-1?Q?meGpiKDuSD9xANNfx5RraBuBLuvlGPHhFghDQmIcQog7Rn2orK9ICzmo9a?=
 =?iso-8859-1?Q?mHxqPnTGsrGh3QlG1dBWF7aYLToirvrNNMMsBreQAyC9gbOQe78Get6+Ss?=
 =?iso-8859-1?Q?LRI8pvknOC28BKYNp+nIuoojsn07NEhTjJqIF6KWySQzL1JkhxJMGlfxJp?=
 =?iso-8859-1?Q?DbZLHfJA8Hlf56vyKGvlBZhrplFt8BR0wWk7hc9IqbVpaR4a/JN0pQTe59?=
 =?iso-8859-1?Q?niuJbx3dtUUhBpQUHfhOpnoVpmTxoeLOratjTZSr7HG5QLAoJvtFdfG9Ui?=
 =?iso-8859-1?Q?jwi08Q/XY25aDEMlYeowApA+narHNGqMUT+M8n5ra2KnE1ULeR92PT88JI?=
 =?iso-8859-1?Q?zTYVubpAO1fwPyoRqEabW2J/hQ8ylra5fx6ngV2xzQEfr6GSi/t2znlfE0?=
 =?iso-8859-1?Q?p0GF9eS/i7Lzb5+0wNzx5drF8OCC5swN9QAfb2nlN//B3wFJldb0bqvWGz?=
 =?iso-8859-1?Q?YiTwF+zBp8T+r6gRNhW8E0MrdLTQUq7Z7ha/LfO1dDwif4Bvu/JScfz8pF?=
 =?iso-8859-1?Q?N0CkJwcMqFsGd9+LZ0A3qLr0F5Rgp7D2Zm7DsPP2qFYptRhJnixsYAnZKM?=
 =?iso-8859-1?Q?xaeaQBov23uF+qx6oCCS6s4AJUftgyfu8Gv6VBlfnWEIQO3UqiJzypuXbC?=
 =?iso-8859-1?Q?fNn8lFo2uXUI13m/YdnvVI9Of31EaB5uFB/fLr58q79InjfZPtfbOUMIYK?=
 =?iso-8859-1?Q?WBLaDT1UyYYmQXRAfkIjSb5kk9WXa17pk+fk9zhEkYFCSQbRCw31EQnunQ?=
 =?iso-8859-1?Q?EwJes2ShYR4EFX70DZADsNuJD1PjOFJQNf9LVAs62uCBVHqc4mfN70Ow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afb5347-c76a-4178-d834-08da69f626b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:58.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9ZlvO1vr58A6d2EoBc6Y05Lvxp7xg9mPrIW1kXUwe8Q4cm2iN1n7PdzigA12Co0vjJMb0Xk9Q+Dulb9wWZ1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: 5t511W8zEn602deliXsWcnPElzAkuS8x
X-Proofpoint-ORIG-GUID: 5t511W8zEn602deliXsWcnPElzAkuS8x
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

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Link: https://lkml.kernel.org/r/20220504011345.662299-30-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-46-Liam.Howlett@orac=
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
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.35.1
