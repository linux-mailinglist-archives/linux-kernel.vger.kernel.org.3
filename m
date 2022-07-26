Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAB581C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiGZXd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:33:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1672FFDD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:33:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKn4up024544;
        Tue, 26 Jul 2022 23:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b6wO/3pdjGedZMm568xlqM2fZJwXioknbMs8JiVAnn0=;
 b=mY0C3SzRLUXhjuGmRGzknUUjX8rUQEUBXgatvEsC7WBZtV4vlY43bsDlsYz7JUbAoA9x
 X1rpgoqjcJduUmt3R4p1LnQcMtwro1mRToVBhLnC0hXNeBHnVFcUD5PhPk1fVU6KZ7cR
 Kv7ad8N96LtQQyUa2KbTVMxwVM5CvCPLyO40PInnjTPPmCzgMqUtCu7QZeZ6Up9sfN1q
 5Nq72kIYMAi/ZI9PdQVklPATeCtnxvkKBgMYGHlUZyYY3+GXItNq8hNqGwf4Mlw4rwsi
 pSOzYvp+NF2NvCyy17izAigPXZFqI/GgCelNbYKR2rFRY8W3yRW7NcUO4n3kl0PRJB3H jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940qqnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 23:31:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QMg2Ha006242;
        Tue, 26 Jul 2022 23:31:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65c6394-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 23:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+2X0JzZzsnHRHgXINMMFFu6uo//+HMRucI6ZhjmwWI4t2Vuvlw2FjjRz6JHSUf1TviYx4QBBPLqvz9QlpxfvL+H5DQEzvN98Oth5X+04dHPpzh2ZemgzpcwyuNyLyloI7fj5+NCiIS0lTVESGW4iOJ11dZo7osI8RJ8obZFaaWGBC1g2Zb/NSuNkxyZ42hnNtT9vB9OXPVEn4qXsdDMNcaiNvsYLo1qZ3bgZwbVTIT0QBUmKle/4VTGo+5XmRuBETgepR/eu9+hg7POG7hO3DgVFtqtnm9SEOU0U6OEspM6dpr4hvACNwBBtw4YBZwniuctyNvSEt5LfcDAhAth6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6wO/3pdjGedZMm568xlqM2fZJwXioknbMs8JiVAnn0=;
 b=Tw99YD/ZMNKXaDiFzBMI3tBAjrPS6qOqJTHweiPqxapiO3ra7NY1IQVb+onptM0/NXYNZgA2EmaLgM3MeyHWD2Df0LmyWY/MEtNaJq2emvp2M50bglGWUV8ZSTFg7WiqF+SIdqgVjQJXsa2sGW9fDcQ9SAkgxs4vz/HF8kZoLiushu0cg6zvYlcM1Rdt56sJ9HCVw+8lFFhQzFqHQdTWTDNCBZ6PVS1KX9yYeu0u8BxSVH3iibcBup8rH+ke++ow+hyStFvM5hw/iEQ2mVpOm4ZiaWO2fPtqMWC+KoE+SG5/QJh2SLOR7l1bskf2UjYjFF/VfqGziRr1QVAemZDGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6wO/3pdjGedZMm568xlqM2fZJwXioknbMs8JiVAnn0=;
 b=oVgw7SnTwaZ5+aDT4BAGkZO5zkV5kLLl1DjDPvjou4QJDHlCJRDp0BvT04L6ALf3fa6HCX1FchAfpLBl4UY/Tf4psshlrIqtBevtcsaXNUMEvgVzJALwqlC+H+dttcy6nCxmO5fJwqteyFOrdo6T+WkYaLTvAW1FUhbCJsCx0No=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 23:31:37 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 23:31:37 +0000
Message-ID: <f396712e-f567-f4f9-7b2b-a67b528e1939@oracle.com>
Date:   Tue, 26 Jul 2022 19:31:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <jane.malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        xen-devel@lists.xenproject.org
References: <20220726125657.12151-1-jane.malalane@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220726125657.12151-1-jane.malalane@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0130.namprd11.prod.outlook.com
 (2603:10b6:806:131::15) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0123e62b-c3ef-4dbe-75ae-08da6f5efc3a
