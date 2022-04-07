Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32054F8B45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiDGXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDGXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:17:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E913C70F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:15:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Jv8tV005378;
        Thu, 7 Apr 2022 20:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h42ziWwbYgAUAYilcI+fTyDeYpkmHQ3G1Gs2uWgyrkI=;
 b=ZNhG4Bh8vsgnHDnE0/T9teWYem0k48qSlmuqcNjFaOddQ4IdJnU5IEV34rqV4/9OyPLW
 /ps5s4lOOFjkxlSdAA2WZlaKc6m5+dy0BEIKwQMAGaDUdIT6x5AA3jBURcVskjqNzpo8
 tCOCECaNDRfWO/7rWm+U+yTwYIyX1vpVeV+NhPoiPhdBJ3ZQAmb0EGMrOxJrN0+Bmkoa
 Wk+b8kCU53ZxAOlVhnuDX6K/V+aY3SDAtxMFfjK8vifaPZRfFjaKfDnBZDzL2Q2InmUK
 5sDjSElRoAaZts7qvFb6gw2f0Z/ZgHYKk3gPQP8px6aP52bQNYyxSBzYNXp/1BuIlBCt Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d9351ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 20:04:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237HXJUL031723;
        Thu, 7 Apr 2022 20:04:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y81p00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 20:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0BEC/FY8vcf0RSqYzSgvfgbXINdcGhXg7crd9YNJzPSINjKrlz+PBZxf/Uak9PTIK41AMF1HpOUU/H91soZ2OWXfjuXaFpr5YoHsx3P9Ad+LphL2rWdtpMn2sDjL0pRipHzTNOmhLlTFY0PkMbekf0PUlkKHIQ/yvZiYktViC7M/L2enyAe7Z/15WKZQ9adCYtlG040jxCt6lkbLboBk5NxrDskKron19qOSnqYNAHXzV7+esSG6UZAoGFt6rn7J6fE3bpNndNKRdCUPg+tbvU35MhxfvOufDFYhlFk7QZR5jJdW9EDAFcqnmmD6DFIuvHSvqKsWzOkBp9TMZfdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h42ziWwbYgAUAYilcI+fTyDeYpkmHQ3G1Gs2uWgyrkI=;
 b=dCDMlZI8oHVb8x49N0mMuDqW6IaGTomRBEd/H8lG5ZUbtCOaRyNqpDNnBcZbEQFenbKMTBugE4J/PhZ5OIFrNe97kbieZTmFXYZPb9mJfnKp+I3IGFwLrv4aw+IXqbnq2tbAR6ywp6ZMR82c/rw1GA6ChDEbnNCfSCTinXPlvVn4C9aFqllVG84rTGpmeIAl7ebuD6+9HqARiMgmnPUxrShd6CZuIyyxiXb1cNYiCJUBJY74xRoXbg78X22T2IS5/AAg+B58e55aEomIcQbQMpY9P7I1UZY7Nd3QH3kFWwMpXDjqOjltR8KcLCZCZf0AsGQWx1qMIGrVGIZZmR9bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h42ziWwbYgAUAYilcI+fTyDeYpkmHQ3G1Gs2uWgyrkI=;
 b=efCn9AN2dZ4GoCBRbA6RAEgei3f2uutgZg28hIe8+tpqw+tuxIkpHQJzME8EohbuZl66SDKGZ8mC1spOfsqMply58YMDo4FBRuUNraWxwz3g759kk4UrSzvxvfVeyREE1g2vVbUkeWCE8dA2+8Di9lXMBcguBwG63dvszSMt2yY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR10MB1472.namprd10.prod.outlook.com (2603:10b6:300:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 20:04:27 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 20:04:26 +0000
Message-ID: <c2d5f0c5-803d-7ca9-3f57-3d230874e310@oracle.com>
Date:   Thu, 7 Apr 2022 16:04:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] xen/balloon: don't use PV mode extra memory for zone
 device allocations
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220407093857.1485-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220407093857.1485-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b83252-a378-4918-4fe4-08da18d1d0fb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1472:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14727C6B291BCCF1220DE6078AE69@MWHPR10MB1472.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H/KapVb7bQbxksmPNMazJtY4exlQKblNPc/D4qnLgKeNUUQzPBXcUVYrzOlGPrGGlNRdMc0gdocjWt3FZeyUiKWbZMSFJvBORs/L9ujxp6csyPlWEdUPYnqOJegE1u8Zl257kHXZbXJWlN+P5qrXSF7ZccLcJ4si06XGlcg1AuzRfWazpyD4rYhms1467ZW8JqN43kvkeNVm1rdQB7GYKrD0XRpB+l1rgBS+uhE/4vHEgp1EmXa/mTAhcRTWNXGpHXOCuvo9kJ5gCjAf+Sn0AIMnQqmLdd/PBS5eCrQniSEvsywc3wT786dpXW5ixmw6PNkkxXnGRU8SgukfaoL2f2jnH2xw4uOVitji3f7DO2nqe2X/XgTHubiIjudtOnyvj3MFqBUfE7aGtKEeN4FCtEOFeoAprkqomsTmN/F33tDuHwrTkZoG+yvAGCj2Ic1A+PbsjtFd6u4P/+gMgEb3Pt3IP2LLqKUa/AqKV7RYGy+d/lMOM9klyWXuraPWIWqklCawBPBtaP15WyStlkOSL8wPgZ1XGf+sWaywC4V3uAn1pI4288A0cDSCIVOGk9iznNBJn9XxQ9U7ic+oJ9N00zOfYKTtPNrL3ahLMS5qp4wSyXes61S4xLBHxuAXrRz6yG9gr8rBIRgH4oWwU29EUHG6JTjD1eCSwp7e1L0uWH2WrPT+BbUikcvtvHiy96rLyo3v/3i+pE7cB/xRv/MEgl7vW0nch83USzvemmymTqlgqnEarcJxP/E9b3pm2Qk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(86362001)(66476007)(31696002)(4326008)(8676002)(5660300002)(66556008)(38100700002)(316002)(6512007)(26005)(508600001)(186003)(6486002)(6666004)(53546011)(6506007)(31686004)(44832011)(36756003)(8936002)(2906002)(4744005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFIaXZwQVdjdWdzelV0eUhaSmlIeWhIdm9CMXh1OGszSW1WU05mL3FVYnpP?=
 =?utf-8?B?cDZaYStKdVU0TTFGc1BRVFB3b2V1ZFRiZUE0Tm5iSkxNRGRqWGFHSXVEdDh0?=
 =?utf-8?B?UEhyRi9TcEJ5N0hsOWdJdFo2N2QwS1d5SVBHOGJ5dUpSN2FibUw5dWV4cWtX?=
 =?utf-8?B?WDdrWi9kemMxV2RkUlEvSHVkRjRFQVU3QzhLK0N4R0NTbHRSWTNzVUhWZ0xw?=
 =?utf-8?B?YldtaVNpZDVJbi9VbkZNQTNHNHFHNytjSUNZanRBT28zWXpJS2R5N2xWd1ZE?=
 =?utf-8?B?Skt3NWpORmZpT21vQVV2V1dDSU9icUFMc1lTN2tkUFgxYUYvZG1uZFZYM3Jv?=
 =?utf-8?B?WWdld204Z3B0Wm9yUFZrQmxzSU43ZGZiVFJHWG5YdEYwWnB6a1I4WUduQTNN?=
 =?utf-8?B?ZzJKTmxnc2xxZGZVMmpUYTVkRDRpSlhNUG1IN3pvaVhFUFUxdzNTdjgyTHlF?=
 =?utf-8?B?UUtNbTFjRktVMFpVV2J2bStXN1B6QjZFclhyeFJpTlhqdmRJQnlSTnNGTURD?=
 =?utf-8?B?R0JweXFaYmNBTmVubEtJZVRXdWphdXA0WG5KV2tlaFNXL0lhOXJFc2dpUDZy?=
 =?utf-8?B?SVI2SkFJeHdjdUV3N0VzdEdwYTNYcjB6VG93WTcxbXFlcW85b0ExbWI0L3NK?=
 =?utf-8?B?M3BoK2RrNVlzS2o3S00zb3Y5cmN6eS9ndnlNUnNXaEJPb2VXM2ViOTE4aVpJ?=
 =?utf-8?B?V0RyaUNaVnYyZnExYURNUjNqcHNOYUtFeTU1SXA2UGtDMlg0Tzd1WVFzYTZi?=
 =?utf-8?B?OFVlOWdhV0RtL2dSWEdTeFdQSldKc0JhajJ5UER6YUt5OXJTMkxSa2NSNS93?=
 =?utf-8?B?SmdxdUY2OEc1V0pmVXRja2tSMy8wNCtaakk0STZEeVQ2bHNKY2VGeEZqVVBs?=
 =?utf-8?B?TXZnS2c0R3M1VWk4dGxTbnhIRENpY3lvcjU0emlMR2hzNzJpRUhIeFJ0UndE?=
 =?utf-8?B?NFdqc3NpdmJPN3RVUTNJZk1TWWdaN09lM0M3b3RhQk4wV2xSZVNZdmdIbUQ5?=
 =?utf-8?B?Q3R5NmoxSjVIQUxyVGVWQlU4WGkvSXk5TWdkbnJOaGtKTWxweEFnVUNldDBn?=
 =?utf-8?B?RFBJNTlDdGFpTHJWdzBQSUViSFdRSEE1dGFEVUJySVdpWGUwTWtyVlY2RSsz?=
 =?utf-8?B?R0p2NndHMXZ6YlN6MFFFcktIdkhLWjZ5OUhRbTZpc2VOcEFjUk1OSFNDQ0lo?=
 =?utf-8?B?MDIrbjM5WDg4ek5WSXlaKzJ0NURPYXZOd1UrdnJGRVRpT1hXQ3BSUWI5ajhS?=
 =?utf-8?B?ZDQrL2g4YWdVOGVpTFdndzBpbHpDTmkzNmROY2hKRUFJWWYyWjF3MWZaNk9l?=
 =?utf-8?B?WXlVOURWcFlZdExYRzZDVkFWV2pHYXY0MHZnenhjUFQxTlJYdThwZ2ljMGI5?=
 =?utf-8?B?Y1VvSEtnamJDUlFQUzdZdjZkZVRKTEY2NG9mOGtUenIySEdENDk3UDlNVWpn?=
 =?utf-8?B?MWFjUkgyZ3ljaGR5M2ZGOE9wU0FJSThrZmczRXpJVms5UlhNQTErQTdzQmxP?=
 =?utf-8?B?RldEekVTNUpNU3V1RXhkYjNEakRSMmpReS9OT2NOU1J6RC9yaGVjWjdkY1lo?=
 =?utf-8?B?cG1LS0FRNVZvamd6aWFmaGJLd0VhWDcrOXZNck5RekI0cnZkT0FHWlFzOGVP?=
 =?utf-8?B?SG13b1dteWtaUDBWcGlOY2ptV1ZUL3ZDczlEWXlCazlibWtjVjBuYmlCWlUy?=
 =?utf-8?B?cGRXMHQ1Q0pUTC9ucnN1K3dmQWtLNFNWWW1pbm9zbk9ZR3NVU1JteTZXU0to?=
 =?utf-8?B?RXM1elU3cFVZSG84KzloZVlxWUZkQWo0YUpKOHNBSVIwejdRcGhJTjlCd3pL?=
 =?utf-8?B?VmpwenVHeTdxT2xJZXlkdWpRWGgySzM0dGpjdHY2K0JCbjR2QUQxTTlBLzAw?=
 =?utf-8?B?Y256WDYvUzBEWDhYWWxQTmJIWUY0MlZvU3dxZWpDalBOamFTQTVWa2o2UHg2?=
 =?utf-8?B?QjRkMzE0TEdRaVBxWWhVZXlRTUQ4UHZEK2dPRy9wY0ZqN1g0Z3lnL3prelRS?=
 =?utf-8?B?MXppUW5pSXArd0RjQkpJcEYrdS80VXBSU2RJSTAxeFlrUUFnSE9JU3VOalMv?=
 =?utf-8?B?SFNzeVFCMDRHOFlOTUY4N0RTS01HSDlkTmF3YWE1ZHNUL3R6eUtPdGg0YlFy?=
 =?utf-8?B?eThqZHNiRnpSSVNNVm9xUExYNmtpQVBFQVQwRm01azFOc0FzeXFrZk9ybkhu?=
 =?utf-8?B?d05BaC9rWkgyTWNvV1FpWXYyYVQ5RTJhc0VMMU90VDFaVVdQR1pKczlTRVV3?=
 =?utf-8?B?VWxYUFhsR3I5bnlOVExhVG5WRXlRbytwQWtEUUZ1RWhWL0Zrd3NpVVhBSlNY?=
 =?utf-8?B?MmpwWnordGdyaGhFaWNpbTlsYWhPQ1BrSEpFdEFtOWMrOHlHZE9MVzlGRUdE?=
 =?utf-8?Q?ahXLLHU0dBCxssz0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b83252-a378-4918-4fe4-08da18d1d0fb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 20:04:26.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gdLGAd+j1xDqALvMWQE5Tc7SRuJh/+R9mMsXmQ36H0XlKa6zsVaMZKmTv4oejkNeezk5WHvNjNKsdyeoZne9n/QwRqNS/ZjDEw2eJmTd9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1472
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: OdMpIMOh9LFK_hvTvb4Zpv18Cayr15SY
X-Proofpoint-GUID: OdMpIMOh9LFK_hvTvb4Zpv18Cayr15SY
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/22 5:38 AM, Juergen Gross wrote:
> When running as a Xen PV guest use the extra memory (memory which isn't
> allocated for the guest at boot time) only for ballooning purposes and
> not for zone device allocations. This will remove some code without any
> lack of functionality.
>
> While at it move some code to get rid of another #ifdef.
>
> Remove a comment which is stale since some time now.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



