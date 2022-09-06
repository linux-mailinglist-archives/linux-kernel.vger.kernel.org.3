Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D985AF4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiIFTtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIFTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337428A7F6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9gU019965;
        Tue, 6 Sep 2022 19:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=xlSFnxzx1pMphdg/iPYUpFtjRiSQnufnaqFF92dzrAZr5eEhx5nfWR+uRbbL+uIXiXUr
 bzB93kcMHEj7+SpTJcMMzAAPHvbE8qnzpN9dRmqn8oa3mnIRDaMoQiahinfWkgWujtaB
 14+nFFdqudxxx84/13Z0cwrZrweArzjmgBTtF2AXbFcXwe7yXlONioJdxcQgbU+8fhCd
 Ih2IlpTQWaNnXKc+VWhpHT/9qzEB1UiRGEcxbNFZqigjY8bPx91Xu19eB/rpqbkj9NJx
 /6RwccT4uH/flVmmIZKxtgzSZgF33wrfh/CdEnhilMzxV5Z1upyFON0RHO8mwYVh3Wun IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HHdKI037489;
        Tue, 6 Sep 2022 19:48:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mURKGuL//GbVhscrCbjd6iRGs5st5h3isG37a/I9jorThG0ZLo+vYDhezVpZ5QIcbQqsoRq8B5FZNv/L/SYJQZqX0piWtLElxdLR5OUvjA9urS4P2QHJPQDcFBUY9nSpxaBiIdnnRK8GcAtUB4GkIk6rK14JCycAEWGsUZreD00Nx9hKB19xolBzqvpOHUMXuWvixixtIJntfwWRmF67enf6dCYQBvAVoyOT8rZjBWBw39HJVGPjpQgQ6i4blLHDcOgFBdHEgl+3z7IPrcrYCo7EESbyufB/dL5tEDRycAMg3zG+ynIGXROI7eaiGNQVIDM8+geUv+ajFYBRjv/FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=Yfa9k+1ux4FtRdCuongiaDKmyBi28NN7Wr9FevWGN11zQC7UiJiHbQt3TX5cPHZvlZj7Sq902RTiBbZCRnsPAmbsxVAvrVuxqpc1I+GJ5kE5QZTQEU5l0vMAVKUw6QxYLEYXCL1yjjB9W4ynDC2B3nu/EUDj1MJHeO8pHVVoK9aWCILonaN0f121yuk7wx7l+Qjwger6gybYon9g71xI/GEvE7QeI0NUOJXcR2/cCQUmAH8Y+6+BGsmFZbV6Lf8a55j5YjOvLht9A5f7T/dlHupqKRGYGPfNVodSyMw7mC5OR8IctXj0txntO85bPT8lbxZ9r/RLdFPEJOs6OHiKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUu2GQ4uP+RysYobIs//6ncaOCZvvl9onwhVgCsrCgQ=;
 b=bsB1jqb1Nmcz0ISIKIFLcPzZguVTq7QPBiNKjQPW29UQpg8r1GVj4udTitCrx8qNiwV/b5mHkhms76DVISD09zYZEVNjBiZ0sMzHA8rj/w+vgA61fXx1jlAggQvMu2yl9iHkney9KHw46nMPZ8lb47Xo41ceDcI2mm9x1qz+sRc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 02/70] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v14 02/70] radix tree test suite: add pr_err define
