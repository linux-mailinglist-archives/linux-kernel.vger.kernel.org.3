Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF50525946
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376333AbiEMBLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376299AbiEMBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:11:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FA606D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:11:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKVRG7010450;
        Fri, 13 May 2022 01:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3yiYSqVqaRQSxC2B8nkCui4DUv1jwd9Mpbjf/Bgy4nQ=;
 b=C8VMBIeknmI/wqAG8fpZJJQBLyHaGpfrw3Go5l0An1+4McWKyzKAOy1JjAkEW2rvKY7K
 Vkm8YCmyE+EgEy071R1DaZCJO37YxveAd9zZo0GL6afM7zfEszebHP3lco1rzvHQl6RD
 eh4tsIq4A+GyjnpSxw417ZeCYaWy3zZvj2+OeLV3yDT0JwKqIRjyQYFMfeX2XifmMxHg
 3V4nFKkyZPH9pLZVT8U2hGxiNMUaeUF9OQhiPLwShmf4Aj/xeQAMkQtsJHgUEdsw8wQE
 mF6B4qyiDrTbH58r2ll64H1O+uRzhE9hp8L9HTmKMn9PGUkB8KcF16EzPAByniJDmtYN Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cdvgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 01:10:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24D15iuA003806;
        Fri, 13 May 2022 01:10:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7ce63b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 01:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX1E6+srseRXeV1TNoT5S7BIH/dep8SUjEI8/l5ZQsyLmnhuzap5Ch5S5YptiUrw9ES8pOkJKtTNKwGMx7FhXXt9vZEyfgBC5O81lxWDYvzI+LTZE/zKpaevyPyMw0WRDBzEDeQM75CAlKbenWhM12xzSJKViuBQ0Uv9/yif2miLsHhYuHxIMh4cDGWHVxpK7lypmow/Veeqx5kk36oI1YmOwgI/uMa9Dk+0ksuvv4V8XdTo9dbbQKoBfzuosXQ26KMkCQChNA149e99i47TUWUmKso2MkVQmtl1Z5a1GFbqNz0J1Q90duZG4CMu+g/CtXNc++RiFUz5weSmzsceAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yiYSqVqaRQSxC2B8nkCui4DUv1jwd9Mpbjf/Bgy4nQ=;
 b=d7TO2sb5nEcEeCDaF4M8b5KbeFXfG1qsBeFZVsRIJ7Q9ij0+gYFGle/1so7gfODaywnRG0LfuKvh6RE5VrkJNNGz27TlxzlenVj48mEK5YhFBcSB5D9R9kyrheFmGpMt/1YDxlUZizKAg2znsWrit8lEVtqeQvA31l2unSoWTR95g+dtBssZ6uy6Ba5hoxXswDjXvenwJRWi2IFJmVdmyFipMhckDtHHRuAPRJizpTN8g8uajSWcqRu2LAL0pxG3Khcm1vQWHFYs0HIrntaL5RdonQmVcCnVCEhMTd+eDKO3suTvhphTM+gMcw/YJx+V8qr9bDLUyNR8Zlny3EEkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yiYSqVqaRQSxC2B8nkCui4DUv1jwd9Mpbjf/Bgy4nQ=;
 b=JrV8wntEYZigjuWvptG8dOMikhyFXkIQXQ78w25Tk1LZmHelPdmslju3OxKsNlrb+lA8n8dOEZNsWtjOf+PsqiykSEjRImxigNHNkFVK6TP4G2BAWjZ5WNsEwNSykcipUpnHfNemxHSwtJfuXW0Qv6Qkk8xbg9sWSuas0m9dtJs=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM6PR10MB3003.namprd10.prod.outlook.com (2603:10b6:5:6c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 01:10:54 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 01:10:54 +0000
Message-ID: <bcaa20e6-7861-1a3c-e103-8db8870bb0c1@oracle.com>
Date:   Thu, 12 May 2022 18:10:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-4-elic@nvidia.com>
 <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
 <CACGkMEuvN2SSdcn5fY7TZr_-Aj8UFMshrrmFn4dcJPTH94cLSw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuvN2SSdcn5fY7TZr_-Aj8UFMshrrmFn4dcJPTH94cLSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc32994f-a127-416f-4174-08da347d6da7
X-MS-TrafficTypeDiagnostic: DM6PR10MB3003:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30033FB3C414B25FD252DA6BB1CA9@DM6PR10MB3003.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbwrG4ryus4aFglBDHISoD3JvEZ46PgjfpIf9aGv9nKnRpR6HnEdA8YLxXRoLVbrHGMvnXwN25IASyyyn3mWuxwygPM6410aOunf0ETpvBg5aDeixruUMN830ILafFhUr9ApYOPXt3ObmsgmWcVdwaL1XebghoWP3V0ACf6tU9o7Z2l3FbvNBtyrJaXoqP/15swsIZ57LU7G9mtAZMaxS7etA5kWhP3ylZz1N1cPSczgIGB4fOMWZd8j1dMUsKFGS9lzdP6lYzIaJLxWE5U27gksCDVjCDDdQINeX+ZYPXrbMbOIrihA2tXj8hDqZ5LW+kmN704ksUsOzqltPqJ0NRZdJ9HxoqcRXuoTXDOJ474H8RMhHpgt1hg0pmlY8I/QrtZZZK92WEqYPONBBUFNI64w8lOc4u5FBkDzBPcdKI1tH7TjAotmpzKhvrXevjXAQQONx/EKtRvDBpggwWX9jhL5jUCR3Jc/Y0dNFSVgCWEOjnAKhgVOMiSnIv8keurcc7B/t0aJa4yKaYhOQLcGHp+ag1WrcdRWbQ+k2g1C1cD1V5f0d6mRo4X6YgPjGfdJrxrY/vg4UvHLf0T8sY59fA3sA+4FOWywsN7n3+BXRdO/WNM2ug7ADvgvmVyUBIH1/WdDPMQiTmH4wxYNLktYaH5wkmsqMDH20j4pT2lTYgcmle/lBnkFygy18fOrrtEfBakVjHu7QuSUGLAj/CAMaWaAdt4V7tDzCuvE8wNoJbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8936002)(2906002)(6506007)(36756003)(86362001)(6666004)(31686004)(31696002)(26005)(54906003)(6486002)(83380400001)(53546011)(6512007)(5660300002)(66476007)(4326008)(66946007)(66556008)(8676002)(316002)(2616005)(6916009)(36916002)(30864003)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhWS0c2ak9FaG1RRHJpK3lwaTRFMGpCNm94L0JuQ1FNelNUTTdUUVZJQ1VQ?=
 =?utf-8?B?azF0a0lNcy9qRmdxaVdtcnpnZ1pod0tldUYrWE5VdzBkOFFrMTd3dm5YaldB?=
 =?utf-8?B?V3VlWUZBdmp1cisxVmNuMjNxKzZldjRBTEJ0czhrbmpsSTg0RVFPaitHVloz?=
 =?utf-8?B?eWo5MVQvdWpJZlpsR2lBcXA4VVVVWk5DWndGZHYvUW5NNGNBbXhsSjNXWEIx?=
 =?utf-8?B?dHRwMzNINGhKbWJSVHk3UmN1U2tVL0JDcjNvWFJNRnE4c0xKRDA4Ync2aGVB?=
 =?utf-8?B?cjgxL09iYWtxQU5yN0lTVFRrQWtZNHN2YmZ4eEMwR2Y0S3dIM2hGQi9PZzk4?=
 =?utf-8?B?TDcydDdDTENSLzdaVFpIZDk5QngvOVRZYmt3R1h3QWxhWlFaVERnc2xiWnBC?=
 =?utf-8?B?OElPVFJyRmlHVVNxWm1aWUtOMnUzdXFnNnpuMmJIdWw4L3c1VCtDV2pua1Bt?=
 =?utf-8?B?bjduN2RQRkE2TnpYNDBLTnhNMTBMMG41dFoya1ZvcEZmVmYyRXlGb2UzR1I4?=
 =?utf-8?B?bXBDN2lrbGpVck5FTHZBTWVHdERTaWJnQnI2ank2TFVYYUNsZWd1ZkJnU0Zt?=
 =?utf-8?B?YisrUVhoeTRHK3BKMzAySWdZOGlVTCtDcTJDanRRNzJMSGtvT1ZZV3lHNHRL?=
 =?utf-8?B?aGc4Q1VJQ2w4MXp3Q0Rtd2JVMklWakpIL3lEOFdHd0UyemZmYlpFS3BxcFd2?=
 =?utf-8?B?V1ZWaURINEVINGtGZDNzNlJ4RllKQm9SeVRmd1hpLzROa0VIcmNkK1A2eGo4?=
 =?utf-8?B?U0N2SWhqRW9mS1ZqNG11cnlPYTFkL1o3U2ppbFFzaEpHNDcwbXlNVmYrREpo?=
 =?utf-8?B?Q254WVE5WUl6V09vaC83a2d2OXQ3ZlhISkdLN0VPZ1ZaYVFrQllIY29xK1V1?=
 =?utf-8?B?MzRvWWUzNkt2S1FmNk90RWJGeDVEckpEdGNiV2tEU0NyaWFyMGJEdGVFOVdM?=
 =?utf-8?B?dVQ2ZGJYNDJSbzNkZUdyU2p3U0dVNitSbW9oMEd3dExKU2kybWVjWGNqVWVY?=
 =?utf-8?B?L3pjRUR3R2o5Ui9VWlFreDhrV21IQmtjRktrbHlBVHFlRlhsL0YrbjY0K2hZ?=
 =?utf-8?B?R1FIajVqN0NPRk4zdlBsYldkbHF5L2t5ZlhEOGFTUy9vanF4TWw5NUxDWUxH?=
 =?utf-8?B?Y1RkYTJKSUthUlNLWVorakU4Zk5NMmdyNld6byszTlFWSUZHc0w5K3Q3WXJB?=
 =?utf-8?B?elZhQndERmxiOEpUMCsyZ09NQnd0VTc4eVNKMUhhSGxIQXFwczNGRDlmeGw3?=
 =?utf-8?B?YkM2NGxVb2xIdXR5OXpqbmFXV2FlYThHZThQNFJxTTkwV2d0bmZqRGc1c1VY?=
 =?utf-8?B?YTJ3N0hjdUVMUTZ2aGt2aXF6eFl3TWZGRk91Y0NlUm01VmdKSkVicnNMcWtr?=
 =?utf-8?B?Y0w5TmFuT2w0eUNPUTZDTUFmZkc4OVE0eGpkaS9vVmx1WjltQkdNNVJ3RDFk?=
 =?utf-8?B?YU0wekJJVFF0Nkh4NS9KN3hsSkpTdEFMb29hMnRSblh0M1ZXUkoxZ0lMc1Qv?=
 =?utf-8?B?Q1RtK0l4d2pFUGs3cmlTVmhTa2g0R2tnUFBrRjZEZXh0cGM2SjJDQzVLTG40?=
 =?utf-8?B?K2FHeVBNckZHWEhXYVNLV0hCQ2R1ZUFqVFBpN0QvM3JnSUxweWhFMWJPbjdH?=
 =?utf-8?B?YkltUWRNL0plYW04a3J0cjEweGRFMUZnK3FZMXhWZWpsU2pNaENlTHlkSnNo?=
 =?utf-8?B?NDgxcXlnSXdONnFBTTNFN0NKTGN6Zno3VmxZWGFZNDJYbE1xT3R0SXQzSGtz?=
 =?utf-8?B?U25BZmR3VTdmQjFMRlZkM3I1Q1R4ZVRzdWVad0F1aFlTbXpGTTJpSTE2T0I1?=
 =?utf-8?B?MDdWeEd6WXpaSmRXcEVvL0F0bno5Qmt6TUhsNzU5QUVHUmkrN0J0THRKWVlH?=
 =?utf-8?B?N2prZXA5S1gzZE04ZGZZMnR3bGpvbVFnaDBlcFZRMC8zZzJpQ1ZCcFJSUGEr?=
 =?utf-8?B?cE5CV1F5TkhlTyt3YmIrdFJzdEg2MzRzaTdpWDFsdDNGejRwdmhnZ2VvK2J3?=
 =?utf-8?B?VHE0eDYxb2pKL01iLzZ1MmEzYTlsZlZjRWJEWmdRZGVndkRYamIvY0JHUlBp?=
 =?utf-8?B?blVhYnVOZzkyMnpVbmFCQVdZcU5rVmJpU1lFeUJUU3Z1VXh5YjBmS25rckpR?=
 =?utf-8?B?TUlNNFdvbkptWWovTnMzdFJVNHlmTnVRdlh6d0dvanpBZmZHa1JlR21qQkVI?=
 =?utf-8?B?RjNCZENxN1ZtY2RsT3RRdCttUTJVbXVNOFpGZlpYeWpxZlVPN2dPUmFmMFdU?=
 =?utf-8?B?dGdNQVU5a1ZoZnBYWWxycXdnT2hOVjNtd3QyZlNjakd2T0lSM3ZLcCt0dWNx?=
 =?utf-8?B?b0Qxb3ljdjBmV2cvUG9WUXZJNkFLVzFZTk0rY2Ywd2g2ZTIza0Iwdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc32994f-a127-416f-4174-08da347d6da7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 01:10:54.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wwI4Xsk7AnlTwe5vUZ8sweADUx4pX/+so2SYrrKF6XoLQDFQ44NJfgK6bc0A6HcTpplVvJaClBJWywEK33MBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3003
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_15:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130005
X-Proofpoint-ORIG-GUID: T-kZkSLyHtsY4kFGW_NSqZfeNve9KYYz
X-Proofpoint-GUID: T-kZkSLyHtsY4kFGW_NSqZfeNve9KYYz
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 7:27 PM, Jason Wang wrote:
> On Thu, May 12, 2022 at 1:26 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 5/10/2022 4:27 AM, Eli Cohen wrote:
>>> Implement the get_vq_stats calback of vdpa_config_ops to return the
>>> statistics for a virtqueue.
>>>
>>> The statistics are provided as vendor specific statistics where the
>>> driver provides a pair of attribute name and attribute value.
>>>
>>> In addition to the attribute name/attribute value pair, the driver
>>> returns the negotiated features and max virtqueue pairs for userspace
>>> can decide for a given queue index whether it is a data or control
>>> virtqueue.
>>>
>>> Currently supported are received descriptors and completed descriptors.
>>>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>> v4 -> v5:
>>>    Remove numq_lock mutex. Use reslock instread.
>>>
>>>
>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
>>>    include/linux/mlx5/mlx5_ifc.h      |   1 +
>>>    include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
>>>    4 files changed, 207 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> index daaf7b503677..44104093163b 100644
>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> @@ -61,6 +61,8 @@ struct mlx5_control_vq {
>>>        struct vringh_kiov riov;
>>>        struct vringh_kiov wiov;
>>>        unsigned short head;
>>> +     unsigned int received_desc;
>>> +     unsigned int completed_desc;
>>>    };
>>>
>>>    struct mlx5_vdpa_wq_ent {
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 79001301b383..99b0621e7a87 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>>>        struct mlx5_vdpa_umem umem2;
>>>        struct mlx5_vdpa_umem umem3;
>>>
>>> +     u32 counter_set_id;
>>>        bool initialized;
>>>        int index;
>>>        u32 virtq_id;
>>> @@ -164,6 +165,7 @@ struct mlx5_vdpa_net {
>>>        struct notifier_block nb;
>>>        struct vdpa_callback config_cb;
>>>        struct mlx5_vdpa_wq_ent cvq_ent;
>>> +     /* sync access to virtqueues statistics */
>> Dangling code change?
>>
>>>    };
>>>
>>>    static void free_resources(struct mlx5_vdpa_net *ndev);
>>> @@ -822,6 +824,12 @@ static u16 get_features_12_3(u64 features)
>>>               (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
>>>    }
>>>
>>> +static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
>>> +{
>>> +     return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
>>> +            BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>>> +}
>>> +
>>>    static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>>    {
>>>        int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
>>> @@ -876,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>>>        MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>>>        MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>>>        MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
>>> +     if (counters_supported(&ndev->mvdev))
>>> +             MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
>>>
>>>        err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>>>        if (err)
>>> @@ -1139,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>>>        return err;
>>>    }
>>>
>>> +static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>> +{
>>> +     u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
>>> +     u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
>>> +     void *cmd_hdr;
>>> +     int err;
>>> +
>>> +     if (!counters_supported(&ndev->mvdev))
>>> +             return 0;
>>> +
>>> +     cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
>>> +
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
>>> +
>>> +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>> +{
>>> +     u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
>>> +     u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
>>> +
>>> +     if (!counters_supported(&ndev->mvdev))
>>> +             return;
>>> +
>>> +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
>>> +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
>>> +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
>>> +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>>> +     if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
>>> +             mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
>>> +}
>>> +
>>>    static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>>    {
>>>        u16 idx = mvq->index;
>>> @@ -1166,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>>        if (err)
>>>                goto err_connect;
>>>
>>> +     err = counter_set_alloc(ndev, mvq);
>>> +     if (err)
>>> +             goto err_counter;
>>> +
>>>        err = create_virtqueue(ndev, mvq);
>>>        if (err)
>>>                goto err_connect;
>>> @@ -1183,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>>>        return 0;
>>>
>>>    err_connect:
>>> +     counter_set_dealloc(ndev, mvq);
>>> +err_counter:
>>>        qp_destroy(ndev, &mvq->vqqp);
>>>    err_vqqp:
>>>        qp_destroy(ndev, &mvq->fwqp);
>>> @@ -1227,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>>>
>>>        suspend_vq(ndev, mvq);
>>>        destroy_virtqueue(ndev, mvq);
>>> +     counter_set_dealloc(ndev, mvq);
>>>        qp_destroy(ndev, &mvq->vqqp);
>>>        qp_destroy(ndev, &mvq->fwqp);
>>>        cq_destroy(ndev, mvq->index);
>>> @@ -1681,6 +1739,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>>>                if (read != sizeof(ctrl))
>>>                        break;
>>>
>>> +             cvq->received_desc++;
>>>                switch (ctrl.class) {
>>>                case VIRTIO_NET_CTRL_MAC:
>>>                        status = handle_ctrl_mac(mvdev, ctrl.cmd);
>>> @@ -1704,6 +1763,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>>>                if (vringh_need_notify_iotlb(&cvq->vring))
>>>                        vringh_notify(&cvq->vring);
>>>
>>> +             cvq->completed_desc++;
>>>                queue_work(mvdev->wq, &wqent->work);
>>>                break;
>>>        }
>>> @@ -2323,6 +2383,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>>        mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>>        ndev->mvdev.status = 0;
>>>        ndev->cur_num_vqs = 0;
>>> +     ndev->mvdev.cvq.received_desc = 0;
>>> +     ndev->mvdev.cvq.completed_desc = 0;
>>>        memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>>>        ndev->mvdev.actual_features = 0;
>>>        ++mvdev->generation;
>>> @@ -2442,6 +2504,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
>>>        return mvdev->actual_features;
>>>    }
>>>
>>> +static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
>>> +                          u64 *received_desc, u64 *completed_desc)
>>> +{
>>> +     u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
>>> +     u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
>>> +     void *cmd_hdr;
>>> +     void *ctx;
>>> +     int err;
>>> +
>>> +     if (!counters_supported(&ndev->mvdev))
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
>>> +             return -EAGAIN;
>>> +
>>> +     cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
>>> +
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
>>> +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
>>> +
>>> +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
>>> +     *received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
>>> +     *completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
>>> +     return 0;
>>> +}
>>> +
>>> +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
>>> +                                      struct sk_buff *msg,
>>> +                                      struct netlink_ext_ack *extack)
>>> +{
>>> +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +     struct mlx5_vdpa_virtqueue *mvq;
>>> +     struct mlx5_control_vq *cvq;
>>> +     u64 received_desc;
>>> +     u64 completed_desc;
>>> +     int err = 0;
>>> +     u16 max_vqp;
>>> +
>>> +     mutex_lock(&ndev->reslock);
>> I wonder if we can change this lock to r/w semaphore too, otherwise it
>> almost defeats the merit of converting vdpa_dev_mutex to the same. This
>> change would benefit multiple parallel readers.
>>> +     if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>> +             NL_SET_ERR_MSG_MOD(extack, "feature negotiation not complete");
>>> +             err = -EAGAIN;
>>> +             goto out_err;
>>> +     }
>>> +
>>> +     if (!is_index_valid(mvdev, idx)) {
>>> +             NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
>>> +             err = -EINVAL;
>>> +             goto out_err;
>>> +     }
>>> +
>>> +     if (idx == ctrl_vq_idx(mvdev)) {
>>> +             cvq = &mvdev->cvq;
>>> +             received_desc = cvq->received_desc;
>>> +             completed_desc = cvq->completed_desc;
>>> +             goto out;
>>> +     }
>>> +
>>> +     mvq = &ndev->vqs[idx];
>>> +     err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
>>> +     if (err) {
>>> +             NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
>>> +             goto out_err;
>>> +     }
>>> +
>>> +out:
>>> +     err = -EMSGSIZE;
>>> +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
>>> +                           mvdev->actual_features, VDPA_ATTR_PAD))
>>> +             goto out_err;
>>> +
>>> +     max_vqp = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>>> +     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
>>> +             goto out_err;
>> Your userspace reference patch doesn't actually use this attribute, but
>> instead calls the VDPA_CMD_DEV_CONFIG_GET in prior to get this
>> information, which will break consistency. Is it your plan to change the
>> userspace code to accommodate what's already piggybacked here and
>> display stat query in just one atomic call? Hope all the available attrs
>> here would satisfy the userspace need.
> Right, I mentioned this in V4. If we depend on the vendor driver to
> report the negotiated features, we will end up driver specific code in
> the userspace which is sub-optimal.
>
> I think we need to do this in the vdpa core so userspace knows for
> sure it can get this.
Yes, that's what I thought and once suggested, too. This would make 
userspace simple and also ease driver implementation.

