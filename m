Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AC57ADB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiGTCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiGTCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA661D8D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1CrvS015098;
        Wed, 20 Jul 2022 02:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=p58NuhJ9HZq52mzdb8xzOnwxZANNB9xp4iVac9WtrOE1djvqt0pYODHib6RHJCjE6AgZ
 tPegbANB6aFuQOnSVAjj7I99gDH4cpnQhWyjZL1IUmFjQHAbsDlxoFTcKkIBhcyOLpyS
 XP3rk15mGbOnWi4jj8UTQTWhVSVgRGbBKcxevBb/B+Qu6kp1mHtm/uNh++qxy5dVRBeD
 FSEThsa3B+DMQ1WVnw78grKk2IB6ua2lzU9/V0GmMfL5lpPkYITtgZCTtJryBx44A4qo
 TG9dNZJfl2lvuuTt3tzmp1lSB7sED7BB8+lP+HyHNQHd4fwg7pxhMBW9UhVPsOdsIUaN tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g545-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL6022321;
        Wed, 20 Jul 2022 02:17:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK0WcbdtwkSVxAluHTbZow5kS+xDctrHc+ZME+RN1vf5DZEIEipMbKFYfPtAl88iK/nLgXTbsCHGpeLnqfF8ZwO/y3LCxmpH2Utjf3cgSz8l8U0829Qbecn+lwSkexWkaQ2igVywJWHAJ3XSp7HIK0xbV7rYvWrX76NfY517lXxVXZtjHuHgLrCzA7WMdt9q3LfTL3jpOAU5M2bNmB5acb+wwsE0vOrOmlcdz/44BHNE5F5/FWcM4kTmqRHc9YavKXKwj6n4sFenLWFlDrqU/SfDFYf0P3Hz4Q4J/DCxKQqXWLoxu0FrVo9tiHAqf7S2723R3n3IYZwtz6WkokeZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=jIvr9OW+nSI6svNdw5Yqy9kHST+U54o3gXZhaWV4CMu+aau31Df+M2Ls9KqBpRbH5pKhri21+gx1RWRy+5TPllI7emFlJXdSzU+NmTc8KSFmsHQeMsIGvxB/KO9qhrVY8o900tciUJGl/6Ye1iqwi4U+5jpQVVXSOMJfumIrC9TId8JWD/eQ3vaIrssiArNY4DuWDqRxZxCtxkmnl+J9ewbqXo7/jaDIHBQOE6rnwixhI089g52NiKd5J4gssCNXMpA+xVV1FladYTPLwSKzYXLgHMXuVlI3+chjtS2JH8QCMWhIZM7EhMQRufGGqfRz2Ms3Te8G89hAv6F1BxieXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHFj+u3IKwyE6aKTogfed8wCvwRJHUMoTzGouUTk5hs=;
 b=LL9zZ/VkyBk4QraQ9rxZ0hPkSwAXY6k3vteqaHtNfjw3MVSvknIKb578vQfwrIIBDe7UaBIFJrUwpBrl5WJN0HDLWWCOpIU++FdR+Nx5VzC03zgR5zhBY3B326XWio9TFzQBJ1l6vAcdrloLRVdXV2TJ8a3g+NjUqTL4SAQpxHk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v12 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYm97oMSPMUJ3Nw0mCLfaBmQrohg==
