Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0454D032
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiFORlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbiFORlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:41:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295253C7F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:41:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXi60005235;
        Wed, 15 Jun 2022 17:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=2gQv0Hd9LOGosE9l2qWzX9RvO5y0C348nL1ga7X3DL8=;
 b=zFDclcorPINC5lMATt08zjVA6ovXs4oE4FuOmyxvcjB8HSUpnTv/eY0MMlPxVa+iqwzv
 VLUnJZvL/rMQ0QALBB95Lr5wzJ72JEcoJpA6B/r7Cj/SSqYSqZ8a2lerAp33o4MZg5D9
 Z0jf/Vk3witaYuvqlMSIf6bCbSsz34+sroEPUeG7D/JmlT9HdL94Px2jpddOsx/K9836
 UNq/kWrS0aG45EQINMGibmXEp5fU3kPTVlYIMoFbsVsH36/ytn8yG2krTLSzMv1CPsKu
 mLSy7k4G66CNpkgpnz8nRDIpsXjvAEGtCePmRE6d7zP9mXQiGz7puDP/9+XIxub5FViH yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns97s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:41:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FHFaYQ028074;
        Wed, 15 Jun 2022 17:41:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwb7v4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCvMe6TtfaRsfUm93eKe3CS7GmGHgPmtCTs7o+rH2XTaieVSmVuZour1ZlnMEn25qIweDma+OzjHQC22sFBULQl/8rw9LqGqwpuaDZ5moNyyqbujRyy2w9ECE4hBhv6yUQSnv3EcuHmCY9nfetVcFfvNLM5BMUvjiCIzx1f07HDQCiy5sTHvMXLOlrZ4cUAqxjLIuoG9XoFOGXOT6tj2fqM6OwgWEw6JbLS15nYaSsNc5DJsxE0eFq8aYreAdoGuX+DOosLiiwqT/SdwP4PFPsBlMxL48t70NzvyZlcrp6bVRD43ACccs32emjR1A3HJPSLNPCwQyLVNZhAnnvlrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gQv0Hd9LOGosE9l2qWzX9RvO5y0C348nL1ga7X3DL8=;
 b=cvyBs7M/g1AltGifZaiB7jIrH42XwGL3q9rfHsCqXmNqyEO/2u05oP+lrv6aNdWcxsN50sTLDrLKOlr79Hrgw/EAItmmxoh+Q3kXE++I0pN9p+bm30KarbOl2GkLhj1x+YXMsQ2OB7DFn1rXvU+ETxZHr33buT4v6sWW6rS/tfH70zA/O7OCkg5fSQlSnFKwg7WATNlvsGPSukpa9tiTfVftAsBpAoIUVzyoPgpRRuyd7snF9V0uEL25WXW+IVz3LrFvgXjYLVlo8JQep3VHb5q08v8buXGn3tSIg6OzsAA6Jzetk9HSMvwSM+LeJwRQAzsfeCPzhhz6IyspO0oZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gQv0Hd9LOGosE9l2qWzX9RvO5y0C348nL1ga7X3DL8=;
 b=CnKg+YprpnNcLmwEQbLxyTSdrM66rDuxOtvOkj9gC8keiZuWxMSYN1KBnbtH1w5/2qPLaXcTw6mYachbpFfAAIEpZ9FvGeuR7vXMUL73ZQFWkb6KpVjSmpnEnqQMQPsQD9w5K66chksbvSC4BAzj5WD4ktWJgsf/bzofGGleZ+w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1587.namprd10.prod.outlook.com (2603:10b6:404:47::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 17:40:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 17:40:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm/mlock:  Drop dead code in count_mm_mlocked_page_nr()
Thread-Topic: [PATCH] mm/mlock:  Drop dead code in count_mm_mlocked_page_nr()
Thread-Index: AQHYgN8SlZu4nzjVxkan7UNcI+AmoA==
Date:   Wed, 15 Jun 2022 17:40:58 +0000
Message-ID: <20220615174050.738523-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 842733ed-3225-4e3f-85fb-08da4ef634e9
x-ms-traffictypediagnostic: BN6PR10MB1587:EE_
x-microsoft-antispam-prvs: <BN6PR10MB15872EC90508155E3B34BFE7FDAD9@BN6PR10MB1587.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmq2z6rqtgHY1H5Uw5BoekuRmSP20LluDQT99rUxoVsIcjQzwEv7SsxU4OMTeLdGTTUlgRmg5JdBxAdU3prDHx3uEOK8YnZb6J2zKaq+1Oxdjb/RWgPSNsEMzUz/oiW2OMDZGqNoaL9P6zlnBcg4kfslkp/4gIZNWO3K6P71FDCTbAnKr6fJz/ZDMV0+Sq3IBgtIihNK76ZWYIphw9ZWvowpU6ZSseo0oY7EbxkeaTHWo4w69CWJwvg8JYv3FaWEljPthwDXgnjEe0xQXU7e0VP41hHs1zg7jYjHToyR/e2+Z5uImeZZq6AvespEyNXLejoXsGjYyQh6k7hoF3LKaGcsH3NotuXU6uBhZKZZSHW+8T22l4/JxbUcX1MBWwjQfti7uOf/qaq9Tt9IUW9uOq9drXM5MlF3+8uev8ytGUD7dOsmyzZDMhDcGJZsfMwp6RdBxT+emhuy7ammgNWVfmejV6rc78uMHm56qJClR3UNwKORzi8VttWmqltjBiu6ZHxMZaEySHEJTD6sra6Rhi9C+ycBEhgQmwK0mK3Vp/VJKVry/aPX80hxNhuAOFtwQ+ASU+JStJMKrFJIezwvySsCC8bwlw1wgP1o2S3BaxWNYSXidEiyTg3houjRCoMMwhOUdHuKX2itzaqshc5+CWrBTr1t+u/1/v8/HUn0Zs39aUyZeoES4Y8j9PnRKlRIgB3IKGWNPpH5HIgs6s1zFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(71200400001)(91956017)(76116006)(508600001)(6486002)(86362001)(38100700002)(8936002)(66946007)(64756008)(66446008)(66476007)(66556008)(44832011)(186003)(122000001)(6506007)(8676002)(38070700005)(6512007)(26005)(4744005)(2906002)(83380400001)(1076003)(2616005)(36756003)(110136005)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5g8XcKUUxkZdXi9/5p/hAbJF1+SRm8x7oi5sF9N/9YQiuqh9mkdL53STIv?=
 =?iso-8859-1?Q?EbwZx2QBprHmHImBbI+9DCLudkdIHXAzax0KYQJkphEIANaqoe2j+de8I+?=
 =?iso-8859-1?Q?D38NB5H2E+tLpOYWsS4ZR9c0nQYLa+X5pRvb4asDkekGRLoNLJ2VntpB55?=
 =?iso-8859-1?Q?InV3u7EIwYikqkVdKx8CKIktxpDYooYdUss4HeIgmhIYZSX2PhV50EPXYF?=
 =?iso-8859-1?Q?0TbsOuViPD6dI++E4j4HiL4EsthZS0k7VCf9YD4d4rT0PItzFpVXUQ3Wql?=
 =?iso-8859-1?Q?nX7E4EGG8ZhCaq/PJL6UavgSidyb7j0no8SMHaMn10pXs9LOJG+TVbXUkD?=
 =?iso-8859-1?Q?AMSWBMgVf2lGkYYyED+A2vw6UUSzKgYC+fcH+rcQabseB0lfwHrmxJ1qsK?=
 =?iso-8859-1?Q?TAikbMqTaaPJPJr09kfBaBzoi1oPu60o7cOzXQB43ZbyQF2uNQcWLSoZat?=
 =?iso-8859-1?Q?01H2XGf4PJ1qkpXWMW+8NY0KrxJgAlWOA2cTTTXNHRXp2OBmknjOB7ilgy?=
 =?iso-8859-1?Q?Ri9cGd50gswDX2UzCmP7eL5Fr8GnMACMtezn/MBg/0ynzTCyD2EHGdFWoy?=
 =?iso-8859-1?Q?4R3TIC9Nr0XNiThF3GWQjJALJf2+1XszX+NY4blmJUnVY6I+d1KVjrZOrK?=
 =?iso-8859-1?Q?zU+gWZVjoXxPhHxiK59kQkttT8PEYkfzUobXcwDEP3ku0yqVk0XEYBecbL?=
 =?iso-8859-1?Q?RCm/+N/sUDJtQJ+11/zNwITTp6vFYBKIx8Udic8o6P2I2OSrndm2AumBYT?=
 =?iso-8859-1?Q?EdYt16M6AVm3IHlUEjeZmBmQ5yN8kPtGK/Dk4clF1YGoWUgacjP7FPuLVr?=
 =?iso-8859-1?Q?2fq0K9eL2P4oXLNcYvuIH4aB/R7qzLE5XcFiyA3AA9H/oP+PlzhUJ31lwc?=
 =?iso-8859-1?Q?AN7qhqvY8EMs3XIX6pl5kzdLaHhZOnZcUa+77zkgypxRC+/RTD4YJMqtJ6?=
 =?iso-8859-1?Q?kYwyFaBIFagDbdOFbCagufkzYMZ38AQ7nZXd09CSwhFgZJR693YizdK7Qu?=
 =?iso-8859-1?Q?fYcZX3PAE+znTth/n/vNWRpkQ6qd28o2otxHPWMgkcDgodR4HmWicpC4/x?=
 =?iso-8859-1?Q?4kAqAOflK+JxNz7edkaq+NRy5iiIPrTovYbSO0JKRWEGDq2A/baB8svcGK?=
 =?iso-8859-1?Q?dW2yaWlEbBMlFrX816hJn8Z27IcVJbQ/zpGlcPYVnW7KA0MVwcTSSzBKFD?=
 =?iso-8859-1?Q?bf3tkcEe/VG/x0OHo8IJCTFpI/eQxpUKkewJjk0G2waIvALrdPrScjh+Ni?=
 =?iso-8859-1?Q?q7PZI1Iz0YpuyenRGUQPi9fElfjh5ZCk/5ygqxt6Yx/AzV59mh4N5hncP1?=
 =?iso-8859-1?Q?F9HrMwvm2lOSaWsNkOISf9w9K0YxGMgH51WYWk13RzJlXyR01A8BFkik3b?=
 =?iso-8859-1?Q?oR0tF3XNwqNsszT31lCvbnST1pBTYdnbRgg6e6eHt+uJvxlZVOt1vtpeWO?=
 =?iso-8859-1?Q?vzp+ghqCowEHGvOovndIFAxbvqVcQH0ecvSJoHwnlPU0gI56akdadKJ+Us?=
 =?iso-8859-1?Q?eOfWHUIiCFBVWwm7Mjvy7CU1pvLdKVE/raRdzG+egCMF3VdgmAfcw+lWYe?=
 =?iso-8859-1?Q?DQq2R932fKdbe3ypR3SYun9uYZyzNHgVm4run/SkQc0KXDvI35wpi96Tsu?=
 =?iso-8859-1?Q?xXn9jdFiUZ/AtJ0O5W4FDoAO4jMMs7bdhaPCNNaEtlsfyXe1ImuWC/L37k?=
 =?iso-8859-1?Q?l9wmexmSnDzQDJW9MeqHXIrvPW+u7viD1r5El/TPouGolWZSsyAotlfNIi?=
 =?iso-8859-1?Q?fVWv+IAIJOlnIuv5NnNLBleYiQKYBFIvYmt5ADBZqRXdxoErZeII/fRU+y?=
 =?iso-8859-1?Q?DVvWdsND01SG/8Jyz6aFLoxbyM+2lYU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842733ed-3225-4e3f-85fb-08da4ef634e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 17:40:58.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpC7OYiDUGJzpNcyPGZI5Q6qS/2lSg40fW0HCl+2FN8VQqZLCO7ECTUzH1pvnHrXrpaJz9oEXuqmkKkyCqKJMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1587
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150064
X-Proofpoint-GUID: k-lJlUFeBDCzo3tDn8goyDxPgzZ20zbE
X-Proofpoint-ORIG-GUID: k-lJlUFeBDCzo3tDn8goyDxPgzZ20zbE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for mm being null has never been needed since the only caller
has always passed in current->mm.  Remove the check from
count_mm_mlocked_page_nr().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/mlock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 43d19a1f28eb..7032f6dd0ce1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -531,14 +531,12 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 	unsigned long end;
 	VMA_ITERATOR(vmi, mm, start);
=20
-	if (mm =3D=3D NULL)
-		mm =3D current->mm;
-
 	/* Don't overflow past ULONG_MAX */
 	if (unlikely(ULONG_MAX - len < start))
 		end =3D ULONG_MAX;
 	else
 		end =3D start + len;
+
 	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
--=20
2.35.1
