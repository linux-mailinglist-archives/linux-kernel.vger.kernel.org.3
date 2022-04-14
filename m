Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733C500C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbiDNLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiDNLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:37:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253C5005C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:35:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E9la5E031505;
        Thu, 14 Apr 2022 11:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1xXiYX3ILu8v88Aj+X3n2T+cydI4b0Ol5iIchp4jylo=;
 b=UYw32ntOvVb8qOLe0QlWwfCaCl0fgIqvUQyg1vM44Ct5/xuA/MxSTWCJx1spzA+qcMaB
 oBiWuQR+F4JgsRfx8nQ7gN1Kd29BFHPbuuvZxfmVAJULpPfNjJFDBj3YaJ4gRiME7vVD
 HSdqcu5dgtYM5LOajicExhM9OyOud1aeb42kiqbbTMkawOtM5zy/YEEoQIJY+3/6uoDh
 RpfmfDvVU3An7dHYM2Q//R8feisvp6Kn7AsO99OqkLsC/wGsI6kc2/HXORhQgNBtMfr2
 aWawN7I8TwJRrRYiuWaRyHEc8aHWUgERC8sEo1GlEfSi283fLou20OkQah5xbpqlMM12 /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsckxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:34:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EBFm4j037160;
        Thu, 14 Apr 2022 11:34:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4xqkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYLFBMj/rSL0IZj/qErw9Yl3Eh/JiVEuMTgcSyNCssT6Q+RAiNwmfj9pk4kvw16Ov9M9Lguq8gAWluLiYzQ8OEWlEKW2kAywq0/vCSWel1ARIH8QRPqnmqfJWDr/4BwCgEtzke6gvgNH633D/iCLdKi7M9DkX1nzjSBn7Ifv0aPT0lGCU6bV1ZsegJpafcKVrAg7guMj0M3CXdqCDqavh9RMyXkF3crrvj6BrBdG+mGNaB3UQf3R614lgEkktRu/y77zCxxpQUS/pTbhQR9QAGRPre17EEbP9nCGqtF35KF4+0nvaBUCm+8j7AJ3i3by3rcJ3G4PRGSakErQsNRGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xXiYX3ILu8v88Aj+X3n2T+cydI4b0Ol5iIchp4jylo=;
 b=H8wM8r5F5lYpwMkJbp0ayINQBBIdzUf0gqAMpI4030gXOMLseSPBWdQgd0yy24/+qPegD0xX79/dbE1UJcb6CIrulu9AZOknnGDr+A5+/Zub8LUlnJzUAPN/Rnmyq9uWBIsxn7FM32nP52YNd8PHc+q+tX/5lBhn5tTDktWzMXtFfu6M0MaI6tHqOroonW8Lu3ZSrLje2DKfqFpZHsKXzrG+YVrhTfRhq6W/CYeL0P/QIN+P0eYIp2c4uh9pqUFDnOwPCkKD6vxw2Ov9jbYy6WczamKPaS9/vIZFTpKS4w8g1H1z7+FGIVGmGV6Ssll1X2rgIu6GbNVGViR/r5aihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xXiYX3ILu8v88Aj+X3n2T+cydI4b0Ol5iIchp4jylo=;
 b=RP/it49H31NeCv5Iory3a3TGilTR3PF2wcidokEozaPeiIzrwkPfgAJ4Lk1WU8hJ64Z7GVv0SDYPPhXw31MCXDf7j85WvyZpVIY9RgC1HLi+JjSqORY57hFncSKwNFGf9rDNLAAWABnFUzuN+ITCPfEDWwVZnXhBU3AS82R3WII=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5010.namprd10.prod.outlook.com
 (2603:10b6:208:30d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 11:34:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 11:34:57 +0000
Date:   Thu, 14 Apr 2022 14:34:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220414113447.GK3293@kadam>
References: <1649932490-13622-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649932490-13622-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df5271f0-dafe-473e-1072-08da1e0acd90
X-MS-TrafficTypeDiagnostic: BLAPR10MB5010:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5010DE7A85F2BC1698B05CC98EEF9@BLAPR10MB5010.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kiUtbxQy0YNb3zKyGHJ5FymOS1C/dZ8U2NaTMB/VSdw6WEELD6dosyNkwQB3NOxUhyYgTzmYoK1nLIAnRvuq7yfsqQDpAGlsSNUX2IWpQNpad8bGwN/M2+izZ5ZX1gQH0TEgRINk6w+Ns8rSDyUWmReFKu9MUyXyRojjYCk4gk5wsku/qZxiFsm/p8Lr1e+fOh66TaGFqztLsyQBleQN9wOkfX48pZ1u7sblY72z5BPPg+8hjJlNcOqeiUJ84qnp42TlJAE4HKbeeygxQ+jHmBSY46tkUaxGmEfmdg21qVAjGhQAEh/jSqlwpUNS7JUmrIhaHZ1oqSjMQSg7+8gLyD0ZODY04IZnGUcYJCGUT5ckk9E29cgbMErPLt+YeCWKfbRn9InymNqBP4NyOXBnmEB8t73BNxRicOovYgTvot7Ti2+HYcAyIPTqChYSsqxjLJqI2lf9u4dgnguduQ3CloSDmBgSCZbhcwkD9qgbvmpu/atA6lw80+FUoo4ScpCERDhelbJYEBiiZif8eQYDtL6iAD038vZDwvDDUB0qlBXCUCp/6I2TVGLuT/O6ce50QyXkx0tD7YjRz/OVlr7ciY2MYm9OI5rosOZTK2VCww9RbRMPvJTAIa5uJzgeMrkFjRixe/6/ayqGlvI+ZakFZS+7Yj3yj+rRYBnjVFDGJ2hRKi/0Ugsns+cf5l0JPpin68s/9+8bIBa20cPNLekZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(6666004)(9686003)(26005)(6512007)(38350700002)(6506007)(38100700002)(4326008)(2906002)(86362001)(33656002)(66556008)(66946007)(66476007)(508600001)(6486002)(8676002)(44832011)(558084003)(6916009)(316002)(5660300002)(8936002)(33716001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFaiS92bN/XE0H7uBliZ6szhK6bfvGf0cajndjqUYqhDg4/T9OzZQZgFSzsu?=
 =?us-ascii?Q?6+gHhAV2WbHcII8yG5rYateW4H8mtz7n9NVw5X9ig8j+vkL9llYPF77l4uS7?=
 =?us-ascii?Q?/1UEU9RdOJCWDLCyCSVXtc7NJqiNynCGIws8TtcXnIXUVm7joDU/u3PI9WXY?=
 =?us-ascii?Q?dhIh5RwlFjTUpQuoNtF9BsJSx5IjPlQK0Eo+oYbusqwlNvW0t4YBg50Nz9M8?=
 =?us-ascii?Q?7WUQNHsFT+mMX1lx1klQT7oh5niR4TxvMOHwhb6/wgPeB0Qm+i46xWfk11fq?=
 =?us-ascii?Q?mm1xk31JH2ng5pDtLGx3rPy5O7Ffe8cxCYhpY1f+d0Fg1521Ew2kzo6wwf6w?=
 =?us-ascii?Q?4uUOtvarJFdY8YE2WU7xzGXSR82UdzNtSvBGA4byhah3e+d+w6YONT8bSM+V?=
 =?us-ascii?Q?NWRLVIoYrwQm6mw63Su8qEaP2fkAkabqHSjUfAg/HCUOL376Ck5+YZv9MOIu?=
 =?us-ascii?Q?HfizbYtPGQK0Ni6zIDyn0NFEslQDceNWKesKd4qDaFxCjdHYhNPtnU2rO8Mw?=
 =?us-ascii?Q?dE9f+MwI8Xb2x8Q4QEYbT0o5f7a1qfyU+rK69kF6r2b+NQuiiC9hdYzmBtgA?=
 =?us-ascii?Q?sQOsL+ta8xNTbwxF80LDG3Rf7ZY7XGrjGc1o6pNOSq0OmUuaZY4+n/jBpGPg?=
 =?us-ascii?Q?dy2F0g/kdjHxSusFbb459BIOi11cvdGC8vABG983oHCbB1lEXJQrmTypAB0Z?=
 =?us-ascii?Q?3lA016uyUiYVGaVErvS/69QnUUEXSSZdNACI/BiJ58qheXkGtyOWOOHjYqFf?=
 =?us-ascii?Q?91EmCVKtmMWhomr9jCEpLhuAEO5fleJPH+3mlaeeNQQAShvk1KUI6IifFxCu?=
 =?us-ascii?Q?Cp4BpUAwhPKuthq5V4hyt68tZNo+Q2i3hcQdp1XMrIW+0HIS3qLMyKnD/mxw?=
 =?us-ascii?Q?zhKKolAJkxq6g8Lsmp9o3dQmO58qC+1wWEfBcefYmGXP8Gr80+dKwCbHsNaC?=
 =?us-ascii?Q?citFinBMWIl3dxeADhg2iJyKNM/WwR1a8xvvruIk6OsH4/QqGfKOPBRT6G4r?=
 =?us-ascii?Q?PFSbv8Dpdc5f2dmzmj3vgbkeYNCn+zhncjs2i5pU6YNY6rdsf4ISqu+XgD0O?=
 =?us-ascii?Q?LOiUWnQnvWkjmcqQOH/GxoPcZXzmMrDTo90nBfjy+PlcLKBnddxnNFLqflcS?=
 =?us-ascii?Q?Dh/sX9Zd7v8DUnpxbwMeO7yKN54f663ujFnglnAMNlWHzbIiW5kzp3zIV7Yt?=
 =?us-ascii?Q?mKhRv0QRn/LScij8D0AGSwt0hKnPkOZbwCi01v/E/fkl+iEoVt3kMURoKm07?=
 =?us-ascii?Q?XXXRJGLV9U/IdZB9xlpQ31vnHbCjg0/KNF7JZlp8MhiUs+l5f9/wZYPZW8Gp?=
 =?us-ascii?Q?gootpOEOhVlrg2zDsI1PWHaiUwF0XuiBgpwnAUX8vUHwLfScNIqEV/K/v8ZA?=
 =?us-ascii?Q?n8Ynk3CcZCdO1J0Y+DBkz0HBT7PshmAQ3fUfsFMm+LkBt7jWvpARM9WFayHq?=
 =?us-ascii?Q?D9UAaQGbunhkzGh+YZUKDDF1kWVBdPEuE0KXc9hjgPgR/GW1BxC95RH8V90y?=
 =?us-ascii?Q?FHiBPUF5z6ShzvdjhjDK2AUqixpzFPH8hyCIh0OJx+snQfP3G+vxHDRfEhhA?=
 =?us-ascii?Q?WEuHVLVuoSyVHAluV2hjbl9niIothvgJ5mXLE5rTdiYQwcMlNU0pox9VFMgb?=
 =?us-ascii?Q?vjHiX60GSJUd41U9xYhQF+ehcSpKIOiQF0+04PwDpyboHPi7kijjMfCwz1J8?=
 =?us-ascii?Q?fx8CGwekDzNAPU8EBozkVXcYsQF/M7ujjTKReT6tvI35Y5fRHGZdaEp04Bis?=
 =?us-ascii?Q?pDxW4QkVPN3YRydnET5L9Cvh/IyOXSY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5271f0-dafe-473e-1072-08da1e0acd90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 11:34:57.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: za1/6TYoAzXXqwf/G/4RfF1lpLw3PqGIKM1gYiKj+i3IvZP1shx0OMmjhBR7uC2+ph+dK2udpPwzCxguZ80VHxE0AftFwojvU1UvYMsWtxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_03:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140062
X-Proofpoint-ORIG-GUID: YRH2EsfCKLGv393V27qkXEW30LIYFXyH
X-Proofpoint-GUID: YRH2EsfCKLGv393V27qkXEW30LIYFXyH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:34:50PM +0800, Haowen Bai wrote:
> function rtllib_rx_assoc_resp () unsigned errcode receive auth_parse()'s
> errcode -ENOMEM.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---

Same thing.  Make it return normal error codes.

regards,
dan carpenter

