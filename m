Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5374E4EF9EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiDASf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351193AbiDASfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:35:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08551B7555
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:33:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FkuFk018350;
        Fri, 1 Apr 2022 18:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Iom8fg7EDpPn/8hRhUNHxwcoNJkrFB/Bykbamj1Os4g=;
 b=oT2rjWfNlBIH7u34Th7NDNQkctR0zeRGQAqp1KYt1NqIUjm8sc9QY5WP4wYebIvJnIF/
 oE8j9MzKADq+QgW+d6J3B1lWVNu48Iw9LXPA8IXxBKgFPnHbMiyfo2yzcdr+y7Tg1Ecv
 mnnO8FFPXz7bilceWA/apt/BAB+Ur04ZOzvk0ZsnUAV+Pz32N7eN/YWWxnYj2ZO/PEnw
 PSxV4wwO8Hql29LsHbUG54+RWeiJC0fXG2dzlG1B32Z6T9BWOwYGgOyY2IcCg9mbXo2t
 7HiE2gRq+HslulwYMO9qnQpRTyf/V3ROG/O0r1Usl/XtK1z6cDpuXCm9FWQlyuFnPP+Z Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:33:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IVQ8N012546;
        Fri, 1 Apr 2022 18:33:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s96t2bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhi9ET40ASA/DF1uul3fpoP5QDj0ZLf1fTqNotQ1BC6Jb1TgQ25fdr6eZhhZYuP86PMYsmtvIbCrxfxMuCt/UzOQ9mvPlU1RwhSMHVgURIso7CHRmH8zGaqV29vHHag36pL8RhJcyNU1ef1EE4pwmZ3Cu+wzWOehhQAbfFNldCwm6/TcA4dw5UMo/u2jCE8HJvrmbbvUw/kcAkkl9KiP/FSocI7hoSjlJ+IyUSxUMhS4FipoinYxBMeuktvRd00aSOInkIDuedkCR9ir/YoS/8hfZtZnSaWJT6uoIBPmC6X/ThQOcW3LQ0qwoHBfH7hcwym/we/H3/26p0rlXJ3dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iom8fg7EDpPn/8hRhUNHxwcoNJkrFB/Bykbamj1Os4g=;
 b=XIEoDGzR7Xzj6lM/kRTsCzcE5R1XH/ymq9Js+PFg/5DaCsLjTWXLLPkGBsB4U7e/gEH6VDHw4bI3lJFmYrAPSda7Wbv6St8+ecUJW4O0iiLC0ihN93aJApb6/1etMMfuFs7INzVou78xZy6p1ErOnUBkkkD9wLZNgQkPtJ5DWBKP4jYFSBT7oVQSLO04bmsIYYvKHMI369P+Iq8IuEyjPvTuffjfvOy73uxb5xju/XKibUHLpwF/voVmano4bk+09ZULnv7sHQIdVTqU6/J5MUy01Ev1KI4h6vL0HHGVCMbuH+Tf++69OJnxz40V8z19LQ0oZHlWNbFtq6ziPrSfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iom8fg7EDpPn/8hRhUNHxwcoNJkrFB/Bykbamj1Os4g=;
 b=nG5+3s9lE813eDr/h7iXlnJ+bR1QUkLgxl4Sab2w0bnmEhttsPe/2SGXD9ofPP3eAiGC/yX8CFVIRIvHBPPyQ5obDBNlIIQ6ZEJ5/rYzpKeYM1Qyf8He5g8Kck3Jek7CDmV13gJdc3K8O3JGuggAlswLcGsdyRLQ7+PRm1iBqBw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:33:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:33:08 +0000
Message-ID: <0eed9aa8-1229-daca-330c-9d71f2b0688d@oracle.com>
Date:   Fri, 1 Apr 2022 13:33:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
 <20220324143300.GD354864@MiWiFi-R3L-srv>
 <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
 <6f59af6a-8a70-85ce-b36c-38eb31503c7d@oracle.com>
 <YkJciuCXKuU4a4gp@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YkJciuCXKuU4a4gp@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a8c167b-c110-4bee-1b55-08da140e11b9
