Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE53544707
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiFIJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFIJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:14:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F6175A3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:14:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2598e3sr005804;
        Thu, 9 Jun 2022 09:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z7zuugLVFCcF+kLAVxuPCXTL1CU2/eN3Zi0b90prwWQ=;
 b=o1KahLw22i693sOFkeNFXpOdDZ2H0BWnOUVQC6OMbvjrYtfwqWrrAPKcB4J0Y8W2XHjn
 KwTTqErGJ+O2OnhIvPKMdyW+sdXTim55EENAw/OhguT7ark6N1//VfLg8uvWzSr0CCKz
 qXrOm6f+oZYsXpxGaaaElEACc3ZmG1f2AwntH5vMOwxmSNL0yFCgfHIe46zWc2qdHYGl
 6akWmX4Zam08918kdGQ3Ya3BAEo/HI/W57ijqQ6E7NG10/e3jLagff/NC34/eJu6SI26
 CZwzgZFnX2NV5L07hhMJsm6yxVkt0KboNFAmbe7QX0hI51RU2vCsdlzFA9+XDTml/fJU yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekjm83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 09:11:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2599AXVg008076;
        Thu, 9 Jun 2022 09:11:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu4efhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 09:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP/0CRa4Tiv8T8wRSAiS9myExvXCYCB4jp/T6e4XNuCFIY/yV1E1T+BKCcefao/aXTzzQi5DXgjM+iIB5bnq/GLljNEqc1wDw7N5h9XkupyDMBu0r4H3ieyOYEAPnGApxoZy0z9IcFGjhSCEfbyPAoNjxtqIlkBbiBW+VD8YxOe5XLkBPeiHMPcq8xTMS4ql28xic8vW5b7S7wHrVG3Jn3DNNmAPD8Ck6mt15dDJ3N8mu6uAiOrSsrcyS/TY2QWAFSFxSxognlh/UGSgTkG3W//FNYq6pHFp0IxVs3kyH4ytx/n5TnGdYElWVjuNvm66bnqAkFZhl+hTw9BY6ig4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7zuugLVFCcF+kLAVxuPCXTL1CU2/eN3Zi0b90prwWQ=;
 b=hHT8OMwk9WjDsvmp4AWLIkq74/Pvm5zjfanAfguBYTF1ftopYLXZIRo/IhJQQDy0XWD5KmHiFAmhnQb9IsRHIW5JFjK0kTMmTRFCFdN5xW40+K4U69WYxQktcKhZqij0VPfO/kTkVPaHm9MTkh5Vv0JQJXOCsMyynBiEcxEEdfj9+mXeXhvAncX4VZfgUfTbcml9lXiN6mQxDMWzF6PakpVaSuRubj3YcZCD0K5ZnxAYOmDvQrnbXmvMdD28g3dgwTY1/qzuN4d5WTQM0la9dtOe0OsW/e87WeUt68zshDJ9NBHBk5Eky9Ik0oWF8MmDHNcLmDdzFhq7UNFwsbOfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7zuugLVFCcF+kLAVxuPCXTL1CU2/eN3Zi0b90prwWQ=;
 b=H8VFnMLupq2gfmRRUslq1Rqdf7ePuRkx1hUJsIprC47HKbNla21bMpad9ERh2iAK4JLoJhypYktfrIcyHB5QPlwsGEMchICVO/yuXBok9CYOdzhIqbVk+K4NtxZUD3I2qtd+uXUb8er9PgyiSYMJpjysHjoFxOD8syBUdDkaAiY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM6PR10MB3324.namprd10.prod.outlook.com (2603:10b6:5:1ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 09:11:50 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 09:11:50 +0000
Message-ID: <eccf100c-ee04-d42b-c3a6-b747cdad6b7c@oracle.com>
Date:   Thu, 9 Jun 2022 11:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 0/7] x86/entry: Convert error_entry() to C code
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::27) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4b874b-045f-4602-7672-08da49f81673
X-MS-TrafficTypeDiagnostic: DM6PR10MB3324:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB33245EF5CE16B4C19497156F97A79@DM6PR10MB3324.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT3YdDcqJqHbukPWWg8x7AY19sq6GJUhpw836UJ2xYeAEu1ubkUgnlTfr4W7PZeyTvBeJo4cw0WsfVpYpq6lai0zYWrn2mE8wtZ7Efn50IhChJnNbXcYyIP512BwmF+SLEZDfI1LoDAJnehFk1lGgy154GICLLUsAdk/Hk3YgY/kGaujDmNrAdE8gIl1GqqzhY9MkVxhi0z2j2LXKQIqTXwmXqo+fgjFmwnb7hUwKC2gp5dqdjcnAwbOL4lDHJ0XCXee7z7K/ZRMAtGg7Ub7zTWwIsHCS0ACCWgH2cavk1DOxJkWLVH7npa4xjYIdYxPsZNo3V5Yf2fUQ4KZaC8HtIAmknHkQ1EjXhwCkD6KX8pvKaX8iG36hwjHAcdaysqfuXvJo7kyFdoqnI+nQrK4Qpop3k904DSqGjEjWvNHL3uHV6fr5JVY66B7/mvAwcVCz6KyEv/8z8sdLH5+meO1CpcmwjaEyIf/7yhmahCTJUFPiDa1zquoxSyrj/udr6sttCSnhBp2VyEzz1vYBOSQOrVpgyK1xOG7XNReJvPRduGAG5Zku19Ik4aqlEkY4qFRQ4nBxFqQFBseKZA3dVDKQ9VvWH+Ag0AbAy1kVdPWNS1QJLvJnHfvbk4SXuQNC5HMf2FfYBh23JpbTQZqaKQ1zw/3fxAf/jNp9kKkCfRuuWqYoAMw7/P4/s4ljQsEg6VB3EIzWB9nTNQJxb6Xyi1l1NIBgaRzIW9VNGSh14SFGSmYTNc11J6z9wDIEVpTyk3HtWiCkqx1xsq4KTPaJupqi12+7o87ofo8QZeulXDd370=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(6486002)(2906002)(66476007)(66946007)(8676002)(66556008)(5660300002)(4326008)(44832011)(36756003)(6666004)(26005)(31696002)(53546011)(86362001)(52116002)(6506007)(6512007)(508600001)(2616005)(186003)(31686004)(38100700002)(8936002)(38350700002)(54906003)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9KQldDTXoreXV3czBBREF6SG1ueEZ2VVliQ09sT1drNmJWNmJ2VHpjbmpE?=
 =?utf-8?B?NXArWjZ2NkhjOGdVWVM3c1Z6akppbVBENGladmFwejFQc3oyYWlvTjFGUEdw?=
 =?utf-8?B?R2R1ZFdRWmc3RC9uYVhJYldMRS9NYk1hdXdZdmJYNTJhRk94cWRrN0hHeHpo?=
 =?utf-8?B?R3RHWnFuNDNCeks4dVBNdDVVeFpJeTVGUjZVZnFPckRFME5QYmMrM2JlNTVs?=
 =?utf-8?B?SndyREpBOHdJQ1hMUUZDVzRPY1R1TVVPQW93YW9XRzVLNTBub0lpWGtybUY3?=
 =?utf-8?B?aXBHaGl6U3gvbmgwVURwaTl1ZlFvWm4yWjcyNUdjem5RMTRyTWxoalloWnNa?=
 =?utf-8?B?MWcyV0tWdC9LUjlXQVVwaENXSit5ZjRiT092Smc5RnliYjNtbTlPT2FtTEJM?=
 =?utf-8?B?Z3I2VEtWZXQ5YzFhTTl6ZXhmWVp4Z3Q4QWE5eEVrUE0wWEhaM3M4ZXgzeTFp?=
 =?utf-8?B?a2xoRUh6ZnhLenNrekRYTWZsdmJhNEpGT09yN29PWFU4M3VpREVxaUxNSnp0?=
 =?utf-8?B?Q3RId0lCTHc1ODk2RlBNSnhTZUJDcTd1djBvL3hVVzRIZFpaUm5aUHdZczlr?=
 =?utf-8?B?Vmk5R1NFM1hiRDhSMjRGdnNNY000SlQybkgyN3JoOHBBcXVLcXh4WGJ6YzNi?=
 =?utf-8?B?WGJHWXIvOEZFRFdKWWlnc1dRNWlGZ0NhY2xnbE5zYmwrNlNybm5pblRveldx?=
 =?utf-8?B?TVBDcG4xK3ltSk5Ja3haeEtWS0U4VG4vdTJGREJnMVJ1aDE3NExpTnYwNHFn?=
 =?utf-8?B?R0xTclBZYUp6TmRJVFpWckFSdVc1SkdDYVBuaG5zVEVhU05NamNKUXV5b0or?=
 =?utf-8?B?KzV0d1dMb3MvZXZNNWdCWTYydFpEOTRhYUxnZFhhWjFEb2VOOWJOQnNWSVlI?=
 =?utf-8?B?Q2UrRUV6WXlaa3VYUzRickV3Q1JpeUVsZXJvSldZNVVsSjZtRkZFaVExZUE0?=
 =?utf-8?B?RXFGa1ZkN0FxY2lEbWJrdUNsVlcvQ2lKRXNFYnRudFlRKzd4ekNLaHdSaW5I?=
 =?utf-8?B?aERGS1JOTlpjMVpzU3JYMHZyNkh4bGRFRmw4RUpmbk9IcjhLU09NSnExT05Q?=
 =?utf-8?B?K0lZRURXa2J1MXR3bit6MVRJUkpLT2VhMHc3N2hwMU5Hb2VoSm1PMHJyMkVM?=
 =?utf-8?B?c3pldXNmV0VtN1dMTWh6WmVyM1doNlZkVXJhbExHSkRERy9QYlR0enRoQndD?=
 =?utf-8?B?ZmJDZURvdXFZNFIrb2QxR0V1VmJ6NXZIZWpjSmVxL1IyOTdoQnRSVEFCaFN1?=
 =?utf-8?B?ajYva3FoSlIyMlh3L21EWVYzWUdSK3Vna0RtRGovSlVrSk0xNEk4OVVvaGdV?=
 =?utf-8?B?WDBJTlZTU2hMWnpnd1UxZERnZWorS0o1Tno4Y0RDRFk0M3dJZUgzZFdldVpB?=
 =?utf-8?B?Qkk5dWI5UkF3OXJIM1FJaW9nZW1vU2VFZnRtZERoaWdxMDJnVTVmblZJK0E4?=
 =?utf-8?B?aEFUWDlDYmJqUk5lZ0tuUngzL1FHWGhUdmc1VGpwUlpKV0VxVGZ5ZnhMWkNC?=
 =?utf-8?B?bkJQYStmTFRFanpCZmU0RWx0NDdpR0RMT1ZpS0JKdUFFWTE1NldkTWU2cld1?=
 =?utf-8?B?dWhHdmJ3cTUxaGEvdnhKcW90cWFzeUtUb1duYlJ1a1ZETzRseE5WSEtQaDB1?=
 =?utf-8?B?OGxtb3c2T3NsZnJBS2FqbXVmZ1dLaXowY3ZqaE1PeGlpZDNqYzBONkd6Lzlk?=
 =?utf-8?B?eDBESFV5SEVWbE9QMTR1c3Z2NjJQQWdwVjVSRWhPb3Zocm90cDh1NFVyK0ZV?=
 =?utf-8?B?ejBGY3I2Rmlnc0ZrZTVpUTErWEhzTU1ZNWE2aXJkb3FNSGhVb2NwbnFXb0Zw?=
 =?utf-8?B?MWJpSWg5T0dzUUZPV1g4L3hRN0ZtSC9ScXpXanpuNUNDdElIQmUwd010ZGtE?=
 =?utf-8?B?d1JBSVcvajNsYzVSM0VwMEZWZW5RMXRHUnpRbkRnNU9sRlNlc25vOVpxTG03?=
 =?utf-8?B?eVF0L3d4QThpMkFMTDIvb2hraGJRcVg4clVvaDdTNG5GdFRJbFM2SHRGZ2h4?=
 =?utf-8?B?LzAxZ2tWSUZReGhBeEhqenBiSzhPRE1QK0o0c0I1OGFIWWhObzlGYUpXOTNu?=
 =?utf-8?B?REFNZkk4U2xLejZNdWNTb1ZENy9hN0w5TEhPNk1LajdhZkpXVmpoUmhQRUdi?=
 =?utf-8?B?QnNaRiszNXdkTTF1dXF0ZGhTTFNiREhOTW1wUFlJbDlsZTVXNXlkL1lXNDN2?=
 =?utf-8?B?OTRrZmdXQjZTbUU0eDY0bm5EZnUwTGJQNForT2RwRlFxRGxSRUVkeDlQdTNW?=
 =?utf-8?B?Z2N1M1BjdlUrc2NMaFFoaHk3V0RmbnFwZ2VDUmNBc1k4TXFLZWY2RjR5K2JN?=
 =?utf-8?B?RkY3b0lVODN2VkxoKzF3UzdtbTYvYitvcFBHTDVaRVNvMTlnVWwzNWk1cUUy?=
 =?utf-8?Q?QXAfQ79eEIo/62nc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4b874b-045f-4602-7672-08da49f81673
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 09:11:50.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdlrsb2VLDEsWruldearxxthxiBZk5RKp9Vun8Sm2z74y2sQYM3j/feDOUGbafUTy/DoG9N+S442jeO5Ab8sM5EWo54hcLC1OaoN/MeCcsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3324
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_08:2022-06-07,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=988
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090037
X-Proofpoint-GUID: P17366_FrD57d_DgpRM8yurfWGbckyyE
X-Proofpoint-ORIG-GUID: P17366_FrD57d_DgpRM8yurfWGbckyyE
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 16:45, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Add some C equivalent functions of the ASM macros and implement the whole
> error_entry() as C code.

