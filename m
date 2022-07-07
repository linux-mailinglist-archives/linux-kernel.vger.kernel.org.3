Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7E56A302
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiGGM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiGGM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:57:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651745061
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:56:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267C9QN7003283;
        Thu, 7 Jul 2022 12:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=FpLzWiJ2fp/RFRXmNRUuc7u9kzoKQB21K4icXntg8lYaSuDva6hpHLpaNPX0ETJclFLs
 OiBbeTxMqv6HUWlqPxy7Xw34m8i+GAlJtWX54MV2d0akV5zMj8FiqftiENYJexuBdHT1
 Uv4O7IHNaumUNFjIgtlpbzoUrwqM0kNQCjaFOfjb4yO4fcSdbnvgi1DneWJ0C895pDOU
 VZE3x5nZux6D4eq/z26vXu4D/P9a/dLx+IDV76ljviV4YG+miEEbRQLaiLWssdJciE6C
 MTctk3b77Ha3rBNG8/KGtgst/Ls29UiTnWpOL/FrN0KAef0nmjA21lAezv5QKtl8jjOv GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubycu9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 12:56:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267CtLBo020006;
        Thu, 7 Jul 2022 12:56:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6xx2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 12:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/bome66/hLaQjVC0m02A8qgWasTptKr9/03cAYRhyFrKXPHOoIU3TWE9INsVPLrHCbdrB2yklVzpVU+IJxaYQRBrChNFi99sWDj122SQ/vC+mz+W7QrsbH1qqCy9uqNP9ll7I+ihybkWuvTchaRlL3T8614pXDblkNOqdQSXYExO1SuxLXEoqSkcb4fUTNFUXabnTsCL8v9uDc4bJDObZlfW8b4+kmwoGkKQ2lpKGYnsId+AV02dO965AYb6HgdCkUrGPNlLuacVGawejpFNwDIAhdprQc7aqPC8lt3PiBxANmKZzdWbqsHb5V8QujLXDd7kX8Hwn8IzSl3KXCcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=b83re8AP3lESSPOb6JTgIfkS3KGyijxopSUxtkStJLVAPUB++5U/ncryF/CMGPehRGjvswieA66rSzwSdfAJg6qsk87felYKSEaYOevBXLGPSwP+1m3E/yRTBB301aBoRs7SJv9YsaZrUWxG+JST/xshdUYwM+BSUHLWgmBLZBptGTgksjPtnYkSIhcvC0HyPOsNTGGv5VMLAGTlv6Z8dt6oKH0SC9xWUvaQrbL+zDt9YOxT+wsDzJxhtaLVUGD57EuDB4eB5r7XxJCAP048/FLXpEjAmCZD41m55rYl26WjztK4yCkxomwcdOtqbmMjmky/CYehHMZTBIvZySZHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naow4A28O4bqlCscqEkfabSE2AkbTvkiBXstQ0A9U0Y=;
 b=y7b4baxF7873RmgJtTQKe1n6QArstCBnnyx1fOQaGjTjjLNDmzPEavsH0oftOFinOUkoHtLcPPjnDzdhN3L8ez2LFNmN35iCQs8iIB8lCFnjpeWU8jKgug6BkCNNKgLwLMwJ1jgpYGwjQy4Ezj+Ff8F5j/jXUohOUuTxK/JEU/g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 12:56:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:56:00 +0000