-Siwei

>
> THanks
>
>> Thanks,
>> -Siwei
>>
>>> +
>>> +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
>>> +             goto out_err;
>>> +
>>> +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
>>> +                           VDPA_ATTR_PAD))
>>> +             goto out_err;
>>> +
>>> +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
>>> +             goto out_err;
>>> +
>>> +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
>>> +                           VDPA_ATTR_PAD))
>>> +             goto out_err;
>>> +
>>> +     err = 0;
>>> +out_err:
>>> +     mutex_unlock(&ndev->reslock);
>>> +     return err;
>>> +}
>>> +
>>>    static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>        .set_vq_address = mlx5_vdpa_set_vq_address,
>>>        .set_vq_num = mlx5_vdpa_set_vq_num,
>>> @@ -2451,6 +2615,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>        .get_vq_ready = mlx5_vdpa_get_vq_ready,
>>>        .set_vq_state = mlx5_vdpa_set_vq_state,
>>>        .get_vq_state = mlx5_vdpa_get_vq_state,
>>> +     .get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
>>>        .get_vq_notification = mlx5_get_vq_notification,
>>>        .get_vq_irq = mlx5_get_vq_irq,
>>>        .get_vq_align = mlx5_vdpa_get_vq_align,
>>> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
>>> index 49a48d7709ac..1d193d9b6029 100644
>>> --- a/include/linux/mlx5/mlx5_ifc.h
>>> +++ b/include/linux/mlx5/mlx5_ifc.h
>>> @@ -94,6 +94,7 @@ enum {
>>>    enum {
>>>        MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
>>>        MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
>>> +     MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
>>>        MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
>>>        MLX5_OBJ_TYPE_MKEY = 0xff01,
>>>        MLX5_OBJ_TYPE_QP = 0xff02,
>>> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
>>> index 1a9c9d94cb59..4414ed5b6ed2 100644
>>> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
>>> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
>>> @@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
>>>        struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
>>>    };
>>>
>>> +struct mlx5_ifc_virtio_q_counters_bits {
>>> +     u8    modify_field_select[0x40];
>>> +     u8    reserved_at_40[0x40];
>>> +     u8    received_desc[0x40];
>>> +     u8    completed_desc[0x40];
>>> +     u8    error_cqes[0x20];
>>> +     u8    bad_desc_errors[0x20];
>>> +     u8    exceed_max_chain[0x20];
>>> +     u8    invalid_buffer[0x20];
>>> +     u8    reserved_at_180[0x280];
>>> +};
>>> +
>>> +struct mlx5_ifc_create_virtio_q_counters_in_bits {
>>> +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
>>> +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
>>> +};
>>> +
>>> +struct mlx5_ifc_create_virtio_q_counters_out_bits {
>>> +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
>>> +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
>>> +};
>>> +
>>> +struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
>>> +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
>>> +};
>>> +
>>> +struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
>>> +     struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
>>> +};
>>> +
>>> +struct mlx5_ifc_query_virtio_q_counters_in_bits {
>>> +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
>>> +};
>>> +
>>> +struct mlx5_ifc_query_virtio_q_counters_out_bits {
>>> +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
>>> +     struct mlx5_ifc_virtio_q_counters_bits counters;
>>> +};
>>> +
>>>    #endif /* __MLX5_IFC_VDPA_H_ */

