Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486357737B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiGQCuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiGQCtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F871CFD1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8l9i005050;
        Sun, 17 Jul 2022 02:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=lwotX39epEY9YQPAuAdUlfe4DTuELyzeKuxsK9IeARS9HMv8OPB6PY0SxOKjcOfEV8Ua
 ILkmQSUbKzZ9Z4s7vfYY6xEOoh9xCHzGxHo7FfDt/flA8wJlJjBRkUCK9CGWNYehd5rT
 19r/jQL1pO/DhD/5Vp1pdz3f0pNGW7fzGFqnGiuhWuqGCBG+bLmkW0sX3i6g6bZLD1Q5
 m3NGDfBi5RULb0Ir7u+iyTeYLYSWC4hTdD7Zsii9BgzumOEMq6bbD5IeVJDyhQx0bslI
 tFBwLy1XerrzhhCwRuZX11vC1NZHUZlf6gPhbJkw7PAkTazj9W2C2Mp2fW1n7+8zx405 HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxp036125;
        Sun, 17 Jul 2022 02:47:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLJ9Q72mVxu7qfgLglcsUxUFN2cPgKjQV0yAnLNyQIA3tfvbdz00fcD2iCcEhjIvkNkUSzFmz3cb2zlubE4WHVcV5qhnThCjRkMV3edLPmD7DmK+QLGb9Zvlv754nwqxGVrvHMKeEFYMSPyaaGKM8ZR2NdV9d1It3wnnLMgUg7hre7R4g8e2U9aMBozTuQSpMhZ2DOeLuohM8TO6r3BnKeUkTiobjcrTXBLC1qyMlyhnPk7CgvaCt0fzmbZGwxQZWpNLDeE+k95NAqoGCYxvLa4972bWJ7FA+T5I+VSNYwkv7hMVgSN2flRWNsFpfmuXEw2oP2xwJZxs9Q/y7QuZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=jFifeu72M21QVJ/wZqFutafzJgtnJl9bohAFkEbSNZzo9QS4RivmXRkc2tK3oz7eTXIfNOg1AR6bS6hswcRz9hyh6cnDpQy1YygjP+i24BEdSySNnD3k8pQuI6j+TKBEBG4gSsx7I6C1TirdrLicEW7bjtB+ZW4Kc+FQV5/5HkgkY590iQvBlaMbNk9IKcd2GyXKZ1bxpA4qpYoEJFl81MgnXcN0l/hMPjx4znKaAdPh0IxtaNyarb4ov6POzSdIaytkS8U7hM807ZSdXeu62fSWuDPqEkTHwM9G+H45fuBqK3wyuE7WUzNoPzAnB/epMrSlrjIuEBvEAFXiJ4iNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=Qd0FSelMNsfW2JV6uHZD0scAKctwUT/JMNrH7M5ZYUBsZmeuFhFWQIa2gfnfyb2RH2LRKWALhjpZ6nRggZcuMU3lww1ftHNv4JotSfKKR3Lzrasnnf+J/Ouvpxna0q5iQxX20OKbhxxOVp1a3XDilvXNHzkfTiJoNGEw/mujokk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 49/69] fork: use VMA iterator
