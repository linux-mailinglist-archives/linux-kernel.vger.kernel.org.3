Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96230585E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiGaKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGaKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:54:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F711824;
        Sun, 31 Jul 2022 03:54:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26V1OItN020267;
        Sun, 31 Jul 2022 10:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XxbDQUrtuhknVe7cRjFXccbnxe1HrS7GkOwZbwCUKVo=;
 b=RhEQPCOuQaW4P0xEbANRvlnAuAp4zjTuHB5iAQ1geHVMYcPsCP49G73ynGM86OZwFMK4
 4FrecmtQmq30esMbfybWa3OAhZmqjNM++VxoJ//haMvDAoa0DRL0FC1AGu3CAwPr8Xbn
 dmipdvdAuVPDcwtl/CEWD9wynLf7xdmsEMZp1ofXUKJH1PJNh9OTFWrRzHpfHr7mietl
 0KPxGaUn2wQj13gA2eEcvvR1kel9OxCswzMQRYjCUkFpLIfktgwer0TV0aJNjHdcC/9c
 dmAWMufH6KwIYu3M4g0xwe1EOQ7sBCg0c+AJ+tVxTX+KmE0SFvTbbxYhy0/taWb0HE72 GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s1c7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jul 2022 10:54:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26V79lKK014927;
        Sun, 31 Jul 2022 10:54:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30k464-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jul 2022 10:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCL3sRL0wvhiYii3+fMZHX2RethNsLZa7dCD/64xaW1DDxlkD5DrAfrkN1Jqc5vngX/xhVhgxXOqu9ubM5ARnwiDZ02Oxt3iKkDpA+1F3NByTKxv1WofdFO7fYBpUlBsUb4RT9Q70GHJJx5b4hbGrATkyrtbFeEuqW+qZ75lzHyFaHrbT2voQJR7KsBWs8UNxiX/ExybA2IARzfB+UF9v7gPZmCuUyRyt4P3tR8Qrp5DHr2Yg41Yz0pyNxHattmloFyn9w1XRJoSLPclwP+twKnSwFSktmPLGrs7pmB9GD1RRCCh5zT42mDBUvLVodRLeU9wnrE5PXv3qd8DJ//dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxbDQUrtuhknVe7cRjFXccbnxe1HrS7GkOwZbwCUKVo=;
 b=TOGaFNhu+DgwgTe4H7sloY3gt1eHYthVZThS0/x1uue8FC1U66tmY8frz6ZH3CtoYxonwQUeKKZlEZ/cmOudp2/i+fJG4RW3ugVQec89oelrVcRhc0lJViWbUgL5rln9HTXI2eAkhwiHDtK+3bPVgp4caD64E/oPkcr7DzpgoqGY347+zQX+6o0+gK+xhogT9cXLT0Dt/NTsP0EQsjYvgoXTTqhA5ppAbej7jGXjlZpiFmajuWkHLsXAvhPKjmlttzjRWbd/LO1TTlhUqC3HXTbOEYmicQGN4JcTzrt8830w2m2dCUImRgHjNKC9gOublCM4vPJaPFSDpwTCIjlGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxbDQUrtuhknVe7cRjFXccbnxe1HrS7GkOwZbwCUKVo=;
 b=TykWjmuvddQ7BfoDh2UVBIGYcD4mlXPicQh99JjHa7Upg9WpkRLRPUA8yl4Ymiv2LF61qDMYYiJ7rvAJFRlFEouAnshKrrt0yZTx01PB+Ooqbjlt+eCe9v6aD0zPfvUlTrums9+IiE2e6Umk1LZrndQsq8lGAkDie9OzKtLY9DA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2059.namprd10.prod.outlook.com (2603:10b6:4:2e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sun, 31 Jul
 2022 10:54:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%9]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 10:54:17 +0000
