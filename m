Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6FB4F171A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377969AbiDDOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242732AbiDDOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B16D54
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFSm024455;
        Mon, 4 Apr 2022 14:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=exhaR331zBmkpqXRZjNX4HMiA44jKMKkuuNIC1g6Oac=;
 b=IqmmC/yVg2ZLjbzb5FBwonAFxjA4jvI0XEDcXBiwDaxHZ0S348783d4WHWDfrLeTef3c
 Iuwz1qJxz3MwCMe/lWQq6Ka1DoS/OT7cPF9LuVwZzPlqn5EDMbtAYaTWvcmZtyM9jzvz
 ov4wIo70KY6c4h0HkAnW9Yp3H9BJvkk/LCTMnZd8HfV4S4Du0EEhF2q+++EvORVbu7Ax
 ANQ8GMN63x66mfhDG2smPftEH/fiA8UQlzlW4metsycjq+KhMx1iC7KlPRb3hW1iMpVm
 ltMblX+sYWKaOombqqFbHNb+oBkSgc5e+VYj8O8qMcG/lnwvw798rZXkpMLy1h8hMUve kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3crw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaYZ034331;
        Mon, 4 Apr 2022 14:35:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mgyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7ThqhmhBQYDv0zKeE9S5QQpX3FXeL4Z9IsNZjLPMZPJG0HtsHyxxjzIyV2NEFBfS7QK71DR1SOvmJ0q2sn7YZ2W5XS+1gMUsVDYAgc8jbyKzeOqxGaMu4qS4okKCLkAXUg64zej1AMf9u7xaHw5vkjUOdoQKoPAbrNpdh8If0SajPdz93IgBVdUH20PyZEWC90/rt+UWGSo0WJfOkEI1LuGH7hyRTooQI8jDGKrCR/UxUCUlu9powxVI3jMyiqsTm3dVFRbq8azn5HxrAI/EjULTbzde/9hbxax9PXJvdE+pUu3Ck6DmsO3eppj9Oj2CoBVC2JZi2yPssLW1KoupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exhaR331zBmkpqXRZjNX4HMiA44jKMKkuuNIC1g6Oac=;
 b=RlpuY41Rtl8VSfYa29HGL8fksfadDQe3P6x8unMguFmkc9tTDP4aabMkMQRRfEVkCS335YkUFBObTu20R41SfotSAwx/zHtmLT/tEuexrdLh5aq2G/yZdj/b/ForcNQu+Nf/n2Qzz0HkNjGeA7tkgBOZFLzPU+oMGN4DdqHKbh9Ch45unYjuacGjnzNlTuz97oF4CNvRyJrTGp+caDIy3UWshZf2sjoQKmvZMkbwV31sokFkZNJQnXUtdrnNfrjB2AdRVi5x4hQ6ONaSlP0ExsaQu4YtyKWeaRnALTWDaD9M/MTPqelCAnmCqlTdK/LBQGrcVYB+c+cWkdGvgtE8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exhaR331zBmkpqXRZjNX4HMiA44jKMKkuuNIC1g6Oac=;
 b=IFMJ0NM56VDlCxz0js71Bx7Fx/iayqxWFXv98Jm0ZBnt2T11SDsn8+iQo5tO3QCFEOpwAjrRF2edOsgVJ+ZxslJcCVTsRTHYcG5tumFxVpdMg3QODxHEczrhX8V2qY5r7japAMWDFolRlmbD4JaZ9yt+BMe2R56naIzyeXEcWww=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 06/70] mips: Rename mt_init to mips_mt_init
