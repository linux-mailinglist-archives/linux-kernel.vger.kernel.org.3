Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A474512778
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiD0XYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiD0XYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:24:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD6B86F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:21:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RMb0og003699;
        Wed, 27 Apr 2022 23:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OZm1LSmTPz0DMApDqP0zWYUyEA7uzNOG1oofQKNunT8=;
 b=cUSOUijqYvHSDsGtESJZ9ZfAm+t6nYQRZthOwiOkrJJG2EtguBYN58R/tM7gQ5ZUgEfc
 uTfICGo9D2EHyL/8OnSmyNYG27xrCfCKAChWpwsBzSqlYfTkkKixHBtHE0yuEGgPHvgi
 V/g+byh4Sd8/dSsa1u704HaBeg4Ft0ZuguXdTlOqBa4Fz8jPWlqU/sWKVU0QTK3K7UM6
 8ivWE433lIFaXlTu0qqpY2lsqyRgNT1Jg8TaNbrocDSBBNpWnimdLUbmsjn1moWLfh12
 VIiIJ3KGDQBps1rmDe20O1AIsMrNDoBSViotNOcSD6vn+nwbCU0K715FUBkxbXofYOrf lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4t56b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:20:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RNAadi011687;
        Wed, 27 Apr 2022 23:20:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymt8f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWSWEBrG69WajoGlE/LvUcTRGIkio8wWEfzkVzyhYXGIAlS9mHRroB4zzZyCGlYGnACZsV8XhV+6JNExNVxTuuMz54RCxoSTPYdvFEL1ksvZOb3Oeh/wdKI5HWH6RK9WzE7JMh9yQbhKHi+B/cZ5d308ECgB0JpoHkh/+USQYk1PzZlkg8cPPGckxDEmw1KT3MYC3nVKLzNo8g+klIRRRdcCL+e1YQUCmo13JG2b5hHHHbcrtvud4rg7v3pNEENjC/kgpI6NB6caO8qkgJ7ePdZwoFBiATyQuo5PQwxrH0rGey/Z/jc2qArSxxpNjZ9sAfinyNPzaeUMK8d3+EY0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZm1LSmTPz0DMApDqP0zWYUyEA7uzNOG1oofQKNunT8=;
 b=TFFzxGAuPSheQV8utmx/ySx06mMc9aOxb1XYDs+GdsetkTCbNWklymmgGmYUkjgscRYT2Cy5bheIpH69q7sPnBvLMMpi/aZqjMTWJkt1tWITORvftAggBXA/wZjYHcol6ODF4ZFRteJPXI3jwsbo+UYzO58BQwvpZq1loGzAqPBnMaG+lqT4yNkhIYx7ohyD6NbbaAY44YsUAu2v7tJJisIWWCKTf5H+/f3ru/UeVGf7daXZxip8kuli/SssGD4aTwms1c4z/lmUfI6WPZnrBvQTSGQVNBDIQHtr3QoJ4zkt64YB6EAFyEpFzOOOxtL21BkAlkBpR6VJEOfs/sEhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZm1LSmTPz0DMApDqP0zWYUyEA7uzNOG1oofQKNunT8=;
 b=vD85rjk6GcCrvx6YZ8t8AFsZHGPY6RVMz1EV8qXohF0UVixcIqzUWXRjpu8pSYFDqANzXSOtnwuvAKCfdutXnCb2rCD1/NlCuVcDCSYko7eQOjntYkmHNGVaNgSfVzXDSm34P4sHq/vWQVwLY6F9dN7i9UOsAmey3QpNZFXMRoE=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 23:20:53 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 23:20:53 +0000
Message-ID: <98456253-47e9-a9a3-0afd-22a6c2286704@oracle.com>
Date:   Wed, 27 Apr 2022 18:20:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5.15 1/1] Revert "locking/rwsem: Make handoff bit handling
 more consistent"
