Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C20553C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354810AbiFUUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354666AbiFUUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD92982E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5FQW011595;
        Tue, 21 Jun 2022 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=X+Ejkqgjr8uRyorihVORLZNJCc6ei5EgI2IhY1JrOhA=;
 b=W5W65DSSWLLzK12YYGek++9ZV9dnI/FUf7+4j9Xv/Uq34qPDOxpWWgurPtpkz+m1PzXq
 rhZnKxBTESyInYV1zxtiy9Q9N4NqO8yjEHYED+5Df03uMNMZHyeQkA5zivq2UEoC8bTe
 GW5+AM0lbFixm80A2VdzY+iCQwQdiskovHB5bowJ2x6mYeAh4FbZjRL+/CVEOs80NK+l
 WvHc78JgvSNnXBbEgOj2S43ohSJkWR8Ym8GvXMMw3Pnk+/1GIQ2OIZrKI+BjMgsbUgYO
 s4eeerrFFywKcpnQyqLPBDkFtDKC7wSm9JDGKy9gXs8dxKfGT9UxTgv+mCZ02TvZDd5C OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYH001682;
        Tue, 21 Jun 2022 20:47:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJJSEGxZZ0zfkoA8q+Wfghe+Eg7KkB7elNMT+3kQUfWIZLkzAZwfFK9suZS7lTynSW0wwU0Yuht+RxjDtjvgwnLcXuHXPvew8Fa273kmke8RocB3uSp+4SfZ579Fpx+7upvq5gZbI/CaVKdYH6l9KaKBBqZz1twG8tstqR+GqrCMHkZUJhsRzkkk3wRYxGQXKa2e0CFViKPeHMa5ZqhvsLXnjDmUZyat0eDT5oaujW2cMKpwkxpBokxNA9m0tsEv5VNI8vGXrhAMWo+ovE4CMO/+qHg5XbR34bkfyktNpOW3XJObuAOL8uMgES2w3RVts6jt8hV1tc0kgMVYLlnF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+Ejkqgjr8uRyorihVORLZNJCc6ei5EgI2IhY1JrOhA=;
 b=XWoEwgzBFec5g8m7vdIbVQ83CxW1qEN/FD+0KJYC3kwIjzN1dYvkbPSqEW1ni2FPsoKH3Km1xLakGWlEcUWXpwdDhPawh3Drvo1hHGtBsoiKKujUdQNHxb0Rv+QepcSCZwRF34gyYEpdwcia97NELd6ENGipJFS8sojyrGx8k727FeQxAr/YnzeD18W7Wj5pXxOB0Pa3LCve2BDSSnpLE4F2seiaXFfu3m53/q+t09dlMvU6/W/j8faMU12pqX7Jpz5J41rI1jfNliof2UxsuLJH3soWLJ7FtJmNzlHQFcnhHuWFYd6eMy4KKb3iRK5tW9d0BoGlIHkIzkwpC9fRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+Ejkqgjr8uRyorihVORLZNJCc6ei5EgI2IhY1JrOhA=;
 b=Sz4j37CrORjQ/0IqjCuzSaWF+8HTFewsZMWCorwN8DU1yGWfY2uHNZ68fwmp6z2zk/dN4ILQCYljd4zXf4VzcMUShe7n/lGmdPaATJrX5CkHZxYP0zOUtELyGqeQ76qYDj7K9AbXEAnrfPIPqeh6QZDBqFTRiQBlZXqM4A85n1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 45/69] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v10 45/69] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYhbASuP6V4xqT4E2mwt56IV1pDQ==