Message-ID: <803c6f90-4fa5-e427-ec07-3b14e69413b8@oracle.com>
Date:   Sun, 31 Jul 2022 20:54:08 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] mm/kfence: Introduce kernel parameter for selective
 usage of kfence.
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20220727234241.1423357-1-imran.f.khan@oracle.com>
 <CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::6) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5237f63-f57b-40b4-7878-08da72e3038b
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJuIdBX2DkJFoYs6RePtJYsXGFb8bekqOZtYnBUrmgrNN3VgWjnmSrPFXjVy/qfEE0mYMEX5JCvaAnXAEEGsWjU9lTvYNVs4exW0W0B3i/XtngSQ+WTFQ4PC7tlnD5t2iKBm9nQ6FqXRuD6tLrWdl8l5YBFYyHvddDd4r1XvkOvnHCU0kDAaTC87HLYKzUDEt7hlr8EaiafNAETlEJDiRjHIfrfpXgcN/g71sJeFS2CZxus0mWiUAL8umkOfuA77GPhbv3WdSbiV1rbFxHMz+Exd8k1eTILRvw0EGIOecwCrzhGNMilzUkJ1i9BXDj/PtFnD0UyIfArnJ24gLZQA1v7z7avf3VCp+62M0GFu7sVZQY7GtlWXmlNKtiDToCUrgC65gTy91zonGDjXPavw6nCnAPhuFDJxiYywtMP/WSIOn6pQEoaa4oOtpSOH2U81/dr4jJdYGenCjFp0kY5wL7UfLf6vSLajPuBbJwGPXVcnPVcpWf2F7da2lYPyqmEs/1pgz7X/hz9P7T3OYXgmOYkNRbvtRXoHI0zh9UUi22J9uaCXmnNbwDoMvxBDETp+6QfOhPWv4pmzQNnXn4eMZCbkKSqEKh6oLammbO1dz/8bO3igZIX92Hyj8DoImhKlSuUsVzxz6W0NKpD0lWqaYW2GOlnTG1D6nSc//gRs0kkJMuKBOe+bQz5xVi6ZpD0wa63cl471bqTrxQ0/3RXqhzyq7PlHqKbblEKNGL8KT7vw+8cCxu/sfa4q8xszAZX11M61svzyyJ1fTlAUhzYc4WRg0M4favBjS86zGcEDMT28DHx28RhxymTSfh1nI+0Bx4NVSKEK58KVymsm1qJ5bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(346002)(39860400002)(8676002)(4326008)(66476007)(66946007)(83380400001)(186003)(316002)(66556008)(31686004)(36756003)(6916009)(8936002)(41300700001)(6666004)(2616005)(6506007)(7416002)(53546011)(2906002)(86362001)(6512007)(6486002)(31696002)(478600001)(26005)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhKSVpRTWROTUZHcXVzc1B4VEFRMTZzd2hPOHVTbU1IMnJkcWcvUTVNN3Z2?=
 =?utf-8?B?QVpJSUdPVlp3TDk4dEhDeVFBTFpISnkwRU1mZVhtUTZzNVZOc0QyeVBxZThP?=
 =?utf-8?B?cVZacE52UFRDZm9wK0RDbGJNNlpzaS9TL1p5OWhZUlkwbTJjcGhVd0wrb1Fm?=
 =?utf-8?B?Wm5wZXkxZUdza1JoMk80cVM1U2l1ZXhGSWt6Y2k5djQ1Y0VySDg1UFRCeVpk?=
 =?utf-8?B?VXA1VU5KeEtSenFoYWpZSUQxbG1QV3F0NlMzbTNpUDFreldERFFndjBpWU95?=
 =?utf-8?B?WlJ5V0VVNUh1WXBFL3J6cmZzZDFwMlJXS1NPN1ZQeERNc0xTOXd0ZjRoN2g0?=
 =?utf-8?B?KzR5bDBScmYzQ2hxZHNNbHpPMnppL3BxcDBlOSsraDR2ajlZTjhtRSsvdFQ1?=
 =?utf-8?B?NUdmbGh4YTYyVUxwM1VpMFByQ2c4Q0J2eU4wK0Q0QTZSSHlJRVlJL2xZY1Ix?=
 =?utf-8?B?ek00b2hhcUVYOWwvQUhBTjc3ZTM3ZzFZSlIxUXNRK2hXMld6amlpSStkRVd0?=
 =?utf-8?B?bml4Y3BhQ2NWbGRYRzV6MitKaGg0dEJ5OU4reEtaYVNsUld1aGpTZjlxTEhQ?=
 =?utf-8?B?NldNQk1jMlFROERnbXdKUVZiZTYydG90L2hDVlJKcXV6enlQWVpUaGlRMVh3?=
 =?utf-8?B?eVlsakVLelk2bXBEMDAxSjZOSFB4TXVaOUR3SlVON2o2cUNuWXgyNEV3SS82?=
 =?utf-8?B?RUdRVnFLeFNWNjJXUStPZnVNMFZaODZSMHFSS3hzdlp6VE9Db3hNRUlZYm8v?=
 =?utf-8?B?Kzk4M1RpM3BDTk0vTFkyT3BXVUhTcmlnbHlBL3BPa0hvZE5ndS9WZURhUXE5?=
 =?utf-8?B?Zkx0a04rRlB4Wk5EeThnNjJjUnhSL085ME9GZ3d2LzkxNDJ1N3hRRXpXYisy?=
 =?utf-8?B?TXFuOEpBK2FJZFM5Sk50VkpsMlpGOUNYNVBjY1c5ZFFBYTZpS2wrQTM4UzhX?=
 =?utf-8?B?bFhocm5ZKzVnUG4wVE1aNWw4NWlmblVoRUxIQ0NDME9DZ2lQbHZqVVpKb2ZG?=
 =?utf-8?B?cmZHTGU4SHhsZGZ1SDlJbllOcTYwYTBlN2FmUU1VT3BkdDhDSGJJbkFkRDA4?=
 =?utf-8?B?aU00VTlFNGNMZi9udnUzOGFYRG91R2Jrb0VHQmZDN2d3cHF4dng1ZEg4NDJU?=
 =?utf-8?B?RXB1TWZVSm5KdXdNakhoaXYycUc5WlYxMjVZZ3h5Vnc0YWpzR1FxYUVFU1hx?=
 =?utf-8?B?Z2hPeENESm5teWk4ejYwYjBJSDBwS3g4M0tiUTVNKzhXZkhPNStMcXJIR0ZE?=
 =?utf-8?B?Z1ZkdTBBSEtrUEtlSUNxQ1JsSEIxdmFtM1RJNTFSaStWdXltVW1aMVd0bmxt?=
 =?utf-8?B?M3ZXV28xSVVQR2xibTdHOHluUHAzNEgzanB1WnpVRkJ2b0V2SC9HeUNZdGFs?=
 =?utf-8?B?TkZCTUJHaG9aeEdyMzBhUGFjT0ZiSVkyY2pPQmo5cTJEQzRKRVJ2OTJ4ZFNv?=
 =?utf-8?B?UHZJOUlldmM5dlh0dVlyUlBlWXNnTjZjaklHWDQxSkRsVDFjRnFORjBqM0xv?=
 =?utf-8?B?czJnU1F0TFl1b0ZhN3dVdENHYkxUMWc2WndENVVvQlRYd2pDQTJYS2VxZUlY?=
 =?utf-8?B?NTZzNCsvbTRmOTVmZW1yaEZuaEJYamR1UEl5OG5ZUkxvcmZqTHN2cVNRTmZ2?=
 =?utf-8?B?d0ZKOElvZFhZRjBLd0cvRFhrZXVtczhMRXl5VGQ1UWttdUxnSGd1M3RXR3BZ?=
 =?utf-8?B?dXMzNWQ5SGhyZ0xiaVo5L2QwdURRRmxVeGZlR3RsL0ZTSHUraW02NDkxWnBq?=
 =?utf-8?B?THQyQWk5eEJCM29VVFF4MmN4QTV5cWhmcUVNYTgwb0Y4QkpERTU5OGRmTTlo?=
 =?utf-8?B?aDZpaENnbCtuOU5kMnFseTVVT3JQUXphcjg5SmRTZXhhTHFSc1FGMVNQbkxv?=
 =?utf-8?B?UDA0OTQzNXBhdXhOQzFTczJwMWlhU1FieENkRDdRZ0Fid1ZJRFhscldzNi9E?=
 =?utf-8?B?QWpjSWpwQ0pKQVhIME1KMDI4ZEx0UUh6N1loSVRsZjlBTzFpb0N4U21MUXBW?=
 =?utf-8?B?dnNJNjEyK2pXbEFIZWF1dWl4Nm9GeGpHNXN0QVZEb3lNTkY3SXRNY2ZYVmwz?=
 =?utf-8?B?ZlBkK0RLc3NzYzhjaG5FTUdMVG83YTUxYzR0bEM1dm9CM055M2o3NVhseUNX?=
 =?utf-8?B?K2paWkowZ0QvdXhyMWYxMjM5bk55TG8vTjdES1poclU3N3ZkeCtwNE45OUQ0?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5237f63-f57b-40b4-7878-08da72e3038b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 10:54:17.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA9z+IBZvTPgFj9B3eTi0Jc+sKtVTumjmcpx2107WGtG8MNK0mgd24JnT7aKSKB7IDRWuvNdZPwoCOcJEFYbBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-30_07,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207310056
