Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4D52F689
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354181AbiEUAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiEUAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 20:05:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF641A8E08
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:05:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KIlHCY022610;
        Sat, 21 May 2022 00:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o0c7eYCGQAoqYHpx3V/Y1QuCD5s4yvfcGRRduCYcEmU=;
 b=KK+hENR68r4WFJRZiCC4YJq65iKYqaHwuDkvZkVG4cNJ+aKoWfcmBpmv4gGiF8DoN8tb
 BFf3u6cTjUcxeb5aJZaTyoQwZ24vz1lxpeTQ3KTvA/AHvVyT4x7xAkqbEY7xMDQoBAFV
 Te3ywIELzDjmB9q8fDJwsvbBv/ZoOG19ZRiOFdPsJZukIfUZnJbdbQFAPBNkQRoIxNki
 vI1mgDqDik7zQOb2nX4S8a23LNN2U3irHkjJw0ydteCbkzsUZjZKFikAWlOWgWTPvc6U
 AAbtgO3znkcOaxbXSJC2ejUe8DdidlJWLp0in1/3PuP6pT4ZLVT6bUELS9S/Qcvy8uLI yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24yu0caj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 00:04:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KNtLKN004699;
        Sat, 21 May 2022 00:04:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v6quar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 00:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha6WOY9fwJUfAz+FbI3vKftuehVXhnXZm8KFGvdKfY4s1S4aptFhCXVd0Rn3Zq9p98dJq+FJtibHEvYbNC+fGoS9ReWiKKpNuPGe8fasGmKBpEoTOMY/mzW/wbRH9Kq7LshaLLsRGaDJ/xNrqeP4KwRHOQ8XqoRdyCVnKmB0DXLhNHZ6CsNUOcyikzRazg+v87J7InettA5dDb8tNF7KN2X1/0q7K4DbNFEq8OTZe3RV70dHyEw6gDZYQP1LlwsK1oUvPeZPGLDawmhc4F0LgInbmpaSXX8D4LyFOC49e6AsAlfJe8TEUyp49DgGyBtKWwqDT+nX/6GenaXKMTBn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0c7eYCGQAoqYHpx3V/Y1QuCD5s4yvfcGRRduCYcEmU=;
 b=fTsgWCzlKysYQaG8HknICdiDniyGStv1VTGLlzyBDvrhwjMSeofQ2WvUoAKNh5YXhw32zZhRzK/+X8SpsH9ZSzhW73l9f6gdYs0ma0Eq0zD5SR63bbSL8CFSM6Q06u1clU66ScSKXRFWN0Cnv430XHX3PRjPWiR7qA2ESvfmN3DAI4KaXWGLPu74aHm5oTd3yH9TDlxzUJsyOz3zIAZLAwkJ/67mDBmk8/jv8yhu831c4SBN6lE3/Oxbvl9K31kKnjVSHW8tTTOEKlploLbH4eKRAykVZh2xMABEP3VoBEvQFnX1fzAqjZy7ocwbNPoHoDpFIzuGxiB3LPFNffPjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0c7eYCGQAoqYHpx3V/Y1QuCD5s4yvfcGRRduCYcEmU=;
 b=ujGuPv5DHPaD35tqAwJFZ6B7VreaUjqy9D03L19ZPZAB6BrLgCKkJ9IXcpiRcp/NASls79vZFEOiIpkk2EBawfbgM6s9NE61j57gm1J876K6ZpgrCdh0GIcvB1XtaDA6ee+9xDiQr6PzeOoZpog5vVdDgMMhcrd2CBiOU9YhrqM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5444.namprd10.prod.outlook.com (2603:10b6:303:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Sat, 21 May
 2022 00:04:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5273.019; Sat, 21 May 2022
 00:04:24 +0000
Message-ID: <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
Date:   Fri, 20 May 2022 17:04:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YognlSdHAKgnkPPY@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 383c977a-9d30-4a83-98d0-08da3abd7719
X-MS-TrafficTypeDiagnostic: CO6PR10MB5444:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54448BEC507BA00A438C3E9DE2D29@CO6PR10MB5444.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIaPawEvPVl1JeN8W8eu6dRyUSiwJMZhgv1TuY70WZ6CWRSBJj91G3nscq1ymv8F2bMqlMBy3Q/Uh8AhCA/Nd6WmR4LJE3sYmpWyamqLzHjduT1qj23FL+QWsqJi+FOEV0b+NM9cvQduk9FYZT5UAlDvotAG1gnfy9QyrQBTGGEDPo83+p2woVmHV3imwB2JQEycQtfVjlZyX7w23Orm4bu2A4MVl61W7tXOR0RrJXr3bYHeDok/8Ex4yO1rwb4Sd0RzaIW0/9mdgrt49LAMZ27puw3pMFbuoIpzJsYIQ+z+rRbu9hqx5nGpOcrRiLDgsg/GTmabQkKI9iip4iArZNqaVQzRgOuXhwrWkLFgd3MpmxG2ZjkdTgg4GLzsafme8/eaqE7HvrCBOYVI3rqCaTBIFjnwopFqSDj33GXN+Ir+ogA5r2U+t1ojEcSdQZXtiZaAcJrCF6TeqOB6DEj16K/6fM7UQYZ5r9nwLVkCyrbbruFjezWosRVmyRAAr8mQRDVN+lNzTr88neVG5VeWyMXNAhqDcSVTDMSl7p2gZJRDIzE3QsLdh8fZnYzzFxqiose7vhbPMzojL36Zlt7PKu+jJprfZFNzhHwY7xHbCgS+PMhACA5jeZyKnkjalko+hJxdGl3v0cU4CG7HYLZKsbBJBlKBRsExVL7LUccZbzfOV+g0X380OP6z2h6qUTuyUCUPTp/G9p/ALbhIZrjSKUs6fQUt8NGkWfVzDKYfpxysRRG5C97cVgneQ3RLkXcLCNPdjT3fLm8eiBqUsvMQyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(2906002)(6506007)(508600001)(53546011)(7416002)(8936002)(5660300002)(44832011)(31696002)(86362001)(6486002)(186003)(26005)(6512007)(2616005)(36756003)(31686004)(38100700002)(38350700002)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBZWXZTOVhYUGVXd1kzSXRuNkFzTUNzcDZ2Yi80NE1XcFNBTnUyRmhsUVJY?=
 =?utf-8?B?L0VSUTU2MmI4bnhPT0MyYTFYcnREaVFPdU5NTXRQcUNNR2FjTnUrTVpuenph?=
 =?utf-8?B?VjNPaEprM21ZSzBDQm9MaXg0WExNYWJLOWhtdWNMN3I4bEFCZ1BSWktVRjJu?=
 =?utf-8?B?dEFSWGh0eE90ZHM5Z2VHQ3NKM1lWVk5DSUVQc09ER2FydldTcjA1OVJuUWd4?=
 =?utf-8?B?OUNFVmI2SzFsSWU2eGsrcFN5dUswZ0hjU1JMb08vLzZ1M29qeDhSS0hPcDN1?=
 =?utf-8?B?dG1sZU9LVXBCV2NRYXRsNkhzMVBDMFowSXk1aDJOeGNqVzhsWmQza2FTMFRi?=
 =?utf-8?B?QVZlYTJQV25mc0xZZi9kUWFtUUp2U012RjJ2UEZ5WnI0cUtjdWZUT2lGVm02?=
 =?utf-8?B?TFJjenVKTW1wcVY5RGs2S05weGlzMGtUYXZaaW9oaDhLL0J3QkZtTHM0MzlU?=
 =?utf-8?B?UitqTEw4NzdWNU1ydGR6T0pPbVBJZ1FnRTl4R2NlY0d0WVFqRFVXVmdKTVhR?=
 =?utf-8?B?YUVXQlo0eGxNRHRNcHRvR3ZvUWdxUW9zYm56b3NWeTNHbmJaRm5Udkx0c2hi?=
 =?utf-8?B?UlNvTGJVUDEreGl2R2JOaUVMOTc2enRmMHNRYURUNFV1RmJiaEVqR2hscjlQ?=
 =?utf-8?B?cjVrelBVT3pZanQySFI2RmFoaHFkenJOaXU5SVUrYUxCQVU1b2lwdWlmVEpH?=
 =?utf-8?B?YWJ1TENzVmRrUXQvQ3c2WndHc1VEUHlNYmdJWUFwTGdaZmF1REJHbERWRW9B?=
 =?utf-8?B?cnNFWnVWWjdickswUTVyM3hQR09pYW1Wblh0UlVlSk0zZG8xTEVCOXJBTHla?=
 =?utf-8?B?ZXo2QmRVQmtUQlRCVGc5TmJNRTlGcFo3bWFIOUc2UVViZ0ljVFB1ZmNOMjFC?=
 =?utf-8?B?UUpQRlhBbzduVEI0OUNPeDRGOWVZbEpjalFMb05adXhLbXlzYVNKeGxRUW80?=
 =?utf-8?B?Sko4YjdhcmRUZkphVmw3S1pUUHJiVXZNV2FXd2xJL3JjeC9ESHB5cFgyM2pX?=
 =?utf-8?B?WDBXVmw4RW1iT1FCNFUyRVZNcXdUZngxMnFZSzBkMFlYdGVrazRrOExLa0lu?=
 =?utf-8?B?bjNMcFhwZS8zbWlmSG15NzYxaE9BdFpyQWlRTFJiSXRIWGxqVWV6VHN6dTRR?=
 =?utf-8?B?RC9OVm9jK0YyZGxidURwbFZEOHE1aWhZVndRWlJyUkNoRzhYMmxDUzcwTDl0?=
 =?utf-8?B?eEZ1YmkrN0hGR2RzdVgrbzU0bnp5ZHppcnJJRjlCaEprUEp0elVaYW92UjAw?=
 =?utf-8?B?NWJLVzJtTHhlbXJUV2dtdEZLT085L1hZN2drVWJScGJnMUE4ZytjTXpObTJD?=
 =?utf-8?B?U3lrSGRPZHZlUHA4enhkOVZRMnM4WWFTQml3d3UvazZyOVVzdFVqNkhwc1ha?=
 =?utf-8?B?bzRTS2hzNTVTVHl4eU5LTDRMdVRpZjhXMnI4Y3h2cUNqemZNa2tUZ3JYZDkw?=
 =?utf-8?B?M2JjYW9GWW5tSm40WTh4bTBtZytCZlN0MzJidkN4STQxeXc1RURTdDh5NU13?=
 =?utf-8?B?VlVvMU5LTXY1TkU2ZldsdHRsMWlQajlTWmQzajJBQ1g5dENtRVlJUkRPZmtK?=
 =?utf-8?B?aGFjV1BuZTRPdEZKaGRjUG1jNHg3Rjl0VDloaE85MU9vZHhTSGVWdjRsZThr?=
 =?utf-8?B?T09GR20xVkltZlZHRis1bnMrNjFyM3h2TGsyUVRYT2dGeGdWUjFlTWI0dnpJ?=
 =?utf-8?B?Mis0Z3ZGZjNqcmh6WHdqdTd2Sk1kTUZ1bWkrZUc5SkNZYnE2VG9KQ21ZSURR?=
 =?utf-8?B?ZVJhOFFzUWhxTFl0Q2JETFdSYzFHamhpVEFuNVdMQUtUTzNuU3lDZVhnUFNP?=
 =?utf-8?B?ZDhPS0NWNWVaWSs0Q0JYT1pRKzQwUWRvTm1GRGROdFhIY1d1bDNHTmNtOTFG?=
 =?utf-8?B?RTNMVHk5N0hEWlI5OVRRZVFsbUlueFUwYldwNFBzeDYyc0QvL1ZyVGJQdHIv?=
 =?utf-8?B?WVE3NTNnK2xFQkJkVWc2bGF4bks3ci9PdXBlUEFSVzBwaWlmNFFRRUpEUmtp?=
 =?utf-8?B?K1RLV0lZdVczdmFtcnJDcHFldWswYmZMWHJxciswbVRUNGlmOWJKZk9rY2kw?=
 =?utf-8?B?TFBjeUh4bmZ6WXhuMW9BaHRHdjZkME4yWmZrRUgvWE1xTUhKN0s1MTRZb0Jx?=
 =?utf-8?B?STdIelFBbkpYeHFjWXpzZCtwK1NkM0o1ODFXUTFtRVZydDZxRDlYdUNaQUx2?=
 =?utf-8?B?YU5Yb3lBbDVwRlN1blZEdC9hL2hjRXdiakZqOHpVbDhFMVNPUTJlZG56YWwy?=
 =?utf-8?B?bWVPczlveEw2T2pZLzlLOEZXYStyays2Z2RvajNCY29IMG5xUTNad1BSMVhB?=
 =?utf-8?B?clJFYUJtSU5Ya0J3Y1o3THBNd1FRcXhVandzN3pEZ3BEMDZ1cHBCRXZiaE1O?=
 =?utf-8?Q?OK3t8s+Nqn6INCWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c977a-9d30-4a83-98d0-08da3abd7719
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 00:04:24.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKVS2BLeBIQaZvQon8s0NWvz/7Z0mmxOeLNa1+ucS9t2eBe+VnlTxn7c40dgJoK+IWiKdpLqqj6B/IpzvGi0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5444
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_08:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200147
X-Proofpoint-GUID: DqlROjXfi8Do_8ji8eKtG0Ync1Tv3bOg
X-Proofpoint-ORIG-GUID: DqlROjXfi8Do_8ji8eKtG0Ync1Tv3bOg
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 16:43, Minchan Kim wrote:
> On Fri, May 20, 2022 at 04:31:31PM -0700, Mike Kravetz wrote:
>> On 5/20/22 15:56, John Hubbard wrote:
>>> On 5/20/22 15:19, Minchan Kim wrote:
>>>> The memory offline would be an issue so we shouldn't allow pinning of any
>>>> pages in *movable zone*.
>>>>
>>>> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
>>>> problem to allow pinning on those area. The matter is what target range
>>>> on alloc_contig_range is backed by CMA or movable zone and usecases.
>>>>
>>>> IOW, movable zone should be never allowed. But CMA case, if pages
>>>> are used by normal process memory instead of hugeTLB, we shouldn't
>>>> allow longterm pinning since someone can claim those memory suddenly.
>>>> However, we are fine to allow longterm pinning if the CMA memory
>>>> already claimed and mapped at userspace(hugeTLB case IIUC).
>>>>
>>>
>>> From Mike's comments and yours, plus a rather quick reading of some
>>> CMA-related code in mm/hugetlb.c (free_gigantic_page(), alloc_gigantic_pages()), the following seems true:
>>>
>>> a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
>>>
>>> b) while hugetlbfs is using those CMA-allocated pages, it is debatable
>>> whether those pages should be allowed to be long term pinned. That's
>>> because there are two cases:
>>>
>>>     Case 1: pages are longterm pinned, then released, all while
>>>             owned by hugetlbfs. No problem.
>>>
>>>     Case 2: pages are longterm pinned, but then hugetlbfs releases the
>>>             pages entirely (via unmounting hugetlbfs, I presume). In
>>>             this case, we now have CMA page that are long-term pinned,
>>>             and that's the state we want to avoid.
>>
>> I do not think case 2 can happen.  A hugetlb page can only be changed back
>> to 'normal' (buddy) pages when ref count goes to zero.
>>
>> It should also be noted that hugetlb code sets up the CMA area from which
>> hugetlb pages can be allocated.  This area is never unreserved/freed.
>>
>> I do not think there is a reason to disallow long term pinning of hugetlb
>> pages allocated from THE hugetlb CMA area.
>>
>> But, I wonder if it is possible for hugetlb pages to be allocated from
>> another (non-hugetlb) area.  For example if someone sets up a huge CMA area
>> and hugetlb allocations spill over into that area.  If this is possible
>> (still need to research), then we would not want to long term pin such
>> hugetlb pages.  We can check this in the hugetlb code to determine if
>> long term pinning is allowed.  
> 
> I don't think it's possible because cma_alloc needs "struct cma" just
> like handle and VM doesn't maintain any fallback list of cma chains
> so unless someone could steal the handle somehow, there is no way to
> claim memory others reserved for the CMA purpose.

I was thinking about the case where a hugetlb page is allocated via
__alloc_pages().  Not sure if that can fall back to a CMA area that
someone else might have created/reserved.

Unless I do not understand, normal movable memory allocations can fall
back to CMA areas?
-- 
Mike Kravetz