Hi,

I did some testing of your patches (on top of mainline commit
34f4335c16a5) and I see these two KASAN reports very occasionally during
boot:

1)

Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
==================================================================
BUG: KASAN: wild-memory-access in rcu_nmi_enter+0x6e/0xf0
Read of size 4 at addr ff11000034e38b10 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-14003-ga9afe081e27d
#1787
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x7d
 ? rcu_nmi_enter+0x6e/0xf0
 print_report.cold+0x188/0x667
 ? rcu_nmi_enter+0x6e/0xf0
 kasan_report+0x8a/0x1b0
 ? rcu_nmi_enter+0x6e/0xf0
 kasan_check_range+0x14d/0x1d0
 rcu_nmi_enter+0x6e/0xf0
 irqentry_enter+0x33/0x50
 common_interrupt+0x15/0xc0
 asm_common_interrupt+0x2a/0x40
RIP: 0010:identify_cpu+0x3db/0x19f0
Code: b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 d3 14
00 00 41 c7 84 24 80 00 00 00 00 00 00 00 31 c0 89 c1 0f a2 <41> 89 54
24 7c 4c 89 e2 41 89 44 24 1c 48 c1 ea 03 48 b8 00 00 00
RSP: 0000:ffffffff94807da0 EFLAGS: 00000246
RAX: 000000000000001b RBX: 00000000756e6547 RCX: 000000006c65746e
RDX: 0000000049656e69 RSI: 0000000000000000 RDI: ffffffff9509e6e0
RBP: ffffffff9509e675 R08: ffffffff9509e67c R09: 0000000000000000
R10: ffffffff9509e668 R11: fffffbfff2a13cce R12: ffffffff9509e660
R13: ffffffff9509e6e8 R14: ffffffff9509e678 R15: ffffffff9509e674
 identify_boot_cpu+0xd/0xb5
 check_bugs+0x82/0x15b5
 ? l1tf_cmdline+0x10c/0x10c
 ? do_raw_spin_unlock+0x4f/0x250
 ? _raw_spin_unlock+0x24/0x40
 ? poking_init+0x350/0x37f
 ? parse_direct_gbpages_off+0xd/0xd
 ? rcu_read_lock_bh_held+0xc0/0xc0
 start_kernel+0x38c/0x3bb
 secondary_startup_64_no_verify+0xe0/0xeb
 </TASK>
