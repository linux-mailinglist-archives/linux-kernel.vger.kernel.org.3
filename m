Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B3557D23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFWNgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiFWNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:36:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8452F665
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:36:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NAno3K003411;
        Thu, 23 Jun 2022 13:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=w6j7CkkoMrLWSVNGUjl0/+3PJLErj4cmQzKcD1YkyvY=;
 b=es4ftRkeaS8RQUqPdet4ZzTEIXoyA4WiQown+f6hWVe8F0tK+4uRySHGZ8M5V6TZvFOi
 X+xYCzYrwKzrsWMwEKrzOfJ8Wyv98fPb2KlnLDnxYTk4mzM/pHyEXLEegkKa4wGomUVR
 6eNhHgQkVMUlnSdeTa8ddyHaZ+rMxYGWW0Y+0LuOuhMpTBrWuPSieFY1ewOAgUjV/0og
 VVjuGzm8AmIc0/Im+Tca3fqYo1IwSGE3wRcz4o0s+MpTFGAdXJG0hc50xcylF7Uzo/pO
 RfzFTRVGRj3uVudkM80fSd/gL/tJBFR5gV7l6BprMGH5MiMvP5nqnjLnoP5yU6i/oc82 Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u359c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 13:35:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NDUbkL027481;
        Thu, 23 Jun 2022 13:35:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9wajjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 13:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZonoPnQt8mtB3BAHKabwNvKJ6Lm/fbwfxGDrjjNxzsLUcbq9DVp7TSPsnLRHNJJfjqU7zBsFsU++O3SP1O+ZNM3LmlEnS2LCxpRI3Tm7X5CiVCZSu2T6RFWXBHeHi8Qixtsna8rWH3SrFLa6kmFsjwKcY60MH6cvKUzYu75LhoFIIyW6nF9LTXEjJs0v2OSP8i3PNbu8NJilIeTf79kq3SX5k3yE0rEov9P2dbIv94ZeLeIJ0ttqlS3hq9xbTXYVMhaWj/j4WVLMCBSwA/etRoaT5bCY0HmUqhZBG/TwFrwCDiFb+Kyr0BzGnuN4BDbm9JfCPmEuvXOshdd2/FQU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6j7CkkoMrLWSVNGUjl0/+3PJLErj4cmQzKcD1YkyvY=;
 b=ZXytbR4W0CEdFsgfkhc8EWYXN3aRavoACOopAmqDthSb/1G128+WxtKSxTrpGzXV1b2WmpSn6di24dSEmHxz+dGl7SGYIgK+5GGAqhjQTGyvUzvagMdnXDi6hyLm0JVlQZmvRdmlyWLPE/Uec5JN5a/UohPgYJrpbNiodbjUpgkWpew1DjGnd80CDTqikWVxHuuo/D6yynun8MjyCzCLOsE/Ra+hB51EWJGOBRjSNBYwxXZ+RSnKJ/D01DyfsF0JeZLZzsB1j9LjqX9YvxCqTHG84tePVfl8RzcwdhaIOhgfsCHs+mLTj/TuHfd22ZxK4xTBGgWYiN7KfmWzbH5TtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6j7CkkoMrLWSVNGUjl0/+3PJLErj4cmQzKcD1YkyvY=;
 b=XYGA2UVDO7PGka2h67N9YHuSYwpnWfevnlmx1o9jeUuNhiLWvaoTbdDDzDrglOabg2Fhjb4Rf9X/us7uxqts6obPoOpC5kbqGaAyIbSFvTwdWnP1Q2ti1ZzhN08FVR9lYjUy2+JiORO9FM3/BO1sQcgm7EziAzA2OQze6TugNXE=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 13:35:48 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 13:35:48 +0000
