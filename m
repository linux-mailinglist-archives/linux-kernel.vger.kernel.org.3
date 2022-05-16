Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8CD527C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 06:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiEPEQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 00:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiEPEQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 00:16:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F8635C;
        Sun, 15 May 2022 21:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7toA82V/r37smYMshSC+P9Oxp1kTIkNes51LxCpk1BuI3Sk3LzQee6DSs4RsbI50/e3bUwHd+GqwSvVkhARNPGffl4xPDOc6jgYpdu8C94ldC9oTv5CsOK03ypaWWxfPh1FhhlVx7X2jmof5fceQO4Ye7a6cdp4CwFK4H8tfJD0Qq0dil97mEty7Fyw7GYz39pyuH4ARFcV4uLqtLsdM3qslOpBJPWF4/fCrtURGRrcxoz5FFEtsI+S1YjPEV11Js6WLnYKZIk+oUdEt3trNEaj1OXJOXtwJxMp6ihjydDdTFVej/RL///JZc+1uLALhdIqQ/dV5B/boVW8V/vPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eueE9zP9QVSm8C1d+evmUVy+UCIAGZ29w0x3stv3NA=;
 b=GzFiTFx+mHv2eUtxbPIW9Ru5IyRSEbc1jtCvg5YHK051svP1ckD1DM1KzG165JEUieYqlQirNK1cV2pxAVNqdhT93aNuKcozkcpMqErUFhtolcPFSww1TcNAc8CIvU2wCDqUGDfKVKWWqQWaGnwFQAoKqLoAoetZ1kuOvGYZIggP8S1BpUC0QBKUMMnpuQyCl6OVEkc3ru/MEg+t2PwYx0QJbm44Y00DuaBsxTeGvM9WAfrpLwL1deebqWEKUub53G76UqM4zlGf2JPfUGDZ4j1OBfu0rbBF25fcubTWakx6VkPt7AGGTG7JVqzkQ6+cEI4FKDBOhXkWHt/u+xYesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eueE9zP9QVSm8C1d+evmUVy+UCIAGZ29w0x3stv3NA=;
 b=YFzA9npvkUatukL74HANA0/VmxDt8xHg1QcrNGfUyITe/HOcLHEuiwlUV6CDmWCNkeTRNQe7jj8tEtBY++7wx55eY82i4C85QmK6yz3kkX3LZAFWxuHqMhdo1/udgx87L1HS9kl4vO7oQJay4vOmr3sjLxlui0H7IatfIUb+VVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 04:16:04 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Mon, 16 May 2022
 04:16:04 +0000
