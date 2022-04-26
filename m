Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46A510178
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiDZPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351876AbiDZPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5EF13137D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSu3G018603;
        Tue, 26 Apr 2022 15:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=N5flKQi+YvtP5Ybvnh+b1ZLfhLHg88Uf+53TM/uGjjXokDdVk6ocHGIQEYLObuTW9vHq
 aZR5CX9qEmu/YUzm79mTQfHjdjLuaSGeHK8pHhjaLE1lv2nTnedY106Pk3JYO2SOxrWq
 I1mmAZfvJ5tZjeNwm59zTPyVz9Pw1bAPqbflCbywMf6uc9EpbsWwSasEyh7RnRbABi4l
 hI19O4mFpAsduO9AcZYmTNrIsBz8bD9ac9KGEycVBrYlvrsslz7VX0yxua4MESKfQCgy
 8Xn/d2yaJCb0g9pzlgiwrpAH7O7lNByOel+yT4b3tffCQ85fPnOEoICFrPVX1G1m15lu Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxef5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63EW012545;
        Tue, 26 Apr 2022 15:06:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFfCVBxu6R3/mp55qBOdgn5tT5U7bMWowg8zW618w38IdP2hd6G4G1fP29tpbIeHxanJd0V0twmf7ZZqEunz07N44FK3fhZ7tuVcqzHNyIOp+jd2/2nkatwhA6v7Hhl97jSsFDzzyzfPYhU2Fr/6IBj14zyYj9qt8mH6e6HG8ELezVBnkNcaXpGUcuFRmxqQhlr7Uk6YFJAEtV7eShiGqQNC9F2j1bo3s2zfjNnUB6uEfv0l8YO5Yg5G7eNIh5xuvHfwurWfpEVfMrEPWhy4e4stbMt/6ALTS8yS9KyIFqdi3LwyAAeqWwUr+it7TWjlR+XeIBoV+CfzxOQzUat4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=U98TVxGhRv47Qzlm07z3I4RVwbhIZTKaFy8A7vGGxyTMO5TyTtnjXCJuDXRVRIYriyM2w2S2ES1wGEYoHwAk1W4tW2TVtq4la+drnF7lLieo+6CnYo15RdT4SWGIqP5vNTftGUkWGgLC9ay5dXq69LN5FaVO+3cWIqSgkAB5PWfr+3nxZfs+3e4nwgxc47v3zAq255THvRGKlOV3uF+ItvSSUYLRpxaYAJtmCoSWZrrevRdW5kSkdUF+GDSlRE5hYNQwUBz9473pZDNMeXWv99ejj9eGiHBzJQS7xqmGoMcHNzrfaLDl3mxUajVbsYcJGImeKttWyNHp/frcV3kjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNMWphPtjard9k3471GPoeMlaFIEuRlk2JENN8rICVY=;
 b=cjAGHnsV5XnXP+ofZ8DG1QNDCEwX0JLlw7Y6BOXF1UKtPlGXBB30YwMhXG0M5VculCRNhsDDl0CFdAItrbqW9cxF3mOU+aeq0mLqo9BCr+hSx7chY1VkKWRRCB5VYtONUTF/j04Z87qlaYuOFMf8JzDXuV1nWALgY1ejW+QBy38=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 01/70] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v8 01/70] radix tree test suite: add pr_err define
