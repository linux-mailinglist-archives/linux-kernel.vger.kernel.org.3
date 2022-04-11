Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B74FBDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiDKN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbiDKN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:59:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F221AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:57:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BDLYRq028018;
        Mon, 11 Apr 2022 13:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sDtdFMFG4DR0ioZ2FHlXVhpnmgvuUIB79ZMlcQ3v1Ao=;
 b=Ka0QyoVn7RCt8599WFFfubx10gAaDeZpoWps1I/UyZKt9sXlaChDU9/U9eXy3z9DbCPM
 JG5cunZu4lC8et2DDOthsDziB10/Ym7R95AIw2avhh6Hka7a3W2Dduryr7y47mZc0FcO
 rIy/WHTIAhvudLGmB37/gjuuviLG3EkHHIC7crAgM3opS+Cc2VtsJx1RUYF1olZ4DWHu
 j8Ds9fHSCi9DvH5F1PSYlM+B1JeLaPK1uq1YPSS2/efCgHeucru7qxdZtAAUolvt8+Hr
 iW7wnYFcWmQqEdSSDdXHBu0GygG9LK3ERWMyfmVsJ7stejYx+pIiYeK9glpPcyva6yvD GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219um1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 13:54:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BDl8PP012270;
        Mon, 11 Apr 2022 13:54:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1fd52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 13:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVaIZZwBPIO9IGQxlcUGU/aL8jnyJovGKl8F5xdNPhAPwVLmqeDaQR+g4UxrgkfxkZIXavtylPtgfGQv4OjAANy1JeoZfWRBXA7Fg1SnrJYdQGm8vyqq4RbSBc3A4QW7CJGOnw9RBT5PB6VnHxAItmAdcHbxBIdh5n1/08XcA20DYWwACU/tvqNbqcNAzu4DYs3X2MTBse4fauuSVHHb7awx2TDc5DpjOxinuOO6brYTXGr0c4CI83RLCJJ+hFNdmUOCYzwfQu7VvwNI5MuusfmLCiAWotBc63HqAMk/Fkg7eM00LVDSfMkjB7EWf1Yl+UqxeqwjeHPGvVCOUlDQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDtdFMFG4DR0ioZ2FHlXVhpnmgvuUIB79ZMlcQ3v1Ao=;
 b=bC2Nyp/MHKJ4IZQfuQpArii5Um2JdERwO7OOiB0FJkUEH1uruMj7sozaowgzUz5hj8BIA+oEYMZQlrBnlUnblvttk6sB0NTO45dF8f8PkvE7GAPcfzLyeyz/omqCceHM37l6Fn+ZGKxj30BZZC+Pq0OcodVmZYfU0icwgGf8XNFoTs316mutY3h08L5mVxCWDPhRfDZCKrRlr5QFD55ei2EVf++f1YXs57TJ+jgcWR6xxsG+1zcDrnuYO0WAKDA8WmsVE+VaDHvOlfgY+sJ93BIJK3tkWgdXFsfn/8JPeTeK+Va5A1p6QVOwQgZctkH/+glmAV1DCLh5sjUoUdgnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDtdFMFG4DR0ioZ2FHlXVhpnmgvuUIB79ZMlcQ3v1Ao=;
 b=SMEhhzLeKqObyRcOA6z6RiySkanpwdcgFE3iHujTdOHYXSJ6Qo70tzG9zoxyf20f+q/Ik14ksP49bVyiZ0Imo4MDPbgNkRD4DpeXr7P+PatASvc7pHGEsCyTE03EBqIB4IV1VA0fpxAaC8TJMN7U0tmatrAwzTy0JH1V5su9IRM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN6PR10MB1379.namprd10.prod.outlook.com (2603:10b6:404:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:54:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Mon, 11 Apr 2022
 13:54:29 +0000
Message-ID: <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
Date:   Mon, 11 Apr 2022 08:54:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:5:18f::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8650bbb4-d2fc-4608-c757-08da1bc2cc28
X-MS-TrafficTypeDiagnostic: BN6PR10MB1379:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1379EA2900DA70D5495FB12497EA9@BN6PR10MB1379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0OikdN9DK13Xp1rLtDoYxcp0V676sXlwJpg311h5+qH4vOaxNTt+sODbTzUwCqoyJDadHFTgrHWmMV0PqJmvo9pHLozTn2+nUzsizRaUB31obggvMRS1ID+rPGdDDWwiu/ZiKJM3GbhaQTDIQNBB5VmKR2QALO8u/62lJgOO0WygGOtYY+FMHPPRzNx9o11bUaxWbkoDIynP7QOiCz5zYbS3JvLezTMf45/zPVy0oD/KUrKC6J0CVVsr+gEFbUZtHtC2+aLhjwWtzCUFtwVw2NAelcfIrxf34B/pdOW4IxEh7pwlmM+kP67Ed1Pr4b4gMk/2eQTkMJXTvhecgzUFOi1SjTGZQVUJWjfN4iCpeim0aC5s5BBVrP+KfuiVRv1DwKS8R4VoR76Q4qSWj4CZfh6u/iwKUmLn5Xkcl5GbK3Ikg1kl2rmzbOsKayu6B4Bxbb9wU87rIXLJvY/ULCzoaTnldfczncvbSX/m6ZE4BkIp2+viz/jR2uuIN8khAevRpoG61A64WsU6tjFspJxoKe7tymSZEmIphzCewhMFDwh1F32Td/WuDPWHcrFQTbRHsu3feEL0xntVHB6g3ISOcv2cxdz35+kBRUESBy8nwo0zCYLux/SnZJ85LO9IiXnJYviSGPLDVTEc0CBhRq4fmOVUsU91Hm0BjPwXYjCkNg4Bhbe3RY6WETeenlkHjJNRv8DgCzC3ouFEh4XKdSLd4hj7Hh2yDjw/JHXCVltyWCNl7KbNo03A1S6ZbO0vmu/7lchfENn4/QDYlp8FIUP3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38100700002)(6486002)(8676002)(86362001)(107886003)(66946007)(2616005)(508600001)(8936002)(66476007)(66556008)(6916009)(316002)(53546011)(6666004)(2906002)(6506007)(6512007)(83380400001)(31696002)(186003)(7416002)(5660300002)(36756003)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG84cjh4cVNHK0VJTE04bWcyMlJpZ0NjQnQ4UGtDaE5ZUWd4LzRIVWtGbDcw?=
 =?utf-8?B?akN4Wm1LbFF0RzA0RStEb3NFNThTRzdTelVMMGNBT2F6MmxoeExFQkxkZFll?=
 =?utf-8?B?cTUxV2J2YkpiNDg3U0tTbU1FRTAvN01XM0NJbGsxVG9qYWx5RW5yellVTEZ6?=
 =?utf-8?B?NWhzcUpkRGZubHJRUThqN2J5emRMaEJDcndtd21OckZxSjZlcThQZi8yNzZO?=
 =?utf-8?B?R1lOTVVuQnQ3b2s2LzJHOFdQOEJuUDRQckpEb3FSaGppOUF6cVNJVzREbGZD?=
 =?utf-8?B?dGtqL2cvQXp4RkRRUERYMDBrbHJmVm1KR3UrMzc0aTRRaE9waXpqS0VwcDJH?=
 =?utf-8?B?aGxpdVpqL1pMOVA2VVBBdmpOaDRwcUdQblNXTDJwNUFzN3FOQ3RKNWs1MSta?=
 =?utf-8?B?QmQ0OXg1VE9QTHhSMFpKOGdEWi93czNsV3BzRWJwYkVWT2o2R0p0d3pwdjRh?=
 =?utf-8?B?UTAzN0xIWXdja2cxT2tBT2dlVGx4V0g3OEs5L0l2b2lRR2VseGQ1dmpLbzdl?=
 =?utf-8?B?L3pXMGVIcEI0dXZyaFgxVXNObGVCM29jQ2UxOUpXWVNObTNYVUU0aFZJVGdN?=
 =?utf-8?B?RUt4T3N6dU9LeWtOYitGNG1WLytMdDVORzVmT1gvbTZRbDJNdkpGZlVMU2ZT?=
 =?utf-8?B?YjRZUU15RmFOS0ZoOGxUckxqWGVReTluUS9IMVd6S0dxaUlFVW4zb2NGcVo2?=
 =?utf-8?B?MDNzM3UyMCt4KzhuMnE1dmlOMHdsSkdwVElDd0txMFJjZjBWN3huUThJeWgv?=
 =?utf-8?B?T0FlTkFFTmlaanVLK1F6NEswbTdXWm5iVENOeTZJamFPTGF4dXdsTGRxVm5s?=
 =?utf-8?B?Q2xJaDEydXFWM0JLU09pRll1VXBCWmpkaDhpTDQwMXM0R0x4aHovdWVEd3Q2?=
 =?utf-8?B?VjEyUFIvTWtUS3pjaW5pcm5jaXpqdm9WRlJMZTZ4NlpiV1c3S1pyblFJSWxL?=
 =?utf-8?B?VjZuVERYV1lkTDFncnZJM2hWZ21TdXU0QWI5MkwvZURNSjRBUCsxbEdzV284?=
 =?utf-8?B?emFNd1piVWxaVWVpUDJPdFgrU1FVaEk5ZThIZWtGU2xiMUVrUzRGUG5VM205?=
 =?utf-8?B?TnZVVGlvVTRqQ0R0TnVWa1lycW1ZUHd6d3djaktPQWdiL0lwMFJRQ0M4Q1Zu?=
 =?utf-8?B?UG5Gem0vY0dRcXRRVndQRkFjZmtHLytvUnVMRCsyTHFTaXZBNjZvVGpWOHhB?=
 =?utf-8?B?TmlkZWZTU3N2by9BZGYvRHJqaEgrMkVCcjh6YXE4dzlCQ0VPV2ZObXBDcGVo?=
 =?utf-8?B?RWhwNHRyZ1BhZ0U5c1RtdXc5aGw5VDE1RUMwQ0V2WWluR1J1K0ZXd01pZGdJ?=
 =?utf-8?B?NmhlTHZ0UmlKcVZVNFU1TGdjbHovbkRNd09VRWFmRnNISkErdXBMNm95aVd0?=
 =?utf-8?B?aUYzdW0xK0NPUG5qVmdEQXhBUFNrUTRiRTVBcGhjLzgzTVZpRk5aRlVndmxW?=
 =?utf-8?B?MS9MZDFIQWlSZk5ET0RZSkhPeTRkdTBJMFVUa0VKQi9OVFI3bzNTbUdPcitK?=
 =?utf-8?B?Nm9ZYUZNcmdVNUxSTUpKTTd4VjN5RHhSeGxmcDh3ZVpMb3JUSG9CS3RTazk2?=
 =?utf-8?B?QlU2VWMycHR3eVpzWTk2M2pNUmlLc081ZTdRc1pENGE2amd6ZlJSRkJJbGp1?=
 =?utf-8?B?VHhzc3dpOGRUeGI3RUdQSzVSVmwxb2xPblRFRTI3ZWxJL2tzRk5GZ29oVGIy?=
 =?utf-8?B?TkR5UDAvK1NobDJ2czZTdE1GYzZQS3pPNEdSbVJ0SWhvWWVZcnpvUlhobmJv?=
 =?utf-8?B?aGgwSWJlTCtKanhIdXBBZTdKczVzd2x4V2ZUSEdTRFg3alh1RG5iOXdsL2FZ?=
 =?utf-8?B?bFZXSEhnVDZ2ZlBHYVJOTTFENFhMdUZycExSNEtPZ2wwaWxqMDRHanZVdEc4?=
 =?utf-8?B?QVJSSjZKbFlEc1hnd1lKNTBjWHFUV2FjeUI5T1lHQURhYlNiblFIOTVTallJ?=
 =?utf-8?B?NGxaSlpBSUZwQzBiZlZtdTRuNENWWDBSakprZ0QxdVFtbnFOMXpsZEZXQVVJ?=
 =?utf-8?B?eWx5RmNyV0l0My8ya05EZmFuUlVhbTN4aVFPc2RQdjdJTDRaMkM2Y1NYOXJ4?=
 =?utf-8?B?M0pwc3kyY0dSaGIrS1drM3RLUjRGSENMM1JQbitMRVNFVDBHb0ZodXNpVlBP?=
 =?utf-8?B?akdKcDRqWklwR3BlSjNIWGkwS0J3d2hhUVRoNTl6RXV2TkJ1eTg2NzAvbjJk?=
 =?utf-8?B?eHFOVlR6bnMyYWxEU2VSNEpCTVo4VFBjWUZyaDVsMENhUytYcG9yTXJrd1dR?=
 =?utf-8?B?aDNodlNEWFN4UkgvS2wySmpBR0JldWNsVkc0bGxlZGtseVMwODVjUW5wR1dH?=
 =?utf-8?B?VlFDZGtXYmpqYkMvNmJ3Z01DTzVXTUgrdDd2eVFzbHgxeHRmVWhoVElqcTBR?=
 =?utf-8?Q?acGSSLD/Oj3Uba+A6/F4y0yyVHAptBMfg0BnR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8650bbb4-d2fc-4608-c757-08da1bc2cc28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:54:29.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdoAB+N19XMpVgdHQZOCgrqGiQxT1T62iRzjSFoC4Z6VCMCZZ8Rp0h66sUbi+sLq/bVcCktW70Zd6xWH7N2cCsnc//e3sPewuFHOKepENoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1379
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_05:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110076
X-Proofpoint-GUID: GHVyGbUKKWqflbideauZD6_lTlnezhG3
X-Proofpoint-ORIG-GUID: GHVyGbUKKWqflbideauZD6_lTlnezhG3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 04:20, Baoquan He wrote:
> Hi Eric,
> 
> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> ... ...
> 
>> +static void crash_hotplug_handler(unsigned int hp_action,
>> +	unsigned long a, unsigned long b)
> 
> I am still struggling to consider if these unused parameters should be
> kept or removed. Do you foresee or feel on which ARCH they could be used?
> 
> Considering our elfcorehdr updating method, once memory or cpu changed,
> we will update elfcorehdr and cpu notes to reflect all existing memory
> regions and cpu in the current system. We could end up with having them
> but never being used. Then we may finally need to clean them up.
> 
> If you have investigated and foresee or feel they could be used on a
> certain architecture, we can keep them for the time being.

So 'hp_action' and 'a' are used within the existing patch series.
In crash_core.c, there is this bit of code:

+       kexec_crash_image->offlinecpu =
+           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+               (unsigned int)a : ~0U;

which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
I looked into removing 'a' and setting offlinecpu directly, but I thought
it better that offlinecpu be set within the safety of the kexec_mutex.
Also, Sourabh Jain's work with PowerPC utilizing this framework directly
references hp_action in the arch-specific handler.

The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
impacted memory range. I agree it looks like the memory range is currently
not useful.

Let me know what you think.
eric

> 
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>> +			a, b);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +	unsigned long start, end;
>> +
>> +	start = mhp->start_pfn << PAGE_SHIFT;
>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			start, end-start);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			start, end-start);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +	register_memory_notifier(&crash_memhp_nb);
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +				"crash/cpuhp",
>> +				crash_cpuhp_online, crash_cpuhp_offline);
>> +#endif
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
