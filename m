Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E46553BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354330AbiFUUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354237AbiFUUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C123F23BC4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJBboG004709;
        Tue, 21 Jun 2022 20:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1mGNhzsmdfYEi5t9mjXborhsfSraHQy46JNtniTvh48=;
 b=l7hhHCk80Xpz95fY0Q/DlTlCRLlvcnyCMucE2W8H2CxzFpQUYipsX9lPzZggUvgdBtXa
 F2Huke4OiXvsYSpYw7bqw50RBFeosVYepeo5rJL2K/ME/bamVl/DvI96p9XsclXTR6xe
 bIWzhtvn16spD0QlGAtZxJUckpmeGchiPzmpnC/Ju8SoKu0KIiQ6ETKyYoUPNXAdzhby
 FS2zLVo5TE+yVkNrfhKB5z8zoWQSyL1eNNX2DAZ1kWmA0m6jEtHSMokApuQbGM6NItAo
 +9FhApnQierp/2p++cGSJ0WkRN4AR7t/GsmGy7tP2PMzwI+2PEYrH1iCSCATsrQTjkVf ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeb6c010844;
        Tue, 21 Jun 2022 20:46:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkgjp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkEz+sehz8kD6d7Cru6NJW6ZAzjT7nRD65m+++wq9YbBU0XhjTF/dp1GUSKV1ZK//zS/nhc1K2dZHvTo8gHlkiPttaxDzA50H5THvqpH+I0SKGfg2q0wM2TibG3MgaMO8nY8h7l27ooXQ9Dx4Yg5Hy/IRbuvdF/DYfDgm0JugmR6vrY6RVzqo8mHjeaQMvGd9cO7ueoUHOfYLHu/XdTVb+EsWI+F6TCIcdQlAZRh2CCxt+TsI+ikqBEtAEZY9jSYCmDnNSWhyXbNKZ1IluX7ZkTGuvRFcsGuxlPn3gLfQygZrk3m/TC5H2HTfVUevwbTao2oGQLbz+9h3kFTqZuXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mGNhzsmdfYEi5t9mjXborhsfSraHQy46JNtniTvh48=;
 b=dmWojQU4k4jmuUaQTLnG5me6iHroeazbBgktmkQTe+jlgPEC6h0lTeoGAorQxpJ39DOATStS7dX+FHrBlEMBEjHL97wO49TJ8eCYWziRJx/2z4amEfJWYJIsJ0vkyaOIWTJiSBr2DODQoqyMIBpfzcv1zbKPx5HxrJuvaHz799JOXSuVu3Iev5BKiV0B3yGQ8/w+u+4Fp7ak4epQIpx3S09Hu4Ddi2Ybsaor7g7CMMm8Ldu7JM3LSYqMJkAfBTuB8t0yPXt7xf7wDuUWh6+0AQRQhUqnmkf44MNPSutIoZuaE8OfNKflL6Ff7aBCxd4sGHQWyUKFguApOC5anrKL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mGNhzsmdfYEi5t9mjXborhsfSraHQy46JNtniTvh48=;
 b=hqz7VaU6iaURbqJtQM0nMwxxqVC2sjS4XyI3C3nsSfLRr/qMkmJyV3sWY+PZLk/u8oqfdrjUXCIB4nGY1/aYi8K4i65OnclfpH6CaHAU6KrAtdnAp6HYV9mDehcITSUFAQRVHENOnujBxU/U1AAaezfm9bARnCU40RwiWgtJrfA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Topic: [PATCH v10 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYhbAHidvH6lLGrE6f/uG5iI4U8w==
Date:   Tue, 21 Jun 2022 20:46:49 +0000
Message-ID: <20220621204632.3370049-7-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40425477-e3dd-4f3e-7df6-08da53c72b27
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB307409C2AC037BED21D75D11FDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/GlhIQ/D5zQbWX+hYi4LaMihj3I3LEXaodfYBhbJQ9AyNy4nG1Y6xIT4mnqgeLmOQaXZG5r/sTN824aeOJRqrfWzuEra9tcQiJmiErmrMFqRet/zSeEL1gPiEB2nx9zjZjj8bwvgtwlKHB/vxU+F7PgkoPnBOk27yJhj1r7GP5kRzi3UQnysz7bGSaB+gmhcDPs/KaL6KkPyRAHa+iEkUn9t7qv1r2/4KO/sPCtkjWJbh0XfqedhtIPwBDZudXzY9wZLyCOO6+fYK3AxuYD2mhSycBTN638wPVZIyUcBCJ7kXCsYLjnmSGaYaiM6XNMYsIuIIliHkrB7Y4n/FaDcR21zGE5LPbeiTUIQ35YqheY/Xy5a6gHQ9WggcUXY1EDpCsgeeIPaEwimhzAHmlJ0Mq/W3JiBEbnyALW7psJIp4YgfhSJyjzWbW/RbKs7JMbjpVuO744EIM8ic+M8qoBwZusxQTqrjEwYAI2fXFxV2vxmpU8GklX48WBdVjkwVTyC3XyYBabgMVByc8LT+VPf1vfeE39abmJsuQevQ4GE3wppB3TSnZWRp5SXycT1wxn0jkMTV4hkRtEMbpzjjAjspg5Z6vc9cIO0Y93Xj85nzNY8Dxdfmu6+cYJEVIM99numUzMoQIy88O8S2pGgJeL494dO3yae6zUqpoEvmtJFUmUJiTbPbwzpH2XbnTLpV2zLhdANxok7v+bso/qP2qjz/kmh/iRXsDXzr5UT1Uw//AxO88DDCchrQWTbeJ3IiynEkAr81zHUHop66C/Vf3y9cBRXXlV1B6+3DpyEnZ/ALE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(83380400001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(4744005)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v0+oabIzsdTmnEhE3JnEbvryDLOyixyKwj1KYsD4dT8Ka10Zz/P+JexKoz?=
 =?iso-8859-1?Q?IcGQKUAMjH6RfYeLXUKvnYwuRnws3GqbN2V/JNNir0KJavk+Yx/sxPzJYP?=
 =?iso-8859-1?Q?zQbneuJ+y3d2e5+oCrEdl4XhjLhcxCdqQhN63ZpL/+aihr8WgHnY7lpjeQ?=
 =?iso-8859-1?Q?hFbobULOYl8S7eUwA8iiXetxykvMo20gwvVJo5YqaBG1V8t4WRBKY/2FhF?=
 =?iso-8859-1?Q?ghYIYGBkXLw2H95ShaA2a9QeaqV4Enc9CzibXNu83ue+oFKXIKKkg+YN9I?=
 =?iso-8859-1?Q?W+gq4I7rw70ikVvEEfEmwvwNVAO0Hq7l9MJ/QnlfY2Cj85Jmu2yURpTQm4?=
 =?iso-8859-1?Q?ETNkNx4pZbp1iUnsvtlEJBjZ2oWNnD+Loj8UK4YP2atmdM12qNdfTwRr+I?=
 =?iso-8859-1?Q?QNpys++QmpkDHeb/F+8IL0P8XVsA4xgtbGCS+EyAZS3ZsGkiEre5ucTvVC?=
 =?iso-8859-1?Q?nQDZNzcLNpWrDWrtlaXBrDMAG7+cE1hfjneUmmiZA+HToKwXZx9JkfG5Vd?=
 =?iso-8859-1?Q?MSX0fXPqL7uuB447lupa+FQNzzM2UOkbe8WPPmqENgpM1FcEYjUBP0y6ow?=
 =?iso-8859-1?Q?1BJc3C11M4tmZss2L1+dnX5hMx0dcLw9g54OBlrXxyN72hyBR6dz1ZHPAX?=
 =?iso-8859-1?Q?dkyg9JgejqbF69iHg+IQaOpbZL1rwIw4ewwhN7GmpkvPLIiypsR6GChFFW?=
 =?iso-8859-1?Q?Cuv0JqJr3+r9JYCy3NU26RphmIkAQVhh5MHsCkZenqHZXurbV+vD+WoYhn?=
 =?iso-8859-1?Q?DIONYb/ZiXKa5eEbnn0k8ZBslTAlvFG01s9KptcwUCt09pfARhOi9P6aQh?=
 =?iso-8859-1?Q?WF9uVH/GyBSWRHTAniZq2oWOXyUp9+aWwo1ZENKzKe4bdetEijcU2Rdjbj?=
 =?iso-8859-1?Q?+eii9+iRd0FkCa+g6S40sdUkHJYBuXkePtULIRiCt13GDbzM1C752ddXce?=
 =?iso-8859-1?Q?ohUCxqOKX5d2a694kh5mr1RDhWdhdjeSHddDcG/NP5Zq2cz2BQQ4ThIcmX?=
 =?iso-8859-1?Q?ZkWEXnokVnAqTg9P8xPYr4tOtgTQqWGwLUHtwfzc7Rd8LOFp3iAbLSn5F4?=
 =?iso-8859-1?Q?XNgcaBHseAeRZZ0rMs8WhMEDIM8+8W95vLlEm7RfIpStoFJdYxI2X9Oiyz?=
 =?iso-8859-1?Q?rcII4uVNHkMAhabUiRxEo1MHuAggiLHEFuYdoAHyYjg2vFukR7a+XpGqm2?=
 =?iso-8859-1?Q?d7+g9ggKfBGZjBM4BcYNoHg9XbIb3fVRS415Bf9K8+ftNWKIjQTYM0I6X9?=
 =?iso-8859-1?Q?+o+kUHrHN3BTN0PUnpfmJUuEOkTfClSqGycHKEx5rQI9H1Kz7NCHCIkeKV?=
 =?iso-8859-1?Q?4CAV1ST3jKlq0hzTagxgH+gB9zbfFtmaQOamwwSovxRDvkcSugVoOhhBrc?=
 =?iso-8859-1?Q?4MqWAy2wAD4NzGondkeyxtKdWTpppx+M51tgyjOiGgftJvjDfccNEuzvKx?=
 =?iso-8859-1?Q?U2NMmJEUsxs8ZkZCJ5EJ7AfFiK7eSjkLWSim9Lq1M/d/RF8KI89NsXZS67?=
 =?iso-8859-1?Q?J7oG2/z3VB6W+twaLwJh5Wtq6vETNT4GwTGSiislqjwf5cUOOFXP41kFFI?=
 =?iso-8859-1?Q?eqittNww9FyTxw44P0RMfCDVNp0NvwSSVRSthSvW3D1fGpnXW0MkFqzjTC?=
 =?iso-8859-1?Q?ltQgCTxt62IdsoCNZYlr2YeEW9YnKR46Jgfk4QaTELicX7mhzeftWvGy3Q?=
 =?iso-8859-1?Q?tAJJKRn6SVFf4y/nBB2Cn8rsWyh9683MgJVYl8uUTTw7L4j+J0svKjIZT+?=
 =?iso-8859-1?Q?ZVPDu2+B7RBWGGMKTADZEHwoLue37n1vGU81ibV57C8giyQkXv1RFTQKb9?=
 =?iso-8859-1?Q?5HUKAuOI6Dm/O1WoNC6hbefj55tUxeQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40425477-e3dd-4f3e-7df6-08da53c72b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:49.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEvgMhAqxjURf9P+xWJue7UCNp/7NLo6Zq4YUbsPSH8hRfjDGjVz35DvsEGTUMuEDIDxQSCHaVB9SuMs57u4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: cRfG2aqRPOZ7YmtZsgJJGMu0e1fc4YxR
X-Proofpoint-ORIG-GUID: cRfG2aqRPOZ7YmtZsgJJGMu0e1fc4YxR
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

maple tree uses lockdep_is_held, so define it as external in the header.

Link: https://lkml.kernel.org/r/20220504010716.661115-8-Liam.Howlett@oracle=
.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.35.1
