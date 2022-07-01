Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA325635F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGAOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiGAOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125C1275E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:38:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261D4Rw2021945;
        Fri, 1 Jul 2022 14:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c2HznpuJAvkwA7KWiy20FZWB+ZUCFRwdP6ah3gRSKrQ=;
 b=PBhVg+TOVFLGIWkjU3+A7ReCADbVfdLEoggzyqa4e+2aqvukhyFmQWvj6faIe6hdxDw9
 Whyor5MdPv3NZekJU2kAGFVzgE/7gwTQUIq80YW52kyj2bPSMzs+6UYM2mqYNMCiCZeu
 qFmDCypNI9XGDbnMSmno3CM5paB6Xk98qHoClfG9+YU47ZzjF/8P0XhJc0gQ4kj3XnPn
 f+019IkRmQtMGnUZFexdD1jz4eD5uNp0zpn15VLlwOoyGYLfY7oYgqoF62F8fpgby3S6
 TrjDVbjdyto8Ex6BxOPXe3/QqcJgA57X3E4orhA3tJRQjCtpP/3Ob/Feiitji7YmkYz8 XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52qcfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 14:38:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261EFCiM016023;
        Fri, 1 Jul 2022 14:38:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtarcnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 14:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3X6z8aVAHWvoIa97spNCX5fdBD8LIga7PQtxvGzGHxFGzCyHI29B0WBu9NfDLBFH2vINFsiHkzKHHm48d2wFs2mH+Esl11gx3DFBK+3+NA/g42WxAPrca/TAG4Q+zWmIsBJMa+QgpBXYk0JLQVO6TBWG6YPN2mnq/N1zz0SALdAsVcRXGilz+Sr6aywlsq7YfK5Gj0Dicy3LxvjTwvp33FmhOLzXK0O2cAj6fv5o5NdfRyRXaFHEmcjQiScBQKmegJwRozQtmwMLrqNqPGAz/FPDXrmNF506nmV+8SSCxn4r9s5AhM9h/MZ+wlp4UTWQIGQqz+2f6Nr/NqtKkGdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2HznpuJAvkwA7KWiy20FZWB+ZUCFRwdP6ah3gRSKrQ=;
 b=DlNpN8TV5WAlZGBt7w/nix0hHAGj0QfrzkphJPxf0Ic0GmSnWkYSGSPIjcwFBcQ6qDCmaJsqS2OVBTk4EGE6oMxeBEemD1D0iUK2UBTqM7twq7Yodj8hAC7HF6O64KkgCzYuBxE/Cq8SwQgDz29eSLx51sgC+Ee+cRryuLbu2LrChMaJAu9jbQi0pQe6pJkE8nWl3hC1OFEmqirrfL5/DKq1F4iBMgjIOpdODQBWoG+KE96MkoNzPIx0+QCmA1md7EXddEZc48PVGjqOg+L8uMxn6zPrqPO+yaO0Gb8fRLn3PXcqMIWeakzpqmC9ALR4aumL0SwInXzsMtdruafyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2HznpuJAvkwA7KWiy20FZWB+ZUCFRwdP6ah3gRSKrQ=;
 b=L1y68Y464ROwAsR4dwESjbZXtFt3g4GwfYe1RXIDUiNQ+T/XYgaXd6Yc2+h4oW7ISbJW4gV5/GxMhdOej00PEiArgBXdDNHi/XxQA4ZoSYHVQpcM9+qdorAutgRccM+fSSZphYfORo/j+/fK0AFeDtEq3ComoY+EqWfzixEyl6Y=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 14:38:02 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 14:38:02 +0000
Message-ID: <6b2af276-f592-061e-1c0b-b11ed57b49ea@oracle.com>
Date:   Fri, 1 Jul 2022 09:37:56 -0500
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
        Mel Gorman <mgorman@techsingularity.net>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220622200419.778799-1-longman@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220622200419.778799-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d6f51a7-54ef-4812-7b30-08da5b6f4d26
