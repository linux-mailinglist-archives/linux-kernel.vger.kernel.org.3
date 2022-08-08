Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1E58CB2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbiHHPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiHHPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:19:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F22613
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:19:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278F9SjK001340;
        Mon, 8 Aug 2022 15:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F9CAR7tpXepulQGrffsNtBQ1fiG03NQm76or99XWbCM=;
 b=WyE/saH753f3Wde9tQ76w/UGW168YDFt+H+PRRT57w1WQmfsfakzrbytmIf0axZhbJ13
 vdrVY1H9A7jwZhCOxND5GyyX4gWkaeaDZiCIpL996adXOULoShV+PFoRKinZn2WKY76U
 tS1P2TUMpO5fGrkyxBjXhNBhwqvGejPZmfp61bLS/+UMFe5tgvkrOzfQRbYj3Jm5nzxv
 yEbJPhLOLnauEw1VmpwoIWGt48hHKkBihg3TyZIccIHNciONRSbHK42BezTFseRVaS9m
 Y4pcF6asTH9PEsivYtklDLXEkVULG5GlCzc0OFaRS6/ZGO067f91S9xlD0P/6SakMVix 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hseqcku1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:18:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278DZsjA012537;
        Mon, 8 Aug 2022 15:18:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser82j8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxmlelr+m7TxF5EtlNXi0w1XbxH7Ny8AIrEUgHKeQO/M+SV0PsmSSw/qLowhotrvGa0D6UNEWMQXl8MMbxwc1AWnwBpPfANFzXxXanP9bX6iYqgZEQ0/kcU8xhsv7KvxudTJQWwNDjcvqW9dmEwswhPnsd95qjz/j3brcf4o1EBEzkFWRjz8UhvollWC3pIMtPlDtaXRLUZ1H9N2m4lfzWeiAZCgcKKfhFjFu+CtW03jF1m0E/3tsO86C5MerVZcM+V/U2H4E8FRPrys194qi4wrLgfJxFNQKdTW716GaiQO+15iyhBqPVWElq2z4m+pyaYnlPzgFv3dXv8EQGmdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9CAR7tpXepulQGrffsNtBQ1fiG03NQm76or99XWbCM=;
 b=iQTThVmWbQg4LMmJ7XI2Ie2/bXvK79YqnPFzhOF8nai0IkZeNbLVcYy4FXdbWSQAZVPTryjL5GsAyGpquaCsyX8VmHjib2drAbNK8tVpayClIo0wsSH8O0Yv5AW/JWQhQIjZRvasConSVvu6rHdtitzAoDugQGXQROUlrp5kc94WZS8EE+R7EnItJndgSEOO02VqKsC9VwMOV6cGLo92WIa2lFK/uVy8KglkEfeeY7LW+hD/05uaYnXqq9ViHruWOcbZ7dncWFn+XtSBFpON0QBh7Fp6umWjiQd+UaeqwwBzeIik5lyaHIc2DQvbcvq/+W9l4Kr2KWp5XhqmmbmLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9CAR7tpXepulQGrffsNtBQ1fiG03NQm76or99XWbCM=;
 b=XmgLpH/UDPLKocoga0YgI10nmFZqiDhS02Ag0zaO11hgvTNwIpuMFL6EPkIzBHpx1X5Oxv64rDKZhR9CKFLMkvT0kfDMjyQByrYkFlxbJg5YXW4EGG9Z3uxm6JKf/25VWMarKP4lGWS7bbxVh9La6OmrGreyr6Yv8EAszBwZl6w=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY4PR10MB1253.namprd10.prod.outlook.com (2603:10b6:910:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 15:18:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:18:49 +0000
Message-ID: <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
Date:   Mon, 8 Aug 2022 10:18:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:805:66::48) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab08fe54-d3cc-4b1f-a813-08da79514b31
X-MS-TrafficTypeDiagnostic: CY4PR10MB1253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhNuqqRXfdDmprmE+R4cq5VkdD6kVQmBbrhqUzCLPNEWNgtCS7a7CQz44Hy9HOYONlSVY0d1ooAcU1LbpdusKHyHYcivY/sP1dk+OwGIGskBs6MkbMuNyugpiW/6l4vRMAX9Cc/p4+eEAlulx6gR2Kdy4cScIvR5qoucjcsyfW4g7aY8RAXUU/06/YgF52pO2M6GHv/dY3/rEQVgAYJfmn5VQZh25AvXocMoIQSEFcbjaVW9S7+Ieq8+k3M4frmxmYaifczn3zFL4KKlm7sFYu2vhaS2flHWvTKeHDD1LtFjM7pSopIoXN+dRtcN/kxUWDJHmGq2Ps81owsXhQ5/cgfOJ4unJX03Buj++6gv4lAsPv/T67+Fgi50UkX1pFkPLkey7idLZiXP2AXAGYwrjYAZDzvmCIo1ytyF485ZsXG3uAyygK1YJX2a75uHhMs6iCFkTS+Z2hu5VzZS2q3Lz7av23+UEphHzvRFs0RLt3KPoSVuBfqat/vuaObhxfBswFVR4mCH5p5oo8EaQ4cw+L9v/XhZMLvKWx0OXJAsWm7Oh+tcEA7GGXC4LJuN8x4ph+yb1+2wb+IdDIrrxGHPfAP0IkUq5QrIQnj8M+Vd4YR+iA90N7gB7BS8833/jkPkaqjw4sd4L8FttHC49kNqgRTm+l8KDRTpOm+49taSHbk/XkUd47PXJ3Mn2wifKaLzpEzm0Nx2IYkaA9Na8wtUirDnOSq56BVCNucNgpjiZUegabB8vr8Fc+yynh+FILKHzHz0IqJAUdunCD4cdIxoHZ+bGvusyr0rNpY95nrUD4MFNPJfpWyAdRi9odlaj/90VzEQhI0q2k6Y9DTrTMcWaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(396003)(136003)(83380400001)(2906002)(38100700002)(316002)(6916009)(8936002)(4326008)(8676002)(66476007)(66556008)(6512007)(6506007)(186003)(2616005)(7416002)(107886003)(6486002)(5660300002)(478600001)(53546011)(41300700001)(6666004)(66946007)(36756003)(86362001)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhBMzl3eWNjZEtBdm9FSUdMbHVoTTJweE9wQ2wvcXJNNGJXanduUjJKelk4?=
 =?utf-8?B?MURFVUFONHRyWmErUEQ5WWRWVHVpcnkxWHVsU0M5Z2pVUDdGNkFPS20rMmR5?=
 =?utf-8?B?aDlPRG5rN3pUWVBKQ2JNOUQ0d2U4UFg2NmR3aVE0eDJUa2MvNkFwU1orZ01H?=
 =?utf-8?B?SWxTNTNVZVhYUVBMR1BMRUtUdHlTNC8yS3I2T3crT3VFUVk3bUF5V25aWjRQ?=
 =?utf-8?B?U3poR0hKUjEzODZQRnd6ZmcveFA3Z2lGTFNacGNmWEtFeEtJcGhkY3A2MHBY?=
 =?utf-8?B?SnpPZjR3MWE1a1hCeHpaaVkrWmQwclF4aFd5RzlEU2tiWlB5RGQvdlE1K0dm?=
 =?utf-8?B?dFU0SkdBUHFYT0dmY0NjMm5XNFZ1T0JFbXB0ckMxaU5FcW8rYXBxdndaSS9p?=
 =?utf-8?B?ZzFDSUdxMWs5TkdVMEJ1eFRsQ0ZwZnFPMHRqNTJtNnBQanZIUXpqeEFuYUQz?=
 =?utf-8?B?eWVQK0JXYjlJVHFybFFkWDlMNTNtVUxpckRxWG9nQWdSeTBKYlh2S3p2alZu?=
 =?utf-8?B?eVdnamxlTUNjZkY5M1JPaHVoVkhMWkh4NVIybFBldHdQSEM4bHJBTFIvbElr?=
 =?utf-8?B?VVcxU3M1R05IZG15S1BmcmFWTUtjSS9hNlFwRmxicW13R0NtaEE2bGJWTGk5?=
 =?utf-8?B?bzg4c2dyc2lmQ05EQXIxQTRiM1A0QjdaaHJXMCtMdkhKbWVDc1lCNEJDQThQ?=
 =?utf-8?B?bEJURitvaHo0eU5hRGxiSW9sZWdNeTZDRERVYkNZS3NrczBoeFlkWmFoeDRL?=
 =?utf-8?B?K0RHdzRQTUtqT3hoanJ0QnRMYXNud3YwTk90aW1VQkpnZWswczNWRkZzNnRi?=
 =?utf-8?B?eXFTTGQ4TXJwTVBVZmRxTUlXdTMvU01naTNZM3Q5bHJQOWxoVWh1QVlwaVdn?=
 =?utf-8?B?Tjl6T0xsbUNScEd0b0dOR1Mydm50R0EwME54WXJaYm5mMWpDeS8wRlVvVXpP?=
 =?utf-8?B?K0xPbzIzQlJzbFRQWmxkVEdYTzVRRlArN1dzVjRuL2wvdG9UdnVRZVBNa0R0?=
 =?utf-8?B?Znh5Sm5wbnU3c0lXZnorQXAvNVdwZ3dPdjIzWjVQK0kwTTM2Z1JRTk1abEN1?=
 =?utf-8?B?dW9QaTdrR0NZeDY4dU5DcGF4Y0pKRUhmV3gyNVBWRVRRQUdlR3ZJdjNFVTI2?=
 =?utf-8?B?ZXZkQVhkTFBoSmMyOGZGbTROemw1RitneDVpUVJCUHFiYjl4Uk1MRDg5bVZl?=
 =?utf-8?B?c2I3TlFDcDNjVStpSDhqUFVjRUhjWHJoMlptVzRpaEhScCsvUnovTGhCYVNU?=
 =?utf-8?B?TVVRUDNDL2xzWnJaTzZ3OWFrOS83bElVOVNqRWpJWEk4b2VMZHQ2U0JTZHJn?=
 =?utf-8?B?S2hOYlp6U0FGZXRub0JrN1k5MWx1U3ZzaDA4S1Z1ZzJxVFZKSUFqdGJWWXM4?=
 =?utf-8?B?SDA5NWFpQjJ4UnFkd3RsMkFUYk5wSzhDSG93RXN0L3Y5K25lNFI3d0FheFZi?=
 =?utf-8?B?cDA2ei9uZEhHekoxOWk3RGxsNkVVbHdNOEIyRnAxL1l2empiNEs3b1hPdm9Q?=
 =?utf-8?B?bTZwbkltSW9NcXBBY2JFSWp6WHRXTlZGWGhGeC8yc2ZHN0lCQmRMdjlPSGZi?=
 =?utf-8?B?L0VtMFY4TXJ6cHdmNEN2VE51YmFvU1UycDJUYXRiOHo2T2loYlQyd0RyVlRr?=
 =?utf-8?B?WHFXcnJVSWhhdzRncnliV3ZlaEtsOVB6ZW1RVUJGcEVKZXVVdFJBMWhkdmZs?=
 =?utf-8?B?SjRHbTdGdXB0ck8zMVBCTlRMQzNuUEx5RkpCV3E5bzFZV2gvZkhlZmp3QXBR?=
 =?utf-8?B?UTRtZlcrVDI1SzB4OWNmV1NiVTR6dDlKZGE3RzgzZGIxbnRCMkwrbXl6dG9j?=
 =?utf-8?B?NFNPWVpLRlVSN2pGU2wvdWhzbUI4MFNiL1d5S3hKMjFxWU96SWNXM2RiaGt6?=
 =?utf-8?B?QWZtZ1g3ZEpQbllIWUM2Y09BOUdxRHpjK3pIeFBaYmI4SnRLTDU4UldyU0pm?=
 =?utf-8?B?ZWJUc3Z6NXZkUjlMWlFESXYxdSttcVQ2ZkV0ZzBGSmJZd2VuQS9DVFFvN0tt?=
 =?utf-8?B?NEJGUUV6WkpOY3h4cy9qejVmZUMwZGdrb3lva2FLdERjQlM1U0F3eUJsU0g3?=
 =?utf-8?B?WDZYd1JlaUhiTVF4cEZTVjhtTVVqbHpZaGRjRkNYMFRuUjdFZEtiZDVpbThG?=
 =?utf-8?B?TlZGVFNUZUU2VThuckVqYk1GNTdMZDFNY2JsWlV3VzFSWllKVXBIZVNFckMy?=
 =?utf-8?Q?Pr1B5w1ZaFVbD1+NmDE14vQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab08fe54-d3cc-4b1f-a813-08da79514b31
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:18:48.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvIYsYd0VlwRkQt5ec1gfgvYN+Dwe7iHPkeuutLeAfv7OJacQtDF/hm1goGfBl7bNLKYW6fnpUdexMhPv8Ai3bnzJ5c6Ab67ZBo0CZ7LEEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080074
X-Proofpoint-ORIG-GUID: kO0PogfDP7oESpZhZP-ZTKC5f7t7JTHt
X-Proofpoint-GUID: kO0PogfDP7oESpZhZP-ZTKC5f7t7JTHt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/22 22:25, Baoquan He wrote:
> Hi Eric,
> 
> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
>> The use of __weak is being eliminated within kexec sources.
>> The technique uses macros mapped onto inline functions in
>> order to replace __weak.
>>
>> This patchset was using __weak and so in order to replace
>> __weak, this patch introduces arch/*/asm/crash.h, patterned
>> after how kexec is moving away from __weak and to the macro
>> definitions.
> 
> Are you going to replace __weak in kexec of arll ARCHes? I don't see
> your point why all these empty header files are introduced. Wondering
> what's impacted if not adding these empty files?

Hi Baoquan,
In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.

For kexec, the items that were __weak are refactored into corresponding asm/kexec.h.

I followed suit for crash __weak items. File crash_core.h now #include's asm/crash.h and
so that file needs to be present for every arch, else build failures ensue. It turns out
x86_64 already had this file.

At this time, I was not planning on converting the other arch's __weak to asm/crash.h, but at least 
with these empty files, the infrastructure is in place for when that does occur.

Let me know if you think I need to do something different/more here.
Thanks!
eric

> 
>>
>> No functionality changed, yet.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/arm/include/asm/crash.h     | 5 +++++
>>   arch/arm64/include/asm/crash.h   | 5 +++++
>>   arch/ia64/include/asm/crash.h    | 5 +++++
>>   arch/m68k/include/asm/crash.h    | 5 +++++
>>   arch/mips/include/asm/crash.h    | 5 +++++
>>   arch/parisc/include/asm/crash.h  | 5 +++++
>>   arch/powerpc/include/asm/crash.h | 5 +++++
>>   arch/riscv/include/asm/crash.h   | 5 +++++
>>   arch/s390/include/asm/crash.h    | 5 +++++
>>   arch/sh/include/asm/crash.h      | 5 +++++
>>   include/linux/crash_core.h       | 2 ++
>>   11 files changed, 52 insertions(+)
>>   create mode 100644 arch/arm/include/asm/crash.h
>>   create mode 100644 arch/arm64/include/asm/crash.h
>>   create mode 100644 arch/ia64/include/asm/crash.h
>>   create mode 100644 arch/m68k/include/asm/crash.h
>>   create mode 100644 arch/mips/include/asm/crash.h
>>   create mode 100644 arch/parisc/include/asm/crash.h
>>   create mode 100644 arch/powerpc/include/asm/crash.h
>>   create mode 100644 arch/riscv/include/asm/crash.h
>>   create mode 100644 arch/s390/include/asm/crash.h
>>   create mode 100644 arch/sh/include/asm/crash.h
>>
>> diff --git a/arch/arm/include/asm/crash.h b/arch/arm/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..385646957d60
>> --- /dev/null
>> +++ b/arch/arm/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ARM_CRASH_H
>> +#define _ASM_ARM_CRASH_H
>> +
>> +#endif /* _ASM_ARM_CRASH_H */
>> diff --git a/arch/arm64/include/asm/crash.h b/arch/arm64/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..ec8870c1ea49
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ARM64_CRASH_H
>> +#define _ASM_ARM64_CRASH_H
>> +
>> +#endif /* _ASM_ARM64_CRASH_H */
>> diff --git a/arch/ia64/include/asm/crash.h b/arch/ia64/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..02a457cccda3
>> --- /dev/null
>> +++ b/arch/ia64/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_IA64_CRASH_H
>> +#define _ASM_IA64_CRASH_H
>> +
>> +#endif /* _ASM_IA64_CRASH_H */
>> diff --git a/arch/m68k/include/asm/crash.h b/arch/m68k/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..ba6e412a1267
>> --- /dev/null
>> +++ b/arch/m68k/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_M68K_CRASH_H
>> +#define _ASM_M68K_CRASH_H
>> +
>> +#endif /* _ASM_M68K_CRASH_H */
>> diff --git a/arch/mips/include/asm/crash.h b/arch/mips/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..35872522c574
>> --- /dev/null
>> +++ b/arch/mips/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_MIPS_CRASH_H
>> +#define _ASM_MIPS_CRASH_H
>> +
>> +#endif /* _ASM_MIPS_CRASH_H */
>> diff --git a/arch/parisc/include/asm/crash.h b/arch/parisc/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..96833b727179
>> --- /dev/null
>> +++ b/arch/parisc/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_PARISC_CRASH_H
>> +#define _ASM_PARISC_CRASH_H
>> +
>> +#endif /* _ASM_PARISC_CRASH_H */
>> diff --git a/arch/powerpc/include/asm/crash.h b/arch/powerpc/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..40ce71e56ac1
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_CRASH_H
>> +#define _ASM_POWERPC_CRASH_H
>> +
>> +#endif /* _ASM_POWERPC_CRASH_H */
>> diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..24f3aea99707
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_RISCV_CRASH_H
>> +#define _ASM_RISCV_CRASH_H
>> +
>> +#endif /* _ASM_RISCV_CRASH_H */
>> diff --git a/arch/s390/include/asm/crash.h b/arch/s390/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..0db16ad4c75f
>> --- /dev/null
>> +++ b/arch/s390/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_S390_CRASH_H
>> +#define _ASM_S390_CRASH_H
>> +
>> +#endif /* _ASM_S390_CRASH_H */
>> diff --git a/arch/sh/include/asm/crash.h b/arch/sh/include/asm/crash.h
>> new file mode 100644
>> index 000000000000..f54e12f88cae
>> --- /dev/null
>> +++ b/arch/sh/include/asm/crash.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_SH_CRASH_H
>> +#define _ASM_SH_CRASH_H
>> +
>> +#endif /* _ASM_SH_CRASH_H */
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..cb0f1916fbf5 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -6,6 +6,8 @@
>>   #include <linux/elfcore.h>
>>   #include <linux/elf.h>
>>   
>> +#include <asm/crash.h>
>> +
>>   #define CRASH_CORE_NOTE_NAME	   "CORE"
>>   #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>>   #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
>> -- 
>> 2.31.1
>>
> 
