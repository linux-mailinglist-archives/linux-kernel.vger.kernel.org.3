Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7A544969
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiFIKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242944AbiFIKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:44:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCCF7A80B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:44:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2598kP5T020270;
        Thu, 9 Jun 2022 10:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Aq7biVbPXv4+ZczyTtJd166ptFCMQ68RcPpSZARLICc=;
 b=OzKJR8oO725Av+twuYbbk/ogfI2ES8Rc5wJ2J3BsEpg726CjrRgm2k6L9fI2d1rxKDX5
 +avBkx0IgY0iJKNs2HFlyqExpu9LKxmqIfU9xoiTP/fb/Tz/wiOH6fZq8kafyBDA7i18
 Rz1SD/d6vLXwjyn0rMPdgwfnp0Xn5p73LdfDB9cNxKhm/yf1idwuQVYHQpckorqgltza
 ncL5O2ae3nJc4pdv6OMe8ZXkV1qz2SlOmvwEl/qwwMutqNFj4VTjNYro+5e6hAxnHb9q
 65HKSSA98ib3mzTrkHr3DPy+99XBnk1oo5DaKS749Ts5dfZyy1Wqq3JZwqkU7/1pbhVn DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqtsdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 10:43:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 259AVUDl013411;
        Thu, 9 Jun 2022 10:43:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwubn9q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 10:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/1AqVB4yjHX1wtI/UOuMrBrLkl1g7wqHJTG8/nYDUHgFSzmfzcHYqXdu2b8GGVxcCBBVPItAcy5qm1sABuPEWfZCBaK1PT8buGGpkIKKtxKQwb4na63BCJeNaDEhd0je7sS+aLxbiSeHwwNKMpW5gPsGULADQQ6s6LEeGRJPe0FncLfXj4Vc+HIXCVkggBpolf9TdvS/bCPXM7RJnGxi6G6neb2onOGEuW89bVFEpZn27rHX8iatBL1lXuTwF1L+p2DXe7KfvCgRku+tzofs+gKB+TwPvpoX6tTHmciY5KWZpR8D2j8d0u9QsznuXpTYBPaCHIBhem+Qz+KyUeYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq7biVbPXv4+ZczyTtJd166ptFCMQ68RcPpSZARLICc=;
 b=gCN0LhegeaC0f2jXrSddUTsiVOoWNBcoAIcpc568wIsyv0VetQ8NZQ97Hedk3GxZkgCSaoFaUnB40AHO+u6726tf1cspxKe7MimVzcHRLVHBvL7jqO8FqtNaBlTUEHZEk3SMaLCTgQgnRXV9V3nJOf2n7x4J9Hlkuuv1K8hBuXmuPWe9hGAY6VfPqrXXg5t0S6XQhbSE5I9U9ASnBSvkHIobUlvPNDPM3lQCvQR3hOw+JN5HvqgAXMFlmPhHTrk55iKNjokOg2sw2Ok4GjA4zh3WkmgqDQ9SL/e7mQ8WN95OAo8cVhpEIKsT+8rsRs9QhQJcN3IV13Px94j+97z+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq7biVbPXv4+ZczyTtJd166ptFCMQ68RcPpSZARLICc=;
 b=yhQPyFYCQUrvcwM5D87y7oO8TokgBfZ61VCEMZgSsECCUeDQjxAe4i/r2vqSfU/43VF2JxHAKK03pxBYFjSfgujEaNO1plIElKWcifIPjZ9slyzuzf/qSlN/0LjCbW9VaexyjLIHLLUmgscsWIaCFlSvABNzYuuGSaVsMu4kDPY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 10:43:47 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 10:43:47 +0000
Message-ID: <34998a4c-7c58-295a-c216-7d217fee47d1@oracle.com>
Date:   Thu, 9 Jun 2022 12:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 0/7] x86/entry: Convert error_entry() to C code
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
 <eccf100c-ee04-d42b-c3a6-b747cdad6b7c@oracle.com>
