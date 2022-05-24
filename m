Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CC532159
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiEXC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiEXC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:58:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8A9CF02;
        Mon, 23 May 2022 19:58:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhwa8032382;
        Tue, 24 May 2022 02:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=hn/0375+dgbPQc4XdSFySUA3tTp9ri4ZdFjp1GI5U0s68hLX1EMWEl1R9EcYTA0e4Fl9
 08rXbm81lJ1+A0sIQw+fIt1rnCf/yS0JazE4+v7qQjP5HqBfyXr+PKDwuA2eWJxtGUkH
 ZS6oU+DDK9jTePV8X0qUltsRoPiuOoWO4pcCn8odrMWygBpHOBsSqx5Q0ZLVTNIP0mXb
 q1Sn3C0Qpv+cgPMlTSXbggF7SZtcH490Sjh5QPwuCIbhqzeUyR5Eq8OYCoaEFERrkuXz
 Uba2XXjB5tfPFC11wE+am0RjMjHlyOfVgVaCbOzja9ES7hDu390i7rs7NMXwDFLU8K9/ WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtw1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2uIaa013622;
        Tue, 24 May 2022 02:58:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph28h14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc/7tg4cCk8t/ICo2NpgadC0cVcJb/fcqUpYx1vOo7aR6YC1qPE0Yrgl7+ioyK8ifQbf/x9sQ+7U3kxaBDJMx7PqA0o1dxenD87trsDJxj9HQqhoylAr9uU0WwAsJ8+LShFaT2iRLcWltI5j+D5zOmIUx86njAW1hYMVvq5Tn0XXfbJCbPGMfyAg9GjIk50sK65X8bT/nVMJE/df8XZqajEThUtjDiObrSgwbmJiNpFsaH/HlHDEioE3jD2ZbAV4xguaV4Cuju7bLjHgG5DYUJR2VHIyIf6BiSm+p5RQQO6xP2KQmCWC6bDuPNZ8jdfaAh2To5J1wXAOnYtdJlgpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=OyJGMMQj4QUK3f2IieIcm9Ut+alUGXNdS2f7a/ukjJkwurDawCJfH4IkuQfnHfWu1Rt6cOs+4Lr+UUqYc6Zz4wcA6V8IUEFEL17xZ4KTnnSz7onnlBsjPkG6cBykTvIvk0uC9NNVgjq5htjhErXGu9BvMQo0Bp4PG40qVpqh3dy7uebTLioDpXxGclGCBQ8r1cz7TwjY+dAHHNgn/ZjugEhgcS6/lcRdo7zQdwoSKU7iKscyh75wP1Sr8Hmh7j8xu5leOBr+iQOWR8vRR0k/D862rlqE4LWo1piQcxvrL6m0pw7fFv9m0tZARWitoIbPtkT9zsvAkiTAxanoeq4FYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=MJSgSk8bM3L+KrZas6msrQDCZKp/iihAD7KbJ4Fn0VyDzsk9jHIY7XpkbWOVxLKib/4AAH2HsixV7+EhpAnVArTJym50i1ok+XU9FdMQJMNVq54plK+RnSe6vl6APkKF6mT+ffTy8nYtzR7RVFZUdIKNgSNtr+maVdGOiAcUqX8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:58:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:58:30 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Don Brace <don.brace@microchip.com>,
        kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: smartpqi: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ylviqlt.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-58-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:58:28 -0400
