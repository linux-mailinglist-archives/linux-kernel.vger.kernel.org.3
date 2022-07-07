Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC756A327
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiGGNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiGGNGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:06:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5330564
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:06:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267C9LLV004505;
        Thu, 7 Jul 2022 13:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F3NwzliUADUBa7fwMo9yq853N8OVmed1hBNFuFUM9qM=;
 b=RkG9zzNBfcJTTVe26CKn6n51xK5c4AzJg3oMRM9Ob6vFQmM5pENchiC6zOA4BcLhAIoD
 Ymcc+jh5IHKqsilNoLszbpzWCmrAylS9uYrcfq+PHNs+JolBdCXonqhvAkajhFcY9GDW
 HFPps3RDmN2nYgZ0K3ZWv3Guhnzc/z41+hdHdpcz/9JmH+5bAv4GC2q9xnPbNXydqFqE
 BukjrEw6SAreBnYmD7Ewd6c6MdJgtDemtF2wO81wbmW6tzbJrgH8nFbvsXIUL6kP1RWq
 wYb+/CpIlUa4ZKYziqyXp6RtFxl1IDFVqQtN0AdwrjvCtgqUwxMB5kiTb25p4sg373h9 vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyn46y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 13:05:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267CtIKM033712;
        Thu, 7 Jul 2022 13:05:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5rp2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 13:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyeejc/mU0GudQV6Vlv9JnTlSQ7nY4vYmkTB/ra9wNUHq4AbtUcNEL3SrVSnCiWYvZFTaknHPj0Pq71NfiGlAZbPssHxkAoAp4nGfxWkxUZTrsDKDEGNQQ/rgP2uB6k+wmfdR+84W1ooXAwgLvAjgW1oIHM1JWzpJF6VgEcLEjd+fJ6d99AF7kl64P8TISmvhwrVJPyc72CWZ1ZRQPs3oeCcRDKsbYVPH9iIakLZ78FmUrrnofW4s8RL9zDcnWvbCJwZnk99DAdDPi3CCEVb8FMtYViG6o6jcPXq1zzlwZUb7D6gsmnL8yOcH+ZhLOTnZ5EtiwuSOkYjQ/LcKigvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3NwzliUADUBa7fwMo9yq853N8OVmed1hBNFuFUM9qM=;
 b=LIRWeogTZeeXrUfehNAcHFbEsvQMe2QFz5x+ssvADy/4sZlXLhp6jH9NwnmLwiDJOO4UkCWJX2xUybJ0QtUNg1VYRiVzzdCZUB/IU1xApyRQqPVwyFxqq3r4zdqssg7cew0we3hMry1NNxKWoYKlXUpufhUSI30nLOqt0oon7TyWtMLxxgi/Ftr1Zu5CrRYNplCiQAypdbqXE7jJ6kmsFHbz6S7i62jSyAZk2zBEH1bD3mgXu+BnuYzL8RBxZXeSBdRqrDRDYpJIbnaNYMBCd86z715ybDN0Ls5iXQdTpkEsefKRL8HTIq6gCCkVNQR0W+4lVgeXerjiYSmOD48WAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3NwzliUADUBa7fwMo9yq853N8OVmed1hBNFuFUM9qM=;
 b=GwqKo+Y8MxJMdu030xaHkTOmECtkGEX5p4rwLTxbN3/83l+1X2/2U9kCQrv7Dll9KKiS8lyIB+ss+n2KA2pGMWwopCS54eyhWSIS8x+K/iDOS1yoQyPCktvq5y/teeyrlDn49+YILGadH0xMEg2XT0+OAmNO6osTmyeJvS1tTGw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB2917.namprd10.prod.outlook.com (2603:10b6:a03:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 13:05:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 13:05:35 +0000
Message-ID: <176bd603-05e9-2235-4052-dcca446098d7@oracle.com>
Date:   Thu, 7 Jul 2022 08:05:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <51e85040-5622-dae2-dc28-f167660184f0@oracle.com>
 <YsTiUXjVL1ativXJ@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YsTiUXjVL1ativXJ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 766a4910-ea90-4dfb-5296-08da60196156
X-MS-TrafficTypeDiagnostic: BYAPR10MB2917:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVAgMs5llbvNozRSyssyZJJIpcrjKDxE5jlPaPVyaDn3w5XMAsJGcmLF3FpIJhUuSbuLtjwOPFX57T4c9fHlRw7qHYowFe62U/3IJ40Gdw8WBuNYuUdTt+kON1+gYpMVMiJpzcLxp2eOvGE+THRvIONYPOY67rH+lhmCVdngaP9WxZhGP3YAM2NaVElypqNCLPWjGK4oqzws+2/ADnnp2yGKU8cnkKNhM3/2AcauPnhEAlQtHngjSjuATncEfJo+u3q69jjqG6Y26fqrmNsPlEIrg+y4SDcUAzi5bmuyzpeqCqrGA1i9uFQaPkxOkoiXZk3LzrkJtjC+9m+RRl78jJJ6+1RuJ2EPUcrQNyD6wi+nsl+ND5tncvU9lX9DU0D4fKFNXlCLX+vPrwQWNEuExJad5Myh1oBly01+E+2KfKp97+iCm7+viaKTSguyoVc98Y5T3QhRUuMTnk9MmvQ1z5Y88XxiPW025yQfNF2ELE3rEAHBD4mZ+wSgIyEBOXCvxRPQ+ERn0oj+18nuCrzvDD8i1X8uLcGGdLQpzJoBn5rZPZh2E9S/f7+nq6PqJILOB5cZZbuKTcXLgPqESKd01n5F3nhXp/p0LT0N24QWP78PpWtY6m1N0otuIzcqjFDzYk/j01UZuagt9eZ4UBWGYkHNKpjSHhP/yDLhqx2giSPQb1UP1TXxbIDGQ4/lbQOx0VKbD6Azdc47+mBWJefBRzCvLj+L0Y9CM4fMyguqX+aORpj6rFCcN7Z510YIQ3Dss/TURw536XN9ZAED/hwZVSN87vXai91AIYP+r+cVk9XogNidqFU47bPZEpT6cZdSA/RctxT2R9jFFI5Q24jGZUQDqPb1l1OJVD61mu+OtvpbnVNHejBtOyhjS7XYYzWxqIHtRrDCpgRB2/u5ky5FMCvFfGutw0xsEq+LOkzANeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(39860400002)(346002)(376002)(6916009)(6666004)(53546011)(38100700002)(6506007)(36756003)(31686004)(316002)(4326008)(8676002)(86362001)(66476007)(66556008)(7416002)(41300700001)(8936002)(5660300002)(83380400001)(31696002)(66946007)(966005)(2906002)(6512007)(186003)(478600001)(6486002)(107886003)(2616005)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndCalBTd1k4R2dCZ0NTUkVJLzRSL3Y3cXliM0xFQ2g0bDNpTjVQWGxLNitS?=
 =?utf-8?B?WXl4SFF6ZjVPcmN2NU1DZk9kelBHNjNQNkwvdUx3SWY0eDFvcWh5eFdGd1R5?=
 =?utf-8?B?VTFZTjlLMFhxNkRjak1HU2E4RjJxUTRXWGVSYUFhdm5XVGdjR1dnZk5jLzdh?=
 =?utf-8?B?ZGNNYTg3MmdhSHpkOTI2Sy9DMjY2SCs4cVl5WUxTbFlJQjQyYU5va05aSXZl?=
 =?utf-8?B?czJzT1Q3K1FDcTA5Y2ROdWpDT2wrYmcrUVU3Sk1OUytBM1hibUk3U3VxcldD?=
 =?utf-8?B?R2ZiWnhsSFIxUWx2cnBVeDRVRVBCc0pCUjNGcHZ6ZVBwUUh0SkNiMEQxMGti?=
 =?utf-8?B?RXZieG5WejhZYlMzOXFRMGJhK3FTenFsMWdTYUNCRDNFOG52Y3FkVy9qL0RB?=
 =?utf-8?B?djBMMTlzYkc0UDZWZ1dRSXRLc1pObXNCMjU0MEFMblp6Z2JwNldiY2ZBQmlq?=
 =?utf-8?B?VWlVL3Z3cmxFbklTOStFMmY0WTR0UXlmOStGRHU2cjJKVUVpRFZMV25NSE4v?=
 =?utf-8?B?NFdEamtwWmVaVFh2Ynp2a0VXWjJQZW9DOFRSeGdlT1BEM1MwOS9ka25ZNkVj?=
 =?utf-8?B?UjMxTmMvVDNKbCtCbTBMSldJZ1ovdE9Ba2IxZEYycDFKR3ovQlp5U204K3Nq?=
 =?utf-8?B?QTFzWDVYZTVPUVJzY3lxdG1BT1F5R3IxczlQeDFVeWdFcnJWOVN2b0JvUlhm?=
 =?utf-8?B?cW5Dck9tUkhJU1BrNHB4U1F5R213dzVKcmltUWVORVZacG44MlR4cUIvQm8z?=
 =?utf-8?B?SnZxeFd5R0tHdFhyVEFNazRJdTlvdGFkWHoyOTM1NS9HVDBGV0UzTktzM0JM?=
 =?utf-8?B?TG9wWnJPSDhsWEtSQi9lTDh0eVhOU3gzZWdsYVg3SVZURTdYTG9IdklxNUJB?=
 =?utf-8?B?YlBhR0NscHB6WHdKcHo5MStYT2gvbjM3U2xmbGNBamlKakRmd1ArdStyblVp?=
 =?utf-8?B?c3RTYWlRa3ZWVVU3VHdDaGV6bXRBa3FHQ1c2N1hwcm42WkRHQ0tqMXcrTHYz?=
 =?utf-8?B?dXVhVThzVnpSRWR3R1FLODViWXJnY1pBbjhMK0MwZU45R0p4WElIUkV3UDZK?=
 =?utf-8?B?OEJKdkpWdkp4RzhhNGhEL0pmSWVldy84UW9xSXlJeWJINE50bmR4c1NsMjlN?=
 =?utf-8?B?Q2J6ellCcGl6R2pVRnYwSWhPYndSV21BY3poOFdLR2dRYjZZM05DVy9maXhw?=
 =?utf-8?B?WnM2Z0xjdC9xZDZxTGw4cURZY2ZlbHBoUHBaZklyNFdUVzRabFNZOXhOSUll?=
 =?utf-8?B?bHdIalp3dHhFVVBhTTE2aUpDbFBiblpCbFFObnBXeTQ0dW9VcEZrUHgxa3lL?=
 =?utf-8?B?OFc0OCt3RThJcyt3UjVEK0VsRGJmUXg3U1FKa3Z0U2tyU1MwMElpQzNQdUd2?=
 =?utf-8?B?SHpxdHhMNERYRDEzUVE4ZnlrZ3g2cnNSUWxmZk1WaVcyTUpIQWpXS1VtTTZY?=
 =?utf-8?B?SHR0VjFJZ09IeEtkU1F0VkJJV0hGK1JOU3djMG00Vzh5cHJuSi9hNW9LRTM1?=
 =?utf-8?B?cGpMdGkvL29EYkVURXpHeVc1a1RheTByOWpHbjdTUnJudnBqSUFPcUgxOEFm?=
 =?utf-8?B?U29CUGk5emlGUWsrWGNtWlAydXlzMkQ0UXZkK1BpQlc2YkdEbnNYb3RNNDFP?=
 =?utf-8?B?NGJQZklaMnFzOGd6VlJHQlN6MEVlM2NWNnFvMkFhajN4cTBFbnVuaXN4RDMr?=
 =?utf-8?B?eHpjelI3VjI2ZERtZ3BaOUwvOXlJeHN0d1lMQWdkbDZ6WWJMaDNqb3VDUHdq?=
 =?utf-8?B?T1VMd0pwdWl2SG5uNVRocGZ0VVJycVRDYnBQZ2RsUmlGcklKM2YvZEp2REY4?=
 =?utf-8?B?eU9jUktJTitZT3liZStnRW8wVEtYWE5WVUhWT2RFL2hmOC9vWmoyMFIrZ2ZB?=
 =?utf-8?B?OWpKQXY1OTUxelNTbzFtR2tqeUVld2VqMzNDdGtOajA2aEJHNEhMcUF1YjMx?=
 =?utf-8?B?cjhpT2VSTlZlcWFrS2xmY203aWRDYmdFenYzV3U3WVZuSWRrVE82SEV5ZzdJ?=
 =?utf-8?B?dHlUQkQ5YzVHRlMxamgwT283T3F0TmFOMnd1VTkxbHFFVGI1d0FXTHB2bW05?=
 =?utf-8?B?VnpWMi9RczFTQ0Fhd3lMZEw0dG0xL2I0Z3RtZHd3Wks4WUNDcnVsRlJHLzVK?=
 =?utf-8?B?ekdjRXBTdmZpTERMQ2ZnbHRhZ0g1cU5mbEkrbnduSjdjZE1aQVF2bVErck5v?=
 =?utf-8?Q?9AqluVFUgAyGhujyFrfbjec=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766a4910-ea90-4dfb-5296-08da60196156
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 13:05:35.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSUkD41TrfjHv8e4T+++n8XGCZzdK9uEMZkttM3pp/p30+421Lxcdk8i/MnkT/qao9uQdbU+b2tPtTS7WeAzqxchJ2q31lwlRgnOrLHFsuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2917
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_09:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070052
X-Proofpoint-GUID: LpGaHLC8FBH-qyrXUz8X7ehk-HpF5M3n
X-Proofpoint-ORIG-GUID: LpGaHLC8FBH-qyrXUz8X7ehk-HpF5M3n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 20:16, Baoquan He wrote:
> On 07/05/22 at 10:17am, Eric DeVolder wrote:
>> Nudge...
>> Thanks!
> 
> Seems DavidH has concern and rasied it after you posted v9. Is that
> solved?

In looking at David's comments on v8:
- [PATCH v8 2/7] crash: prototype change for crash_prepare_elf64_headers
   I adjusted per feedback and responded as such. He provided an Acked-by.

- [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug support
   He says do not use WARN* on expected error paths. I instead used WARN_ONCE(),
   but I didn't consider this an error path. Nonetheless, I'll remove the
   message altogether in v11.

- [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot un/plug
   David muses about a better name, but that was in response to Sourabh's
   and I exchange on the sysfs attributes to use to report the presence
   of this feature. In the end, I used something altogether different, as
   presented in v10 (and the corresponding udev solution/change that goes
   hand in hand with it).

Let me know if I've missed anything else? Sourabh points out a build problem
for architectures without this feature support, so a v11 is warranted. But I'll
wait to post that until I hear that I've addressed the previous questions.

Thanks,
eric


> 
>>
>> On 6/13/22 17:42, Eric DeVolder wrote:
>>> When the kdump service is loaded, if a CPU or memory is hot
>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>> and memory in the system, must also be updated, else the resulting
>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>> regions).
>>>
>>> The current solution utilizes udev to initiate an unload-then-reload
>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>> outlined the significant performance problems related to offloading
>>> this activity to userspace.
>>>
>>> This patchset introduces a generic crash hot un/plug handler that
>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>> changes, this generic handler is invoked and performs important
>>> housekeeping, for example obtaining the appropriate lock, and then
>>> invokes an architecture specific handler to do the appropriate
>>> updates.
>>>
>>> In the case of x86_64, the arch specific handler generates a new
>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>> with userspace needed.
>>>
>>> To realize the benefits/test this patchset, one must make a couple
>>> of minor changes to userspace:
>>>
>>>    - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>>>      Add the following as the first lines to the udev rule file
>>>      /usr/lib/udev/rules.d/98-kexec.rules:
>>>
>>>      # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>>>      SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>      SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>
>>>      These lines will cause cpu and memory hot un/plug events to be
>>>      skipped within this rule file, if the kernel has these changes
>>>      enabled.
>>>
>>>    - Change to the kexec_file_load for loading the kdump kernel:
>>>      Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>>       standard_kexec_args="-p -d -s"
>>>      which adds the -s to select kexec_file_load syscall.
>>>
>>> This patchset supports kexec_load with a modified kexec userspace
>>> utility, and a working changeset to the kexec userspace utility
>>> is provided here (and to use, the above change to standard_kexec_args
>>> would be, for example, to append --hotplug instead of -s).
>>>
>>>     diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>>>     index 9826f6d..4ed395a 100644
>>>     --- a/kexec/arch/i386/crashdump-x86.c
>>>     +++ b/kexec/arch/i386/crashdump-x86.c
>>>     @@ -48,6 +48,7 @@
>>>      #include <x86/x86-linux.h>
>>>      extern struct arch_options_t arch_options;
>>>     +extern int do_hotplug;
>>>      static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>>>      				  struct crash_elf_info *elf_info)
>>>     @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>>>      	} else {
>>>      		memsz = bufsz;
>>>      	}
>>>     +
>>>     +	/* If hotplug support enabled, use larger size to accomodate changes */
>>>     +	if (do_hotplug) {
>>>     +		long int nr_cpus = get_nr_cpus();
>>>     +		memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>>>     +	}
>>>     +
>>>     +    info->elfcorehdr =
>>>      	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>>>      							max_addr, -1);
>>>      	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>>>     diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
>>>     index b8bb686..5e29f7a 100644
>>>     --- a/kexec/crashdump-elf.c
>>>     +++ b/kexec/crashdump-elf.c
>>>     @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
>>>      	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
>>>      	long int count_cpu;
>>>     -	if (xen_present())
>>>     -		nr_cpus = xen_get_nr_phys_cpus();
>>>     -	else
>>>     -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>     -
>>>     +	nr_cpus = get_nr_cpus();
>>>      	if (nr_cpus < 0) {
>>>      		return -1;
>>>      	}
>>>     diff --git a/kexec/crashdump.h b/kexec/crashdump.h
>>>     index 18bd691..28d3278 100644
>>>     --- a/kexec/crashdump.h
>>>     +++ b/kexec/crashdump.h
>>>     @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
>>>      			   unsigned long long paddr);
>>>      unsigned long xen_architecture(struct crash_elf_info *elf_info);
>>>     -int xen_get_nr_phys_cpus(void);
>>>      int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
>>>      int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
>>>     diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
>>>     index 70fb576..f54a2dd 100644
>>>     --- a/kexec/kexec-xen.h
>>>     +++ b/kexec/kexec-xen.h
>>>     @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
>>>      #endif
>>>      int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
>>>     +int xen_get_nr_phys_cpus(void);
>>>      #endif /* KEXEC_XEN_H */
>>>     diff --git a/kexec/kexec.c b/kexec/kexec.c
>>>     index 829a6ea..3668b73 100644
>>>     --- a/kexec/kexec.c
>>>     +++ b/kexec/kexec.c
>>>     @@ -58,6 +58,7 @@
>>>      unsigned long long mem_min = 0;
>>>      unsigned long long mem_max = ULONG_MAX;
>>>     +int do_hotplug = 0;
>>>      static unsigned long kexec_flags = 0;
>>>      /* Flags for kexec file (fd) based syscall */
>>>      static unsigned long kexec_file_flags = 0;
>>>     @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
>>>      	return 0;
>>>      }
>>>     +long int get_nr_cpus(void)
>>>     +{
>>>     +    long int nr_cpus;
>>>     +
>>>     +	if (xen_present())
>>>     +		nr_cpus = xen_get_nr_phys_cpus();
>>>     +	else
>>>     +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>     +    return nr_cpus;
>>>     +}
>>>     +
>>>      static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
>>>      {
>>>      	char *buf;
>>>     @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
>>>      		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>>>      			continue;
>>>      		}
>>>     +
>>>     +		/* Don't include elfcorehdr in the checksum, if hotplug
>>>     +		 * support enabled.
>>>     +		 */
>>>     +		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>>>     +			continue;
>>>     +		}
>>>     +
>>>      		sha256_update(&ctx, info->segment[i].buf,
>>>      			      info->segment[i].bufsz);
>>>      		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>>>     @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
>>>      		case OPT_PRINT_CKR_SIZE:
>>>      			print_crashkernel_region_size();
>>>      			return 0;
>>>     +		case OPT_HOTPLUG:
>>>     +			do_hotplug = 1;
>>>     +			break;
>>>      		default:
>>>      			break;
>>>      		}
>>>     diff --git a/kexec/kexec.h b/kexec/kexec.h
>>>     index 0f97a97..b0428cc 100644
>>>     --- a/kexec/kexec.h
>>>     +++ b/kexec/kexec.h
>>>     @@ -169,6 +169,7 @@ struct kexec_info {
>>>      	int command_line_len;
>>>      	int skip_checks;
>>>     +	unsigned long elfcorehdr;
>>>      };
>>>      struct arch_map_entry {
>>>     @@ -231,7 +232,8 @@ extern int file_types;
>>>      #define OPT_PRINT_CKR_SIZE	262
>>>      #define OPT_LOAD_LIVE_UPDATE	263
>>>      #define OPT_EXEC_LIVE_UPDATE	264
>>>     -#define OPT_MAX			265
>>>     +#define OPT_HOTPLUG		265
>>>     +#define OPT_MAX		266
>>>      #define KEXEC_OPTIONS \
>>>      	{ "help",		0, 0, OPT_HELP }, \
>>>      	{ "version",		0, 0, OPT_VERSION }, \
>>>     @@ -258,6 +260,7 @@ extern int file_types;
>>>      	{ "debug",		0, 0, OPT_DEBUG }, \
>>>      	{ "status",		0, 0, OPT_STATUS }, \
>>>      	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>>>     +	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
>>>      #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>>>     @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
>>>      	int buf_end, int phys);
>>>      extern void arch_reuse_initrd(void);
>>>     +extern long int get_nr_cpus(void);
>>>     +
>>>      extern int ifdown(void);
>>>      extern char purgatory[];
>>>
>>> Regards,
>>> eric
>>> ---
>>>
>>> v9: 13jun2022
>>>    - Rebased to 5.18.0
>>>    - Per Sourabh, moved crash_prepare_elf64_headers() into common
>>>      crash_core.c to avoid compile issues with kexec_load only path.
>>>    - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
>>>    - Changed the __weak arch_crash_handle_hotplug_event() to utilize
>>>      WARN_ONCE() instead of WARN(). Fix some formatting issues.
>>>    - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
>>>      and CPUs; for use by userspace (udev) to determine if the kernel
>>>      performs crash hot un/plug support.
>>>    - Per Sourabh, moved the code detecting the elfcorehdr segment from
>>>      arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
>>>      and kexec_file_load can benefit.
>>>    - Updated userspace kexec-tools kexec utility to reflect change to
>>>      using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
>>>
>>> v8: 5may2022
>>>    https://lkml.org/lkml/2022/5/5/1133
>>>    - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
>>>      of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
>>>      is not needed. Also use of IS_ENABLED() rather than #ifdef's.
>>>      Renamed crash_hotplug_handler() to handle_hotplug_event().
>>>      And other corrections.
>>>    - Per Baoquan, minimized the parameters to the arch_crash_
>>>      handle_hotplug_event() to hp_action and cpu.
>>>    - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
>>>    - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
>>>      to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
>>>      by David Hildebrand. Folded this patch into the x86
>>>      kexec_file_load support patch.
>>>
>>> v7: 13apr2022
>>>    https://lkml.org/lkml/2022/4/13/850
>>>    - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.
>>>
>>> v6: 1apr2022
>>>    https://lkml.org/lkml/2022/4/1/1203
>>>    - Reword commit messages and some comment cleanup per Baoquan.
>>>    - Changed elf_index to elfcorehdr_index for clarity.
>>>    - Minor code changes per Baoquan.
>>>
>>> v5: 3mar2022
>>>    https://lkml.org/lkml/2022/3/3/674
>>>    - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
>>>      David Hildenbrand.
>>>    - Refactored slightly a few patches per Baoquan recommendation.
>>>
>>> v4: 9feb2022
>>>    https://lkml.org/lkml/2022/2/9/1406
>>>    - Refactored patches per Baoquan suggestsions.
>>>    - A few corrections, per Baoquan.
>>>
>>> v3: 10jan2022
>>>    https://lkml.org/lkml/2022/1/10/1212
>>>    - Rebasing per Baoquan He request.
>>>    - Changed memory notifier per David Hildenbrand.
>>>    - Providing example kexec userspace change in cover letter.
>>>
>>> RFC v2: 7dec2021
>>>    https://lkml.org/lkml/2021/12/7/1088
>>>    - Acting upon Baoquan He suggestion of removing elfcorehdr from
>>>      the purgatory list of segments, removed purgatory code from
>>>      patchset, and it is signficiantly simpler now.
>>>
>>> RFC v1: 18nov2021
>>>    https://lkml.org/lkml/2021/11/18/845
>>>    - working patchset demonstrating kernel handling of hotplug
>>>      updates to x86 elfcorehdr for kexec_file_load
>>>
>>> RFC: 14dec2020
>>>    https://lkml.org/lkml/2020/12/14/532
>>>    - proposed concept of allowing kernel to handle hotplug update
>>>      of elfcorehdr
>>> ---
>>>
>>>
>>> Eric DeVolder (7):
>>>     crash: move crash_prepare_elf64_headers
>>>     crash: prototype change for crash_prepare_elf64_headers
>>>     crash: add generic infrastructure for crash hotplug support
>>>     kexec: exclude elfcorehdr from the segment digest
>>>     kexec: exclude hot remove cpu from elfcorehdr notes
>>>     crash: memory and cpu hotplug sysfs attributes
>>>     x86/crash: Add x86 crash hotplug support
>>>
>>>    .../admin-guide/mm/memory-hotplug.rst         |   8 +
>>>    Documentation/core-api/cpu_hotplug.rst        |  18 ++
>>>    arch/arm64/kernel/machine_kexec_file.c        |   6 +-
>>>    arch/powerpc/kexec/file_load_64.c             |   2 +-
>>>    arch/x86/Kconfig                              |  11 +
>>>    arch/x86/kernel/crash.c                       | 119 ++++++++-
>>>    drivers/base/cpu.c                            |  13 +
>>>    drivers/base/memory.c                         |  13 +
>>>    include/linux/crash_core.h                    |  12 +
>>>    include/linux/kexec.h                         |  14 +-
>>>    kernel/crash_core.c                           | 241 ++++++++++++++++++
>>>    kernel/kexec_file.c                           | 105 +-------
>>>    12 files changed, 456 insertions(+), 106 deletions(-)
>>>
>>
> 
