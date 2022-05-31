Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3F53996A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiEaWTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiEaWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:19:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096909CC89
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:19:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKpfKC018920;
        Tue, 31 May 2022 22:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T7d5iD2Fzg6SrOAwyr9EFspPNbG2cxE3B2n5zKu61ng=;
 b=rsIFHuETZTzc5nZyA2nPAGAIsno8CIvksHflP9ATNILSbrrtAiCDQ/jPRvFxGJ4WauhA
 KL/PNvbiaP2Boxz/vmE3nV9pU0Iaby/4eEQCUO0MHt9Qc2P7AeLKuHOhz5R5Vi6wDQpx
 TfRuTKDNQYslZSrKVVVyla/A5GwVg4L0henMabr+myX3ItTiVdgNl5Mq53e3vtOs2lqp
 5KrLDtRrvLXuwrg564o0uTMIlgYkXUE2Kfok+BOpWD3EJ/Z12VAn8kXA4pCkeaMWMVa0
 xI4vZCJWS/E4Q5TBGjAjcJg76mDuagEPNzehEhuvWJVL6I5eFimdfiv+08CMvTlVuYuG bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xpcmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:18:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VMElOW033658;
        Tue, 31 May 2022 22:18:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kjdt6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQGirPFXbNQlCOU2I/xPAiKnP+0YwiFpbWj/wPdy2spe+oY2MNpUtfVx3dejsxOYigiSRsgTePAIclnZvR2eyaVHO5BlU9rsovk2cxZToykj0abur4NlV7u8EAvJSBLJgBGBZNcs3SFi/89DeJwNKm0Er6KmCMt8wT+jY9FiXLmb0UJHdXw18MYa7TX3mfFs61ejI5MTcRHuXK3mBQm+utQRTm4uLo3if6Plh6nVnZitvZAd3vUWGuELCy+XE3uQgGvuGqd1KXohnni00+t+j4AZ8g3IEjngTWZYvYEt+KzgGWsMsY7lmggZ1Gs2eBYi8CErn7IKSs0XZko47lPx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7d5iD2Fzg6SrOAwyr9EFspPNbG2cxE3B2n5zKu61ng=;
 b=V0EBr5SVuKk3dUV6R0t1vsHTxdqakJvrZQrEIL3tirpioSbziiFRkKJeHRtw2bobvFBRXqx43qpS4841W1dSMBpnMhi210R0oN31dn/+MBO7aXARezqwqlly9oq7UZNsavPsE60B0QxiRbwHVXux0Cnhs/nfvShjl39M9ljnlqCDczM8vswfPMW2pzZG0ifJNWN1TnGlB5KGSp12yBPKWSph2xoGHZntqw8qEmBcvb3XPM1GCOGNOyv5wjfRQ9Veb93B50nBW4shxY8k+Cbe28+XbNzrZ+HAjbK5FSW4Uft1J5BE8C9h1WdA1/TFk3JkalOSLfKhyvwR1Y++LHhefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7d5iD2Fzg6SrOAwyr9EFspPNbG2cxE3B2n5zKu61ng=;
 b=u/hygY2kVNsAazVcW62vDjUsMBV5SQSsmJeZqDgfAcNJxGQDEwDQBmQC2OHAlkrclska0WKzHQIMFED0zlSICWPrarPVqsgLuToJRXNAOt60ZiTQ2NnWmqj0oBqtBjt6AL9KT1+y9T5o1Ek/J8J5JbsnC+wF9YrPmLpT5Ne8jRw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 22:18:42 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 22:18:42 +0000
Message-ID: <fed45ff2-0f1d-6c55-244f-357e103fd775@oracle.com>
Date:   Tue, 31 May 2022 17:18:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 7/7] x86/crash: Add x86 crash hotplug support for
 kexec_load
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-8-eric.devolder@oracle.com>
 <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:6e::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e589a7bc-c4c0-4255-b601-08da435384e2
