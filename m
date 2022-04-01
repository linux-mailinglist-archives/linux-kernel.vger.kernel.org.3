Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778694EF9F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351270AbiDASht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351259AbiDAShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:37:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911D1E1131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:35:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FiZXD014831;
        Fri, 1 Apr 2022 18:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AjHeRq5wVgOYs1Bw5mMPGUS7Oqa1BZQ/voOeweOKezI=;
 b=DBrMxwWt1V6Sz6bYJNkJA4inJrcEn8mc4dSoXxYPV9T8ph9GuPKwzLQoBxKY9HHSMpmK
 EbBL3fQyOn79CKM23U1mNQfz3BeSADv9mEJO9Xk2Z8lLlc/b2OnmIHOraMNlQXtQkR3e
 gSX02MH9lnhsotfo9JXJ5IFtTbYSk6WT6gSgsHeYvHnmnp6ScaMgoVWgStirWPccghWq
 49fymt3iilhv6zR1tXzyjCab2o9lVbE/G3/cYZ6Igd1rtwRvku0T1FG9SQq/UpgW6tqo
 e5FSHIqFzW6DDq0+8E5WOC6YQS/bazPqZX+t6f8XE5bP/MiM0EAb+W0PLszAiVvflXH+ 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2qucx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:35:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IVOkH026435;
        Fri, 1 Apr 2022 18:35:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s969399-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg5u66THz7eKNsqnsmTjbORmPfEi4ClkWzkrq+ZPGyrPddCA3BQaD8rfaGRIUzeYG6pmR58bZaYWFIgEQL+NvDSq21XOhG3i6Mxm5sYK3soDl5f3RUVlm3H1NEa66DtuT6yK7pBaFL6fHEFnAv2/YkHDk3TM6OePdPWzNxUV70KqS9JVK2cWSpWg0+MDd5Nk9JPh4mzuPep7/B342xnlFuqp7LXHxstmgQwFvDNWq1jbMrqCsDykTjhshmfR4ZNAZCsT5Qu9QMmSsb+Q5IPY52oJG9+oywe5g2yKyggIiT8tpX48rUXRT3FkKhJGD+sUse+yqKn0KTXqGfA/uear0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjHeRq5wVgOYs1Bw5mMPGUS7Oqa1BZQ/voOeweOKezI=;
 b=KWJnrwgBVLkqqgcCquShCTEFtIokLLyD3oBSn9JOogQUPmjuFIItBPBnW2qhjZ23o46rOkHy2cIJO7a5YkSmxpqPS9llugF/fkgCTvPwWh4fn8P2DS3LiXf2FQDg/B2ObFrBMsh+CsggBCj13bS2kK+Q7XbyvRrNr69sRnN7f1RhUeoPP0Na9K7P7x/NbS8/LuVows0IS1nhj3o06e8K4Am0u/aBSTgiH5KmA2GwU9cExcRfkqrFBubQgFXoNvzE50gTv5koHz5DEPSdY6MQqSNHQiLJU1gUMFq0uF63myy80tsntePNm6UBPdLlRMzlB1FCSuqyh0EnHBrPWxRNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjHeRq5wVgOYs1Bw5mMPGUS7Oqa1BZQ/voOeweOKezI=;
 b=pNmyvD2+8GASFmpa/As6o+xfbbuKH0JtHryybkkOuvpQqZ5eL+2lBKd7L1T7wh4CEXj0tQk1fFDk6xz9tAkdjuK2X/0N6bi1k9iGP9NXqGVB5dMzE6CQJC2EFoNzNxg8xDsecMmDmnV1ulplMaZMd7jGXJ5uabzjTZcO9lHSvB4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN6PR10MB2782.namprd10.prod.outlook.com (2603:10b6:805:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:35:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:35:32 +0000
Message-ID: <bc5ec4a0-a33c-1ca1-c66d-635f4e0b9731@oracle.com>
Date:   Fri, 1 Apr 2022 13:35:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 8/8] x86/crash: Add x86 crash hotplug support for
 kexec_load
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
 <20220303162725.49640-9-eric.devolder@oracle.com>
 <YkWMFzxJpkiTjKvL@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YkWMFzxJpkiTjKvL@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c032b0-e741-4c80-f5ec-08da140e6751