X-MS-TrafficTypeDiagnostic: CH0PR10MB5260:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvWQC2Az8/IdCmk2GttLKMkToRrHZpqOehE89Qf3X4mQ8MfJUPq1bA3DQ7yufvWITg56UsNXAuXhf/11wWVcIdMsCsgmPlaYGNci5Krncy+p9dr439DKAi0hFU1zUJQJ43Ca3zj6aCc6I3oMWQIgATx/x636npFw56cGZWV2Z5cZCbMsQwsEesMP/DkpMz6IlAyCA92r8V7By+imGydq+UtZpXl1ZdhHf8u8QSTPFDPpdjHOp7iwSRbc9IXF+Qh+hLCiKT6uVH7s9wJ2w8h7kTay3KTp+e2soBzgH3svHXhRDo82Mv8C2d8eJfvP28EOPp68CnxO62ijEl2GEarDdXtKQQ1xZfqiaV8plTZ+ApS7yzbbLG0arfaneWST3OYL4IgNgSVLChyBu1KBliHHOwNHpFlawVgWhL1ZlaHTsu8PuYVpeS9a2/XUD9SGbO5fS1aS6sNzTwBxwT4Q7DXBWlKrUlXK+euGyvSSZoB6XB5nJTkjiCb/doBgSWfx/54x4erosae/r7mmCWDNBxw/ObyE/nEsIhD7UKrJ9psPtPtpynHh8IXYWzq8Mbh3CQQujqQteiBxxEHCcWedKOHvZPo1dEAAORBdoWpBWaucF9s3rVnXZtZpE5fmycZmGUb/Yq5IzyZd5yKGm/ic/tiQ4Fdrv/r77HUBlcBD3Mrj/6Wasf29HCR6MeFH8Cp94t1yOPci+r9Z7miihscdQ/KxO8ffpquCmGUSlqMtX/crb094j6bMwd5Z7R07J1RYcnLT+lX+9UDzJQaBM5LFQsT4bQ7QRC23jSGMnRTh8KKk2y0xzQfI4vOK1j5upUkKpKoNpk7rhRxPczrbQ6pdNmqggg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(6506007)(41300700001)(36756003)(6666004)(38100700002)(186003)(2616005)(54906003)(316002)(31686004)(2906002)(110136005)(86362001)(31696002)(4326008)(66556008)(8676002)(6486002)(44832011)(53546011)(66946007)(66476007)(7416002)(5660300002)(478600001)(8936002)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjE5cjN3UXFxd2FHOUd4dGVEZHZVdmltK1NoWHV5MVozdGJRVzBINnhoY29R?=
 =?utf-8?B?ajlXR3MvdXlaOCtaN3VLaitNRWpueU1jd29OdVF4RFhML2tLeHNwOWtFVmdr?=
 =?utf-8?B?bldGUEdlV0tORWFiMUF6aXUxSzBOOVhXRVRZc1llQWl5VVE1ZG1CWHNKelo0?=
 =?utf-8?B?RnRwUHV1emdjK2FXWkc1ZThPenkrRkpJY3NDSWhSSnJySkt4aUluSGk1S0tV?=
 =?utf-8?B?UHFlUmNIa09aYjdnSzUzTUZWRXNab25KYkNCZ0txRlphK1BXSHpOcVNoVHFt?=
 =?utf-8?B?RmY4cUpqRTY0UGd5eVlsODY0ZVIvLzk5RzNqT1ordFFRc2tOelYvUFdPajY4?=
 =?utf-8?B?QXlPa3FZbVRySFFIams4WHpZdWdQOU13OERoRUZTOEk4YzNJVTNxVDNVS2JF?=
 =?utf-8?B?bko3dlZ3MnBvcWkzcTF3Qm95SDNMeXJ6cGN3N3JoUlh2TFlRc2swYmY2Rmsy?=
 =?utf-8?B?eUJKbU96K2tRY0FOQi95b21nMm1KZ1BtMk9mYm14Nm9EZ0tsdEpyMlBLbjBK?=
 =?utf-8?B?R0lGQjlGaG0zQWFkNUFWbGZCR2tXOStFemM2R0pTUnBHNmMxdzhDNHdNWmNY?=
 =?utf-8?B?RXBpZTlOdzBzR3d6OEMyS0NkZmlZT0hkY3ZuUVROZ3ZjWVdKVWZaOEU3ZGQ4?=
 =?utf-8?B?ZjdLczU5QkJodUY2YkppYlViaGJpQkFraE5jUnJBdDdMaVZxcXRCRG55V2h5?=
 =?utf-8?B?ZmpLdmg2eXJ1WkNuQXJXTUdqS1BGVHJsQW5ZZk53MFp6dVhvMk1mcW5QMDVt?=
 =?utf-8?B?RFZOeUVDQ1FhOGtJQ0dNeVRNdkdyOVNabWNoRS9oZHQwQWE5MjZON0wzNlJP?=
 =?utf-8?B?MFdPcnp5TDBnQjdUeGxMODNDbThaWnhHNVVIaE4yWG0zYnowbkR0Mk92UUdY?=
 =?utf-8?B?R3R3TzYwY3lIV1JBcmo3U1NUcVQ0cVhRWHZBTW5uakZUOEZLYVMwa29IMjh6?=
 =?utf-8?B?dzYvdU9PREhXYmNETU0zTnRnS0JMR09sNlJjM1JWQld0S1FibG9IOHZPdmxO?=
 =?utf-8?B?L0JzNjVhZDd5MzZKUjhYai95WU5DTlNvUjFrc1l1K1FMQ0kyanZpOGFRN282?=
 =?utf-8?B?b1JUMzZVQ3NZSHpPVmNLMWczWnVWWmhjSmtGSjU0ZThhLzlYSjBWOElqY1Vn?=
 =?utf-8?B?RUl3aVNqSzRyMU11UE9EUVF0cXdIamJCd1dXd2Y3SmpLekV6TVZJS01FbEdC?=
 =?utf-8?B?R2ZwRUVLSUFaMWxnelVvblp2d052OXBYM3B3Slp3THYzZ0NYMTF2V3F1MkFo?=
 =?utf-8?B?RDhyK1R1ZEhQM1BvaTFUa2F3NnFTY1hnV1NzTDZTNEFINHBXakZCQm1KS29V?=
 =?utf-8?B?NkVCbjRRcTR1ZnFsOUE5M29tWDZnTkRkdkNPOGdjanVmbUF2VmI5Y2pONHl3?=
 =?utf-8?B?TW9JUEFvZXNoS2xtTm1LNWxLYkx5dWh2NmY2cURyNWUwdjM3Q0F6Q0ZHZDdm?=
 =?utf-8?B?SW5JTGhiSFd2cEk0ZWhhcGszVHQ2YUNHcE95ejVxZ1Q0WEIzRG1wWnJNMlRD?=
 =?utf-8?B?UzAwcGdldVBYS0N1SG0yMVdWeWJ1UUV4bFlMc2w4enRFT2RaMlptb2xrSHow?=
 =?utf-8?B?ei80T3NGRG9pOXFzVFpSZExyUXJBY1dMdkwxNWtOVlROUzdtQ2NCMDhoUHFP?=
 =?utf-8?B?Nm9RaU9DYmthQ0lSZkdxV0RVV1RtTVZsTnlUbDN2Qy9FRmlDVEdESXlEQzk5?=
 =?utf-8?B?ZjRlUnJWdG9QeTVLZ3poU04xcE4vZnZkT1hXbzg2RVpTNjJRSEdmVTNndG9j?=
 =?utf-8?B?OFpOTzM1ZHRqeEIzejhUUStwRUYrK2w4OVdwTmVxdHEwazl3N1lJKzZsRnNQ?=
 =?utf-8?B?SStSRjVtVmw0TG44YU9NdHROWWg1Vm9RSkNpYzRXUmtJQVVESEhIYWFUeElv?=
 =?utf-8?B?M2prYndSTE9Selp0NnVSbnE4Y0dFdDhHZWlOaEd1SzBnN3gvMEh1RnB2alBE?=
 =?utf-8?B?Y2dwOG12UHVQWmtidjNtd0FCSEpyRG4zNk1hVjBtT1dVYWJuT1JXSkZvV2dz?=
 =?utf-8?B?eFA5eXhIb2kxS3daT0s4Y3RVNS9SYzNpVjFodkwzaXZjbjhpK2tDT053MHBs?=
 =?utf-8?B?YnNRcnlJaUg1dWlmcHFlM1hmMHp6enJ5NVpiQzB3TG04TUVuVFV6NzYxV3d0?=
 =?utf-8?B?NWdFVGtmWmtKRzlNZ2VDKzNQNDhncm9IZG5Bd0dJaXM5U0RnMmEyWXhrOVV2?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0123e62b-c3ef-4dbe-75ae-08da6f5efc3a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 23:31:37.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkxT0vvuYbbA0d9A+baZevCP+EUoo7tuHTlT4EFGQ9sNvVrOhkTDwWFj0cM6fD8e0SyotLKiBYB3WTj0hg6v/RI9WaeY78vGYEhHqplQfMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260089
