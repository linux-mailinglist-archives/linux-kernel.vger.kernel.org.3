Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7144EF9EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiDASgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiDASgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:36:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85C813E27
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:35:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231G1jwW018556;
        Fri, 1 Apr 2022 18:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Yfo+zc9YFE+d/IC4mEd2+jxv182BlU6SQVi9uD5hPmg=;
 b=FvxCZoO89IoX0criGWuP4v/tGpS0J18VN/WkW9x3NTkEOlES8Ctsb72jlAneuhSK7wzG
 gmnyBIsq/vlTrKM/Vp7U6Kqlc5R9nOB/D1NVfKKCvuykQ+7qew2mlDOPrmEYcGhlaeO4
 KjrK7nMc88pD3uUw9KG8No2bnesXCmv78CkHvP3G6rXMiObQ2fi3bzNFfpX6SCE49L++
 IHzV1Me1rHoWkfeeK3zbr0ayW05yIcXB35NV9aOm+MJ1Cg769b3X+JLk8LIoySqQ9lO8
 CrfICXu1XLCBI78/f3NNzAxOaFAR0vQVQ6wtAtChZrFBqQFABsThXKIaNhA4K9xrBQT2 vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0qsaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:34:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IWANV011131;
        Fri, 1 Apr 2022 18:34:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg9gwy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI3DHU7RpJQketcSpJpQvvDp5V2ry+Obiu2/NzZGoxFG2j18dw8D57uom/8s+Z0LJfXeC1/wkNIHIBApUgje2mr2Q+aJvHfJokHKPX/xMzp9gyZPQ9B3MO2sM5cGpICUrZ/tt9R2Udjs5bbsAxLqBFzxF/jl6G/Vzpv8W1ZH2NP75wNw08qbdeW1+xnmRbFNUZxKQfjnB+G26q+SevkGqCePwDq/2bf+5Az8JetRPpIucTitGP0aQxzKlNP3KyMGQhPbSce5BY/aI/w0yMPxsWq44KD8GVI/kmUhVMAS8j/UQwoD8MXVQTdyysU+PqibZw8yoWYWEtQNQi4NUc3WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfo+zc9YFE+d/IC4mEd2+jxv182BlU6SQVi9uD5hPmg=;
 b=Rjq+lYX9+0hmo/OyFM/z8P9ZyCwMiK8WOufLSUkoRt0c6EpOYrbfbBmRNHqdKYqv67Nb+NTfKYtgwG8LviMhdwa/0igNdto8R3jjlcujFfSpyRR2KzScdSQGfTl7hg3UvdR9eyJErYJnMXCOJCSpCtXyITekeBDSpM+Ju7RNmERB+21PZRSZXWR7ugQ1pOdycdjIIhHiwm6gi9Sllw7kRgrd3w863UrrrswsL039H++JpFcvGs1+5ZRqbiwNQ/L/vADMhFGwiDpuMgYGp26N3mejyN2EqVoeUVxq0HzWY7ybDArbxDQaKe30XbFMfBsmX0dMibZZgy6p50cP0poqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfo+zc9YFE+d/IC4mEd2+jxv182BlU6SQVi9uD5hPmg=;
 b=YUMfuWTMrKgfiegCJKIRa/5NGOb0mkd3/s4VQKzE0AOaRquToRFI+chcjiMfiSqXBXhTChv0aBZvE8Ok56+pXEoHTD0J7q+P72xpPwgSBrs5cZmfORCpXPPjTAqLbkM6uO2C5CgaK/ARY/vmVom9qZKs2uNtMiQTWP8dlpJ+ffM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN6PR10MB2782.namprd10.prod.outlook.com (2603:10b6:805:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:34:37 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:34:37 +0000
Message-ID: <b9ce1ee1-4ff1-c9bd-2a3f-190e41e2d65e@oracle.com>
Date:   Fri, 1 Apr 2022 13:34:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
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
 <20220303162725.49640-8-eric.devolder@oracle.com>
 <YkWDnzQoR0CI2zc8@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YkWDnzQoR0CI2zc8@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2605197c-7de6-48e0-9c65-08da140e46b0
X-MS-TrafficTypeDiagnostic: SN6PR10MB2782:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB278204AC2F1EF0CAB0B7390597E09@SN6PR10MB2782.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eAWIJ04tC8bedYKze6WuVu/z5Fwb4maDwtoX9ga5v2SRvr/7sd3bBmcJEUWOVga40573Y0C5oNghxcHPfrHRGJKMW0TZaxjzdCzqnySuQBDN7I84QgrVYNc18BRoiZ/rYGE2hSCds2qnjjc6d1YaylrGYSKHlPmq3vQJaSr6fLAGnIz/cAHr8olJqto8v51/z/aVNbndZZ8DIDR5UXc1ONVPHyzxJMHcCn1j91F8OmSnTKf3CZy2ZxqW9NaZK3pOtApPEAFkfCFYRZ17gRcfSM0NaGzzHFuXEJdPWbcTMDSLeaHCacaHCH/aj/4jJ+Vzpj9eSRma7vHo3HEMkoYrTcf3Fg4VnUfRvfS/YImDhjT0lyFUQKxwL7a43Byh9ts2quVA/sAqx4zlL84yJhmZ0dwLYjQ5dAj9agRWLxp8IMFSdbDg93imemiFNRiFWuFheY+WfNqVdM3DH3ovMK9uLvk9KRNjcur7+WbJWuhYD1GDS0RDv2KnpR8zdWfFkVBSuOkRFPVH9y44qsCGm3bw9t1BXIBxxACRngLLRGWOz71YzupaJoVALyTDV04sK6a2BWxxsHIWLuZKK/NslHbnuObk4UOpLdVuNBDrTjZCDGmsUFshhQxWBUSsN2v8OmLDDXJ6OSabgaZbg6cFfyH5JsM/+v2J2tnYYVM1AguPdEBulmBCSiPnTsrWe41Xmbs3CpOHerlJituszHJX+ApttnCmNyGOzuroGawVaPRIg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(6666004)(31686004)(6506007)(4326008)(2906002)(53546011)(6512007)(36756003)(7416002)(107886003)(8936002)(83380400001)(38100700002)(508600001)(66556008)(66476007)(66946007)(6916009)(316002)(8676002)(5660300002)(31696002)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3l6ZVhVZmJ0eTlmcEJmMktpakJrSW5RTitMOGMybGxkVEVtL1V2WWV0SlBu?=
 =?utf-8?B?OXMwL0JXN01NQU1OZkRtaWJYcCs4YUNiZ0R2VWZZR0o5YTNqZzlSZGYyVUlG?=
 =?utf-8?B?cCtWbDgwRUNxZWc1WVprNUxpaEJxaDlNTHd0L21GZ014V3ZIZTdoNlU0dTNu?=
 =?utf-8?B?cEZRTW5wMjhqek8rVFJZL0RkWVhJYnFYTTcyOGo5TEd5RFpVRzZ4K0hXeEhs?=
 =?utf-8?B?TmNUUnNUeXQrZlBwMTB2M3JXb0xrbmd5eEJUMERiTUtOWS85ZHZVS2tGMDBC?=
 =?utf-8?B?TExpQTdENUtYemFNbWpGZElhU0RrTndNcFZsSXM4SnVRWFFjRXpmWFZSZGFq?=
 =?utf-8?B?dVdSZkF1NFBMS0dBM2JvMTRIUDdqQnVteTlidUhnY3hnOHdGZ05kd3ZLRWxE?=
 =?utf-8?B?bmF5cGQ2STZDSnZESlJqbHh2bUl5RGF4WURUWHU5N3Vma3VURlNxNXk5VmFP?=
 =?utf-8?B?L2U4SnVtT01tVjZ4cXorK2k5Y0NoQ2ozelBXSHkzZUwxMGlSSC9SL1lhbjBU?=
 =?utf-8?B?aHdQMUZtREppUVpzRkhocUtxSGp5SExnSTZTd1EvVG9ldGNSL2ZwM3ppQndn?=
 =?utf-8?B?MDhxTGN2bVN0MkJaUUJIQzBpd3VudGdleVpReGVRLzFzei9SZkM3S0FIV0ln?=
 =?utf-8?B?VWtoaFVBY0JOWVYxbEFSWWw3SUV0Mm90dUE2NDFzOUJRS3h3NVNjUDRoM3BI?=
 =?utf-8?B?ZmpRWnRZVi93KzdqdHd3L0dubThEV085WTBQdHo2UkY4ZkxvTTEzR096QW1I?=
 =?utf-8?B?ZVdwa0dvVXBhSEhyQzVSRElZRjMwRWdyNVVsS3ZXUnF1WUpnMEVOZnZZMTBm?=
 =?utf-8?B?cDQ5ZFlGY2ovNzIranNhcHlNWldsQXpMR1lwTVpxbXhLNkprWWJMYTRNT00v?=
 =?utf-8?B?KzBoZnczTkNYdUpYZnhmY3VFRjB4YlRPUWtYaWlaMERESi9CejMxSUFsZ0dj?=
 =?utf-8?B?dzhJTFRZMU82ZXVpSTRsRWZIaTR4L3JLWVlwZTFjNGZtUEVhRGpoQllDZ1ZO?=
 =?utf-8?B?MXQ3ZkZ1OTNodXNvYXZsZmNpTW92WlJIaE5qVGNpSDdCTlBoZzRqdWV4eGY0?=
 =?utf-8?B?dUEwT3V3UURHSGlsZXBpekZOaDN2bG56dWROVXBsaFZtWmRHNVFObkRqdzY5?=
 =?utf-8?B?elRrUVJQenJTQ281TlJkSmMxNEhZOE42Q1JlK1pVTmNvRTZwSWg5WUJ3clZE?=
 =?utf-8?B?c0g2QmNpT2I2ZU85TVNhMjVhZWQvZjZNRFl6Q1oyTTk3RzNBVmxPUnp1MEpO?=
 =?utf-8?B?amtheHB4bllWZ1NIRkszSHJYUHpZK3JrZGppSUtPNC9VUXRET0ljSVpZZUdl?=
 =?utf-8?B?UEF5N0RTaUlrUGJLVUJOVEVUeDR1aU83RlF5bTZFWW1rK2pXQnVMQklBNEZn?=
 =?utf-8?B?U05LMmVUSXNnUEV6Ly9BSXhkY0R1S3c5dmMrS0NaNFhPSzdMSFdWdjd4cEQv?=
 =?utf-8?B?angxcHpVREZERzlkdTZ0ZTZGUmFUOGFMYTNvYkdMSmFNM2x6cmpTV2FEcEhI?=
 =?utf-8?B?NVN5MkIyTVpuU3NOb2NxRWhxSkkzSVcrSFJDVG02TkhJeGVhQjk1eUdzWktj?=
 =?utf-8?B?QllJc005VFNXV1VtTU84cFVCZGxNdEtpQ2ZlY1RDTVN2SyttOGFMV3lDTlpq?=
 =?utf-8?B?NXVndkErTVhndy92bTlMc3NIMmRDNk5TaW5CTHo1UmM1M1JJM2E4ODdkblVF?=
 =?utf-8?B?emNHT3AxcTRkdTh6VFB4MENsU3BUQ0xYalJrSlhUdFlnb2J4ZzhENTZ2c0NM?=
 =?utf-8?B?ajhkVkh6QTlhY2JwYkdEMG9Od2g3THcyT2g5aXIzMWpvN21GTkVWVEhDV2lT?=
 =?utf-8?B?ay9qZkdENC9HV3ovS09iTzdFRTJ4V0dIR3ZOY0pOcHFVMS9VUjdpdmNrK3ZV?=
 =?utf-8?B?YVhJcjhObHNRQzR6b3lxQjAweHlmYUtZTHRlNXNJbzM2R3diRFUxMDhZanBi?=
 =?utf-8?B?eG1iejJiOEd0RXV3b2kwQzVtTU4zU1VVRTFjNkI1UHpvUUpkdG5FYktKMVZM?=
 =?utf-8?B?STI4L3lUN2RXVkFFZ2NtemVyd2h0b0VDSktNQnl6U2t6dXFyVVlCTVh3SlBs?=
 =?utf-8?B?N2FBRkxCWTF1M0VDV2d3THhZUkVHUEUvZW4rRm1MdEw0ZVRJakxqR2JjelU4?=
 =?utf-8?B?eFJrZ2JtTC9MbnlPRFAyM01OaFJqcENrdWNnb0VFajRuTW9vcFp0YWhlaTRO?=
 =?utf-8?B?TTJNNFNGVG1qaHlObzRBOHVDeG9DWDQydVhha3dzWEVmZXZlc0h6a0hYb2RI?=
 =?utf-8?B?bEZtTm9PN2JUeU9mM2xoak15Uk9YU1phNXRRRzlwbVFuZ2NNVWJIbzRjYWJw?=
 =?utf-8?B?M1JKa0VkQlVHRW5ZS3V5NHRMTlpHWWhtaFMxTmpTS0FxK2xHK2pGa2h4WXhw?=
 =?utf-8?Q?Fos+oLm7UpOtoAyfRmRHOmErHvSGGW1Ra+IcF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2605197c-7de6-48e0-9c65-08da140e46b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:34:37.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RtTmWcEJk7f366C8gMdNfdhpBL5EjwMsEQxEC42M43Ax4WjGF2V+kAisa6mx88M353zB6W7P0EFI/bbI1uAlEuU39IzWOM4rT3O6aTLgXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2782
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010088
X-Proofpoint-ORIG-GUID: A2yLMZdpjlmDOpQ-3KRQhwZx74scUlUf
X-Proofpoint-GUID: A2yLMZdpjlmDOpQ-3KRQhwZx74scUlUf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 05:34, Baoquan He wrote:
> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and if no errors occur, it is
>> installed over the top of the existing elfcorehdr.
>>
>> In the patch 'crash hp: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> With this change, the kexec_file_load syscall (not kexec_load)
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
> 
> I tune the log a little, please check:
> 
> [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load
> 
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr need be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, then installed over the top of the
> existing elfcorehdr.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest',
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
> 
> With this change, crash hotplug for kexec_file_load syscall
> is supported. When loading kdump kernel via kexec_file_load,
> the elfcorehdr is identified at load time in crash_load_segments().
> 
Updated the commit message.

>>
> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 120 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..5da30e2bc780 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elf_index = image->nr_segments;
>> +	image->elf_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,112 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +static void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @a: first parameter dependent upon hp_action
>> + * @b: first parameter dependent upon hp_action
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and if no errors,
>                                                   ~~~~~~~~~~~~~~~~~~
>                                                   can be removed.
done

>> + * then it is written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See
>> + * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/* Must have valid elfcorehdr index */
>          Redundant code comment can be removed.
done

> 
>> +	if (!image->elf_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	ksegment = &image->segment[image->elf_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources. The elfcorehdr segment memsz must be
>> +	 * sufficiently large to accommodate increases due to hotplug
>> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> +	 */
>          This paragraph could be duplicated with the part in kernel-doc.
>          Considering to drop one?
done

>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/* Temporarily invalidate the crash image while it is replaced */
>> +		xchg(&kexec_crash_image, NULL);
>> +		/* Write the new elfcorehdr into memory */
>                  No need, the code is self explanatory.
done

>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		/* The crash image is now valid once again */
> 
>                  ditto. Sometime over commenting is not suggested.
done

> 
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