Message-ID: <3e3c1d82-581e-5a44-deed-05b5f880746c@amd.com>
Date:   Mon, 16 May 2022 09:45:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 6/8] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, irogers@google.com, yao.jin@linux.intel.com,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-7-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220509044914.1473-7-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e03167-0064-4bea-55d5-08da36f2cab5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB254727F756DDC488CD84450BE0CF9@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3DYnSM33MM79WTwTVWhG8RpzN9GIWJwN3uCAGBSExlU7ry3qAsw/8zWHdAlCE65qbwoIWuYMlOjgWcSzyDvhM8CAb3w6sTLp/aNIPkRqeHSDuALVvbqJumjEByQewd7hTpxroM9Sjeoo0X889ByZaInhcNi+IwZwsezKyyljeCeuWiVFvwFKIpTOT7X1HiYPRe46YSvkt2I+ckjTuLwTbwBe0aUcihvzSzwdjXSNW8JGS5Y0Fwx8XbBpZTuNOws49yMh3iow6cbH98zCI+z/5G8y08UKkPWzV4rlsk2OxtNOiAhRwniL53Eh92k5iCt6PmKUcYkHeUUti9V856UuWROtSN4Qda/10Yg824x8eRpd4RXqs7utManSZJ7KZczsP/XUZJE6JWdmus4sf1ngHzYvdfxtvzYWc6x+Tg00HEXn7dEFJOVUWD7fZfoYPQ1iM0OHx1uj6yr+D9vS+AYMfuXhXyhDTGNbihXHeY0WlbcBoqrRrLD0tTP9jQp4JMSi7hEc2Wc+xoUBxnofAgm29L8jTnnQmNWeoLUKB+lHICEjpBfYEW7ZhfZbFmOCA5XExLOA4YYw6aSlqb3IWNNB+yX0MG643pIaPeEE5Om3Tp3k1SXPUiBhriPTIY+dRf5iR7nDCcpInitkVZ3YOw2GgSYV/zfPTuddkASowxbkSne4nP+Wp9/jdScm8KuJONhiG7Dd7psO3N7v4YMS6rUSaAgT/34rgvKX+vnF3ce/qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31686004)(186003)(316002)(6506007)(44832011)(2906002)(508600001)(6486002)(26005)(6512007)(53546011)(66476007)(66946007)(8676002)(4326008)(66556008)(6666004)(2616005)(5660300002)(7416002)(8936002)(31696002)(38100700002)(4744005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlF4R2ZTWlFHNTVwSmdGM1lCbDdUUGkwcHVLRS9TaktnT0lHTlBLemRoNEZC?=
 =?utf-8?B?dVQrNTltb2VyRjhPYnAzamtDemdza0FsdU9uRVdReFJ5bC95UmRLaktWSlJC?=
 =?utf-8?B?UUx4SnRTTmVFb2RkaVFDeWZyandOSVBJKzgzSEpYNUpmempkU1pWKzlWUVl4?=
 =?utf-8?B?Nzc0R2F5Z3NvVFZFT0hyMmNFUExjdVpaMVBYcGRRYk5MM3lRSEZUKzZnQmI2?=
 =?utf-8?B?OGdBVUxyVllZczNwWmlnQy9QL09VajdwZHJIdHEzakptUkZRUmQ2ZnU0emFk?=
 =?utf-8?B?cjR4Yk9Rdys0ZlVxSnNkR2dVa0tSenljemY2UzE5N3VIckYzS0g5SGlKS1Zh?=
 =?utf-8?B?YUIwK2RFREIzKzlpclU1VHE4UzJoMWNyTG1YdGx2V0pBa3RhdUppeW1yWVVJ?=
 =?utf-8?B?dHl4U0lSbUtIUkRUVjZ5RHZpNjFBaTlpSURWa0JWMzFySW1vVVNkOGZZdHJ0?=
 =?utf-8?B?SnF2RllhRGJETmNoR2xEa0g5OVlVQjgvc0dhSjVMOHFVUnRTalJVcXFZQndS?=
 =?utf-8?B?NTlBb0F5REh6ekdtc0Ewb0g4NWZmY1NKVXY1aURjNWpURnR1bkxHaldaa1Nn?=
 =?utf-8?B?VkVaQ1VBNXdnUVJJbDBhMzdZRnhFNDVJV0M3R0ZWWjNUNExUeVN2ZWZaSWdG?=
 =?utf-8?B?YkxHc2tucVBxT1BRZmdISGw4bUVHdjVlUUlZU0Rialkzb250YUQrMXBIa1Mv?=
 =?utf-8?B?eVF6ejlmMzllakhKa0FnY1VvVWZEbVFHcGpuSjU3VHNSVXZKbDhKRzRCdmww?=
 =?utf-8?B?RTJ3OFowUk5GWnVXU1loZzBKbHE2MDdKZTFLSGErSkR1Vm1QTy9hRDUweDFu?=
 =?utf-8?B?b01mbnRkT3dSWXk3RERYZWZqYlZCL0Nyd2JXV2ZpSjhFN3RUTjlKNTh3aEZT?=
 =?utf-8?B?eTNDUVMyWEt4R3RiQzgxd1FiVjU1dTZBZHM0WFNLK0M0R09hMkl3NmJ6Ykdw?=
 =?utf-8?B?Um1oTks0SGg3aTkxN2dhZk9mLzU3SDJxUHczVyttRGdDbTQ2VEtFeThHcjYx?=
 =?utf-8?B?Q0dVMXBkVk40aEE1MzYxTkFmSmVwMUoxZEZlVnN0cmJ0Rjhqd05iMlNOc210?=
 =?utf-8?B?VWxrVjR0dCtxZzUrQlE5OTdMZnlvR09iWWN1dzVwTExyeFc3RVVVOHBQQ0dS?=
 =?utf-8?B?WE9xWGttVlRZQmVFT2NYSHFuUkZqQVFCWlI0TXQ2MC9IUy9reGhBOVhqTnEr?=
 =?utf-8?B?MnVDTGhpNnZrZ2cyaWhEZXpGdjh5T0NRR0g2ei9kTVl2dXNpcml1Z1dsa0Vi?=
 =?utf-8?B?RnVFZTFKRi9VejFrLzgydFNKam5hZ052WExrWTFiRENUKytFaHJ2QndCT0xY?=
 =?utf-8?B?N01UV1d5N3FwelhKNngrQUpnNjludnBubXV0M1U2VXRjbVZrWG1BYlF6Z2lI?=
 =?utf-8?B?WlJZRXhQWlAvNllJM2pxZ2ordUNCSE5uRkhDNTVMcENFblhzRkFVbTU1OVRq?=
 =?utf-8?B?aFFmNjJaUWs2U1JXMGNyOXBGY2hyVzRjVVMwc2FMM2pZVFM3MmlkZnZVVTQ5?=
 =?utf-8?B?bmt5cmQ3R0I0NDZoc2N6bzVvUVBkSGZrUS9SMVdDM25FUFRFNjFhT205a0tt?=
 =?utf-8?B?Vld4VTNGYkYxczZrVmszWWlnZTBJcVEzTURVU2s1NURoT2ZlbU5pREszSkVW?=
 =?utf-8?B?b3BSdSs0dkFtOGxSVmVLdGRySHlNOE9tUEJzSXhPZ2lGNGpPcUtzYmV2b2Vx?=
 =?utf-8?B?TCtFYkZzYWtXTUJETklWQmlWdm04dXhUczQvdjdJY0pVYmdyQWNjaEoxZzIz?=
 =?utf-8?B?bzh5N1NIemVla0E1Mnh1Q3lsczRsNVdvYS9WQ0t5ZmVQZlJ0SEdnS1dNbXhN?=
 =?utf-8?B?ME5pd2tHUzUyUFFJUWd4L2NOSUZ1b1ErN3NFZmE1a0ozTlpCbFhwZ3EzZjFj?=
 =?utf-8?B?dFFXV09GdWx5T3Vhcnl2U3lCdG5xVWJOaXRJYjNKaytqcUtjeW43VW5IZnFs?=
 =?utf-8?B?TU9xeXZzUFlRcnkyMmNZZU4wZHFWTGJuQUFheUV6WUxjVjlLNU9CbFVtQ1Ft?=
 =?utf-8?B?TWRXOFFEbGtiRG9IbUtCT1I4c3JPcElaSFFodkFtaHBDZlQzaEhrQXlpWmRX?=
 =?utf-8?B?M2krV09vYUdpQzRNTzhNSlpxR2pzMm8wU01VbkJOTmsyU0xsZ2tvQkFwS2RG?=
 =?utf-8?B?TmVsdXJQeU9zeFd0eER1amRpc29qaEhDUXdTRzlKazR0RTVlT3hXSVNNYVQ1?=
 =?utf-8?B?d2ZXMEdtSTEwcGtzMTBtZGxkRHRjNGtkTng3ejZjNHFocEN2cFVKRC9scFpZ?=
 =?utf-8?B?QWhSKzJYZDZ0OUpoM3Z6REtaUDFaNWV3T1dpblhhQjg5MmNQZzJWK21CbHdI?=
 =?utf-8?B?dDBHbkhISW83bTd1cnhEMDFiZzE2NmVrNVkzTG5uQTdYU2dHeitoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e03167-0064-4bea-55d5-08da36f2cab5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 04:16:04.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ5K83wWGVblo10caBrNbzE0GLPd89KXLXkE+FmZXyP76cPDiPLvaGWIpPX6UonoaEgSecV8Yfu1GQoAyvgvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-May-22 10:19 AM, Ravi Bangoria wrote:
> Pmus advertise their capabilities via sysfs attribute files but
> perf tool currently parses only core(cpu) pmu capabilities. Add
> support for parsing non-cpu pmu capabilities.

Arnaldo, Jiri,

Does tool side patches looks good to you? Please consider pulling them.

Thanks,
Ravi