Thread-Index: AQHYWX8vEfhWpAQ/v02QuijF81Khag==
Date:   Tue, 26 Apr 2022 15:06:20 +0000
Message-ID: <20220426150616.3937571-2-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1995e8d4-240a-4d18-10f7-08da279652a5
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB465963C93D7B52D05BE7585DFDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fC/ZCe9zzBGNJhiBpF79g3WP6JLydWwRrexB7qLsI10wOrXS/6QcGQgeFi0KG3kROa0R2EfpJ4Qg/uxVwAW0MScCe3mLTsR3qOHszQmq+7IcZosMxxpu3dnreGYBn7YMGi7rwiuFKKqGL2peUfzu1UA9cOChXYhMyIxiw3ROb3xTrsuHwIES8AuFR1GVrcAUimP5t8eoCeDnGTiOxmzIZ91NgFUdp1qlDY9AEnKP/+ZfGhaIyql+LyjUdqs71G9nyw/24qzQmgGQw8gkHP1o0rm3P4OAm0hImNeoJ3W+gN+J9LaBI+27QWdSfDuB/rSLbt+GnRR2kv1w86SWURm6Ha3PjCNO81HZu5DZHBynmXP6RURbsxzSgZogQ55vvl9p6SvJ16nlIduJl4YQOwF/NnAMcH64fFWl42J0DuPrz4xeUne18paEzmlGzGdIxsZ0cbpi13m3j6HsuCaHdVgsr2WeVlMXVy+Ol1P8WBNNqipji2LZI43Fw/ME5GOlLff9m7vcXJUtGy62VLDGNNO+UZocnf0PZy0Bb9Iv50FIUkJQI9YrWsMkxzTMH5kOXMXujMBjzw/W5PxyeqwFKrPMw1lKSoaLlJwpCUinwm3xN36IchTliNlwn2n2u8TiMJJp4rREy3LGn/We18467LiahSDOaw0XeR2ieCA2G3JSiiCtpeRkUQ5bkMrgGONzzDGpk4yBj6/hI6gufQ/Cm7GmzF3naiOoqTgd9Krx50Y+Od50si/v7pdzcS1WUUyHabJ2idqcJEMiCgFKwZJA7/8NWJsnas5tV/UOOZpr0dzNUzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(4744005)(76116006)(508600001)(966005)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S7jDEKqcXbSj+FbfcGn/8Ca/5nwrHtwsGken9mGhLjGFtWA9ZknVHd/orx?=
 =?iso-8859-1?Q?oMKr18umQyX5qHDmvI381lNcxOQKp7+EzseLee1AuQamBdXKqgmjcldeak?=
 =?iso-8859-1?Q?FkrY2ejtOmI+yQivFyZWSU3PfqurkOEmDuCBsZBh/k+lKsKOMklS7mKNV2?=
 =?iso-8859-1?Q?YIoAMZNgKCVN+J0QdH6xAddefWhvsz4KpTfPljSvn2YvUuDnkhpyZA6XL9?=
 =?iso-8859-1?Q?xCdnUfUItY8v+hvxwZWsugb+BWeyc0pQGgjLx9uQc+Sza65vjkWvijQ09E?=
 =?iso-8859-1?Q?NJ6Ky/X3+4f4P0RJgGxW/OimnBm7ozvspgCUFQcw7ow/y1YF3b7WaOOEqw?=
 =?iso-8859-1?Q?nx5m5leGBpEpt/QMblIShRzziUC7YqI3U5aRciF2wnYmCvw7ESzg58nx/Q?=
 =?iso-8859-1?Q?AhpA4ARrquszLGCBShvmWJTCWqVI9FSfdNUmTn4+nRwSLB1Xc3fq65Rx0s?=
 =?iso-8859-1?Q?MkuNteg09tAI0roe6S+eYQ3NeKD0SUVDay1TmUWf2QbEMEMSgtlDe4Aads?=
 =?iso-8859-1?Q?V9d1xmCCQbOCbNsAR5Kdl75eCbqMjl7dyzuNDxvJD8n4upJCXAvadmhfrD?=
 =?iso-8859-1?Q?jFcNf6Go83mgdGv0WfjAfL82CNDciJ8OBBozxTnG5mFEfJuiuSD5KkJKjk?=
 =?iso-8859-1?Q?MXSYv9ZhYzzo3+vOKtS/xjvK32qy5UlzGElI+v1Y4fsWz6dRQ+TZVPMivb?=
 =?iso-8859-1?Q?RRCBNYykDZWljk6f8jLXUuxiUUFrPiXV3+4n4K4rpKd1XO7uQjz8O0AmcE?=
 =?iso-8859-1?Q?6w4s86kJn/KXq+zP8sZl57EfT2CDWcAjamL9sci/TR/uofnB1ccE0kMbdV?=
 =?iso-8859-1?Q?KWHczNfIpde2rVDKOdHZCrwg9sgQM1TgBaW1mXN//9P4PmIXXB3mXG75Yy?=
 =?iso-8859-1?Q?6ijjgrm8xqQKjAh1mV+KuLY3N2YDMYxNHdjKwSc5uywQElvvA/q48+d/oy?=
 =?iso-8859-1?Q?qh67pEQEGDUWuC9KJwT0vAE7LSmolGXF6iLXPXXd8476VF2biKmW2E3TMR?=
 =?iso-8859-1?Q?g5lvcKBDB5OkTUIhMOl6oEbV/z7d4Y9gQzvUYPEez/W7PXOf4cmFtjKYNY?=
 =?iso-8859-1?Q?bs2MxO4OsEGY8rLunkFQ1oOYe/foIBwIDisOuuzRD1Muk4gq4bXHccrVuI?=
 =?iso-8859-1?Q?co1qoU3EBfOpCR2fdkW/f66/bsmiAKO4OCg8QY8G3t2EtCAyJ1u/n1RfCT?=
 =?iso-8859-1?Q?Py5jVSJQzGAnfatRImlS5jFQdj6ijqOW3z/hZmC2iV54QVlOJ8U7L3DIBK?=
 =?iso-8859-1?Q?vghiMII75gQfdeP4on6FoulKINUlhXZWEOD1bAJcxIbRHa9DYkMuuTgaqO?=
 =?iso-8859-1?Q?g0M8I2trBA5jl8cTla11OeXhaoe6vYfBzousY1Hj75zVqN7YorEVDfC08s?=
 =?iso-8859-1?Q?8xFs0bNG+q9SeBiO23G0RpJRWVWRdZZlsLbQrZuLMCzlhvVQe3CoS0Y7Fe?=
 =?iso-8859-1?Q?N5BW/4ru3EniIiXfglCkhaTCM9V5agBhB2dPfEhLbrx5QSHFgjZP5yhkb2?=
 =?iso-8859-1?Q?VM/LyXfA5UlgNvjXzx8hq9So8yLDpjT5kcTxNzLncQc501YZiud1gp1H7a?=
 =?iso-8859-1?Q?rHp0KgO830YAGadw8jzq2M6XeDUynh2NWwK3GRDA7ZpttDI0GNez4JTS3l?=
 =?iso-8859-1?Q?edv1ih/2TrleTz5y+Fr35YAppd7CH+PqD1aAmWwXPxeiA9muXgrU+1yWve?=
 =?iso-8859-1?Q?eFuP4Sw7lhxWpOhbKazz5J7uNEvKPARrKEBb6GS0vjWGqL1iTTMcqNzSlY?=
 =?iso-8859-1?Q?NmwNIfJLyLbGWCVqEFlVCeOJimEn0O6B976clEWC7Ap3UgBpsatcjaToPP?=
 =?iso-8859-1?Q?yyxbi7KxVCtPAoXSOuOT6cCfX1JFnMk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1995e8d4-240a-4d18-10f7-08da279652a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:20.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SO8qftjhe4ofxAKzyNbJDlaEeHpYwJ7BJeKedWyDeJWcnyUqCtaUXBI8pNCBD+xsw3u1N27tJxVTIbR1RHZH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: PsmrXMy5Zohq-YpD1Lp5o6xOBQUr9pYP
X-Proofpoint-ORIG-GUID: PsmrXMy5Zohq-YpD1Lp5o6xOBQUr9pYP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Patch series "Introducing the Maple Tree".


This patch (of 70):

define pr_err to printk

Link: https://lkml.kernel.org/r/20220404143501.2016403-2-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.35.1
