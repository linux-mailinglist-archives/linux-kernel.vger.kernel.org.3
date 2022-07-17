Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97A577374
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiGQCus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiGQCtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9321802
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8glX009607;
        Sun, 17 Jul 2022 02:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=rLCmVHmAdYjyFxJSZHvIlvPXiTnN54Kjvr0R4zU0jxek6p0VZg4er44mikGYQ/k1ElVc
 DF8IolQUG++9QdCSaKBZpxL+3Tpi4GXQrzkCYKuh3pPtv4+skJerU6ECOjSdIC0E++mP
 bdHTrRSc3PKQujaHksjwI1M0Qkl1YNqdZHAch0FT2G3DIn0hpW3E0zVgY6vBNF2gSTkx
 nNaFPmKgQ269fg1EVTGW60dNlKuC1eqZijtzAhhJKOED6ebmU67bHaH1tmVUeR+zWuZx
 7PG7DevsQguPz7krJfgeEso431wXFRRgTbhJQJxT2S3h9X84mqi7qphQbMrmvzkyGnMG 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIST036113;
        Sun, 17 Jul 2022 02:47:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC8oORE9voPtFpiDvU36AQkCopRUCE7DmrahaKHAFrF6N3atsQbKy0mPtRFC0KFLRer0qQ789cNbQzLjiQVPfA0KvJORK2WmwbFI6G2fIRYkAnQ2wxdDW6pQQp4WCOS0LjSZQLpOJNfvEIRSe7RD5kVhrg8LdnIAP1waqAW4/AQ54qnF6gvGLZGzpn7P0CIIQ1ICkfG5sCFbxK9TC0HziTjSe7ibVsDagk3vUiZDf/Ql6qJMyfQxIphnnJ66DM36jwHuh3NmnGcDteBOgnzgW5hNNiN5px8ygrV14ifujFq91Lw6/qUUSPQklRUOUmAPEEhvLfv7BhYgR0mB9F4dgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=UOTQr2ikWKorTqd6LzfYsTYzNFwVdaWe7gzP0XbNQXGBq5E+j8TLAm1u6B+5WQh0pT/7jdn7lC0/logICqJWemMciTIl3shtlTsADYH5umIB6TrWQSJwF4pKCx0K90JknRRWCnhT+c72zdLP3sz6V9o1BlP2q0CCnA/JakBCf+M/53kesEi/+va5aA8yUYCHIS/k1mHbcs40rWPe0/kBpebJ/GF3jYkyMjk+wwwQAkCVdM9fgRHzeL5i2PCSNhvyDhMQeOTOzs3UdTNQzShew/8/lT9zcnVVN3DB2fx+tgs0Q82p2/KJNgFO1kP926vtmEaX68zgG/WZvDfE2SgLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=uk/dUE75je3dOxmO/pua4kgksYasRrvZSGC6R5YVFDJKv1BW+Xp/zWt823OsiTjhW7naq0clhySSNGqhxYMS+d5bgB6hXLAusCJVLvMYpptFrQpGs9NOFJAev185e0J7RdulrcSi9SbcfkMkMNUk5etSHdhogEixQ7Omqv5KwMI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 46/69] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v11 46/69] acct: use VMA iterator instead of linked list
