Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D4523C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbiEKSPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiEKSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:15:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD4E15CE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:15:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BH3oBX010445;
        Wed, 11 May 2022 18:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VqtY+bD8cvDmZjFMSDzXdcH3a8Q+lkYDtjLSMBgEnT4=;
 b=qSmtq82bgSSa5xZcYD8QZOPeQNEZX98P379uVwOkYuo0qhStvQcYFQq5+yZXEyOK/vax
 wWXyS76YSwmLpOiP6bm+xrjugWqnwlWgg/nvRGZWdr/xONrmF1tTA1e75oJRohR6HJFX
 cOwSQAaXqdHRPCbk33zT8j/KmoCcerPsGl8YBxrDBG9H3oGe9vbgJc4gxTWs8C6XjA7Q
 dzTpWI2TOVe88yw4bSJUobI4ekGfHtDNQleYS8Dy7iq0kG3PSRmlj5SLGYY4gDFmdFLk
 HqikVoVKwew50nmDGqE/S67IskPV+sptdPmzz+DzG0+Z7Ltx6sCELMriLB72RU3v4RjC mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cacyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:15:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BHuflw018189;
        Wed, 11 May 2022 18:15:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74dhna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A770xIicbt4N27lxcSOacmyhid/BiBTYJtBqU7SzWHu56nYSM5QTjERPTnL2YIBVH8HxjTYO6ULnNABNdKS3HNl0HHUcER/yyBAIrmMrHbEw3yKvQNBG0ClOsY+ka8UDi5+qjrdQLBv43wr6isv5LlD0IgAuiArYOa5r5mY0dOniv7cJOrRwWQBHivUWTzAQaYygyNHBCvqWChVTaPpCoVKxI965+e0CszSUSqH7nK2sUonOwDuGrETzr/699D2SmvrDrRMHG3S1qb8fZhM/CBUwE+kTRoqmYQODxAawk3LHCGdmCbCEey0mPEx8GkBaxsXEsGYJyfSKTMWzjP7rNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqtY+bD8cvDmZjFMSDzXdcH3a8Q+lkYDtjLSMBgEnT4=;
 b=MlJ4bdFrd+G5kdFYUvlT/j1lR3bCn9Lcypqv/KQbJzHRLHM/Um4nuwMv2eTASJAy1mo2SRxULtZ9IQXRuqHPgK8W9JxDAQ3SrZFiKADhecySurzjMz+iQoA17l957u605fuPpPZ+xSV5B2K/8NFKLEVZ0lbhb4qJMZSh32nczTPXVyyDSb8Rrget16aia8uhhysmtzO08Zmy5u8xh3cNNH746Mg74J/+EhBN7qpBT+SapcG3jPvaxgAFOotsUXt2oCo4UP+KcU3Ovv92EFCoojbllVK6aTeehY8+i+5XZlKmPg4Dj+/2RuQ5blEOe4gTqTRYBrdJBW5UoXkwtM3fVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqtY+bD8cvDmZjFMSDzXdcH3a8Q+lkYDtjLSMBgEnT4=;
 b=deFWmZEZaDnLpwH6YoVxtd5F87PdlJHjEetJfXyz1lGJrwb/rCy7YM0ECOlkG+sOF89NiyO0KZsKmWME6BDZ4/2FXFu2FcszsUDB9rt0n6g+SKkI5ZsFH2PR/zMggBEgA0MNfYP9EY2HecMaLm059qnBO8xdMZu+eMJvprgR8Qk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MN0PR10MB5983.namprd10.prod.outlook.com (2603:10b6:208:3c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 18:15:26 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 18:15:26 +0000
Message-ID: <16ac3484-0361-94ca-118b-74cdb354cbc0@oracle.com>
Date:   Wed, 11 May 2022 11:15:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/3] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-3-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220510112734.205669-3-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ed6cec-0e15-4062-6a57-08da337a389b
X-MS-TrafficTypeDiagnostic: MN0PR10MB5983:EE_
X-Microsoft-Antispam-PRVS: <MN0PR10MB5983413B1338375C2C86C838B1C89@MN0PR10MB5983.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFyV0kfRN+8vVMaAfjwQ7nXM7uqdljqyf87xdBodaNmHBnB7i2ebY/mKECAxKzoK54rxKsFkKvFnncoTf4jPi8rDnmvKwqF6ZnhIJELbk7XqkJWI/lRbPMG12YispHoNyWeNIUciqbUlLeEOvc/KjaBz8XtdNmj0pxjzkpaSYPwrBbdjtPUYsyC2IWLK5oZKjXvFRNkGi3OP6yp8frOs7c9GqRgmBW0IfDSzY7ufxgTYqRacTg8f0TyPGXWaZ+vpXZqBJKffN2DN6q/1WVb2ZPnQPxhdcUijWYsrUEtdqg/UqCVYgBlAaP4DvU7BQ5ZlwWEs//FmOLF2yr+JYlOn2iB4sTBh5Pb8m2lqMLOZxWz8HpCJZJnqbV/IaXSOIQuBlZy/eoGXelKpGrYwP39I/It+PLrDBygc9+1QtTT8393Nbs87+Zbw89WU2ay0Z4HpTGq0cIJMyLNenixOPiOKToY2VEmRjjR9EEgUXcjYVFRrgc/KMs8R4kJ6VVrRWtxFDzoIn2I7AsdGLE3Ss0QxTlK8MgMwo9A0eBovOcbZtW77YI3odHXxqk4/60YD+bno4ch6YsZzzf193OIH3L0l7R+tpq5QglCjBcZJjGwGCSQLP2N/w7RKrqGkAHp9bsXHwV0kUTaf1lVrb2JWaIMVvYumlvvOkE5M7L0rQaW1iklsJPF+Y3AEQATcVJPnbYMWZGu4D/h+Pob/a15wTR1sVU7CYp09mBYsC9sykp6gNiIx1Dmp9FgFn77mOsuX5FQnHc4Vfb25tybA0jgS6dbRt471H6OMVJxJ4YS+73Q4jBsBftOUeGRTuLWGkcF8LSfi+ONU9nBGPmZbJ2+BBM+lXMBMtwOBT2Ys+WaSWIn7ViMLyeNPjR1Ac0Bdjo0DlsXc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(66556008)(2616005)(2906002)(36756003)(316002)(83380400001)(31686004)(186003)(5660300002)(31696002)(53546011)(26005)(6512007)(6506007)(45080400002)(6666004)(4326008)(8676002)(36916002)(508600001)(6486002)(966005)(66476007)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTE5ODNOTTU2b2hKUjBFYlFuUUcxYmpKQXJFdy9ldFVzV05UTXdOZ1pJWXF6?=
 =?utf-8?B?K3ZBN2R1bnpFNGxJM0dhbmdlTm4vNGVaKzlGQ2R6Vld3YnV6Y2ZsZldPTnUx?=
 =?utf-8?B?RmhzRnprdUd0SWxENVNUczBDc2dSeW0raHgxQzlwbnpGSDI3UHZ4cFdnQkxM?=
 =?utf-8?B?Vy80OTRFYkZjem9MbEFQZjR4cnFyMi9SRVhEODZtQzVGcG1iZGxFQzl1VU9j?=
 =?utf-8?B?bDlRZ2N6YUVWcytQM3d3OTNKWUNXeGF0TWs1cE4zc3NiMDNvZ1R0RmFGL0pv?=
 =?utf-8?B?Q0dMOFRQWkZIMlF3eTlCYXZtODMvM05tck9EY0RmUlpPakROWmdkUTE3VEhQ?=
 =?utf-8?B?OXZ0YU9IMHJna2ptK1diVjd0TzMwSmpZa1VFZXNJVHVyS2cweGxaSEMyYTZk?=
 =?utf-8?B?NE9pWjhrZndPbnNLVUlKNGptcnpxT1pTZkhDQ0JWcjJQWlJhSEswdGVsN3c0?=
 =?utf-8?B?S1hkMWVUWG0wMFdGbmEyRzUzdkVyQjhrSm1tUkEwY0JjcGM1OFd6SmZuanlJ?=
 =?utf-8?B?ZDlwNWd3NE1nLytUVksrc2puTDFtcG1NQ1dHaStJMkVKaHZ5WXpOZUhmWFF6?=
 =?utf-8?B?OGx6ZFpPY3JKVEpVL1psSDhWUGtkbWRsZ0UyWDRsT2RHU08zZEd4N295cXpY?=
 =?utf-8?B?MXVMT1Z1SXAxUTl4dkM3WW5HU0tvbmVrejFwWGJkbjlBYk96UEZnazhUYnpa?=
 =?utf-8?B?RHF1dCtyMjlNSFNwMlY0dFowOER6YTlqdlhDOWcxZGhWcjAvYlFaMi9sbFBW?=
 =?utf-8?B?a1VwaVUwc1dqaC9tajg2VXhKcTMxd1IrRklwWDI3bkNTZlovZXFORHFXRmpE?=
 =?utf-8?B?QUIyb294cmV5MDgveVp6UWNkeEdvcDR1Q25XNTEzMS9ndlYwQTMxNWhMZFRB?=
 =?utf-8?B?cFB5bEJjNTV2ZUtZb0RycjZGTncvOE1BVy9HSTB3WHpVa3gyTG9lNk8rUWtL?=
 =?utf-8?B?YWlLcm14SXZZb0UrOGNrWVpaZXRMZWdob2ZGUjNLeWxzaU5xQlMzMDRtcGM5?=
 =?utf-8?B?Nk8vRUs0d2QydW0zQWR6WjJhK1BHSm15NndvdktzRDJiUWc4L0h4Y0J4MkEy?=
 =?utf-8?B?NkZkV2cvL0ZFempZR2luODJqSGFHNVI3ZTNKSys5OU0yREpaRWZhcHl3MDZl?=
 =?utf-8?B?MURRVjZJVlRMQnVLOS9USktHZUFhNGNURHBvWm05OGZmRXdLbmNpSFdjQXZu?=
 =?utf-8?B?d1RBcmR3Y1NWQjBCMXU3bUZEOEllaWt4dW1tMEphSzFRZytTajZidTVVSmIv?=
 =?utf-8?B?M05kWG03N3YrL1R3eFphMkpIdTlsT3VpZmNWaW94aG9wQUtnb2thRkFPRExi?=
 =?utf-8?B?ZEFzNE1VYXZrSXUvY0YremN2WVRaN25CekQzVU81Ykx0d25ZdStRK0tlZk5m?=
 =?utf-8?B?R2pIbldXNkY2L2trWjZjbEN0VWZLVkJWVjl5ZllVTkJ3OXFVUXNNL3M4MWc0?=
 =?utf-8?B?MlFONE5LRGVPZkhJNnpQZ1llbGduYmNxZnNqKzBTRlZzK0FJR1JWQm9KWWNO?=
 =?utf-8?B?SlZKb2xpRFJ5M1owcGxDVFozbFlyQzNBTENUMkx4eENyRE02dk5PNXc4a0Nx?=
 =?utf-8?B?dHRyRE0wbEk4TTJSVjk0TGg2Zk9NaWFsYTFWeGFsZVNDZytwVDhJbmtsc2Y5?=
 =?utf-8?B?UWZuV1BMQ2haclBsNy9CdW9mVXFDUUxFUUlJTGdTSHByVmhaSnhSM0F3ek9h?=
 =?utf-8?B?Mm1wb1o1S3FJbkJKVUlaZWFxaTJabTltdDIwYUdoVUwrRzNrcGhoREN6cGtq?=
 =?utf-8?B?ZlYwc3ZTa0p1UmJSRTZoZC9iMzcrOHVyeWdLbXBkN052NE1wRXVJeFJsdXVV?=
 =?utf-8?B?NHN0SVNPUFlnd2tKamNPa08wZExnS2lrSU83bDYrOU8zYlpScWpITGdNVElR?=
 =?utf-8?B?Wkt3dHNnd3c1WjQvTWFKWVh1OUZ4dFhSdXBvZEdKU1Q0ZTQrK0szekVSM25S?=
 =?utf-8?B?RlFsWkRMMktXVXVkQnhUbGNKUjZZLys0aE9DL0J5MGQzZlJTNXJZYUxrYThP?=
 =?utf-8?B?cUhEYjg5bFBvL3lmcEt6dXpYL2JmM0NZYWFiYUZqNkhiS3dVb0s0QjRqZ0hS?=
 =?utf-8?B?dHl3Q2luallRMUJoSXJrKzZ0a2NxaFludytQZUlXZHdhenRUM29vMC9XN0VC?=
 =?utf-8?B?VExQVW5nQ2ozenBPL3lhK0RTUU9hRUJtQ05FMzN4WnA4SkV6SmhqVSszNHhH?=
 =?utf-8?B?djRUY0VSMzJDbXNnNVJXcFhCbW0zdjJUWnVnUWE3VU85SXdWbmdMcjdEcWFQ?=
 =?utf-8?B?ekZpVlNHM2tYYjc4ZjYzeDBmcVR1ajdlQUd3QzFnQzkwbno5RXVtQXBDUFRo?=
 =?utf-8?B?cjJmZ1pINTFIWjVKN2phd2VIeXlORjd6MnkxYXFCekJ5TSt0Z3pqejVuODlW?=
 =?utf-8?Q?AsBD5mJ8KDLoCqBQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ed6cec-0e15-4062-6a57-08da337a389b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:15:25.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjkmYAsGRAQ88GpZbdvKCVFP7UkL9fTJvkhNUcXsyiDZ6kZO/RDFOKDBLAooYKkLoI/2o5/cWHH5I+wKixEpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5983
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110080
X-Proofpoint-ORIG-GUID: MPrtJSnuiwHP3jKbkxkyQrx1vZqEIFDi
X-Proofpoint-GUID: MPrtJSnuiwHP3jKbkxkyQrx1vZqEIFDi
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 4:27 AM, Eli Cohen wrote:
> Allows to read vendor statistics of a vdpa device. The specific
> statistics data are received from the upstream driver in the form of an
> (attribute name, attribute value) pairs.
>
> An example of statistics for mlx5_vdpa device are:
>
> received_desc - number of descriptors received by the virtqueue
> completed_desc - number of descriptors completed by the virtqueue
>
> A descriptor using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists.
>
> Below are some examples taken from mlx5_vdpa which are introduced in the
> following patch:
>
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>   "name":"completed_desc","value":417548}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>      "vstats": {
>          "vdpa-a": {
>
>              "queue_type": "rx",
>              "queue_index": 0,
>              "name": "received_desc",
>              "value": 417776,
>              "name": "completed_desc",
>              "value": 417548
The [IETF RFC 8259] "The JavaScript Object Notation (JSON) Data 
Interchange Format" states:

... The names within an object SHOULD be unique.
:
:
:
    An object whose names are all unique is interoperable in the sense
    that all software implementations receiving that object will agree on
    the name-value mappings.  When the names within an object are not
    unique, the behavior of software that receives such an object is
    unpredictable.  Many implementations report the last name/value pair
    only.  Other implementations report an error or fail to parse the
    object, and some implementations report all of the name/value pairs,
    including duplicates.


that said, duplicate keys in a JSON object are really not recommended, 
which have the potential of breaking a lot of json parser tools. Are you 
going to revise the example, and implement what Parav [1] or me [2] 
suggested earlier? What worries me is that the  new output would 
ultimately affect the placement of attributes in the kernel side. And 
looking at the userspace implementation, it doesn't seem like the paring 
and the order of "name" and "value" keys are ensured: for e.g. name1 
name2 value2, value1 value2 name2, name1 name2 value1 value2 should all 
be invalid. A buggy vendor driver implementation which doesn't pay 
attention to this could easily break script-able JSON output. IMHO it'd 
be good to have clearly structured and self-describing attribute 
placement in the kernel rather than have userspace validate all invalid 
combinations.

[1] 
https://lore.kernel.org/virtualization/PH0PR12MB5481F6D44451F01814470112DC089@PH0PR12MB5481.namprd12.prod.outlook.com/
[2] 
https://lore.kernel.org/virtualization/6175d620-6be3-c249-5482-0a9448499e4a@oracle.com/


Thanks,
-Siwei
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v4 -> v5:
> 1. Remove unused macro definition
> 2. Avoid policy on queue index. Do validty check in the implementation.
> 3. Restrict to VIRTIO_ID_NET devices only.
> 4. Improve netlink error messages.
>
>
>   drivers/vdpa/vdpa.c       | 140 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa.h      |   3 +
>   include/uapi/linux/vdpa.h |   6 ++
>   3 files changed, 149 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index fac89a0d8178..91f4c13c7c7c 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -914,6 +914,86 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>   	return err;
>   }
>   
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +			       struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
> +	if (err)
> +		return err;
> +
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +			     struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	if (!vdev->config->get_vendor_vq_stats)
> +		return -EOPNOTSUPP;
> +
> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> +				      struct sk_buff *msg,
> +				      struct genl_info *info, u32 index)
> +{
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +	u32 portid = info->snd_portid;
> +	u32 seq = info->snd_seq;
> +	u32 flags = 0;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_VSTATS_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	switch (device_id) {
> +	case VIRTIO_ID_NET:
> +		if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
> +			NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
> +			err = -ERANGE;
> +			break;
> +		}
> +
> +		err = vendor_stats_fill(vdev, msg, info, index);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +	genlmsg_end(msg, hdr);
> +
> +	return err;
> +
> +undo_msg:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
>   static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct vdpa_device *vdev;
> @@ -995,6 +1075,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>   	return msg->len;
>   }
>   
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +					  struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	u32 index;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +		return -EINVAL;
> +
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +	mutex_lock(&vdpa_dev_mutex);
> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> +	if (err)
> +		goto mdev_err;
> +
> +	err = genlmsg_reply(msg, info);
> +
> +	put_device(dev);
> +	mutex_unlock(&vdpa_dev_mutex);
> +
> +	return err;
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	nlmsg_free(msg);
> +	mutex_unlock(&vdpa_dev_mutex);
> +	return err;
> +}
> +
>   static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -1035,6 +1169,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>   		.doit = vdpa_nl_cmd_dev_config_get_doit,
>   		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>   	},
> +	{
> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>   };
>   
>   static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8943a209202e..2ae8443331e1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>   			    const struct vdpa_vq_state *state);
>   	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    struct vdpa_vq_state *state);
> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
> +				   struct sk_buff *msg,
> +				   struct netlink_ext_ack *extack);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	/* vq irq is not expected to be changed once DRIVER_OK is set */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..25c55cab3d7c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_DEL,
>   	VDPA_CMD_DEV_GET,		/* can dump */
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> +	VDPA_CMD_DEV_VSTATS_GET,
>   };
>   
>   enum vdpa_attr {
> @@ -46,6 +47,11 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +
> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> +
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

