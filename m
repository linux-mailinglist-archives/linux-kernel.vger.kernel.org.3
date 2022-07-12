Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112D57227B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiGLSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:23:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10BD13B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:23:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CIE4s2013973;
        Tue, 12 Jul 2022 18:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=wRltScwWkmwghhgjqrNNefiA/VhpDbwC0KRTcBGii/E=;
 b=KfrAIGNU6R4cPvH1Jb2bej7ui7lcNhibNesOlp4S04m5rNXtb0mJAFNcssbGFk5SalDd
 XyHAWJAwhak9PWTQiPW7Vk2D227yn0V/3PgdT2dXeeFqFYmlGJ7ld9YIIhVPoZpY78tt
 abtHi1gu/Kxhmvf4/2sFTujk/QH9VXfQ4XfxpNcecwa8yyBQSYxc+4Cz6Rnz+kQu8TV0
 EAlSXBLaMoRdjGiGpwSZCVW9srEjHprhsK/VYHxK7Qk9eHkiSQDL2Y/JNv/o27MKRFAN
 58/5QBpTZeihf+ueHH1yoVyTVfQ95ANdIlgskOpMGRsbosf1YdCiBgnRiC+jOyHEkcKP aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrfxb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 18:20:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CIFaoS023417;
        Tue, 12 Jul 2022 18:20:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043uvch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 18:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOvZOV+Yv8wcoNrty106JZzgiijN19UOMBLx+HG5CRIN/cykLF7iYUkk7X6Ifv93dtMmj1qjMgj9gUU4SEEXG41P9U8QfX9vflJ0v4yu8sSHrnWv7iQ3530XxfrJSjdHTbkqPSzUZcAVv2r2etrIS7tpmHYcGZn2PkBADmUMfVQq5x/XeLkAB9bJXbsGV2PK6V7NyZDQjTQyOCbSVWMh03P8qY/KpsWRmb76uMqsV2HnWWICg4yNA1BsPGISBuyB30RnJDoDGJZvVQAWE73y0C+QV1Z4ye7vbxEJFi7Fahp0+EA+A5I4haKywGLCPmnnoY0ev2bplIGiOxR/anbWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRltScwWkmwghhgjqrNNefiA/VhpDbwC0KRTcBGii/E=;
 b=foGetWLU2RVtsV2kblA9bPXSSIgYaGW0MiHT6sFnTfkXM8ygi8GWatOByiJ6USQdL+uhAgUWyjXdAynYaCbcDC0QwTr/PEsejYw+wqDIwmA9z3NsngXcd51tM2SDTTYh4MbqoTtkuGuIhlMSanvhIFOV7Vr40xNCbW8lkngXc7rEabZZi6zXA4q0q+s7XnDZb7DBwMuUSTfWpOKqAsbE2WTJhU/zfvsYj264SZAdthaFnzOTTGSDPTZV/0ixzwn62nj1udTFFUeDlEg2zuyc/IUrr6fAT34u89W5dcl9G3AxTXNVoyJZcuAlQ7eeZW805thceX1iJ/gv6+xvpjDkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRltScwWkmwghhgjqrNNefiA/VhpDbwC0KRTcBGii/E=;
 b=hRrkZu3SFuwIe/j9xAOAv4f6lYdpPa99oyfFq9cKikwkRxZ78Nmv77/8TxlH62NWk3MF+zzMSmPbsD+c9ZQtktGCyk7Knlnx8tQQ6Cyu2l4uLeimEJ3NZIvpjceRkQltzGbNhb9lb3Z7RhOxf7k8YukKrY+xZvS2pIGa9AD3DEI=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by BN8PR10MB3378.namprd10.prod.outlook.com (2603:10b6:408:ca::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 18:20:46 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 18:20:46 +0000
Message-ID: <35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com>
Date:   Tue, 12 Jul 2022 20:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: UNTRAIN_RET in native_irq_return_ldt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::13) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aeaf935-ded8-41b7-11cc-08da64333d49
X-MS-TrafficTypeDiagnostic: BN8PR10MB3378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HftUOD+yplzzjT4i41vbIj9+J6jEop7Maxg/QfzWfFnthjb0aayCyzZyPF6HB2UBMBiqbYomkSHTuvEIYCjCrHixsmYWHDjP/H3ZTsDCgdbYu3cc8ptWMD75ye5BO3AqKGieXNwLWRLs6RyRphJiSS55IOjawZE8yv0Xn0NDqWkwbdCAcLm1ruM49X3QMrL3nuCtmz9wNE47JNKK7L0btuWOSKtuDCU/bSZKy5dYxF4tGcBtgy/d2Q5hHvc2PUFuzYtWpBAsJQQFo3+V0gXyc9Lzoo+aLkKQ9rjK1tb+87QMa5/FsvTCCvhYUbIHKOUqRFAD6ZsDuWGrvrQffgTLrHxU0TIAzYMWR5SGiAgXgox2MpW8ImBrAkFj0x4c3WAjqSc4f1z1t55R2L4/KNA0qZqxbMNK+Oc0l+7fHBX24rJevTs9ZM/u38jnu1ppGoHci47yvFXnfNop3PU/uCQEEL42ppXc9P4USD2PgGGMtMAWw76oUN9RTUgHY1REqIHtxsm8/DCpb3A9K0kv6IxQcEMdesoVgiosApgWsYhS5c12PfasphwIx3bqZLg8e+whUvOWYw8lqQmOU7IyxTsca3vJ+HEUR+sEdWtUfBBO2EUnHwaztvuibOePJqQ3wMoOLMcbEW5TG6BsTbWRWl01WKz+I34ASVMLMvhsAp5CwYsI22mWvTK9hVJWWyH8qculMycjAAZ4IDONNkuh3GTRg2S6VUITX+1S4BWhW8dUwYzEsIGMWHVTuVUCnA8u5k/CytTYbyoiRQvCKvnv99FyIvR0TYFzUa7cccEptRkYe1r2PvL133J/utiTr/iJvS5lrSTel1X9CVNG6wmnsBnXpqxc6F2KlCyvZRSPmy53vdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(366004)(136003)(8676002)(66476007)(36756003)(66946007)(6486002)(7116003)(5660300002)(4326008)(66556008)(54906003)(478600001)(110136005)(2906002)(2616005)(316002)(186003)(6506007)(26005)(38100700002)(6512007)(8936002)(31686004)(31696002)(86362001)(4744005)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1pQXBOakZkUTExMVdIVXJpeVU5MmRVMnE3d0oxdDZrcWNHaVgwMzBzNThM?=
 =?utf-8?B?bGNFNm1QVlhBNjhUYjRRaWkzRjhyV2I0SW9XWWtPUVJYN2JwT2ZjRlBSY0Q1?=
 =?utf-8?B?Wk1xdDVKa2YwOVlRd2dtSzQ5dmFYaVgwTWRralpHNEJhVWZRRDZaUFVxS0JE?=
 =?utf-8?B?M1NJNndqVDJVNzltbjhMcDMyMVAwcW9GMjRNSmxaTEFya3o3ZzVEQ1REQWRl?=
 =?utf-8?B?VDE2SytoV2JYOFF6amoyNzdwTVlGZ0RqeVJ4aDhGeVZMZTVPclRBajl1ak9R?=
 =?utf-8?B?Y0IzUDQ3a2VKTDFoS25EY2lHa2NnVXlVamNWOTRaclMvMVpiL3JOU3ZHWGhx?=
 =?utf-8?B?K0ZmSitoMkpZWDhxTlo1NWo2aXNyQWRQUUx6M1hFeER4TUhwb3kvVkpiSzFE?=
 =?utf-8?B?VHdpcGJnbDl1bmFSSUU0ZDdqYVlXZndCUFpvRm1SWjJ0bmFqZVE0ZjgwNzgz?=
 =?utf-8?B?SHZkWm01bUVWc2ttTVN5SStIMUhUcnpvdktDUDhoL3NUVVRrK0NlUWVUMHNv?=
 =?utf-8?B?NktLaitSUVIyYzNVLzFWa0VUZGZHdU5rMlBOVnRpd3BYb3NuRzJocGxpQXBV?=
 =?utf-8?B?ZVYwQnh4N3B2ZmMyTWU0Vmh6YnUwSzd0UXJSUVh1Q0F4UnQ5VlVhRlRrclly?=
 =?utf-8?B?d1A0R0FyZGtpeUFScnNJNndsd2tDZzhhOXVETVk5QmZrSitmcC9qY3lMbTdL?=
 =?utf-8?B?ZGJiWnpWNjdvRU5KVG5ZZk44V1pQazNuMkE4R3A0YU5sM0IyQ1pzcGozWHFr?=
 =?utf-8?B?Q29lMXc4dDhUNS9Lci9QbWdXVnIvaVBrdzhrNDVkMStNUUFOblpWVnI0VlEw?=
 =?utf-8?B?QWFLZjRjNVlsd0lPUjVqdzlveVA1dStteWs2eThVUmM2VzgwdCtzWUV3bUxr?=
 =?utf-8?B?b0ttNmozT05pRWJOb2Jkb0hIYkNMZ0NKWFJlNUhPc05QZ1BzN25laWZScjhY?=
 =?utf-8?B?anZZNUNpc2djL1MxMFlwM25OVlZteStwNkZVdFR5S2gxa2x5NHdFL0k3QWli?=
 =?utf-8?B?N042a2ZZTDFiU2ZCUkFXWWlDU0pIdEpkQmIzbEQ1RGt6WVgyajFQYzF3b3k2?=
 =?utf-8?B?UVVNWkV2UHNGZmNONXJzL3Qzb1M1b1NVQVM3KzhTanN6aTBpUXNZaWZUKzRR?=
 =?utf-8?B?MXZuTUl5QzJIdDJpeWQ1K0xiVlpvRXF6MGdJUnQvSEwycEQ5VmFnN0xpRzdB?=
 =?utf-8?B?dmdNR0RkdmljL3BpbGk5MXZqYW5mQWFtTUhxUDRKd2lCeUQ1bkRjNmJTNnhC?=
 =?utf-8?B?a3JLeTk2cFBwd1NFc3d4cVpTcGJ4YWxIaUticW82TXpIK05KMjUxZ0txcTJp?=
 =?utf-8?B?bWlTZEVJQzl0RUR0Ry9EQWdrSXU2YXdXQ2QvTExISHhwMFczY0pjelJzSnVQ?=
 =?utf-8?B?eXcyV1VXSjRtVmhpR09OVXgybld2RTdzZ3NTeFp3YVJtazVnUGhkWEUwMHdL?=
 =?utf-8?B?YlRveENHNXVDTVdza3phbUlCL29GWlhJRHlDd0ZmVk1qR0JqT2paZHlTa2lL?=
 =?utf-8?B?L3NqRjNkQVBMbWlHcEloSjRSSmNnK3NMMzAvQWlKRzJQNmg0SnZ3SXBFcENk?=
 =?utf-8?B?RmYzeWtYQmxERm52UitWMTBjUENOSmpBa3djTURmMklzaXdPSlJJN1c2NmFy?=
 =?utf-8?B?b2hXS3JSUUcvTFYzKzMvdE41UGY5cjRrNDZTZFFKTkZuTGlIeHE0Rit4T1Rr?=
 =?utf-8?B?QWhRbmlvNVRwWUc2MG1FVXJSMDAyOHI0TFc2MGtHbFBiNnJkaFRMUVRjV1Jy?=
 =?utf-8?B?dmtJNUplTnZ4OVhnTWwvd3Uvc001ZVkyZFNZanR6REk0Q3gwc0hXeVVLWDVy?=
 =?utf-8?B?M0Fvdkswa0ZtVHplV2FyODFIOXFsRW1PQTk1ZVFKVWFYTjRxZ0I5MFBHaHdR?=
 =?utf-8?B?b3B5NnNPTHBrTXlBcXZhOWRKVnJyUnhKK0lxNmpPalBScEFnT3ZtdlNMQjg4?=
 =?utf-8?B?dThCNmYzbHBFMDFuTUZRZWhad0tWcWloZloyN3pNSXJwZFVWdjQvRFlzZGwz?=
 =?utf-8?B?dllmL2hBbkRvUG13bEtaTXVPR1ZuL3ViUGVXcFpUN3FkaDZXSWlKcHNKMGdZ?=
 =?utf-8?B?ajZqN1FiL3U5MHdXUFlEZTAwYjJYanMxUEdMTzlLdUo3RVh2TjhiSUhkNGhr?=
 =?utf-8?B?bFB1dVUxRTRJcmREcmdyckxYVVNFME5DU0NzSnB2UWIrSzNWRjJPK0ExbWgx?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeaf935-ded8-41b7-11cc-08da64333d49
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 18:20:46.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17rqq1SD1DwgQs7/UQDEURldTXuEQbjv87E00VB+scDF4vtVNCMooQs2QPn5DQifRHJAaX49KQohQ3fi7xrUOPQTB4bdyzB5f5FuIa5t9po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3378
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120074
X-Proofpoint-GUID: UxhXCChGR_jTQPphex-O00wXjMYfgBqU
X-Proofpoint-ORIG-GUID: UxhXCChGR_jTQPphex-O00wXjMYfgBqU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think there is an issue in native_irq_return_ldt: UNTRAIN_RET is used and can
clobber %rax which is expected to be the user rax.

A simple fix would be to preserve %rax:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a4ba162e52c3..f1fe05289d84 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -728,7 +728,11 @@ native_irq_return_ldt:
         pushq   %rdi                            /* Stash user RDI */
         swapgs                                  /* to kernel GS */
         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi   /* to kernel CR3 */
+
+       /* UNTRAIN_RET can clobber %rax, so preserve it */
+       movq    %rax, %rdi
         UNTRAIN_RET
+       movq    %rdi, %rax
  
         movq    PER_CPU_VAR(espfix_waddr), %rdi
         movq    %rax, (0*8)(%rdi)               /* user RAX */


But I wonder if we really need to use UNTRAIN_RET in native_irq_return_ldt because
I think we reach this point from the kernel after untrain has already be done,
and it looks like we don't do ret afterward (the code just fixup the stack and
then iret).

Thanks,

alex.
