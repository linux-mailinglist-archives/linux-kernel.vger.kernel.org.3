Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CA50ED87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiDZAXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiDZAX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:23:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3E2B19E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:20:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PLhMdi031660;
        Tue, 26 Apr 2022 00:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XrBNwAmR8WSnrL5QXWxNFDLUghQbSj/ElsIY1GXs610=;
 b=rtRFQbzu2903Q+m8q6IoTzIzcLyE3PeN1hA+IPPNdUgn0BAgJkvAl1nAjo9C+pLHFsmz
 KP+WeI68n0Vui0jGtGwCPmr1vI+xwL9afHVa/YhDV8c0+q8DnOu0Y+6CrKi6Hi6QDGh0
 cudF9Xw637+pPXDbm/ikmFi9fC7ncGYn6s09zp6qJ7Hy0aPJRt48ZS6R97Dt6c+JnnQW
 tT0mM8d4iH1tS4iFg2lEiqv+qz9jRTlKxaRN1z8xzb7Dmx9y/ZXuBXMEBs8KsIVWG69N
 ffsLOvp+oDhUsW9BDsEi7OCHO35tgtwb+d+UODHpPPQzgfbhYRpo6TRAbu58b64qc6lz yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jvrmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 00:20:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q0AOmm014589;
        Tue, 26 Apr 2022 00:20:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w27qea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 00:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc1zJ/UybqyuanZ3vIr1Org9+fF92nAQB8y6gwWenCgfHgJpLPVhRzCYQvYyylnHK3CFeBwmCpqq2iHX8MsyOYbduLSxxfoo9p6dLBP8P/vtQQTFdgr9fTI5h/JA5UcUGbFnilrAixmlVfBpY7a3qR+nfkDfyZHEwCCNiBHEh6rPoEnco/DIM2XOhlzoaOoWXWp0Qf2hcFCY4kJyp0gH4aeX4MSx43ReiamuRbn3Yh3wwmppiMH8btqYx/fuiCA9QLpC5OFzs1OwxM0ZaDLLUJXEwz9gIzBVQAvUy2AdBHa99csia2dEA7mgnU7PLdOK0RYDb/yIDX5HbjuXpo7+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrBNwAmR8WSnrL5QXWxNFDLUghQbSj/ElsIY1GXs610=;
 b=Zhs5sOuDVgfWgPLTn5zg1CBgYcB2oE5Knt3qlSeZDSILgRc8BwTCWVlyf9h6+Ro+cw//fg2VPcGCW7bCB6GHnSxa5oRIVIW5+LzPU6xOWC5Pd1tbBPFiHTdVHj7+YHN2p5P7e/dOXAtascwAFx+nc/qnnHR57RR6jX4WzY4CZe9HBbVCBU8z+qH05mmLqG4i+5vLpqRdemJsCp+Z5Dk3nY0CtKqtx9lLgdbESRhYuwNuNJUE5bZIoWDPBUrXZX9Dzs5FQWeDoGXro8Anxc1LYqgkXpIDptkYdGxubwheZB2NR29H9C659KECqUO8GtYoy2M0jUR2HcknDzy1KqtR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrBNwAmR8WSnrL5QXWxNFDLUghQbSj/ElsIY1GXs610=;
 b=y1vUkYg5YWnsBDaCeD61xdAfDCgTEfa/3LZviJDtbBT9C3ONsibXgJEgc267jvg4HXKrrE5CbfyLl8iZCM+dimjGlrmRzbZTMjwXq3U5JGlM4wzIh+tVxzB6pSbmOqzh9xXf/jUmbBhGHBXF/3b1PGMirJZ1BnBvS1TGdWya8jY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3094.namprd10.prod.outlook.com (2603:10b6:a03:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 00:20:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 00:20:10 +0000
Message-ID: <064da3bb-5b4b-7332-a722-c5a541128705@oracle.com>
Date:   Mon, 25 Apr 2022 17:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1650810915.git.baolin.wang@linux.alibaba.com>
 <f5e3b77c5a4c646e000ffadbf6c3db0531a01795.1650810915.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <f5e3b77c5a4c646e000ffadbf6c3db0531a01795.1650810915.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efc8d70-dc55-4bbe-38b3-08da271a868b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3094:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3094B6738B1F520FC38CA618E2FB9@BYAPR10MB3094.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYFwnUwjFEVcKq3M8SwCWRJtV2vZk+l799ZjtfzwPfK7lk4YK3ozW8/0PNNor9JjzIS6DncLEqNh54k2E8mDulu/9F0nF5ElZZo8BrGICGtD/mus+c0U++PDC717k46fRhtyEjsPj0RNJcp5ym+nBWy5/TiSLvJGEP445/VScmuVnGKHwlyGC3gzPFApUIuPSB3yVCJ9t9/QuQnfkVFtRouVmKLpnd+G4HYSJEdkXmjW1y+EeSvvKv+T3jRkhheCmE1arb5vKQuKL1Kw9gudat8ok36sHwfraBOWiMgiTAxX76xkBW18qCcKlUkYTygEC95xxRaRz/F0mQvHH0rtu4uQwZzmdlKYPZskFCytiAQmGDaJ0Eej7QnbY2yYyaxtTiMH2zJRMvmbCBFMmbh4Xq1ycZZD7nH3COQCFbAcW2vvWUkJb7SDyQCawPbSAUIeADqGN/pK9FAPie+IrLLQCC87BZHNBfUJHbxQUal3+j/adsOLbfTkYgPijhr91nqGPjJlUU0rPiaxE+K/H4itXZwOaFcxpn5LWzaRbyv23K4RprGY5wGyIrAEUmvNHVDgIk7cPYpmDAJlZo9m/jUNc0bsiRcHv8WNHRwOH/z6ivb/TaAtbkwQynRYdh5flE7cfoTexJBZUyGXKXL72/mNNUMTlU1WqejqoHIMSiPRTRzQHyXH/wBPvlWkXwCjB5dgnYYuMqFVfZ9brRYwLf/PRrLIL2fFoIYjlFy9NwaUknYf7GUPX8H0cpO02FsB3FeIZ8ZYFDihjVqpSERKoi54f8HHEHTP0gP/6oOcdwAiFC9zH4GziX7sYyJaifwjLknTS5SUzIb4tl+v5BX6b6XNoUTdbCD2V867MasWLRYCrB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(86362001)(316002)(53546011)(6506007)(52116002)(6512007)(26005)(38350700002)(508600001)(966005)(6486002)(186003)(44832011)(38100700002)(8936002)(2906002)(2616005)(4326008)(8676002)(36756003)(66946007)(66556008)(66476007)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRoaUsrMk00MzRGallvNjhoUy9ncHB0MGcrR0I2U094ekQxQkRNVEZnZHFJ?=
 =?utf-8?B?WmQydnBMK2Q5WnczQzlMZEM4WnlkK0ZUd2Z0NkYyWVJJaWhaeExkUkx1Y2Jt?=
 =?utf-8?B?WVJjWFd2T0RNR1VVaDBXMDNJaUYrUVV4Q0hOQVJ6SU9MODRreTAyK3JyOSs2?=
 =?utf-8?B?aWN4S2xlOEVqd0d3ZzEyRjZ6Q284cVBxaG9zbmpYdWZPcVZDeHBFQ3k4VnVp?=
 =?utf-8?B?Tk5XTTlVWUxzMk9JUFNuZGt0M1VQVlZyZld0aVZMa1JjZzFwQlg2OHMzYU5H?=
 =?utf-8?B?anloMEVBRGFTTklRL1VLTG9jc0xWRCtBWk02a2xpOUg3NTJLMDUvdlhFRWpt?=
 =?utf-8?B?NU9SMDl2b0lHQlE3Sm5VN0ZMU3ZubVBUT1pIbHlZOENTaWhRcDBkQnEzZEVu?=
 =?utf-8?B?RGZHOWl6SXd4UzBPWVh3dnpJcFR5SXhSMGExQnVyRVpqUTFSV2J0WUR3Rnkv?=
 =?utf-8?B?N1FCTmRRNzIrQ2ttWmhUWC9DR1N4bVJqYStvNU5lZ2dqQTd2eEJ3QVUxNHky?=
 =?utf-8?B?MVIweFcveTZUL3U1M0gwenJJSXJKZ1NJdGFYUEhVV3FWTUFvbTF1N0dTdElN?=
 =?utf-8?B?RWRXcjljR051ZGxGeE1Gb1FUdzZPeEkzNjAvUDVLUnFVK3pqSm02cXN5a1Mx?=
 =?utf-8?B?bWlZZnhJUUJFYnUzVjhQQ0RRclZRekpDZyt1RkVrdTgrNngxL0FrUm80S0dl?=
 =?utf-8?B?emQ3SjBVWlV2bFUyc1R1c3JrQmZiMVNnSWxwellyMDhlc0RhMUpmSzlNbkdW?=
 =?utf-8?B?QnMzcFZIR0RXcEMvQitiaWt1OWhWN0UyQytTSStudStGNkVNb3IyQjZiTUNN?=
 =?utf-8?B?dHBxTVJTYmRSZVNPcDBHUm1UWmRmUVB1SVd0YTFkdnRqdXNjdmtWcklUc3lk?=
 =?utf-8?B?QmRNT0pFQ2hPcTdVM25takt2Y3FsMHhteFl3WVlMMnMvV0ovekNxOVpKL1k0?=
 =?utf-8?B?M3BZSDl3WU5HMlZBS3RHWHIvMnAvMXJnZ2lmSnRGQmdOVW5nSzZvMzlNU1BZ?=
 =?utf-8?B?UWhidkVpdlkrM0FOSnBDdGdQZHdoZERsbVVZS1I0d2RyQnU3VWRVV0R0bGdY?=
 =?utf-8?B?SU90d1VMVml1bURVZWVtbEMrbnh5VGMyYnBIWXFENFNuTU9jVGNOUmo5dDBP?=
 =?utf-8?B?U0hSWGZiYkV4RjFkeHVMV2VSSmNnMVVQS2kxR1NiMWc5Nm9lVkRsWGF0WS9J?=
 =?utf-8?B?cVJIM3Ayelh0NkRCc1hiVFNFM0pETmRSRzQ5a2UvOTVFMmRFQ2Z4SFhMaVZp?=
 =?utf-8?B?S0RIcnNyd0dYRW9qUGVxNGJicXJrQXJzVkI4Skh0NEdWamwrY2c5VnZrYnNv?=
 =?utf-8?B?YXNsaGxwSzR5cDhLcnljL1ZjVGVGYUo3eEVmd3JFenk3dEpIdEhpVUs1UytK?=
 =?utf-8?B?WmF2UTRkRlNidjNpQ3pEaEl2QmtGMWZxejBUazI5Y3d0Nm9aV0ZCYkVQa0Ja?=
 =?utf-8?B?a3NxZThQNHNDM01PSUUwbW1mWEpGMWZxYVVvWHZDMWhlK0l6QTcwNW9JWUtN?=
 =?utf-8?B?bzhGNXNhYU9ndFJwN05reXR4elV3KytYanl6T2xIa1NiaXc4YVloMVA0cUJt?=
 =?utf-8?B?N2UwV1hBbllrZTArZkcwQ2NpNWd2Nyt1TzJOWTVIQ1dmUXpHOCszbHAvd1Na?=
 =?utf-8?B?cnFWK29lSDFVRXhjL1g2NGR6cmtjbDMzN3NRQ20rZHNTVUthVmd0YWNpQVRj?=
 =?utf-8?B?K0c3K0VLSkcvbnMyL2s4enFkVjMrK1R6bEJkWDRMVmFvclZvT25SUU1aS0dx?=
 =?utf-8?B?bjJKbW9ySmlLWEMrRTB6Q2dJdHRYVERLbkhnMHp1YVpIblVoL1hhUnI1ZGVy?=
 =?utf-8?B?QVd3blRZeDgxeEUzdzdWNHRlMkY4UjhXbHRHd0IrV3o5cWxtWDlCOUtvZnE4?=
 =?utf-8?B?QXhhSC9tL2NaTU9Ga0ZhaUVoSi8zQVR3QzV0bFFuamExYm9jUC9DajcreWxE?=
 =?utf-8?B?OUl6dk9zT0xrQitKNE52V0g0U3gzV0VnZTRJU1pBeE9xb2ViM0piTHJFRjR6?=
 =?utf-8?B?RXJkTGJRNCtoZmloaTdLelRtV2pqODJPM3NpZXR4OUxjVXBrbFQrSkZ4S0Fy?=
 =?utf-8?B?cVBKWGNCM0Y1V0c0ZmM0S0NCb2hQQWNWVW0wc2FIV2pvY3A0Q2d6TnVMcytR?=
 =?utf-8?B?TjU1UDMzRmRTZE5WYzdvRU94KzFEc0VtVXFIK2Rwd0g2QTVpU2dabjBoWFli?=
 =?utf-8?B?WTlCWFJsRWdhWEM0KzdCWm1CcDAzWk5aVElzMDF1WHpFWmd6OEd5Nnk1WDM3?=
 =?utf-8?B?Mk43KzN1NmxzeldZODRZVDlHWUplNDgxTXV1ZmJUQmNqSGNuRG03SUpKL0JU?=
 =?utf-8?B?Z29KWS81ZnkySm1McWthYk9PVGZ1NEh5a0lvdXFjbEtSaTVpT09Xai95Y2sw?=
 =?utf-8?Q?wlFQdM5TF3I095lE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc8d70-dc55-4bbe-38b3-08da271a868b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 00:20:10.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOufM96s1Bs2LQj6HLO+26g1R+CAJ3JRj8ugmAwJuABCmkTKDH4nFjLhrksbjgIGEfLRbdepGKjYLur5m169TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=877
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260000
X-Proofpoint-GUID: CbCCmyQTx6INAmpC9oOMSbxdoW0hDctI
X-Proofpoint-ORIG-GUID: CbCCmyQTx6INAmpC9oOMSbxdoW0hDctI
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 07:50, Baolin Wang wrote:
> The cache level flush will always be first when changing an existing
> virtual–>physical mapping to a new value, since this allows us to
> properly handle systems whose caches are strict and require a
> virtual–>physical translation to exist for a virtual address. So we
> should move the cache flushing before huge_pmd_unshare().
> 
> As Muchun pointed out[1], now the architectures whose supporting hugetlb
> PMD sharing have no cache flush issues in practice. But I think we
> should still follow the cache/TLB flushing rules when changing a valid
> virtual address mapping in case of potential issues in future.
> 
> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/rmap.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 61e63db..81872bb 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * do this outside rmap routines.
>  			 */
>  			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +			/*
> +			 * huge_pmd_unshare unmapped an entire PMD page.

Perhaps update this comment to say that huge_pmd_unshare 'may' unmap
an entire PMD page?

> +			 * There is no way of knowing exactly which PMDs may
> +			 * be cached for this mm, so we must flush them all.
> +			 * start/end were already adjusted above to cover this
> +			 * range.
> +			 */
> +			flush_cache_range(vma, range.start, range.end);
> +
>  			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> -				/*
> -				 * huge_pmd_unshare unmapped an entire PMD
> -				 * page.  There is no way of knowing exactly
> -				 * which PMDs may be cached for this mm, so
> -				 * we must flush them all.  start/end were
> -				 * already adjusted above to cover this range.
> -				 */
> -				flush_cache_range(vma, range.start, range.end);
>  				flush_tlb_range(vma, range.start, range.end);
>  				mmu_notifier_invalidate_range(mm, range.start,
>  							      range.end);
> @@ -1560,13 +1561,14 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
>  			}
> +		} else {
> +			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));

