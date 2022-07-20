Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8B57BE46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiGTTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGTTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:09:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883EC655BF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:09:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGcpfj024998;
        Wed, 20 Jul 2022 19:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gIYXdiU248RxK5fhAQkgPo13CDuvw4UYSzuTX+68xz8=;
 b=Q8LWn/vejP2Zx9irsH+mvpzMQHe8DkcwqJooaCWgMG6APVzUOcNPoVUjhtRczGXs4rpP
 f3H3uHQoWbN5byAW9/UdVGppCJ+n71uCymWL5gabk5EVFQxqRLiwmQJyOPiOqM9vHE0G
 QnISuisK62Ghofkr6RoVmesoWsaipn2fp0LW3o3fZPCLnF87zq208+kwyvlsvejoVDAb
 4RHnjOYtTQii2+2eFWWT5QwnH8i+8acD/p4W6hEcUYJLyPgWkpuFBhZHkQDWJU4NnGw7
 la+h9kq65G6cv+WvT9OPWQqVo5O0OBoXalQQ256bP0vLhktpB/1QiXNsivrKh7GjGPxb ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtjjwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 19:08:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KHK5F7039235;
        Wed, 20 Jul 2022 19:08:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k5x0mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 19:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2AmGVYk3Lsb2Qam/nBqMkcnDSL0mkwsMZXqC1FPB1S5rYE0cOw3AW3Ckx+C/IgSz4lrMqSxflaQDaHVJkvcSvnK4zxIRZFXFpUmFf+hHdXZe9xTEbKz4iM8ZyiIRGnxtluL5r3fgNyLE7wENHbm2lYdZMDz6lLyKyOSmLitWAS+yIt2CJ1YXvMMqmD3aRaATqpS5eEdjyExzxfXZbk3T/kLK7V4LLy0Yhf4wHHamm+T6sXXBwtFNLLFsd85b0lX4kZPtWXKyFrekrp4tdXwWmZTgCUkVYaby9JHnIyoVQxWN5TcF60e4hc3xk8PLznQdtgk5WLsyg8HgKQIa1IA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIYXdiU248RxK5fhAQkgPo13CDuvw4UYSzuTX+68xz8=;
 b=nr2YTFv18jWoAXearse52uR191iKURSJtKDyRuDT04oQxRFiaerinEfE9ltq4DoG5NCd8ArYqcCMsQKDEpvjLDjiAQnf1fcmRODu660UFymXD1jym8dNMmDiWXDKucSYGda4xAWIe9CAwH23YP+10ySYCEh2eB4hCLibfzzTXiXZ52qTdux4qJTTUOF+ghuNtwA+ruaNM/AHEtbJhxJFo7N0c/wT0oDcOIyys04fT4RB3CI1PEEF3ngiLNPoVzNdeVfwJ2FQL8lOXt0K+yVhiXAeXts2NcbJ9Dg0S3mdTOCItluuz3bjfGv/MIVzXyM8WQBIVfJOU33Bg2ZSYwZU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIYXdiU248RxK5fhAQkgPo13CDuvw4UYSzuTX+68xz8=;
 b=Qa4UMOYSEaDBgVX9FbIONYWKwUtrZpqZUJhb9uHmM7dyUFQaCyJ161Two6dDz+MZYHERsj/VIVHmqkR4NLsVgVKj9SNJy3Ax/wpkk5kjQjupFcbCFhl/ySdv83Zaa/lYSQWU7fj8cYVAFprL3EC5ojU9Ckpcgrccd9FGdbCmiBo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 19:08:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 19:08:26 +0000
Message-ID: <4ec347fb-0f1b-868d-d8a2-bc88a9f2ad54@oracle.com>
Date:   Wed, 20 Jul 2022 14:08:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <51e85040-5622-dae2-dc28-f167660184f0@oracle.com>
 <YsTiUXjVL1ativXJ@MiWiFi-R3L-srv>
 <176bd603-05e9-2235-4052-dcca446098d7@oracle.com>