Message-ID: <43518b7f-04e9-9a8b-891e-ee6147b11312@oracle.com>
Date:   Thu, 23 Jun 2022 08:35:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220622200419.778799-1-longman@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220622200419.778799-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::24) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a019359-21d8-4ada-a3b1-08da551d484f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB428944D2BD4C2111A39CB074C7B59@BY5PR10MB4289.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UurPTUHSwR2G3ngPXqAC1DjCLj1O3bOxlLGLL+4vyTgtLQQphB0Z7B8oUhXtCOSzealcdNpOuv6nYjScjsGiudzlV9TYtlQZVmNl1Un9XMMDtW/IMGr6R2cAg7c2OoTKa1OdV6JKPLvSfvU9jgsEHYm3OW9PVMNlOn8UeJ1MXheeF7tyTNhw5KWo0xoObeGzoFmCTYri++6JyKbtQBIRqGGc8BQDeWpIPPuNRveW426Hhg++6ncL+azIqpKZ9UU+Uxu/1c6ORC8fL4PGDecl7ZGT4xTiFheKSNDQH6hfDg3m6TGJw5EQyRkoT2u2fWiZBKyBY2tb2Vx80NFOWvuSOjJuRqyv3Plp+1AOIcjCjKaNG2Gy33UvbuQCJDrNpYGFzn1oMuDNCHIIh236AsY38yNSLRf0t1qXfkVad2Qs0RZE1ZrFdu/1b1wSNb2nkLtQ12WhpRVjImqkusRQ4Xf/b5UZdNeYPDD6UGcDvYzyAxtervKTDsjNCCZ2h2tj2COSFBLUEkvoXWtwbLmPHOAbeDSzyaq9AuaLosnBVISfYCZismCWiTyBPEDSwzzL49JxvFzA3072RI8bmcd+grhCB0GQbyPddJOAt21Mv8tsMuvjj7UfbX7kdZO2WRDNIWm4QSkTS/X2SihmaDg8PF/iFb9helXpiBPiRhKSGRyt8uNLfXbZ/IBJJFtMgnZEeQ9Y1L9iNKpKWy1ElTPrzUkf74yvme7BbUqWZS+VyflFawJOv+Xe6X/y/J/5CaxbJQwH1u7MHU+pP78687uM3Y9YxmCqaYho+Eu014PY5ZlEVNr8rLLM8+9KawBWnUmGbuMA/tPJjaSF1SSIzhtnzCJjYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(396003)(136003)(6486002)(5660300002)(966005)(478600001)(6512007)(4326008)(66556008)(8676002)(66476007)(31696002)(66946007)(8936002)(83380400001)(9686003)(26005)(316002)(54906003)(86362001)(36756003)(53546011)(186003)(6506007)(31686004)(2906002)(38100700002)(2616005)(41300700001)(6666004)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RxUUZoSWV5c0xpenRMcU54WFUrVlNxM2tVaHRvTHpway9YbWc5NlN6WnhU?=
 =?utf-8?B?L3N2SWt0WldkeUNlZEYzTm1tb0NKTWRTNlByZWoxM1Z4cGs1VkNQQjJyb2xu?=
 =?utf-8?B?VUxLVGtDd0RnTWxpcG5CeWxRODQvZVhvY2VHTnU1S1J4U0lKbDNoWHl6TG1i?=
 =?utf-8?B?dDJHODN6ZVZMVUdrOW5HKzRvVDQzSFF0Umo5VXhRN2s5TGRabTNyRVVoL2p2?=
 =?utf-8?B?QUMyaTFoOE5pejBaa3BOZGwxcFZ4RHkvWVpiM3NvVFZKcFBZRzFJc0dJMjNM?=
 =?utf-8?B?SGxHVkgwTUQzUXdSdklpN1Ywb2R1ejVFbSsrYUxCaldsa2RoSWpacnkzVFNn?=
 =?utf-8?B?ZXRGc3IwUDJENnNTYTFNbjdVbVhqWnRHMXhXaXhNUzNNbkoxR0lHYzBySTVs?=
 =?utf-8?B?MkNKUXJ0S3hDcS9sSUN4RlFrQ2c2blpDU3NKbTlPZGsza2oyc09uaWQxWUsr?=
 =?utf-8?B?alFjNXZGSVFRYkdtVGp0cVc5MU9VZlZUQ2lvZ2JWSEwwMEFZRWxnVmhveThv?=
 =?utf-8?B?S09iYUVUV0M5eGp4d3hMU3RXZkxRbmMxZTJBUjIxMUFnWHdJa1FTY1Fjc2R1?=
 =?utf-8?B?VFpyelh5NVh1cDAwNmFvMS9Mcys3anluaWpKK3Q1ZUxuT2xWSjJheW9xYzNB?=
 =?utf-8?B?ejU1MjlZZE1zMzlKY1RidGp6YWJxSityVEtuTEJuZ3NTVy9LNUY1aU5BdnVi?=
 =?utf-8?B?S1VOaWZla01ZV255WlNXRVR4UlJGOTFNQ2ZmdFhDZ2RuTGk2QmNMMExXTGdu?=
 =?utf-8?B?RzkrSy85TjJBQitoVWFrWTE5TEVWQld2ZkdKbmlobEl2UlJneUtDQ2kweVU5?=
 =?utf-8?B?dUxlSjRnY01lUUp1UUhIZ3dJUWFIZWFNelhQVXFSQ0J1OGFSbzBxTWxSOXhu?=
 =?utf-8?B?VWdxOEtSZUREZmY2TXhScytVVytyalNMZnhNRTIrYWpjU2VvZ2xnbHhCZ1pk?=
 =?utf-8?B?ajh2MTJ0Zi9CYncyYUIvc1Bpcmx0aGxuNkVkRVRLTXBjajZRYno4K3BxNU9s?=
 =?utf-8?B?RU9OZnBGQ21oWGpFSFRzWFVZUjZSb3Blc0I2S0FDbDBxNy91clF2K1gxL2JQ?=
 =?utf-8?B?MFdQYlBONVRNSW5rRDE0b1FmVWpsYm1DbzZQQ3N0VHRhSlFHZVdmM3dEMnVL?=
 =?utf-8?B?cSt3R1dQN1hmTjNUWi9LZVRsSmp1V0NFRnJCSjZVVTVvUk5EdUVjUVN1L2Rt?=
 =?utf-8?B?eFhtL2I2UHlvQ0MzeWNnN1dyejZ2U0R0VXRrVHVFbzNkVGJhZm1reFdwYlhI?=
 =?utf-8?B?UWxDakVLYngzZ2JGRy9LREVjM0s5TTJSUkVrTUdyd1d1NUp2Q0UzNWh1UHU1?=
 =?utf-8?B?bFYzeHJ0MlhudGRPS0R0d1VienRDNHJ4VmJOWTZkS1RncmVROVVXWWkwNE1i?=
 =?utf-8?B?cXIzS2FsSStLREI1OVNXZk1FanppWWVvdDFTdVJrN2tjeHRuQ0lnM3ZuVU5V?=
 =?utf-8?B?NkhYbnV0WWZpVnpsVVVwTjR5UE9sTHUyMWovM1htcGFoOXFIS2w2VVpZRFJR?=
 =?utf-8?B?Yk5QdEE5SzZlRlQxTyt6VVhhQWRQMmZaYTlmZFhaU3pVb0p4SDBtNFd1MUtY?=
 =?utf-8?B?Y21uY1J6TXhTUkxxblFadHkzMTRUa1VTeGsxaUdCNVpIcm9oNTFTdHdKRnNt?=
 =?utf-8?B?VGtra2VoRDhkV0pxb0ZjNVZuZmJ3dThlUkpVVDA5bnpSNU9UNUdjK3BmN1FM?=
 =?utf-8?B?RWtTZ0dwUGl2aXBURVBjQ2I5SkJCYkFSWkIvTjZsNzlaaWNnbDN1WmtSSm8r?=
 =?utf-8?B?ZWZuN1VLaGdSbTdyRmVoUko2cnI2Z0loSnVNOHZhbHdXQ1luWkZjcVk1R2E5?=
 =?utf-8?B?QkVDdW1IKzVFWnZlYVRyTDcvTU5rQlZEQUdONHpJeEg3bzl4SzJQZHM5cnpX?=
 =?utf-8?B?ZzJpYnlmQmRmNXFzTXM4NDg1YU1Ja01PekRzMHhOcDJKSVRIUUtaODZnOVlZ?=
 =?utf-8?B?ODlCTko5S1ZpWUkycktrZ0tpbTV6SUk5ZTdadG1OTVhUL210dW1mQjg1Y1dF?=
 =?utf-8?B?Y09oRTVVSFZyRzE3VFN2OVFHYlFsRE9VbHpwQlcvdk1xQnZlQ3JiVHlMWlMw?=
 =?utf-8?B?dld0MUxUY2EybnZ3QWtBUnJEUWpYZzlQd3lReDlEVkpRVTdQOU9Gd3psYmFL?=
 =?utf-8?B?WnliSmFBamlpUml0cVZjZm1JNE9uSXZhZzlKNmFpRzl6LytqRWJEL2ZRMUV4?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a019359-21d8-4ada-a3b1-08da551d484f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:35:48.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvyJc8NgRlmviAMTh2aOqFUsmcg3ZGeqxHXqT5etWrbt9hx32n68UKnmCdLU37wuuUnh3e2fDnMmYuqBxY2RAYDorxSz6SqDNtcHEZ4f/as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_05:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230055