Date:   Tue, 21 Jun 2022 20:47:07 +0000
Message-ID: <20220621204632.3370049-46-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5be62190-3293-4234-53c1-08da53c74e94
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392E0194713FDAC7ADA248FFDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQGxmFondBLe73wSaXXTlhEjngpD2QcOtWyhFReYoAIh5CTrLbQZIHBFnbwz0pDoPcsFWoMZfWcZ6nra8Hygq2DDcptBBk4/FO92gG8xLa78YLiBSiWYQbn++oq3jS0N1Xa5BRieWBe7DlU2bHfMqGl8siaAiHVEI5oItXpIQ3lw/cZCe2vS727PwsS2ASrD8WM9HQ/8nN7Ra5wSgSm+CfnmF7ybzxQJYRKLZM6W/kyP57GPB7Ki4oEvuNNJhJTUx2KAgRA55heeiFw3WLLoRrS04qBtZDG0GG/dW4WsK6vtdXZgKkgQPfnOQ6yL8j9x7RGArcHVGWFk5K0UcFSMcCjUUHttSJ1ZY2BLdAnxByUO7Up9pZLQDRNn5FVIlC24IQSOjUDBQDHH9K72rDedq3jqNufsgjDBVa/1d9Fv8kMEaUPmbgCOUJqe0KTKqNBhy3pkTXxHY+KoN9MQxRcvBrKCAZ4KKiuon65p0towKAEu6NRNub+UAOR7H79UJL4gveefdNTji+/vMZQrjmxHt3dByBF4ib8L71NLGLIfYryp5p5tSF/N7D5mu4E7S+bodXrFvX+5OEF7sdBiCEoPd0nA0eomFQhcmnOdNIbmhEMZl2n20aC1r/Ii1mjyv+jF/jdpOEuCKrmw21hrrtJ4UED62eA+OtXiZTout/nOTQTVpgcc6N/djVnWh8GFg3kb2LqWJdCHiporCIoS+8y92OP9QPKC+ttVZDB3+P5GkTpg/gTHDqFm9KXJUMkyIu5bZ44DXxdJCjbBH2sKRsAiBmccJZUcVq/Tw7CQiIysOKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dYn3T1Ee7dk0p8DzNdeWdFuz8pcza0zBtWuDdSgc9N+iDOjbrSzBPhV72b?=
 =?iso-8859-1?Q?aXwtVH+vDUw9n4LWpZ8hAbAgC7kx4VWpwftvoXqvlsofl2viEYgAn3novD?=
 =?iso-8859-1?Q?7cY7ytwt3V0TjjGGAsh5WA0yfljCWKXuIvrKe6bhYjraBoK5f/1Pxhdst0?=
 =?iso-8859-1?Q?ZcMbVue8O4uVoypcsKSc3mDuyHFunvCcc25TUwXzTnBMYbLwV0rCN9aVpd?=
 =?iso-8859-1?Q?WzfSsaJ2JQaZVWWB0HEdq392GvHnjE5pjcrFX4SMRyqSl8deE7rVXPwyDr?=
 =?iso-8859-1?Q?MLofuxa7xKBCqa0Tr84thUknZe/OI/jwJBdU7ihCex6tIzXB5cCpEM2cTc?=
 =?iso-8859-1?Q?a7e3lOR+YX13/ECEawIOIQWqrprqNbAUh8fSWzqLhgDwjCi8Cj2twtgBMx?=
 =?iso-8859-1?Q?C6aOsA1Dkf2uguD8o+XgDufFw8PCs0Eir9CBp1zYp1RsAEtMMjNmobu3Y4?=
 =?iso-8859-1?Q?LMPthe5/E3jbqdLY8EaHUYIV94cbcC/b5hJmbQAv7kq8ZpcjccMlRGDS9d?=
 =?iso-8859-1?Q?Te61GDM3durhErg+UBo9xE1R+SAnRAKCOXtEQ0/akRyj6hxBLaXyRMP/3J?=
 =?iso-8859-1?Q?+Edt4tkx4xQJaBgp0ymOIMDg1rc2ZWE4rT4AWO+pBLLJIKrrlqcjBKjNl2?=
 =?iso-8859-1?Q?BL0wgBKI3JlfTT5CKrzrRt2eqX2p7i8tFBBlGQuGLCmnLpNc/1lD34JSab?=
 =?iso-8859-1?Q?hjM5NKSXbpeIAQpeSRbrLbqVONiTteyTCOOjcnqizQ3ko3/GkaoJHDtNz1?=
 =?iso-8859-1?Q?WdClPX8+Bn/r3EK5IQvkr9H4WurEb5VB6H1mRXhactMAViBsB8TogRPdHF?=
 =?iso-8859-1?Q?OGfFHg35d6ZY3Z1Bpz/JidoNu9zdyKQXMsM2bVCE4wHffBrYFZ74XiaUjK?=
 =?iso-8859-1?Q?vv2YpiE6aMWHQQNxI8IyZgeXZCDM7JoBtnLEVYrA5A97RKXsFo9Sj1Mhe1?=
 =?iso-8859-1?Q?cSD/pYnp+W1vLhGlbGvVvg15UOaOSJ+n/KiYk3YUm4YbF0kFl3asvT7C3/?=
 =?iso-8859-1?Q?G5iCYqz7x2pkdTk/0wnu7TEwQOat0BIRnovVarlhssDnlINPOU/DdYbjHa?=
 =?iso-8859-1?Q?x3leiTUwJbtlY7GWifHpeU4GbPMfR69TGAtcGbESgn1EhMyxQLio06aLqT?=
 =?iso-8859-1?Q?FmyP8kNoCaqOl6KK+SXijb64VVaz88F+I3u5nQTD5hH056BvuEIe62/92x?=
 =?iso-8859-1?Q?Y5uTL3XoVI38A7BkQYdAjPBQfWh7sXuAK5NghjtKDeknPXHE1mB19BDxmJ?=
 =?iso-8859-1?Q?MjDxYm9uXSTOBoCVNz9JbrxMrGfLfia2qlcM7as9FhFJy4IcAwU9JDHOEE?=
 =?iso-8859-1?Q?b8m4U6dJA5f/GT/8eAaJVfkoxlxjPurACxN5FU4tTlayAmxwvGfjVACMpX?=
 =?iso-8859-1?Q?RcaPFLlK4LXvTiF336ZdVTcIBlIpfaGOBxlPMsFvIoJ89QFZe0Yg/GtOOE?=
 =?iso-8859-1?Q?BmFVmTAINNN+J2GgmaUJ9R7aSTdEx5ThVEu6dtFSLlf7AjA2cFmOpWoPx3?=
 =?iso-8859-1?Q?RN5ppNITT+Fyy86Ye+O1USLYyd67ePZf1HBuUEwK5FdL8jYO0wO54aBlIR?=
 =?iso-8859-1?Q?UI1Hfy+aAN0DPUgGycN9ptq/2dg7b8L8KXb4Z4xcOlMMG9YSLlAZ84zgsB?=
 =?iso-8859-1?Q?6SIhfoqgwsnwFbMKAf0Bo6NaCJ68vQTpAPXbqBM95sEoGD1PUXXvaIajtq?=
 =?iso-8859-1?Q?cuHGTssm10DQ6pzaLb6AlVcFFpVIAjRjetjdZqLAkJT7sKt76o48XvQkTE?=
 =?iso-8859-1?Q?03HvfN2Y9/QsFrkz/wakgJ6tJ3zHit5D4iRogb1mx2lGr2GCT5BlJUEVPe?=
 =?iso-8859-1?Q?D0L9dQwJgRv4d5dejKq1V7pDlY2dDgI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be62190-3293-4234-53c1-08da53c74e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:07.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4E8SBKg4vD62pYQBMVwISqmZUagwBg1/r6fcKeTt3fI40OI6+Ld7ktkta2MepOA++1UKicvKcwswINaYFBI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: ukqoDQKEKahJaaUNcjQdfbmjZ5p2c1Wt
X-Proofpoint-GUID: ukqoDQKEKahJaaUNcjQdfbmjZ5p2c1Wt
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

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Link: https://lkml.kernel.org/r/20220504011345.662299-30-Liam.Howlett@oracl=
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