In-Reply-To: <176bd603-05e9-2235-4052-dcca446098d7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99198922-e53f-4dab-3a17-08da6a83392a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UZI3f7MFzRgw0jb/Y95sCeFAK40S35ujCmfGHOeMNdZpFrCe0bVw7V97nGv6YAH7LrO/8lpLQd/fKzXn1INV/kIz9ubvvfztCfW2CCvE4BxaS8+pqwF9bOmz9iwkjXJPlJdAC981eY5LSGA8pHFhcYoL2aMFiSLN94ODPjCQzeVcG1eKLnFuldtcaUd/Q29ieUHrH1Q+X/SYdm5Q2cDinHWW1TKjZ8V6NVXgKTXoqrnfvg8bIhR5+UKl8p1UMRQZ1MSGt9y6SimZuu8eSyAeZE+k6Y25ebJJNJ6kZNMi+887lT8Bt4SAnTx8sDZ60u0yniIMOvdTABXXqS2GDYJ68iyBr3LSeWMkk4a6cqITwkLJkys/Aw5w/CSH9Qs4BOyigC94CnnDk+Wvd/V/APjTLxZ7Ub3cw0rGWLBpBIAfDZG4AQ9YIa3/UU555yaj6mV9ChyQhGuIkvebIYGP6g3fdr1xXwCwisISIj7G+7DTxOC19uucWX82t/i43dEIvPPFb1l94LL0maqbbV1NWtnkud5TczLQ9tlw8BnXeWto/7ydr4P/gDhYhB5QDau9eifpGtBZxRoDKTMOrQUQ58PyEE4jwngm/gWsyRTc1idrI6C2x+FUHjcPjyhszD/Em3REgoJ1O2MpmBcEqi2KouMpJWYF2D2subdgMCqD2eac/8ZzA1knN2qQY+N+tVWpqPCMQjyo29urQJ43Yp0maiECFEk6spJ80HtT0Fo53LMgZrD/85puGkJsfxqVBim9CTYnw7icF+iY0InI2j5IxMiIJCZfsTfL5j3CSQx9Rc8CnAODrx+tbrWTLQbKsPqg8nlpxda3s2ruYvLwT4pQGulu1ti/3V2EZWTw165UG5paXnMvNTBTNvkCUEDtSjCBXWXMHw9jnYAb+rM8VO2zDSH6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(39860400002)(396003)(5660300002)(7416002)(4326008)(2616005)(66946007)(66556008)(8936002)(30864003)(8676002)(66476007)(2906002)(31696002)(86362001)(6506007)(31686004)(6486002)(83380400001)(966005)(478600001)(36756003)(53546011)(6512007)(316002)(107886003)(41300700001)(6916009)(186003)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRCNGtsakpJMS9vVDhaeW1kS0FUL3A0RDZzK3FNbXhZSnpMbjZNNytXVmx3?=
 =?utf-8?B?cDc4d3gxKzFYRlAwQysrbGRrYzJJQTVGc1RGbVd3MkRiVkNwRGgxTEpBd09a?=
 =?utf-8?B?cnZaekhETE5UYWRSZWtOTVAwYlJheVlOZng0NjB1OVFaZmVxcmdyVWFqYjhP?=
 =?utf-8?B?V2VPZGZsNVlsVWNlc3gzZitlcG81SUN0NlpEN0hsSFB4b1RzSzdZNUljbVYy?=
 =?utf-8?B?ME9nSVVPcDRQVjdraVlIZ28vZ2hVMk42c3FnYmxVYTAzbjhSZFVrYXRnVk5o?=
 =?utf-8?B?K2xueldKWmpNY1RQRGpiNDZ6VDFjU1VNM2J3SHNZMjFicDM2MXFCZlpwVUY2?=
 =?utf-8?B?ekZzZEhEbXNrNVdDRkRNWU5CbUhDUmErKyt2SlRqbG5ENURCTTlzcldJSVJ1?=
 =?utf-8?B?d1hUYmUxNVR3ZldkQjlEVEd2NkdYMm13QXdVeVRqbkp0NHcyaW4wVlQyM2JO?=
 =?utf-8?B?d0plaXBNakZJa2xXZmpsYVNaclROUnArVGhwaW1FOE5veU1TTDlSTGk4ZzFM?=
 =?utf-8?B?ZkRtVG5hZlBOQjZkY0RPZVgwNmw0RTVOdFVlK3lTdGVrTEpxZjZLS3ZQaDNN?=
 =?utf-8?B?RWZjcjF6Q2pRSkJ2Ym9mQWVNYlV4dFErVnIvTGNINHZUeXdOUDlrTzZNUEYx?=
 =?utf-8?B?OU43cjFuOXNMZkhJalhNWEs5OVJOS1VqSTBSdHoxL3NmSXRyRUo2cGppU3Bz?=
 =?utf-8?B?RGtJT016Qm1jOG8zdFE0RDRpcDg0dDl6aE5oc3BiTUxmWklLdzNYSXNWVDll?=
 =?utf-8?B?Nyt3TEI2WldWV1YyN2U5VEhnTncrUDM1Wm5yR0Znb3h2MDNPanRwem9SdzJI?=
 =?utf-8?B?WHl2OEdzZ0lGbzMxekg2cnMxNzBYcVh5NE5GNzhBaFppdWVmUEZCbGdmNys1?=
 =?utf-8?B?OVF6WkFwL01aNk1DWXBpb2V3ejg2aU5XZEpSdHBPNCtjdkxFbGRnSjA5M0JV?=
 =?utf-8?B?d0JneENYUHVpbXhoTld5aFdBdjJBMU5QNFYwRytkSEZPZnVXZWZocnlrS2Fv?=
 =?utf-8?B?dnNYYkE3SHBxaXVrZ1pXT2g1ck0wbkdQeDBPOW5EU0kvRzF0bHUyaDFCZjFU?=
 =?utf-8?B?Z1J0ZEpZdkg4ZWZxUXNjUzV0d2RaOVROSmNkR3hwWmMxanRIN1p5KzFteXha?=
 =?utf-8?B?U3VZNTM1S1VjV2gxQXlEVDFKdWZiWml2b283Tnc4T1BPT2RJTVFhMjRuTmZa?=
 =?utf-8?B?ZmRZQlExZ0Y0Q0hnUWhHV0gvR1ladlpwR0FydVl2VVFQWkFCWjVhY1hHQ0pR?=
 =?utf-8?B?eEZqa0tFaHVNY1VRSnVldHBCYmJMbzcrY25PT3EybjR5UUlTTzNPOWhwYkhM?=
 =?utf-8?B?UEVQM2RVUVZZNXU4OWNsRGFHZUdjdUVpQUFsVzZsaVJiZDFFR2lOa29EczZU?=
 =?utf-8?B?MDZaSUN2SlZUNmRCK2lGUDNZNzhjb2RmamlLNU9ZNnMrV0poay9GTWxJYzZZ?=
 =?utf-8?B?aEhTZU84MnF0c25TaHJsOVJacG1pM3ZRUHJqdHByd2JZN05MYUFDMDY3NmFB?=
 =?utf-8?B?Mml0amhFY01PbWtzUElHUHdXbU5RdjFhN0pKcXdyVm0wem9TNStRZWRhdnpS?=
 =?utf-8?B?UjhLTDZ6cmFuQXJoc3JuUGxweFBmSEdBMVg5a29xYnNmaDBTWDRBS0toT2RG?=
 =?utf-8?B?OSs3M1ArSE5xWkdtLzFGQ1hIeXVvQ0p5TlE2VnNXR0VnTS84RDdDUVBNZFJ6?=
 =?utf-8?B?ZkRGSlRPNGRub0gweXRYd1NlbFpFNlVlY2pvZ1hvbU9waVBOdHN4eSt3RnIz?=
 =?utf-8?B?OVd0NEp2QWljQzR4R3poWXdKRGYxZ3oySE0rTCsvU25FZlJyZXBlMTA3U3Q0?=
 =?utf-8?B?TkthZDdTWFFkanFHSFZoZXRmeXhkYThHd1AxWWwwWkVSbkNKVXliNlEzOUNY?=
 =?utf-8?B?SWtyNG0zTHFscUt5L05sN25YeU5EOW9UOTBPN2pTVC9rcXJzUU5hamU1TnRa?=
 =?utf-8?B?OTcxNUdmajdPRUZKSS8xeUVxUHdPYnA2RjZTT3I0cUZPVFQ3WjhwQmdDWE1C?=
 =?utf-8?B?bDgzeExkaGZXZnJtdlRheEpqSUFKZFNibFRXRVJ2THI2SDZmajlMNVhNczM0?=
 =?utf-8?B?M2h2SnowK1JpOFlQMFVpSFpZQVVCRWhiRFFyMlVoTGQ5SjlDaHo4cDIzdlFh?=
 =?utf-8?B?eGdYaHRkOGVER2kxZDlmQVRyazBDbmFwMjc0emlJak56SE9JNzljclhTeUU5?=
 =?utf-8?Q?WQ0q4ivU+DY5EALErPnz4rQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99198922-e53f-4dab-3a17-08da6a83392a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 19:08:26.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38/1rCWxQqEqb9cf1152jf/RoOjnLC0Omu1+RPhuOr+TpI5KyvuyMciytR9C6Xn2yjpg2iQ/7Q2UIJNiF7XF7U1khF7f5G6ramXvwCzXTgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200077
