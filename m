Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F3561F19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiF3PUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiF3PUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:20:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A1381A8;
        Thu, 30 Jun 2022 08:20:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEqUia009852;
        Thu, 30 Jun 2022 15:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jl38j8U3A60oXE+4oXWPx0UcVEskq4/WnHaz3YlZVLQ=;
 b=XKSJvgwHlm/uj1igT+h3/hMaL0Y78rOIXUJKUja+u0iUvaNbPkxmQtK1vqE6QVlQTknS
 nk0m56DodQmnmQAJivQxYLe4kL0DTWgYvO+Un+ASPjkGnFsX4NALtA9DM4lxsM2VNqL0
 IDA0nj6f3wVdOcXfvJJcmSKTypL57nwqdWJhOD/rYG4uS3i2MlOP+3rZ4dcz1XnzdBBI
 yMD+9knvc6EYV9/5zj0/9J+GUJ1/aiw+rrwuM7KJStMrq5HBkaW+nwzta/75Lr2I+5aO
 ghzeqKjLPZwOD4PKCBXraGF4+dJ3UjO/jKFqgqSN/EC5XfAvz/Ry4PMNEEXBqt9x9dT2 GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwucrcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:20:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UFB0Dm023073;
        Thu, 30 Jun 2022 15:20:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrta40gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kffpiSg5Tv5d39IQK1msHkzrevGQk8eMwr6pf/JYAT1fueVGW1ws+Qz3t2NP9LBz/papp5/TPqq31jh05+N8GtLhd4O1dCVZSBUtnTlh1KCfGFmdwk67wSOku1lv5OYnK25fJgkgl1a/mS/x+ZVprhtSFpiFf0bSXWMD4+j8LzGwiJt2sRWHMS/WSN9a1zY/5z9wcgfu5UE1RpiiLSADR/o+lwO0WHUITq3SDN7kDntTWRd+ejWgmaQp4oiwbyFswA9adA4gkww2K7EL8vVInwSbwY+JHW1ZTd6N7UzhKpeoOTtBEh7rPvqUeIeGFzXPlyCDG9EO2sRAcPPxO29sUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl38j8U3A60oXE+4oXWPx0UcVEskq4/WnHaz3YlZVLQ=;
 b=aXUu7RyOOXGKSOiN174UNio5f9g5s+RrfvwBecgpaSdOdeuLG37cIWYi9hcD79xHMl9kSkNyi2KksqEdPBAMEpQCJrp9a82sOKfEll66/AAFP06iYWZCpgMm2edUJlVmXHvMldCHHvsHHdY9RyyAkkfUlVfFlFCAXGO33fhlTKmv4jvf1l4xeDGCD5obO5taS5J7NJaYPfhMhU0NlkrWrr37qH4sanCfyFrErVUOXI1UceMn2jsrcXpeypZsi7BM886n5c9/kjUeyTotT4T3/mDPCpTkhJXfpJYi+Gj23nfa9N36Mp0klgKviKj5gz1KHaiOL+4PTuHzB+xGMSp7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl38j8U3A60oXE+4oXWPx0UcVEskq4/WnHaz3YlZVLQ=;
 b=vgFWXKHmqVlJsT/WeHQeyoVrQYQLlDYYbSoaZSGZ+3/ZW6nbQ104vRNdRq7t3w0YBNIdHZ9ZczolWnGZ589VbgWS0rXLtMZw3qFAR46VTfcAi3L8J+NbK4iUrN4LvWLAUiHiwnv9vAIQFixLD2RSwj6FQtvLAbp1OaUPgIJR5Qg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 15:20:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 15:20:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Thread-Topic: linux-next: Fixes tag needs some work in the mm tree
