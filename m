Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF3537634
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiE3IGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiE3IGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:06:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588275205
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:06:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U2mbb1018356;
        Mon, 30 May 2022 08:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=/dXeBozR+Kqv62A+L0lsd7HCJQxDINy7U5UxTcb89wk=;
 b=jhcwZBXZe4d8/O3/ztwANzdycVKilxlKo2sKyi5KNmQC1ri2TP7k57PfFeG5I/XV880l
 hWOvf0/PqvAh6hothPSgrA7K21CcNoPEqobJ21dv6Z6jKI1hNC0faJJGrjoXws9eKxmW
 WV9QWlJ0RFTSGyszIum460CMudhMfIpSgcFDJUHiLrc9AToCYOGOLaeNCDv3l9vQ89km
 g0LOXIIgUz0Lber0BCbPBJrD8N+oB7odhxssaRFgyqGYOg7ZB3YBLrkB1u59HzVmJQW4
 brp+zGAytRGAVCaDp1uqAPrxVZWbqO59b1GZRT2NPwOLpA2ilERkjwQKEKRNYjdGBi5A ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xjaxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 08:06:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U85Mf4033543;
        Mon, 30 May 2022 08:06:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jvye2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 08:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OofL9xw23Ao2WWciJ65UHFRpL4OJi7JKd+HXtS4Fy+zkXW3EM9hdGnP5CjwmTorgn+z123RJ/RoLEpbnyTN0BmzqIi74NUTvyWv3p54GLiS59ufr0e8dQsDIbwcK8iXGe1jcxP/7G9Fv8A7UbT01U83MFP+ZGWwcyp9EXQZzNcrSxKnQqw9zFGzMudUAfwA//amjEfy0w098J1fNYeNUHFO2mINRf7+5FaZJ1a3P2Vi4bvfIY2/HgiNvlsmvDQlSJVuCXalyilTUQ/50zyXIlQWzJ2m50pXTuZumPIiv7T4CgV+bjMr9NP3PMU5J4eWiASWHq+udolMKLQc8SXrPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dXeBozR+Kqv62A+L0lsd7HCJQxDINy7U5UxTcb89wk=;
 b=GsSAVFlQHlPSB9WY9WK2oFOBdZ1hyEwcKkpf5nrG91L3DbP9FGLt1WGHLYZzHwbPkG6rhWj7bACW6B5Oww7WOVvj5KfiVu/EKd5R0ngqGzj5GHlVLUe7wIXF9aByTbW6K8mr4B3olKJVr9vCoQOdMDyPwYfMTEQ2WOw4yVhLyVF3a6vXdp0TX8ZOPrZt5FwqGFrNdPvLK3UpWU5pfWJcEJy5a0zNP2F9EAlXbNuaaCRscgRmJAwd7pinM0X7I6I7XjQw8lQoeiumWnyRxC5gEaDvegpV+azuTZw4pL+9fF8luX2vfnuvNuq4kjh+e7wlXDRNkq0xSu6/IIRI9c+ugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dXeBozR+Kqv62A+L0lsd7HCJQxDINy7U5UxTcb89wk=;
 b=mwjvGA4FMRSJ5vwwat3cj4vFu+0nY6C7sN4F3peajvJH3RDC3vqVOXFct0B5zLLvoE2X4bsVVn/Rrouvzu+xoA6VvFxeEHYF5xIRam/amhp+lHlFCgfyXgyC+fuWb3oFEc/pKybyTvHyQQD+MHZn1FKd8IAxmRfZCqWLSRs+TV8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5536.namprd10.prod.outlook.com
 (2603:10b6:a03:3fa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 08:06:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 08:06:08 +0000
Date:   Mon, 30 May 2022 11:05:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: Fix undersized array in
 rtw_xmit.c
Message-ID: <20220530080556.GM2146@kadam>
References: <20220529004711.27545-1-Larry.Finger@lwfinger.net>
 <20220529004711.27545-3-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220529004711.27545-3-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845795a4-c33a-4e08-09ee-08da421340cc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5536:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5536A8C083AFA0A47472CAAB8EDD9@SJ0PR10MB5536.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSI+33l9wFzllZvjOsCfyRNPY64ObnJFZ8xlbkBBcQwP8grpFYNu8rNZU24tHWJOJzRpr9pk+cUyC4cXbGt8XUHxSFQrnPGLQIiwYKkM3e1pvLH5gum+yC+1zATo7c0thb8GAZe3or1RvG6hv+W9YG+ZglKfRaAwnf46Z4+zG20TxZkAhrz9ZJ8A5KCyoZDuAjOTbmnI3Cbe+zOD13iT5/5Fsg8bBiAihOt3f3fHbA9Xwgvc/e6EUP1jQ7tbU+W260TxCdyRRSH7qicVDPa03joBnjxx+Xjd1rhDVp40LbAjs7TpcrRnFrcisqDY5AJHKqYV7opi5AkgDlvSitD3VTJzDux0Eu0LuL/AAytFKKRsmb98pt0IjlRiggLqIu72+sAmQ+iQhhHPYGizyOWTBJz+vbHnwm+vhxomLo0d0N34m0LuDjdC+fEFvg1O++aLyAHIgZSl7RXu0w06tbC7aPj5PXPch8o9XlsU5P/5wqOpuUdgS7G1cMUUlak2SWN4rJav0Gsv0uAemTx95HUNcihSbZoiSVOvqWDxAZDsYJV7NxRxtA7kfkvDCcVzsRN/mcqWSX2591V9je3mPl9Pq/YOJ2eglorzhvBqk/Dw2sD0CNuPqkAngHtcW/cnN+f24JkwIeJRpJQ+uPl8E9Jmqo7EtNRwZ1OM5CfyFY5n5muaPaB/TTLefD8QoFUdYvzBpCEBW4Wl6z4wJ5/xOoYTrG10oOlMEeNnPfPDb1xMsf3kfKjSnrJggxuLJQvR08yh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(6916009)(83380400001)(6512007)(9686003)(26005)(6506007)(86362001)(5660300002)(508600001)(8676002)(44832011)(2906002)(6666004)(66946007)(4326008)(66476007)(66556008)(8936002)(33656002)(52116002)(38100700002)(38350700002)(6486002)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxsU2g4S2NYclh1QlBqYUF2Y1JIeVRPckZaSHlaTTVaS3lNZHNOMjNtU2ow?=
 =?utf-8?B?K2wzZG5oOWVmMGEvbTI2MHRiMU9zR1E5TUI5a3dHTDd5dHFPOWhKdE9YSHRU?=
 =?utf-8?B?L2E1TjdDdlB4ZVI3cU1qMlFIalB3Mkp4cEdnbFhWejREcjVYQm9ZVWRFVHQ1?=
 =?utf-8?B?L3hCeFg2MXhTKzhjRzBKdGxnZUpjbnhWNllhN3JEbXIzUW0wamd1SkRPMWJ0?=
 =?utf-8?B?eEFjUXlHNEFkSmJKRGhPVXRPYjlJTDdOZUMycS9ZdTgzZTViN0JoZEpvYnYy?=
 =?utf-8?B?M2VmNVFxbDBrK2ZaRkhUZFZ4OTNCK1RBN1pOZm1OZ1BNVjRvZ2t2Nk4rSXhC?=
 =?utf-8?B?ZVNxZGNLeVBwNXQ3cjNMSHM1L05MajlyTXljb2oxL3RFUklweGdqd0JUT1d3?=
 =?utf-8?B?MXd1OGlsRDk3cjliUCsvY05Xb3Q3dDk1WGhKUXZnZmFBb0c3bHRmVjhyRXJY?=
 =?utf-8?B?NVNIRjRzZUw1aWtzYU1UZ0dkaDdIMjJQMitQMUdVbEdwRWlXTHdwM2RmdzlZ?=
 =?utf-8?B?emtrcWJWRVJELzRnR1lLeDYrekM1aFNTbGdoTHV2dkpTSkEyL0M5RG9MenQw?=
 =?utf-8?B?K3lVOW5WMzZnMkgvR3RhQmxwWmNYK2hISTlUM2ltL1dsQ1kwRmRHZTJNTjJR?=
 =?utf-8?B?TUVaS0tnMjJQZksvY0srb2tXeWFWTk4zbWh2cXdWakxzOExJMkpjVEIvS2JI?=
 =?utf-8?B?QU5ienBIeUpiS2ZZWFR1ZzRTb1ZHNWg3ZUpsMHY4dUJSTmZMTHY0TitZZnFn?=
 =?utf-8?B?R3k3bzY3aFpxb0hycW5EWGJPNjkvd3hYZGZKVXpnOStWRnZ4b0p3cTdRMTBj?=
 =?utf-8?B?KzdjSnYvMHNCTkJZckM2T1JiVjVFbjF2VzZvMXFlZ280TmtKSkNkWGdtSEhB?=
 =?utf-8?B?Yy9HZlYzcEsxamRSdUJzZUhOVVRQZ3lrWFkxdkxBQUtuT3V5L1FoK1FpRytU?=
 =?utf-8?B?cW1kbTRvcytPcVV4aG5XYU1NTFFpOHFmMGZoWnJSN0RvQTRVaWkvSHdRa2Fa?=
 =?utf-8?B?dEtrd2E0S3d6cVRqeGxPRGF0SnZROXIzYWtHM1J0c09IYWdZQm8xclVIQUVo?=
 =?utf-8?B?WmVmVXQ4bW1zSGU4REVURkRqWnUzZUlSd2xHQ2RRNGw1ZDhDUUtGVVY4ejd6?=
 =?utf-8?B?SHFZREZZYldLak55NHd2dUI0UmRaeDlVb3gxbmNWbzJZZ2Q0L2JQekVRNjl3?=
 =?utf-8?B?VElYRlBxTVNsN2NLUUtPTnpKV2E3WUQybjFEOGxnNjd4Wlpyb04rV0hPQ2Yz?=
 =?utf-8?B?Wmw2TE5Nem5yaEV4NTk3ZEFEYVNEY1pQMGZMa1RscnVxTDFLNlovTjNaWk5r?=
 =?utf-8?B?OGNGUUtSTjAvWjhnb2RUVjZPRFFvcEIyZ1hjQ0VyOHdqdmQwQjRBWkRjV3Ur?=
 =?utf-8?B?amZIaExaYWRWbmV0V2xYQnN2em5welVwY2NSWTlrcVowN01EeFlYNG9QSS94?=
 =?utf-8?B?L2R1YkZSZURzaW5jY0M5MUNJMklpVFVwYkpHdklFTmQ3K1BYN3gyRExOVjlK?=
 =?utf-8?B?bjhNd3RkeW9KN1BFZHllclp2bVJjd1ZrdllkNGk0UG16Mk45a0FyS1ZTenNU?=
 =?utf-8?B?QVFzd1QvN2ZsV2NzVWdzYVhxWWpQaE1FT3l4ckZyWWRDeFlmWXdPQmQrYkoz?=
 =?utf-8?B?QytsZkhPanBObnB0ZXphaWliYi9zOFhmeWN5Y3NRdFY1VXptaEZaVlZFRXIx?=
 =?utf-8?B?SGh0UU1sbE1FaFVHRis4VnNtM240bTQ1Z3M1YmxxZFVVclAxRnA1bkQrQ3JH?=
 =?utf-8?B?eDlxdENxcldxUDFSRnk1T3FjeDJoZzdDWnlEZkc0YXBTc2NiY3ZMMlB6Z2FH?=
 =?utf-8?B?MVRRaVd2TWd5OXBPa0t5ekdlVjdSeForUHc3L0l4UHJUZk02U0hBc3lySHl0?=
 =?utf-8?B?NVBtTG9wZUR0aGp0TXIvcVVhZ0VsM3lCSTBvdkZKdWsvN292eVZyS0xHYjJO?=
 =?utf-8?B?Q3ZoL3lSSXlHQXQvdzVVdGEyY0t5RnZXNGdkUlp2bjQ0RlNraitWUW54VXQ1?=
 =?utf-8?B?Vk15M0NvU1krQUFPTk5lOE80dG9SZUdUMVBpL01DVjRQUy9OUjdvOXJXMjF6?=
 =?utf-8?B?RVlBSnB4c1VrTkZXeUkwN2drQVJxZGxaZW1BYWRGeW52M1h0NUdZdFd6UDd6?=
 =?utf-8?B?b0FpWEVBM3hYS0wvTklYcVJBL1dsWWxiRlJwNXVFWndvYXJtMHdqaStTbXBN?=
 =?utf-8?B?L21kMy9SZ29Va0JkakpHSFVTRjByM3VrUnR4L0dEcE1wTHFYOHBVb215ZjY1?=
 =?utf-8?B?cDMzdC9MaVI4MnBPWURJa3YzTStWSmpBRDlQaE5EQmIxMVR1cXFnbjJjZE9N?=
 =?utf-8?B?M2NzUEV0aFNXQjJ4eGRwWU0yY1NDNlIyOC9LYVZpNSs0T1F6ajJEYkc5OHZo?=
 =?utf-8?Q?XknBJ2v1iu0HfGjA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845795a4-c33a-4e08-09ee-08da421340cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 08:06:08.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O12oXsMV2oJzDXX0VduyG/n7cFqyu576Kqxaxf+oT6h7gUMXCHSA9X4LxoBWsL17NFQwKES+NZWqTw5VLP6dvIutuwe3oqRnB5qY18jkomU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5536
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_02:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300042
X-Proofpoint-GUID: FOJTrO_QOlmXo0T0M-Dd6UvB-8MUqqay
X-Proofpoint-ORIG-GUID: FOJTrO_QOlmXo0T0M-Dd6UvB-8MUqqay
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 07:47:11PM -0500, Larry Finger wrote:
> Compiling with -warray-bounds yields the following warning:
> 
> drivers/staging/r8188eu/core/rtw_xmit.c: In function ‘rtw_alloc_hwxmits’:
> drivers/staging/r8188eu/core/rtw_xmit.c:1493:24: warning: array subscript 4 is outside array bounds of ‘void[64]’ [-Warray-bounds]
>  1493 |                 hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
>       |                 ~~~~~~~^~~

This patch is not correct.  The hwxmits[4] is nonsense dead code.  It
has an extra element and the other four element are in the wrong order.
If we applied this patch then we would have to update rtw_get_sta_pending()
to re-order the *(ac) = 2; assignments to match the format.  And to set
*ac = 4 on one path.

The correct fix is to just delete the dead code.

regards,
dan carpenter

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3d8e9dea7651..2a93e7fa1142 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1483,19 +1483,10 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 
 	hwxmits = pxmitpriv->hwxmits;
 
-	if (pxmitpriv->hwxmit_entry == 5) {
-		hwxmits[0] .sta_queue = &pxmitpriv->bm_pending;
-		hwxmits[1] .sta_queue = &pxmitpriv->vo_pending;
-		hwxmits[2] .sta_queue = &pxmitpriv->vi_pending;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
-		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
-	} else if (pxmitpriv->hwxmit_entry == 4) {
-		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
-		hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
-		hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
-	} else {
-	}
+	hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
+	hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
+	hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
+	hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 
 	return 0;
 }