X-Proofpoint-GUID: -5dHQNIN4LFLVFn2zCXjLtIp_bl6bP_-
X-Proofpoint-ORIG-GUID: -5dHQNIN4LFLVFn2zCXjLtIp_bl6bP_-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 3:04 PM, Waiman Long wrote:
> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
> consistent"), the writer that sets the handoff bit can be interrupted
> out without clearing the bit if the wait queue isn't empty. This disables
> reader and writer optimistic lock spinning and stealing.
> 
> Now if a non-first writer in the queue is somehow woken up or a new
> waiter enters the slowpath, it can't acquire the lock.  This is not the
> case before commit d257cc8cb8d5 as the writer that set the handoff bit
> will clear it when exiting out via the out_nolock path. This is less
> efficient as the busy rwsem stays in an unlock state for a longer time.
> 
> In some cases, this new behavior may cause lockups as shown in [1] and
> [2].
> 
> This patch allows a non-first writer to ignore the handoff bit if it
> is not originally set or initiated by the first waiter. This patch is
> shown to be effective in fixing the lockup problem reported in [1].
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/lkml/20220617134325.GC30825@techsingularity.net/__;!!ACWV5N9M2RV99hQ!MtLCpFzIovhhzojTACH793QVlr1c2eCOsHnjbuB6O3ydj5cqhlZUjVchbfnbMeD4kQ5AsgjVmX0hGfREWPrEAA$
> [2] https://urldefense.com/v3/__https://lore.kernel.org/lkml/3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com/__;!!ACWV5N9M2RV99hQ!MtLCpFzIovhhzojTACH793QVlr1c2eCOsHnjbuB6O3ydj5cqhlZUjVchbfnbMeD4kQ5AsgjVmX0hGfQCd2bHaQ$
> 
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Tested-by: Mel Gorman <mgorman@techsingularity.net>