X-Proofpoint-GUID: gu8yNbtCYwYcaDf-zi8Awm73LKZoasFx
X-Proofpoint-ORIG-GUID: gu8yNbtCYwYcaDf-zi8Awm73LKZoasFx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco,
Thanks a lot for having a look and providing your feedback.

On 28/7/22 5:24 pm, Marco Elver wrote:
> On Thu, 28 Jul 2022 at 01:43, Imran Khan <imran.f.khan@oracle.com> wrote:
>>
[...]
> 
> Have you seen this happen? The "skip already covered allocations"
> feature should take care of most of these issues filling up the pool.
> Have you tried adjusting kfence.skip_covered_thresh?
> 
> Or put another way: with your patch, have you been able to debug an
> issue you haven't before? Typically this is not how KFENCE is meant to
> be used if you know there's an issue; at that point your best bet is
> to build a KASAN kernel and boot that. Of course that may not always
> be possible, but there are other knobs you can tweak
> (kfence.sample_interval, kfence.skip_covered_thresh).
> 
> Your patch only makes sense in a "manual debugging" scenario, and not
> quite what KFENCE was designed for (deployment at scale).
> 

I have not yet been able to utilise this patch in a production setup because as
of now we don't have any deployments with kernel new enough to have KFENCE. But
I have had multiple instances where an issue would happen in production
environment but is not reproducible in-house. As KASAN is not an option for most
of such cases, usually we get slab objects that are getting corrupted from
vmcore and use slub_debug for those objects. The reason for using slub_debug
selectively is to keep performance impact minimal.

