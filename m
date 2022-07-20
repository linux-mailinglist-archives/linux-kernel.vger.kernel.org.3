Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E57ADE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiGTCXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbiGTCW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BB6F7CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Ktu6002392;
        Wed, 20 Jul 2022 02:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=wAQrMbQevOL3NJkMB75VJ2VP2FJNLT3raFJLLOBSK/jz8a0FXHvgfXdIFXOUfoDCeAVl
 XJd6IIWEi+MkBrqZlJoOt07BntPgGgF55aQTwyvhvdinP6l/AKTaPIyz4+R5yhX/s+wn
 C6Bhh9w9r+6X6oPNCtqWdOZ2oei0IseK99thSihCz+1phlFAYmfpI1u1O0qSi79OA9g/
 ZOXndRaajxAgVP8y6nVmVY7ZsvEBIKc84me/D4nM3kOcNVuJbl9zp1LGhIjNCZ5fNjCk
 WJ0sm2SYUTqjGGGbXysNTMBZvOQHRI25ebdESWf0aTxwL21MpqUxdKN5xqycYldkSSeB Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMm039258;
        Wed, 20 Jul 2022 02:18:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hASlCdsh7fTBBbgr5Vq9TD5Qca1R0kH6G673BXuVFWJIWmzqA+3OvB5ZkBLDW5mWNrtMK6/Um33pXJT4YdXyuEEPe/JwpoIQQNZ0cPWJtVbwF+Ln+YMBE1rF+IiCUhOH5Voex3dKEJW2Viuc+MujtpdHzd7G8eta/WUvISHcvNMi3jjBbCbJJbMNiGqkkesI/99LAGN729oUal2p29iO886j+60aKfCZ/VPttbYzDlQbBUaQsIMWQYTmP9EwCfb0EXz/hrEOXUgxhltryppIam+lonSmfa39FEten7LbI7+UhE7r2EfKE/SSZFL/jXs/0FTB4+Hxt3f4e1FJPqpQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=YO6t09G9wxKRl5p80PaxiFFw71CMQowcQ0fqNbTzrHs6pxPZlNehds1jmYSehqtUA3DNvDlfIkGUesfLv7Q1bNpsS0bI/WVk339l16ZtaGjtxgz+PaXW3hDSkGaIOquLOepGiOWCBgQJf1NHwZb7PPhy0yghtNSLimYCpLMhnAh6lFxTnKY8sjNMpwyoRKdJv9PwpGkCk0nfIPCUt4DnSGEo/lnYbpKcb04UPc5Rrz8U/vpCS2Jw3i3Dx5+zdeTq7ZKt6jfzCJtDU2VvJIq6YXCb3H7mHgQlt7PiouPRpNkEGUpZ8hlgB1ujZZ+EvVeQBRxPJiOBMqFZNv28JtYDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=KBAaoGyqAUlqwiat1diBn6IHXGCYEIXFL5kM0p3NG/beUzvr5BfyzWO0Yfrll56Odr4bK2IMKm1YgBUl64uFiOiWxs6bNezginvU2vZxJnTQAY+ytKFJhoXeDfkBdecCcEuZDhc4YE6oPlzSrlyer6p78WzfL3vzPZMGXaiqMyE=
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
Subject: [PATCH v12 51/69] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v12 51/69] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYm97u9I1w7jGCLUqVc5A93L6SEg==
Date:   Wed, 20 Jul 2022 02:17:59 +0000
Message-ID: <20220720021727.17018-52-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1a9e0a0-5a0c-4114-fb2e-08da69f62931
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBBXrNF+hqB3G113F4fgKsijEQFeqSOqt9LXaGMIPN4b/chuIHkI6Ng8BXWkDmoNWTeKVu2WaGQJPc4rtefM0YSR4sxM+38di68lrZd4t1B43+4Z2BbtSv3qcvps9mH62MqpNrnhO8+x1B5lE8XXQT4+J7qqAdmDnfa9fG8VxkTfdubIByWaikVwcAHxUyrEIEeQ9dMLolGTJR90P8z2s2p2moQlyUzPPqR4IGhu4yDI09MfFc0xD8ZkTEzxIz3eDW1Uu4aQOG62zD/UC8lHu5GFWmxbWqWXZqFP6mIve1dd6gaj4siEHKuQ30Yw7SxKXj5r6a+INbChQ+8qvFrJ8Kz+VJe850Wkk/pORx6P1sYeXdB4om7KZu3uO65PUQ37GoBTew33z0J2fNTv02ZMCYpCV2Cmj7DCtU/qFKfiaM93KGo2NiBCwD3GyFxmFfzfpJ2JM4vDHerGcT5IlDuM5e8lmyw9D7QjN2Ol8E0Ve5lvYK/Vv7vfITo+H6Lh7pbJybQY0PoicK0IQnO/Qb6ABZVy1cViyWANgPMzS/IKJUTPnIYrX1oyvwATeaMpB1OSOZHRcWs7xu0b9Lxo20RDeC7nICK3Ls072YRoV8HMlPGmHzWYXScKzaYCzzfgimfSe+wfQ0+rf7Tu0obydIGQimZtUR7luoUwt8MBVqjzXq66Nayo/3NE7am9EuBKqTTo77i1XtY2VHYnzn8OFVuLVkRX+0KUDR6ugM2OeubTFALYLuwv9mFNO2I5QdZxrrkYNqnyRRSi5iOKgBl9Xb4FigbV11n7t7cZfH/7Ksc5OHMHL+ogv30WnrDT5sCtMGfZJNqBgBoxy6Y3IA7MV4yHJSh2+zbvwwzb0wxUUEgvLxp+pRo/nbjYIdO45qldQ165
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dKjtFjYeG+6kN8eJSQ0OyfGX1NCLIEDNcC9rFK1J5OeRwFoDDUh7HSR28w?=
 =?iso-8859-1?Q?FoEyfUTZhVP7stW+87jqWLb7YUsVRnHiWKGGlkNaX1LOHQa5gr16ufdBVh?=
 =?iso-8859-1?Q?Xuigjj1srZDdiuisQAlNCSepOfDwoNQHiMxMyppTp8hRFKJYm1Y8Dk8vzi?=
 =?iso-8859-1?Q?tb4s67Im9BnE9njoiVM/9nWt8xoJKzNui4uzoLqHx2/F6Rn4dHwnmfJFiX?=
 =?iso-8859-1?Q?XLvprA5E+bVUGjPOsNQElaxanzRo+ADhXJqK6U0/l4JdtgMP9ZmjrlI24T?=
 =?iso-8859-1?Q?6zCIzRHJJ7bwWIEf99/AyI9W67WYQgj7iESEl16XjGJfdeNCEju8EUb/Vf?=
 =?iso-8859-1?Q?LeBv4MfuDjBnxOi6FZZ3QJVKrsWzZa55LVVAtkKFhUlMy3YK61A7Z3DtmD?=
 =?iso-8859-1?Q?qIa6ULnOwlyIdpJqNOr9QZY3Yh1+gMG75thfzGDg7HJSZiHUWvEUgHxA4n?=
 =?iso-8859-1?Q?349J0A3CwZ3OBol06Pqmbvy0szMwIEsVrDB0oC2Sag+TqRwnfLA1gteUup?=
 =?iso-8859-1?Q?KNujEw4ITJHf/u2NyiGJSbKxaToBULA0nrwptXtaOkRzLGY5Ll1lHRTnkS?=
 =?iso-8859-1?Q?TWy5BtU+znIDBda4uWwaIgT5GD2EHc7szwPjFD+aQMElliqSroS2m29v9d?=
 =?iso-8859-1?Q?ShAFU7ZiAmntK9QkNvyEMLcHDrirbkhdixFQ5tgPv+oqlZmrov+Gw2QSs1?=
 =?iso-8859-1?Q?qV2mEl76ptmxKNG0JBDgjdRYdy7HzlmduheeLRymslPzWK+L93II2nQuH4?=
 =?iso-8859-1?Q?HhsfZztkUd4PFmnz+AlxpTwHJagQ3P530FMTbtBzBERODY9lwIBdLyA6Rr?=
 =?iso-8859-1?Q?JpAtbWdbJkSOfs1JkL4i0iG3mbkOuM+M2tx+jGlWE5VRqrgcMyYDXJ4540?=
 =?iso-8859-1?Q?LaHZSPJdJr0/HSQXy6xVaPZdfKmWPq3oxal5FgHaY2VdeUa3wmimRfkt1c?=
 =?iso-8859-1?Q?ED0QE7CuRfMO+88walqXNgGMNbE4Ml8dCpDkhMNFIE9Pn6qTPXPeLHQFXs?=
 =?iso-8859-1?Q?cbeiEN6ODWieToZdDoiujelxKZLx6VX5UcIBySG1sj+wiscMgLqqcWkcfg?=
 =?iso-8859-1?Q?/cKM0gVT9BNESJVuAD/h5mibHPtA3dLbUBfypXdu5CBnjDAglXSSk8QVOD?=
 =?iso-8859-1?Q?jPHOBtkEE4ohL533dALY+1r0ijogR9uF/5U34l77skVv8JAKRU4KLnNOEc?=
 =?iso-8859-1?Q?T/IMqpvFn6fXNIYir51ReQyx7b8548Kfp/Y4QpXFfAG3XH6ieGitKtcsAu?=
 =?iso-8859-1?Q?pOWWlPu+vkUxKlKW4fm87utIJ5Gip8DfDOUzw1mHdET62eWEi4R6P+PZKv?=
 =?iso-8859-1?Q?YkzsHw79nnXBI4OHksgmmKphD+UgphYMKGoMxMUhPF+xaRHMRFY+fspu96?=
 =?iso-8859-1?Q?FQFtJ9U4n6NHsxkr/vD1rHq3mlrVGYRcpGM12l8hbRVOe6/DZ+OHT0sRX1?=
 =?iso-8859-1?Q?X7P9Y4IsKGVzu9O79njS6EufxXPpBIt0iLl5nPfQqRMntXZny+O11YwGn4?=
 =?iso-8859-1?Q?SZqaUNew/mPU+Hsu6NwncKz1VnlmqN7+W4DQ8a6GXvT57OgC/nwd0eVg7m?=
 =?iso-8859-1?Q?ePFpqK+tPp0a6wgFMv9HaVO73YDQ8B31hFJZydRE8RXoA6ydGTI5pEdd64?=
 =?iso-8859-1?Q?p8t69o4OK51UErT0X1PPg0EBYP836kOAmXV4ODYcvHidAvdJ5NQaJ1+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a9e0a0-5a0c-4114-fb2e-08da69f62931
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:59.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7PQLc/r6LyE8AVRvxsROZ9S5VFodPqI9ZsEdFWBvGUSt89X+/a08A0v+M1feCOKF1/H1NNrNrAuQ+7isd7KWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: USVKRtC4n2J5rXFKJ5xkNnsj243_JKca
X-Proofpoint-GUID: USVKRtC4n2J5rXFKJ5xkNnsj243_JKca
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

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-36-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-52-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 407a81d5ca03..f0e5d68ea932 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1641,10 +1641,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.35.1
