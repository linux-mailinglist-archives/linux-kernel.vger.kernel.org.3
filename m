Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA08525228
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354179AbiELQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356292AbiELQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F232EC1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:10:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CDvdGo010355;
        Thu, 12 May 2022 16:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/pHd5qBcKaAHZgfiRARtCy3q8gww7nH7ws5wSQoILb4=;
 b=EkYCsTXVoJSPioTcWTw8tTUZtBat/P9E+2+d6jTDbKUGmoIP+tR12U0XDmDy8uwKRvuf
 /6W9MmEiiSsmGmvL/nf6xz2XnhNk0RZZozPs0hUkTwlajWJ8wIGGC0ujapNCd+hVQEVm
 WQ9mgwIVrSMdYg5MxuBagtRYQj03Ca2UtJb7Ngy95nBEsEmMVwJfJXZo9e2cL6IV7flZ
 OAY4LUUbsgcW4TT8Eda6/rAWNOL0HI2cewGJg5VSDVSi4ZEXkeztLDlRV2fDQBx1UBMJ
 DAuoImLsi0VGAIlGNChpzsIavctLhVfdfuyWjwcRnNYlhMlgXUgL8iTDA4oe/nPdikV4 iA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6ccw1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:10:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CG5qEL023393;
        Thu, 12 May 2022 16:10:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7bywek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/l5wfEC3hSraXKCB2OEJHKBQ9qAuebafEqQpbJRKYyIEO9+++4rJFlJsoEl2a14rzUE/UGgoemarqFlQvrpljIRfL5rMZqXSRpTcQfJneGe1SKOJhy4VavelscOHarmKIM8fYqlcxllLZup1ma6hPYr3rd5LIN1Bl8BsXpTF4KRkY2pSV9vFg1r1TTz+jxwoRdcO2AkkL5pdQcFibhQkdP9yu4hAplx9qB7Rowlp2YdnQTeUVQ8LazmstiUR90Egrd6S8Kz5mHm9O+RfKy5kHZOHxWQje3WQjFLXjOrgsgoJD5O+eRNqSqhbteQ0IKYNgm/h8+J8rO9FGcQm28UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pHd5qBcKaAHZgfiRARtCy3q8gww7nH7ws5wSQoILb4=;
 b=GT7D6hkBuoNrtcT+HIDcwlKRYc8PrrAhyt6xAMaPlF4i34KMdsNMy1ljLIdRcoxbtBVpiQEhQzH39YdGbdRJX9FTTKltSVErZdWJ8uZtgWdP8fcJSLe6+h+fjVHOsWNXsZ1jCMn07RBgOFJoYpxHBv9BDw300iGlrB26TOBPg3/ncQoPeFMtCVlL5GwgyT6Rice4mFtL7lHu/vVK1gd86Bhv81IDy1DC8Q5hT0L+MLQRuSTWqLd20YJAGxNW9lhs5fgTdH6XQnU9yrq8qaDgI8+M5FcBTBShfP+GxBZOs65jy+dbrSzkxCtRokbT8iCFthKyWMbOVf6HfxkKQkxztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pHd5qBcKaAHZgfiRARtCy3q8gww7nH7ws5wSQoILb4=;
 b=bifOiYezrlAwyDPut79Yjb5K485ZXF4E+bAko13NLGQyZnqIUKb8zX7dXQv2DpAzu0HK/e+1RPJ2YF5VLpBE0fcnvRmrRNUsOFRdJaQCtr5A+OC7JhLQVxMCH2azBCxh6okp8zCmLUUQGK/kyluxXKnmhCD/HFXxIrmNlMoKC6I=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5375.namprd10.prod.outlook.com (2603:10b6:5:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 16:10:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 16:10:16 +0000
Message-ID: <093ebfa2-9584-ab89-9d52-f21b2841ec56@oracle.com>
Date:   Thu, 12 May 2022 11:10:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 2/7] crash: prototype change for
 crash_prepare_elf64_headers
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-3-eric.devolder@oracle.com>
 <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37baca51-35f9-4bd4-7004-08da3431e6ea
