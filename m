Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB644FF6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiDMMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:40:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037834BB87
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:38:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DCGvZ5008564;
        Wed, 13 Apr 2022 12:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f9PM2FURfeMWJ5QldHb2vWDTWbaYLLDcOsnQzoamVfY=;
 b=ddbg8axOWtVIKsBfhiNvVbyNemEQbi5U4ov+GWkvhoPCWsFR2+2ZFmr9Egy2cD4xT9ZB
 yblTK+uh8tGO+t1aDu5hNKQa/oVWn5NYrDLkONWzSu0DQJm2OfdevKb7Z0BXPh1ze0G1
 dC8GSSQmslUmsPqlKVv0/tWSguctGO18YvPUBYKqYwEwjeH5vXmOQUpXzoA/xpCT9vbZ
 3iD++W4rG7ztmgXYT730KnnM7mbX/96UXemwyzglX7amz7nxXk+ZwC22w8SvmwoNU6to
 3VqsxtbqcTkSQfUgF5Vv5KzzDKzgcUx4kwXNAJNmek6PmREdYrmc2I65JiUxPZ1SWRMj kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2hsg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 12:37:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DCaJm9013043;
        Wed, 13 Apr 2022 12:37:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9jnkjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 12:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPMtdNeoPMkHCg9x099t+LhxZ2e8+blQlD2mYNQetIwbb3+vzoHJFN+Cz2UqQtYSbgS5QaLcRsYRe9cR3N9cNTQshIhdYpILp2PdeG06tYrquunxfLiBFHabi58Y7tE6/CEOFGcDVB1IRKf2hcvTEuP2LtyD8DoMVgEmLCNZj4I3Zf+9Jk9cqqBPpr0oT6OtG4WMckbclW0BYD7YLMKjwbSA5GKiDyfFTVMx/q2TU4CAYgAfaFFhvZbHXAh+U8wWE2Gx3beV+KElTY4xjMi6spk6/g+0ImobjFStxV3DGz7pnrFoCv+0Vn5Y1mwOwoKppQzlOISlqwJP48xQtbuMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9PM2FURfeMWJ5QldHb2vWDTWbaYLLDcOsnQzoamVfY=;
 b=ZCTurCXfGGw+EjaZt+J43HhlMgC63KZalBu+foOgi591sBUXCCXI2xLxuF1BR8iyloZVY67VqtAIC4CCQ1Jjf87RvGqX+MQMbwxSxoRDYuqPCAUCcj+/xTq2dP07yZUhwKn6SpAp9xnIk5umzKwG3HTJSqer+WFAMdl9Ozu8xat4iqNJU3+E+yqrcmyk4IJXlY8F8LguVefaMRgBb+hZTO4fe9NVySsbgrbtyAVv668j1aLvnBWBoCh6vYE53og1xiK6GIMjQ3iINodV0b+MMQKyQs705+kwZdW/EMdfbCaJO4KrtxbH23+DU4MtDXIHQrlOugq5o+Bos+aDtEGa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9PM2FURfeMWJ5QldHb2vWDTWbaYLLDcOsnQzoamVfY=;
 b=fLca3uLb82UA21rEbRiaqEHoK3ufJD1/CLEnyNqvhmnPmNrhCtvMNCMMa9Piz/3L26T+C2fd/cpyIfWT4Z/ihzFZa4vgskuHTRIVpcvA3KoMEshznPSBMaLFVEqNk35Lh1KvOYUXGntKVkw/pq/rTILd6BcZCj1zkEBB0JucJ6U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM8PR10MB5429.namprd10.prod.outlook.com (2603:10b6:8:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 12:37:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 12:37:23 +0000
Message-ID: <d3ae80cd-7e1f-50e3-d90d-becf779788c0@oracle.com>
Date:   Wed, 13 Apr 2022 07:37:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
 <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
 <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0148.namprd11.prod.outlook.com
 (2603:10b6:806:131::33) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 765a9992-99d3-4710-df10-08da1d4a5be6
X-MS-TrafficTypeDiagnostic: DM8PR10MB5429:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB542960492ECBE143ED9D671297EC9@DM8PR10MB5429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xT4hnBUcwd3q2lSSOVwvWe/TBM9v/Czw/toS1NcoyTzv5kMZIdKFa+/3Bi7Ikv0pSsMfWTveFJgSY/gKOMgwLaQNZrpnwpo7dnTcpw+rc4lB48IXUrpWrod80qdNTVonHR2qvxxLYfMGuNX8itYDRceOo0OxGEzMQpsNPwjDHdYFmQVIizC15usxLVAT5Z5LkYEHIic0y0SwoRLQSkQXYlJxozcgC62DazcdEMbq5s5YtiPJqnfbaGgjl4ePxvFSrw091vxKSTsESn7lBmzG6XMV8IQlslK5NODp9M25aXaD8ZHyNJSWYYbqenzim8AnX3ObYhDdNgrU/Xs6VxtkXGTVo0DIorhKs//Mdju+vG/nq7DvRa7TtxtjqqJ2nmDRtrFAapjJHumh8jANaeLHxBG3Yi2pGLzmnY3CH/750vmOyJv14DgUw+7n+j/LhSr4AqGjBeajhJxev6opkn4Kb/q737GGT8II/pdVIvB5tWejfvSAQB8I59CPzsGmAhPuhg3V6QoCYR9JXyxUQBgAKw6j0GrpF9qI6ItL9a312U9IIV9bbENvTwVdtdjXoS6DTBB01EoSIH7BMBweKhhCFV9Ya06d+9BLeSM5vGYzpio1Vh96f0PGKkOXY13oyrWBXSkDxmEwIEh1rp8zwH4oNltzcg+E+smahRQpXzV7z20Sxu7KwL9GPtcm+yhdrWVMRCnIqYzj3E32ZUtBwxboF5u3nltHjSnfmiGkzEnzLJJJurrz1go6O3r08ZylXuXGTKlq3Ey2u4AnH9+tSL4bGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(107886003)(6512007)(5660300002)(186003)(38100700002)(2616005)(4326008)(8676002)(66946007)(66556008)(66476007)(6916009)(316002)(86362001)(31696002)(6506007)(6666004)(6486002)(508600001)(53546011)(31686004)(2906002)(36756003)(7416002)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R242ODdTRVFlL2lJdm9LaHR0bUkwZzl4L1lEYityQTBWZVAraWd6M0YvKytI?=
 =?utf-8?B?cEFLMS9tME5URllCTmZMWDZqWEZrRUk3dllFbGYvQ0F4SkRYSnE3dm9DMWVq?=
 =?utf-8?B?MCtER1hZdXVwVEVhdHBydWRBdG5Pc1BQMXRpRnZUQVhMYm5PTzF5aVRuOUZi?=
 =?utf-8?B?VW9PZE5ZNlFMM20xYzNITjRxSXYyS0FFRFhLMjlKYlVZTzJkRS9qQllqd2xj?=
 =?utf-8?B?RlpMZ3lBTDlCTG9RalNjTnR6bHBWb1pQWi9vSHRONXhzRkVwNWxaNGdGTjFH?=
 =?utf-8?B?YVZkWFFpWHBwS3hSb2tXTmlSNFk5dzRhQlZFbFdneEw5UlNwckFpOFFnZTVj?=
 =?utf-8?B?cXp0dVRFdFowYVh4WHl3VTZMZWJ5OWRwQS9wWjEzYTZudllPUzdVR3lFOFRs?=
 =?utf-8?B?MWZ3R3hJV1lEUDk1dHFNUllUeWZGYU8rZUZkVlhqeWsrRzJqNjcxVVoyV2pZ?=
 =?utf-8?B?M1B4cEZmR0Z3Sk4rV2NpU3NGQ0NVMG5rMGVlS0pkTmt1TFN3TW5rNmVLMzVz?=
 =?utf-8?B?T01vTnJ6MXFkMVRuemhrdENCdlZoYXA1TDFYajNCUEozaEF6anFrOXdyaGI4?=
 =?utf-8?B?RGwrd043RTFQY0FJSHlBNkEzTVc1TWZTdnlPaW5wcElkYzJmWDVJeDl2MTVi?=
 =?utf-8?B?M0RoWnUyL0s2VXJmVFVzdS92SVVQMFNvcHdnL2ZmdVM1Zit0aTRSUVROMWds?=
 =?utf-8?B?bVdtMldnU3lUQkQ1NnkzSmszVmVNaG9vWXF1ZWgvbmRvbUswZHNSVldpZFRY?=
 =?utf-8?B?L01zbFNtTVpoRndIVVRlUVh6a0doODdCTjl0VHQxenVEUUZ1dDBUUEdQL1Ar?=
 =?utf-8?B?TTN0SXZLOEU0dVZlblVwUTN3KzVWaWpyQlB2NnFFUmptZXBSWDFzT0pTaVk1?=
 =?utf-8?B?T1JISWE0NE1MWVRXMVVJQkxrclJPcjQrNGpObnh4MVFSL1krd09NbnV4OTJw?=
 =?utf-8?B?MGswSVNzaUxVSm0yNHRzdVZDSk81RG15ZVNKZllXdEVtZ0dEVVJTcHdSVSsz?=
 =?utf-8?B?bnZNelN2ZUQ0ZDl2b1BCM005bzdPdDlCK042eGhhRjdOVVFMRzdUWHNxd2xO?=
 =?utf-8?B?ZjJRb3pLWEM2REh6cm5YLzFoVDhTOWxWdHdwem0vNUQ5dGlOOXRKR1E2R2lp?=
 =?utf-8?B?ZmpiZ2FDa2graFljVUp4SVZZK3dzbzRZb1BkNk4wOEM5WUExNHh0ZE1MWUQ0?=
 =?utf-8?B?VEp5Z3FjaHJWdzY4aElaNmVhVDZ4WXoyM2Irb3ppeE1GU2lBcFVJcHB0bzBi?=
 =?utf-8?B?bDVibm4rSXh4TzlHYWpwT092THR4cTZPNjFiVlNnN0M0RXo5S1BFWEdEdncw?=
 =?utf-8?B?ZTBMT2M0bENzWnNYN25pTXkwSmlCMVFLMVkwVE1hWmppTWhjelZMS0RSZDFh?=
 =?utf-8?B?a0lkVG1GYmRjd2FidDNlY0F2MFJzdVBQaUUvOVhoRTVVeGcva3JwZ1FKdnlz?=
 =?utf-8?B?cFpGdCtEd2d3NlgvTU1QYytCWGRpSWVPbDBlaTRZQmVjR21uK2wzSitaVGxP?=
 =?utf-8?B?TFFyWGp0TkV6cVJtelRGSVBEb2NndzJqdDgyM2RzOFFETk9FaldnOXQzSzJX?=
 =?utf-8?B?Y3NLVklFSnZtaVFhWWs1VGJFYVlKSDMxditnTm5hd0JaV3NSTVMwOHI5Skkz?=
 =?utf-8?B?V21mZE00anROOGQwbFdqYm9nRFNRSlFFWHlOY05tbEhVWklqRmtCd2ZwVGF5?=
 =?utf-8?B?c0Q4bFdXVEJxVXkxZUdjR0trOHJ1aTh6dUdoZnhOdFdiZ3p2a2hzdWs0aEV0?=
 =?utf-8?B?dm5IVGN4SmI2QnVLVGZhSCs4cExXWEhsUEM5dHVYdFpuYVViS1VyWnhDaDg5?=
 =?utf-8?B?K0RWMGFlSnZvdWRvSGJCNmhpRWJ2cGRybFNnK2VrTG8rZGVJS2xGYlRaVEty?=
 =?utf-8?B?ckNkZHNqYldrWDFoVXRmZGhuQmdkUGpReTRYMnRoU3VWQmpHd1pCbExwTGk1?=
 =?utf-8?B?SG9YNUFkM1BBREw2SmU1VGtVNlczVjBvb2EzQlJkU21LN3llU2tmeTVQdE5v?=
 =?utf-8?B?Vm1iYVFSeGRBb1dCaWlTUXFjN2h1akE3OFZkcHE3WDNKMmg5V1MyNlYrT3R2?=
 =?utf-8?B?Q3pYM0dXV2owOC81aGpPTkdKeVdWdWJCT0p5YVhxRVVTNlgwWVFXc25RVHFx?=
 =?utf-8?B?RnRidXNybjU5eG53OTg3M3dIS1dEUFZ4ektXeG8zUFg2NVZQb0tyZXZTd1hv?=
 =?utf-8?B?SWRNcVdFTTdkRW5FcDBCUHV3TmFhMThWSDgvaXE0WUZ2b3VhazNWNWQvY1Fw?=
 =?utf-8?B?M3hxQTlhSzVlWGlkTUxQTUdSVXU1UTh4dG4zeXpEbXlJeld5elF3b0EwRklP?=
 =?utf-8?B?NzZSaTBUUzFxV2V4RlJHanBtckhWVVlUK2drWXBVQ2EyWFV1ZG96elpqeE5n?=
 =?utf-8?Q?05gGwGWfIhwuana//lF1s0SrvAPr0+alnrKqK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765a9992-99d3-4710-df10-08da1d4a5be6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 12:37:23.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Nbfn7qQubnIu11uUUOC06hhD8yuPFQ4R4++WkitAqIpfLKd4U391VT1gpC6pNqCIXs8MR04YcWBq/LbeIZ1rg6/rhMjS1QCmfnya0rLD0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5429
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_01:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=962
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130067
X-Proofpoint-ORIG-GUID: O19bCs8GF4XePGmyw1AKW2-rZVtrxlrr
X-Proofpoint-GUID: O19bCs8GF4XePGmyw1AKW2-rZVtrxlrr
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/22 21:41, Baoquan He wrote:
> On 04/11/22 at 08:54am, Eric DeVolder wrote:
>>
>>
>> On 4/11/22 04:20, Baoquan He wrote:
>>> Hi Eric,
>>>
>>> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
>>> ... ...
>>>
>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>> +	unsigned long a, unsigned long b)
>>>
>>> I am still struggling to consider if these unused parameters should be
>>> kept or removed. Do you foresee or feel on which ARCH they could be used?
>>>
>>> Considering our elfcorehdr updating method, once memory or cpu changed,
>>> we will update elfcorehdr and cpu notes to reflect all existing memory
>>> regions and cpu in the current system. We could end up with having them
>>> but never being used. Then we may finally need to clean them up.
>>>
>>> If you have investigated and foresee or feel they could be used on a
>>> certain architecture, we can keep them for the time being.
>>
>> So 'hp_action' and 'a' are used within the existing patch series.
>> In crash_core.c, there is this bit of code:
>>
>> +       kexec_crash_image->offlinecpu =
>> +           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
>> +               (unsigned int)a : ~0U;
>>
>> which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
>> I looked into removing 'a' and setting offlinecpu directly, but I thought
>> it better that offlinecpu be set within the safety of the kexec_mutex.
>> Also, Sourabh Jain's work with PowerPC utilizing this framework directly
>> references hp_action in the arch-specific handler.
>>
>> The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
>> the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
>> impacted memory range. I agree it looks like the memory range is currently
>> not useful.
> 
> OK, memory handler doesn't need the action, memory regions. While cpu
> handler needs it to exclude the hot plugged cpu.
> 
> We could have two ways to acheive this as below. How do you think about
> them?
> 
> static void crash_hotplug_handler(unsigned int hp_action,
>          unsigned long cpu)
> 
> static int crash_memhp_notifier(struct notifier_block *nb,
>          unsigned long val, void *v)
> {
> ......
>          switch (val) {
>          case MEM_ONLINE:
>                  crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>                          -1UL);
>                  break;
> 
>          case MEM_OFFLINE:
>                  crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>                          -1UL);
>                  break;
>          }
>          return NOTIFY_OK;
> }
> 
> static int crash_cpuhp_online(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
>          return 0;
> }
> 
> static int crash_cpuhp_offline(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>          return 0;
> }

I'm OK with the above. Shall I post v7 or are you still looking at patches 7 and 8?
Thanks!
Eric

> 
> OR,
> 
> static void crash_hotplug_handler(unsigned int hp_action,
>          int* cpu)
> 
> static int crash_cpuhp_online(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, NULL);
>          return 0;
> }
> 
> static int crash_cpuhp_offline(unsigned int cpu)
> {
> 	int dead_cpu = cpu;
>          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, &cpu);
>          return 0;
> }
> 