In-Reply-To: <20220521111145.81697-58-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:11:08 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91827298-a5e7-429b-680c-08da3d31484f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468533DEF23BB67DC389013C8ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIudHdSU5mj+TPja+M24rb/muqqj7EdagUSDHj25YLuFwpQtPWa79TrQqJe+bjEBztYpIpwJ7KEr63tnCyX1DGtNT+cqgbH1nqRKBkQes43nvGJHAuv5t076jW2GbbRah4EY1CU1M2x0E9OHCOE3G9VhnLNudw/PwuuZgwUz4dwhxlMt5/hYBwEzb/kHNYhla2TmcJq5UUuZEODyWn4K7RSIEbSXj8wc/xPR0I/JIUUqBHHKL4YCq9u3ZsrGiz6vn8eracHnKXfrG4qeLdOZs++5OF4qmjxknANciq5Rupm+ObwS/4f+ejC/WOMCt6zB5QXx6b6uL3gH0HJDTgE9NB/az7SgUn6sznLRp4Kx5aP70gNVLw2ETc3Kw2ZI5/aSBGseKwuJ2MOwWUVZQ/m1HG7IaPLbzElV6FfdmCzRTeoveR8an89zuL+jOiyNxsH9j6wJQhZs3vgVmWk3wDte3EuZSLCc3K9epK1QacafnbSh4q29hNmYFRBk6j4SfdABKalHjxvIULrKtDDlkV3ghyuUy4LGxpX6clxm73eU35zX7vUl5D1bC5CdoUhHGemMctUCN4DrjV08DgspQAMt3EmswWMGDAjIcUAzCMqAIQWYqUCBNW1+nuTjmyZn67NeWDahWnQHlvQguscCWlbgUIz97VTePCPm/+g+/y/Hbxr+XBIaPPfFIPf7qJqmjZbZW6YXcPqY+iLkT+ek4WsvOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O56kBRU0E7AzY+87obCV7rrhJHhUGD0RgjoCQD37oZgrULa+NoOuJwve5t0v?=
 =?us-ascii?Q?uKkgO6GclV2m8HY15zl0kxVSPnYy39DKlf7/oMfB8RwOdjB4ySrENXfhcn8n?=
 =?us-ascii?Q?RJNnIxANBnrGNqx/HPRsxfxVGwptSbcHSE8IkOxQsYoBc3raCAva6GxgLUtB?=
 =?us-ascii?Q?dRrTLEl2wevi46LCf1yl+K5vWyge5jeRBchQ2m2UtSvMfFlZ6AZi0moVJFjF?=
 =?us-ascii?Q?M/DvaoLYCl29f+yjF19v0kEhHbiFqVz4LNIvV/m/yLYSActSobt499ENKDfd?=
 =?us-ascii?Q?q3CH2XZ/ba88nlCrqaPT2FdyIhY/gHMpPvUrTFigGMRLDYmEQrUurFh9e1c0?=
 =?us-ascii?Q?OpjJh+GsxxOv2L4xa2XMruUetCeCyJYGedEpryrEJWbS5vHTZB1oU67utrIW?=
 =?us-ascii?Q?j7YXX4S6gFka4M2m0CfY3sQ8xONZv2RRRY3g+POWlM5PnmD/nKUVN5Kjp0Fd?=
 =?us-ascii?Q?rCWVCan/M+frkWTA0U9CoaBxuYRnFUhcrGEpKywlHrsCyev9HKF7v3gE8e0V?=
 =?us-ascii?Q?qWPzKV7TB+vRhWPATphMnAEI4jrvFU2VBC9Alty9shQDgP+uxMbtu835QS4o?=
 =?us-ascii?Q?tP8XIdHtmDyDR1QdY02bV/Y86CBHZen9MG1ZtIdA/hNIBaxAM2nex4Ocb4z5?=
 =?us-ascii?Q?nBjRxIvfGNgeqbqo/iPWARXUQb0UXPO/RLj1WSJQWLKey6jy57CITF8KR8U5?=
 =?us-ascii?Q?kzEzBncQmcxCCJukHuAuMKckqeyBsALUKB/rYwLu0glJzJk4vdQda20Cbc6/?=
 =?us-ascii?Q?7d4lZj3YB7E9Ie9fXeKOM+5iW/0owCvtH+7cDpNf6kZ6Fbao8hjHohf8csBT?=
 =?us-ascii?Q?lq4XIOuakp4jiLcr6cwYi7Ewd1eVYUx0m88FZKOtejLbRN2Erp+bb4KlP1Iw?=
 =?us-ascii?Q?YertihXVLTjlM5ep4YRL2M639zOZguoEDPJWl93/ZuBXDVOO769q0l+RjmWR?=
 =?us-ascii?Q?7mSlLqnPrX0Ky0bNDINZDx3ogHSUlvlap0ewgBFliJcqO0cXB4ZZWSFsbKzM?=
 =?us-ascii?Q?BPvnIHmVJwgNSYObGLIRSivNHJocTw7m28j/zL75PAvMxOOJB200Ur17dVsr?=
 =?us-ascii?Q?CWKZ/4C7admPXAth40YWzDiPhhWTdSju5/ry22mCZ2WTZPxulrs9Rl2z2MCn?=
 =?us-ascii?Q?uOgkqXVym2XYGTSs1NmlfZMf1h7XwADWKr3CpbKF+GaI4Vg+ETdZ6B+30lWD?=
 =?us-ascii?Q?Lpztmiw5w3P3Ww9ve6lYG0UADvVQupYKqvik3gC20cC8B1gqEXJLaNkNmkAE?=
 =?us-ascii?Q?OfwF6duHSGEW5AGRixlF96dHGVdT6qYVwDlaaYoMrXZxZYA5UT72mfqvstkA?=
 =?us-ascii?Q?wL2LthrpL70MJIVXHePe6bEHwDHBwgyY3uCt4m42veVS2t/Mrp51aEIm4VZR?=
 =?us-ascii?Q?3DsaXlRZV7Wmk4TolQYDNtX/TP/O4EePXCwfEedqvbdtdiTXjlOjyOIgGye8?=
 =?us-ascii?Q?ZCL9DZygiPHdiULU9GNnKJEwtqbCDngG/sVhY2TCAy/KSEduv9oUU8ovBPIm?=
 =?us-ascii?Q?+mU0BOGIGUJxn55E+QQfPZU/4PbEq5EsbWyLjU2eBO3bnZurJHSYSJcJMNn5?=
 =?us-ascii?Q?oeXCSRdYC6CrSLktgKfcyJHR3CEllvIGqArRl9KPioLEpvOn5rwNo8U78vBg?=
 =?us-ascii?Q?dMOHRxWIq/tAoRcB+bh2lkw6qY7r68ATpZi6FeO0lLvSakDeLeTomU4NEau0?=
 =?us-ascii?Q?q5f0qUbPrmhXYvsMVc4EN83OaAJdd2jNe0I38+NEQXZ4fbKNodtuSnEF/jno?=
 =?us-ascii?Q?9Ho4JHkH06lcajeKsQtbKkixY4EnT6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91827298-a5e7-429b-680c-08da3d31484f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:58:30.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q714OTqEJpiFb7wZ0NLElJd2EuCCgREPqu6sVVFS2iau7jh2hyqEWLqDzqKSmlWZ+qtNsg8AQatPM+P2YCV3mojDygvNuueLjrfzkYFdDgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_01:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=840 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-GUID: fVkWol4pb-IuaxHg40si3wNRifrGEL7M
X-Proofpoint-ORIG-GUID: fVkWol4pb-IuaxHg40si3wNRifrGEL7M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