So my intention/idea here is that if we run into cases where we have some
sureness about which slab needs debugging, we can limit KFENCE only to those
slabs. This along with increasing kfence.skip_covered_thresh should increase the
probablity of KFENCE catching the issue.

[...]
>> I am also working on getting kfence enabled for specific slabs using
>> /sys/kernel/slab/<slab_name>/kfence interface but in the meanwhile
>> I am sharing this RFC patch to get some early feedback. Especially
>> if this feature makes sense or if there is any better/existing way to
>> achieve similar end results.
> 
> Do you need the slab restriction from boot? Because if not, I'd much
> rather prefer the /sys/kernel/slab/<slab>/.. option; in that case,
> it'd also be easier to flip the slab flag to SLAB_SKIP_KFENCE, and
> none of the "kfence_global_alloc_enabled" code is needed.
> 
> Then if you want to only enable KFENCE for a few select slab caches,
> from user space you just write 1 to all
> /sys/kernel/slab/<slab>/skip_kfence, and leave them 0 where you want
> KFENCE to do allocations.
> 

slab restriction from boot is not a must. We can stick to sysfs interface and as
you suggested get rid of kfence_global_alloc_needed. If some use case wants this
feature early, it can be done via some init script.
>>  .../admin-guide/kernel-parameters.txt         |  5 ++
>>  include/linux/kfence.h                        |  1 +
>>  include/linux/slab.h                          |  6 ++
>>  mm/kfence/core.c                              | 86 +++++++++++++++++++
>>  mm/slub.c                                     | 47 ++++++++++
>>  5 files changed, 145 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 98e5cb91faab..d66f555df7ba 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5553,6 +5553,11 @@
>>                         last alloc / free. For more information see
>>                         Documentation/mm/slub.rst.
>>
>> +       slub_kfence[=slabs][,slabs]]...]        [MM, SLUB]
>> +                       Specifies the slabs for which kfence debug mechanism
>> +                       can be used. For more information about kfence see
>> +                       Documentation/dev-tools/kfence.rst.
>> +
>>         slub_max_order= [MM, SLUB]
>>                         Determines the maximum allowed order for slabs.
>>                         A high setting may cause OOMs due to memory
>> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
>> index 726857a4b680..140fc4fe87e1 100644
>> --- a/include/linux/kfence.h
>> +++ b/include/linux/kfence.h
>> @@ -125,6 +125,7 @@ static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp
>>  #endif
>>         if (likely(atomic_read(&kfence_allocation_gate)))
>>                 return NULL;
>> +
> 
> Why this whitespace change?
> 
I will remove it, it was a mistake.

