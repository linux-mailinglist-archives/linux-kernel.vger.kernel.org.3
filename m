Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E565A4681
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH2JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH2Jv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:51:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A22A26A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:51:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T81XW2016502;
        Mon, 29 Aug 2022 09:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ybdOfKYL2Wzer7PAJnXk9WJJ+KleUrYbd/hdnePSwPc=;
 b=n3Kpo5v1SQEcj/LKf3/xuUEvhyq0bZfYQWDvYaMsxJ+yoknd6RgpnI6qW58kKkGSUl6t
 r7wGJuV5fSAtEjjVYR9jl6NhDIMdFPlOlJfypsuj9STRt1Fdtid6QuLQvpPtqbexnDeX
 uGa/3Vnj9DlADHVWCLrvUUshtkTopiQFOR5LOj8aTpuWZtPdFdt+2f3w1sOJbTtkvcnc
 oPYjJ+slmup7L1ewiluvqkgNv9ooJ8KitfpWMdgFd9Xev78iztw+WkUWeRrZVjcpAe+D
 2VUA7iTekFiOQW+JtcJgsdOzw3H9LWLECwrDKZXFRTzwe+1lf1UEpQsq9EcNHL/z8Y1d pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0jx67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 09:51:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8jDQ3005995;
        Mon, 29 Aug 2022 09:51:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q22cv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 09:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/ysHcGOg4BLshbMBWnA+3nauqNi1mfbvMTO47PJTf/2Ba3+pextoo9Pw8T98hia8pTW+HOJoZWwY2jV2Ed8zFvECOIlngfM4J5lOZ0wnYg9moa6bYOylmCUE+IFmusp5/jC4GVxTnLTxm83M4NGnXutHZcuBD5S80SAYhaBfaS0wrq587Cv/PgY0K8FOXjSuAO+bVgSo9DKUEkHko2tEe2ovhc3wIoMEv9p641LAIfWRa7HinsPdzPn8IlImgfM1pPTxuPJ7H7UEsXL95yZdtHwma4DtVIBeZFsN+FMyH0M2kk6iaJGxtfp6xSkOIlxmVy737/aqE/hoUf2duY5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybdOfKYL2Wzer7PAJnXk9WJJ+KleUrYbd/hdnePSwPc=;
 b=EewE1Y3T4oX+2uYe3atzWqvLUTalXN0vj0D5sYfEGpWXhWgJzicVg88ZJrcYDBRY7Fxp/1tZ6dSHioEDGBrNmFU5qAictMQa2Tkb60cWtmMHSPFZATGRzXSvSE/dT0UBqGEgGZDeODresQvF26UTieOY6rXBpxZpvsfY7SA1YbTs+vctNDRL5nVaBxnF5t8sGwX8e04CEiPQr9UDMZu6lBmCnULGGMX8nG8LjiOYo1VBmnOkKy1dJ5z6EJgangdb1eDjkDp4AoFgOspu3DhsyNbLI56oFIYo//FPRE9ujCJvwXdZVKv2HkofPIF05hDcym67yfoVbvp4mllPHjpnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybdOfKYL2Wzer7PAJnXk9WJJ+KleUrYbd/hdnePSwPc=;
 b=ZDXR0HWwVRIdTLsDbWg3NagZM825IswhvSuNS1tNn+5SSyySR+z0RGCyh2JaqhGhE7Ed9bS5fzcpDnhyv81YEdLlvNiK9B80YujIwf/3lMy0UgNgc297jXeEOc2FDREJcLhRpGawf5g6qgbKAf2o1z90LngJiH8L6NeE4P9fA9E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1362.namprd10.prod.outlook.com
 (2603:10b6:404:42::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 09:51:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 09:51:24 +0000
Date:   Mon, 29 Aug 2022 12:51:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Message-ID: <20220829095106.GG2071@kadam>
References: <20220827075143.61311-1-yin31149@gmail.com>
 <20220827144943.5290-1-yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827144943.5290-1-yin31149@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74376338-18a3-4cb3-59df-08da89a408aa
X-MS-TrafficTypeDiagnostic: BN6PR10MB1362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RbZOX4S/QyTtWz36/ixuX4dlSfiTGzx4oq3e7u4Evz9kOmE1eNjRZ7eJemZ0Y/kRovj1W6aG/HA/bh7Eb5eWwbdvYT9OGBaiy2SrU468qMgNJeRW94XbTLECLx8bcykM4R/bAIHdPV6sL6xjrYBw8V73ZFodpFNLjQCQzTu+Ppx/C02lUHI0lfejfjMhPswus1TTifDd0iYUFCCWqN0XGYGrjZ3kJHtqv+6sYe/hgV7aE1sDs7HactrtD/RAOxG9lXezpvYF4iunRN2P2DZj6yIdO8jUCXhxBo5E8/s11yUtrdnzGcrMIgvl1HwUzntgnW9gTOV1q/O3UpEa1ii33ilylE+YzXTpVkaaFAFQ28bAeJ8G6+OfKDSCyfQeKDXOSVHM7FgS7HzgN75w/ilBjluUDH6wpj1dVMlfx7tkKVpcuEXHV9lTSEcOlx/kG9VHAwsyHPcWYS+//BVrtKe12Wgu17g0zI54bx0VKAqOT4Vv94NX5CptOhOzkxfZNtWGwfD5P/aytc+XeEFPkHiDLI9J4BmbAsxS2Whxkb5MOXa5Qg2Lqu4OS/olopu7sFMsqups16daXtef72KdE4Qf9YZl20c1ccWx7LsqHuMc7pEFv+gjZA7ExslcU1pIY/rLx/+Edh2C7DEsdUIef4KJ+L5i9eXKiJHTlBylwSKdeTew49O+YjGmpTTYrHBijHpOMUh+i/5YmD/P1YVXw9w4/lTvBKVtsiH8zoUyFzLt2RTcaydS6ccQrDoCw8XPIL4pFH2sMw7Oy8Dcd6K5GI+Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(33656002)(1076003)(6916009)(316002)(9686003)(26005)(6666004)(2906002)(52116002)(44832011)(6506007)(6512007)(4744005)(186003)(86362001)(38350700002)(33716001)(6486002)(478600001)(5660300002)(41300700001)(8936002)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ox8dNPMUKI+8ghMNg9PIH0bzW+HtKbLy2rm+A9Fl1+kJMjtGtsAMXSSMUiKe?=
 =?us-ascii?Q?57Jwr6NxQgJ6OrczNo5kfoo0hcuPZixzphrFH3L28M9i2DvMBYnrCA7JxTgq?=
 =?us-ascii?Q?wq6LAHJAV8tbeS39Zz+dEOFxncYKff4Z2D/nDWsUtrgRMUksdwNm9FlUHijw?=
 =?us-ascii?Q?JiRb6ysQNJHkyGIh4iMiDjGiDeRrER+JUEAGRBDU1xOmJiVly0ehxnDpZbwq?=
 =?us-ascii?Q?9WZEzYWqBJS0j52izIIHNuKeWNYY8JSesSSq/xQ+5rfl05B4BTSxMyKXC/6k?=
 =?us-ascii?Q?LGr8wy9YIiOJo0GMVyef+0JmwfA/eLJdPZ49saQnrIbG+X59Kc9QD6cN9KK8?=
 =?us-ascii?Q?VuklqOjRbXuT7lKfIkVADNslngtocwGk3hdqblPwkiIqeaOMkY+SYd1Ete4z?=
 =?us-ascii?Q?C9W72INzn6/C0qFG/iqg89nAZw+XlLAAvdYnfVZygoER4b+Up8mNvFDnzB67?=
 =?us-ascii?Q?elkx2f5XwIppXsBDqtEJmhhMrXDFC2+wnOVqA4a45i8bLuPVdiQ4aeglz/Gi?=
 =?us-ascii?Q?csDw9CPTQtljuP86ZOVcN8ZakaoIWs4FB1pIfB3PtPH1kc87MAumke2XCc2O?=
 =?us-ascii?Q?FCAvYYZi92JjcUC2COyc7fNqNdZoAa4Gt7WFTG9OxZBqYaBkPmFrVxFNGLRC?=
 =?us-ascii?Q?4FvTWeqnHJpFasVX/oCtgntMYWav+qpUvEC/umw1Q+QPsnmhGyGcyeVmjsMc?=
 =?us-ascii?Q?uVh3SSNQ625+ASxIZM1AtyExzETGoXtQcXByDuw2sZmKNLHaSab+HJ4128HF?=
 =?us-ascii?Q?H2L8kF3xnBp468aUy9cDN1JbWjLs7qp9ylvfpr3eIKudpeZVeVKgcZMwJwIQ?=
 =?us-ascii?Q?h/fgq7qx/mRpCPM5nX81CdilCsTDsj+lx0qGiIXlGHUE5zeFDyRNT7YjoOTN?=
 =?us-ascii?Q?Cy8/IcCYlRU92/bMv4PxcGiMu+XBQrd8TRfY6ldyElq5Z6YhGdkYZVMamp+g?=
 =?us-ascii?Q?zTq/x2V0A+++2hG43LSer3vuJESK+dRUiSkA5eEkIF3ewusYt560e/CvMJvk?=
 =?us-ascii?Q?Z0/zhm6OqeiQoNe/p2+2WxOuzEsNA8WLPpus2yDFHkqFALlkgQ0YO1gzMznR?=
 =?us-ascii?Q?E+dnvPYeBhDbEbqHN98DpAG46N5c564wW2oAbA2LgWY13uKz5PX/Y6M9UH9j?=
 =?us-ascii?Q?lXQTS6Vn6TsokKLO2PRAial7lVRyg+NIgWTXjKuUtaFaPglVpyFdXPfuSeLU?=
 =?us-ascii?Q?votIDFM3Z+OvDI3+YzT2EMDqiApee0ezLybVfAvGU3LPDZPjxJFyZe0FMc3w?=
 =?us-ascii?Q?N7fxvJ1H3Qv/kjKXfDiijkQ/laaxP5F8s/8zw/KSgavVELRr7g2RLUj4BcyC?=
 =?us-ascii?Q?7VBEAjyHV8lyV7WnDuzA4ZxbxnAemfezDjALRRZIMav240MU1IDaVW/Gl5lm?=
 =?us-ascii?Q?3KKbwDqMCSGT4N06XcZ7UKu+cQxUnAIxl515AjINEjVHPhp/91e4pae14TCG?=
 =?us-ascii?Q?BLwB9yZk2J879HwIji+CYzzfbPRJ20V0vwvSmAJKXM6M9Gm5i7Ma9L5CUuUy?=
 =?us-ascii?Q?fL8Lq4UHslB/fgy8CWu2uJPKbpnHZOmp/yvf4fBRNQIagn5xkZnV/Q/Denbw?=
 =?us-ascii?Q?1Isv/srfU3cZX8eJ+cLNVAGaokgH410Flr8egZaZAfudYc+IeLPKXZ8wpSm9?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74376338-18a3-4cb3-59df-08da89a408aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 09:51:24.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0og8cWGY9cTSilUM/z3MJK2l9Os0lziR4U7G8GHEvw6Pj7XqpRwEUS4ed0hKX3Tox6Fum7Djmm9q1U9vADFZUySb8VNsZjx309JyPSp1AOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=728 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290048
X-Proofpoint-GUID: AdxUz_JtlUI23TcAjaHJUmEmcBWyaiPE
X-Proofpoint-ORIG-GUID: AdxUz_JtlUI23TcAjaHJUmEmcBWyaiPE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 10:49:44PM +0800, Hawkins Jiawei wrote:
> >
> > And as for the root cause for use-after-free read, I think it is the
> > ctx->attr->length to be blamed.
> Apologize for my typing error, it is the ctx->attr should be blamed:
> 

Yep.  Both patches are required.

regards,
dan carpenter

