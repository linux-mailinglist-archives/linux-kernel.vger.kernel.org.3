Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74495805EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGYUst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGYUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:48:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3865D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:48:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PKhoGR008803;
        Mon, 25 Jul 2022 20:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QUsg1I9/CaAjDKyQ8r5mqHTb3KdEpWdYfi5h2h3wmg4=;
 b=uVJyYcyQAK1XBDo9BCZhrgGMcGoHIYgpF1Wl4csJvWwyVDW+svGvSGc6rd/7b27b8+ti
 yGmy8bsu1aIYIjX076mcmeYUU4GTNvysikodb3nOb46dOKgybkMhVhUjKf/bm5tUaI3S
 NRzbDTQroQp8Wv9D+cOi1zVgnJ8uAx9RPjJnOFHFAE7rUdhFdV0vcfASU3e9Y1k0vuhN
 RLhcAvLJMGq7Sjw9MJ94gKqGZnLbT3kDcqMAMVP0JrZI80FqhKWDryDPQanYBqRn/OjH
 vNBISez3OJF9kzI/kLl/3oqmgPzqjzl8Elttj3ZYOcqMMv0vuPdbtcKYjFmZKB9YDmRs rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4mpke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 20:47:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PKM0tQ017379;
        Mon, 25 Jul 2022 20:47:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64ys353-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 20:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnGmskViF5qdb+ZT99gHTjyVXBKVPkZ/vgV67X/MpZX32hogysuNEKlJxvseygt4tYY/5JUyG5JrsvZslDwq6TyJ/1C4XT6vkLKcXr4mChMdb2kdvjNYnvQdRNdSqZT0SmHUBSg5Jw1+6mXigMD5/EDM+3NnGQIdCbzTRPOMjzlBNE4iRUYl1I1tgcmnJFZmG3eaJAGAxQdbZBwyQ7jEVQjdwzamFMRuSpmoiJiVaMxgdfFngrUy7CHLxDhvFKwnYH8pLW4gBSI3tbr2OuCpNHiWWOe8VxCWI6TBLsHTAnASsPQJUJSVQ2vmTD08LTl+aKSUEIlU+9giAN0vPJTHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUsg1I9/CaAjDKyQ8r5mqHTb3KdEpWdYfi5h2h3wmg4=;
 b=EbqgqIn3F0eik4MjJ92lPjQyybVZ3NkRhiOQQlUNPjFiD66mhQjSdS8jsNcGTE53RviwnJ/tvMln7l41lN66au4zIc79XMPKUJcWSpvKpqsYf0eais8kDfMlgQelLcZ2L1ERQPwWcGNU6ty8+m3S+14mRbtfHKr67HKSr+5BVO4xuj8jtaklRbIBxLa3xF2csLhBs/0/qqgeWgr96CXwUDPDtltkrVZe8WLtRJsWeBU2fsdlgsfD45VuzDhOg286u4nleFmhO7o1YQmucHBQ1CiAbvbPQU/4VUPtbOEO8ySDScEzlVIQA7BVG5wHKs5AcIGlK4SrmUIAjwP59f0WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUsg1I9/CaAjDKyQ8r5mqHTb3KdEpWdYfi5h2h3wmg4=;
 b=LAsSm/fR2KnzL3/lkkPHhJ4t94iOnAvC87faD8G0nfHEAo7Ft6oD01rW5zwz9C1pAbSQkJ8k10lvuiktCRvXsUb/zw2TPdyE9jkok9Vrv/rXx3+NMKlr3x3a4Lm63wlBcz2z3mxCDyrqeHmo3TMvuE0YyU4N8eeoPWQH9xaR/wQ=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5283.namprd10.prod.outlook.com (2603:10b6:208:325::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 20:46:59 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 20:46:59 +0000
Message-ID: <ea76eda5-2736-aacc-5256-2bee7b9247fa@oracle.com>
Date:   Mon, 25 Jul 2022 16:46:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <Jane.Malalane@citrix.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xen-devel <xen-devel@lists.xenproject.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
 <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
 <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
 <b0124d4d-32c9-01d3-36e7-9890ea990fdf@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <b0124d4d-32c9-01d3-36e7-9890ea990fdf@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708a937b-6ec0-402c-a09d-08da6e7ed1ac
X-MS-TrafficTypeDiagnostic: BLAPR10MB5283:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pu2/ubNIdW2gMQwF/6o+1P2VAyXwXPIbTYgg3RCiPHtlatmB7lzDy8l6TfwiUkSy9UPmXAhkRANQN3tTieDkgSVFwGgP/KHXnHy37+vRbI0yuV8isG1yJeBsrXQH8sfqY0mmv3kocDUMrCaw+sP/2q8s5bLVoLLPAAO7ch5Uw7EpmYx4HcjUuZv/eoJfyqucJ3nkCSs9IQfK1l9wBhwUe9IG8RDbExyRNvczWCHBui6KCgMtg96SN9kt5/ez5NrMdfM4ppf4aImD9kC45LI7ysLHtEIwQ90fuP3oVF3jwFPzbNaBuZE80sbV8D1MdF6ZTfuJrHIc0CZ6rbdN/5x6pII13B5/oY6DizqMl5z5Vu6ge+V4rUMR6yNJ2qUQ2gDORGp1R7h8oQ76w4bFm//D5cvRSwT/bW79IrWIWiIvdxZMdK5lQILxbhYQY56aBudROZiTyMF8+1U5UG+noesYLKhFGXzD/oM3zL09FRkvevQO2QvdM0eimJzm3pRZbKYGiqn5bJA4c6lWFzzrandS91End3Bu7XETq7f6q2gv2eJi6nxZUODOmXLoTp0IpbWawT1vBhnn5ys3/1w5h9yQsJQe/moayBuG/9W6nDRssC13dmZpAEi4/3DvoA2D0opDoy2JvpS+rPDAxKMaU+qk2DL2s6P0WnrSmdV4c6iswYLIt4m+idcVtNulj12B6ZFlZhKz710F/4Uqp3ZwRL1yorKuB5Zdz9Bde1FrNL2bP9SI3DynozgEeA/VbBrHBEiiqZ3xilTL54QI089gvdovyazQB8+DDvyqraBnemXbwYHWTdTCpENH0lD5q6hQWHBhtAGNHtq7TM0y+Cdgac6Vsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(39860400002)(376002)(396003)(86362001)(31696002)(6506007)(26005)(83380400001)(53546011)(36756003)(2616005)(186003)(31686004)(6666004)(41300700001)(38100700002)(110136005)(54906003)(6486002)(316002)(5660300002)(8936002)(44832011)(66946007)(8676002)(4326008)(66476007)(7416002)(66556008)(2906002)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hURnNCZkRzK2RpR081SHpMTlcwTjFQWGNlK1RDUi9YYXNEVG01cFBlaStM?=
 =?utf-8?B?U2RIcVlJS2ZIQnJnNkdxdFdHNllic083Ui8rZHlhd0dLZ0dJcU54YzdzQm5p?=
 =?utf-8?B?K0NDWWd4Rm1mam5MV1A1b0gxajVpTmVXQVJvVkxvazFiZU5mdGVYVFE4Tklt?=
 =?utf-8?B?U1Q2RlFIYm9za3pqRHd2bytRdWE4a1JvL1E4YTE5aGpDVlplamlhRm5uUDJ0?=
 =?utf-8?B?NHJndFhvdUlFS2pTNkxTV2k0RktrQ2t5U0FYdDZtS2k3R205TEpFMnM5YVZT?=
 =?utf-8?B?MUdpOXQwbWtnMkZCdGJZR2U3NnpJM0U5Z3dabzdnc2gvSldQWE5kWkdyUzA3?=
 =?utf-8?B?SmZNNS8yalprcnR1ZUMweWRuekhPV3RSRGRMdlFYaXZTOHVVWk1ZeWRaK1E1?=
 =?utf-8?B?ajJQQUkxZzdGUFRPZGRROFB4blBxUm5rd1k3aUlxUHQveTYxOEo1YlJFRlBO?=
 =?utf-8?B?a0dnU21FRmFoSVpYMk1LcVovR2VUR2RvT05xS1RWd04wbE1YSDhsckNuZ29D?=
 =?utf-8?B?ZlJUcEc1Vm1pWThBcnRWVjY5Y3VvVmNUUHhJRS9VNWZyV0ZwSFZKTEIrOFlK?=
 =?utf-8?B?T1ROeEpqYyszckEzdyt3T2VIdnlkSGR5UU1LeUk5Ny9EN0lXYWF5ZmMxQXVn?=
 =?utf-8?B?RlJUSlIwamNCMi9tNndBbEI5MFY1N0dOMHpabENpZ3k5RnUveXNUTVZGVk5p?=
 =?utf-8?B?VXR0aSt0VTV4dGNQb1Q4ektsVTZqaW5LYUxDUE83Z1NYdWgrdGRjTUwvR1p5?=
 =?utf-8?B?Zms4MWEycmNueDgvQ28rMjJTVHpxNjBGZEpPVm1sNmJPajFwdTZubjVRUnVq?=
 =?utf-8?B?T25RcmxqWmFmdVB3d1k5V0c0SVpQS0NleThWL0RZeXhxMU81U282cDRVU1Av?=
 =?utf-8?B?L3RScWwzcW5JcWF3d0c3Yzd4QlE3MEtIbUVXWlpXcU1ScnphRnNyc3h5SEtv?=
 =?utf-8?B?bjVvekU1VnQ2SlpSczFTWlFTc1BVTTY2RlZFQUZNeTlJbVRpU25WM0tuY0Ja?=
 =?utf-8?B?TjQ1N2ZCSmNCNE9UV1FTQzQ0SXJDb28xV0ExTU1hWXpSbXRYdmVpSmFxbFRI?=
 =?utf-8?B?VVdxblB6Vm9kYkg1M3VkSTVUWXJIRnJCbnFvTE40MzhFSTl3a3JhREt3TXA2?=
 =?utf-8?B?TENaUkhRanM5bFNmOFY0MXlqZncweEpQbzlKL1RHVCt5VFE3c2xSbkNOTDM3?=
 =?utf-8?B?SGlpbHRGa0RYVUV5Qkw0ak1HSEhWMU5nd20wLy9uaFZ4K2ZHdzdubUM1QjNx?=
 =?utf-8?B?eGRGQ0FnRkxqTUNqWG8zV2xiUnVKbjc5YXdKNmQxZDFmYlJvL1lBNkh5YzlH?=
 =?utf-8?B?Wk1lek93YUdXaVo0MzgzMVVqaXhCMXFxMlk3MTJDTVRBa0M5MC8ydXZESi8w?=
 =?utf-8?B?c0htUjFYeHhUNHNpNnpvaTg1L1FsenhOdEFRWE8yR2g5cVYwTVcvQ3FSVVYy?=
 =?utf-8?B?NUdNSlVHY25RZG1vSVkvU2xETnpEY011MnJpNkgxUE1leFJ4NFM0M0NvQ1pw?=
 =?utf-8?B?aWlIdTNucXN2WTVHcWxXdXA3L1JBVnRtVE5Sd0FHb0hBSjNHZU1LdFNjODc2?=
 =?utf-8?B?THh5M1o4RUZSS09EdWNHRnAxRHdwT2J0OU9xNUdBUmZ4aUhyK2FSY3U0dDd4?=
 =?utf-8?B?eTVBY1ZKdk5ETUQ5bGlXMW82dmVSTytTTFRvU0RxTzlKYlBzNmNmVHpQamVn?=
 =?utf-8?B?Q2hZdlEvTlBDZmovREFGOHlYbUs2K2haMXF1cko2VTFpQ0hOaEh2TTlwb3JJ?=
 =?utf-8?B?WUsxdmNzRkdROTM3aHFkLys3anBpWTVpWk90d0VBb2VxVnZHbjZuWGlTMEZ1?=
 =?utf-8?B?cE1MRFdPb1N6RnpBYldYcy9raEJ6VjErWFhuOVJOTzg4bndBcGJzVnlTblg0?=
 =?utf-8?B?NExPS21FQllqTG9KRDBtT3QvMURZeEYxQjJiWk5XR3NUUHlxWmt6b0xCVisz?=
 =?utf-8?B?dmpqNDJQcDl0b3gxbVI4N3FTbDNYdG04MmdENHgwNlBYK2NtUGFUdm83Z2pB?=
 =?utf-8?B?MzZnTXlHcGRMSWVXbmZtc3VtUk9KSXJRbnZ2M00waHluZnJuTWNscHVvR24y?=
 =?utf-8?B?QUZnWkpoZCtXL29QSXEvM3NJSm5JQW92TStIaGVZTzc5WXlVQURHMU1OVjd2?=
 =?utf-8?B?UEJ5RkxkK3RvMjVWb2g5V2poTmRSK1Zkc2xaRGNWOHN6Yllsb3V4T0gvNjBY?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708a937b-6ec0-402c-a09d-08da6e7ed1ac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 20:46:59.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvzXvS+O9MT8EPHDpMSl5FioSDsqkawD07DWiCu+AF2IUOv/6Al3H/B7rriA6qfV8897jMxOrK0FUCHQGcu2WywMOx4cvqaaEtuvt7z+6RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250084
X-Proofpoint-ORIG-GUID: hKu8nYe2Keo72yhHldu1TYhEa_9LyMuG
X-Proofpoint-GUID: hKu8nYe2Keo72yhHldu1TYhEa_9LyMuG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/22 6:03 AM, Jane Malalane wrote:
> On 18/07/2022 14:59, Boris Ostrovsky wrote:
>> On 7/18/22 4:56 AM, Andrew Cooper wrote:
>>> On 15/07/2022 14:10, Boris Ostrovsky wrote:
>>>> On 7/15/22 5:50 AM, Andrew Cooper wrote:
>>>>> On 15/07/2022 09:18, Jane Malalane wrote:
>>>>>> On 14/07/2022 00:27, Boris Ostrovsky wrote:
>>>>>>>>          xen_hvm_smp_init();
>>>>>>>>          WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm,
>>>>>>>> xen_cpu_dead_hvm));
>>>>>>>> diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
>>>>>>>> index 9d548b0c772f..be66e027ef28 100644
>>>>>>>> --- a/arch/x86/xen/suspend_hvm.c
>>>>>>>> +++ b/arch/x86/xen/suspend_hvm.c
>>>>>>>> @@ -5,6 +5,7 @@
>>>>>>>>      #include <xen/hvm.h>
>>>>>>>>      #include <xen/features.h>
>>>>>>>>      #include <xen/interface/features.h>
>>>>>>>> +#include <xen/events.h>
>>>>>>>>      #include "xen-ops.h"
>>>>>>>> @@ -14,6 +15,23 @@ void xen_hvm_post_suspend(int suspend_cancelled)
>>>>>>>>              xen_hvm_init_shared_info();
>>>>>>>>              xen_vcpu_restore();
>>>>>>>>          }
>>>>>>>> -    xen_setup_callback_vector();
>>>>>>>> +    if (xen_ack_upcall) {
>>>>>>>> +        unsigned int cpu;
>>>>>>>> +
>>>>>>>> +        for_each_online_cpu(cpu) {
>>>>>>>> +            xen_hvm_evtchn_upcall_vector_t op = {
>>>>>>>> +                    .vector = HYPERVISOR_CALLBACK_VECTOR,
>>>>>>>> +                    .vcpu = per_cpu(xen_vcpu_id, cpu),
>>>>>>>> +            };
>>>>>>>> +
>>>>>>>> +
>>>>>>>> BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector,
>>>>>>>> +                         &op));
>>>>>>>> +            /* Trick toolstack to think we are enlightened. */
>>>>>>>> +            if (!cpu)
>>>>>>>> +                BUG_ON(xen_set_callback_via(1));
>>>>>>> What are you trying to make the toolstack aware of? That we have *a*
>>>>>>> callback (either global or percpu)?
>>>>>> Yes, specifically for the check in libxl__domain_pvcontrol_available.
>>>>> And others.
>>>>>
>>>>> This is all a giant bodge, but basically a lot of tooling uses the
>>>>> non-zero-ness of the CALLBACK_VIA param to determine whether the VM has
>>>>> Xen-aware drivers loaded or not.
>>>>>
>>>>> The value 1 is a CALLBACK_VIA value which encodes GSI 1, and the only
>>>>> reason this doesn't explode everywhere is because the
>>>>> evtchn_upcall_vector registration takes priority over GSI delivery.
>>>>>
>>>>> This is decades of tech debt piled on top of tech debt.
>>>> Feels like it (setting the callback parameter) is something that the
>>>> hypervisor should do --- no need to expose guests to this.
>>> Sensible or not, it is the ABI.
>>>
>>> Linux still needs to work (nicely) with older Xen's in the world, and we
>>> can't just retrofit a change in the hypervisor which says "btw, this ABI
>>> we've just changed now has a side effect of modifying a field that you
>>> also logically own".
>>
>> The hypercall has been around for a while so I understand ABI concerns
>> there but XEN_HVM_CPUID_UPCALL_VECTOR was introduced only a month ago.
>> Why not tie presence of this bit to no longer having to explicitly set
>> the callback field?
>>
> Any other opinions on this?
>
> (i.e., calling xen_set_callback_via(1) after
> HVMOP_set_evtchn_upcall_vector OR not exposing this to guests and
> instead having Xen call this function (in hvmop_set_evtchn_upcall_vector
> maybe) and tieing its presense to XEN_HVM_CPUID_UPCALL_VECTOR which was
> recently added)


CPUID won't help here, I wasn't thinking clearly.


Can we wrap the HVMOP_set_evtchn_upcall_vector hypercall in a function that will decide whether or not to also do xen_set_callback_via(1)?


-boris

