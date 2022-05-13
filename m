Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52169526904
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383240AbiEMSKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383235AbiEMSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:10:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134CD52E53
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:10:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdCMw005765;
        Fri, 13 May 2022 18:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r1AeB9LtTvz+LXUuQyd68tJkJRIs77uPBliEfO7NMtA=;
 b=mveGzam5L5SwbSE6fOlaSk5B6Gvz65GWNplFqhhYRUTcqd+Gy90Dwd9leLcRr45W/VBa
 oLqsmoJHq0OU0EqKazqhSkeaLbRMIT919lPt4u35KL/6kAIBLv94bftyDgaMXZR99ogi
 98Kht/FJS9TaBYlAnuw2T69ECL/uXaPQKMAIvcrwrlNUmIMQEjvY6H9Ts+Cx0ng/oexx
 WJSoHQJQHamO+982Kp8c1RP+IrKTMxLFI0cMlUJNSpw2CeK1f80p57CSFZ2oEpHacLUj
 iW7ZLBkqZSM58+MnxdBoaz3KVeSTq94lgPJtyNX81jqz/bpHF/oIcc1deKW5bpSGncZa xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatr9jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 18:09:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DHtK2x001535;
        Fri, 13 May 2022 18:09:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6hc7vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 18:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR+ZQ3iJ2DD/Iq5oZU8SQ7j8VefyG0ZY2TySFllNIbrmlO3InOY7z+8IW58B2yq8JmoxHjS6rcrt4nKgoHoBCiLLTi5fcLEp6btQIJG4xu19oBUQvoZYaekg59RHnEoMnF+JN2aa+LsuxF+Wg7ZPzELv7rnzW6GFvCwxN/5wrQ3OozowxVTbqsQ1Z5LaK1sw52ShPr68BAWMSs0LYsdcCMJQyr8g/BoK2pz0nGtjyiJ6Yt341xvr8VIugGaFEOAfqb+/1Ka0NViJe8ra7avSjoaMjj/0hsF7VbJYnAGcvigHHtdGigdGS0HCNXpvZZA1GcF7qNMcJyw49JmQCdtEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1AeB9LtTvz+LXUuQyd68tJkJRIs77uPBliEfO7NMtA=;
 b=KPVwS2EHHJYR7Dkpsw0vC47weoa0a9neoQVBQ/1FSasq1GzggVeHHXigZG1lH0LmRFnK+FF5KogBzJ/DCKWXobvXTa+IovdsL/3MRTUYeYdX5jPJMHZBwPLAC5t6SAHRu9cJlycyEAoTvwkgA6Ne1u46CklN6YJsFpH8DTWyxfWGVC81wZFXXlbC5XO5YsXCiQzbZpHCfsR/SQFT86ACP6MTDvpmL+4SIy6pUQg8JTwbERMBBeVttjbZsBuMK0peb73M/yvcp1RbvaYdhEZXr501eSESPQv5tJ+Q8dgnGV0GIy35pvYLojTE93SAwm2aNJQXoUJNHSSXmpeYcaPRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1AeB9LtTvz+LXUuQyd68tJkJRIs77uPBliEfO7NMtA=;
 b=zwPCB0TFBqFkwdiv59OMDyyMQEEo6txbd9Jiv/AKTX98ivFiazMidvFVvT0YQ5wQu9YvZCUHaplmU1nFq7rFeGrnf/AYR3a1Bu8WgM2UyTvstvSgvMY6IbFrB5eDc2FjeRX47tkIPgNCPThB/Xcq6gb3Av0Y+M7QniBIxEa1QvU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6168.namprd10.prod.outlook.com (2603:10b6:930:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 18:09:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.016; Fri, 13 May 2022
 18:09:51 +0000
Message-ID: <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
Date:   Fri, 13 May 2022 11:09:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514d98c9-0fd5-496c-2646-08da350bc5d1
X-MS-TrafficTypeDiagnostic: CY5PR10MB6168:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB6168F4B49DE9FD468C4FFAB9E2CA9@CY5PR10MB6168.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHFiSG44Sm1ra3hPOGp2dE1OekYwNEhSYkZ0NjBQbmJpZVpQMVNwVXZ1ajRW?=
 =?utf-8?B?YlhtUTlQcDBsREdBRS9lSVZ0cmVHOHBlaVJXL09iTkNWMGRqZjlQQkoyek50?=
 =?utf-8?B?ekQvaGhKZTF3YmIvNytRTEtBL2syLzVCOXZQNG4yTDNjeXhVRUZSUjhzalZh?=
 =?utf-8?B?YXNDVkdIemdtWTFKL1ZzdlIvYklVZC9hbmNsaVR1VGwvMGFWZDNscmYrM1FF?=
 =?utf-8?B?ME96SHZIbUxxVVkzUmxManU4R0lMU2dwRGJUZkUvSEllc2lUa3BPZVVmUkpa?=
 =?utf-8?B?b09IZ0l4STlMaTBydFZsQU5JL3V0andnOHBDNXZqYWtzMkVuWVlxMHpDS2Vu?=
 =?utf-8?B?U21pSnFDQjZVeitiVHZmU1NnUE9ZZWhhaWdCWm53VjNYYkVlcG9qOGhxY2o5?=
 =?utf-8?B?ZFZmME9Fc2hIOHMvZUowSTZyNVF1emxWUjVPRmx5S0E5d3UzZlFKYTA2Nmty?=
 =?utf-8?B?YXcwRDJwZ3JPR21jMUZEcE1aVWJwRms4Wng1Y2tvbEJ3dHM3ck00RGQ2eXN3?=
 =?utf-8?B?ZnRCZDU5UHlKV2s4SkFoeEtqcm5oWE5FNVhKZ01VcExsWmdHVkxINEFLaWtF?=
 =?utf-8?B?MXRVaEFYYnY0OGRldkhvRHh4ZDJCUWgxR2VOWGU3aG1MMDFMZkhGWUdraGhT?=
 =?utf-8?B?VWtwWDR0K1N2bTVNdFNFYWVhbkdrYSsvREc1VmZqWDJIOE9sSUZqVEFOcHdx?=
 =?utf-8?B?MFdRU1A1VlZrLys3NW1xTzQvZkFadVZTdERVLzd2eW8wQmk4WTNiWjJNOUN1?=
 =?utf-8?B?TEdQSEJvRHJ4eTl0MElBSUJRcTg2a1BjbEtiSjROeWdQZmdLTHBQUkVzVElv?=
 =?utf-8?B?aXRVckJPcXZ3dG53VTBFUDFXdWZOeVBuMzZPRkw0MFZCVys4TjEveWdza1cv?=
 =?utf-8?B?VTlBeGFGUUlFcDBWWGd2dy9rU1N5Z2t0OW5QWGJBWEZJazdXY2drcWN2NHpK?=
 =?utf-8?B?U1QvaEd0UGVMUEdMNE90NU1ET3ZWa0I0aEQ0VUtsRTI3c2RVc05GLzZnZElX?=
 =?utf-8?B?dnJxNkJjdFRlSi9XVlBnNldmcG5vWDNzZWFKWUg1NGhwbVB2NmdlRVJONlFl?=
 =?utf-8?B?b0pORGdybE5nUDRuZDgyZ0tmYk80a3RSUUZ5ck41aTB0U3BNTktsN1JCVm5y?=
 =?utf-8?B?ZXBxL3Mzb1VFYnJqRDVMUFN6SGJtcW9NVnFQQ3NpTUNJNjNFYlc2ekU1QjJh?=
 =?utf-8?B?OXNUT2lkYWdVbEJXY0JseVpSMUdjRVlMODdnTjcvYk45SGJHc0VLVzdOWFVv?=
 =?utf-8?B?bng2YWJtRHFWZzVZb0ZVV0xnYjlmdmZWaUo4TUR3NG93Y2RYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6486002)(86362001)(31696002)(6506007)(2906002)(6666004)(44832011)(508600001)(5660300002)(53546011)(8936002)(52116002)(7416002)(38350700002)(83380400001)(38100700002)(6512007)(2616005)(26005)(186003)(316002)(36756003)(110136005)(8676002)(31686004)(4326008)(66946007)(66556008)(66476007)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnB6eVdmSnJZQ2JzNlVTWFFqV0pKMWZLbnI0MmloUE1sc1BwdjVTMEZZSUMr?=
 =?utf-8?B?RW1FZVFTVUkyMFZVREdVNkZzZTZ0RkEyUUpEYStHbGhNZkJraEJhUklscjJ5?=
 =?utf-8?B?NGxxSXNJUkpEV1cyaExtU1NGdHZ6ZEtyRzRRYUE4ZTFPU2QwT0F1QTIyRWha?=
 =?utf-8?B?UTl1a1NZWGZzcVR5eGRTMk12a050cFZvV2MyNEhxOXd5cG5MTEloMEFways4?=
 =?utf-8?B?RndUVnJjQlpPZC8wTkIxdVBoSG0xT1dCS0FSellpQlZsRSttS3h5QnR4bHFl?=
 =?utf-8?B?eGZlVzFSK0R5QWw1b3I0enRPc01WR1NtK0I3Vmt2SkZzZkdKOEF0OG42dUM3?=
 =?utf-8?B?UkJEQ3BKbEtTb1NJNVMwbTVZRmNCRWo0aGtWZEQ5QkZhSk03Qk5lMG51SmFv?=
 =?utf-8?B?ekVhd0hMb1RpUWR0UCtsYmlRYzJ1QnRtNGtkYi9xeEtaSkwzSGtpcXN4bFZ6?=
 =?utf-8?B?UTd5dVRlREd5cDZVbGRUU0JDdXUrclgwQnlxcDVrWWdKREJFOWtTWVFHQ1BF?=
 =?utf-8?B?dVMxaWpQdFFDQU5VMGFBQ1RVZW1TV2cxd1I2NmtXdm0wM1VGZlBtRXVUTlZ0?=
 =?utf-8?B?NFl2ZjVjWFNrU282T2xtUGd1SE00N2M1aDhKU29iODhWMkNtRis1cXkxNVhN?=
 =?utf-8?B?WnJwbThoOUhOQWlnWERJYTFzeHBmRUNnd2Q3S1ltQ252T2c0cUV2Nis2WnJT?=
 =?utf-8?B?ckcxeEkyTkRoWjYwWmpLWWRvMFlRcXJIUmdVc3pJR3A4NFlKUDlLazRPQ2hR?=
 =?utf-8?B?ZExzeHA1MkJRbE9EUXlLenFmSEVWNjQxZFIxOUFQK2hOY0pWODdyWUpvczhm?=
 =?utf-8?B?SVorN29DeUNhU2RpcjBncVErVGduNFZSTU1hdHE2MHdiWnN4MGdZWEQ3TjAw?=
 =?utf-8?B?c3JieUJCcW9tQUhlNGx2d2pvc2p3MUtrRnJwRmVrWDM3dWg3ODVHODNzaFhu?=
 =?utf-8?B?NDc0MC9kUDJWNVA2SmtBNXhTdHo3WUlBNlhsQjA2cWdMbE1kcmQyNjV2ZEFi?=
 =?utf-8?B?WnduK0NwdUZmdXJGTDIvVGlqYTdnMWlSWjlFejdBWU9VbkxSN3lMVGIwVE9E?=
 =?utf-8?B?cE9SdEgxWWFJUTBObEZPVklvL243M085d0NBaVZrbkFLbXV1TjNxa3RwMFNB?=
 =?utf-8?B?S2lFei9QaGVkSzdDbm15QWw3TkRoVGtXL0NkaVY2QjhnQnIxRzBZNkdRamJy?=
 =?utf-8?B?WFdZUm5sZUZHMGJPVysxVzdkaEp3VDRvLzdyM1piQWxmQUNheGNQMXNxN3g2?=
 =?utf-8?B?TTg3SUprdzN4VmdlSlJKdEpRR3VOL0JjaXJ6YjJjN0VBQ01SR0Q4c2pSdHRx?=
 =?utf-8?B?d1dWQWlPMU5JSW9mcW5pMzNpSlVkRG9GNFM1aGpIdUZQZCtLNjI1RmlRM1F3?=
 =?utf-8?B?NWsrS01qOEhSZWlpN0NYSXJlbW1NMko0Wm55QjFwcllrV0RPdnhDaDJCTjAz?=
 =?utf-8?B?OUlxQjdydG1xT2FxS2M0WHYrbGwxZ09DOWJ6WXlPZG12WHlCczBxbElzY1RQ?=
 =?utf-8?B?QUNjOVRNU1ROQ1RMWVNvQ09MSEo5blB6RFYwNmcxUlpVZDRFNWRkaVpQeW84?=
 =?utf-8?B?ZlJ2aXBtMUd5MDloNU81YncrRXJORFdhdEMwQlV1bm50Q1laWXZ4TVFxMFBP?=
 =?utf-8?B?Ri82bWlqaDBCQmwwNkV4ZHZLaHBtZ09oaE0yZm5WMHh2bktJTG9Md0N4ZkI0?=
 =?utf-8?B?RitYdUt6bWZ3eWs2VUh5MWFmc3U1L2ljaUlnV1FwUlJid1p1MmFtaTgzQko5?=
 =?utf-8?B?aEpldi96M2VMbyszMlhzRmdQN3lPQUNnKzFSZmxoS1Q4b05Ud2pjWHhsSTZr?=
 =?utf-8?B?S1FiYWFKMllEUUN6Tzd2anN1MFV2RnpzZ0JCYmRZZjFBak9SSXF4ajVTUzVj?=
 =?utf-8?B?bmhEdmExalordjkySDRrbmtCTEIzaldycFZKa2FuWVZIdi94U3ZmUXVLUVE2?=
 =?utf-8?B?OVE2ZFlTcXVKbmNEcmpGS0ROVzB6bGlyTy9JRURvN0NCNGc3T3NBR2paUnlz?=
 =?utf-8?B?alF3d1dXQWdWRXZVMmt4WDdLNy9nY3JxbU1PUWVjNVRma0pzWlpYUDYza0ZK?=
 =?utf-8?B?cUlrNlJBa3J0Mk1wblhlZTJYS3Z1b0ZUaHgxVi95YUJZYThWZFlFVGlQTWRU?=
 =?utf-8?B?by9ZMGM5VlVsRTVYUGhmZjdiQ0liL2tpYlRoc2dVeExZbmxwam1uS2t0U0sr?=
 =?utf-8?B?V2xSM2o2OVV0VU1zNlZaZG1KSjdZNmFoRk9yL2VPbWQwU2dVU0ExVzBIRW85?=
 =?utf-8?B?d0VnaUtwWUI2Yk9ySVFNNnBhUm9Pd3VGUSttdG84bks1V2k0NXNHY0dzQ2p1?=
 =?utf-8?B?K0NubzdQV1lLcWNGbzBRR3VxdEU5T2pzRHV5OGgrRU1XbGVIS21sdzVKVGRP?=
 =?utf-8?Q?T33MDvGhdrHRuyQI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d98c9-0fd5-496c-2646-08da350bc5d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 18:09:50.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGQmRxc/9xVnb3ch1ltW3Lw7hMtwAUo2PVPSKQGBkqh4DrY1Ckw8gptNTsG8HGucVywuZAT6jBzhCAk64Dp9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_06:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130075
X-Proofpoint-GUID: Vh-Rhf32uhc3b02Mxk1S3gKq0SCWseYb
X-Proofpoint-ORIG-GUID: Vh-Rhf32uhc3b02Mxk1S3gKq0SCWseYb
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 10:26, Andrew Morton wrote:
> On Fri, 13 May 2022 09:43:24 -0700 syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com> wrote:
> 
>> syzbot has found a reproducer for the following issue on:
> 
> Thanks.
> 
>> HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=174ae715f00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
>> dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11531766f00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce5a9ef00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 3611 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
> 
> The try_grab_folio() added by 822951d84684d ("mm/hugetlb: Use
> try_grab_folio() instead of try_grab_compound_head()").  That commit
> has been there over a month so I guess it's something else.  Does
> someone have the time to bisect?

I can recreate in my 'easy to debug' environment, so I can bisect in
parallel with other things I need to do today.

If someone else has dedicated time and resources, feel free.  You may
beat me to the answer.
-- 
Mike Kravetz