X-MS-TrafficTypeDiagnostic: MW5PR10MB5873:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5873485E0C7C25A91B0A671997DC9@MW5PR10MB5873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wf/AQ4iPqoRhskqAy334QsaY4oCTNbFhgwiLbPEccXrcK9e0kMSITAFp50EBZSWu2IHNT7r/hUoxr0BKQ/urKicJ9qBNcBvuNwbOvGNj/Do7sN+TS5b/9z+UlrLKET/H2ezUo/yCrmw5m3aIX5E0qbpwG3R94aR76bnndV3frg2Tid5N9MuVr7BEyAufK35cVFUWz0d5AyIwI+xf8wdsI2xrWE3Q4BNjfdfaXwu6y9pvncxQZyQU0ZIJcJi+mCPPg9y9Dr1yzutsDFKnk8BniPrGLVEYi3lzZJiaABBTT0ICKCgs74v58omRUEPqt3d7ErCRaJOOrUfXspMr/2sd5FKtclidAAClR4p1HQ9711/Wg+m4cr3TUrw3z2dP7rdRbykP0/cygJN72aSLZ7qxBIGVzRqqTaGppTYueL3UWHw0g8k0ISjwN5PH9bJaPOYoF4/m6ZfxKtv2cB/+N0q9uvUt/Xx4aQnMVg5ONz/Y0GN5hR21nIjvk8rHu0ge31bFdaS9KppeMkr8svD9g28DLbxQqJKxwy0ywyBfhVYgqEj4TR743Pdm1Hh8WQS9NeXcP9cS8arVquX7FpomesLK4g1Od5eeqmf98DdaYB9RUIFinQlqRGtOfbnGZrFJJ2wf+kPOLJmbNY7dPZGwQkZZfEytc2tHE2fkJhSh1U/m60G0lYWuXrmcrV/ELfd6TH0feQj245lsMuE+dgzsyQx+B1HJZ4633uJqmCa4UG2hI1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(508600001)(31696002)(66946007)(66556008)(36756003)(186003)(4326008)(2906002)(86362001)(2616005)(107886003)(38100700002)(6512007)(6506007)(31686004)(53546011)(6486002)(7416002)(8936002)(5660300002)(316002)(8676002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVNTG9rckhUK1Y1ZENCc00wcENnbmp4ZmwwMVVSY0RSQ1hLWGRKRDBLdGhI?=
 =?utf-8?B?dDBVb285ZE9VSmFjeHpTRC9acFAwUm5rTDl4ZVNWVnJCaWlqWDRpOTZGNzhV?=
 =?utf-8?B?NzI3Wi9JbW0wckpNcU9pRHlMWTBXZFJtNDZpQnNsbExtTjYwTFlSQW9rUm9E?=
 =?utf-8?B?aVhPWkRDaFh5c0JLQVRoaktEVEF1c3pkelQ0OGpGRDQwcW5mdytkdEVZUWRm?=
 =?utf-8?B?WjlISGY0aXExbGlpRWU4b2t3aExtOWJTbXFFS1JMN2pPWlBTby9PaDN5dGpB?=
 =?utf-8?B?Q1dyWUhMWFg4RllKNGZmZDZ0NUVHZDBEdFhYUUxPWHlkYWxYb1pqOHR4NDJr?=
 =?utf-8?B?UUxHOHBXTGFhbFRWRXhvZmR0U1BMVEVkY0xWL2NZVitzWG1vendZUjJBOGNx?=
 =?utf-8?B?azQ2RmRubU9FaFdZU3h3R0xIL1hTR0xpZ1Z2V0s4SmZGYzJnUkhiVXdvdFdh?=
 =?utf-8?B?dDZaeFBVZzk3SkM2bWFhNkFLaUlFRFBmaXJpL3VhSVhHNWdnT2JTMTRiQnR5?=
 =?utf-8?B?K1pJU216RUY5RTRQMk05N3l0MEEwNWN5RVZVLzlkVGRMSURZbXBXRnNhZXdr?=
 =?utf-8?B?dGZNUGs4eXNVR2J3QTE2TnZrNmRFc3l5a0hBdWphZmFZNDIwbWFaaXJnanB4?=
 =?utf-8?B?TzZZTzV6c2pEc3B1MkN1cmROV3BYcUFCUms4Y2x6UVdweHB1V0VoNEYyTURN?=
 =?utf-8?B?dHpjcE1KRzZaRG15aEZFR1o2T2tmQ3o2aUYxeEpNREJINTl4MmRxWkhqVndl?=
 =?utf-8?B?ZlMrTDNBNHFFcS84OWo2dWR6TWdiR0lLRStxSUNEY3J0S0lVUEtjNWYrcnlh?=
 =?utf-8?B?blFHQWtjbFNGeXFPTDh1SGVCdzZsWFhTdFF2Zk14UDZNQ1BiMDJwSjRiNlcz?=
 =?utf-8?B?OGxTN295d3A5WGs0cXluOFZPcTBmS2Q5dll6UVUzY29uUTJFWmNub0MrME82?=
 =?utf-8?B?R1ZiTzR4UjlmU0RNbmlaNXk4cWduQy9qT1VpMHFlNnNhQ29ubzJyVVRia3pZ?=
 =?utf-8?B?R3J3UTZTOEdEL3VQUW10ZC8yY1RNeWJWWFJMZHorUW5KaUk0YXpkRGJYSkdw?=
 =?utf-8?B?cmVSZTk4cGpRTjRkUXRtcXl5dmVqbFYvdHBJbkRlM0oxZDYyL3NjZTZib1I1?=
 =?utf-8?B?SE10MzVyVStrYk03dWYweXh6VHgzcFNQR0FBUjdPdlFiNkx2dkczcE1WV291?=
 =?utf-8?B?WTlsVnhQcTB5WVFTdkswQ2RjL3VaTGdtcG1tQWtMTkhpWjlpVitHN0h1TUZn?=
 =?utf-8?B?azVZUXE5Vk50WWtTUkQ0Q2RLZHlXRWhvdWVzU0xrTTNJUTMzZDhQNzk3MTVS?=
 =?utf-8?B?UzFZMzVGZU5jclBXbFJaQ3RNMEE3WGFScXMyYjJxR3RTcGlNZzMrOHZyd2Jk?=
 =?utf-8?B?YkVYVzdvMnJQSXU5ZkhUZzV5SCt6NTkxSnNKQ2ZYdTFSMWxxTFVqekhqZkF1?=
 =?utf-8?B?Zm1yOU1hWjQ1dkRiY0UyYlJqYmtpTVEwYUx6VmE1OFE3NW9mL3NHaDJHSktK?=
 =?utf-8?B?WFlYV2hXZFJrL3QyUmNCWXNMYVZJRS9XQlN0OEZ2ajAwV3NCazJrcS9wZXpO?=
 =?utf-8?B?US9UVDY3SjJORzZMYkExQzBja3d5NTRxZkRoM1kzdklOcFlUQUs2dEtYVStu?=
 =?utf-8?B?Wk1pREs3dGNuVURrVVpMNVZja3dXd05tUW12RzlyU3JMaDhvRFBtcDJoSGhM?=
 =?utf-8?B?NnlveWJYbW1vaG1tb0NoN0V1NHZXam12V3Y1TE5CaEhEWHIzbXZFMmttTHEx?=
 =?utf-8?B?VkhKc2dtTi9IRGEzRi9hb2krQkZXZlBxcWdCU0R6RTRiVXBqS2xDYkZrOVBj?=
 =?utf-8?B?clNVVHZuaGF6RTY5U2doRHlpb1pGcnNROFJzQU9KYmpCbUVKNFA2V2tPNkE1?=
 =?utf-8?B?Mk9BZkJpUVgyOEgrSkxqKy9ZWWNYY2crNWdUK2R5dVlVVDM2NUZ4aloxYkN1?=
 =?utf-8?B?cjhLQTJjK1ZreXRPRGV6M00xRmZvclZtV21TQ2o0MFB6YVdlckRUcy8wNmkx?=
 =?utf-8?B?ZkVWbXZRSzE3bjRBNFg3a0lEWEpreURRZVI1a0U2UU9UUkxSazg5V0tlZGx0?=
 =?utf-8?B?SjlPNmFuRmxuYURWWC8ydHhSOHdsVGozQXRzSlM3YTNURzBoMnB6cW56Ynpv?=
 =?utf-8?B?VE5VaHhrU083c1N6MVJtS0NFL0J2T2VVV2dWZzFzTjVabjhlcEtsZ1cxSWdY?=
 =?utf-8?B?MWprQ3paNGxld2VORjJ5a3cvUFFXa1dIenF5RkpEZ0hvQ3hzRnVOVzFiVVVY?=
 =?utf-8?B?VWFjZmlBUTIvSjkrYWJIYXdENWhjUXZYanBKMEJiQUh4TDlhaS9oMkg1bEVY?=
 =?utf-8?B?UzRxcXJkRGlOL25GYmlGalYrRXNPRU5SN0tnZklrbXJraE5xODF5RVNDNHB2?=
 =?utf-8?Q?IvZiFjPnGd0Qgdl/tjUSrJ5+PTRVcJmCfSaUv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e589a7bc-c4c0-4255-b601-08da435384e2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:18:41.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6j3chG706zX3urPqY5KOG1mgoNdurwP6veZJJP9QMYyyungZEG8b6tzzHtQeHgWkDFeXsAVPl2lgnSipw/ca8k4XpzZMsBLYzWBtImCslY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310097
X-Proofpoint-GUID: 17-XpWZikGjXIgYpLiRBuUw1aAlJvdDU
X-Proofpoint-ORIG-GUID: 17-XpWZikGjXIgYpLiRBuUw1aAlJvdDU
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 09:26, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:16, Eric DeVolder wrote:
>> For kexec_file_load support, the loading of the crash kernel occurs
>> entirely within the kernel, and as such the elfcorehdr is readily
>> identified (so that it can be modified upon hotplug events).
>>
>> This change enables support for kexec_load by identifying the
>> elfcorehdr segment in the arch_crash_handle_hotplug_event(),
>> if it has not already been identified.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 951ef365f0a7..845d7c77854d 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -485,6 +485,30 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
>>       void *elfbuf = NULL;
>>       unsigned long mem, memsz;
>> +    /*
>> +     * When the struct kimage is alloced, it is wiped to zero, so
>> +     * the elfcorehdr_index_valid defaults to false. It is set on the
>> +     * kexec_file_load path, or here for kexec_load, if not already
>> +     * identified.
>> +     */
>> +    if (!image->elfcorehdr_index_valid) {
>> +        unsigned int n;
>> +
>> +        for (n = 0; n < image->nr_segments; n++) {
>> +            mem = image->segment[n].mem;
>> +            memsz = image->segment[n].memsz;
>> +            ptr = map_crash_pages(mem, memsz);
>> +            if (ptr) {
>> +                /* The segment containing elfcorehdr */
>> +                if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +                    image->elfcorehdr_index = (int)n;
>> +                    image->elfcorehdr_index_valid = true;
> 
> How about finding elfcorehdr index on kexec_load path post kimage_load_segment call in
> do_kexec_load (kernel/kexec.c) or other suitable place? This way we can avoid checking for
> elfcorehdr index for every hotplug. Also we might not need image->elfcorehdr_index_valid.

That would be a viable place to put it. However, a couple of notes.

This code actually works for both kexec_load and kexec_file_load paths (how I originally used this 
code); so if we were to move this to a more common location, I'd be in favor of a location that 
serves both paths (ie handle_hotplug_event() makes sense to me). That would eliminate the need for 
setting the index in the kexec_file_load paths.

Also, I don't see a scenario where elfcorehdr_index_valid can be eliminated; the index isn't always 
valid. What are you thinking?

And the check is rather low cost being the check of a boolean.

eric
> 
> Thanks,
> Sourabh Jain
> 
> 
