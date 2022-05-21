Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5252FFDC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbiEUXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbiEUXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:51:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00303B2BE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:51:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24LFqjLN006977;
        Sat, 21 May 2022 23:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nYvZ4xzEpbSd0S3BmUsY+klbyHoTNTtS58yHHv5vEAg=;
 b=yZohmY5bAzFQvZHh1t8imq2p52dJY+laaqE8mFMNnGaWDblL4qwEiIxkbkQ3Kwe8Gz3j
 asykpQ71g33TsWbF/MQg1L2q5bT8HA4OIAEnpqNrmHE6C0IJjmCfOb3+aY6wjxPg6oO+
 bDdWiClcu97CPzLBebEMtVEPJktaHlEWBSQZf5fQ8UehTbG30nHF9+QMv6bU9Hke+Rh8
 pb0X6Gw86wCekq7k0C//73oEzjGrOgd+QBmmhO6BfG9YabU7l2OdQGQmEAoz3yctleBN
 PJH48EWnFM6FkgDfYaROHfVDP9a933dkrcFTsExEp7Y/9FPKJvLGMeHiRFAX4ZSZHCrR Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps0vrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 23:50:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24LNk2wq018293;
        Sat, 21 May 2022 23:50:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph6sxmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 23:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOuk07ox6aRT347mwlA6RwZURGagZN0x7ybsRwIFoW/z25ldM+BERG9JxTz6EhONNNw4ISjRSO2GD8jOYP70fJrXzvamYxyfZUgqVGp4hKXxaZF4ycVOqfNMCQi6eVr52AcqdAuAQ2L8v2qtfIHofnMdOqoLJcUPatGOMplyBAwCszPM8reYuICXUHbYPRoY6XZZn7giotpBS5kJkMrBX5f6AIk2L87zUZ6TotBnIwoeTAAxhTgWTBhvxj2qFERnw0imojraKF1hLjKDAGlCO0nBs0YQh4BK3ba+KhCOR7ku9etxzJy3M8iZ1tD8qG8L1UFzbmrkEgKcTtPNm+EflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYvZ4xzEpbSd0S3BmUsY+klbyHoTNTtS58yHHv5vEAg=;
 b=mCJMZ2Mbge0KH28Vnm0JutsHbcdrVK+w7QznBqYUAL3bOLECfvZ6cj+Q2aJAKo//0rA3gNHyPLyEe+hwhx2zUu5Gmx+w0TG92qm21hnEOek7krOWBqRMkTq/rqPLNlT/exHOuZ5qbFG173sSsKmGJqGd67G2JWu7Fh9XRQ/7cmCpELiTVVai0JAlzB0wiZO+OP3QKUNz5byQNYkaE3KOP1mwVtQi4+dGcB0DaAgCzKGOF9LXaFoD0uEVIJ2Xl4zw35Sv6PmboC9jEylVt+HXfM+yTFT6XiUzsKYCyNPe/EV4wLpCxQD6bNlEi5q70jggYDnvQLti/9Yab2JgIyp8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYvZ4xzEpbSd0S3BmUsY+klbyHoTNTtS58yHHv5vEAg=;
 b=glCtycCjNEffcoskClfWe9+7hpeFdbKqdVlhf1OgkdDAehkgHw88W4zRO0/4oX467TjoP3wOVt2R94TtyXfVfeatDb+2sa0+/jtlExVbw/zMpFWNHRiA06C7cumPjUv6dzQBw2vSqdzg/uKxy2Uc/24r3utOnEukBWEbEAQGyvs=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by MWHPR1001MB2208.namprd10.prod.outlook.com (2603:10b6:301:2c::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20; Sat, 21 May
 2022 23:50:54 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5273.022; Sat, 21 May 2022
 23:50:54 +0000
Message-ID: <6daa971b-03f1-0f69-4c85-ae4796d339e0@oracle.com>
Date:   Sat, 21 May 2022 16:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
 <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
 <YokEEAemXTwTSZh5@google.com>
 <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
 <YokVEZbOayed5hBb@google.com>
 <000a117a-694d-d3a9-a192-14d08d50c884@redhat.com>
 <YokufHxnkHUk5UR6@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YokufHxnkHUk5UR6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f053d187-985b-49b3-2ff2-08da3b84be2b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2208:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22088BB1EFFE59DA483A7CE8E2D29@MWHPR1001MB2208.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXVjXp4fxp+yVyOenc2i6rlC/hWocMulDdD2uT3bqADttF3dUIgEcGr0mh7+lxMoxjyzH01hcTr3kLS4A85k/91OLeLh2YN0IsivYMjl7STXS/VLkMIdroZo1qtEUwO3dYVqcNAz58o2vDMezlFUy5cZqXwulYqQ+ElQNjiaC+VZ+p2PIJAvxt18JsNq0DpM488nwAqgrSK7ee8PK7QHZDrGW6h7jXZ0L+YRk3plh2wAEphR3dcp4z5h57SxicE9eWutJNsOZgCr8IjT6aifT7gIruNHvtcUgDYhcRSFMynwi8ZoclOpmbV8Ooyr6DUJNxFvFbQeNXMGPcOKBFltX8JRvLWLQGfiV02gaIHfMgWz6hC8143ee06U++5LmUfUwywf5EA4gtxNdprC+fEupbwL5Q2GXh15iAe8th4cU8c/spxC5RMLmv0PgwDFp71ajyLRprFRBDCuqIozq2ejztgbLIn6ciplVTWTW6NJGzjBcGf+ij9salifjVlzmZKySs2sG285Qk/OMX9dvTAOD3JnhitUK2oW5YCVHdW6qLP2hOHRV1wmmoEfousXayYbL0YLsQ54OIzvoje7FeSb5iw9qX/HcD5Id5ej01FH7t+HRn/rnT8bExkJd4wTQYv8XsAMe+Qj8UTdtyBNi1Z1dV9n8yWQLNmL30xKMLzNAgeuuElDVX/hrQWDaApH+Ge8uc+gM+Q5Tb8fa0uE4MtmzOjhRgNGKfgOzEcKO7VCY40LI3+xw862qKerLp+vjWqxQx3V5CYrQi1/rOrYwCDdeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(38100700002)(38350700002)(26005)(2906002)(31686004)(66476007)(66556008)(66946007)(5660300002)(7416002)(8936002)(44832011)(52116002)(6666004)(6506007)(53546011)(6512007)(316002)(54906003)(4326008)(6486002)(8676002)(508600001)(110136005)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHA1VHEwcytUa1AzV2RYNXRiMndBOGpHMjV4WUl6R0M4ckhESHpZR1R3MG0z?=
 =?utf-8?B?bEFPbUxOemFackE2aGVveEsvSkxBbDBETGk5VVMxL2tveVpTbllJVktkSzR1?=
 =?utf-8?B?eERYS0daTmozRVJEUzcvYUZUY0FnTmNRRTJsZHg2UlVvSlhtOEtONDQ4RlA4?=
 =?utf-8?B?TVhDdnU3WDgrMG96U05sNHlaUWVXTUFVY2MwNDZGOUtoUDFHVnhWakRsUW9o?=
 =?utf-8?B?VklzQ3ZzNTNBRFc2eWNyYWRZVFplUytEdkxTMTJDQ0VHbFZnN2FzSUh5WHZV?=
 =?utf-8?B?WkhzWWtHNjF3alR0aENuQWptQytkWk9USFJiYzNiNEZpZjZNeGZwSXk4Ujhi?=
 =?utf-8?B?RGQwekZJaDF3WFk5NkFXSzUxMElXSWwzWW9uMkp5SE9rVU9IM0lsV0FjOWJq?=
 =?utf-8?B?MWgrQVZNTFNXMVhjaHM5ZWVZaGRRRWJXaFNPeXE5TVVyQVlqS1Bpb0VISHR2?=
 =?utf-8?B?OW1seFNmWWY0OW5naTNiQ2JxenBpeXF2Y0w5Wmp3andDeU55ekc2OXhnd2pp?=
 =?utf-8?B?TUVMclFBVUQvTC9ibC9iR3AyWHpvaVdJdjFOWlRCaXBSQUUzNnU3c1g5aUZx?=
 =?utf-8?B?RFBUaU9QcmtoenFmb3VsTjFaVG8zckxUMXVuU1pSYUkwOWkvVWZQSG9tRVdH?=
 =?utf-8?B?NHhoSG9nWXJkRHd6YkxaMEdTUVBZTGFWYzNUYXY4Q1kvSUg5NThQL25tZGJE?=
 =?utf-8?B?OFhGTXdGd3VXTDlXekszNTlzRzcxeU1YRGlYcWJMK3J2TTZZc1I3QldGQU1n?=
 =?utf-8?B?NTJDUDQ1ckFsd0JLbHd1YlhLa0k3bWxCY0JvR0RJWW5zLzFQd2dtemgwdUpn?=
 =?utf-8?B?U1pqemNMbE9TM0xJSWcvZTM0dWhCbHV0d2lIc05IZW9SUW1QUTZMd3BJQ05l?=
 =?utf-8?B?ZGQ5VitFNHVxQmYrb3VicEE1UU4vamw1elBhK3VNb1lvQ3o4eVZwTFZWS3N0?=
 =?utf-8?B?VnVUVDdOV3E4U0wva1JKQnU5YUg5UzI1eFhuSlNadXpKcjduRU9KbVJEMHhP?=
 =?utf-8?B?TjZDUlVuNjNydzlRL1lLMlMyOXNoWUxud2kvSnVpU241cENucXJLQkx1L0VD?=
 =?utf-8?B?RWltai8zNGFzdmtCVWdvY2hUajlKMnF3UGZZc2dXdUZ2RERoRHU2c01SVzVK?=
 =?utf-8?B?RmMySmpIR0MrTkdoYjQ3OExpUXB6bThJWVdSN2NsejlQVThJQ1R1YThmNzEr?=
 =?utf-8?B?N3k2TXlneDNxQU9WRUlyZ1ptQTUxOW9WVGF6b2U3V2NmL1QvYnU5OG5zOXdW?=
 =?utf-8?B?ZWNQUXBrRnpSbHk2Ri9ySnIwT1BsdGtzYUJVRVEwNlltTWhjQlorY1RBayt4?=
 =?utf-8?B?Uy81cUI4S2NLZ0tRaVBIUzBEYlBXUHFYcHZ3ZFAvNnZGc3cvZFd2ck1xem5i?=
 =?utf-8?B?Y2xiWEcvYVo3cUxicFliQmo3TVlFUVJheSsxaFczblJUc3VNcndDVEM1TFla?=
 =?utf-8?B?bWdYczI2ekxjbHp4TkFsRjIrVWNNVkxSeDZHakJ4WlJqOExLMmxpTHM2eCsw?=
 =?utf-8?B?QzVEdkVyQkFMcEFNM3IrOFFua3JRdWpHRUhpWnhXc1dpdUs5OW5tZmJ1K0h3?=
 =?utf-8?B?TlozSkMvMklGUExMQ0NJTmVKcWhEM3d5Q215ZlVLNzRra1FGeEdScFFzazF4?=
 =?utf-8?B?VlROZjNEMFQyN2gzdGVKV25xWjRUbTg5czhoSmwxb3pySUNvMDZWMktKKzZu?=
 =?utf-8?B?cnNhY2JyRXhJcHN3aXROVkdtL0VqeEZWWXl0dHpRTlpMdW41M2hZcnh0S2pn?=
 =?utf-8?B?TktrWVc0SlR4WmlKRk5LNFBMeDljNURVWk5qditvekxod0FHM3lkUXBzUGgw?=
 =?utf-8?B?bTlDYlE1ZC9EYURkZ0d1VVhFUVA3cXlRcTErRkk1dy90dkk2QkRZb25yMHR6?=
 =?utf-8?B?RzdvMDNTUWZleGpDcnF4d1FvVS9IZzZPRUh3bFM1UmNlNEU0a2tQNENnVkF1?=
 =?utf-8?B?STdMdkdWT0JyT2I1Z3J5bzVTNitPSFBzaHEzR1pVTHR6SDZwM2RBbkd6Znpv?=
 =?utf-8?B?OXlYK3JRVW04c3Jpbm5kTXBPeHhaWXB0WVBVSzBvRnVrcDhYdHZrYndFY2sv?=
 =?utf-8?B?WUx6bE5iWkdKaGcvaWV2NUYwMVRqY3JsSlBkbnhmQW1sTkZTNHBJV0hISXgy?=
 =?utf-8?B?YlJzSjRLcGpFUXBqa2I4bEdnVnNDeWNrQ2FZOTh6OE9pSVBta3VxMzNxb041?=
 =?utf-8?B?MWQ1bEQzd21lZ3J3OFQreDNxSGhGTW1pWS9BVGI3ZjVtM3hnZFJralFCMDBx?=
 =?utf-8?B?UHlVaWNSVUNZenF2blc5Vm40bEVpczJEbjB5bmNwRFhDK0FEOE5veTZGZnFX?=
 =?utf-8?B?YVZLbW5MWWFpNHNGU0VWV2lRY29VTkJkN1VUL2pFcisrQUNweXBoN1RPcDQ1?=
 =?utf-8?Q?JcWTgi9dNGmfDN3o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f053d187-985b-49b3-2ff2-08da3b84be2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 23:50:53.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNa7LAZOlunSdEDPYt3Sa42tz7zXia8mtFdUQnPuqb+8ajuJF69ELgfJKnsIjgXswhvQdWdXXJQLYpZMAC3eLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2208
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-21_08:2022-05-20,2022-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205210153
X-Proofpoint-ORIG-GUID: _M5kgwF6t7nHTXIri1xGg-SFnRfh-C1j
X-Proofpoint-GUID: _M5kgwF6t7nHTXIri1xGg-SFnRfh-C1j
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 11:25, Minchan Kim wrote:
> On Sat, May 21, 2022 at 06:46:27PM +0200, David Hildenbrand wrote:
> 
> < snip >
> 
>>>> The general rules are:
>>>>
>>>> ZONE_MOVABLE: nobody is allowed to place unmovable allocations there; it
>>>> could prevent memory offlining/unplug.
>>>>
>>>> CMA: nobody *but the designated owner* is allowed to place unmovable
>>>> memory there; it could prevent the actual owner to allocate contiguous
>>>> memory.
>>>
>>> I am confused what's the meaning of designated owner and actuall owner
>>> in your context.
>>
>> designated==actual here. I just wanted to distinguish from someone
>> current temporary owner of the page ("allocated it via a movable
>> allocation") but the actual designated owner (e.g., hugetlb CMA)
>>
>> The page/memory owner terminology is just confusing. Let's rephrase to:
>> only the CMA area owner is allowed to place unmovable allocations there.
> 
> Yeah, the CMA area owner is much better.
> 
>>
>>>
>>> What I thought about the issue based on you explanation:
>>>
>>> HugeTLB allocates its page by two types of allocation
>>>
>>> 1. alloc_pages(GFP_MOVABLE)
>>>  
>>> It could allocate the hugetlb page from CMA area but longterm pin
>>> should migrate them out of cma before the pinning so allowing
>>> the pinning on the page is no problem and current code works like
>>> that.
>>>
>>>     check_and_migrate_movable_pages
>>>
>>
>> Yes.
>>
>>> 2. cma_alloc
>>>
>>> The cma_alloc is used only for *gigantic page* and the hugetlbfs
>>> is the very owner of the page. IOW, if the hugetlbfs was succeeded
>>> to allocate the gigantic page by cma_alloc, there is no other
>>> owner to be able to claim the page any longer so it's fine to
>>> allow longterm pinning againt the gingantic page but current.
>>> However, current code doesn't work like that due to
>>> is_pinnable_page. IOW, hugetlbfs need a way to distinguish 
>>> whether the page owner is hugetlbfs or not.
>>>
>>> Are we on same page?
>>
>> Yes, exactly. What I wanted to express is: for huge pages we have to
>> make a smarter decision because there are cases where we want to
>> migrate, and cases where we don't want to migrate.
> 
> Sure, maybe hugetlbfs could squeeze a bit in one of subpage of the
> CMA compound page. "I am CMA allocated but allow to pinned for longterm"
> 

Thanks for all the ideas here.  Yes, we already have a whole word for hugetlb
specific page flags (see hugetlb_page_flags in linux/hugetlb.h).  I'm pretty
sure I even proposed a 'allocated from CMA' flag, but there was another way to
get that information.  We can add such a flag to for the purpose if making a
decision about long term pinning.

BTW - It is possible that a gigantic page allocated in CMA could be demoted
(split) into smaller hugetlb pages.  I 'think' we would also want to allow
long term pinning in this case.
-- 
Mike Kravetz
