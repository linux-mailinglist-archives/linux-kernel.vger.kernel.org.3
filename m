Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E257849F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiGRN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiGRN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:59:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517222289
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:59:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZKkd028403;
        Mon, 18 Jul 2022 13:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zden/FfAFlA7VwHfl5uNLpSbJmIbDIrWCPOjDyL5dBY=;
 b=VlIwYjRO6HW5jjwav8ISlcydJaKYXaMgYsrxnzbSJpMoKlrp3TtSruJFNPKLDNXneyn4
 mRly5IT4oJx/mPwpzEwNvYOKR8y30ail8l87NQfst3ROfsBftvFeVRqowRXBmgsbWygu
 67yHZeYoZ2/xxI179dTi/O42FL3omRoS9L67Z6ElsWkl3O94bgLu60QcSeaHBR3p3pSv
 ynI6hEt5PSDHptGK7oLfcjY10Rx+KIY4YQr0rVbEXMl0To3Fs4BWFmjYLA87vQs8xu/B
 sCqSBSK1k2oJovomPj6CJAtjLcpKUFO6f/D+PgMG7ARbxOztArrYaR1T0NM9YnDykBa9 sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0ue67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:59:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IC9WAi004030;
        Mon, 18 Jul 2022 13:59:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3ump5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns11Sq/7gOMCZMr+TgXaQiIXGYdEi2Cx4h5o4q4P2Vv5plqCguAvre2x0g+pVVmU/1XJtJRWTvon48Oq41Yf+dIoqODzyC72QdA43kynP5scehbHYczKjeWq9yFKjlb7j+Z4EVFp++7onk+KBSVZeymgxRdh0vQ1t2LBdGwRuhVILldNgWgzI+mEZJcZ9FO1zGNSwvXJcSzStyizfp1o72RPg6g9sdXM5ig0nF7yk/Ans/D6SszzqY9XTEm0+gca3W1XAa9ieKFkLIq8h4liCam3U5vCoEuFWsnxegMkD4gUPuoMbHoZdCPROk73ZOjpa90rKQNG6PKCEeDjOrIuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zden/FfAFlA7VwHfl5uNLpSbJmIbDIrWCPOjDyL5dBY=;
 b=NK96SJc7mTwcGtoP47V+2tnWNxRo6RBio40uG+X56NoyGOql6+dm4+dGZufwWwgctqF4ChAk6f5nbHAlE3YUP8d3m5BE+puUl8DFGHOPAzqTI+6ig8/Y+OWwiTh2b/zj3Wub9zHi58inbQarOjxD0dnMvRcxmiyuzQfYFLhqzG1Fc0Ci/aiE/MnV5SNvsbOJMhmgSwDIF+YgHnTylkNjTIaCdPThZJD6cktVtNpzTFfQqE9Rn2KbGRbLE8DAoLZjcG4BhQNptMIr45lDL/Nj0ZKABFkap61Xaq+MOwvMgzFHBGZYyg9Qk51+Wuw5ZYSFmp+swEza6hNLd49n71DRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zden/FfAFlA7VwHfl5uNLpSbJmIbDIrWCPOjDyL5dBY=;
 b=FPht56eWeUbJOO+DtWeUInG6woa9qOitlnrOlmYmtAnw4HRSIm5fTd1N+tuulipZNn2nVX/whgM85sXTiMgQyvw1WV/LA4kbkJ+qVNIwNM53iJHr3wz34P2/qDNCd44v9tb1pOeL0IyKA5lSRv7r5O46ewSx1iNTCq5MVpjCHh4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR10MB1870.namprd10.prod.outlook.com (2603:10b6:300:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 13:59:22 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:59:22 +0000
Message-ID: <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
Date:   Mon, 18 Jul 2022 09:59:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Jane Malalane <Jane.Malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
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
        Colin Ian King <colin.king@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
 <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:805:f2::18) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a09814-81bb-4e28-0b3b-08da68c5b72a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wN5IHgnhlp8M4p1iImqVIQfzB7hWLmFoCbEeYZsYEMEmh51adR12IcV2vU8XLSPK5NkzzkVIQpqMKJyXQiylNncLaP2jWggxoFBE43lHCOfHt1x6GtCSwNdYx1GIYlYjNIlAMX/ODEjCWifaUiBSyyPNwrbs7DutUF2KyOoOBNuWTJXnyRtenx13patCLgNCs9d01/K5jw476T+x/efM7XUYWWg7A4JA3gn3rC9ToszUo99Yb6aOwjO3HWC6KSFY7eZbsc3E1jpE3Kj49wfMqfdVbnK/MYyOyu0ofubb5JQ65XDmvVJZ++Dj8qmDiMRtfqKmjYebDEIoGRICcoor3350TUDRDkaBx6NsRNLX10T6yFWrWvMX81juykurxmRdHPxECPoSiSqpja/vOavO+KWGCV3pTB9aRneeynH2zMlzlQNl4H6Ius+LJCzV5kHNXXsgzD2n/ETiRlPi4XQMA32DQ1e+mEElbFGKW1Ysj7RYL6eTLKkks28bPpHtyu2KBRU3Xm7i4x8G6WxpBRAwQtUyZ9z0+SzRpjQo1Jff2Fbh0dFHgCzoIBCML4fRib4sMaKXFuI3KiuoKRk57z5s14sJd9jP0pLUNjS/Hz0qRfL8WFDTC2bBq4I9UpRHJHPP9k0XXi0NAUKZWuTitRNGz+KFnYIvhbVEIT0zk1EuRR74UBqiYabF0EOcROMj78K5gz4hbekgoETgEJrubVYcNBgmmFPrJdN82SJWUBDoIwAC+vflP0cTd5HRPpaLEMvyUPmZnL4QiL1TQdt6pH+FJyh9A99rRz4n6Xa26CpAGiE6XyOg36fxSuhU5i6cvJaCVygolBl6SKeyDzKkbIK0PESWY2Fd9kxbnf8yh3h5+NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(186003)(54906003)(110136005)(6512007)(2616005)(36756003)(66476007)(31686004)(478600001)(6486002)(2906002)(41300700001)(38100700002)(86362001)(316002)(8936002)(6506007)(83380400001)(53546011)(7416002)(5660300002)(44832011)(31696002)(6666004)(66556008)(4326008)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndlYnNWei92U2Fyd1pNeitHUDUzNTAxQUhuZmVXNEpIdkJxcmwvemJnSmlM?=
 =?utf-8?B?eFg5dnU0RHByQnB1ZFI3TXBua0tXem1sL0RaTlBJVTNqeGVwMmJtb3g1QW5J?=
 =?utf-8?B?aFZZVGJEVWJmSnlvbmF4V3RrMkttUVZZVmpGQlkxVFY3cjMzWUZGWmtlb1Rm?=
 =?utf-8?B?MG1jdHYwV3FDSjE5dG1kbGFYL3J6QndlRlRZZE5QanlJT0t2YWJndDBFcXFu?=
 =?utf-8?B?UHVnMENTb2RCb3Y3ZUhza2xBbE16ZjB0eXVMUFF1SHZGVlQ1dFBkNUZnaW1T?=
 =?utf-8?B?QlNsZE85Z0dpVXZNVE9NRVNQbnhiS3FsRGN2akJWZnpLbExzNVFhVEYwWHBS?=
 =?utf-8?B?ZGtEdVhzTnRISG50dHZYL2RQMFdhNzRYNGJ0QzZDUnk4aEZ4WHJnd0lkYTJM?=
 =?utf-8?B?MnVZemQ5TkprRmI0N1ZGa21MM0JtQ3JkaHI2eWxRTWVic3FDV2hONDlDQmFD?=
 =?utf-8?B?NUgvQkF5OHp6Umw0Nngwb0hBUG5wcFlJUHpBUjFxRXRjZGhXYlBlS0lROHVx?=
 =?utf-8?B?YTdtc0lsSmZtNDhwVC81VVN3VFZMb0lYSkJISnM4eXMvV2pNRnoxZStIQnNz?=
 =?utf-8?B?MUlYZkE2T01TNzVZSW5oa3ErSmxFaXpVcXZUSWtReElCakxxMVZQSmxvbldo?=
 =?utf-8?B?cWpvVkRJQjQ1OVREdWFDUnJhNEg1R2JYSFZMcS9CS0JzaWF1Tk9vSG83RDlk?=
 =?utf-8?B?Z1BmQVFHa1hLTjJYNVI3OWxuUEU1MDJBNGRkOFBTTERhZHRYMUtEM0FlamZy?=
 =?utf-8?B?dEl4cXFzVVUwOXBLL1hEQm83c0tWeHdOWWFsSWRWeVh1WnJLWlJDdUFpYWtT?=
 =?utf-8?B?Yit4aS9Hb09yYjdINWNEbVNVNmRWckd6UXpoZ0ZzRjYvL255NUR6MFFvSFI4?=
 =?utf-8?B?T3o3UGRxcHd2RFgvaG1rMktPYXAxZFgrVE1HaTRtMHFzQUhFazMxazBpRjZF?=
 =?utf-8?B?WXBxUmI1R2ZMOW5pa0YrM0VEa0JNZllSemxwOFNCd0I4SkNNQlVzdmJUOEMr?=
 =?utf-8?B?OE4vSC9Vd0hHWnN6NzVSN3ovQVZ2Zm9PeGxacGFMWGl6SXBoOHU5Q1VWT3lW?=
 =?utf-8?B?MG1zSkJoUlFpYjRFS0xFYStDK3pucWRTTmhaelYwV01qdmFLL2N5YlZ2NUp5?=
 =?utf-8?B?aDJxczY0V1RkTkNZRFNuQVVlTE5IU2E1LzJaMTFVNzZZbnRRY2dWbno3TUhz?=
 =?utf-8?B?Z3NOZm1vb0o2QWZoWi9IMkRMRFJWcDVZRTM0ektOU1g5bDI2SjMyRjA3czh3?=
 =?utf-8?B?NVFjbzhwMnVaSnRnMGtWOGVFckY1SXRIUDhVaGNjanNnZlcreHBrYzFFZTZv?=
 =?utf-8?B?akg4Uy85dEwwUlBScnFoMHJMQ2IwcFJ5WE5EZ0ZmMEtyL3JNY25PNElqVmVB?=
 =?utf-8?B?cU5BYXpuT3p2NmQxd053a205bElreTNINy9senBXdytYekNPZFhyMEZDKzBC?=
 =?utf-8?B?ZDFhWWttYlE2U1RLWCtpK0MzVlFzcEpjK2xtdmxZQUVzbnlkTlJzVURQc0Zu?=
 =?utf-8?B?c1M5VGRpRWt2eU5EL2lWQlhGNmhva2hYMkw0aGdpd3ZZUEppRmlLTzluOXZ2?=
 =?utf-8?B?Njd2RmFRMnRQRkRNbVdhbThsdUx6SkVEamtPOEg0VjQzdmc1SUpNanB4RW5U?=
 =?utf-8?B?T2NBazh4N2paTDl0bU5BdnBOcE1kay9qZC9EY0xCR1htNEtXVGFkdzFwNFdu?=
 =?utf-8?B?bFIzN01FbzQyZmdlVGhKOHJEVnlTOTJBd3lTWnRqUENBUG5QRzVVWmg0R1cx?=
 =?utf-8?B?NkdiakJVNzYwS3k1T1hrLzBvQWhBZ0ZnVzE4d2RlQllxVmZDNGIrRjFSTWNE?=
 =?utf-8?B?L3hCaUl1ZW5NbkR3N0tXS2tBVUs3SjZGZ28yaGZyanA4cS85aEtVRXVjd3FR?=
 =?utf-8?B?MWZLK3FLQ0tweXUvTkwyQ0lkVVBHcDVzcG4xb3BHSnAxK21HdkZTWGFWb2ln?=
 =?utf-8?B?Q3I1OGl5RVNXcjlVVFl5OGJQWUt0L3MrcC92V25XVVUzZEVSUDFWNG43WXJD?=
 =?utf-8?B?YmZOc2pkaFROU3BkcXFBSDZGTWEyL3BxY3d3ZkVNYWpmY1VndkVlNkE3ZERw?=
 =?utf-8?B?UFVCZlp3S1VnQndlRUE1WXV5dUQ0aUZPd0RLTHFxS1pYcjFkTnBKbnI4Z0dY?=
 =?utf-8?B?dVJFNWxxT2pIaEZlRm9INlEzODRqUlo3QlEyREMvOU41a0JiUVFnaEt1VmlJ?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a09814-81bb-4e28-0b3b-08da68c5b72a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:59:21.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMnXgP8734lLmZuLl56Yc7mZJ2n8T1SDFvx5pODsaHy6k4/fFQn6bbuyOqGWOShAAyGURRrlmxjWTFmr49/wZCYhZ3gpoWGK0+B5k6kOsow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_13,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180061