Thread-Index: AQHYjDIKc7O54eZ+20OT7XXDs3auca1oEVYA
Date:   Thu, 30 Jun 2022 15:20:09 +0000
Message-ID: <20220630152000.atnwbnan6hctflar@revolver>
References: <20220630133206.4fb988b3@canb.auug.org.au>
In-Reply-To: <20220630133206.4fb988b3@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65fe4937-e36e-44c9-17ea-08da5aac0524
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fGcWDnA4G0xQAQW+45Sjq5aas74rno4XIIh/JCMLgvBEkgd2UR/Dk2WHhV5PK9RRUXV0eSTNCxW+CCxc6XyTwDeuhxGISjos3pqHDLb5aa/6iLKdLFImKtaE5kyYONMEjBtd9RaUJ0y1JMXvLak+cByU0zOjt6c/NF4y+YP88Wc1GjiOR/Wq9Vh3Auqmo7cIrvfpcaV5tXQM/kt+Yor87IEgElYM9Tl+uJrJ/fqrj5KdDQDssDmovXLcpI++bYubznNzG4x+/+GEAPqWNTUsv685J4tg85MbBFUaqPtr1zacsZ9UY2CZ9xQRAWEeNF9XGfWavK338FDh1Kj8LQZM23mJFAficSHSaBp2fdx5k/tHeFfiZghwUpyDbFGOMHxWs0OX7WAGCRsXOVdN5n0oB1TuoXfR8vldNHiNjtT/aAZVT11j98m6GR4fC2xqGBes78EHgb3o3Nwqkc6Df6qUIyOBuXyPXDRLJzZT2qVCjKzc4z/t5Yig01k7DbZ+od328n3LlQehZcfSxSY416USAgMY6lau7GZjXfPmr8nZEy4Olj2XFQKvzLqDLV5ZpvQR+KTXM4CKYHyexhoqhMK2ioTxoQXCzyNOzFS4HpqceAYZhixx00vxVpoukc7UOaXJHUL5DRXrTUam8G4L8hLUeeiFHu80uM5Fnrs2IB5u94Zd0dzMXDwI765xsdAuncd/DpyxPjrREHnLt53IdAvtY8dldLPiVUnxn5xEg9HxJ7EZv+V8m2nf32NVujpEkR7s2Qm+SOeH++a73Mw0Uv15cG+xFbmNvyJq1znT6Uaxon+OrvIkZBUEZdpZUkoS4gQB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(316002)(26005)(54906003)(6916009)(6512007)(38100700002)(478600001)(83380400001)(9686003)(5660300002)(66446008)(86362001)(4326008)(64756008)(6506007)(91956017)(186003)(38070700005)(33716001)(66556008)(66946007)(76116006)(71200400001)(8676002)(2906002)(122000001)(4744005)(41300700001)(44832011)(66476007)(6486002)(1076003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q2Yn1yqcsWx6T6Yf5KmOlxKSp+OYVomIavE2pmfEQQbg+xTXK5ghxUbhXAcL?=
 =?us-ascii?Q?Qt3dvsA/2pIfiJS7RJtPRliLafUA+Xlh0HkI90HEthrWZJJH0FJj4JzvYd63?=
 =?us-ascii?Q?mc/G+DD6/l7VS6L0KYELxLL4BXFydj9qKGAZ+19WdediE1Kd8fZjlxpZqQap?=
 =?us-ascii?Q?p2kUSPapw60vL7uv6J15Iv1FrNlu2ZZSd2M8BGT7lFx16PYUYN9BgeHzCdBu?=
 =?us-ascii?Q?IkxhatpKUB5lbHSuzDnO5DzkYoLCsKLDwbXuukn2dGEK/sjkQoXGx9gWP4Sm?=
 =?us-ascii?Q?GWloRRGvZ5HuDN3SKnnqnh5+RXgBeW4bZMEo7YadmO4i9BCK6UvtjVTHJkDs?=
 =?us-ascii?Q?DuRlLf5BiPCZzCGvFnVwETqlRBDEjlLBZFev+7U/VXFsq/TWS/ngdOXpqsdU?=
 =?us-ascii?Q?0b/lQJ9Kp66e2aKHqnNacpPKqQmnbcRzLarRzM34WbtmYwkFW5qkTk8e+Jfz?=
 =?us-ascii?Q?0DNN5mFzbX0+JzHw3XBcsXmtHZczxPqC9xpwKZioeQn06Ym/31lmHL59eUUs?=
 =?us-ascii?Q?FwE+StTJIQNY+Zxj1vLlp+yGI5fNmeziNvl28tVT/EvVSn9DqI4wzNwuG26s?=
 =?us-ascii?Q?w7yYyrmxqIYCUnSvSGs3YYIsiJQrOLEuLW966CRZzPALCYHvYw06CXQnqH04?=
 =?us-ascii?Q?NaXE/oLFG0ZlNPcIiQh9sPRtTEpA3HOkyFkpMBZGKT/iYZj5RXqYgW5WwDZf?=
 =?us-ascii?Q?l8CnJjjJQfalpedybQr1A0wYMhlQKYpag4m202KY8z6/mASaA2agI7WnoMk4?=
 =?us-ascii?Q?HizcOWOsC7dt1O4ysCcOM311YoCriUo/UVgJeL35bQKHMtPif5y1JNvPvh4s?=
 =?us-ascii?Q?1hwi/tHN+iBMMr0MOSqbsQRsQvx7eb8bxVAnMD5CvkRbP40IZ4ZmMdKsUdP+?=
 =?us-ascii?Q?xinBhrE4AoUq/bwlb5b23FLx3yIqZUxQdVogmnJoqxQXpNKKjJFOYE2H1lgf?=
 =?us-ascii?Q?WtBxDBl6uI+iAhiJYfbRm7FwEao3i5YyBXEYDFzHcbvMUl996LP54N0yFLxT?=
 =?us-ascii?Q?4De6AVZ3fMqoW/hYcTIRI70UT1xLjfcm1k02K87hdVX0n+NBW+XNoiR+MID5?=
 =?us-ascii?Q?IbjBk+n1hH1WobZoq2Rqni0CQr3/emOFwWkknpSeiEu0g4g47fxdDjko3Qj7?=
 =?us-ascii?Q?QEcGuo2wHmAd4gytv1VMPoRXYjPqeTqUZrBTqOKnR6F+CRmSOhH0jKzCQYAE?=
 =?us-ascii?Q?/X7FEOqa1MEc+u+MQxvVHSBxXm/1vVInje5TKarL6mrZWua1XCkmmewZo2qz?=
 =?us-ascii?Q?2VjYoPqMovVvNAN3HlAL6ys4nPoVDUKRM8oeSJalXUg7fKS9hlBWoYBZ9QbE?=
 =?us-ascii?Q?mvAc4ewInUk3JKxmKFHp4lOsX3DU/q7shulrykgbmkSHGx5KMz5JrDbd4J/S?=
 =?us-ascii?Q?2hMUbnTyBb+I1GSe/1//kxMyZyY1GjcVEmhwLaRoS7PDv3Z9aLA0FUl0Lu8l?=
 =?us-ascii?Q?o+aeh/9EqgLyaEsrnK72T/YaCjWdeBr7ua2rwMNfY9Xh+tlwgsD0ovdzbeid?=
 =?us-ascii?Q?JRpaums60Nhs4Xy1lxqU1hPM4XbltkyYP3vANWww1p8UiOWaSwUw1XiraGMi?=
 =?us-ascii?Q?v9tuc0dK2w8sl7roxjrWHVCSmz88bSZGIIEIPT0NGViWgcXC06chPUtzkGG3?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEA06BABC71D6240962DAE8BFFAB1EF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fe4937-e36e-44c9-17ea-08da5aac0524
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 15:20:09.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5toJIeYlvdcEQWHy3Kq1c2RLQsjgwOiqL8qnFZrX1uFeQpUbbkz7vqJkTYfjOUfY78ouIomIijqAQS7K+BDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5563
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_10:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=853
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300061
X-Proofpoint-ORIG-GUID: 5gvvDwptNS2V0-HwE7Z94OjEUOKElXTU
X-Proofpoint-GUID: 5gvvDwptNS2V0-HwE7Z94OjEUOKElXTU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [220629 23:32]:
> Hi all,
>=20
> In commit
>=20
>   c0e9a439da6d ("mm/mmap: reorder validate_mm_mt() checks")
>=20
> Fixes tag
>=20
>   Fixes: de4583ed958b (mm: start tracking VMAs with maple tree)
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: ade97595a8fb ("mm: start tracking VMAs with maple tree")
>=20

Yes, that looks right.=