==================================================================
Disabling lock debugging due to kernel taint
x86/cpu: User Mode Instruction Prevention (UMIP) activated
numa_add_cpu cpu 0 node 0: mask now 0

2)

x86/cpu: User Mode Instruction Prevention (UMIP) activated
numa_add_cpu cpu 0 node 0: mask now 0
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Vulnerable: __user pointer sanitization and usercopy
barriers only; no swapgs barriers
Spectre V2 : Mitigation: Enhanced IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context
switch
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction
Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled
TAA: Mitigation: TSX disabled
==================================================================
BUG: KASAN: out-of-bounds in rcu_nmi_enter+0x6e/0xf0
Read of size 4 at addr ff11000034e38b10 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-14003-ga9afe081e27d
#1787
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x7d
 print_report.cold+0x9c/0x667
 ? rcu_nmi_enter+0x6e/0xf0
 kasan_report+0x8a/0x1b0
 ? rcu_nmi_enter+0x6e/0xf0
 kasan_check_range+0x14d/0x1d0
 rcu_nmi_enter+0x6e/0xf0
 irqentry_enter+0x33/0x50
 common_interrupt+0x15/0xc0
 asm_common_interrupt+0x2a/0x40
RIP: 0010:text_poke_early+0x97/0x9e
Code: 8e 00 f8 fd 48 85 db 74 01 fb eb 05 0f 1f 00 eb 16 8c d0 50 54 48
83 04 24 08 9c 8c c8 50 68 13 ec 12 b1 48 cf eb 03 0f 01 e8 <5b> 5d 41
5c 41 5d c3 41 57 b8 ff ff 37 00 41 56 48 c1 e0 2a 41 55
RSP: 0000:ffffffffb0007c10 EFLAGS: 00000292
RAX: 0000000000000010 RBX: 0000000000000200 RCX: 1ffffffff61137c9
RDX: 0000000000000000 RSI: ffffffffaf69f720 RDI: ffffffffaf7f9ce0
RBP: ffffffffacc6902c R08: 0000000000000001 R09: 0000000000000001
R10: ffffffffacc69030 R11: fffffbfff598d206 R12: ffffffffb0007c80
R13: 0000000000000005 R14: ffffffffb0007c85 R15: ffffffffb0007c80
 ? kasan_check_range+0x1c/0x1d0
 ? kasan_check_range+0x20/0x1d0
 ? kasan_check_range+0x1c/0x1d0
 apply_alternatives+0x79e/0x81d
 ? text_poke_early+0x9e/0x9e
 ? xas_clear_mark+0x1df/0x270
 ? apply_retpolines+0x4e4/0x535
 ? apply_alternatives+0x81d/0x81d
 ? delay_halt+0x31/0x60
 ? delay_halt+0x40/0x60
 ? delay_halt+0x36/0x60
 ? optimize_nops+0x225/0x225
 alternative_instructions+0x43/0x11a
 check_bugs+0x14fb/0x15b5
 ? l1tf_cmdline+0x10c/0x10c
 ? do_raw_spin_unlock+0x4f/0x250
 ? quirk_disable_msi.part.0+0x72/0x73
 ? poking_init+0x350/0x37f
 ? parse_direct_gbpages_off+0xd/0xd
 ? rcu_read_lock_bh_held+0xc0/0xc0
 start_kernel+0x38c/0x3bb
 secondary_startup_64_no_verify+0xe0/0xeb
 </TASK>

The buggy address belongs to the physical page:
page:ffd4000000d38e00 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x34e38
flags: 0x100000000001000(reserved|node=0|zone=1)
raw: 0100000000001000 ffd4000000d38e08 ffd4000000d38e08 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ff11000034e38a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ff11000034e38a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ff11000034e38b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ff11000034e38b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ff11000034e38c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Disabling lock debugging due to kernel taint
debug: unmapping init [mem 0xffffffffb12b8000-0xffffffffb12c2fff]
smpboot: CPU0: Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (family:
0x6, model: 0x6a, stepping: 0x6)

I'll try to get more details (boot options, configs, full logs, etc.), I
just wanted to give a heads up in case anything sticks out.


Vegard