X-Proofpoint-GUID: Vd43k06TR7kQN9IXsX-p8kkE8x_saDG1
X-Proofpoint-ORIG-GUID: Vd43k06TR7kQN9IXsX-p8kkE8x_saDG1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/22 4:56 AM, Andrew Cooper wrote:
> On 15/07/2022 14:10, Boris Ostrovsky wrote:
>> On 7/15/22 5:50 AM, Andrew Cooper wrote:
>>> On 15/07/2022 09:18, Jane Malalane wrote:
>>>> On 14/07/2022 00:27, Boris Ostrovsky wrote:
>>>>>>         xen_hvm_smp_init();
>>>>>>         WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm,
>>>>>> xen_cpu_dead_hvm));
>>>>>> diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
>>>>>> index 9d548b0c772f..be66e027ef28 100644
>>>>>> --- a/arch/x86/xen/suspend_hvm.c
>>>>>> +++ b/arch/x86/xen/suspend_hvm.c
>>>>>> @@ -5,6 +5,7 @@
>>>>>>     #include <xen/hvm.h>
>>>>>>     #include <xen/features.h>
>>>>>>     #include <xen/interface/features.h>
>>>>>> +#include <xen/events.h>
>>>>>>     #include "xen-ops.h"
>>>>>> @@ -14,6 +15,23 @@ void xen_hvm_post_suspend(int suspend_cancelled)
>>>>>>             xen_hvm_init_shared_info();
>>>>>>             xen_vcpu_restore();
>>>>>>         }
>>>>>> -    xen_setup_callback_vector();
>>>>>> +    if (xen_ack_upcall) {
>>>>>> +        unsigned int cpu;
>>>>>> +
>>>>>> +        for_each_online_cpu(cpu) {
>>>>>> +            xen_hvm_evtchn_upcall_vector_t op = {
>>>>>> +                    .vector = HYPERVISOR_CALLBACK_VECTOR,
>>>>>> +                    .vcpu = per_cpu(xen_vcpu_id, cpu),
>>>>>> +            };
>>>>>> +
>>>>>> +            BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector,
>>>>>> +                         &op));
>>>>>> +            /* Trick toolstack to think we are enlightened. */
>>>>>> +            if (!cpu)
>>>>>> +                BUG_ON(xen_set_callback_via(1));
>>>>> What are you trying to make the toolstack aware of? That we have *a*
>>>>> callback (either global or percpu)?
>>>> Yes, specifically for the check in libxl__domain_pvcontrol_available.
>>> And others.
>>>
>>> This is all a giant bodge, but basically a lot of tooling uses the
>>> non-zero-ness of the CALLBACK_VIA param to determine whether the VM has
>>> Xen-aware drivers loaded or not.
>>>
>>> The value 1 is a CALLBACK_VIA value which encodes GSI 1, and the only
>>> reason this doesn't explode everywhere is because the
>>> evtchn_upcall_vector registration takes priority over GSI delivery.
>>>
>>> This is decades of tech debt piled on top of tech debt.
>>
>> Feels like it (setting the callback parameter) is something that the
>> hypervisor should do --- no need to expose guests to this.
> Sensible or not, it is the ABI.
>
> Linux still needs to work (nicely) with older Xen's in the world, and we
> can't just retrofit a change in the hypervisor which says "btw, this ABI
> we've just changed now has a side effect of modifying a field that you
> also logically own".


The hypercall has been around for a while so I understand ABI concerns there but XEN_HVM_CPUID_UPCALL_VECTOR was introduced only a month ago. Why not tie presence of this bit to no longer having to explicitly set the callback field?


-boris