Date:   Wed, 20 Jul 2022 02:17:49 +0000
Message-ID: <20220720021727.17018-20-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec218055-d659-4bb2-4cfc-08da69f60d5c
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Pa7zLQ4LwqvBp66taLgAIeM6wip+oMjL+tjYtOm9y18BwwzJhkeu66R6Ptmene/9zNOo2K90Oh/Rodf7ww3QS7AnD/y4WC/0uuuPaWe0Le/B1N4cLdizybEnvhZNxiMkQ4IsfUxdtoR1xXCH0QDJv6Xmc5Lg4rgdyV5aXAuXIKqRxN+OoEiAHdj6gFCD43thDAW/jSzsXVA7zSt7yePprgsMtkssdhGxKAjIEO7BkCer/CvxJX9sWZOYqOc60VJdKFv+zJ640h/JfiKAEeL9qKP+prIGRIQ+AC8MG4myhgZMsosZf3Stxt3h2M72trtiWbe5MxoZNksoUj/jkdRkFuP86t4BjG5TOg+5q3allPllvElMhzhdx+spWMsEuhEJhl81pds7rx8WIgMO1bo+av1+LqUAVWcphLjgXeLPOU7Jjt4bGvAUSB1pE32gUMRBS+F9WM7/yyuCeErPWuTUV05UVIGvjJFvEYuuCYexHeHA+vA4OJrnVyFaFBWzeprG3naCwIdU533tlpw/fJMupbGgTfRK3yF0LxqfQZB2TbTCXBpaHz0j3/MJyQ8tsnLmKpJeVp4KQc5ZPEnJgMsbs1AG7H6wF0nlzdiXOSHYX5/3kl91SdAVYvX95Y0aYBE4Yu2iiZlMo7mC/hPRRq12MYXf6ZgJbcHXtDtwevpLjD+mZYF0gNtzhCGRbiRygrUbW17dLoNQwucYDHrHsWQJtlKWi1x8SPa77l6bQISobQkj+8PKHsxgA1urOC9Gcrff+bZ2xRyuaKH/abMoYetvnyXW1cjv8poMKIvxHYq1qAzU/Z2kyJ4Tenbrp+hBWPGSeEG/Wu2j43DzwUVO6d/IL6K9Ax/mqDKMvQLnbjf5EKbqZnqdCho0XlT1mP7mLRf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AX0VTNexlGdAfCpvqlo2ksMNrBaQto2eYOn1uv9mWozZXzoQC6obMm9bph?=
 =?iso-8859-1?Q?rVM2JtRf3QFuL9WVhizDl83UpyMnIv6gQcOrSI38r3ezqvvwhH+VcXCKJy?=
 =?iso-8859-1?Q?LKRUN0gymOcKOFVQFpIsOOIlIezz8qw7P8dBBCeLJ6LJB0c2nvquWcBv9a?=
 =?iso-8859-1?Q?yBbQjKgMyEmtsNCEqmA+AIaEQGt04asEIxkKRsk/H1YMOaS4wrI2cj33On?=
 =?iso-8859-1?Q?D7uTypThTYECzMvkFwzmRK0M36uHZwsJGwlNvGhG1B9cLwLYmQrt8sEu6T?=
 =?iso-8859-1?Q?DzJ66QW33YELNKY4JQPzCueTvjJcaZZXucXu8siviA6Xucj/6rNf8WGnHb?=
 =?iso-8859-1?Q?zqjbEGvzOrI6eJOpIooR/GxSm7XlZDYjnUPSqwgahLRIOasMuGqQRzJ1AJ?=
 =?iso-8859-1?Q?qmq6ShoeydDFFHyPJtfk9TP4IhhRtdbxTGathkX+GdrLiDQgrKaiyYdd4+?=
 =?iso-8859-1?Q?eiZsg3eDFLtgIuUotZsrhcvO5xVtExGIgIJ16q8pfAgPssOSYn5vHQAC1D?=
 =?iso-8859-1?Q?BJ46GdaKHP2/QH5+scK16x6U2uuveEthxN/ma0JAwaTtJEfxhJCBPKeLBa?=
 =?iso-8859-1?Q?a9hDiuf54nXUfE/l5FY2yleMQ3qp1cGqPf2Eun7gmxQx7QS7vqPurfF/hZ?=
 =?iso-8859-1?Q?OvRos9mcYbLeqFbabGHv2iWIcu7XT50gVsJUeF0BxnOt7jG5n4bzE1x/Uy?=
 =?iso-8859-1?Q?nsCRxFzQLHwVNYETopK9+LudKKEUAqyQXiqnP6BfP+nTRSA2RS8uvPogZo?=
 =?iso-8859-1?Q?uPudWX+10Ge14RMqNZlSaILQDYmtunhBHelhNnGqabOaURKf3YGYsotnQs?=
 =?iso-8859-1?Q?diBrIkmP3UjlpfCB5M7nbKcvZxqvGf9ogb1YKTergXDyemYcHsAcykD3Z0?=
 =?iso-8859-1?Q?woLa6iRbJdgoSgnIh4j0SAdN7V7KybGnOutrMFUOkMgRdxR1m/w0+1+hTn?=
 =?iso-8859-1?Q?e+ztM8WyLWekWICVshzB/t0n0ZU56Nm72fd+4yJh3JkH+jeuI6uSop/Ebp?=
 =?iso-8859-1?Q?A6ox7LwYG4YLUj0Q2igLVIynWwa2YN3v00NlAesRIi3McR1Mm7sgjQuS0m?=
 =?iso-8859-1?Q?EP57ngBXi0p0PZ0oBedPtcUfd190R3RJplHABet9Y2/Ay46HwncnlOtaQT?=
 =?iso-8859-1?Q?WuLGqjYHHzLcZsEJnN4+igAbQ2h/21k92SsKTMs09IUrfiMMJpPeJlGs20?=
 =?iso-8859-1?Q?Mjni8A3ay0TtAcqcEG6EuBV4tV5FS/V3lCqvSSJHZvX9c0gn7I8AgQqiqr?=
 =?iso-8859-1?Q?3ku8y678I7wZuj6sM+9wzaNoS+OQWmT/tINSFCZd98iq62CigNKExAMSbP?=
 =?iso-8859-1?Q?Ni9xtqfk4AeCtMpcllLWjwZ8725HqDTCWiPUI3mxAaV54IZD8VlA3FJmSL?=
 =?iso-8859-1?Q?mPeZd/6TFjwL6IjUqUCRUBkxDAWTV7kNWHuxLsCtihociKt1cP3GbGxUs/?=
 =?iso-8859-1?Q?b6yhJLYnHL+6elSOHyE4oWqAiok4C/5aAugq9gMaGlQkgIS5NrBN1g2+yg?=
 =?iso-8859-1?Q?HfYKaHEMh2A72jLU7jV+lbf+QnLaOsjDWUGrErKVZLtCrOxoTSdC1GcOJS?=
 =?iso-8859-1?Q?L4CpE9VstQdPxifLOvSytPAqn9uoadGKSLnYrr3l/AJmnm1VIz3Z56AGIp?=
 =?iso-8859-1?Q?kcAkons8xcp9fDce1moVKa3zQy9+uhJa4+AsVBQJn3qfI6cFxxKbzSvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec218055-d659-4bb2-4cfc-08da69f60d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:49.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKeBB5g9aqpHQTmKFrJddW186fC1sO9VswdDvy0O4kehmrpfr9OkMVaF0+C1/43QF+mSndKDZxdkoiM5F/tZtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: YF5GyMKrRgQsBW6TgvTFlwO29HWsbdEN
X-Proofpoint-GUID: YF5GyMKrRgQsBW6TgvTFlwO29HWsbdEN
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

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Link: https://lkml.kernel.org/r/20220504011345.662299-4-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-20-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