Thread-Topic: [PATCH v7 06/70] mips: Rename mt_init to mips_mt_init
Thread-Index: AQHYSDE7eiYZataXOEiuDEf0e8WhSg==
Date:   Mon, 4 Apr 2022 14:35:29 +0000
Message-ID: <20220404143501.2016403-7-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57df67d5-8238-4ddc-8d70-08da16485e62
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB581208F90619D9496F006E90FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CbiKz/ohN7alvdzOnPG4i6FIU5dTtf4Pyh9jMEDyEDMvs7qogKzdK739Tdc54L1kpU5ZLKNTnPpTqqCuw/8Bz74C92mvJ89c2F86Jc9olTRnVJe0WWqZHzq2nXc3Gp0jX7P4ayCZtswUvz50Ymgz9I7NffhA9AvzKw2EoHCJsfN1WlCWy6gJgRfZ33P8//VvFYmgxqP2lsfVTALe/CAPWVL1iUBhMN6ZClKEMbA/ebfvJZYbp4I7JuM5SeE1NeER9qYx7DsdxvkaDo/h6ElF5ZTMl5grzl4ynCi1egLUc+LFPhWj6hqaNP+4MdM2BQYWNkNbqWP64qbeiUhzkcs1oNFNsZHBvBJA7RE8IklEjLKrIMfrvo2BbErIbNryVoroF+jW4lDG7YcAWQ0QTGttAM5XHL1Y2MzvSxJaIyN08eI8TTD0g5r1HKpVNbhO6CoLrBpgDZpkn5CVaR+RQ/z0febLydBsTalb9pokT6llyBIzVv0NDNT3RGKS9wbep/oK8t80SUX4V1UI+mrUD4yfDCu7RdeRiJsXFSqI1fihm6p4WTkifAy71AOx5YCrtFBYpUYtjZyBykZpWv/7LUpKPHSfxcQ6+bXtyQEedqbnctOmKEquSKHPgAPf28+uJ3008OUdJlAriRh7EncM+SDq4oVhWWkZf+oju5c/DCN4zLYY1+VwF+ikJg9mzgR8ho+piT44zfxsSIwmTKTgkxONA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YbEMevEDSLdzASXvUe1B2BiuY3V6E2hoejlUkeK9+7LVLaKTkuGDTFnzQW?=
 =?iso-8859-1?Q?ZIULM5rJov4+Zktpopv8wG2i3qedVfBM4Brpg5eCZDVrdA5nuL5d1sIsEV?=
 =?iso-8859-1?Q?TFNYWBu8byh6pP6tgDoYCh/G7midznBv5twanRrWGjdMbRyfbKsEp447um?=
 =?iso-8859-1?Q?Iv0B8g7XPbN9WaQ3BLP00tjzS9GjEy75Uo/7r0J01sX6GW1O0e5XunQuEF?=
 =?iso-8859-1?Q?hERx8nIUeJ3OHmIp4LHIAXErih3FPI22lhpIrwSLb4OZLNp2KmB5OuCkoi?=
 =?iso-8859-1?Q?J0GA6DdeNroteo8CcO6kX7uOCi5kN3Yd1VN/koiEM1UTZ0+kTFrUtv8vNI?=
 =?iso-8859-1?Q?JHV/fNzIY9Tgb3NqBVlV3S6fneGt/lDL2NA9HEquD7RurIIUpG4Rabd1ok?=
 =?iso-8859-1?Q?RCpK+eclw9IMfeCh0pJzXJoH1KZXLyU5dvcQ2OIKHPIlW/ykePcEM5Ybkz?=
 =?iso-8859-1?Q?ifXOpje8CoNmyviIBTX/lrOX1JZOjMa5f7M+KPGWA8EKyRZgeSDA/dJDnD?=
 =?iso-8859-1?Q?aq9/GoM9uIW6c7+ExA05GSWLwxCQthNOt6Vc0/n1hZa163aAjGXGvdrpbg?=
 =?iso-8859-1?Q?FM51WKmMmgAYilmZmay0pYOEmhiMCNbYCZ9OLWIeoK757vs62f0y13+GP9?=
 =?iso-8859-1?Q?KW8404ijVBVlC4lp+mCyV5iiao2CqAF6yI+XSgFVkE9/9UWcqyNUKMbCTc?=
 =?iso-8859-1?Q?NzI93fZut38pA27qjEZ0mcxUZIQGc/laxEZ82xqxu/4Dh8luup3i4il5xI?=
 =?iso-8859-1?Q?Nn3jSD0/XRl0Qbkf9CQ+VL79gPxiXajn5Hpap8sMZhb6qdF32KP7AuDsVu?=
 =?iso-8859-1?Q?5x6rD6BajJwbW7TOz8nncsiXPbAOMknDuLaPFZkwi3OxUhv6NgGZmXGQqM?=
 =?iso-8859-1?Q?QZ+q7s0UvZLDIdfa1kYWMaUMYok9Yxv37Aldvwh5GkLw+5eKGOoImxflPV?=
 =?iso-8859-1?Q?1+FuP8BcsSUHa5eNe2pHzEg2rtQsYiglN+hyVER2sz9kULTcsaegPS7rfT?=
 =?iso-8859-1?Q?5WIZSGbariFC8ZKd+a5DZAHvKztk//V6gJwT4ZFK8Eg3GQeJKNZfkV2Iu4?=
 =?iso-8859-1?Q?LqyR1S69YNT0tMtBwiruTR1ilX7V+sHFBe+F52F9rPNpul3MREUvmYPqPw?=
 =?iso-8859-1?Q?SVcAlj8B2dHHFoaMUz2V0zT6CiAQSJJi0SiqvmJExVvxgD22pY7jPpnXtc?=
 =?iso-8859-1?Q?xxh1wK6ltB4/jxgGGD7v7mikQGKCXVtbtXORXz9Ea76dp5xG1ZpIC0Dkrf?=
 =?iso-8859-1?Q?+7ogShZbTzeToAC7gtam8volL+OsjcXku6KA4/u/ZJO2qVnGwpswnZhga4?=
 =?iso-8859-1?Q?3tOo2ljozPzfzZyMPzbzDRqL2Ny5UYncNn/o7XJsD3qf4Xz6VSr7RLRB37?=
 =?iso-8859-1?Q?Knm6/rgyHnD11XdrlIsPuAb8hNHnJbluAJ1ljCu10WtaRpk9fMHCogIE8P?=
 =?iso-8859-1?Q?Sw6353ly5teNH/2N2/19YU1+8WoCaRiH+7JXjC7/gZ3F5OSIqKvi/DOAA9?=
 =?iso-8859-1?Q?AuDf2+CNq8VF8JOV5smH3CH7LeLm9Bt81XBr/5PClegusJTTLWLtJ2oMt5?=
 =?iso-8859-1?Q?sad5RMgK2efbQsYUy9bsZJLmiaQB6Y2T1QZl5izg7Cex2uHCcaWiqqNiuu?=
 =?iso-8859-1?Q?KJbE8Lb7CugsQA83w4CtehtPb//RwwkbQpNSu+/8OAadRtLc56d4U9PpFJ?=
 =?iso-8859-1?Q?6KhKt2p3RhTtBOI3hzmmrv6/trvnfcpJQxVZaNrR4BcIDx6IeSc9Fo3xUI?=
 =?iso-8859-1?Q?ZiXLcMe/to/sGFH3SSTUrkMRMGr8mBLM+PUJzdz4jwb2GLf2wIKRmV9peJ?=
 =?iso-8859-1?Q?Y5p13tl91qxYdVBa8X5Z1NYSSIMXt3k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57df67d5-8238-4ddc-8d70-08da16485e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:29.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkZzZ5XYjewirCpNCtNOGbGl8g4scAx29JAWMt3Y9IPVt2JaSWwmbE4iltJgteaGZs7e6yjtSoEh6OzV9wOS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: 61J04PouwbmzMNtTw0tClg8typVPqJFa
X-Proofpoint-GUID: 61J04PouwbmzMNtTw0tClg8typVPqJFa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mt_init out of the way for the maple tree.
Use mips_mt prefix to match the rest of the functions in the file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/mips/kernel/mips-mt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index d5f7362e8c24..dc023a979803 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -230,7 +230,7 @@ void mips_mt_set_cpuoptions(void)
=20
 struct class *mt_class;
=20
-static int __init mt_init(void)
+static int __init mips_mt_init(void)
 {
 	struct class *mtc;
=20
@@ -243,4 +243,4 @@ static int __init mt_init(void)
 	return 0;
 }
=20
-subsys_initcall(mt_init);
+subsys_initcall(mips_mt_init);
--=20
2.34.1
