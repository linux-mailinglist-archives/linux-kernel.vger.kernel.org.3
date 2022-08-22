Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E747059C218
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiHVPDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiHVPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:02:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE437FBB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:02:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEphoc016577;
        Mon, 22 Aug 2022 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=2lP8YryIloNDlkJBY4ssj8f67abqK78aPv0twkgOufnG2zmzZC2J/krSPzXYODKKZJ/m
 JOwU6xEtQUJ+iM/HOf3Y1MP39MSw/hXDgynA+QARk8kO9iR7/I+rsZIpjGX+1tLtOnh9
 n8AeqJguPNRzSywyOezSoTYEzAiIlqGjHCZy7M4UIUOKgmUVod4cIZnxQw9qb7ppFFqS
 gVqRmQfJhNvgu2bqfYg+ajYMfaiVQw2urHzFGiNwZHtG3pgOIHKL4X06E+5ghkfbzej7
 0IUh/BlTZLEQ5b+QXGTS7GG6U1zbR2Jc7+1Zx0p54drePCRi661O+FhvzQ7S1BcNdFt2 Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx6813r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nf3037763;
        Mon, 22 Aug 2022 15:02:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg37uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQuWoKiLwtNCP1cApZF0uscgGNGvw8BYf78ZIf8+Rx4VGmLDhOmXOOhZkf7h+WnZvSScBfsL9gDHJD0hyaM12BcttKzpdA7sg4tdjk8ajcFrZHL1xfwo4Dv9hI1J/wgBGbsx1h7PEpZdlJ9vXTMOY3F1VFqM7aMJSsaMPIDecHiNQW7Tveu2/ZhREHJjoOpwn8wclAblSuswyuCUrSoZYm3lOipAqNTe99YHSCwlnT0Ktf33o7e/9FTi+UhnzAjpcFM5qjlAjgzDvJ8Y3L3dXDX679V0rP8gW7KAgHvHfRXGsXFnv+c4yrIFVRtJVRP57lqbwI4FMM+2qryRRZIQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=jYQmNp3+JzWlaaP/uo6yTSFVJ6sZhdFRdqQeKOapWWzI+Eqjxwndx0oi/w2suVhx2Et3dbOtY5ib/dasAZf+VdpW7hGLWmjySTnCuHEkWfE2I53r0P4GAbGZC2Q3XyTj0o1Gc5D2qD4uYlkepOJjrA//8pOjUACy5DlJyNMHhmeJACMCiQfjeRr2JOpr7MQ3XtoHrtZNuz1AXBnCu8z0AqS6vIrsaBJL2/kmPH93a5C+tmICuDqkdbBapGPUdzwtcbnKDChx9Sy0JRhiqgizzvWDnUCET8nD7dDRo9qHeB7q+i6TT5mpT+j7tcTK24oOHxGzfccsbAPvlD7zWLC+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=Dmk16zNEDKJeiWDUoVJZX46M8hA09VDwS/4VG1xga+72drkOouUxJohMzk/AJxAma3RicRyVRi7nzakcaHA3GcgFqGrEbUBR2vxT2kpq5ftFV9fd/kuBB+TeLRfBMtfKzWCSlthfYT3xgu22BxrUBXX6yXQ4pzSKcnp4HiHnvYY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:02:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:02:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 02/70] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v13 02/70] radix tree test suite: add pr_err define