Content-Language: en-US
From:   John Donnelly <John.p.donnelly@oracle.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, Waiman Long <longman@redhat.com>
References: <ef615782-f1b0-af1e-5341-f787d964756b@oracle.com>
In-Reply-To: <ef615782-f1b0-af1e-5341-f787d964756b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa665d8e-04e5-4936-4c6f-08da28a492e6
X-MS-TrafficTypeDiagnostic: DM6PR10MB4186:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB418659BB7072113381935779C7FA9@DM6PR10MB4186.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nN/HfQEm7YXzeEAv2PiYJ313spVQYUbHU0vMJTAioZ99U5mUISi+2Carmp95eUbX2KY/YzvmItB91V8odY/iTYzzzDIckdDm1JGduMsGNbZ9JqKpw1cpRdU9Tj80LCRWeMgF3PfJYlmRGmcFSR0sZ1net3MjXoaLl6SD923LMkbZKWjabR/wh/0JHD/Ii2dMIhHL15YAS0xMGKBO72Y1zCzUBRSrDS0Y4DTeW6GEgft3w/vLXidfigZd/3O+qyastdkwRGI3ESvHpfffHO0IJZDsQUvzeF7cvApfng9abYPWOOnMUcR+E65FqtNNYo+y71M8NLi7orfnahOylWEDXEM0Fxj/B2qPYEX/4z0A06jUX0/E9xPbsaZPI47LdsWTf0Adb/0YEVCfMA2CnBHdlZosgs8anFg6y7BQhLJ+YyTyLXzzSjnvBvHiTGffcrrpEpBtR8mL9VOl79/gCrNQkHsucghMyiTa3KnUBMdS6xycIztvslUvKIbGUMQuQIsNnyAt/WrNuiPL5pPLkUz2vTIaRgeboy0gsoeeYT6dxLG/WiZRKIYLXEdNxmsGWYyGxzA/YNfckVUDYO+n6YxG9ud77Ap0P2HZWVXZ9xvxzL2+wcIeHpbkrbRj/xecPbG65UkEbmlvwXijBLC7cSa8t7GHKbFUoBbf5ie0XdjrH9Q11KUgEsOOwoW5i7NLRStJdzOm7DRMfFCQJ0QVube9uGnoh1ZcBo/wJ9En2nalCvlH0nmdzSZ3Tdn0RZgoh7T6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6486002)(66476007)(4326008)(5660300002)(26005)(66556008)(66946007)(8676002)(31696002)(83380400001)(316002)(38100700002)(8936002)(86362001)(186003)(2616005)(508600001)(6666004)(31686004)(36756003)(6916009)(53546011)(6512007)(6506007)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2srWU4wSU1pQ2FMSlpVTUNQU1U0TDllOG9McWZrY0pDMmNhcTFZb2dkZ1dm?=
 =?utf-8?B?WDA0dGdyY1hSczZneURyT0dHYmF5UE1FeXcwdHdXakYrMDdzbEhOSlBNUzJ1?=
 =?utf-8?B?QXdic1g3YkhudklmRzNPWm9hY3R4b1d2L09xWXRaOW94S2UwblhqK3djVXpK?=
 =?utf-8?B?MEJHWlZtQnBaNlJmSnFqb2Vsc1hwTExnNjZnb3QwVjlXOXlkU1ZhbWdCdlBF?=
 =?utf-8?B?VGdwVWhoTkVzSWlKVzZQUFRLeUdQWVVGcWh6YTZxS0hXK2lheUVSenRJMXNZ?=
 =?utf-8?B?czB5RnlaL25yR3NFTHc0UDVua3hwNFFHS3JoYk9LOUlHU3BHdGpaVklzcStt?=
 =?utf-8?B?N0xKWHRjVzFpQmdjTmhXd3JGUHJ1bElBZ0tpZTNCVHJDMUN3cWFmZ3RKUk5v?=
 =?utf-8?B?QTlpNTkrUm9zdTk5ZDNoZ2lKdG5JRmtJbkxlRDhYaURTZTIzV1h1V3BBd3A0?=
 =?utf-8?B?UWltY0lRaFZWY0dYT2s1bFFiNVJwa1NDN0FNVWhvNHhtS3d2QzI1MDJ3cXhH?=
 =?utf-8?B?V2JRMTF3bWl1RWNqM2hENjQxcSszT1VtNmlIYUZBWG1VeFRGZWVDeUl3dU5K?=
 =?utf-8?B?aXBmQmZmVVRjNkY2ZnE3RWtyRkFvNHdIOFcvdEtraklLT3N3ZklGWGNJRXZi?=
 =?utf-8?B?S25KVjFnV0hCMktCakpXUFlnVUgwSVhPNW92T0VKa21qQWtDbFpieGdDUHhX?=
 =?utf-8?B?RHZHR3FuMFBSMGJQWHBRL0lzaXowdG9LdjMzbXRZNk8rcEpHRVhxWVAybks3?=
 =?utf-8?B?MHhWaW5VYnFHVWFwWThyak5xcWNsN3JhT1h3ckF1d2oxc0lBeGxmeEhmMFlE?=
 =?utf-8?B?NGlNaGFac01UQisrSU1MdnlvSHRJQ2R1Y0RTcHNkS1dQVDk3TzNwVkVkdHc1?=
 =?utf-8?B?S0FXQ0ZTcDVQOVc2RjZ5dFZsdkRmNm1Ba1NUUE1IN1dBNm1rYlFUN3ROSzF5?=
 =?utf-8?B?V2hCd0hDcEcyYU5LaFNOUmtzbURZQ2tjR0ZzQTRCR3NwYmd3bDNHTGZjQTk2?=
 =?utf-8?B?aWdHcGhjM1dPMzREU2FBL1FCWTJwWUlVWitKenlPZGVEdEo2dThmN2xsdUZ1?=
 =?utf-8?B?LzkzQ3RWZW11SXp4QVgyRjN5KzJ5QkZ5TWtWcnBkb0c0d29ObjMrWkVKZWpT?=
 =?utf-8?B?UVRHbDc3T254YUp5SDIzK20zeFZTMnlnYmlrciszMk11OXBkc0tHOWRUemhZ?=
 =?utf-8?B?VCtHYXJwa3lGVlNzMStaak5HWk5seWFWSnhYOUtYem1lbWZySUxFcDdtUFMv?=
 =?utf-8?B?NXFMNUdYbmJONk1LZmhqMGg1S3JaMk9DQ3QxRW0rd1hPUEhWWG5NVVlWMHdR?=
 =?utf-8?B?Y2pIRmpWMGJUbHhlUlF4OFFQcnVoRFFMQ2thOEx0T1A3ZUdpck1DM2xqOXpK?=
 =?utf-8?B?QU5wZEM3aWhNZlAyMFpVZ2hid2JCUnRMRHVTc2JIQ0pMdUE5VHZNNUJQSDdH?=
 =?utf-8?B?ZWxpOG1DaVNJcEhCamVEQ2RSdFdkRVppWnNXRGZiQ0U4SThmN09hVUtBdzVE?=
 =?utf-8?B?TmtDcktwL0JBdEswYWVZaE5ncEdia2ViZkNaSVRGNXhBRkRlU3VZdDcybWRa?=
 =?utf-8?B?UGVsWEY2cWJva0pkdzNCL0V6ZjFrcnF5NFZTKzdWTVRpSWxwM1A5bHA2eCtq?=
 =?utf-8?B?cXdiamVLeStkYmxnUzhVMVhsajhtdi9UV09HT3E5RGFDbEtBS0w5Z2pKUnJM?=
 =?utf-8?B?NDB6VVlRUkMvUUNESVpKZURtWU1LTWlNeFNIOXRtbHFmVXhnYWE2SVlEWTMx?=
 =?utf-8?B?UDFzTjBta1R1YXpSOWc4SWt4ajNtV293UncySW5RcGtEZ0tlUWRjMml5NFEv?=
 =?utf-8?B?VzhtdGgrNXZVV3ROZ0YzZDVmTHlZM3RxTkZKYVg1Z21ybXNTa1Fpc2NJeUpJ?=
 =?utf-8?B?TDhBbC9xLzZPQWFubndTcjZUTW8zd29HZFhMcWM2dUxvNXBUVjNyRUlpSVpn?=
 =?utf-8?B?dHV6TjZja1Vlc3FBOFg0Rzl1VG1mS2tmclVWdC9qcW00VDBiMUFQbmgvQ1ht?=
 =?utf-8?B?SERWRDF6TTNSRk03cjdad0c4Yk03YzYvN1pyTlAwZ08rZ2NPKzVhUWVoVFJv?=
 =?utf-8?B?RzJkMUVkTjUxMkZuNTBwZHFMaHBvRXFwNVI4ZGhoSkZqai93RTdta3JIV21J?=
 =?utf-8?B?d0dxR09YZGYrYkF4ZkFSZ3RBNHQzelh1WDVkbWMwcEVGSkM4cjBwalZ6aDlx?=
 =?utf-8?B?ZUhHQllYSnhvUUkvV2ErM1FHc1BXcUNJWlUraWkvWFlQQnl1ZFd4ZW5DMVd4?=
 =?utf-8?B?VWNwbFZQU3RVTGdJeWNMbFJoem5ONVJXKy9OQThldTlDWVhQdFJ4aDg4VUtU?=
 =?utf-8?B?ckkwTXJDRTdyZk04cDJWN3YxL01MRytabjdNNHZJellqTlpHbHNuYkZMVFAr?=
 =?utf-8?Q?Di/2REiFiBl6HBJU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa665d8e-04e5-4936-4c6f-08da28a492e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 23:20:53.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8J2Ab5uE+1nHf/BnJIh4moyWEOObAi5DDFS7dsHk2Jtzav63IeLkLlxne2KhLbb5WMHNqwX/fhJz0THh4+/2t3p2l0IB9HALA5Rzc1Zrkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270136