X-MS-TrafficTypeDiagnostic: SN6PR10MB2782:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB27827CBB6F40947CBFC3A5DD97E09@SN6PR10MB2782.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/w1Qk8/MXiH6vPAAmu0NoOUamXpzSRT9Ph9nngEn4UUr4FoffWhoIJxFVv89UJYotGFSUp6DdUHuepr93zim4BMwjVpBx1KH0WjELzdTxtxkZkOQzAAl19oeoN/xWmDVX2Xq7iQrRrmguy9PN+KCWGWBvprE5tN1BOsqqfMsWQKRBZiywnr1cbemhfgrfAj469LfZmSUhEk6ZG1yDGsRBbLLpa3J3xf0W2nT1+Gsj2jqTFD5esTKVwA7zB10P54XuqC+khwW+UwzrKEXbxIKAUkA19BPBVB3yOOVQLbVabCD+e4P/vJe2dHHjKXvUG87pJsLd3jf402p7eIY0uhaS1actkVuWC49+JdGRSCQcEagt8FGfRSAsRet5JSJod4oSY8S3pUT5anhmCxyyB2u+wMgm/2Qe3qqPegqYQk6pNP8wM8i3jFaIoE1L4hzx1novXZEp+WAX6seBn511+zBT5bR9In6oBpZ04CsXcINq67cA0+HOv4JgECC87C09ixkNGFw2Ud402BhDQTALQCIv+GTDu4jK2iyAYvpGJxrn30uBxy+pby7pO4ybK5AHFg7ZBdgefJ3/PnMAn/C7ctdnuEzjuAyQRwlu++/YKYf0XvzK73D3GDujrcpH+kWAehl4LAC9cFF0WmJnp0bKqqM8oNBZnuv5tzNUzNZwcY7JwSjld1tr36/dIQT3AdLeQGi+krVqjRJloQCi+K0sVS6tSbvIuD6KbAZrruX+slEP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(6666004)(31686004)(6506007)(4326008)(2906002)(53546011)(6512007)(36756003)(7416002)(107886003)(8936002)(38100700002)(508600001)(66556008)(66476007)(66946007)(6916009)(316002)(8676002)(5660300002)(31696002)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRWQmwzSW13T0VabVJXTldyS3J2WXltMGlPTmxBc0tUeVpJbW9MTVd4a1Fn?=
 =?utf-8?B?R0w0VXEvcFZJUTFCRjRBRUNidmQ3eHdwRjhUVUN5V3hnZU1yVDBBaFR1bGU5?=
 =?utf-8?B?dDgwUlg4bFozRERuei9HdGFjdXFsdUc4N0M3Vml0aVVJR3hsNUFHODZGd1M0?=
 =?utf-8?B?RFl0eldzUjROd0NoSGEzMzl4ZmxZaFp5TTFlckt0TnBpd2JzZDVSWHhDbHBM?=
 =?utf-8?B?a2lGQXNjbk9nU09nSXJrMVEyaVB3bzFDM1pIdnZsQlR4MjNXZ3Q5ZFNSWUpL?=
 =?utf-8?B?b0loeFdrd2MvUU1aYy9qUnkrS291YUZzR2FOWnc2bGNRVzE2YURGR0JwYjEx?=
 =?utf-8?B?U1BlZTFYdlZGVTdreXpGNFhzWDRIbFJLak4ybzJhNlhDZTRYbWFmQjVmbTVM?=
 =?utf-8?B?UTRtT1RwWUVtRGpaSVhQUGdJMWNpcGlVVFhCaWh4UDNYN09neE81M1FpRWlB?=
 =?utf-8?B?Tkx3Y1RhVWZLV200Vkp6TW1iV3JEdzZzWFBuc0VIUmNBWC9uL2NQdGQyWDFx?=
 =?utf-8?B?QkJKSTl3Ri9oV1JkcGZUVWlzdmFGd2x4QktVYTF4RWRwbm1jTldDQVRtbEJM?=
 =?utf-8?B?WmhuNDJ4a3dhOFJRejh4K0wyc2tVSmhBYnBaN25DaHpMNVBqN2ZMZE1zOGlv?=
 =?utf-8?B?ejRBdlZ3dC9icVgvbWZxaGl5ZW9SbzU1QjhzYVRHOFBiSU9jbzRRNVJ3L1gr?=
 =?utf-8?B?eDNRQ0dOOFdPcVUzeHYwaGRKUUJIejZDWXdsRTJMbUV1S04vTm56alVKNEJH?=
 =?utf-8?B?Zko5MENnR21UaUVZRjV5ekR5ZkJlcTRqR3dMcVEzOUdiYWhxWitjcXNHVkZG?=
 =?utf-8?B?WFdoazRVTU5ZWVNwTXRINUZSM2FQUWFrdmV4UG9HczFqWHY4a1JDT2hGRlh2?=
 =?utf-8?B?c0J5NGNWSlFFNU5MTlkyN2h2Uks0Q21yZ1JMb0ZXeGdhemI3TVdhZzgxTzB1?=
 =?utf-8?B?VC9VYTl6bjY2ajJiVm4zTTJVM0MzZWVwTW80bjFVWkd0MkErcm10NXRkOU5X?=
 =?utf-8?B?YW5MdXVBL1h6dUJFTCtLWDd1TmZaOTVNTWxiOENEMXd3M1hjNmpLVGRFR3Vi?=
 =?utf-8?B?SWJ3YkpYVEtjcVJMT2FzRkY1S3BXRmtkYnBiMVcrcFE0eXc0NDlwdVFhTklU?=
 =?utf-8?B?d1NtdVFISG1xYmMyK21DVUYyT2hxOXUxVTNtTFBBeWlpbngrTmFpbFNZdXEx?=
 =?utf-8?B?YW9rQmZpeXFwSjNJNHJ3bU9SM3BySWtTT3REa1pxK2lYYzJFSEpPK3I4UTRv?=
 =?utf-8?B?M1ErRS9hMWp5TUdoL3dpeGowSVIrZ093WTZrRnIzRjN3Zmo2VjVmOW9XWWJ1?=
 =?utf-8?B?TERuT3o3dkh2WXg5clgrT2JFbTA5YVZvUjBTTEdtR2tVZm85eEFOeHpralMy?=
 =?utf-8?B?MnpuUHFwTGxLQ1RZU3doUzNwWHhzenA5Rml1T2FPanpVdmRBajBGb0VuZC9E?=
 =?utf-8?B?KzVXb1NEMStzcEM4dFZSRFlIb0graWE2eEVla0FpTTZSNmxtK1ZHaGVaNDRF?=
 =?utf-8?B?Rkk5cmY0bkVvVys1QUUzK0FCOW1kREMrRWNUbmE2R3ZCbk9wTDFlb2FpRnll?=
 =?utf-8?B?d0k4STBqc0wyK3dnOGluZTYzOVcyNFNsMGhlZkJMdFd5T3BNNjJlbkc3b1h3?=
 =?utf-8?B?V1d3MWdGNDk2RkF5SmFzQWFnbVc1dUM2MjZvSWdTNDdCbW80MDJUZytGT3dK?=
 =?utf-8?B?Y3R0cXlHb3NEY0RmMk55S0tFSm53SUFkVnk2aUNiNUNDZE4rSy9CWGZ6QUpj?=
 =?utf-8?B?YWJZNXNJV0w3RkJLeVB4RnRpYVpHMWpGajZqcFhDbU04cW1GRy9uUXFiWGdM?=
 =?utf-8?B?b3h3akFmcVlCMU5HUHluSEU0WWhkWGUxREF2Mzg5bzlzSTVyMWVQR3ZrMFBP?=
 =?utf-8?B?UU1CMVg4OVJJL3NUK3JqUXcwdnNWdXNPaURYeFk5NHJRaUptd0lqK2NwbkFC?=
 =?utf-8?B?U21QVkIxZFZTZ09reHNVZG12MFNMZklQd2hYeGo1elFnWGgwbTR1Q3I5Wmpu?=
 =?utf-8?B?NExZUy9YREt4NGpMWllvY2dKZmt3TERSa1JLbjBIelk2RWpMOXFiQTYycXZt?=
 =?utf-8?B?MDVHQWI3RzNlMlV2ZWZSNE9hQkdIYU5PWHJ3MXUzYzVydXhUWnZxWDJJUWsy?=
 =?utf-8?B?U0xKZmFUaS9XdldmK2ViWVlwTEVNWndCRTFjQ3o2ZWZCR0gzRnQ3U0RJeTJ1?=
 =?utf-8?B?aFltZWtOa3lZVHhpcEVsT2pOYml2MmVBYUhtMlBRTnhGaGs5MzRzeUhMNnFZ?=
 =?utf-8?B?UFZZQ0EwUWoxTzg3ZEhBYkEzWUVHdWl0eVhTTzM3TGd4aW5lSk5EUGRNeUNV?=
 =?utf-8?B?aytxN0c1MW52VTlVMENJY1ZIc2w5SG5ha1d4WjY1Nm1sVGtIRWh6bjdyWnhZ?=
 =?utf-8?Q?eRX2daN4QMUWuWORtIbd5stl+weP6mPvOmGv0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c032b0-e741-4c80-f5ec-08da140e6751
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:35:32.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BvS8TG4CdccstvB+5ItAJYL+PKAG48h4Zxdz8YL++PbqmHZ409KmGpJS6tJajaTillSZpvcK/cK1edYXpvP7eml2mD+7Z8IHmE6FcHcJyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2782
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010088
X-Proofpoint-ORIG-GUID: BQp9-j8UK9N-CVzJBdMB1yGJEu57d5nj
X-Proofpoint-GUID: BQp9-j8UK9N-CVzJBdMB1yGJEu57d5nj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 06:10, Baoquan He wrote:
> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>> For kexec_file_load support, the loading of the crash kernel occurs
>> entirely within the kernel, and as such the elfcorehdr is readily
>> identified (so that it can be modified upon hotplug events).
>>
>> This change enables support for kexec_load by identifying the
>> elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
>> not already been identified.
>>
>> In general, support for kexec_load requires corresponding changes
>> to the userspace kexec-tools utility. It is the responsibility of
>> the userspace kexec utility to ensure that:
>>   - the elfcorehdr segment is sufficiently large enough to accommodate
>>     hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>>   - provides a purgatory that excludes the elfcorehdr from its list of
>>     run-time segments to check.
>> These changes to the userspace kexec utility are available, but not
>> yet accepted upstream.
> 
> These backgroud information should be put in cover letter, or in patch
> where they won't be grabbed into the final commit log.
Removed.

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
> Here, if you want to put some status or backgroud information and expect
> they are not got into log, this is a appropriate place.
> 
> 
>>   arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 5da30e2bc780..45cc6e3af63e 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -486,6 +486,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
>>   	void *elfbuf = NULL;
>>   	unsigned long mem, memsz;
>>   
>> +	/*
>> +	 * When the struct kimage is alloced, it is wiped to zero, so
>> +	 * the elf_index_valid defaults to false. It is set on the
>> +	 * kexec_file_load path, or here for kexec_load.
> 
>           I would make the last line as:
> 	 kexec_file_load path, or here for kexec_load if not already
>           identified..
done

> 
>> +	 */
>> +	if (!image->elf_index_valid) {
>> +		unsigned int n;
>> +
>> +		for (n = 0; n < image->nr_segments; n++) {
>> +			mem = image->segment[n].mem;
>> +			memsz = image->segment[n].memsz;
>> +			ptr = map_crash_pages(mem, memsz);
>> +			if (ptr) {
>> +				/* The segment containing elfcorehdr */
>> +				if ((ptr[0] == 0x7F) &&
>> +					(ptr[1] == 'E') &&
>> +					(ptr[2] == 'L') &&
>> +					(ptr[3] == 'F')) {
> 
> Can it be like memcmp(ptr, ELFMAG, SELFMAG) as we have done in
> parse_crash_elf_headers()? With that, one line is taken.
done

> 
>> +					image->elf_index = (int)n;
>> +					image->elf_index_valid = true;
>> +				}
>> +			}
>> +			unmap_crash_pages((void **)&ptr);
>> +		}
>> +	}
>> +
>>   	/* Must have valid elfcorehdr index */
>>   	if (!image->elf_index_valid) {
>>   		pr_err("crash hp: unable to locate elfcorehdr segment");
>> -- 
>> 2.27.0
>>
> 
