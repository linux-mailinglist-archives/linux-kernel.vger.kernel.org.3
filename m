Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9BF59BD7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiHVKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHVKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:19:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6EC13F63;
        Mon, 22 Aug 2022 03:19:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MA5fik005803;
        Mon, 22 Aug 2022 10:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6DK9CQElqdoyqaUXts0NbOYao3Vo8Di7W1eEMnk1U8c=;
 b=3Rh/CnRRty0njUZOM0mPdo/M0Xj+bm8HmAUQyZAS3ZN29QNyFHCNW2phNlYX5AUCHbBr
 dkQHWOAiYqqW+oqAGHrcYfztAP4XRwgzA4xMthlEetHXXo1bz2QL9la3r1jQDUAgMOSX
 Z+uF/2UO2I0qjcdvwsGl4gVRVG9P0UOlD02hxZADDI85xnGh9nWjhABEDwlpprxXExQ1
 mNWX7VLp5twkqRtd7J6jzmBuVUIe0zbWcYWomanjonYmQwva3SFNQSCw1e3isTS5mYy4
 zytItVG1c1CvPYJPVzVVvlsLxhOYRmbxFSNvQsANXqqNMJL5/gHPNE8FB0zuqEA4/Eo/ QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j47r2g0yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 10:19:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8nQ9s011357;
        Mon, 22 Aug 2022 10:19:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm83n07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 10:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6rFQks6MmbXheEfkNjRb8zuj3nWr5mnk7cvMUw2uJrwsYeq4jLSQv0dUGww4yBhW0m0Opft26KyzvivUtYB+Vt/oo/NeJKZzrh9AiV1tu9wf4myxgqxt4K82GQsbJb/cY2USrtHX3INFEbkr5QSJNsk08q8VSI80zLOCIGcrlOUr2DVufkejz4L0x6E0ySOoqc6a6b9XwtqrorxmCiAp9NDUYY93ZSMfyCOGktocyFku6NIBybeneJCHBHYNAj+XoLKETXX/Yeef4TYQZjPuDL7xi70Hr8Axb3MCkB02lfh5pD3Q6LYbECb2gyUhSWqMqBDVh3X+Z4YRGnScuYv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DK9CQElqdoyqaUXts0NbOYao3Vo8Di7W1eEMnk1U8c=;
 b=RkytWZ7bCDsfjWwQzdYTgOkfMmkCNgh7o5gM4uhAA+M79svd0Boy8wQU80rdEphKG2fuOMpYv4zerm7uZgqLYH+/St9aDBhRIig/ETqMck0MtBfUtDzR2gSaXSzMvx1xbaJhVrZggQzhXTeJciddEW/XaPBBXNIzWxVQn5eOrNoY1MT60sOSmb/DjgiqzECFViqYRcqGfU2AN+8mh/FkdyjdooxoPUlc303wGmKE+ufLS27uf/yZQNdNbJY8j8QwE1Cz1hER5H/0XvovBS+Zwz6R6/x7/DDm7pEXvExhxGpAc8+8gECsit4qovoFLQV07x31hQQqFqGHQ7HKGse1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DK9CQElqdoyqaUXts0NbOYao3Vo8Di7W1eEMnk1U8c=;
 b=LeweUWdG3Jo2tBwd7qFRI3kHqb62mp8f38FZvITulnWIzbA953Z7othdS9p0Fi1P+viy0HXcGBzzNRhNvmUhpqz/QPe9tg5sotjXLkD/BBsahzW7syJzp80Ak07/TEJ6XgPRnpQHOHMACMisZ3hpylRwRn5WBgreaDrkWQYHHh8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2800.namprd10.prod.outlook.com
 (2603:10b6:805:db::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 10:19:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 10:19:13 +0000
Date:   Mon, 22 Aug 2022 13:18:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: dw100: Fix an error handling path in dw100_probe()
Message-ID: <20220822101851.GC2695@kadam>
References: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0410e9-a8a8-4ea5-2b6c-08da8427c211
X-MS-TrafficTypeDiagnostic: SN6PR10MB2800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIhpFSj5MtWj2bdpbgdiA+gjeBP89WfgdXLzdvRv/Rp7Pn7qTY+vOoN2erS9+EeZFEfOpVHSwfBspPbMKmxQ/nulWQuJ1oUXCpBLKFSW52dNIzVW1wcx8IBV+mq2ewlkxF6tcqRhrBEjyWhkvvVcvMoc+eABmUKSDHfWHSULNONotIyQm/3RPDUhLPbh0KYR4+D+CFs9tJMl108e0mkW+83DJo63aoHqHSZ1+MUWQz1z8/APq0sx0PhBifZmXSJxwct/sA5BKgFu36VZKyOIFY/Yi7cyvMzgocMK9TdlCF7P1SMW0GfSAd2QRlrJD4hvxNaGguQG4KBIXh1/5Utabja3scx6+7nj/mK3YIVdh0cP5eub8zgpLQRsxdacA8rQZs6WRRbBDUvyqsW1GRKwd2fIgb071NQrSNpmML8MEFdGbTflPdTQfXWfJ46SdbyQalrQG+jHL5EVL1NaLH/1gXWFXvsc1nyLJW2GKtlrSwmez0KI/Hml6VC57Bl5vAqgAiyZtZxps5X0njiQ2PA2w53plUpZGuR20LCpHNXwx8LhO1/hszrfq4HDkV50Cy/AoaJBRyKSpJEcWRt5dF1e65ro7Cw3jvb3oAy4C8vlQ7Usz6ctqvCs2v4MEcWxkPgxyrYdkl57VPKd7an6PLV/yPCg8Mf8V+HuTV52jfAP1j3RfqMd78JyS5MjkD+cJCEcmk5DlLvf492V59HoQfkxzDBRHXj5D9gfd1NuwN+OPfgTaqQnh12Nbyn2ddu+V8MpMsxoi798nei2QfnCG5PRAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(136003)(39860400002)(396003)(33716001)(86362001)(558084003)(33656002)(38100700002)(38350700002)(316002)(5660300002)(6666004)(44832011)(8936002)(4326008)(6916009)(54906003)(8676002)(6486002)(66476007)(66946007)(66556008)(1076003)(186003)(2906002)(26005)(52116002)(6506007)(41300700001)(478600001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WfD0zhfYr3b4WUp1XuBh/6snlAuFx7ryk8EA3MXg7+gZ5/NOAMblHFck4bpw?=
 =?us-ascii?Q?znJlNMaKu+xeeGYxXR9eJWRlwcADars3Dw0OwCn+2iRf/sJMh4MbqLTdcuGb?=
 =?us-ascii?Q?bNgmysc9M5RK47gq1KnK6Fk07RgshdPbVqmERxQIEvGMixX+xOQ4xpNPbSgG?=
 =?us-ascii?Q?dGTPntltOr9E6G5WQ+1ufw9FQctHOMObtR8h/vtyxPhp9PAU7rx2/elmQRbG?=
 =?us-ascii?Q?xZhv/qe+R9AFfLghJSlksiA/eMLutPp8HuY2hYS0DnV4uDA9x6n0db66bwvh?=
 =?us-ascii?Q?NPvRiWyrQ7PWdY2EVDvsVFaa3q9tt3HEdBbSDg/yRshj7UYSKKULM37HaB3J?=
 =?us-ascii?Q?zp1Kvx5LyKF1A7l2nJVbcFwl2hQ41Q9HcHQfKkkXERcYbcXJNxAGfvA2G3RN?=
 =?us-ascii?Q?bEdV6nqlmiaAwGsVIKx3ao/v4QZF6t6zM2uMBMsZG5mHeShJ0oYiiV/VmKRp?=
 =?us-ascii?Q?/D4T1FeAGHDD9Ps9Ozq1tnGLYesRaRd0hiBERm7ypu6iwauqeiwun5AUqdOO?=
 =?us-ascii?Q?cOrU9UHHCBBiyl75SRY6JoB7C6/2hCmXpYD9R++eZ2V2u9tWb6x6GvxxWWf6?=
 =?us-ascii?Q?9q+NJlvKZsVmM2cOBVlYS2jWPKnPDkDZqGG4Vb6Dx3mNy7rzmwWoG+GlRnc5?=
 =?us-ascii?Q?1SkCNLFX8pjUNUC1yvX2iZT/jaNXAX2pOL9BRABH7t76/k9cVTACehuT2Blt?=
 =?us-ascii?Q?bKH6H2edpINywiqj4aSE9sTKMiOWCMLeHqkRfHXNm6Z+7E/p9vHPz+5lWdLj?=
 =?us-ascii?Q?BtighyCZKOc43u1KyamA3NMiM2MTq5gn/HoyzrgWG5Y5fFWB1h+t24etlkh7?=
 =?us-ascii?Q?rSQI3OBfSjsy+HoDoeJiLajRyRU7CNd5xUhR7Ik0/XZbtmBW9Kfy46ylkt9w?=
 =?us-ascii?Q?Vgrr9XvkmaybEExgwhsV3sKrtlZXryocamNfOXQdluPYEjWY7jSodKBUaSpQ?=
 =?us-ascii?Q?0jdi1otTQVbciAZxkqiizk+SVeMpKYXTtSSeGFuMpKDk8X7Q3pyTprjq/QV8?=
 =?us-ascii?Q?qqzIRvbaHBbZEraOSNgsmUIyk+SV7S95zZa5kMzkaQzOkKeQ8tBmGlQ2bgU9?=
 =?us-ascii?Q?3LmVOc5Icf3PA+19tZsglwydBLYWldueMliPak2rOgZB0huj3CtbKtSzB+L2?=
 =?us-ascii?Q?LR+KLADgvdQbiFjYpyDKHVfL0IQlDeHlTCo11eZUZe1DIU/9nXj2u1LX/TGZ?=
 =?us-ascii?Q?X5yD+lS2a2UYBjqaLGQ/x8uEDirwkuBq0Sgd4KMn2IHtuKdxGuDOEeFYPURv?=
 =?us-ascii?Q?vjiSwgzvI7FWPDgC7kZCzWUYYK90JWYhjLfHbEb1JshFkbAmxv7essGAnWAV?=
 =?us-ascii?Q?I8aNl35m50fGWoQMoM4+6Re2VgNQsIaN1SAiZrC0hsXASzvz60OzroiYzhkl?=
 =?us-ascii?Q?9tDp4PokqjpSbZg5K/EX0hkFbfiQ0KgmUYmC4I3Sxhb+u9mZwm8aIt1Z8xNH?=
 =?us-ascii?Q?WpWR95KZ8zFuRZvKJLkxdy4W8okGaiAl9Dy6BJStZkyFOgbGYLgOZZw/R2I8?=
 =?us-ascii?Q?1PmP+4iheVJ/F2I7UD1iAVkosjjP/t69NgsFV9qHgW4mkCAiF3ngfJYA8R2G?=
 =?us-ascii?Q?KLLCPbOPsAt2DdcJk6dNRrwRFGa0PfrpuPfcrz9taz4KO1jP/GMCkzzQaRXo?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0410e9-a8a8-4ea5-2b6c-08da8427c211
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 10:19:13.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FI0PgwLZDgTQ7ofD5zk1iWbtNIgUmlfPb2w/BqaVInSv3JrDhpkyRCREwxsiP5rgVrw2ImgxJJiQpzWK1QJLELyI7wg51MyKCQvA/O75vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_05,2022-08-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=838
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220044
X-Proofpoint-GUID: glA-sPgh26c6f1BbPFgO4FInJzamh5QM
X-Proofpoint-ORIG-GUID: glA-sPgh26c6f1BbPFgO4FInJzamh5QM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:40:43AM +0200, Christophe JAILLET wrote:
> After a successful call to media_device_init() it is safer to call
> media_device_init().

s/media_device_init/media_device_cleanup/.

regards,
dan carpenter