In-Reply-To: <eccf100c-ee04-d42b-c3a6-b747cdad6b7c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::35) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e80cde8-cef6-4370-d87c-08da4a04eee0
X-MS-TrafficTypeDiagnostic: BL3PR10MB6186:EE_
X-Microsoft-Antispam-PRVS: <BL3PR10MB61863449C2A2C029E67A5DDA97A79@BL3PR10MB6186.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd6NNIiQFJ6bhp2enrOm1RtwGP+CsKD9Y5PHIX58y6wL1wzelj/3V3H8LehZrQ69rSxybAnMqDXJfTJnkGGtM5gwiMcmkou+MsmyKT+fsd1dcKox51yqKVGbBFGAJtQF/Qu/omZBzyEOyjErz+jt4jwSZ/f3wnPE0l+jzpo+Jy9UcwcSZGfO8z/AmHj6YA2KzIjmERXyO9g5BIoM0s2T+WtZWQR2LwnfWZvpbkvzA2mfl9zHuT9ycNT6q21LtLFQKUhrWw1oMW5bU9RTooXlxughP69Kk6G810IIlhr4HUL2HoHfdIc6kZROevWUQPoIfWKpKrbN7THqK3L+DAVh2dokeaGPQ//JfIHiTpfndlvd40H12z+3cDDlvzBsr/70iAlW1I9XAANlH11F1v9E60f6f1HwGMJNkmtR4ZpE1Rzvmhq0VpH8J9qX1ZxOkgZiQ8g4zX/y/1JZblpL8uhGbtLEmNBKIOqs3BIBmCTX+s+HaIugEZNkh6yiSXJuMrO0mspfGbSLvkG09qJaA7bUcRdOHf6kCQM8Jzo4REJRp0Oa64ewIgxsuGSKe4jWb4tBfsSG4pcSMAKV7SOuGMCqgd3D7YZm0M1FgynSCE2MhFU3JZPhXPE7EtjRcq6LVVDa4ljJPd2YUl9hojkNbDF6QxNX3eEwQXAqSTFKntDEUoG9VJnENOzOu7GbcBl3AJjGVq2I9de9OYb+wpiiYdjBgP7Fl2yjksMD5zPjDJ1/gbNR21cF2nljG1MhB4eNoqqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(44832011)(5660300002)(36756003)(8936002)(8676002)(66946007)(66476007)(31686004)(4326008)(316002)(6486002)(52116002)(54906003)(6506007)(2906002)(6666004)(508600001)(38350700002)(6512007)(83380400001)(53546011)(26005)(38100700002)(86362001)(186003)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVYMkZTeGdLV2Ftd3V1Wm9ldm5FNzNad3JiRS9nUXZCMWVWNzNTMVNzQVJR?=
 =?utf-8?B?aFJDL21rOWVXc1QyQm4yL0F4ZmVvZW1ENFlmd2ltSUtJT1U3aVJRdkFSNHd0?=
 =?utf-8?B?RTIxTldXT0t2NU16aGsxYjZ1d3VUdG12Vm1VK1N2a0FwM3FXN1J2a2YxNFVi?=
 =?utf-8?B?aDE1MHpydFh6ME5vdENqNCtWaUUxVEE3aTd3M1o3cVhHWHlDWDNqZnMraE1J?=
 =?utf-8?B?MFQrREEydDUybHBCOXgzMVVHallOTlRhOXk2R2RyOXdGN0tEbjNaZHJVbjFR?=
 =?utf-8?B?ZlFjbm5tb0xBazJsNVQwa1c2K1VrcW1maGg0UHE3K0JYQmRaTzhvQnRoUW9G?=
 =?utf-8?B?VDdUQVdOVUVENHR4TlZPdDcrSDM4cnJTVnNzczVLVU16czIrd1JOU0tFTGND?=
 =?utf-8?B?aXhrdUxxWGFsT0ZLZ3VqTkFKZ0RYN2JhNjVxWHRsRk4wblNiM0xDdDh1UzRv?=
 =?utf-8?B?bHdiKzJ4WUNmb3hieTlZd09odGZEdWduNzJSdzY5elVneDZIalVsNmdPemF5?=
 =?utf-8?B?cENNakpUdmYzei9PS25FNGJ2dmdEdWF5OEQyeTJNb0hHKzBmcnRKb1E0bG1U?=
 =?utf-8?B?Ri9RSDhCWmo0T2l2SG5XZFRZV0ZaaXE5bExwaU9HbXMySXhNdmVqNTNMd0Rp?=
 =?utf-8?B?RDJUWnc4N3VZNGhLTDZyY25PN3Z5K3YzeFd2VllhczEwSmc4a2NxWTA5aHU5?=
 =?utf-8?B?NW8yVEM4S0FsTWNMS0RHOUxFRXA0Q00xcS9hMGI2bERtYTJ5VU9vWWl0czFN?=
 =?utf-8?B?cWZzSTZ0K2l1R05CbG4yQldaK3F4aGd4Wmg4VHdEbDZZdWlKRDVNYkh1V0xk?=
 =?utf-8?B?czh4VDhYQ3NhcVljWWVOU00xTFduQlRZUm5CWXhzL0Zvak1TajRiL0NrY0Zw?=
 =?utf-8?B?elhzRThIcXVwNEtkcTdzRGo3RVM1THlPQWlZNkN2bkFacWF2UHVNV1dFdTZz?=
 =?utf-8?B?c2w1a0wwSGkvYUdKblA2ZXB0N25La09DL3FOYnJNTnkzOU9EVGw3UVlnVlY4?=
 =?utf-8?B?WVZUSjZpZStYdWlzQ2RnSWlsWW9CNEh1dStIa1FmeEhyenY2ZWpaNDhjd3hr?=
 =?utf-8?B?bGxMSzRJaFQyL09UWHQ3b3pGb0RncFlKS2tFK1V4SHlab1owV2lXeVp3Vmdk?=
 =?utf-8?B?NWpJbHYrczl5YXk2aTQ5K3hVU2Y1cEViTFhRTmthZ2ZpK0Fwd082SzFNcFRM?=
 =?utf-8?B?ekZjcjA4c1FIVC9zVDFKelQxanMxVGxxaEF4Mmp6dEEvTElISHpUbE5yUEZv?=
 =?utf-8?B?alBDLzZyQk1SZ0U1OFREdVo3NkRlb1NHMnZIWG93bkpRcTIzYUZyV2tTeW5L?=
 =?utf-8?B?bWpweXNuenNKcWs0dFBrRFYwZkljN3daQlQzVnlZNDFseHM5VWhYWFVVYVNv?=
 =?utf-8?B?UGdTcnd2Q2E5MVZlRGEzbFJxZHNFK3BPQ3Q2SnVPKzFNVnhiNWViMzluSkQw?=
 =?utf-8?B?Uk1zL3JaL2UrV3NIRi9ZakJWS0UvTk1MTXlUYU1nRHNMai81d0dWN0ZZc0RJ?=
 =?utf-8?B?T0hwUS9OdENKM245ZkVwaWlaSFgxNkE5d3puMGdiSFBFMVJLUXQyM1MvbGI4?=
 =?utf-8?B?UE9YOTJxODBZSTNsM28zbUVrRnZhYVVJQXJRc0FqOFRBczhQYmlYYTVXZFlG?=
 =?utf-8?B?NzVwaTVPbzlZNVNUY1NlUFJjNVV2QTU0Z2dnWUgvWUNnbVZDc3JKcUdtd1ZO?=
 =?utf-8?B?czd6R0JXM3JvblJ4OVJtbFZBYTIvR0ZvSHA0UEF3NUpxcGNWeXpEWWI0dDRn?=
 =?utf-8?B?bGVkM3BLTVVHRGxaeWhuVWE5T252c0hTMkc5bGRCR2NkMGtBSFRKUWoyRUxC?=
 =?utf-8?B?ZzlUdkhvY3dmT2hlZXFNUE5YZnJFWnlmYWRlSzBXNnhjY3NJd1NvM29qcjNh?=
 =?utf-8?B?NjEvSjdGVnEwcUgzUmpaMGwyVkc2cU9jNlpsTHpUN1dyUVJWa3hjelYzWDBp?=
 =?utf-8?B?eXhZTkhzKzFYVVFOY0J6K2d2VDYrTVNuK0NCb0IrOG5DWkRyN3lONE9hdDFi?=
 =?utf-8?B?MXp5YUtWeDUvZkdob1VBVDB0ZURNdEQrVDNuRnRhazYvcC9VRVE5Mm83eEky?=
 =?utf-8?B?WXBlTWloMnlSa1RQTEQvcDJ2VmI5U3FQNWN5a2ZpSm8vVVkxSUF5UVV2ajA0?=
 =?utf-8?B?Skp4N3JkbzdnWWZ4NHZZckhoOFRodGhlWHB0MG1ISG8xRnhSTys3MlEyYzhH?=
 =?utf-8?B?emVMMEgzRnQwMnpuQkJCR0lab0pvcDVwVzJFakNwc245ZEEvclhIb290U20r?=
 =?utf-8?B?c3ZWVm9oMlZ1YTdLaWR3Tlp5QlI0SFYzRmh0Q2loanNwSXdGMUFKOHJBOVow?=
 =?utf-8?B?Q1VmQ2JMdDFGcGJPeHRHSHlmMVB0eDIrWkJqSVRoVkF0WXZpMGMyUTRKZEJo?=
 =?utf-8?Q?m7aW9Zle+l7Ct+wg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e80cde8-cef6-4370-d87c-08da4a04eee0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 10:43:47.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZbQMPepJRQ4rNamkVEVErM+BUBTbfWqa/1s4eBULQWPpIhzqebZ7pIiDxYC3J41wqkMNmCtxufMhnSKt68qWGRPX6uIHiNCmvFbDBl1Hy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_09:2022-06-09,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090041
X-Proofpoint-GUID: 5d7SToDM_LIhvroebeqGxbifRVlrMDE3
X-Proofpoint-ORIG-GUID: 5d7SToDM_LIhvroebeqGxbifRVlrMDE3
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 11:11, Vegard Nossum wrote:
> On 6/6/22 16:45, Lai Jiangshan wrote:
>> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>
>> Add some C equivalent functions of the ASM macros and implement the whole
>> error_entry() as C code.
> 
> Hi,
> 
> I did some testing of your patches (on top of mainline commit
> 34f4335c16a5) and I see these two KASAN reports very occasionally during
> boot:
> 
> 1)
> 
> Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> ==================================================================
> BUG: KASAN: wild-memory-access in rcu_nmi_enter+0x6e/0xf0

So this one I get without your patches as well. It's only about 1% of
boots, though. Let me try to bisect this and start a new thread.

> 2)
>
> BUG: KASAN: out-of-bounds in rcu_nmi_enter+0x6e/0xf0
> Read of size 4 at addr ff11000034e38b10 by task swapper/0/0

I haven't seen this without your patches, although it's the exact same
callsite so I assume it must be related to the first problem.


Vegard
