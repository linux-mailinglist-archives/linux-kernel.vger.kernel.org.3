Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182850AA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441836AbiDUVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441829AbiDUVSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:18:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6944C435
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:15:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LJEAHB012431;
        Thu, 21 Apr 2022 21:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EAOpr8ZdY081Ha81IqAq9/zTKyOSUanKdgBrWUCBYD8=;
 b=MRsrhd/ac7rVJP0OJoPwPBthbmUbqoR6PFI8F7tCFhgqfGE5TT5Hk0t2aCV3Gf8mys2v
 ufVbr2IMEfeaJcwqIf/h9HHzbejpsxjZeW3wocfXE7QWhmzAzX89wFjCQK8PNWILbt9k
 lbB2mayLyjMyNHns9ZmHX8nNLjnhk2DjUqyMcyL10JmY7GqDH6VgjHu73yJcknTdamed
 rwQN5sp2QLUnLnjCABbOxuWflDS16eJRpBbjRxAHd+rlk8z4LmpzxndRIbkPPVqDcgtw
 psN1R11zArnfI6gzyj/ultPQeDg5UBJ8ApDpeKS0ZxQVdNunMC0mDk4VSTVpJfKZ4CFm DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvdgqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 21:15:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LL0mCX027434;
        Thu, 21 Apr 2022 21:15:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm89ju68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 21:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDGatQ6w5WYA6Yvc73X841hl14wzihpgVU55fJaSkqRIPaB4Ue3CHf7kVCsJECRlqenkZOu63z377yVHHjlHhqrr8zIMlylkOGmk3m76g+7qSTni4og8M961V+RAlUypqXoCe0gV5llYZRYKNH81w5vW3O1c5Lv7g62YSjcSJkzgbCwC0dKUQ8HAIpXB65AXDp6SSOHRkyJE4FjkZ4TbQ5aN0Mjwabro20kJ7S/acd3J/9R9x9SlctQovJqL8ZZsa+H1NuVpHROuGvoxXs4FyoWCp43DS784PX/YoWsgi4fGirByqUd8WaZQ0WjmnncthAAqPvIw/26bnC3AMbzVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAOpr8ZdY081Ha81IqAq9/zTKyOSUanKdgBrWUCBYD8=;
 b=nki7khf+iA3/SVVQt2LRzscfROq9JrvOHiTrDz7q+UbGcfedZhppSK1S3xfyYaRzCVX5bIeCkloPg5Nnj//fRvANxzeQT4Zo3adYB/fxQkIu1weZ4DS2kw1ocPe7CFu1AJyvC3DviIgaQFnAhsJqpneil5DzHgYGjGJhop2S9V7+n+Hs2bXnT/Z+xpLQ70LzpZ94B1eD7OUq6ePmmHFl74So8CMYDm3N9MOdIeDw6HmDZV2AxwBPhd/VYDuBvuux+WDtwSas+2s8IrLRbVAowLHN1nWqGUb14ZOBh1A1bI331lpvEI71Plh7TkEBJ93D4NDHQsx9sdM9POJgwZK2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAOpr8ZdY081Ha81IqAq9/zTKyOSUanKdgBrWUCBYD8=;
 b=BIelbU3UgoWYx3NLhNoJBbrWV9yZGhH+eJN8rfdnEW1W6e8glxNxSm3hJLARNrGHt6l/OiBQcti59X+osyEroeoi+BjH26PmLEXUtpnGFasku622VQudScDhB7e1gU9Rgbj1GGT0dEMeqf2h5tMAIYankkAAw/HvRVhFCSKSkZg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM5PR10MB1898.namprd10.prod.outlook.com (2603:10b6:3:10e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 21:15:29 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 21:15:29 +0000
Message-ID: <7ff97157-4792-c48c-a06c-ad98884f9e9b@oracle.com>
Date:   Thu, 21 Apr 2022 17:15:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2] xen: Convert kmap() to kmap_local_page()
Content-Language: en-US
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be7f60b-7015-4cec-2ac8-08da23dc0f9a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1898:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB18989CC3EA7A1354363D14EC8AF49@DM5PR10MB1898.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sE5nRMwj2KxdLsvDsGifDlUVB7e/CsxW+232oK1RAagY+ApuFMyFYeyQ6h+Ehhn2Rma0sbpbQ8aHoqGIw5X4sBQ4mgXUd/DSsT3Nqv+Rxipjqbc6Rg67ozsEZwY4vHahQUDFT9+PgjbMd09CHxtj2eL++HJwXxBF5K6u/Bq2FsMgGjnCig+M7nd1CMqZOmm/KnnQmtnONuUA6/adUd0jKtaaqL0ZGz8qv3k4cskoPzkLiA8v0XEMfF1/N1zNkIr/V15zQG6Lu4mIgxcLL61fC32AnVQY0yVT4YAOWswnb0Io38vHieTcq175TfbBtuqx5xGoTVmCJRWEQ9tgUnSjwedsR9p65NV6fgtqe4K8Wxg6IhUXNYhYuVqiP3px0u5DAKQvJ/3iwduCGh1oUgFJZ5GjHc83Lpfves7+sp+BQmmcInyCBTgcqHf7nHphRsuBsLaRrXR4sPEAcUv1IzCxVu2EysjUku4DdiwyghvnAZV4juSSC6DkyAe+M+alQOECOIIaF/3a94JMX06Jx1WNGAbKneZOy4mAc8T12ICDrF5SBvboxY5xajT5Vw4HHrTK8Gu8vKyfw7724u+InRNLMrbHgBvjGkOWtL2gUa3U05X2tjNvP4dBu1qRHq88yVruYQnA6HLeoF2vFXUNfEsXHZwB1p0rn8HmxlY3iTEzmEZchOCO/WeoXbkd1Nvv3TrCyNlrOIh+xywO2SX7qqlwxRrJJ8F7EExw/cAfzBrjjMmWpsdrOYShoH0JYz7NYRs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66556008)(6512007)(36756003)(316002)(31686004)(2906002)(508600001)(6486002)(186003)(26005)(6666004)(5660300002)(6506007)(44832011)(66476007)(8676002)(53546011)(86362001)(4326008)(4744005)(66946007)(31696002)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjRBK05sdkc0YU5HRE9mZTdUQk95RWkxc1NXa09ZWDIva2dmQjBlaFVkS0Fu?=
 =?utf-8?B?WXo1TitRc212TFlMUE81QnpTUjdTYm1sWnJ6RXVXQk9sbkZvZXlUNGk1VWc3?=
 =?utf-8?B?dzhEVFRZdGN6QXZEeVJnNlpYSXJ4U0x4c1dCUzdaZi9XN3ExMDZ3NFRDSUYz?=
 =?utf-8?B?Mi92NzJya3RxM0RSTnpTTFBveG5HeGVEcEtUYnJKR2hnL1QwZldZZUMveDBs?=
 =?utf-8?B?VmhxaHVoamtaVHZ5RTlQMzJWS21wZHdkZlVlN2J5UHh5SktpQlU5UnVidndk?=
 =?utf-8?B?TElzTDlGQlJiQk5DRTZBVmtXQks5RjVhNkV2bzZxdTFtM3BCTjZhYkpzUGlx?=
 =?utf-8?B?RmpGL2E1UGpvUlZJc3cxV2g1cXVEQWVnUXFnQlRzbitmc3BCMzBVMmw3N2FM?=
 =?utf-8?B?RE9zc04vRnhKVHlkVnVsa3BuR1ZFV2FZeWZhbkZCTktscy9iM08vWERHblhJ?=
 =?utf-8?B?WnpLdHlzbFJBc3JQbSt3SFQ3NllJOXJFZ2JZeWNsZ3dnSzhIRU80NjJqSDdT?=
 =?utf-8?B?TlJiRkhERUM5ZDNrbldRbWhMZnNWajExanAxRExjMUlXcnJWUllBUlQwS2tH?=
 =?utf-8?B?L0oxUW5WS3NaNlNtMCttVXlQNWx1em9FeXFYdDhTcll5V1BJWm8zTUJ6Y21P?=
 =?utf-8?B?T09MR0F3aVM3aHVwSjZRc3hoU2FKaTNhNTZoSUY2dUlQUkMxc1lWVnRCUGRr?=
 =?utf-8?B?WWtRYnJCVDd4NHBmcGlORHpxOGFSNFVFMTJWOTZiM1N0MG8ydjNMN1k0TE5C?=
 =?utf-8?B?ZVZYWUhPdnhKVHNicDZRajFnaERJYkZvRi8weTlZR2xtcEp6dlhHcXNFSXNs?=
 =?utf-8?B?c1ZRdS9nNXE4UlozVE0wM2FPZE5oSDNvSnkrL3Y0Uno4eDcvQkY2YlVrQTQ5?=
 =?utf-8?B?S0NlVUlkWkJpa0hObGRIWHBnNk5RV3ZrSE9YNFBnQy9XZ3hGTlAydVppRERP?=
 =?utf-8?B?MnYxREV2dUdtUXpPVGVJSEU3YThOQVpONWYreXgwRFJuVUFwRWtLc0pZOUtY?=
 =?utf-8?B?dlV4N3lpaG9DOFhFakYwREcwNmlmem8ySnJFdFcrL05tMGFaR0F5YzJxVm1S?=
 =?utf-8?B?b0o0S3dhSnl5Z0lkWFU5eHZoUXAza2xNSG5NU2lsVU9jMFA1a0tCVFBEa0k5?=
 =?utf-8?B?d0U3djFneHRTNGZFKzFIYnZ1anZaS0ZUdm9MOWJNRXk1VkRZRlZlN2xDUUp2?=
 =?utf-8?B?ZU9LTVA3ZUtxVW1HQ1hNTEZtUG0zZStQRGd2WEJBb0ZoR3ZyMkRYeFJsQWR2?=
 =?utf-8?B?Q2JxQ2RuMmN5R0x2eDlDU3lYU1RKTkxaMnJuS3UxZlRKTVJaRlZUWlRBYVI1?=
 =?utf-8?B?SkJneDN6TTNsYlMyaGVyZk1RTzRVaW5MaXZiMVFRaWNjK2ZDc05odThvV1di?=
 =?utf-8?B?bCtqZ3RzYVl1RXVMQXY3TFVUMHJYUEgwUVdnS3VqVGg5VzMyYTFDcStydXNn?=
 =?utf-8?B?andVbFZoTld4YkZLeFowbmw3UnVVQXRZSlVZQW1YRFJ5N2tNT0hBeldPQmJ2?=
 =?utf-8?B?Y2EzRmZUaCtvOFpUZWhnL0ZyQzJLRERXa1Jqa29DY3pRUWw0T2JudWNFVVRk?=
 =?utf-8?B?RUtKZkx6UFBsaWpNZWM3RkNMMmdpdllyQXMvSFBxN1BBaUw0RjFnU2VRdDRu?=
 =?utf-8?B?LzNMUE5oUjJqMVZzUngxNDE4NUMzUXBXM3JzaTBOdWRWOTQ5SzM1bVZEVThC?=
 =?utf-8?B?ZG44VkI4VHlyQjFVeDdsZ09Ua0xwdDZENkcwcThhaTdNYXpUT2YrY2hLUE1X?=
 =?utf-8?B?VVR4aHk1MkJJVEF4UkJOTkM5QzZKYlMzbGtxeC9VZlFMbW9EUWowWm5TUFpB?=
 =?utf-8?B?a2NIdEFiTmtKZjdyMkh5RDgyZW5xQmJzVXk1RFNMVjMwTVlUYXlveVdUR3hS?=
 =?utf-8?B?a0tQa0J1SnhuMHVic3NkN3hnRnFIQTQ1cXZDdkFRUldQV2dvcGZBODVpbWIx?=
 =?utf-8?B?TXNIdHoxT0VnVU1TZHZWY084WHpBV05XSkxZWFJPNUNMY1RIZEJ2QVJYbThY?=
 =?utf-8?B?bWp2T3J4NXJVRXA0aXVEQWIwMFJMV25qSUVTRFRsbWFoN3JFaVRCYmcvcllH?=
 =?utf-8?B?dCtOUDdBdy9naUp6MUdSQThHRDRGRlpoV3k0cTdmQXAvanVnTHRCaTJVWjBX?=
 =?utf-8?B?U3VGbU5oOW4xNVREL2laMThUK29Rd0V5d0FDS0FURFM3MnZQek1IWXV6eSs0?=
 =?utf-8?B?R2pJZlZwbVJQdXBVQ05ZTWdPdDYwN0lLUjNOam5BcmtxNXIrTHdDZmhwS1ZG?=
 =?utf-8?B?SkcyOGlTUWlOMDEyOFM3NkxOaHpxaHVYYXpEYzkyRmRvVGdOa3dROWlGK2dG?=
 =?utf-8?B?TzdkdmR3Qk5aQzJlUmJGMzNIeVJScWQvZ0RlK3prNEhRVTRqMU5QcENZWGJJ?=
 =?utf-8?Q?NRT+Iv5RPxDUF1Bk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7f60b-7015-4cec-2ac8-08da23dc0f9a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 21:15:29.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdGp+b2CD1/+TUUe+ITGwyza4nd450Eyb0Xk+BajYP01YLtLZL+RN2aIjLVQ5SoorybFLMobUuTMTLY9N9AFikNrb9bbb1bOHZxzoQMBNuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1898
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_05:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204210110
X-Proofpoint-GUID: o1CQ6H-WCdqYeRwAsE-c-mW-L3QnWulw
X-Proofpoint-ORIG-GUID: o1CQ6H-WCdqYeRwAsE-c-mW-L3QnWulw
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/22 7:43 PM, Alaa Mohamed wrote:
> kmap() is being deprecated and these usages are all local to the thread
> so there is no reason kmap_local_page() can't be used.
>
> Replace kmap() calls with kmap_local_page().
>
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>


Applied to for-linus-5.18. (Juergen, I kept your R-b from v1)


-boris