X-MS-TrafficTypeDiagnostic: BN8PR10MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB326887AF80F2C25E8E0BB05F97E09@BN8PR10MB3268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQCT5uKl2auwqVKFjE4taogBsDYM7PUdOZ05xXAN9Z6ERFXTR960aeOgFLp4s9hcbPIwhyOcp0dYQBGzKCLGDe+HupykqlRoklTUZ5FFmhAfkBisjVb57PfKVrktz4ZVw6GUxhpmJ0vxiCiPot89sZlVJSUM15+FiKM/xiG9RR9PB6yneO9i0FNCak3L3K1/IqXR74ndN+ZNO8hBFEZIXfqQDb/NgIg+xpen8NluK/kKrCMTEHzal9Jx85oLP0PVD5C0gBs8lAnfTeJWKIwDaQdI0hH+c7AO4tKYiEI7mH5FR+K/NoFsC0fUFrwoMs/+W8kInrop7iHLY/ZJJwcx37Fzw6wP7BbmpW72QIj9tG4ehWJ2Gxq7U8Yh/8DEapXAv0M3AgLI/kdCrZ40arl8joQMPzgTKS/hPr/qfXh/rUrJbl1RZzvGQzqxRarnkXsG/yVT9gNItlQtw5DlyZEb8MCTTf2T+2A+c72K09XabC59j516uGIBajh9tx0Uk9i9Yg84QVgmOvklP5tMTp7zNSQLgrFWKubvjqA/7UWcL2axUVCl0/aOqY5Mt8aqCUnbEzAyIsV/XIV+5n8eII0dANIqYE1WwTaNgD8RHQsN/D0mIo5S0GJikH1LNAdn9zRU3QerhuQHUX79nL5B09cLPf9myWJ6qzeclfi0XbeAduzPhYfOt8k5zDe3sOsqJSFR+BgWOnTzJiIOr1JebuUHmcaMXl1gLoGTzr0XcsBXx+m0y9S1HToWQkrur8D8fq9Q3+vd2MxrukgfcZYRleV37w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(66556008)(83380400001)(107886003)(31696002)(316002)(8676002)(6916009)(66946007)(4326008)(66476007)(36756003)(31686004)(6512007)(6486002)(508600001)(7416002)(38100700002)(6506007)(53546011)(2616005)(2906002)(5660300002)(6666004)(8936002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBucXgvb0xpNmhIMXI1Tjlvc2dEdGMxK241dHIrVFJ4OU1BUVljVVp2aVJo?=
 =?utf-8?B?c2xqRHRudXNoVzRCaU8yTTFqZ091RWtBK0w2NWVLYU93NnN3dXM1N1RCUTJw?=
 =?utf-8?B?R0hYd3V3eDRGeWR4ME9wRWtmNEx5YkxSZ0JRV20zR20vV1B0aVY3TFJhZm5q?=
 =?utf-8?B?V0doaEF6Rk5yUGpXNVpIMUdSdTQ0WFhQUW9PQXcwZVJEcmtnaDJmbGRFS2Rq?=
 =?utf-8?B?K2NyTjZMNEV4cUZ0dHFQV1VJa1NPOFpZempGNWsyVUozTlA2SzVxRTFYT2FS?=
 =?utf-8?B?a0FBT0NJVDJpY2l0bEhvQ2NQZkQwY2tHVXQ0dUxFRi9wSGpzYTJWTTBNenVE?=
 =?utf-8?B?cTlNWG5xTFBSdUIvY1o4b2J2cFJOWkpBN0JHMk9aUW12VUVGSFhzWnkzanZ4?=
 =?utf-8?B?VWQvQmxxaHJYalBhOHVBNUxlS2E2THFnTDdOM0JZRzJSWHM4ZHk0bDlkdVJk?=
 =?utf-8?B?eHhzWS9maGFmc1BrdXMyVm9leHU5Ykk1OXFYcmR6bUJEZ1k3b0IyTytnQVdS?=
 =?utf-8?B?RDhPRzd4ZEhJQ1RTOHlSb3pGNHc5WFpaN1JhQzVJdkVZRnRhRzE2a3JPTGhw?=
 =?utf-8?B?WUNub3NOUGVTNTBtcGZFTzFZNTkzYWdFTDZDUGRYMDF6cEp0bm1QbXJiTXRw?=
 =?utf-8?B?cW5wRXQrU0NRMzBidzdIUUh1ck9QOVFSOTVnSFhtYkkzQTRMb0NSMUw1ek5U?=
 =?utf-8?B?UjZXcWloNHJJVXJLc1kwNmlmU2ErN1g5VWZ0U2wrSWlXQ1J5bEEyN2xhMy9P?=
 =?utf-8?B?ZzZ0b0w5eExoekxDMUJINlJGZU1iSERrUWRjTnVDRHVVQndTL25uK0o1dHMr?=
 =?utf-8?B?Zmh4UHBHRkhIU0NzVytOWTRnWWdFbjhQY1JRNDRUVk1HWmt4dEdBY1FJL1FK?=
 =?utf-8?B?MDJId3JDY0s5c1JrZDJUUVZRTWRhNUdsVUdrYTVwd3VrWkxxRGJobmg2R01u?=
 =?utf-8?B?eVFoUGVqenkzTHRBL0dkU0VJRnEweFdZQlZpd1phc3NCbitJaFNZcm5jeFcv?=
 =?utf-8?B?VWpkR2hEWGVEclJFajl1a1c1M1ZNa3dhdFREK3hWMVBrSWZTQytpNE9JaHVK?=
 =?utf-8?B?R2tMVXZuYXJPVEhIVm4vNDMyWHNZZUtqTEJ1QSt5eXVQRjRJVlY3OGVjMHVE?=
 =?utf-8?B?UW9KeHVYaHZ4L0dFQlVjcm45d1VRNjIzZVNxUjRTMFA3N1I4MTRNMHB6K2NX?=
 =?utf-8?B?NUQzVmU2Q1JXR0FDd2hPMGxIYjhaRnBheWljd1NoZ1cwaHV0S3RraXNjVEtN?=
 =?utf-8?B?dUlwRWlJR3l6bVpwVFAyc2dvdVUrajN6eGREQ0ZXb0ZDRmpmS0dmSnpJMkVP?=
 =?utf-8?B?YThnSGZTdlRCZnNYUHY1WWFFbU4xVnFGV3VuVSt2cnZIb0VIN0Nqc0pFUWNI?=
 =?utf-8?B?K25aeENHN0RLRzNxSVM4Y25COUpsaWhRQ3hEUVdXbitkcjUyQXFEc05aek5q?=
 =?utf-8?B?M2xraFhRbzVyNUxuOXF3UjQ1K1VmeUsxV1cxUEFpVW5KN2FXbUhBb1B3R2xU?=
 =?utf-8?B?enRLd1RibytuMWlzNnVNN2xncldBV0FWZ1ZlbnJ5bjlNZFY4am9QamZYQ0lL?=
 =?utf-8?B?enVnRldUeHJXUzIyaW4xZkc2amFldHEyNkZOSElxUkJrZmdjb2MrSWxVcURo?=
 =?utf-8?B?bHJjbG9icVV1bkJqQk5YZEsybzgwYlVEaTVFWGJvUXIzSmlnM0Q3VDl5d0tT?=
 =?utf-8?B?WjBDUVE5WWhRVHNQZGZ3eVZlMHZRTVBnNUw1ZFVzZEovZ1ZkNVdqbnJqdzZR?=
 =?utf-8?B?Vzd3YmhxYnR5T0J0dTY5YmljdEtoR1ZkalhLaGJCQ3lobDI2ak1Ra3Irb3Fh?=
 =?utf-8?B?ZnpabWwxOVcxUzJiNzAzbll2ZG5YWHh4eEhHczVJTS90eElzRkZNM3lmN3Uy?=
 =?utf-8?B?Y3k1NTRhZ1QyblRMVDFqWmEydzgzOXYrYTZKcU1IZXVTWFA4V3gvVXJpL1Bu?=
 =?utf-8?B?bGtyN1BHVFdWOUlVeXd1bEVWd0VrZFJIbU13amt0R0dEUEJQdlJQbjFaUTdi?=
 =?utf-8?B?UXFKQ3pvQkNockIrU3FVUU1wdnQyZ1BVa25pNWJHRzJPdmxsTW8vN3lzOHNK?=
 =?utf-8?B?SjF6dWZ0WlpDd2lIQk8vN2U3V2U5bUlIbWh4ZU5YNHkvL3ByUHdUeTFNcVF0?=
 =?utf-8?B?NmFqWFJ3bnhEaVFmOW5Ea0hCS0UyVnVLZTlQUGFOeVhQb3RBeEtpSUI1c2Nw?=
 =?utf-8?B?NDY5djdZTXVSbFE5N05DdCtHM2NkdVVsZ2hSdDdKNG1jRGNWakY3R05ReS9F?=
 =?utf-8?B?aXNTSGVSdmI2L2dSZGNnK1lFUkQ2RGVGNDdFajUxZXhHTDhVSGQ5QUs4dEJQ?=
 =?utf-8?B?SCs1anhFT2JmR3JBZ3NwNUcvTG5nT21BWEQxRkxjWjdkNWZOOE43UjEyRnJ2?=
 =?utf-8?Q?r09olAF9YhhMeYC7eVcDXY0Obsqv6eSAfkfib?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c167b-c110-4bee-1b55-08da140e11b9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:33:08.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltWo3aadIGgYRoaMyPdoz+QLqH+6/E5D8hIQhZQD+Tbw752MUS5SlEhKO34f2UpeD1v/9VRSNIKa5BHpSAUlJf8whKbzOFZK9wZt7bmYQKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=914
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010088
X-Proofpoint-ORIG-GUID: bVeESMbZGi7UYCaEcw5kOBrOiR4ogNJo
X-Proofpoint-GUID: bVeESMbZGi7UYCaEcw5kOBrOiR4ogNJo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/22 20:10, Baoquan He wrote:
> On 03/28/22 at 11:08am, Eric DeVolder wrote:
>> Baoquan, a comment below.
>> eric
>>
>> On 3/24/22 09:37, Eric DeVolder wrote:
>>>
>>>
>>> On 3/24/22 09:33, Baoquan He wrote:
>>>> On 03/24/22 at 08:53am, Eric DeVolder wrote:
>>>>> Baoquan,
>>>>> Thanks, I've offered a minor correction below.
>>>>> eric
>>>>>
>>>>> On 3/24/22 08:49, Baoquan He wrote:
>>>>>> On 03/24/22 at 09:38pm, Baoquan He wrote:
>>>>>>> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>>>>>>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>>>>>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>>>>>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>>>>>>> important house keeping and then dispatches the hot plug/unplug event
>>>>>>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>>>>>>> that handler returns, the lock is released.
>>>>>>>>
>>>>>>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>>>>>>> function that installs handlers for hot plug/unplug events. If CPU
>>>>>>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>>>>>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>>>>>>> register_memory_notifier() is invoked to install a handler for memory
>>>>>>>> changes. These handlers in turn invoke the common generic handler
>>>>>>>> crash_hotplug_handler().
>>>>>>>>
>>>>>>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>>>>>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>>>>>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>>>>>>> of the new CPU list, thus the need to explicitly check and exclude the
>>>>>>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>>>>>>
>>>>>>>> On the memory side, each un/plugged memory block passes through the
>>>>>>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>>>>>>> memory events, one for each 128MiB memblock.
>>>>>>>
>>>>>>> I rewrite the log as below with my understanding. Hope it's simpler to
>>>>>>> help people get what's going on here. Please consider to take if it's
>>>>>>> OK to you or adjust based on this. The code looks good to me.
>>>>>>>
>>>>>> Made some tuning:
>>>>>>
>>>>>> crash: add generic infrastructure for crash hotplug support
>>>>>>
>>>>>> Upon CPU and memory changes, a generic crash_hotplug_handler() is added
>>>>>> to dispatch the hot plug/unplug event to the architecture specific
>>>>>> arch_crash_hotplug_handler(). During the process, kexec_mutex need be
>>>>>> held.
>>>>>>
>>>>>> To support cpu hotplug, one callback pair are registered to capture
>>>>>> KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
>>>>>> cpuhp_setup_state_nocalls().
>>>>> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
>>>>> names I've introduced with this patch?
>>>>
>>>> Right.

Updated commit message.

>>>>
>>>> While checking it, I notice hp_action which you don't use actually.
>>>> Can you reconsider that part of design, the hp_action, the a, b
>>>> parameter passed to handler?
>>>
>>> Sure I can remove. I initially put in there as this was generic
>>> infrastructure and not sure if it would benefit others.
>>> eric
>>>
>>
>> Actually, I will keep the hp_action as the work by Sourabh Jain for PPC uses
>> the hp_action. I'll drop the a and b.
> 
> Sounds great.

Turns out hp_action and a are utilized, so I just left it alone. If you'd rather I remove b, I can 
do so.

> 
>>
>> Also, shall I post v6, or are you still looking at patches 7 and 8?
> 
> Will check today, thanks for the effort.
> 
