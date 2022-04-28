Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4F5129AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiD1Cyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiD1Cy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:54:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B857520B;
        Wed, 27 Apr 2022 19:51:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RMb0Dv003699;
        Thu, 28 Apr 2022 02:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6DRBCBU9zxTgAOaraRisVx65Z2jV7At+q4+W/6MHW2s=;
 b=C6BrMf3LzvLvHB60MQ2XlFq07hJYL8V25whh17yPQOeBB1YwU7MVQ3I1TIDOEy0A1qNe
 v6Q1GHuX8U7E+o+Z4bNdEJP8feCCQpcVfkKsw/2OMn7My0SwUZUTJ293lbbkt5mWYD63
 ZB3+BLN+30sQXfh24K9yOQIj03VmO34A9vg7TCHEc17E23cZM19tCunEw9k9EyLU/mh2
 jltBHN8doGMpDekPlfhWQgUk04Fx8iF4xahQ6jwyMUf7OUZeoAIX7Lx7iRZxzt3E9CIA
 QAgabRyLYQ80yow3XKQEB/k5moB9A15szr2v3UfS6YcZUwCvdhNal8kdqe7tBQbZ0tA2 hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4tbne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:51:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S2k9Nt019823;
        Thu, 28 Apr 2022 02:51:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5u0u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+5IvO5oYfXmZW0YRGhsc1T4TDxU8LsE95fiTWhKv0MJ+NBpiYMWXt3gA0nFD/Lprz21Is+uaDMFr3RQGEjV6JMIGg1ECt/DEeXL3E/tchlaHpwplWJb86RjlR/hrCNLI3SAnTddGB8+0FRrJ2/VQNdj0+sXVVnubuBAbCLuCdcGsIIEuwC5+nIBLT/97KiOTl+5/VNdp+iRsnCVxnWUq2Vo9nD0e+tmu3UB2CbmXGRDILz8XHNSMaMGp2xzMvS91rDe3EYEl/fVeSbl7v6Mn6V3cE4pEwaJaDdcIYurTWYBxhm8v1SM5s6hmcU8dmgwmzI+7N5IElZv5A7bd9IHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DRBCBU9zxTgAOaraRisVx65Z2jV7At+q4+W/6MHW2s=;
 b=f1uIq0FZEZobGwp3rovQ5NGloR5JzwEwaxnCYBH8wdrvmXGH9MsJ+f58f8t2fL6W/EioruRZZMYe6mcgGZxMLxyaEATIOlmZUK01VKtxtc2eK55gx6+whLKUNpldCAj8BdBaQOhu/RQyJjswuWzzPX5ETV2OkJTd4OXnZUg8mAAmpgUsMt+PxFbNRtgJKxQUmrbMAiK7KWX8t+Dyb7us7YDwEW9kp9V5Xj0CAUNhdci3D/0jzecIfqwxymzwRP2FPBJPB47cW68Q3/qvJJZmdE74794VdM1HTNw12sF4voF6RYQ4UvGPPgCQ8GSemCiUxhsK+6v9gBcEHGm+ylQOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DRBCBU9zxTgAOaraRisVx65Z2jV7At+q4+W/6MHW2s=;
 b=wBC6q1/PjvCSO7t1bvLrG+G/bCeORV1AOCW6hdCAW0SOM8F8U0khPDMuoYW2vGzKp2JhddD+sajwt0trRej5VMPAujsqyX5zIUrOs0dlO9GFaj0va94DyAoUdJbYwU9qOrYM2gq29Bgmh93+oGBxoROSRlLNkDsLhEIK8lScJoQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1301.namprd10.prod.outlook.com (2603:10b6:903:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 02:51:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:51:04 +0000
To:     jinxiaobo <jinxiaobo@uniontech.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sr: Fix some cdroms automatically ejected when
 booting into the system
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfpxkjpo.fsf@ca-mkp.ca.oracle.com>
References: <20220427090906.2257940-1-jinxiaobo@uniontech.com>
Date:   Wed, 27 Apr 2022 22:51:02 -0400
In-Reply-To: <20220427090906.2257940-1-jinxiaobo@uniontech.com>
        (jinxiaobo@uniontech.com's message of "Wed, 27 Apr 2022 17:09:06
        +0800")
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ff51c2-cfc1-47ca-c865-08da28c1efbb
X-MS-TrafficTypeDiagnostic: CY4PR10MB1301:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1301E602AF43E63A6AF9D2938EFD9@CY4PR10MB1301.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvpb8sjo+rcspXXLoFr6eYGjgclYeQDVpiGQdsSnPeAd8DuKXZFcX6oJEmnFkAGolENDJ+u82LSdcXFm44cJR9N4JdliEHKH9KXvdb/F639J7vkgfIBWWyCaZc8WFG/euOipbjldN/qlrf7Zq28T4I7K/GGjdsub7Sz4FJizvVyxi1firXviHhStHCIDA4cuY67XGzwTd2FsUKqCKXOqZktmJf68ttB+meu5wPhZl4Wgn5pig5R2PRF2nDqq9HMEKngTyQssAy1Ti6fu3dLP6zLz1zszGzNsNeTadIywGNoxIXF0ZO/GLPicjRxCD/aSAw6yK4vd9vCoAcWsI70BjcksdqKbUdpkZZmUi4f/F9BWdHo5fwa5Qy1sVipfzpLS7IpWyBsguPtxNQxTTO8tPr6VFAzNdYEwcqyXv/6HRDjzqchjDpKTO9Bt+2hZkJghKgTmHUeWa4picmSDbz722qYQER9JZsVn+6Ibe0VzK3NNNA/YtJOKukVb03HbnkZCTXt8vNP8KQhPasW+Ld+BaH8+F4LCzbP/3oY7mkU/JVdHggea/Mjd0owPfd/EmKNiO3i/r8uKXdjpdn8MtQXhnTS4Tbo6iTPAI6NmzSRdjoQ9/QORXrKhBY5nCHSCWofd2dT4cmCXZjRG7i8FoGudMSnSUI0exdbrXVLjJPTlH0j/aoCZMLq3+mtVzeuGKr8b7G+i9N3Q4RDV/IKAND17zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(86362001)(186003)(6486002)(508600001)(4744005)(5660300002)(26005)(6512007)(38350700002)(38100700002)(2906002)(6916009)(6506007)(36916002)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l9wISOe9d3QugRfLRpr7OJaKzz9EL7qqD4hBknb4yaXUWEU8b7zlv891+ZOv?=
 =?us-ascii?Q?52iqW9/SCvKmREWMJrLd7fnITjJCyHQny2i/gmq4IOmOgy7IUDPPa0rGl1fq?=
 =?us-ascii?Q?TqGJwCoB2an7stGrmQIDnf8pbt0N+H3V+pVXHi19C3Vu+dsbrBF/5pL/G1l+?=
 =?us-ascii?Q?X7qaCIQwcsNcoxXaa3gZTln1EafsCsvA3/rKAITrkhzR9Wn+YmVvacf1MvDf?=
 =?us-ascii?Q?4drDfgD/GAuOLdrszBVPo8c1ZRsKFOvS9ZIXvyAWWvtnCnq7GqEnqVwsNls4?=
 =?us-ascii?Q?oB/CH+HNX3Rg87hsoRO6ZZeAFD54Tre1GYIzsrUsZTDy/96oOU98AM2wUuws?=
 =?us-ascii?Q?CIDBwb0pWbDXwsDFGlX9q0Fdt3E0bxmr/VcaQy/HJjNrLjEBoPQ7x8yA6VFl?=
 =?us-ascii?Q?Tofj38FBWCzL/U9x0+2A7ShOSJa0jATokjSUdVI6RiX10OTns6NlxRXnnJUV?=
 =?us-ascii?Q?2UsxBtM2sRhq1HaEV9RsRYpz4KFO+ca9YaMGChUYExlVPMaAo2/qV4zJHoaA?=
 =?us-ascii?Q?MHdcWNXTW18MS5+s6RR2akJej0DoU6zgKbOvA6r4Ns72XV4ZPbKY2yQYjYVE?=
 =?us-ascii?Q?m8OE2RQKG4bWo481qdfLcFoI7bmpe1T/o0xOyc5gp9n7h+T8l3gkVxouRcbp?=
 =?us-ascii?Q?vgC3yiD1K53fOoIPEHx/QbWM5LKKzOcA99OHMWc7G6Od72Yyi6dQoTzm5N7/?=
 =?us-ascii?Q?vwNPX+0/adL+zZlK4jkQUqI3kZ3TX02kpkbCNGrT7XQGn+3qZa2FHHI9ocRS?=
 =?us-ascii?Q?6unWdogS1EZVMX9klxyVR0+FXON3/FZNfwU6GLG4ZBtG47YtBHfW99DUHV/n?=
 =?us-ascii?Q?EpTGCUkyVV7ioxeBY/DFyyixTrN3q8fT5eT5KAaA8QPt6XIFzCVaxku3HNIo?=
 =?us-ascii?Q?pc7mvJfGpAtvUghx7lTseuDev4Dvj/rx3/1HosZKE1fP+NlwCvoGMEILUDe+?=
 =?us-ascii?Q?z0WI0A46/iS4sflaqEST32JjzZkMy6CmNucrzSgRGh4cv1REPJVU4TYsWSHn?=
 =?us-ascii?Q?QmR0HoY8VvlvkcyqgEtOmPRLrA6kHBVD79IX+/kpVpVX9iUzlUbqtWInf8ij?=
 =?us-ascii?Q?KYc2ZYv7yCZAFpm5d0HyGgbtSiGvT0CbrfJuiO0YM0zwwUIEY9JFvVEQmXhc?=
 =?us-ascii?Q?HEl3ewNrmOxeK6LW/ThTIiZD9tJH9ujpAyj+ibEuDbeo4KfTqa+KkJGZBYWu?=
 =?us-ascii?Q?ZvdkLnh2Q/ZoZjY5eC3pBfCWtz0bXZQum8fuMIuXafVuPSBW+QfPeA5351td?=
 =?us-ascii?Q?7rXIqefj6k8f39odf0uYV1CH7w8I3ssuBZ/mgerAnxUiU6uXaLU2hoqk1J6U?=
 =?us-ascii?Q?Qx4GMMUF/3t4LChmzENMxfjZQOg7XK0a0CP/pbZKDWqD8+Sly5Ev8+iQs7Yz?=
 =?us-ascii?Q?uqcAMz4pTGMihJW0Wy3/hFLvlYcqNi/sBvdDvkAhAR6rd/DdShyZ/JpN/DGL?=
 =?us-ascii?Q?zpEEtPeC3xT7aTIj3iigmxEzF6AVgMYCLwVqu4qoRZWcQ8KUqsHdqmVtgVM4?=
 =?us-ascii?Q?xXbZUvbtl1dPawNh3Sh3htTqCCRAYYyyCr9kQEVZ/p8SxSACkOnj2bzM9eBZ?=
 =?us-ascii?Q?dJKp5VPcpRL/NQrSjYu83sA2IyQHgsU4QP5dldG8L7E3OeGXAEr4BfwCNINF?=
 =?us-ascii?Q?w/qUw+njeGY02GaHYwZEDEEHSxqFTm426L1a0+HNcSZjV6aTDaiZRulu3Oga?=
 =?us-ascii?Q?n+pUQaI3LGqmB65VRXZzzYO2O+GSV5wD61TNRJBAjK7FQ713ruNnrmr6w4eR?=
 =?us-ascii?Q?i/U/0EeJH6d/Mw/sW8fYPNhjqk0RvMY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ff51c2-cfc1-47ca-c865-08da28c1efbb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 02:51:04.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7dHirrfCdX30OOjeYgHD/HR/Jhry803QBOeRH/c4O7aYuFfQrzeXqKKLYJ8IpcET2IgVpoEsNYy1YPWimAxAW8IWqxIUaOBl12rzkNt8Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=565
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280014
X-Proofpoint-ORIG-GUID: bkAv93Uu39H0PN6MEKDa3nd8SJXswT_R
X-Proofpoint-GUID: bkAv93Uu39H0PN6MEKDa3nd8SJXswT_R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi jinxiaobo!

> sr_get_events() has been called before udev starts when SCSI CDROM is
> built-in and AHCI SATA is bulit-in,so sr events propagated to user
> space are not handled.  if both is loadable, udev will handle sr
> events, some cdroms may eject.  We need call sr_get_events() once
> before device_add_disk() to keep the same result, whether both are
> built-in or loadable.

I am not sure how calling sr_get_events() and throwing away the result
ensures that events get propagated to udev. Isn't this just changing
timing slightly?

-- 
Martin K. Petersen	Oracle Linux Engineering