Message-ID: <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
Date:   Thu, 7 Jul 2022 07:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:805:66::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e6c365-3a3a-42ee-033c-08da60180ab5
X-MS-TrafficTypeDiagnostic: CH2PR10MB4133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3FuVcSGVR4BRu1S+euT/oZu2qlA3zpucsp1xz8e0bFA0las/6MF+4GkY2lzy/IXIt11rXSlTrgtNCy3wWQPMI9Yrv/mRE+zlqjPAz6OWMGQOgSi2ckMqkwVas4WKtBNdn1FmwY0/UaQ45WSq530txONfqNEKs98S0xUIgMaE3muE6VGSLK4vY7IopidYz3gStA2PN/fXWI+vEBG1fJH08onSeXQTl4yBrRUPlJ0ve9+xkRV7YIedFS6Mz4FKFP4TFOX878bbgkKUWRAl2L7Sfdle/KJ1rAw109cX0RrT2LPfE+JlYBZbGYQCpB2zW8TD33HYgA+rfgoRoF8M/NevSqLFcA94nhvGEQ/MXyB6SvBP3Yl9tK0XKPUyetzogmKf8fbHAS/ukVYaoIr+Y8s0sFFYKoAADFRmYaXTj3AqC3eKUYVlSRzPbg7mkprAkf4mRWfEA83Hav5rYFO36kugJeRaWzH/QfC1p8MM143SNzigERRkOyxiwjfTBSkit8+KFv4ocVwCdQdkHcTarJoYumEppMGI39o09Z2u70E2opqlw9sMFkgzhcheWBSBWJABVBOGPYzEY79Tq/K11rveoX10q5DgPZ8z4++2a9ziHCGWufAjqLdIaEqz9LqBqIul4dH3oiCbHPstI4iQ8ULzrMAnstTQwhyjwjpnqa5BFJjHt2P5d4r3wSqakfv+jV0G2jSmsY9NKb/uU7nXg9D4dUYDMYdjhuzwyshhfVHF5cy/cZ1lwndbmsz57fKVGt9BunMY39LriVyjcAqqz2TJc2O8n5LM7IF9iKpSEAapOUKfxHnAz5k0fl4nnhZ/eZoVzywmHzeSowFdgPvX6wRmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(366004)(136003)(66476007)(4326008)(6512007)(66556008)(66946007)(7416002)(478600001)(83380400001)(5660300002)(6486002)(2906002)(41300700001)(2616005)(8936002)(107886003)(8676002)(186003)(316002)(6506007)(36756003)(31686004)(38100700002)(53546011)(31696002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWY2ZzFkTWFhQ253T0dvRnNhckFvNVV1WUp6dWZGWTcrZGN4Z05mMnFUY2Rn?=
 =?utf-8?B?bVZCZFBzUFc2OE9NMzF3TERnOVlkRlFqdmoxamlZYjZrWWZOWG5uQlBTUWdr?=
 =?utf-8?B?NEpEcnBqRWU5SmQxaDVOY3pPdlhTb0ZVbHAvOGVzMWR6a3lFUTRxVE42b28y?=
 =?utf-8?B?MkdveHM3ZlcyTHRIZGk5TUhCWS9keHVRNUNjanVCNTM0Yk9mcithQkdvMnhy?=
 =?utf-8?B?NU1ZSkhSaU9la1VsMFNoYkdidWc3RXFQUUJFczZUOHFZbUNQWVBUUXI5M1B5?=
 =?utf-8?B?THkydHkvZHU5MUkxWHVWaE1kdmU5eFVOanE3VXhtYmtscEJkNGxVUHplSEVE?=
 =?utf-8?B?dkJFNm5hcHJvK0lVblB2L0V6aEVsT0dPaUEwT2VUU3phVFhKNW5zcVFka2JO?=
 =?utf-8?B?L21WM2djNlo0Y0tiWTYvbHMyeW5ZVlFEYjkvNWJNaENIeG9aalFVWFNUMmJl?=
 =?utf-8?B?S3F3RmpmTS8vL1lzUk1TZTYwWnVJS1M3VG1GaFdqblIvRkNqNUk3aVBKRWEv?=
 =?utf-8?B?MnZ1cVA3SWRxeTRiQTZzd0g2MTFWUllLSGVsYnY3L1lsM0gxbVd6SUs3cWdZ?=
 =?utf-8?B?Z0E1R1Q0UGxnLy9wM2tqMzNoZWJWSXNrTjR0NUt2aWh1YVhjN0FGWjNoNVRB?=
 =?utf-8?B?UnZNTVl6ZEp5ZTBMcEdURkZSK2xFb3BLUjlRVFVpL2tsajU5RDdaRlZKeXF4?=
 =?utf-8?B?ZGRGRS9peUIwaVVmdjhrWnBTRkhBcWtmY1h2Z1U3dmFZNkFaWE9zWEVGQXRi?=
 =?utf-8?B?Q2NHaTFiUXZkMUora3Bkb0ZzNk41TTh4aGx3M0hXVlBXZWNnejZBak9ZU2ZB?=
 =?utf-8?B?d1FQYjBYTnhMNkE1cThIbWd2L3pSZFdoYVVjZjZJMlhxSmc3cVRsWWZ1Ykll?=
 =?utf-8?B?SHRzb004VUVVY1QvdFJtUVNaaWgxSE9QcUtqOWxmWXZzQmNsMmgrQTJWMFNB?=
 =?utf-8?B?MHg4bHRPUm5sVU1PemdpaXBPQjBjcHZtOVFQUlI2RFlpajErSlFVc21xWUFP?=
 =?utf-8?B?eXdtY3hHVERCb2x6TFlGd0VuazhPcVRmQjdHTnd3V0s0TXJETnFRQUF6K29Q?=
 =?utf-8?B?VTFjcmlmbWhFS1F6blB0U0dxK25acVdqTE5BSmlzV1RXZHdMUE4wajFNNTB6?=
 =?utf-8?B?K3N4UVpHV0FuVHJQUVVBbHpuT1RpeWJBdTAzczRhNVNkODF2YTJWSHpiWXhN?=
 =?utf-8?B?b3Jhc0U5d0g3aHFiajZwK2toR0ltNDJKUlNUY3EzMmxQTU53dnpXSEswWll2?=
 =?utf-8?B?S3lKVmxvem1ReHEzRHZYTndvZDFLREMrM2FsUCs1b3BTL1hiVXF6ZngvdGpH?=
 =?utf-8?B?S3ZyNGlCYVk1dTZZQTJwbUJGOU0yV2t1NXljM25sK29MRFZGMUp6R2dXQVRL?=
 =?utf-8?B?eE5OS2g1YWp2a3NycWJjcG02WTR2RVBJcTMva0xWNWJFZEIydVVNUCsxVEgw?=
 =?utf-8?B?eDZIVEhFdkdLQjcwcGx6YzQ4bDJSQ1orUGhObmFRRmRwVysyWjk5UHUwcTZj?=
 =?utf-8?B?NFhhYjlZdDhhc2JXYU41UmdIOUdJYjNYb0c5OGI0eWFQWUswYzJUd1oxS0VK?=
 =?utf-8?B?a3FaYzlXa1IzK2JwZkhlc0R0WFgvcldNN2pNazNOVlNZdWhsVjNmUkNmR1dO?=
 =?utf-8?B?cWhBVU1DRU5BZHNvVVlGMGd4WStIYUp1eEE3c1NMc3BRNDNnNkVpT0pMRldI?=
 =?utf-8?B?cEJVTGlzUktnNERCbTNtTWQwblNyZDIwMWp2c3h5VHFmeW9GamFhOW81dlBy?=
 =?utf-8?B?bHZTN2xFVHBDRWZkOWU3azA3YmhKb2Uvb3U2b091YzB6L1NtV3FaNFNja2RP?=
 =?utf-8?B?M2swRnFmS0hOR3hiU2drMkhpK040ZEpVUGRsa3RhTEQ3dCtmTlNvQXBHNXND?=
 =?utf-8?B?SEVoSnpyQVQ1TGdCcEJwZkFKaEtEN291aGhuenRHbkZGTW1pbmhRUDBDWVdL?=
 =?utf-8?B?ZG1ma2lYQmRRMXBDcnhaRFZqU1BlWFZuRTNVdmpGL3ZaQ0JGSHlYc2RYRTZQ?=
 =?utf-8?B?dUNqYWlZWXdvd0RWZHF0MFBjcmtYSHVyL1hyekxTUkkwa1FEY0NqOWt5cFkx?=
 =?utf-8?B?V2VvY3gwbi8ya0E4cVgrSmdUOFdHNEtYc2tObVNsUm1Bai8rVG03eFpkTS9m?=
 =?utf-8?B?ZWdmNjFVRmZSeGl3L2tYc3l0TzBXZm42bDlDeWU5eGFYcnc2alhjU2xWTlhB?=
 =?utf-8?Q?8pnrBXdV0Cn74VMnJlMP8jw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e6c365-3a3a-42ee-033c-08da60180ab5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:56:00.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3wQyvQehqdD8U6DDPV8wNPfc/r89qgN+TX2WNVFhsCbOPLoBJIxWX1vzqRzPtdp/5M8LkfMayEKjeViW2RVxufTEmybsJqx7hRJKZk8vDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_09:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070052
X-Proofpoint-GUID: OogTfvsNkn7Svi56CKYSxhuDoV9_B92y
X-Proofpoint-ORIG-GUID: OogTfvsNkn7Svi56CKYSxhuDoV9_B92y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/22 00:06, Sourabh Jain wrote:
> Hello Eric,
> 
> On 14/06/22 04:12, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> When loading the crash kernel via kexec_load or kexec_file_load,
>> the elfcorehdr is identified at run time in
>> crash_core:handle_hotplug_event().
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. The kexec_load is also supported, but also
>> requires a corresponding change to userspace kexec-tools.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig        |  11 ++++
>>   arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 127 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 762a0b6ab8b6..e9eecff3b97d 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
>>         (CONFIG_RELOCATABLE=y).
>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_MAX_MEMORY_RANGES
>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +    int
>> +    default 32768
>> +    help
>> +      For the kexec_file_load path, specify the maximum number of
>> +      memory regions, eg. as represented by the 'System RAM' entries
>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +      size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>       bool "kexec jump"
>>       depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..b9cdf7a0d868 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>       image->elf_headers = kbuf.buffer;
>>       image->elf_headers_sz = kbuf.bufsz;
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>> +    kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>> +    /* For marking as usable to crash kernel */
>> +    image->elf_headers_sz = kbuf.memsz;
>> +    /* Record the index of the elfcorehdr segment */
>> +    image->elfcorehdr_index = image->nr_segments;
>> +    image->elfcorehdr_index_valid = true;
>> +#else
>>       kbuf.memsz = kbuf.bufsz;
>> +#endif
>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>       ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
>>       return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +int crash_hotplug_support(void) { return 1; }
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +    /*
>> +     * NOTE: The addresses and sizes passed to this routine have
>> +     * already been fully aligned on page boundaries. There is no
>> +     * need for massaging the address or size.
>> +     */
>> +    void *ptr = NULL;
>> +
>> +    /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +    if (size > 0) {
>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +        ptr = kmap(page);
>> +    }
>> +
>> +    return ptr;
>> +}
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +    if (ptr) {
>> +        if (*ptr)
>> +            kunmap(*ptr);
>> +        *ptr = NULL;
>> +    }
>> +}
> 
> Aren't arch will have build issue if arch_[un]map_crash_pages methods are not defined?
Sourabh,
Yes, you are correct. I'll add __weak versions of each in crash_core.c in the next patch.
Thanks!
Eric

> 
> Thanks,
> Sourabh Jain
> 