Thread-Index: AQHYtjgsiR8lzd9CH0KTrcqm/ara7w==
Date:   Mon, 22 Aug 2022 15:02:19 +0000
Message-ID: <20220822150128.1562046-3-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 358c322c-8c6b-4292-082a-08da844f5621
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsqHV+TBtwfGXH3x4U1h6nh+hs5cjzc8wwjBpI4zKgQDyrXbv6hgZR7dUlevJAlp4HtVk34AbuKvjiutngsCzwZuZKIgpLSO2evvIsc+TUSgywtXi1YVEZbbPxhjk6Iug3u7c/d3Qr252wlc0Y+EXijczXvNV34lYayKwvIg12TUGFuVir2abOmGQ7qNILiJsuHx+/w2x5mHNNS7YnktF+OZME01PO5irOnZm3QAYg55Mm7P5LcRCS/lSkJ+km2UiFTL2liBvj4kgVIAy/90GGDIb4QLuQYMNkLjsDy9IIdy+FzfvmvlljPPrDht1b1MN6hVmRIlAE1N/o3XvpVfRfofGsO/C3JZbyWyY6ECvUiBUB+65DkPO9YwPveOQ6rLTRKn+8EMOZM7pCee/QQHkOSdoQULdFWlp02wuTUKbKH/1VPRJqjnvuKzzoxdq5PhCwvgNft8PgjyrmRhowOtyEg5cMvc3Juy1UY4PVhhO1vPm0Pud8HOYLClrurzn+SMyjLhmlBjljmaF7NaMDtiCUm5YAPS1HESqKruQS3NsdUgGL+IUd0CEAxh/VUVeTTpO5dvoUSQP1cEua0vMmCC9IB786PvrrAZtoISZfidAdX4HL/Iy19HN0Fvne6oE3yN01LR3MMzFJdRty0Mkp7qNoeDQOcTSIYgYzgiYlLf1HtpftBbRSlHfIemtgH/Qb8F4DqIkaxgjM4MAxSoG6n/wg7frlQl+8N1wSVMs8rNvwwPdlTQ1xonODxCDQsrrYJZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(4744005)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pg0RIP3hV/bFiu3+IT6d0r09b5J+ViBkBRRJn0VwpCbfpmBCxOjN3QBTO6?=
 =?iso-8859-1?Q?gyZjQS4N06Q4onZN5wTKzd8SY0JgDaPOHY9aA6LaEmkZFTlvYt3tD+kDea?=
 =?iso-8859-1?Q?bAvydyOxzrqnHyWT+EtWzLovWowuUI+LqRRvOAcNx2SLk31jhD7D1k6hTF?=
 =?iso-8859-1?Q?0gUoM1BmCpkCoy5B5P2es2KvXTq1HXC4voTHD6oOQjp+TuCieYj8E3vmSD?=
 =?iso-8859-1?Q?c6DHtInYKX3NzKI4NjH3/AI1voUSpfbxxP0BMEx9dvYEJ9SWUbELOh43TM?=
 =?iso-8859-1?Q?oNM74HHs6sy5e34a8wlUIEWg4LdnMQ2QG+dVwwtQYr0w8w0G2JaD17ffjJ?=
 =?iso-8859-1?Q?CoL3T6annGV+lEE6Ty6kQHkR0MCI1i9PFiKwClrSC36gM6AyotxZp7rart?=
 =?iso-8859-1?Q?Va5XsOSMlYzfog8YVyQWVy/jExkadq4uQ4V8VIKIgty0Bq0Qif1CuZldBV?=
 =?iso-8859-1?Q?KocYWtt77lEn1gLx+wFU6If1DeebNq4eBrOVZS7I6euZRwrPp2pmRJQSLO?=
 =?iso-8859-1?Q?+HMyJPh71JCGyagRXHH+sRNi40NSEHh/akwa67ELLxq7ZGMHv0LfoJJKOv?=
 =?iso-8859-1?Q?Kv/rgc56dVSnBxCvixb2mdu/9hOx8AQhNVOzPIKS6DxOmbtL/DHjGYysce?=
 =?iso-8859-1?Q?Ll6qI5XFDddviE40d5W/mTBSEnT2i1xM7RTQ0389c5mlRybrZWJ6tXRDzD?=
 =?iso-8859-1?Q?xBmgD9BVgzMMrjM9aJ7mdvXEXfuorwtnm3EpTCqIoFwRjSh1bYaQtZy4Fx?=
 =?iso-8859-1?Q?vxgWbheg4ktIXtnlJ76aMphWOZJML5XO0LH7Rgw7xWe98RQn17fZhx3/dm?=
 =?iso-8859-1?Q?y6VgieOixt1cBHTno7Rk4oFvDH2+S60ZUeyqyu8nSyc6BN/xctQKAV39nb?=
 =?iso-8859-1?Q?6QgmlPVqcVQQt3cw6+1ru0ICTzn7xkWjHTpYmTKW2t4fOIh9wdLRudLHpW?=
 =?iso-8859-1?Q?IOmTqAkb3OsW8guMx0sErw7+OQFpKXw17kcSulsaK0AcHf/IzI7qSL3JHM?=
 =?iso-8859-1?Q?H5jAquN/IG4VDvRlIAUVwjkWPDmAr3wnHr1tuRwDhB28ufjEmAwmTb7U8k?=
 =?iso-8859-1?Q?JiU6h0Cw4kPRMiHfNdL5WasWqEOU7E2ZBBd1gkaA8anoLAZrKATuxsEpNQ?=
 =?iso-8859-1?Q?FGPTslsY4Hcv8SCxktRw1eb4k2A2D1PQiXWHLZGKZN2FQaDeKaLO2A0udb?=
 =?iso-8859-1?Q?d75Ao7DQb/uSraYaX6gwfV6uJi4p53cKuXvDI5G1MmnJd3idy58D9xxt38?=
 =?iso-8859-1?Q?yu8FGYGRbT9NKoCICR0PdfTk7qqugiLqbFnkJu1AWjwcZX2gf+oQB0VlgP?=
 =?iso-8859-1?Q?WYoQLOVGA1qGw/x7aHxtXigMekUVrTSr0X/rEXY9/5MLEniztfEh3E2SAQ?=
 =?iso-8859-1?Q?zerboWpVuj36RSFcPsRZnqoin+HeEHruGognkuxbXWqOG8A6z8vPSJPgj+?=
 =?iso-8859-1?Q?sIM/lC5yLrXK9bsW/Ag8fMOmU80OTsiukAp7Nv8ZAZWuUUERliMl4pNevv?=
 =?iso-8859-1?Q?XqXDQOUKTuuOoYA7/9Iwm5dRLo3aF1YRMgY19j6rTR1a5N28IWpkKSC82T?=
 =?iso-8859-1?Q?ybwdN81cQUYcZnAM32t4RwYNcjANXo0guVflNnR0T7Fb9cXtK6vnM6mgBk?=
 =?iso-8859-1?Q?IngbTOTsM+nkIrq3SkYaGosH9DjRgi8OFUKbaqeutkyrASjA00sZu3uA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358c322c-8c6b-4292-082a-08da844f5621
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:19.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvITvEP9kFBv5EDA+u1N2lC0IS/2mKxbW07BgOxjszthwIkqv7CUYY+ZVZeKwycWqC2LEqItXpTg9RVB/JzLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: 5bPswl0GzlNk7AY-uhrBW4s0Tf9MPgcD
X-Proofpoint-GUID: 5bPswl0GzlNk7AY-uhrBW4s0Tf9MPgcD
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

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
