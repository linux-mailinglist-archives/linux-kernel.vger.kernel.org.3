Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DFE54AA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbiFNHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiFNHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:21:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D33DDE9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:20:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E6uTuP004212;
        Tue, 14 Jun 2022 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CHttJ+kp48DnuejbDIjbAqCqO7rWV/voDCrxt6wFNgA=;
 b=SRgp8FRGvtQ3u45Vy5OTwGbhhqJGNnWD3img4v7Bp0Z+pT85w8Le5x4YROH7lhT/UVHC
 S3rpaz/kOU3T+7MZ78aft6EaEfBPTeDz1UVdsY67hPYsgTDUF1i7Ye60s6xMVIYrueW2
 /eEFYcYf2g4DPljEY43LcCnTzBc1IW3TVIDAttmMuZpj6KGcCfVjRWaHO54+KVaAnHgU
 ocdxBIYFBtX8OxyyW4dxV+Vaw9YDkeWW6BdlI1mT/ykhKUTdRETNhSCpASb+eTEq3eQ+
 RnOjZvVHOQKSHXh7VDqlxX4PSwpuVbK6LIw47hcCxhAMtqmjncf0bQKs1P8AZI7svvUP AA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2n2bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:20:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E7GDWI012911;
        Tue, 14 Jun 2022 07:20:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpn2msb9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmlJyuMP7volSNbB+KgWIMVStIb2MqAMbonEYYxnBz8GFQINVCQDDOtvSnZlF8JJIuhQmxnqMSfhv9q54H8kDVq38ukPwXqvZF+oiyvwg11KZMLFtxLHlqecoF6lx2bLOwv2Ax522hQaNx3fyT4j6SuXOAh2ueKfWOT7mOksLleSrMZCoKenFWhGFdsqkw3PTE/qZ89pu0WdYIDzUGONSlPw2N0AEowTOn7tsKPb+/ttrng2/bUSbi2wJ6+ktvbSHR8bupdIIWqP4c9jgzvK3eznvNq8PS+HSVM1yAgMKsyVSZ4w5IyPF4ewFNP/gQ4ybGsL4AOkX0+WKPDUb69KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHttJ+kp48DnuejbDIjbAqCqO7rWV/voDCrxt6wFNgA=;
 b=VfGO7EQMDNquLwhqp1vWJDgRpvlxFUzfJijERO9rZPhgYPGdGd00gMHrEaeCCW+iQcBcJd4lnnEcVu13P++Wgq+GyLD9NTL4QF4kPg5WQoZIZB2uFTATfCcuMRHorP+UgX0fqU0hbcGvHw9i2UdBqPh/8IjiHWXWBMNeH5aiq148C9SrJ8i4/ViXoZ2KlNWZtToTJaDtEEelwYJp8RuX3Dpkcc3RlyevRL7sxQez+T27Wp2n+4m3z64wIXeRWmKnU9F47P41ngkZI6X00J2MwWkCNiy+tHVWQyTf7CQGXOpLVl+mtoZJY/l7omdrRpK2I1pHARH/5eO1b0UGTfOqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHttJ+kp48DnuejbDIjbAqCqO7rWV/voDCrxt6wFNgA=;
 b=YdaAPU9URepQo4dnS2/jTdEp5/Y5ELMuN61UY4ZiA9tsy71qymrA0+U0PZT9DbKKUxse+XKDiBblDxD8f6sKiZe95db9+sRvdQAWpiASdzwkUveLVfQk8HBjksTog5xeqr7Wap8+Gnq6KQb8UGsPxhxEFJ5oW2LCZYVruAUJQ1g=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5571.namprd10.prod.outlook.com (2603:10b6:303:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 07:20:31 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:20:31 +0000
Message-ID: <cb8e3574-31ac-b858-81db-2b86cb75b340@oracle.com>
Date:   Tue, 14 Jun 2022 17:20:23 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
 <20220614020840.546013-2-imran.f.khan@oracle.com>
 <Yqf+J/P1/24i6rN9@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yqf+J/P1/24i6rN9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0003.ausprd01.prod.outlook.com
 (2603:10c6:10:31::15) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed450203-d4b8-4325-741b-08da4dd65d81
X-MS-TrafficTypeDiagnostic: CO6PR10MB5571:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB55718DD17F7FEC0FFEF4E703B0AA9@CO6PR10MB5571.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsraXb5DdM3uF9zLUB0j8sqHwnQgv+Wbn5KBgPoUxWwSXnhp1RymIOdMngnYQV86LlB+UY1y9M3F70cXcKMzFCMiF+jgNLWljuj2+NYUrsBsgMs4mWhjkRZn0a76tfEoDNd0TteG/HBTAOD25tdA9JHUrp5gCeifXusj8fBluGzNcd082Xr5DbqnUFKMokFyzHngp/Sli0O3IZmp9U7besOYOOj2QoUI61WFOBdwwyfOMSMpCiGFSTTKgUIF3oNiQQt0fDcmcz+8Y2iS0rFmdoIQh/GYddpVVTUHfneEbLSkDS8lZOceZKxQCoMkOMl8f/G/OBtbr3IPJ+ihCH+o8pHyKCwq3ZU3FWzMZQEL6v6sW1TCW6G0sVCHC4oMussqhld6BNbFuRar/X4m1tZPHWwNoLxiMRty/2qUDFSpmqgswpPtRlaKUeUWY8dZgFLxxLXL5uOoITH1+he9n0OV9jtUo05uSvV2FIezzZokF3UfxfHrXfIURaRBkpo4R3K8Ck5t1S0CrD34u4rGm3WwqJ6hYDGAsbMKJUiFa/EkFp67+RgKvt/7CjXVjffUL/ubTLQ8/QNGPiZZ/FBSrmNHSgxx9e8VYS9BBWWO5S1QrxVXbze+plcjCdVT4zpvCBIL2BEcE6PNVrBnjq3euuGffwfvjXqhcaWkgp7jxe1cvX/OZaclw82ilwunJu6tI+Ls2DTD4RnNkEVivBb0IVb5bc9G5lshxUZDEWhamuyTy/V6yn+6FFUPc4Htc4zHkGk9gvQ2quigFlKUlT41HpbmDuCAZE+uQ2nZsW+OvtYymXcbL1VZ/oG3Ctc/f8zCsJqx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(5660300002)(8676002)(186003)(86362001)(31696002)(2906002)(66946007)(66556008)(66476007)(8936002)(6916009)(4326008)(316002)(31686004)(36756003)(4744005)(6666004)(508600001)(6506007)(6486002)(2616005)(6512007)(53546011)(26005)(38100700002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVmT1ZrYWNsWVFKL2lDYVVTb2dDWWNNVUhMWElCaTlKUlo0NzhXNUY5NGdV?=
 =?utf-8?B?OEFzLzNWaU1tbXE4L0dORVNNMnlZK2JsUzlwTytlQ1owLzNtM0NJcU5vUUow?=
 =?utf-8?B?WCtFQkZKWnYvS09NbUlIbG14MVZGT0UrV01sVTQ2MkhrRi9GcitneVpPUDNF?=
 =?utf-8?B?U0wyelJEaVFuY21wNHN4VkwxS1l2dUZET0pzMWxQdzZkODk2cVFtOW5SWTlU?=
 =?utf-8?B?RmU4dWMxdDZteENXZVB5WW55bWZtcmNWR1NqTWp3SCtibHF5b0NtWXROTnBp?=
 =?utf-8?B?a3J5bGVleGFlWUUxK2hvS0c4SmRZVGtZRCt1WXJ2UzcrNHhiR2NZSmN2UDl0?=
 =?utf-8?B?eEwwTDVqZENHUlljR2YrNGNhR3NyZXBrMHdibVFTV01sUnFONE5MNTNER3hI?=
 =?utf-8?B?NlZHaURKQk1pWmpOLzFXVVkzb3A0Sy9Ya1ErMXR0Nkd5Sm9LL0lLcFZMTEZO?=
 =?utf-8?B?SmpCYkoySXRWYmZueUxlRmdoUnNBNjNBQ0JXQnpERHF3TVZFeHpXUEdUT08w?=
 =?utf-8?B?cldVNXFVRVgwSWYzOWxCN2pXRWlDTDIvU3dJOWlydzJIZnk4emo5NC9yMEtF?=
 =?utf-8?B?NVF0U05UU1FLNzg3SHVINE1TQnFBM29rVDgyWTRvbGJsZXRzSlF6WklPeGlC?=
 =?utf-8?B?R1B2UU5jZ01vamJURHByYVJSbWoydHRVQlNEc1NGQXBHS2pSWXRBbjZOQ1NK?=
 =?utf-8?B?OWhrN3pLMEp3R3BOMHgxdjdFUEVadGNCbDBuVjg0QmhsM0czczJ1WEQxQitz?=
 =?utf-8?B?blhGV0F1aWc1WXJBUDYzRTM4RzMrNVV2L1cyRWpkdzBySXp6bEsxRVZQOVlT?=
 =?utf-8?B?NzZ5NnlZY2hNYzBOR0hIaUc3WVI5R0lqZWJlU2pKa1NHWnFvdndObVAxWkhk?=
 =?utf-8?B?MU43bWJNd2JYSEpYWlpqMDYrTjVYdlJ1VDdJUmNpbjQwRXluWnozbTNBWmp4?=
 =?utf-8?B?Rm1MME8vbUJxNWtNVGllMnpyMnBCRWZndjB6MWxId1JsdVEvWGYvbHBaZnZj?=
 =?utf-8?B?dENiN0dKWStHNDNNanhvRU9QRUpWNVExbHNsOC96Ui9JM2dTbVdBT0lrZzRk?=
 =?utf-8?B?bXdORnJ5dndKbGZZZlROaTQ0ZHg2akhodTJoSENIZEtjYWwzLzVjcTZ1WnZu?=
 =?utf-8?B?Y1F4S20vMTg4TWQyVENMdlh2OW16eEZOSnFXTkJsUGM3cXhwS3hNNmhQZzVm?=
 =?utf-8?B?ZVRWNmlJYzkwakhHdWRwUWowVkxuWFdXc3pHSEpxUml4VmxCNGNGcXBPRXJm?=
 =?utf-8?B?UnRsaklacU1wSS9OTDFrVENNN2RZWDBYUHYxT3l0TDFkdWFKNS9BTjlwa2p1?=
 =?utf-8?B?YkMyTWZXZTI1Rm1pejBDSGEvMUtJRlJBekRTSlFJVi9XYi9rdEN2MGh4bzRt?=
 =?utf-8?B?VFFtZnJSVnRUVmgyYWVNRzd2WUdnTzlabFppMGZZQ3JnczJibVR4YTlTVGp5?=
 =?utf-8?B?Q3pMb0tpazB5ZmZROFZxTlFiZEM3dHJVcUJJMXdJVWdsT2tNRjVFTVd1RWFI?=
 =?utf-8?B?WTg4OG1ReGpibFBwNGhVWm8xRjNPL3RPWCtBNWxuR1ZqQWY5a0JlbTBpNHp1?=
 =?utf-8?B?S21YRllEUnpVWDNYQmtub2lCQWhtQ2h3S08wWnNzNUwzU2txVmtHWEtoNWRT?=
 =?utf-8?B?d2hZM083aytHc0k2RjRCQ2ovdk52M0kwaXgyaGhUbGZ1V3VMYmVzMmNmeC9F?=
 =?utf-8?B?OThWd2JyeUxWZXBBSFljRXBUdEY1L0FSU0YwS3VTRTlQdEtUR0RuY1hlL2ZI?=
 =?utf-8?B?S2FubHViMmVIbkdoZkN5ejhQRjdMTVZDZWFzUUhtSXVUeG5LVUtScW0zTHkr?=
 =?utf-8?B?dFozRTRNWDd5UEdiNnA0MmdEK2I5YTBmb0EyNUFkVkhZY2xBWjMvN1VDN0ZT?=
 =?utf-8?B?Zld5WnA4VldObkpMZURmaE5YdVNWT2xoSGY2UVQ1TmloYTdWTDJJWURMeFBG?=
 =?utf-8?B?N0NDZkk4R1MvR2lMT093ZEdQU0RxVjFkMENBTmpGVzU2ZFI1bVRzMU9HVGFt?=
 =?utf-8?B?MCtSeDEzTzhFcU1WY3VLMnBsQWI0c0ZUZGhIR0s0TS9DSzVFVW4wZGpiTEgx?=
 =?utf-8?B?eHNDdEhwV1hyWTVMMXVMdkxYcmZFTGVObVRVdmw2U1BJRTMwWElhb3o3TW81?=
 =?utf-8?B?YThaSkY1VXcwNDBiZW1YcDJZMkdTSCs1YTRFYTVhWnUxRW0vT2ZLdVlFdkdX?=
 =?utf-8?B?bVVCQS9wRGRhdEswQXQxZzBUMTBFWGVXNDJHZWM1TmZJREpBU09NQzNNdXVG?=
 =?utf-8?B?L3dYQ3FNdTlIWnRwOTNrT2c1QVUxY2MyQlZVOHBYbHk2bHFJSVpUZDNIL1Fw?=
 =?utf-8?B?czJYZGZUMnNpWnNDSXNSMVYwK1c3TDcrSlJ3M2Rsa2t6ZFdMMC80ck1vSE1q?=
 =?utf-8?Q?uQeN8ZesevIaSwso=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed450203-d4b8-4325-741b-08da4dd65d81
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:20:31.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkqnMY/ZWm0PjbZM1z7nLV45QA62/gj/J7leIChbYIWRpFTeOK5XJmj1XR7Dq7ocYUW869SQfC3m94EbkLg3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140028
X-Proofpoint-GUID: vpfnSBiP1uttOJLNXpXU7BR_s9lrMjJV
X-Proofpoint-ORIG-GUID: vpfnSBiP1uttOJLNXpXU7BR_s9lrMjJV
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 14/6/22 1:19 pm, Tejun Heo wrote:
> On Tue, Jun 14, 2022 at 12:08:37PM +1000, Imran Khan wrote:
>> +static struct kernfs_open_node *
[...]
> 
> Hahahaha didn't know they'd be taking two different arguments. Sorry about
> the many iterations but it'd probably be better to have two different
> versions for the two argument types. Other than that, looks fine to me.
> 

No problem. I have made the changes in v6 (at [1]) to make use of 2 helpers
based on the arguments.

Thanks
 -- Imran

[1]: https://lore.kernel.org/lkml/20220614070346.810168-1-imran.f.khan@oracle.com/