Thread-Index: AQHYwimprsTHENaGm0+u+A2ABlRcmQ==
Date:   Tue, 6 Sep 2022 19:48:39 +0000
Message-ID: <20220906194824.2110408-3-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 700363c2-a9e9-4bff-6dcc-08da9040cbff
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eg5RvKiaS1IX5RFeCYpK3s1aP9D69XrNefXScIlozHMVkeDFD0o5HUsaZihSKsZRn+Ha2+Jg72A/3AjLCFmZieQYKdLX0M47mxISBDsiCzh01kM2ZFziDkZayJqxAjleWgbUo9etBltdtz3LwvUwPnLRrv8bHOX8lYmVi6nSp8H8TJObZXvUtpWZbxQ7X5qzGcSEPV/jksSUT+85BFtpUQTKwhYEE1oj5+dtoundCrPdkL19Yj/mcP2+9Q1lmMdY19p6Xzh6+uUjaUmyPDrMRabDkFFHeQqqMWYF1592YY6R/6qLLSixcIKR/lW81XlkIuhkaNnjHfs9vHWVbue4hhaK1b6jIsZW4i3jThNtWwOAvuqDfzI5nsVCwY2v1uIUm6DR2PM/1ZTJYm1SODrMIV9P+TwH4ykof1hiNYtem9eRqeXknKA8bnjCw6wbUZAKgqxlV9cTsJXJLzW3RKhRudo6nuYyvYwZ/ndCoKEFLevlKJzLDcUSHK4Rv79zlEcKXUs7psdp0xbyNOELXTNbN4JgorymL7g6pQ/9OwW7a/ic2y1fOeTbZHrYQoEyDep2u9I+FkbnLRIGEiRgSOKWJgXrKSSrkM0k+wI57ho3SPQoHizQqWJ622sXViRSLuobF+o3tga9qpAGZRbAfMVJ9nGGPzhioSWthnijmSEDw3TY8ihNbxEqw4/Ilq4Nl1/O0l+3azopfeZTAzzA9rbPjPkCK5FVaXQ9rCk83Lxcf/KlvrseZVreXXIh0OJrB4jZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(4744005)(8676002)(91956017)(36756003)(2616005)(186003)(107886003)(86362001)(1076003)(110136005)(44832011)(71200400001)(38070700005)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CwzvmU7jrX3wnCSL5kyKEMvxGIrIp3511zcg4oTddGxoeVCEQKWxCUEo2B?=
 =?iso-8859-1?Q?hdhYP9ARqdNv48lkT4sEUN+rCLwtw3nM29ENxKbM7+ylEpLZyb2kMo0ipb?=
 =?iso-8859-1?Q?/qk9xPpNl9nNMHnYOZsYAmgDUX/oH/PH+1CWqvTKjnoY2+qUG6Qyi/n1KC?=
 =?iso-8859-1?Q?OiO7TVPNdG/pbrpaNbU5JDBinxpFt65K1GWHCzX+gcXiDUMQkVSYwyGg+j?=
 =?iso-8859-1?Q?DismuIfl0oXTW1sT4skshbf7lPKYj/caX7uvXHR84IU6lSdDZ9NKS9Oo5S?=
 =?iso-8859-1?Q?2N2OfaM2fsY/2sELB/2FwAG4E0UwAwhp7CjtLy+xRtgugV4dOnH/kp2c5a?=
 =?iso-8859-1?Q?DE8JdcKd6Efq2mG2YWavix5U7RLEN8xaa+qrfRb4nqP/stvBJ0Mnkht49s?=
 =?iso-8859-1?Q?yL6jL7DS4ZI4H5a8b1KZ8gRAIddt8RfGclMmqNU9SNZ3y7z9ogGHrh0pqj?=
 =?iso-8859-1?Q?mecdybAkvHl2vN/gLS7Sa6sg3TSDszlbpRVlkIbL5cV43i183YMHwvuGQp?=
 =?iso-8859-1?Q?enLBRg/8uvPJTBgeO4dmK5+JUnN6riiaFemDW4wH5PdPHCwnTxYCeVQSjw?=
 =?iso-8859-1?Q?JH9rmP6ku13CGgkPESKo0ggBDrLQnfAYYmD0DD2v/iwvjNR4p26Nsn3F+W?=
 =?iso-8859-1?Q?E4Q7KmvBCAxpAT/l0Sro5dYUXHY+CY64RcZWGUFavbnDTndrDsEBXxOL0F?=
 =?iso-8859-1?Q?5rYVQ7UFKyBpKJGagLjPDgJyNNTeM4+UEDjl6T1ji2SPim8ItrhBRaALNm?=
 =?iso-8859-1?Q?XzIJtJwl8L2bIegF3aBU5qdjCyh75Bf2UBMTujj7+vgDvUlrjTD9epPne4?=
 =?iso-8859-1?Q?0OuqvPID4lc0nKi4POjml0Dz6kXtgviEsOJ94Fc3OYfiH8O0zY8kGY1Tag?=
 =?iso-8859-1?Q?uVT8vzJtd360Tj/aNMVKkIC5A/1Ws0nnu8QhC6wn4nP0GnlbYIszXP1fgo?=
 =?iso-8859-1?Q?2/2gayTozy5BqZr/Mm9oAwh8FR35NfUzZCT7qfo3q7XFkgWsSNQXvf07Ht?=
 =?iso-8859-1?Q?WxS/89VRC/vZoZHT3MlaAqYFXrNmuZ6RWzBohKuI1/vCnI85UG0e12G5xD?=
 =?iso-8859-1?Q?5fjEx5ZwCdfMrR0/Oc5quc8ot5+eKc1UU1mGfFdG5cyY/HcSMDAQcl+Hq1?=
 =?iso-8859-1?Q?6djOOgrEOBTZQANygSh2vS/dn6qni4vGJk0CtbY2tFQaS8lztO+NIJjcqM?=
 =?iso-8859-1?Q?QApYrnYN96/+Edo7sf3e7Pkzg+NMElNM8JDKNp+5GkMikLsqdLa//76ncb?=
 =?iso-8859-1?Q?vk3EhQhQaAPsuB6x0cw8+el1VLvY0Q87JeuWUGjZwRNZY0uIoYCe63vt89?=
 =?iso-8859-1?Q?XuvEUxs+eiLR9CkaMA5zIb5y21lhElClpPx5znWpwIMlkDCeQOS6kK/Uza?=
 =?iso-8859-1?Q?Q4GZwPLuieDScy4ddwEpR5vTVAeQh/2D+j2gswCAZG/BiDsrqVaiisOy6O?=
 =?iso-8859-1?Q?y6oysxsAYWz9yN8KmzpBkOXvZXvMJSeC9bvi1RsIszR66x2PLRrRr+umv5?=
 =?iso-8859-1?Q?cOxF2AICXDPE/oYAazXze9e0oKRTuglkH+wU/mHsLsfjhTrVKoSh4MOL8j?=
 =?iso-8859-1?Q?9MHqGPXQjEBhlW81omHXvxInuk4udaaeG/X+i9UjspqozC380mn43a8a48?=
 =?iso-8859-1?Q?+8sf+4CuvHrAurtcFxco/rXuhlxTIIJSiK0w1NiTU5RWYoL1jdargTtQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700363c2-a9e9-4bff-6dcc-08da9040cbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:39.8824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CwkjmxkZI4kU36yR/cMlRRTihVBr+LP893TQk92XdL319ySAdskbs+PukpafSkV+Ib6R2xqXx6+N4QzpdBvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: k1ehD-0_gMW-apE3HWdscaailQlRrDJH
X-Proofpoint-ORIG-GUID: k1ehD-0_gMW-apE3HWdscaailQlRrDJH
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