I know this call to flush_cache_page() existed before your change.  But, when
looking at this now I wonder how hugetlb pages are handled?  Are there any
versions of flush_cache_page() that take page size into account?

-- 
Mike Kravetz

>  		}
>  
>  		/*
>  		 * Nuke the page table entry. When having to clear
>  		 * PageAnonExclusive(), we always have to flush.
>  		 */
> -		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  		if (should_defer_flush(mm, flags) && !anon_exclusive) {
>  			/*
>  			 * We clear the PTE but do not flush so potentially
> @@ -1890,15 +1892,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * do this outside rmap routines.
>  			 */
>  			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +			/*
> +			 * huge_pmd_unshare unmapped an entire PMD page.
> +			 * There is no way of knowing exactly which PMDs may
> +			 * be cached for this mm, so we must flush them all.
> +			 * start/end were already adjusted above to cover this
> +			 * range.
> +			 */
> +			flush_cache_range(vma, range.start, range.end);
> +
>  			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> -				/*
> -				 * huge_pmd_unshare unmapped an entire PMD
> -				 * page.  There is no way of knowing exactly
> -				 * which PMDs may be cached for this mm, so
> -				 * we must flush them all.  start/end were
> -				 * already adjusted above to cover this range.
> -				 */
> -				flush_cache_range(vma, range.start, range.end);
>  				flush_tlb_range(vma, range.start, range.end);
>  				mmu_notifier_invalidate_range(mm, range.start,
>  							      range.end);
> @@ -1915,10 +1918,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
>  			}
> +		} else {
> +			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  		}
>  
>  		/* Nuke the page table entry. */
> -		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  		pteval = ptep_clear_flush(vma, address, pvmw.pte);
>  
>  		/* Set the dirty flag on the folio now the pte is gone. */