[...]
>>  #define SLAB_NO_USER_FLAGS     ((slab_flags_t __force)0x10000000U)
>>
>> +#ifdef CONFIG_KFENCE
>> +#define SLAB_KFENCE            ((slab_flags_t __force)0x20000000U)
>> +#else
>> +#define SLAB_KFENCE            0
>> +#endif
> 
> Consider flipping this around and making this SLAB_SKIP_KFENCE, which
> would be more intuitive.
> 

Sure. I will do it.
>>  /* The following flags affect the page allocator grouping pages by mobility */
>>  /* Objects are reclaimable */
>>  #define SLAB_RECLAIM_ACCOUNT   ((slab_flags_t __force)0x00020000U)
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index c252081b11df..017ea87b495b 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -132,6 +132,8 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
>>  /* Gates the allocation, ensuring only one succeeds in a given period. */
>>  atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
>>
>> +/* Determines if kfence allocation happens only for selected slabs. */
>> +atomic_t kfence_global_alloc = ATOMIC_INIT(1);
> 
> This does not need to be atomic (kfence_allocation_gate is atomic
> because it needs to increment), just use normal
> READ_ONCE()/WRITE_ONCE() on an ordinary bool. But I'd also prefer if
> we don't need any of this if you go with the SLAB_SKIP_KFENCE version.
> 
Agree. I will remove this flag and use SLAB_SKIP_KFENCE as per your suggestion.
>>  /*
>>   * A Counting Bloom filter of allocation coverage: limits currently covered
>>   * allocations of the same source filling up the pool.
>> @@ -1003,6 +1005,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>>                 return NULL;
>>         }
>>
>> +       /*
>> +        * Skip allocation if kfence has been enable for selected slabs
>> +        * and this slab is not one of the selected slabs.
>> +        */
>> +       if (unlikely(!atomic_read(&kfence_global_alloc)
>> +                   && !(s->flags & SLAB_KFENCE)))
>> +               return NULL;
>> +
>>         if (atomic_inc_return(&kfence_allocation_gate) > 1)
>>                 return NULL;
>>  #ifdef CONFIG_KFENCE_STATIC_KEYS
>> @@ -1156,3 +1166,79 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>>
>>         return kfence_unprotect(addr); /* Unprotect and let access proceed. */
>>  }
>> +
>> +#ifdef CONFIG_SYSFS
>> +static ssize_t kfence_global_alloc_enabled_show(struct kobject *kobj,
>> +                                         struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%d\n", atomic_read(&kfence_global_alloc));
>> +}
> 
> Why do you want to make this a sysfs param? Have a look at the top of
> the file where we add parameters via module_param(). These can be
> written at runtime as well as specified as a kernel command line
> param.
> 

Sure. I will replace sysfs params with module params.

[...]
>> +       if (!kfence_kobj) {
>> +               pr_err("failed to create kfence_global_alloc_enabled kobject\n");
>> +               return -ENOMEM;
>> +       }
>> +       err = sysfs_create_group(kfence_kobj, &kfence_attr_group);
>> +       if (err) {
>> +               pr_err("failed to register numa group\n");
> 
> numa group?
> 

that's an embarassing copy-paste typo :).


I will make the changes as per your suggestion and send a new version of this
change.

Thanks
-- Imran
