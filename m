Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467445310A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiEWMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiEWMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:32:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5E427E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:32:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDJKw017035;
        Mon, 23 May 2022 12:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rnlSN2U3Tp5PFehLSRpOz7stpzWVGcZRa+qSO9cJ5a4=;
 b=KPa5x8SSSpQkfyotj+xuM6mONtHPIFJjd3YIA7zXga0IiZn/JYuQw3AhMWESwzEhdS/M
 HttsPtkqPUHZaINtp2XDdzTP4gFAowLt5e0uD4G4xiaPnQWa4dUhDCqxXh4c6nW8N0nR
 5jZJegUihy/hxjtmGlbo453DwWjVruOxgetXfy4hEq5Qq95WeSHIt4/PMgbLZWWx0s4E
 4w0pNchNrGVmVuThxaNZDTFy2VkyFei3rqrV6gqCmFvrLXOWxkuSOz/qpZq1motP5wcL
 dEga0/xYtmo5S4fLGb2UuQfjaekZECVnRVr7o8BTb+PUAkidq1csw0+2+kJl8q0JqhWt 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps36m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 12:32:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NCUKUZ010687;
        Mon, 23 May 2022 12:32:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1hqxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 12:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVXE1HpXwHRHvewsMsI6OmLCAo1hNaTGfnHQfHDOd1pPaGvxv3bhooBIdoLjz6yqLY1sHmHBT7Hq8BAaK/UhInaAud0KiAn1oAu5sqA7Ko4YnyjegNowcTNGR2ZV2dBuRGdulI91y5P0fcRAl5MPJnTDgGhJqNK/VZfHLW5sTDJ0qt0TUJ4Tyc5pgpvgdgBAnuBRs78T/0SB60Ce1222FdwbWhvIbf1Ls0vG22LxN1COlZ3GTB04Vj98NAvi/O9oIUjZCUJfb7azeZAICApVI1eScbShusZrnwSDP1p7FexXRo3d1B45+vus3nEfZKwoX29LVzElpxCoV8pnsduUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnlSN2U3Tp5PFehLSRpOz7stpzWVGcZRa+qSO9cJ5a4=;
 b=ZwmpPzPFRIMsVtKJx6a8WK0rEBCj/hXTfO/OIANkkx/ufRtzUGYF2bp1Wv+uJ4reIJuSyxO4Z1nMobhTxZYmIE7HqWFP/lNsp/zjZ+bXfCwYU2Xazm0xo6zxaxTRDTPoowYAbsAaUY0ozWVibO1zp/qj15GK3+gBL4qWLfh/RQcdvJFaKoSjixBYZKE/E6ZZVkZhLDtrSZ6W5LDQrSDR1pfzYrZCNAIkCsq8kv7t1SHNA1OOmNv8RamWJSGv8Rpky+kyX1fvot93ScHPIdWu1k4tYUgCYKkRPCsE4wlKntn9qdiGxNlmVcMLbytyeUOv1KecfGMey9pJC1o+P9pzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnlSN2U3Tp5PFehLSRpOz7stpzWVGcZRa+qSO9cJ5a4=;
 b=D25tC0VqtxJh0CBTCpbq0vk8KPyh/zCMK+/FTaEzcUsgc3b0NVNa5kWRqFVFFgd5cd/3NzHf+O4+pD0UdnzkoJjRz/I/YbgpuKtVAxYZLnUB8TZWMHJP6yovyzt38MBVwdZPuF/f7scrqsuGbbza0ANVge+t1UJbEA4Wbns21ko=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5185.namprd10.prod.outlook.com
 (2603:10b6:208:328::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 12:32:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 12:32:13 +0000
Date:   Mon, 23 May 2022 15:31:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: Fix indentation in fw-management.c
Message-ID: <20220523123152.GC4009@kadam>
References: <20220523120857.8476-1-me@wantyapps.xyz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523120857.8476-1-me@wantyapps.xyz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5681c184-b214-45c8-f966-08da3cb8431e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5185:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5185F64C3F37F7A579938AC28ED49@BLAPR10MB5185.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2++yTJU80/kPkPpn7oGL1McXqTHXBceks7svUmFTfdnUc19Voxn3MjJSNm22XVhlZgHMrtvgrKSgYYh+u+YQyTubhMJE/PWsb1UqZaf3RMhlo2YTzZGHW8FvCEsNhtlHVAMEeLVz71hA56k+il4+cCMfAnH4p4mm5Uv/m77WZnD5Q5se5m5MFjXtZHtvYuZXdvl8dTKaV5VvuC9fal7Vxdl5ObX3daCKF8211dKdrgE4pr0VeZMKgBLwdUd62r7BcnJvAiSMYk4l2onS1JLD5JadwMFr1kLfq/GOj+e5uRvVVNxRcK3HnaMV0uIXySUUDzgvoFsxl8AkwPY0SqBvu4YW4E9PhsFXhCvxafyQS7SCg8siFV0JKsK5T+l1pIJMhXSQoR/TnkdANuOhen0vDTFZstHC0LPQin0fFJ9CQhSRDw/F0NYFq/Fwgv7K0LpLDdFu2ykXjjSKWq8VQ4CL9Od1WX1OwuZjRoYO/NTp+A1jdXYuPGUNnqEVjCKhCLMU0iAcc31p3DBuUDIeUjB3WGQJTG/o2xjJgijq/Dm49zMVIFQaQiwFvwyE+MuRHN8Nlcrgn0HdJ2PBc5MK6cgk5t8VxQDwx5kf3FZfA2am0CYKzzJYNSlP3bbLorQiJUhJmuOj+oeJWND746eMf07QTOhmSca7HgM2hioAanPUDhLlDRpN6ZbrzuTU5XlnszCm0O1GpOmRqdNqAWROEiBR5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(38100700002)(33716001)(38350700002)(2906002)(44832011)(66476007)(66556008)(66946007)(8676002)(4744005)(5660300002)(54906003)(6916009)(8936002)(6486002)(316002)(508600001)(9686003)(6512007)(26005)(86362001)(186003)(52116002)(83380400001)(33656002)(1076003)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rSYMHRUKtYUhjOIJtuz+hw56ybvLUoCyIcC6xsrI/vIp4xb+Eh6N5bIxSHxO?=
 =?us-ascii?Q?gcxkmLCD45E8z9RhyoNq1ECPrvl46OkNYhLGi2ZwfG612oHmayLlzF/AOoep?=
 =?us-ascii?Q?Ks9bXraZ0iQfkcY44C2Mtah/CCBgHfEe4PaeXiQg8NcQzD9xGi/PLBnGw/rW?=
 =?us-ascii?Q?dI0zw2X4+IK+Mmlbi3qy82Wt4PapjMMyZuBcDqGbr4L2uxT0so/vQ5GVa7eC?=
 =?us-ascii?Q?fDpjU6A+9MyibzY75mBuZIobgkVVYnJNMKPFrIoZ19/IDyEIL5nW5Yf2IDLx?=
 =?us-ascii?Q?fK0FVkOenODa0gpY6fyEp0IQgQA37ccEb2K0aLMWhIjQx+i68V/rpGnmZ+hV?=
 =?us-ascii?Q?9BO+KeeCRkEVpY8UPYE3ZBhVYMbOTyrgJH22LMH7oqXUcUbjFyI4k/he5I+R?=
 =?us-ascii?Q?8drPWmpj1UQHYeEjUOrP4ryrybFsSDS5vW8jH6DPI3abn/SQWLhTTgS7qGuu?=
 =?us-ascii?Q?jlgsbAMkj+YgJUdjcJwDfKKWvhpG9LdyBOTJeCxgP/tTA9iM19Z/Uf454h3Z?=
 =?us-ascii?Q?nzolUcN8m8xGhYbHEtIJDg583UKmGb5M5x3GuJZvm31eQPprjKcKWXo5cf4K?=
 =?us-ascii?Q?XDdVx4b31FlNflstApQJIEj9ImhvczhJL5rqQQj33TwFRmXPKL2G8lkPYCZR?=
 =?us-ascii?Q?VFyQ8lXIqkoBOjd8B7ISIgJPhNC77Oqjnx4ZE2xj5CpAzhsFXnWRHEGBZu0E?=
 =?us-ascii?Q?tyDJyrbeC9M2OcVe7SOP2cPCqpdxl3WripmmFH4C88bhiN4CLR3mAMBCOAoL?=
 =?us-ascii?Q?UQJKkdluK7G0qLQYrQn2olGuTeBOl7I4ptHugDppQz6FdDV2UeDvFZstMBMk?=
 =?us-ascii?Q?+YoDdAhyhPPMM2l+H2QBubGFcgWqRXBEst0nd6M0r7suX3YlF2u4SzJ0Q2lx?=
 =?us-ascii?Q?cZkdySGZAIEEiXn1na1T6yw93Nhl9TiaEygFi9NaCT+ypr9usdbeGMmnequr?=
 =?us-ascii?Q?T02wZXAq7DiHj5cxy8/yxl9R0w3BQPsaZhrZqrGwh1itkQ7z2m5bTL8DBDIi?=
 =?us-ascii?Q?lrX77w78LxDLReYBiBdhLEwH8WqaQSd3w1z1tqi5cwJIw6MqI6a5njH9RGA4?=
 =?us-ascii?Q?7y4Qu/BPL5M5u3vrPpIN6dS2pSNqNHWIFsr/AUg/UPjNYPaYdXlhf+hJRle8?=
 =?us-ascii?Q?5smogkUpb4N/yNFUa1+Oj8GrswIC6PFHEfMU4DkvZpB8UZuRWY+ZJxGDiQ+s?=
 =?us-ascii?Q?5nsskmnF9127WqWdradvnmI5Gr1Tbc4K4bVA2RQXo7M124lUb8RyHhTIitN+?=
 =?us-ascii?Q?BTWuQsIoE815ZCHsb63QZ0g9asVLFrbaIedY4kxtHti+ICK2gg8i0Xf8U00B?=
 =?us-ascii?Q?CJ6hugIKwHZfbn56zjXuNY45OtnOgAWlWJiF2+QfY0B4hhm13JOg0NuNppmJ?=
 =?us-ascii?Q?hvUlrS4szmg7g0ydOKEujsnF0mDlfxT5D67almUzLoC+5zaGxTBMBRm80rF1?=
 =?us-ascii?Q?g7xPOZl/fiSo4P3jY/hH+VZqcI0bU2sH+WMeKokG47IueEBuI2g8QJWo4Bx+?=
 =?us-ascii?Q?qstslRBCrSSHjAif1MNvO+nhEJKA0xQCD6qf/+1RCunPPATriMysJuAscDoq?=
 =?us-ascii?Q?T+U9b+u3s570KN1gNZt48OS33oho5kSRzqk4IDmOSWboEe01pxbTg8dkWcTt?=
 =?us-ascii?Q?fGclEdB0203ku4/TI7/w81HwwnT3920kDYwTfLGZyIts1vKYGNrGvAshxDU2?=
 =?us-ascii?Q?E0gtH6kfs88vTPVszkoO5Huix7dopzHbwNY32E6DOPCibB7lXlesHlnJHKJ/?=
 =?us-ascii?Q?VB79eyR2FiG8knFf06qHMm6C8EVSDvE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5681c184-b214-45c8-f966-08da3cb8431e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 12:32:13.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDWfiKIhf/nHvoHxR4kkYPgipgq/dOzjkReKMZM9nttNQvVIKAr30u10nO77YN01Dlyl9s0v2sspAUWmWZOppG1r2PHSBwd4Cr3ALxEEWBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=910 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230069
X-Proofpoint-ORIG-GUID: FnQZveJa9zXH6FeipZpztV4X5szWpJuF
X-Proofpoint-GUID: FnQZveJa9zXH6FeipZpztV4X5szWpJuF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:08:57PM +0300, Uri Arev wrote:
> Reported by Checkpatch:
> CHECK: Alignment should match open parenthesis
> 
> -Uri
> 

Don't put your name in the commit message like this.

> Signed-off-by: Uri Arev <me@wantyapps.xyz>
> ---
> v2: More understandable title, add Signed-off-by line

Why didn't you fix this one as well?

CHECK: Alignment should match open parenthesis
#452: FILE: drivers/staging/greybus/fw-management.c:452:
+               ret = fw_mgmt_load_and_validate_operation(fw_mgmt,
+                               intf_load.load_method, intf_load.firmware_tag);

regards,
dan carpenter