X-MS-TrafficTypeDiagnostic: BN0PR10MB5173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSbkruxyd3tkrDG+e0VqcJYL3F42CVGeuS+0MqaL/T/+2SKuVGS77GeOhfrYNnh5Jc/V9g+PhMtTvuUvUtBxlVnKjgAqucwsyXIHZo8sd/pCiOPjrYtGfXWVRm//OJ1vBKgehn9Mk/6KakRyC9PhaXb9Q8Zb8nVVNnozCaK/4M20nCdgm7IWRhtUOpSPR6mh7OmChqSSXTffOh0YCb6I5mv8gwXAIKWkPrhUhPsvvsHY7XF14N1L4qG4/yF7qjeHrr3NofWDjCSTgJqv/nZSENUTTTwGRFsfL0GfZB5ha8tvwBatGV4CICGTAt959IikVzyTxvTFDN2HDt5vmrMt+IzPl50tV539f9JN54gFYTsfSgWCRRExhfZpLsRJidhhigQxnZzMgj/CDFcfVw5Bq+bJXfSCnhH98GE/5lJnJqQmaolkhYg1WDciO14twleXQnnYDreaiHFEhOI+dcGxhfzVDpjpQUFoDuX+2q5eYJyJ4C5DDc8x6V/ScavDIe77JDVPaI+1LbxWJUMT2tbaKRJ8AP2Q3eqpahzBIbzm1yG1v4Nu3L8OgRGzyogCqP8RAen2Spf2k79M4KAz5W2fJm/NgEcklljBfgdg5h+NZNUP1/Es7FAH+CGGp4vXy3rlnIRTeMI4jbAZiPVZ32S2TyVxD7DbE4gpGWSSPExgW3XIVa3oJmLH2CGyVvOUD4pL+eS9hM+wAN8B7YxfJp5xc06Fq7CsPQCaR/V8pOUPcuS1ev54tlrHfjznx2uZfyZluxAgGE9r6vwNIxahFytIfVUh8RWdQC0bZ58aRzA/rNOOhOq6Qy9qLs0xBG6Guu076lxb872+sNJeS3iN+BTEj4hxaGahurgiEARdjwYz8DVY54AQTRq+k9E9n9eI2ZaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(366004)(396003)(346002)(8676002)(316002)(66556008)(36756003)(66476007)(66946007)(38100700002)(4326008)(9686003)(107886003)(53546011)(41300700001)(6512007)(6506007)(478600001)(2616005)(966005)(6666004)(26005)(6486002)(5660300002)(186003)(110136005)(54906003)(31696002)(83380400001)(2906002)(86362001)(8936002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxlWE1jWEJiUFBOUjBEU05HYVZ1OUVBdTFDM2J3ZlJXMS8zK0F3a2xSNm1a?=
 =?utf-8?B?SmU4anRFQ20vYmRrSGxBSGVyN0JRUnZjQnlQenR4SU1YWWVUbjhEallKNGE5?=
 =?utf-8?B?UnlUbGs2RTBKdjJQWWJsNFNEaXowREowYUNiRkxHQVd3cFNqcWVVa21Mdmhk?=
 =?utf-8?B?MzZWbVRTcG1QZmhMa2JFdGF4cktGWDZqSVdHVGhIN3RFTTJkVkFqalJMcm5k?=
 =?utf-8?B?ZUhhc0JDL1dXb1pyNmNoU2JnaUxKdUwxUmxVc1hsSlRoVEJldUtISy8ybUFx?=
 =?utf-8?B?NFFPeFc1QVJjVXc3Y2Q3UklLSFVrN0RMWG9ZT0w5Z3RVekJZT2F5TStnZWtr?=
 =?utf-8?B?NU5qTTVoWkx3bjF3LzRDcWJDaGI0VHpQQUlMVXhZbGUrU2JGdVpRWTBna0dJ?=
 =?utf-8?B?a0dhaGdNdm00R3FHeWpqZkFnbEtCRFFvWS9tdUJqbFpYMHpTRWIyYTdEenN1?=
 =?utf-8?B?KzA1ZS9PRkpBNWkvT21iOUFFQy9PZkhaOG8vNHlkY3JTcUVHaElFTitIVmZE?=
 =?utf-8?B?a2NIQzV1cVR6eUQvZTlzcGg1TEdYT1dVdk0yYlEvaXdpSnZmcGdEenMraUN2?=
 =?utf-8?B?b2ZMNWRaOWZ6MFRyUm9MUFJBVHJWQ3BqTDNkMzBuQWw4VjNRd3NRcFEyMVFa?=
 =?utf-8?B?Q0Q5MCtnNTkyZUI5QW9jNHJLdFFpK1hVcWw5ME9Jb0dQWjBMZ1BsYUkrUU9J?=
 =?utf-8?B?alkxNnJlbzZmdTBjd2VxWko4WkhZa1k2cFR3NHcvTFlWbkx6Wm1Lc0o3dkJM?=
 =?utf-8?B?UVNDQlFZSEZ3S1lCaEk0WWhGd1pseWpLVVRoM01oVERuOU43cTViRzcwSUVJ?=
 =?utf-8?B?WVJRRjBBTDB6QUorL3Z2L3lXVGYxZVkzSHZkRU1pai9CSUFGdC84NXRteFFW?=
 =?utf-8?B?MEhNZVpQZXRwb280Y0Y0TWw0Q3g4OVdlalJ2bWVsOUdpdUVEMGRlbHhHempp?=
 =?utf-8?B?N2FqTXd4aU5IK1J6STYvSzBUWkprSUcwNnRxdDF2d0poSVVzVmZaWUlXR3Fv?=
 =?utf-8?B?SHE2R2Z5L3lmNVVDVjhoK2w3Vm5zazBCVm9XZ1JtTnRrY0RmaThiTzJvMXdL?=
 =?utf-8?B?cFNBRnBOVUNFKy8waWdNeWtSZEhYTlVCRW5OTVZTdFM4bFRSSlNjcTgyNi9J?=
 =?utf-8?B?ZXMxVTRBSmZCOEphZmJ0aWJhV2pKcmE5ZS81TE5rNkwxMW9PWjBEaS94T0NJ?=
 =?utf-8?B?NFMxUTNzNkI2VmZCK1BoTGZJa285UTJyamVCdDZwaHVZVUlZSkRxMGFhaTNm?=
 =?utf-8?B?N0VPYXlUMy9jSUdmVHZCMERxblpJU3phcE0yVldtY0E5QWZrb0pTbVdLTWdn?=
 =?utf-8?B?enhPbDFvYkE2Z0hBUU9vLzZnSCtiem1VWHZGR2IxNzBoOG5vNkdWMTFsUHRr?=
 =?utf-8?B?Tm05UFQwRksyWFBHYjBPNDlkUHRUNnpEWjF5UVJsRHVUcTVrdllHaHVQejE1?=
 =?utf-8?B?dWpYV2JURUNlbTVkSGdoeUttWVlsRG5KL0xka2d5Q1NSZUlQSzlTZi80aUhp?=
 =?utf-8?B?M0RvZkVXYUhwRWtYdTRLVWRSRWZLK3lZSTFxYS9hZGdXTVlZZ1hYTzlFQk1V?=
 =?utf-8?B?QmpDNC8xN2xMdnk3ZE9nc2M1bE54Y0JDK0FJSXg5NDlVZHN0Yys1ODBLWm9J?=
 =?utf-8?B?UkJ6ajFnL2d1cnYrYVVkZUF0MEE0MERVMWx1MHBwWC9FTVZBQVY2Y1BuTDgw?=
 =?utf-8?B?OW52cndJTERqVjMxUlRITE9xNHJ2RHNJUnlTWElsZFdjRkY4OXBhL1ZQSlVj?=
 =?utf-8?B?OUlyTUpQWXgyc0VDTnpNdGU2cE5MY093b0s2ek8zRGV5dDZQU3picDROYVVi?=
 =?utf-8?B?ampaRFFjTUJwOHVRNkVpSXEwOUN6V2o0V01jS1p1UWozVzc2aTUzYi85dFVH?=
 =?utf-8?B?bWxHblAvbUZ2RmozU0VTMUZrcGhiYjV4Z0dIQ3JKN2xGOVY5Q2tYUjU3cUtB?=
 =?utf-8?B?MGRWQkxNMTF2Q3c5VG5DN09rV1kzZzVVb1p2dzJJVUJESzFvMzBDNlhIcVNm?=
 =?utf-8?B?NmJpVnhZbU00eUp6N0x2MnNzUnB4ZTFOWUJFVE5OdVZCNG4zVlhFT2dZNFZ0?=
 =?utf-8?B?bndHb0pLOEZPbnkvWlRCTlVIVzJxRUdxR2RvUU10eStETldtRlFmS3ZGOE5M?=
 =?utf-8?B?WmRxZXorSm5LeXYxSGpsenVYbkdRR3V6RjVnRzdmM1VjV3A5M1VrSDJwVW1P?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6f51a7-54ef-4812-7b30-08da5b6f4d26
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 14:38:02.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXvAg3hRBNKtUMmI9n0trZzt4MRDgnsmWWa/y7tkotsHawJcTKmenMe/PwF69fOP5RZBPCzIf3PTuPmcD83XI5lLfl8wTU7re4XLXUL8l+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_07:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010056
X-Proofpoint-ORIG-GUID: mavKK8LEMNB-kI-2CFYhaIg8410ZV7nP
X-Proofpoint-GUID: mavKK8LEMNB-kI-2CFYhaIg8410ZV7nP
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_LONG_WORD5,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Acked-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
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


Hi,

ping .


Can we get this reviewed ?


The offending commit:

  d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more  consistent")


is found in all these branches:

   kernel_dot_org/linux-stable.git    linux-5.15.y           - 76723ed1fb89
   kernel_dot_org/linux-stable.git    linux-5.16.y           - d257cc8cb8d5
   kernel_dot_org/linux-stable.git    linux-5.17.y           - d257cc8cb8d5
   kernel_dot_org/linux-stable.git    linux-5.18.y           - d257cc8cb8d5
   kernel_dot_org/linux-stable.git    master                 - d257cc8cb8d5



