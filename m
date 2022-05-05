Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61651C563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382094AbiEEQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382052AbiEEQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:52:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EEE57B3A;
        Thu,  5 May 2022 09:49:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245FpOYH029440;
        Thu, 5 May 2022 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=koXkNIsnQ7LNgQmg0K2p0OWzWbKo3wV9b+ieue/AOYY=;
 b=UaRu8o92CItQ3beUEb/3RvjM8ygYEAiLlSQHXzerpyinz9j7UCA4iKi1Z1dgCJK3Xs3U
 jNoRk9Xz9RvzE6PJgigEi28/W4kLAZL4R1NxkMEtY6uSummkvMWSGNoyZQFdzo+qYPfr
 l8IwpqNH1T0lKJ+9Abfa9Wp8TnZ+GLHrGnq7//ji5fsQtjCHKyNYVcgoqN9rNXly+oAF
 WZO/Ro3HSIkVeJA5CMOItig9VlA9jbHwmsAtCjCloURyOZsQpZPeCeBNVxKya/GQmGH8
 2jV8SUXESCwSuIauZGBxOdjC7MhakukvLBBZTec/3/7lodqgvAx4ep+0XxoLqimnQJZX Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0m1dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:48:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245GkYhc005668;
        Thu, 5 May 2022 16:48:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus8yahdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSSSoQcypwSn/kNyQj9gQPZc6oSUvg09xz/2v3dcsltgJ8a72wZq21HNKkqZxKNVNyOE9Xvcg4Jh1ma1DITNk+phsYbBVUNnmx7GzB6P4+Dxr+pQ2MwT4WX+N11tMGlmwIGv729m+g0t9Ng8wSGifzjf0Xa253htW/EFU4nT+QYEaLXqOpYnTNj1tMRUYb+mLUUlo1vFnyV7Y1+EyukMwuIIxboZEk3oMngRkaSZjFR+0xCVIV3m6ibnM/6fUFIeh4BSDG3OU6ZI0CdswQCXpoFrBpkrUk94ipPeOsOh0z0t/jsFQtEpCSc88lhd2Y6IjSx3zbumpB1stSI73w2Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koXkNIsnQ7LNgQmg0K2p0OWzWbKo3wV9b+ieue/AOYY=;
 b=FJNLAl88ktCPhNaJv/WJ6e8+mWaozIV5Nvx3hYvgXGuT6n+Ie63kIvrzqr+vjZtwazzDAkg5TZiaOtKW6F6suJoy1CiZb56wW6PY23pdxlcZSzUt9ggvT0SWgVk6V0aX6UMef4/vIFdJ7L1Uf4cq4vKU59+whjCrHa9uGWybqxjX2T0unj9sEbtlDO42oe3viWbkqCGfjWodIVLOEIauODcpWD1VfUxxfbZ+/xg//z3aebQMGncDWaIPabwyYk4s2rDciKTnvexY8ja3UUgJMRcpVAUntPQ+JVf/fkX6I6wAwGkYgGFCurV1z2p2Yq5yNkKAC3u2bYr+3Wx2Mbr7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koXkNIsnQ7LNgQmg0K2p0OWzWbKo3wV9b+ieue/AOYY=;
 b=s8Tz81evtS1SNyvn435UKI2RxeQZhab4YeT7cWSgvFdlLICkXbHwFTCOoTCIv1VvlBD6ZcxUSSDk0DFIQHooauIbGB0oo+nrhIdw8bgAEkEuS3fGl87ejhXbEt5Lh/A0cisUe4XR0QSmLRI1aCIWWxIO0wY3BWhIe9QGs/ttwKU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2463.namprd10.prod.outlook.com (2603:10b6:805:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 16:48:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 16:48:37 +0000
Message-ID: <a0c54e91-dcb2-debd-a1ef-b4906fed8ab1@oracle.com>
Date:   Thu, 5 May 2022 09:48:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
 <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
 <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
 <YnOEl6Qwp5jp7RHp@FVFYT0MHHV2J>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YnOEl6Qwp5jp7RHp@FVFYT0MHHV2J>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0368.namprd04.prod.outlook.com
 (2603:10b6:303:81::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e19501-9f7b-4793-68b5-08da2eb71968
X-MS-TrafficTypeDiagnostic: SN6PR10MB2463:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2463E617A2FE5531883BF1E0E2C29@SN6PR10MB2463.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4qZEfgRjuCYN3ypvYi0SjeJtXqCx+t90vl3qmqi3dy1uzy54jVo5KVxEAq/eJNlR4bqaL8v9OouMpgqtFubrS2rcCC2+JUiQ8MlFbG+yky1AL/4f5YvoqVPm66Je830dPO3bP/74X8Tkfr4R8OsV9T/sMrVs96TdXkjYCgpA+a7AQtwE/dmZveb8b3OjCTGw8jsE1IIkKw06DPVE8SQLuNB934PS5nl57V8LFNi0j46D2uxVP/PJtVexmO/qsvI3SxoEriE/zKnMY7vlyeC+y4wAPQZ9rt1U5ysUEwAtozTTLw6FsfAGTZViGk6QW2tSgXSvqjCawA8kmK4SDlQyTliPt8pelKdqTrWV0X9h7tC6fpZBbc1C6MUbBXvgPBp28qjNfftpuViRZL1g5APsrAdIKHL/5E3Cp0z+fg8y1vy+RBDuieF26Y2HsOB6kev3dSdf9UArud59llxhiRXIpbgsYZ8NRIX/ymbRrcWL/kQGmIMPxqDqfFMOVA7BYRJs4cSFZQB4/o8Dg+waoWpUGz1odab7N/dYdApReyDZLNdmof1eoGIlarrT4OJYypym0xdme4nYsSLQfJkBHZIOCZhYbHQzJUAbV6P+F632uAmIbD54E3I1s09KHKgQp2A542yZOiuHz72tZwhtdySIM2wHSjvRyY/wpyFiPEtTpSdk/9nEFYAx2F+PeW1LiTwCzloNGyZ9s+BRrLFFF/l2XapsWPrP+tQvfDowPTZZV2T3Rl5vZKC6KCbu9kO4yUN2TME1/0JpwjaUwLuOHaqdzyBRcpXHerUAKRGv199LxuWoGrdpobB2impbZj6GMoNeMNlxBA7Qk4cwCpt4DW4+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(36756003)(508600001)(83380400001)(26005)(6506007)(53546011)(66476007)(44832011)(86362001)(6512007)(5660300002)(6916009)(31686004)(31696002)(8936002)(186003)(2906002)(316002)(7416002)(6666004)(52116002)(966005)(6486002)(2616005)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdwZnZLeFZhTURvYUlsOXNIdExIVStiU3JTaFhtZFhYSWcxcllRRHZxOTVs?=
 =?utf-8?B?M2txajZjTldnUk9BeU1LaU9ZRGdWWHpvaHlUMFNJR2RhRjV2NFdwS0t2ZDZ6?=
 =?utf-8?B?bTBpcDZWM2JUZVltTnNucE9xWGZLcm1laThCcGF6Sk5EN0ozUTN3RmZGSUZw?=
 =?utf-8?B?SGwvOUlhRlBhOFRXdlVlb1pHSVBxNHhoeXN0TnZyejdxQ2JwS1dYMWtUbFk5?=
 =?utf-8?B?QlcrVnJmWVJKRXg5bEFUSGJyUUJQdEhMbjU5M1l6SHBsVDh6Yll3YWhUUXVN?=
 =?utf-8?B?cUwwRmJSbTVSdDgvT1pLYzNPWTE3NUpNcitxbm9PTHVJUWQyRzExcWpwU0dP?=
 =?utf-8?B?MXhWcGUzOHlTWFBNVHRRZGpCd0VLWXZRMWVpK2NpV0x1b0hzUisrT3JkajBt?=
 =?utf-8?B?bzRRSUZwY3ZkSlB1ZFJRbHcvaW03Y3ZFRzZwY0xhZk9xSWpubDNHUlRWL2lh?=
 =?utf-8?B?VWl0NGo4Sk5MclI1bE1EY004SHFnSnkrcUhwMytjQnJNY0U2a3Z1VUdrK2ps?=
 =?utf-8?B?cW11bWdNYzRveXZiVi81SHF2anhrdFpkZGFDdU9zT1RxRzJlN1BQcG95Tng0?=
 =?utf-8?B?WVNPTGs1eWJSTUdVNnJNTy9hQmQwSUVHNVNnb0wrc043NFhuYk1Uak1DTEt4?=
 =?utf-8?B?VUNrTFFXRThCNU9XYUMrUFVqRExlUEdlWWZjUW0yTGdxN0Y2QjlHQ0x5RHA1?=
 =?utf-8?B?TU9DbHdheE1BNFdlYmxlVjdNWUxiS3BDNVpqbEtXZ09OM25HckxqUExlWlJM?=
 =?utf-8?B?ZU5xeHEvY3FMRTZOS3JSTlg0eDlmNGExemtyNG9kc3ZESmVTVkZ0Z2VxQWR0?=
 =?utf-8?B?TzVmRERLZzJaZTNrMmovaGJObFhsRVgyV1RnTm1DYVVQUmt0cS9nTlA1QTZs?=
 =?utf-8?B?Nm8zQ2xvQXhMcHJuRjNIa2Jrb2djTWxBTEErNUlDMEs3eEdkcWptTWRRVTBB?=
 =?utf-8?B?dzVpSjMveWpPR0pJNjdYakNod0wyU2Zhc2gyeGdYS0c1ZjBsVnFDbzM2SXA5?=
 =?utf-8?B?cWVQL2lBTnB0UUQ2QlFxNDJIWEdxVWlqdkVjakgzaGtsQkhoK25EWjZUeitv?=
 =?utf-8?B?eGozTnkvVDh4L3NPU1BJOHZ2bW45NzRmV3hhSGlOc1UzZWJ1ZXlkSlBUYnpr?=
 =?utf-8?B?bFQwTjJFZzVITmVnc0EyZFBxM2dRL2pIcVZyYmpibDBNenA5cmNUK2NZUnJa?=
 =?utf-8?B?em5sUzM1NitnUEMvSS93VDk3S0JBWUYyc0dDT1R6UmJ6QktXaTIxaUtER1M0?=
 =?utf-8?B?K3NzdFlFdFpZWDMvNWR5VURZbW1qWGNTaCt0VGdlZklMNDNVaHpJbjZYRktG?=
 =?utf-8?B?dEZUZUFtTyt6SkswN29BbXdGTmVlNXZQRS9GWWhwRDZGUncwV0xKRkJhalAr?=
 =?utf-8?B?Y3JHUGV4NnltSmJQMkVxTG9iZkFPU0VWdWE5cWZFRityaFJDbXJFNkNPNzI0?=
 =?utf-8?B?QVMzWTh6K1phUmtBUEFlNyt3akQwYWNzbG5FOXRPTTdVdWtjWTY2MHNkaE5X?=
 =?utf-8?B?Q0dIaEc3Z2hxWkZEZ2hmQWI4ZDIvYjJCZm53NmxXRTdUR0w2SnJZbFFkbG96?=
 =?utf-8?B?SG4yYzJtNU12Ukc5cmhKcTNoSzQ1SnZmZlliVjExZGJ6eVc0dW5Qc2ZROUVY?=
 =?utf-8?B?K1VRRndNcERoczgvdUM2SUFQaUYraFN6c2hYZUNHSUl3d1p0dnBvMHQrOGFO?=
 =?utf-8?B?VWkzL2xjeGlXU09UNy9UUDFSZU42NFBYYlM5SDNlL3dFYUR0MXovQTFlN2ZQ?=
 =?utf-8?B?VnRkOUR3WCtCQXYxNnVNUGREVm9wb0dyQU9nUVBoQmZ4T0tXNUdZMUplbTA5?=
 =?utf-8?B?T2w4c2dzU3FwOXMxTGsxQTlvQ2Foc1JMVzRyeVk1bENOUXdjaHZ6ZjNmWXlv?=
 =?utf-8?B?MmpIWi9VWHZ5bkRRUFc1K2EvL3c2c3VHbUNzeHpsM1NQTGRucFY1dlNSRG1V?=
 =?utf-8?B?aEhnU1BwWXBrelhJSVRkY0tsbm9kUlhjeC9CTDlEeVFET284MDg5V3M5Rml2?=
 =?utf-8?B?M0VUZXJ2K0FQMjIvVTNja3BkNm9mMS9pSEtleTVnd1V6eU56R1V3NUR0ajZD?=
 =?utf-8?B?TDhxazJmNjNkeWkyKzhxY1luR3o0UDUxK1Juakx3aEZsZHFFZS9KeXNFVjRy?=
 =?utf-8?B?VElQd21EME9MNkJlOWRGK3l4dEUxWVRRN2NYUjN6ZEJ1WTFUZTZlK0tRQU5m?=
 =?utf-8?B?NG5Uamc0amcwR1owQ0VEZGZQS0Z1SGhJejYrbEFXbVhHZGoraVBXeHJTbC9L?=
 =?utf-8?B?SnhzU2owTlJRNlMrRlY0OUY2dDQzMzZUNlJGOWZSOHJBL2tQQkgzbjl2bXlp?=
 =?utf-8?B?ZzFnek9senFJUkNESEE5ZmgyQ0lVWEJPblk0OVdrYUhVUklKZ1QzN3drK3N0?=
 =?utf-8?Q?Jf8ClNg1rtXNsYOY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e19501-9f7b-4793-68b5-08da2eb71968
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 16:48:37.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLI3w1AoGOQD2FEq6NrN1NOOGmd1bJv0I3G1l/JM0biD0q8FEL5EFPgl9LlGCTBSspSUKQ98Rm8mqehZmV3nQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2463
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_06:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050116
X-Proofpoint-ORIG-GUID: 1QdUW0Nn-8t0D0Z2JV349APYSzm8X1xv
X-Proofpoint-GUID: 1QdUW0Nn-8t0D0Z2JV349APYSzm8X1xv
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 01:02, Muchun Song wrote:
> On Wed, May 04, 2022 at 08:36:00PM -0700, Mike Kravetz wrote:
>> On 5/4/22 19:35, Muchun Song wrote:
>>> On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
>>>> On 4/29/22 05:18, Muchun Song wrote:
>>>>> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
>>>>> +{
>>>>> +	if (vmemmap_optimize_mode == to)
>>>>> +		return;
>>>>> +
>>>>> +	if (to == VMEMMAP_OPTIMIZE_OFF)
>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>>>> +	else
>>>>> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>>>> +	vmemmap_optimize_mode = to;
>>>>> +}
>>>>> +
>>>>>  static int __init hugetlb_vmemmap_early_param(char *buf)
>>>>>  {
>>>>>  	bool enable;
>>>>> +	enum vmemmap_optimize_mode mode;
>>>>>  
>>>>>  	if (kstrtobool(buf, &enable))
>>>>>  		return -EINVAL;
>>>>>  
>>>>> -	if (enable)
>>>>> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
>>>>> -	else
>>>>> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>>>>> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
>>>>> +	vmemmap_optimize_mode_switch(mode);
>>>>>  
>>>>>  	return 0;
>>>>>  }
>>>>> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>>>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>>>>>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
>>>>>  
>>>>> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
>>>>> +
>>>>>  	/*
>>>>>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
>>>>>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
>>>>> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>>>  	 */
>>>>>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
>>>>>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
>>>>> -	if (!ret)
>>>>> +	if (!ret) {
>>>>>  		ClearHPageVmemmapOptimized(head);
>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>>>> +	}
>>>>>  
>>>>>  	return ret;
>>>>>  }
>>>>> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>>>>>  	if (!vmemmap_pages)
>>>>>  		return;
>>>>>  
>>>>> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>>>
>>>> Can you explain the reasoning behind doing the static_branch_inc here in free,
>>>> and static_branch_dec in alloc?
>>>> IIUC, they may not be absolutely necessary but you could use the count to
>>>> know how many optimized pages are in use?  Or, I may just be missing
>>>> something.
>>>>
>>>
>>> Partly right. One 'count' is not enough. I have implemented this with similar
>>> approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
>>> However, both count and synchronization are included in static_key_inc/dec
>>> infrastructure. It is simpler to use static_key_inc/dec directly, right? 
>>>
>>> [1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/
>>>
>>
>> Sorry, but I am a little confused.
>>
>> vmemmap_optimize_mode_switch will static_key_inc to enable and static_key_dec
>> to disable.  In addition each time we optimize (allocate) a hugetlb page after
>> enabling we will static_key_inc.
>>
>> Suppose we have 1 hugetlb page optimized.  So static count == 2 IIUC.
>> The someone turns off optimization via sysctl.  static count == 1 ???
> 
> Definitely right.
> 
>> If we then add another hugetlb page via nr_hugepages it seems that it
>> would be optimized as static count == 1.  Is that correct?  Do we need
> 
> I'm wrong.
> 
>> to free all hugetlb pages with optimization before we can add new pages
>> without optimization?
>>
> 
> My bad. I think the following code would fix this.
> 
> Thanks for your review carefully.
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 5820a681a724..997e192aeed7 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -105,7 +105,7 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>         unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> 
>         vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
> -       if (!vmemmap_pages)
> +       if (!vmemmap_pages || READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
>                 return;
> 
>         static_branch_inc(&hugetlb_optimize_vmemmap_key);
>  

If vmemmap_optimize_mode == VMEMMAP_OPTIMIZE_OFF is sufficient for turning
off optimizations, do we really need to static_branch_inc/dev for each
hugetlb page?

-- 
Mike Kravetz