X-Proofpoint-GUID: S23ebNL8ZN_wFpcuQVjEGkTKs3YW2rO0
X-Proofpoint-ORIG-GUID: S23ebNL8ZN_wFpcuQVjEGkTKs3YW2rO0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
I believe I've addressed all feedback, just checking to see if you agree.
I have the next patch set ready in the event you think it a good idea to post it.
Thanks!
eric


On 7/7/22 08:05, Eric DeVolder wrote:
> 
> 
> On 7/5/22 20:16, Baoquan He wrote:
>> On 07/05/22 at 10:17am, Eric DeVolder wrote:
>>> Nudge...
>>> Thanks!
>>
>> Seems DavidH has concern and rasied it after you posted v9. Is that
>> solved?
> 
> In looking at David's comments on v8:
> - [PATCH v8 2/7] crash: prototype change for crash_prepare_elf64_headers
>    I adjusted per feedback and responded as such. He provided an Acked-by.
> 
> - [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug support
>    He says do not use WARN* on expected error paths. I instead used WARN_ONCE(),
>    but I didn't consider this an error path. Nonetheless, I'll remove the
>    message altogether in v11.
> 
> - [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot un/plug
>    David muses about a better name, but that was in response to Sourabh's
>    and I exchange on the sysfs attributes to use to report the presence
>    of this feature. In the end, I used something altogether different, as
>    presented in v10 (and the corresponding udev solution/change that goes
>    hand in hand with it).
> 
> Let me know if I've missed anything else? Sourabh points out a build problem
> for architectures without this feature support, so a v11 is warranted. But I'll
> wait to post that until I hear that I've addressed the previous questions.
> 
> Thanks,
> eric
> 
> 
>>
>>>
>>> On 6/13/22 17:42, Eric DeVolder wrote:
>>>> When the kdump service is loaded, if a CPU or memory is hot
>>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>>> and memory in the system, must also be updated, else the resulting
>>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>>> regions).
>>>>
>>>> The current solution utilizes udev to initiate an unload-then-reload
>>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>>> outlined the significant performance problems related to offloading
>>>> this activity to userspace.
>>>>
>>>> This patchset introduces a generic crash hot un/plug handler that
>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>> changes, this generic handler is invoked and performs important
>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>> invokes an architecture specific handler to do the appropriate
>>>> updates.
>>>>
>>>> In the case of x86_64, the arch specific handler generates a new
>>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>>> with userspace needed.
>>>>
>>>> To realize the benefits/test this patchset, one must make a couple
>>>> of minor changes to userspace:
>>>>
>>>>    - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>>>>      Add the following as the first lines to the udev rule file
>>>>      /usr/lib/udev/rules.d/98-kexec.rules:
>>>>
>>>>      # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>>>>      SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>>      SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>>
>>>>      These lines will cause cpu and memory hot un/plug events to be
>>>>      skipped within this rule file, if the kernel has these changes
>>>>      enabled.
>>>>
>>>>    - Change to the kexec_file_load for loading the kdump kernel:
>>>>      Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>>>       standard_kexec_args="-p -d -s"
>>>>      which adds the -s to select kexec_file_load syscall.
>>>>
>>>> This patchset supports kexec_load with a modified kexec userspace
>>>> utility, and a working changeset to the kexec userspace utility
>>>> is provided here (and to use, the above change to standard_kexec_args
>>>> would be, for example, to append --hotplug instead of -s).
>>>>
>>>>     diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>>>>     index 9826f6d..4ed395a 100644
>>>>     --- a/kexec/arch/i386/crashdump-x86.c
>>>>     +++ b/kexec/arch/i386/crashdump-x86.c
>>>>     @@ -48,6 +48,7 @@
>>>>      #include <x86/x86-linux.h>
>>>>      extern struct arch_options_t arch_options;
>>>>     +extern int do_hotplug;
>>>>      static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>>>>                        struct crash_elf_info *elf_info)
>>>>     @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>>>>          } else {
>>>>              memsz = bufsz;
>>>>          }
>>>>     +
>>>>     +    /* If hotplug support enabled, use larger size to accomodate changes */
>>>>     +    if (do_hotplug) {
>>>>     +        long int nr_cpus = get_nr_cpus();
>>>>     +        memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>>>>     +    }
>>>>     +
>>>>     +    info->elfcorehdr =
>>>>          elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>>>>                                  max_addr, -1);
>>>>          dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>>>>     diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
>>>>     index b8bb686..5e29f7a 100644
>>>>     --- a/kexec/crashdump-elf.c
>>>>     +++ b/kexec/crashdump-elf.c
>>>>     @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
>>>>          int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
>>>>          long int count_cpu;
>>>>     -    if (xen_present())
>>>>     -        nr_cpus = xen_get_nr_phys_cpus();
>>>>     -    else
>>>>     -        nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>>     -
>>>>     +    nr_cpus = get_nr_cpus();
>>>>          if (nr_cpus < 0) {
>>>>              return -1;
>>>>          }
>>>>     diff --git a/kexec/crashdump.h b/kexec/crashdump.h
>>>>     index 18bd691..28d3278 100644
>>>>     --- a/kexec/crashdump.h
>>>>     +++ b/kexec/crashdump.h
>>>>     @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
>>>>                     unsigned long long paddr);
>>>>      unsigned long xen_architecture(struct crash_elf_info *elf_info);
>>>>     -int xen_get_nr_phys_cpus(void);
>>>>      int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
>>>>      int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
>>>>     diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
>>>>     index 70fb576..f54a2dd 100644
>>>>     --- a/kexec/kexec-xen.h
>>>>     +++ b/kexec/kexec-xen.h
>>>>     @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
>>>>      #endif
>>>>      int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
>>>>     +int xen_get_nr_phys_cpus(void);
>>>>      #endif /* KEXEC_XEN_H */
>>>>     diff --git a/kexec/kexec.c b/kexec/kexec.c
>>>>     index 829a6ea..3668b73 100644
>>>>     --- a/kexec/kexec.c
>>>>     +++ b/kexec/kexec.c
>>>>     @@ -58,6 +58,7 @@
>>>>      unsigned long long mem_min = 0;
>>>>      unsigned long long mem_max = ULONG_MAX;
>>>>     +int do_hotplug = 0;
>>>>      static unsigned long kexec_flags = 0;
>>>>      /* Flags for kexec file (fd) based syscall */
>>>>      static unsigned long kexec_file_flags = 0;
>>>>     @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
>>>>          return 0;
>>>>      }
>>>>     +long int get_nr_cpus(void)
>>>>     +{
>>>>     +    long int nr_cpus;
>>>>     +
>>>>     +    if (xen_present())
>>>>     +        nr_cpus = xen_get_nr_phys_cpus();
>>>>     +    else
>>>>     +        nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>>     +    return nr_cpus;
>>>>     +}
>>>>     +
>>>>      static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
>>>>      {
>>>>          char *buf;
>>>>     @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
>>>>              if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>>>>                  continue;
>>>>              }
>>>>     +
>>>>     +        /* Don't include elfcorehdr in the checksum, if hotplug
>>>>     +         * support enabled.
>>>>     +         */
>>>>     +        if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>>>>     +            continue;
>>>>     +        }
>>>>     +
>>>>              sha256_update(&ctx, info->segment[i].buf,
>>>>                        info->segment[i].bufsz);
>>>>              nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>>>>     @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
>>>>              case OPT_PRINT_CKR_SIZE:
>>>>                  print_crashkernel_region_size();
>>>>                  return 0;
>>>>     +        case OPT_HOTPLUG:
>>>>     +            do_hotplug = 1;
>>>>     +            break;
>>>>              default:
>>>>                  break;
>>>>              }
>>>>     diff --git a/kexec/kexec.h b/kexec/kexec.h
>>>>     index 0f97a97..b0428cc 100644
>>>>     --- a/kexec/kexec.h
>>>>     +++ b/kexec/kexec.h
>>>>     @@ -169,6 +169,7 @@ struct kexec_info {
>>>>          int command_line_len;
>>>>          int skip_checks;
>>>>     +    unsigned long elfcorehdr;
>>>>      };
>>>>      struct arch_map_entry {
>>>>     @@ -231,7 +232,8 @@ extern int file_types;
>>>>      #define OPT_PRINT_CKR_SIZE    262
>>>>      #define OPT_LOAD_LIVE_UPDATE    263
>>>>      #define OPT_EXEC_LIVE_UPDATE    264
>>>>     -#define OPT_MAX            265
>>>>     +#define OPT_HOTPLUG        265
>>>>     +#define OPT_MAX        266
>>>>      #define KEXEC_OPTIONS \
>>>>          { "help",        0, 0, OPT_HELP }, \
>>>>          { "version",        0, 0, OPT_VERSION }, \
>>>>     @@ -258,6 +260,7 @@ extern int file_types;
>>>>          { "debug",        0, 0, OPT_DEBUG }, \
>>>>          { "status",        0, 0, OPT_STATUS }, \
>>>>          { "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>>>>     +    { "hotplug",        0, 0, OPT_HOTPLUG }, \
>>>>      #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>>>>     @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
>>>>          int buf_end, int phys);
>>>>      extern void arch_reuse_initrd(void);
>>>>     +extern long int get_nr_cpus(void);
>>>>     +
>>>>      extern int ifdown(void);
>>>>      extern char purgatory[];
>>>>
>>>> Regards,
>>>> eric
>>>> ---
>>>>
>>>> v9: 13jun2022
>>>>    - Rebased to 5.18.0
>>>>    - Per Sourabh, moved crash_prepare_elf64_headers() into common
>>>>      crash_core.c to avoid compile issues with kexec_load only path.
>>>>    - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
>>>>    - Changed the __weak arch_crash_handle_hotplug_event() to utilize
>>>>      WARN_ONCE() instead of WARN(). Fix some formatting issues.
>>>>    - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
>>>>      and CPUs; for use by userspace (udev) to determine if the kernel
>>>>      performs crash hot un/plug support.
>>>>    - Per Sourabh, moved the code detecting the elfcorehdr segment from
>>>>      arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
>>>>      and kexec_file_load can benefit.
>>>>    - Updated userspace kexec-tools kexec utility to reflect change to
>>>>      using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
>>>>
>>>> v8: 5may2022
>>>>    https://lkml.org/lkml/2022/5/5/1133
>>>>    - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
>>>>      of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
>>>>      is not needed. Also use of IS_ENABLED() rather than #ifdef's.
>>>>      Renamed crash_hotplug_handler() to handle_hotplug_event().
>>>>      And other corrections.
>>>>    - Per Baoquan, minimized the parameters to the arch_crash_
>>>>      handle_hotplug_event() to hp_action and cpu.
>>>>    - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
>>>>    - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
>>>>      to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
>>>>      by David Hildebrand. Folded this patch into the x86
>>>>      kexec_file_load support patch.
>>>>
>>>> v7: 13apr2022
>>>>    https://lkml.org/lkml/2022/4/13/850
>>>>    - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.
>>>>
>>>> v6: 1apr2022
>>>>    https://lkml.org/lkml/2022/4/1/1203
>>>>    - Reword commit messages and some comment cleanup per Baoquan.
>>>>    - Changed elf_index to elfcorehdr_index for clarity.
>>>>    - Minor code changes per Baoquan.
>>>>
>>>> v5: 3mar2022
>>>>    https://lkml.org/lkml/2022/3/3/674
>>>>    - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
>>>>      David Hildenbrand.
>>>>    - Refactored slightly a few patches per Baoquan recommendation.
>>>>
>>>> v4: 9feb2022
>>>>    https://lkml.org/lkml/2022/2/9/1406
>>>>    - Refactored patches per Baoquan suggestsions.
>>>>    - A few corrections, per Baoquan.
>>>>
>>>> v3: 10jan2022
>>>>    https://lkml.org/lkml/2022/1/10/1212
>>>>    - Rebasing per Baoquan He request.
>>>>    - Changed memory notifier per David Hildenbrand.
>>>>    - Providing example kexec userspace change in cover letter.
>>>>
>>>> RFC v2: 7dec2021
>>>>    https://lkml.org/lkml/2021/12/7/1088
>>>>    - Acting upon Baoquan He suggestion of removing elfcorehdr from
>>>>      the purgatory list of segments, removed purgatory code from
>>>>      patchset, and it is signficiantly simpler now.
>>>>
>>>> RFC v1: 18nov2021
>>>>    https://lkml.org/lkml/2021/11/18/845
>>>>    - working patchset demonstrating kernel handling of hotplug
>>>>      updates to x86 elfcorehdr for kexec_file_load
>>>>
>>>> RFC: 14dec2020
>>>>    https://lkml.org/lkml/2020/12/14/532
>>>>    - proposed concept of allowing kernel to handle hotplug update
>>>>      of elfcorehdr
>>>> ---
>>>>
>>>>
>>>> Eric DeVolder (7):
>>>>     crash: move crash_prepare_elf64_headers
>>>>     crash: prototype change for crash_prepare_elf64_headers
>>>>     crash: add generic infrastructure for crash hotplug support
>>>>     kexec: exclude elfcorehdr from the segment digest
>>>>     kexec: exclude hot remove cpu from elfcorehdr notes
>>>>     crash: memory and cpu hotplug sysfs attributes
>>>>     x86/crash: Add x86 crash hotplug support
>>>>
>>>>    .../admin-guide/mm/memory-hotplug.rst         |   8 +
>>>>    Documentation/core-api/cpu_hotplug.rst        |  18 ++
>>>>    arch/arm64/kernel/machine_kexec_file.c        |   6 +-
>>>>    arch/powerpc/kexec/file_load_64.c             |   2 +-
>>>>    arch/x86/Kconfig                              |  11 +
>>>>    arch/x86/kernel/crash.c                       | 119 ++++++++-
>>>>    drivers/base/cpu.c                            |  13 +
>>>>    drivers/base/memory.c                         |  13 +
>>>>    include/linux/crash_core.h                    |  12 +
>>>>    include/linux/kexec.h                         |  14 +-
>>>>    kernel/crash_core.c                           | 241 ++++++++++++++++++
>>>>    kernel/kexec_file.c                           | 105 +-------
>>>>    12 files changed, 456 insertions(+), 106 deletions(-)
>>>>
>>>
>>