Thread-Index: AQHYmYd4gmBn0AwVuUqS9aAZQjbPrA==
Date:   Sun, 17 Jul 2022 02:46:52 +0000
Message-ID: <20220717024615.2106835-47-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c3f8a78-2238-4edd-2e36-08da679eb09f
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kv++dELoZiI64fPGxAYhBtWLqS4n/lBzRx1XwsW7Q1bYyD6poLGCTF3jCPyEsa7SAVE2TewWDAa4nw7fy8fqMB314Z+FKO7RJyZ172T2C01DMajPZcROaXwbEFp92iRXVUl1lQz/ma75fkfQEXw4aFR+7lLK8gmGr2UeltLRvWS9qd4WWvTP86pxAF+KbamyCWpuJAPlu0gtJpca6JtPqHi7hZ1NHIr0+QAYIHOlWPu7Ixoi3p0ss7XzgJzMdTNsI3iTNTi1ZKyfiEKh8oz0vZMAGd5NLKjMuJzv+POcHGXbOnkgcHeZhUE7aWj+r2w6GMJiBl2pXkJMY19DldMoeKjUQHOQ3AtHQ3HXXJNnz96givo0w7vaukaMRFuabOhWYWKSoo0lJg500a1xJBTLbJaQGD8l3Bx0xD14ICF6zBrqLCngKJJsL8VJ0JjQIsNgJUzhHbEdIRccvTSmO2hqnFnFikToYD9ivsNYDz+hWGBZu5DlVy8inIpKezGHB2ARS0ZQYJ90EoQF7NfZbteF5RzuxY7rzlfgvEjSWAlVchrIrlM6jIV0NwZrdyiSCZ7FZfU+KYt3CU29inOnTB0JnUDPc5jK6W1JZ8DUdnCPLXBgtQuiWpOrVjdQmQjlZ3nvCtFM25tROaj6kkq9LU/m/x+kgAWVnujSN8hOABbfbUttytHtu9ScSW2oYL2rpsvtM5399hixyisFFGJHwstx+yPB28UwS4XJxqnCUHY18xv9PASlqw38im82EOnfMOtvWBiv/h9tHhhGJVuak/aNSPPbFcZHjVkEHEB86XJyXg0F0cK0OPLLI4isqEvcc6DSGSi6fIbvbgZVZmasNQGBoDKHOM8OYjrUi6PkxZ6I++86WGm8W0TgmpjU4O5zWcCq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SafM488FpLLM3nREN34mt89mBcfbzKlIXwDrQsrff9Ni8Rkt+VPgCLWWe6?=
 =?iso-8859-1?Q?FWN+xihiXGTY5u0vpwgxSGpfxbh9fQ7UD0pKw79TGzb9+pxeB/o/9HwVta?=
 =?iso-8859-1?Q?A6B1VNivnUJVj9UsMzMgasFwJM3GLhd0mGo+9ZeP4AQWQLvswuzdurh+wg?=
 =?iso-8859-1?Q?JUojbB1HuD4XlDF+X3xnKVAXzbzAbJHhgekhHzNVLcu6Cv1aiUM54CVo0B?=
 =?iso-8859-1?Q?tHjXxE3hv0+98JTmNvxffJ8ZmtpqtLDjpDlSt1rw7fra+92GdP/R9+fAhg?=
 =?iso-8859-1?Q?tTugm8xdLfPwppG7HevEFW25LSrAz6eU9N3v7PoE23Cootnb9amSKTKOvY?=
 =?iso-8859-1?Q?Syj7eKm7ygUMyG0rT+yK0+TeBuw92Ts5OxYM6+5AFiNoSTMohv9Ohbw72h?=
 =?iso-8859-1?Q?wZQSNB/gS6mUwuma9K1K9ow3qIrJk7sWwSmXrh/xKFig0f4E7z2y+Li8I8?=
 =?iso-8859-1?Q?bbpML2eBGksFvtA6Q4BKXtGJRBIP+vZnF5cY8Ak8xUxdnUcEssx48UqrHZ?=
 =?iso-8859-1?Q?BtJsmYRmoc6Q2aPqRHYOaJZbN6nHl6qQvkoBtPtGSbJZ8HidULy3dOKzIe?=
 =?iso-8859-1?Q?JENINPfX9LNuYvPPpFuofJg1ysnwM49U+2XDqq99hpvq1fvO0qw7osObEW?=
 =?iso-8859-1?Q?C1HM07M4gzwHu66ySe2zeSlXIbDmq1xF7PeBdDarmLCyhfXUvFNZYKuXbz?=
 =?iso-8859-1?Q?hothLAHyrQij3Vz/TjI1K0iXKXw5lla9T0REc7QUS75aWaWa1zUW6E1a/C?=
 =?iso-8859-1?Q?BbwqKpFrBHc3WK+xa7FWYOEAQXTmMs4oTvThgIppE8zd7OlA5tIWnDmuPR?=
 =?iso-8859-1?Q?jOX3z8H0icfu+pHxXUWNjXxwei0ASl5elDg1h9zkmwbLs45PVwFbYjNm0/?=
 =?iso-8859-1?Q?8yOLgOVbU0MewzThcb03VoPPktgujsV3Pu/Zn7xNNChTlAVWb6x3H/F1aZ?=
 =?iso-8859-1?Q?gtyMgUvAG1MZ9c6B4lJxGcC0Jw9cHJ+Xmw4Zdtl86n7ycu/EV3gF7/WmEu?=
 =?iso-8859-1?Q?c8f08CJ1LMVb+BFqXjhm/IKXK9VQ5lyYzZs3VkVdctAOPSArosg2h+OIY5?=
 =?iso-8859-1?Q?P8/ieoN8mDLQve52gUkajsguV8qjPVEDupl50WdRPeNXDMxzu/EqAaazHc?=
 =?iso-8859-1?Q?OBRn2sK48Qc2b32oF9BIGOR/9DdwYPGDBaJ/UkfTatYefNCg+2cKYIoA/I?=
 =?iso-8859-1?Q?ccWMUBiS59xxxtkzWIkNVXyw1Imolf091sZfksbjhQ8Y8cbmvqieBsiTce?=
 =?iso-8859-1?Q?3wLCABqmq+TT69XMLmSucCr9BiC6SUTR8K7e0KBa9kbElyTUKY6RG2340p?=
 =?iso-8859-1?Q?BuzZGNBW7NFg3NgkJgsyO8Uh1XZArXXEbqCAYUwmhC/Z3s1qsLiyTt4abf?=
 =?iso-8859-1?Q?HwT8cwHzbJQrkYw2FP7eKFmYMjY8V5nA4/PhCIb5ngamH2Ppi4rm0sbbr2?=
 =?iso-8859-1?Q?1zuf45n7HsA2GFQ7MnAlYkxlppKubdmgqZbI0Ajj1YEsSl9MejV2tccR/T?=
 =?iso-8859-1?Q?hnh0zdIEbT9b/Qdl1KHyq7ed8mIujmH1z2aTNbxtAwc7PkqSc/XD5GelLF?=
 =?iso-8859-1?Q?LSad9lW8U05OH7B3CHA17Ha8Wp6vljJg5j+c4Rp3uZfciS4g9YBf1MfICc?=
 =?iso-8859-1?Q?uc9rPYQJfFxTNQiUt10cEN7bclKT8iAwmPbUO2BIkVzZ9JPgph2SqQ8w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3f8a78-2238-4edd-2e36-08da679eb09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:52.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McaXO2k7+C3EH1nTT7FnAENZMICr+KNsdN+cnhuknwDsiJnKN2AlkNcTFFogUU5FPPFFhTfoKJVdeAEvj3Fn1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: SWuPzP10CciAeeZ8pIyZjasYHVJs3X8O
X-Proofpoint-ORIG-GUID: SWuPzP10CciAeeZ8pIyZjasYHVJs3X8O
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

The VMA iterator is faster than the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-31-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-47-Liam.Howlett@orac=
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
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 13706356ec54..62200d799b9b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -555,15 +555,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