X-MS-TrafficTypeDiagnostic: DS7PR10MB5375:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53750BA339A9B6EF0E5DDB2697CB9@DS7PR10MB5375.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRTJveaA7oJVW+0AWdeee8xZhILDGN2EnfcXobkfpittIU/kgKb7fqsbO36o+ILIbCpCLPJQ/YJT/+L2FB9poVjNn6Xk6ND7nnnKYTXdropPPwcAwF9hxAC2xTLzJfqLAKaTTC4LvaoSEkZmNhA4wL1dE+BZNKxWZim2+aN5Lwr1oWV0BEO9zLsONGCJAHvb32SNZ57dSQUwBHd8ef2Nh4Tg08nJdVC1297jc3t/gXhDZghnPfYkw1CPh58Jh1OovmybwmCQlOOQsb1jzZfZYVjVMfr6CI67MSwHQlQZ0Q2vNfoiCLtKOj/jNU1MAg4FgmeSCIN/WHJmGUSFxJP+A3HRCXtNq+yndfzulqA4GVTuAlRFvuzM9UVpIqwdflIcXvnpD+d0olVrKdjbwx3OgYe5GYWxhcH1QNYwzQPkNH1g+1xW7LWbPh93A0QuCAj12NZObPHpPBu4e9kcxO1naG5umyogrc9h7k7MK3GZ8gX3Q/5GeTVptuTJJwpyAOXcCbmt6LKilW0aKll91UiveoJUHwjf8Ii8+nf+eUXHs5wKVIatK82Z0u3EP7Fr6WwzMCV8AlPzP47CV0juNZfaexAcP6nDBlIbnW6iu9/BwlZtCiyr3uKc5CLI0sFolfptIzBXG1jOwNRFLparVD8EUD5i0Veo+gGpYZW8oe3CoPHi/+SzIb76cl+ElqY63NTqbL6Qf+pJLJAiBd59u0zwFqAgpR5eoLcQUg1YOzQGdes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(6486002)(86362001)(186003)(7416002)(31696002)(8936002)(38100700002)(508600001)(83380400001)(316002)(2616005)(5660300002)(107886003)(4326008)(6512007)(6506007)(53546011)(6666004)(8676002)(4744005)(36756003)(2906002)(31686004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lvNHhudzh3ZUhxWSthZ3FPd1ZzNDJrWkdTeXhjdWZNV3lCQVpud2dFa2o1?=
 =?utf-8?B?S2J1cUxxUWxwV2NreEZpdEVJQWZRMGFaMCtDL3BCS0ZNbVJpRk1EV1VnRjhz?=
 =?utf-8?B?bXEycUR1aTBvRWV6RGFBYzcwQTQybjRnckRIUkxGaWRPSzQ1WWtOeThzNmtr?=
 =?utf-8?B?dVRMR2ZncnZUYjhvM2lPT2V4a3lnQ083M0FCYzU1NFIycFdrdy9KL1ZJOC94?=
 =?utf-8?B?K3dqNzc2ZlpDSUJVT2szNEkvclp2VFZ6aWNFVlVJMWUxVEIzUXJ4NkpwVG0y?=
 =?utf-8?B?TVFOUjdYbnF0MW92Vkk1eG1ETENiUkhHd1MzZ2VOSmxYbGxQR3d6K0pWc1dV?=
 =?utf-8?B?QWRhRmdQYmh2b0NqanV3enBnZkt3Y09jTTlYeDY4WHJmVzhMNGtNbnE4SEg4?=
 =?utf-8?B?Zk9UaldodU1BTk9nakMreVVaTmczbUdRWnhFbUtCU01CNVMyU2Znc1BZTWJ0?=
 =?utf-8?B?d2kwTUhtWXNFRTdGbDFBQWVwbjFDRWhudVYxRHBiQ2VVdzMxL25mNXpRdExR?=
 =?utf-8?B?bERNcUpqbWVvQW1aVVdDeVRPVWw5eUtDWkxkZFlYamlMclBRV1laWlQ4Z01z?=
 =?utf-8?B?NUZSV2dXY3M3NU4xRjd0ZVNwUWFqR1R2c2FYRFd1YjJOV2ZQQy9CQ2JFYzFp?=
 =?utf-8?B?SHMzZ0U2QnY4NFhRaURDL2N6RnR5dU9PTUFhcEtIek1tdWQ2UmRCWjg3ME03?=
 =?utf-8?B?amVtYTlxMTIzZDRBNzBwSjE3WDV2c0c2Ui81YVdPaFV3b1pYSzltUmVyMFZM?=
 =?utf-8?B?Vi9QN3JHRmxqWENWeHFnRThWQ2k5Sk9DeE1JWThDYVI5akE0czJEQ3oySEEr?=
 =?utf-8?B?MGY0MWM0bDlaLy9KajduZndKeXJHRmxJRmxtcG9STndUQURlakVPbFRRaFdS?=
 =?utf-8?B?TGsrV2wwVG12djJjSEFoMTNSTy9GVG4ydEJDeWI1ejMwaVM0SWFBSTQvbzhs?=
 =?utf-8?B?ekxhYlN5OXE5N3ZkSU9WeHFCdnYyak5Da1VvM2EwWFpKQmNob3UxeGxJSk4v?=
 =?utf-8?B?Y3JVc3U2UXNGcVI4YlUzNTJPVC83dGIzbGZpbG1mOVJsRmhsTzR6Q2lrYVZs?=
 =?utf-8?B?QUhtdERiWXRrZHhnSVZoaVliWFhMNnl4RzRCam9HRVZmaGZQRVVuVUFPNkg1?=
 =?utf-8?B?VUh1NzNuKy80dnYyeElMK04zZkpIWFMyb0NvNU9xSmsranBQVmhoSXpwdjJQ?=
 =?utf-8?B?WmVmSkRTYm90YVA0TXVzR3MxeU9rZU96cEZTeW1xSXZrSDk1TXlDNkQvZU4z?=
 =?utf-8?B?TjRjK0UxNU9jYVI2VGJiS2s5YjMrcTg2dGdZa21pNTFHdTVBZlVtcmpUQndT?=
 =?utf-8?B?bXdPbmpaZmRrVlBKbWRiVVB6ZUswNy85TnczMjJ4dlpWUEQzc3cvODE5MmRS?=
 =?utf-8?B?N0Y1SnYvMVkyaEN0L1VBeG5yY2Ztd05pdTFySjl6YWM5dE16OENrb0U5S1RI?=
 =?utf-8?B?YUYxbUREdUJSc1VpSGJ0M0hOUElnVjV4RjhkQ1hzdkVqVTBrWWkwYzZmb0xy?=
 =?utf-8?B?OTRJZzVlY1NYakhZbzVxU05TaHAyc2hNZHB1OTBxTWlkeTRPd2FBOXJQMUZi?=
 =?utf-8?B?R1FzcnVaZXB5K1NMN0x5NHlDS0N5TEZWUy9PLzBtSWt5L1IxUFdPWSswc2d2?=
 =?utf-8?B?anRleldaczgrR1JlM0R1UXRlNkwvT2xoYXc2bUF2L2hJTVZ0UjN0azRzT2VD?=
 =?utf-8?B?bXdQNHAwMU9aTGhKbjRTSFlxUDl2QVpQZW02ZzNnSUc1SjJQdUVxMjVFSk9k?=
 =?utf-8?B?TThNdklrcGlFdENmSGJlVm1GNmgrMDZUeTlpdDlPZWVQVjhVampQU09pTTZr?=
 =?utf-8?B?SmEwZFdSR09xaThCSEcwL2ZJL1RZUmJ4ZUM0cXpvZWVwakQ2Z1BjcmJ3NWhp?=
 =?utf-8?B?NzV0L2VWWGc0VkN6L0VKM1hKdGZkcWxIaTh1clNqaTl1b1ZqbFpSYlJnWGRY?=
 =?utf-8?B?WmFiM3oySEprYzRMYUVvOUswSDI4eDUydS9OYkNXY0ZLbjMwcHJCd05iQXVq?=
 =?utf-8?B?ZU1RczhDSEtlNzM0am9kUnJadWtpTmtNSjZpdktZdlZuV2M5Q2JpMXBJRVhM?=
 =?utf-8?B?SUtRUHJkSEcrNU1QcW5KZVp3VGk3ellmR2oyT2tEZWNHeTFaelo4RktLaUhj?=
 =?utf-8?B?QUJGeHpSWWhFeE9oN2hLV0k2Smw1YVJvc2t2aU5KOVplbWRMY3VMNmtWcFZu?=
 =?utf-8?B?a3FBN1M1ZFA3alowWlJmNFlZNFh5TUcxZStWNVkwZVhvMUF2dGQ2cXZjcGwx?=
 =?utf-8?B?RFdrcERyV0U1K3VCRzB3WmNLM2Rpc1BScUJabzVpWllMdnFvTmVTVEg3a3Bk?=
 =?utf-8?B?aGtvVGlGRWsyNGlrZjd1Q3pWbFpGOHFUMDlhYXZtWWtBbkRJMjV3WWRUQ3JR?=
 =?utf-8?Q?Ps1YZLJvqiP2oSVpihDy0WxeRlWvIgRnb+G/4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37baca51-35f9-4bd4-7004-08da3431e6ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:10:16.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVOB3oaMzxCRFWvpoZ52dWowKdIpX4z9ldaivsqMybcnwICrpAJGLomLGgEl8nMCDsuHYxO1a4SrgnP/j/JcHQcwm3PGQ2AnGoYz5vNIYKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5375
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_09:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120076
X-Proofpoint-ORIG-GUID: DONibuQf_tLnJ4WPeoe_NpLuaX4d_97A
X-Proofpoint-GUID: DONibuQf_tLnJ4WPeoe_NpLuaX4d_97A
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/22 03:42, David Hildenbrand wrote:
> On 05.05.22 20:45, Eric DeVolder wrote:
>>  From within crash_prepare_elf64_headers() there is a need to
>> reference the struct kimage hotplug members. As such, this
>> change passes the struct kimage as a parameter to the
>> crash_prepare_elf64_headers().
> 
> You should make it clearer that the hotplug members will be added by
> successive patches.
I've tweaked the commit message to indicate as such.

> 
>>
>> This is preparation for later patch, no functionality change.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you!
eric

> 