X-Proofpoint-GUID: Ul6hWfnwxE-yWm59F8N7TnJNRPUNyOHC
X-Proofpoint-ORIG-GUID: Ul6hWfnwxE-yWm59F8N7TnJNRPUNyOHC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/22 8:56 AM, Jane Malalane wrote:
>   
> +/* Setup per-vCPU vector-type callbacks and trick toolstack to think
> + * we are enlightened. If this setup is unavailable, fallback to the
> + * global vector-type callback. */


Comment style.


> +static __init void xen_init_setup_upcall_vector(void)
> +{
> +	unsigned int cpu = 0;


Unnecessary variable.


> +
> +	if (!xen_have_vector_callback)
> +		return;
> +
> +	if ((cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_UPCALL_VECTOR) &&
> +	    !xen_set_upcall_vector(cpu) && !xen_set_callback_via(1))
> +		xen_percpu_upcall = true;
> +	else if (xen_feature(XENFEAT_hvm_callback_vector))
> +		xen_setup_callback_vector();
> +	else
> +		xen_have_vector_callback = false;
> +}
> +
> +int xen_set_upcall_vector(unsigned int cpu)
> +{
> +	int rc;
> +	xen_hvm_evtchn_upcall_vector_t op = {
> +		.vector = HYPERVISOR_CALLBACK_VECTOR,
> +		.vcpu = per_cpu(xen_vcpu_id, cpu),
> +	};
> +
> +	rc = HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op);
> +	if (rc)
> +		return rc;
> +
> +	if (!cpu)


A comment (e.g. "Let toolstack know that we are enlightened." or something along these lines) would be useful here.


-boris


> +		rc = xen_set_callback_via(1);
> +