Thread-Topic: [PATCH v11 49/69] fork: use VMA iterator
Thread-Index: AQHYmYd401qZSF+Upk+wV/ProxkEAA==
Date:   Sun, 17 Jul 2022 02:46:53 +0000
Message-ID: <20220717024615.2106835-50-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0d4e3ae-d0af-4435-9d25-08da679eb111
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGbLYfFQODvjj9mEXV8jbqrKYgStoV09uO28J6n9rwYAdDvn9/aj7fEbr6D+66B8FxfP1YGI4v2lv01qXjGl32j16p8bemKstElZ8ISwmzPgDJZXnIk/e1o5iA7bozRfvmXgAjEP4n4kLQluhtNH1ZUvsbIWOoNcQs7zhr2sQXtf8qF938sJ5tZ+FWOfTf0XFIQilmnuhrCJVmpJHz0lagPgzz625XHzOhP0MfURZfCNESntb6liEKRnjc2m/0EQlwX1FBbwXbjjjk9RZklUzYd/ChnpRf36kPCQESNKrQE7yXVDXr8pohFooVPsi/UOIY3XWlxy7Om/1KvEa/qafR1BSPjAasOoXOxCCvJkYN1IJyqh/c1rKNOuKlbkvfuCsV4R2wsYApImvWHIbGXJY4oN/9ha814dHkT7+2+mBTPWgO0DaIR+5g5mXhEv0z4Rx7BeA+BS8SNzDX4CSN1IsKyoM5IzPWGD5DxHRHr5UQkes7sU6AOECm8i+QDFnQiDrkH0ZYVkr9G9vg147hapBu6PGqeAjd9Gc+OBVD+kCrXB9sztj2dRAG5QMNIYSqgl9YEUBk93QISGFp1WBHIO1Mb38Ii4oYRLdouMqu8Y7xch16PkFo4gJvNE8nlmSBQny0QcR2abBODyf/iI+H1R+QHYmXvHwRbI8YPxSE22TyCeck4HbrrdXFyoO05XmS8Epxf8JUH5t89Uo8HWzf4Aok6ppA2JaewsEBV1KJtmZPciFE8UBkfUIHAyK2XUDTIGm8r+ET2p08G7CBT8MRom0+eeWi5wR7voOG3ccKboL1DUoy/qlx3PG2GVw/aLJ5J9sldySkfrr/kr4az7FMsSU2H8xFp1PIxlP26VMY1oufkpkeZjdOzK53cBuNEs12+c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wRiFjnCMf9rpoIo/wBr32VaOa9npRbfXt4GMFxnez2wyv9yQkipMle3eQT?=
 =?iso-8859-1?Q?9XX6W+KWEpp21fQcya359vwWuZCa87lrSdPCdO4Bq6tPhAeDBhDxmO8+dE?=
 =?iso-8859-1?Q?1HoirMaBhp4hcmK8pbnU/12WNHGoCj8qAGvf+EjUgFJJ0fkhX+mwX83UDf?=
 =?iso-8859-1?Q?zhAmYAvkOCIIBzSGA5boBvnWXlJg0xzIWMsMUrfqhjpPvHte6oNq3DTFak?=
 =?iso-8859-1?Q?sTrwdJ8LI6MtpxYJ0yVh9A6GFai7n6gfnj69LtsafzutJfmGXVyT+uZqk2?=
 =?iso-8859-1?Q?fVhy0/ZXQof7IbcMNuLrDDeiDNZyNmdE7qx/ezkGZQP3/p9iXeaeMtdc+v?=
 =?iso-8859-1?Q?RES+WDd/JusjX+gvxJaXSUTTrCr3ALYGEGFYfxYZWAaQQxuy3mQ5Bd14bj?=
 =?iso-8859-1?Q?bUKzNxm26OdyJ6CA47zRnwY8fvbQuv+UfnaAN7fKd/KmAgBQHqAhnGxsfT?=
 =?iso-8859-1?Q?3WjJobWR5+4Bmly6YVWUnM7rTDFBTUZY8bBOLWhF44GfeVCWcZuUMr6TJc?=
 =?iso-8859-1?Q?cvxesbLKArqlX4yH0o5W/ylhZBcU5EkT+/CE/zdM40+fHy0NJuFKLjxfIU?=
 =?iso-8859-1?Q?Z/dm2sIqfkE/DWDSL9AZyXAA/WiJEMOTq/85wH+HGl78XlfiU9i8Ge+vON?=
 =?iso-8859-1?Q?Jb8gT6O06D4KFp+9txDHas/kIGc6gclCpoC3THZynxkdjWzXTGV5FXz4mR?=
 =?iso-8859-1?Q?m2/TeI8zPoTILP3fK6W05xsbFJEBmT8zu4rfFJyUqyLn/NJHABMKNCvZ7k?=
 =?iso-8859-1?Q?LM6acKLzGu08sY+5e0TQLd4lGUNbu8Kbck5HRqs2UXdctoTNJa8CmxkOoF?=
 =?iso-8859-1?Q?rYl8ybqY8cW4UpQGKhLv3sT1LBy4tfnfL7p6Ca8V7u+8IZmFAPkcRbPAAZ?=
 =?iso-8859-1?Q?XnmchIvuJ4eNk2HOCSuwyqinMwql+F3LK0OA6IfhhIQ49bfkxmGbJcxlYz?=
 =?iso-8859-1?Q?BOgAvJ4GqLDa268iBhD0hwNvvJlr/JvY+JKMQVby0jziYSr2L3Kg5DopXB?=
 =?iso-8859-1?Q?2uXaqKz89Hv4vSXJB59hivUv4Gv0sPXKFpErIxsRD7ye0NJoQXMICGHDyG?=
 =?iso-8859-1?Q?rymQQZqBZ//FbKUrG4PN2he2pzklxLl4cdE4v0lIhtE9zZJX9giCrSUJ0d?=
 =?iso-8859-1?Q?YAczFdgdqkm4dtmWVQxp9OfgM99AeyzOi/iC6CAMNKAHH1Q556U9mcxoVx?=
 =?iso-8859-1?Q?UkkwnQm7l0vd0bb2Ftyap7yPdEtikr5dM39BV/2X3KyUZ3pc+3nE1qZ3Wx?=
 =?iso-8859-1?Q?6t0TYyWv5K/WmdJl1AJrIwbyjBGe7ChezWRWm6m4I40oRahNsSiT2x1T0i?=
 =?iso-8859-1?Q?JxFz/uFeBl3Pzb+Il62hF/2zedO9cqXaKd/XAKBDNwr6jAMaou6ir0ts0s?=
 =?iso-8859-1?Q?SmeB0hQK3VX2939rqmoGQce/W0ClVRJY6TMWNrWA2kuyPQqbcHUMfv7yKY?=
 =?iso-8859-1?Q?vYVhdBzEPq6dwrb8vUxU0ufYgLf6WzluTQbAeseJjxp0+ccWtySsdxabI3?=
 =?iso-8859-1?Q?CbRrpcQwZ4uHRVJDLlbdEDImnE8chB4e4ByPl9eJevHaVt0um7G5tNVoE2?=
 =?iso-8859-1?Q?K7MC/CC2nYnXm4kljjzlvoAm2hbtnxv7o298oLShLJQ3NIbVEZ0PALvlNr?=
 =?iso-8859-1?Q?ZlbHCTM085mKCQxNQh4C94FMICvODffhLe6xHGviow5O3Eer9dTid2KA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d4e3ae-d0af-4435-9d25-08da679eb111
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:53.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wrGKfnxgGV3RloxPrMqQTPmGEXFTuTKImqYjignjp0/ErEeoQv+7RZdf8sqyazkPxDIs7gzUIKtDUjPOEStQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: G2FWFTjtbKhgWAktP-ih02RH54uYA4PN
X-Proofpoint-ORIG-GUID: G2FWFTjtbKhgWAktP-ih02RH54uYA4PN
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-34-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-50-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4a9fce369f30..4b7b0b7dd446 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1294,13 +1294,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
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