X-Proofpoint-ORIG-GUID: 0Sqd_5r16fuBR3hbM3-IlyuUTgSRVLav
X-Proofpoint-GUID: 0Sqd_5r16fuBR3hbM3-IlyuUTgSRVLav
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 5:56 AM, john.p.donnelly@oracle.com wrote:

--

Hi



Since Waiman followed up with :

[PATCH] locking/rwsem: Allow slowpath writer to ignore handoff bit if 
not set by first waiter

today, I am not sure if this is needed if that patch is applied to 5.15.y .

Please advise.


> This reverts commit 76723ed1fb8922ee94089e7432b8a262e3a06ed7.
> 
> This commit has introduced frequent system hangs running "fio test 
> suite" on a variety of filesystem types on LVM volumes composed of four 
> nvme devices.
> 
> This issue was first encountered in Linux 5.15.30, and later in Linux 
> 5.17.y.
> 
> Each panic includes the rwsem_down_write_slowpath() :
> 
> ext4:
> 
> PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
>   #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
>   #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
>   #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
>   #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
>   #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
>      [exception RIP: _raw_spin_lock_irq+23]
>      RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
>      RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
>      RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
>      RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
>      R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
>      R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
>   #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
>   #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
>   #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
> ffffffffc11ad9e0 [ext4]
>   #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]
> 
> xfs:
> 
> PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
>   #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
>   #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
>   #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
>   #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
>   #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
>      [exception RIP: _raw_spin_lock_irq+23]
>      RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
>      RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
>      RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
>      RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
>      R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
>      R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>      <NMI exception stack> ---
>   #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
>   #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
>   #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
>   #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15
> 
> Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Reviewed-by: Jack Vogel <jack.vogel@oracle.com>
> ---
>   kernel/locking/rwsem.c | 171 +++++++++++++++++++++--------------------
>   1 file changed, 86 insertions(+), 85 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index e63f740c2cc8..29eea50a3e67 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -106,9 +106,9 @@
>    * atomic_long_cmpxchg() will be used to obtain writer lock.
>    *
>    * There are three places where the lock handoff bit may be set or 
> cleared.
> - * 1) rwsem_mark_wake() for readers        -- set, clear
> - * 2) rwsem_try_write_lock() for writers    -- set, clear
> - * 3) rwsem_del_waiter()            -- clear
> + * 1) rwsem_mark_wake() for readers.
> + * 2) rwsem_try_write_lock() for writers.
> + * 3) Error path of rwsem_down_write_slowpath().
>    *
>    * For all the above cases, wait_lock will be held. A writer must also
>    * be the first one in the wait_list to be eligible for setting the 
> handoff
> @@ -335,9 +335,6 @@ struct rwsem_waiter {
>       struct task_struct *task;
>       enum rwsem_waiter_type type;
>       unsigned long timeout;
> -
> -    /* Writer only, not initialized in reader */
> -    bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
>       list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -348,6 +345,12 @@ enum rwsem_wake_type {
>       RWSEM_WAKE_READ_OWNED    /* Waker thread holds the read lock */
>   };
>   +enum writer_wait_state {
> +    WRITER_NOT_FIRST,    /* Writer is not first in wait list */
> +    WRITER_FIRST,        /* Writer is first in wait list     */
> +    WRITER_HANDOFF        /* Writer is first & handoff needed */
> +};
> +
>   /*
>    * The typical HZ value is either 250 or 1000. So set the minimum waiting
>    * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
> @@ -363,31 +366,6 @@ enum rwsem_wake_type {
>    */
>   #define MAX_READERS_WAKEUP    0x100
>   -static inline void
> -rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
> -{
> -    lockdep_assert_held(&sem->wait_lock);
> -    list_add_tail(&waiter->list, &sem->wait_list);
> -    /* caller will set RWSEM_FLAG_WAITERS */
> -}
> -
> -/*
> - * Remove a waiter from the wait_list and clear flags.
> - *
> - * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 
> 'copy' of
> - * this function. Modify with care.
> - */
> -static inline void
> -rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
> -{
> -    lockdep_assert_held(&sem->wait_lock);
> -    list_del(&waiter->list);
> -    if (likely(!list_empty(&sem->wait_list)))
> -        return;
> -
> -    atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, 
> &sem->count);
> -}
> -
>   /*
>    * handle the lock release when processes blocked on it that can now run
>    * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
> @@ -399,8 +377,6 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct 
> rwsem_waiter *waiter)
>    *   preferably when the wait_lock is released
>    * - woken process blocks are discarded from the list after having 
> task zeroed
>    * - writers are only marked woken if downgrading is false
> - *
> - * Implies rwsem_del_waiter() for all woken readers.
>    */
>   static void rwsem_mark_wake(struct rw_semaphore *sem,
>                   enum rwsem_wake_type wake_type,
> @@ -515,25 +491,18 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>        adjustment = woken * RWSEM_READER_BIAS - adjustment;
>       lockevent_cond_inc(rwsem_wake_reader, woken);
> -
> -    oldcount = atomic_long_read(&sem->count);
>       if (list_empty(&sem->wait_list)) {
> -        /*
> -         * Combined with list_move_tail() above, this implies
> -         * rwsem_del_waiter().
> -         */
> +        /* hit end of list above */
>           adjustment -= RWSEM_FLAG_WAITERS;
> -        if (oldcount & RWSEM_FLAG_HANDOFF)
> -            adjustment -= RWSEM_FLAG_HANDOFF;
> -    } else if (woken) {
> -        /*
> -         * When we've woken a reader, we no longer need to force
> -         * writers to give up the lock and we can clear HANDOFF.
> -         */
> -        if (oldcount & RWSEM_FLAG_HANDOFF)
> -            adjustment -= RWSEM_FLAG_HANDOFF;
>       }
>   +    /*
> +     * When we've woken a reader, we no longer need to force writers
> +     * to give up the lock and we can clear HANDOFF.
> +     */
> +    if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
> +        adjustment -= RWSEM_FLAG_HANDOFF;
> +
>       if (adjustment)
>           atomic_long_add(adjustment, &sem->count);
>   @@ -564,12 +533,12 @@ static void rwsem_mark_wake(struct rw_semaphore 
> *sem,
>    * race conditions between checking the rwsem wait list and setting the
>    * sem->count accordingly.
>    *
> - * Implies rwsem_del_waiter() on success.
> + * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
> + * bit is set or the lock is acquired with handoff bit cleared.
>    */
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> -                    struct rwsem_waiter *waiter)
> +                    enum writer_wait_state wstate)
>   {
> -    bool first = rwsem_first_waiter(sem) == waiter;
>       long count, new;
>        lockdep_assert_held(&sem->wait_lock);
> @@ -578,19 +547,13 @@ static inline bool rwsem_try_write_lock(struct 
> rw_semaphore *sem,
>       do {
>           bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   -        if (has_handoff) {
> -            if (!first)
> -                return false;
> -
> -            /* First waiter inherits a previously set handoff bit */
> -            waiter->handoff_set = true;
> -        }
> +        if (has_handoff && wstate == WRITER_NOT_FIRST)
> +            return false;
>            new = count;
>            if (count & RWSEM_LOCK_MASK) {
> -            if (has_handoff || (!rt_task(waiter->task) &&
> -                        !time_after(jiffies, waiter->timeout)))
> +            if (has_handoff || (wstate != WRITER_HANDOFF))
>                   return false;
>                new |= RWSEM_FLAG_HANDOFF;
> @@ -607,17 +570,9 @@ static inline bool rwsem_try_write_lock(struct 
> rw_semaphore *sem,
>        * We have either acquired the lock with handoff bit cleared or
>        * set the handoff bit.
>        */
> -    if (new & RWSEM_FLAG_HANDOFF) {
> -        waiter->handoff_set = true;
> -        lockevent_inc(rwsem_wlock_handoff);
> +    if (new & RWSEM_FLAG_HANDOFF)
>           return false;
> -    }
>   -    /*
> -     * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
> -     * success.
> -     */
> -    list_del(&waiter->list);
>       rwsem_set_owner(sem);
>       return true;
>   }
> @@ -998,7 +953,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, 
> long count, unsigned int stat
>           }
>           adjustment += RWSEM_FLAG_WAITERS;
>       }
> -    rwsem_add_waiter(sem, &waiter);
> +    list_add_tail(&waiter.list, &sem->wait_list);
>        /* we're now waiting on the lock, but no longer actively locking */
>       count = atomic_long_add_return(adjustment, &sem->count);
> @@ -1044,7 +999,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, 
> long count, unsigned int stat
>       return sem;
>    out_nolock:
> -    rwsem_del_waiter(sem, &waiter);
> +    list_del(&waiter.list);
> +    if (list_empty(&sem->wait_list)) {
> +        atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
> +                   &sem->count);
> +    }
>       raw_spin_unlock_irq(&sem->wait_lock);
>       __set_current_state(TASK_RUNNING);
>       lockevent_inc(rwsem_rlock_fail);
> @@ -1058,7 +1017,9 @@ static struct rw_semaphore *
>   rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   {
>       long count;
> +    enum writer_wait_state wstate;
>       struct rwsem_waiter waiter;
> +    struct rw_semaphore *ret = sem;
>       DEFINE_WAKE_Q(wake_q);
>        /* do optimistic spinning and steal lock if possible */
> @@ -1074,13 +1035,16 @@ rwsem_down_write_slowpath(struct rw_semaphore 
> *sem, int state)
>       waiter.task = current;
>       waiter.type = RWSEM_WAITING_FOR_WRITE;
>       waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> -    waiter.handoff_set = false;
>        raw_spin_lock_irq(&sem->wait_lock);
> -    rwsem_add_waiter(sem, &waiter);
> +
> +    /* account for this before adding a new element to the list */
> +    wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : 
> WRITER_NOT_FIRST;
> +
> +    list_add_tail(&waiter.list, &sem->wait_list);
>        /* we're now waiting on the lock */
> -    if (rwsem_first_waiter(sem) != &waiter) {
> +    if (wstate == WRITER_NOT_FIRST) {
>           count = atomic_long_read(&sem->count);
>            /*
> @@ -1116,16 +1080,13 @@ rwsem_down_write_slowpath(struct rw_semaphore 
> *sem, int state)
>       /* wait until we successfully acquire the lock */
>       set_current_state(state);
>       for (;;) {
> -        if (rwsem_try_write_lock(sem, &waiter)) {
> +        if (rwsem_try_write_lock(sem, wstate)) {
>               /* rwsem_try_write_lock() implies ACQUIRE on success */
>               break;
>           }
>            raw_spin_unlock_irq(&sem->wait_lock);
>   -        if (signal_pending_state(state, current))
> -            goto out_nolock;
> -
>           /*
>            * After setting the handoff bit and failing to acquire
>            * the lock, attempt to spin on owner to accelerate lock
> @@ -1134,7 +1095,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
> *sem, int state)
>            * In this case, we attempt to acquire the lock again
>            * without sleeping.
>            */
> -        if (waiter.handoff_set) {
> +        if (wstate == WRITER_HANDOFF) {
>               enum owner_state owner_state;
>                preempt_disable();
> @@ -1145,26 +1106,66 @@ rwsem_down_write_slowpath(struct rw_semaphore 
> *sem, int state)
>                   goto trylock_again;
>           }
>   -        schedule();
> -        lockevent_inc(rwsem_sleep_writer);
> -        set_current_state(state);
> +        /* Block until there are no active lockers. */
> +        for (;;) {
> +            if (signal_pending_state(state, current))
> +                goto out_nolock;
> +
> +            schedule();
> +            lockevent_inc(rwsem_sleep_writer);
> +            set_current_state(state);
> +            /*
> +             * If HANDOFF bit is set, unconditionally do
> +             * a trylock.
> +             */
> +            if (wstate == WRITER_HANDOFF)
> +                break;
> +
> +            if ((wstate == WRITER_NOT_FIRST) &&
> +                (rwsem_first_waiter(sem) == &waiter))
> +                wstate = WRITER_FIRST;
> +
> +            count = atomic_long_read(&sem->count);
> +            if (!(count & RWSEM_LOCK_MASK))
> +                break;
> +
> +            /*
> +             * The setting of the handoff bit is deferred
> +             * until rwsem_try_write_lock() is called.
> +             */
> +            if ((wstate == WRITER_FIRST) && (rt_task(current) ||
> +                time_after(jiffies, waiter.timeout))) {
> +                wstate = WRITER_HANDOFF;
> +                lockevent_inc(rwsem_wlock_handoff);
> +                break;
> +            }
> +        }
>   trylock_again:
>           raw_spin_lock_irq(&sem->wait_lock);
>       }
>       __set_current_state(TASK_RUNNING);
> +    list_del(&waiter.list);
>       raw_spin_unlock_irq(&sem->wait_lock);
>       lockevent_inc(rwsem_wlock);
> -    return sem;
> +
> +    return ret;
>    out_nolock:
>       __set_current_state(TASK_RUNNING);
>       raw_spin_lock_irq(&sem->wait_lock);
> -    rwsem_del_waiter(sem, &waiter);
> -    if (!list_empty(&sem->wait_list))
> +    list_del(&waiter.list);
> +
> +    if (unlikely(wstate == WRITER_HANDOFF))
> +        atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
> +
> +    if (list_empty(&sem->wait_list))
> +        atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
> +    else
>           rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>       raw_spin_unlock_irq(&sem->wait_lock);
>       wake_up_q(&wake_q);
>       lockevent_inc(rwsem_wlock_fail);
> +
>       return ERR_PTR(-EINTR);
>   }
>   -- 2.31.1
> 