acked-by: John Donnelly  <john.p.donnelly@oracle.com>


Hi,

If you send the .patch offline as a attachment we can test it here too 
if needed in 5.19.x tip.

My email client doesn't like inline patches.



> --- >   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9d1db4a54d34..ffd6188d4a7c 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -335,8 +335,6 @@ struct rwsem_waiter {
>   	struct task_struct *task;
>   	enum rwsem_waiter_type type;
>   	unsigned long timeout;
> -
> -	/* Writer only, not initialized in reader */
>   	bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
> @@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>   			 * to give up the lock), request a HANDOFF to
>   			 * force the issue.
>   			 */
> -			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
> -			    time_after(jiffies, waiter->timeout)) {
> -				adjustment -= RWSEM_FLAG_HANDOFF;
> -				lockevent_inc(rwsem_rlock_handoff);
> +			if (time_after(jiffies, waiter->timeout)) {
> +				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
> +					adjustment -= RWSEM_FLAG_HANDOFF;
> +					lockevent_inc(rwsem_rlock_handoff);
> +				}
> +				waiter->handoff_set = true;
>   			}
>   
>   			atomic_long_add(-adjustment, &sem->count);
> @@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   					struct rwsem_waiter *waiter)
>   {
> -	bool first = rwsem_first_waiter(sem) == waiter;
> +	struct rwsem_waiter *first =  rwsem_first_waiter(sem);
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
> @@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   
>   		if (has_handoff) {
> -			if (!first)
> +			/*
> +			 * Honor handoff bit and yield only when the first
> +			 * waiter is the one that set it. Otherwisee, we
> +			 * still try to acquire the rwsem.
> +			 */
> +			if (first->handoff_set && (waiter != first))
>   				return false;
>   
> -			/* First waiter inherits a previously set handoff bit */
> -			waiter->handoff_set = true;
> +			/*
> +			 * First waiter can inherit a previously set handoff
> +			 * bit and spin on rwsem if lock acquisition fails.
> +			 */
> +			if (waiter == first)
> +				waiter->handoff_set = true;
>   		}
>   
>   		new = count;
> @@ -1027,6 +1036,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	waiter.task = current;
>   	waiter.type = RWSEM_WAITING_FOR_READ;
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> +	waiter.handoff_set = false;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	if (list_empty(&sem->wait_list)) {

