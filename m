Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24D505F99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiDRWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiDRWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:07:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9B21E07
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:04:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23IIoWCY015013;
        Mon, 18 Apr 2022 22:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BI5kj1o+nG44BUrxXVy4A2uEcBh5VkIxjbjjpI+FP4I=;
 b=lK5306guNitzU64PVVUICYwj5B9twvLICq+zFx+FMAFU3S75TWtWXsRee3LaJbH1Etze
 247sb9M5Sgr8g9Jx/7KApnITLfYMNs+hslII3l7vPX4WhJCq+mnnpoHIqGGMOrIDkOza
 Fwp2XXOp5gEPiHZ0VBk517oJYJvCarifNgxtoRiC9Ycx3hggkGiBzWypG64aLBVHVJbj
 zeyZ1nwm/L1oGz/ebc7kv2Ho/o37gZaNUh/odtpI3iLjXtm+d55yApLy3VmPlx2+K7pC
 mj5qeTuSh6fqYYnqk1wiMZR/ucfTSJKTHnXh9AsXOLTudnmmXW8GqfwUOKPx6RJS7BGY cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtce3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 22:03:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23IM2eR2001920;
        Mon, 18 Apr 2022 22:03:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm87xa5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 22:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIB1/U5rGapKNR5QJg/4znra0Zh0APppy43j4ZysfCmzgKkwDPIv9TAyflpLdlxaEvzul4mg7s3VeeuF0pq7EKC49afD7G3FcjqOqBCx2XlMH2OPOp4AVcF3SoTH6E+DQY/xA44h0Dizfbx/bVB32ExcrOtDybC4OUlyA7XRfwUAuHMk5v3nZ1i6W68T8Gt/7jMm2i10y3W5MbxHSpRyGEuTrCaPFbigo6oi861Ypemaw/VPxqqHm1YlhAA58OnoRGgxwFJlg80BoCt0Jj7LeddHKx+w89lIv0Emcsgby2ItgI6PZRyfoaBnTVZfV2HQej+udLXHOmzoejjEcQRaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI5kj1o+nG44BUrxXVy4A2uEcBh5VkIxjbjjpI+FP4I=;
 b=jvoomYnxaKV06DErC0a9yi/q4luvyUXR2ODIGzXM0mCHpKJt+GV1T1vZFt5psCPZxqMOetk5MHj6iq9ByCRa6PhxYUgwkCVx16qz2uNHDFjmFwuCpozpTEr79+DqCB9GExfLhqY0gQ3GaO+FFpYShMG+vnPiiFn4o1X/eEsRW8LwqGJ5yA5PmYtqlfJ6TVZZeyfb+MXYVbTiih32PNMCoA8uoWpXpR5JIV+HVBILqOGitONP6qzi1fdknPNxv+Lv4/DV5/W1aToUePhcpNMMJL/FB2kFVgP/y9U2mWIr9cvKqhw6EFdmVEGI03G2uZb0cBzRZaLM7XRSaO4y5T9Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI5kj1o+nG44BUrxXVy4A2uEcBh5VkIxjbjjpI+FP4I=;
 b=MVSuhgz2p0Emi1+XMKKQI4tu6jIGF83eMwNgBMD6xftSWuVA+sEWXOUuRcPjo1LkZYBUbOG9g69h9RQS6gVH3PnQgBFqEHv9d9cg6zxXBI8u9ZUmpPrjpE6bLV/a/TLduqOzYBcvahPTKk8AGgzqYC2IdZ47T3Bp9beOMYnAjoc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2015.namprd10.prod.outlook.com (2603:10b6:300:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 22:03:44 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:03:44 +0000
Message-ID: <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
Date:   Mon, 18 Apr 2022 17:03:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com> <Ylgot+LUDQl+G/5N@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Ylgot+LUDQl+G/5N@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc336717-82cf-4260-8d5d-08da21874e02
X-MS-TrafficTypeDiagnostic: MWHPR10MB2015:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2015A3DA2D3B2DA6D72B2F2C97F39@MWHPR10MB2015.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIMSo2FjhgtQo6TdYko9OfO8s8eNLIvP3AXSPmvEhkk9oheRdr0PcELypru/FTA81DjBUzOgm6oT0gluGU1Msmbu/iH6ZC8Q0He7BJLI6O3fIA3XC3GIQBSjTxD4AftS72uwT7wBTvgLYcJNl6XM4eRVDkt5/cFxPXoZtejrdKHYUWSghg2Y8TqhNqlzsEAzLLeFzlyBHchC+yqnQLEVvt6N5LRQQAxIOOaPn+YnHWt73C8YV/cTLpYJMsCoDnaCeUkdKANUwXG4PyIdYf2pFIHd8UK4NUxakb65GbjhWoGrnYnfuCWyXV+/pdgWUBpK6ESyTFLqeihJzHACWxf/AIpZ85ENAhd44y3yEU/oMuZYrvI7km+P3E+QKznqFSdRmp1TRIj7wZUwrn0vYp9y/MEloKIuFMpfer/tnES/APdByc9STE70pgXGkFwZKTzrX8xZPzp6BstWKJphjgHb6gxbdpo7wfnAh4ZQR/Mlj2PqIHdaLNh2Qc27QzyMm0yYOedWaob6FAyWw1SzOSbgGMpwTWlFAlUtpc9lUNXQfWsyo5U8s9HmlFW2XAaUv75z/+5ZKEI6H1H9pMuS1DNA73v+QGjgpJagdiljO57JvKRbH4mxhzR8GTqY7odhZ9cXNgtZSk2n6t+5YI93/5OWCDEUYCQJ76IM1aYZd8KrxcGc+6V9S7ByxRSSkZZQVj4Y3BB25jZmlvifhdGW8ge+RSYQfpRw2TtgzsGwPcwDj5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(31686004)(2906002)(5660300002)(36756003)(6666004)(6916009)(6506007)(6486002)(7416002)(38100700002)(107886003)(2616005)(8936002)(66946007)(83380400001)(4326008)(316002)(66476007)(66556008)(53546011)(186003)(6512007)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGE0UzNhS0dVKzE0U1VUN1k2YVJDM1lzRHZwTnd4VklaSHYvbmtwaVF2MldY?=
 =?utf-8?B?MWsrRnFGZm5pZXNpeExLSnNGcllScEYvZkprQTRla3FVVWZCcEFRY2p6U0VD?=
 =?utf-8?B?M0pFMVZaNVpMd0RVU09RVFpCOG14OVR4NWJra0pxMGlVa3ovZU5oVExvNVVx?=
 =?utf-8?B?eHRhckU4M0VITEdtWTQrRmhHQVo4Zk1iMDkyNHpxOW1UblZHay90SWtiOUYv?=
 =?utf-8?B?Vmk2ZHFsUWd4UW8wZ3NWZXZYaFN1dGVmdUhJNk9BbU4yVkpPWldnbkYveTRU?=
 =?utf-8?B?WnhxUm1USTVHRzJtdVVRZk1yTmZVaVQzQUNUTXNtS3RuT3ltMWdhRmpJLzFQ?=
 =?utf-8?B?OWtaTmJFcmNpSGhGVXJ4RDlES3k0SWh4UGtrUmRCTllCYlZ2bUpPdHUrSk9i?=
 =?utf-8?B?L3MxVUFNNVh2YXRjMURUTUw2bDIwanhrbHZadXVjNUJNWCtvUFNyUkp2UnZm?=
 =?utf-8?B?WDVmNmpveFRBd3llM21XbE1rOUlpcnhjaE5vUkh0NHZ2ZzdOQWhUMmE3NHpI?=
 =?utf-8?B?RDVrMExmV0hKNmhHWTJPMFdqaXUzOGVxNVdXTlJtRkZSRmVCcnltRTRMb2Iy?=
 =?utf-8?B?ME0rK0NBRVd5UVppMm9Lc3FqOUNDd0NqY0VnNFRJNThhN1lUNlVtWFZVelhY?=
 =?utf-8?B?MVFlY1FOQlNQL2lFQkZrNkpOakl4MkxiMHhaMHgrdUZhZ3ZWQ2kybXFDOW05?=
 =?utf-8?B?RkVieXlxcWVxQjZFMDRoZWRzUFFsYUZCOVQwRi8vNUdFYlpEalFtdjJWNXhh?=
 =?utf-8?B?cWVleGNWYjlBa3JTZW96Wml0N3JiMW84eFFTUWtwcFBkMXAyTm56eUNMVURG?=
 =?utf-8?B?Nm5pK0pJOWNENlNaaml1bDh0UERsUVNhM0FIb3JsQ09YQnZJdVpvVUV0eFdM?=
 =?utf-8?B?RDdXaThkcVhuZHNzMGxhOURaQjExOGRQTnhITDhHK2o5aFhNRmRRd2pLQWt6?=
 =?utf-8?B?elVKeUE4Q2VqeTIwd3MyUGJraVJFc3lZN3FyUDRJUCt6V2Mya3dORGVnZDlR?=
 =?utf-8?B?dkZGU3ppeG1oQ3dMSXBqQnJhSkYvR1hENVY2K2FnQm1jQ2ozbWRBUEp6Qnpv?=
 =?utf-8?B?TDJhTDg5d0FHVWZXSVVDMjZEbWZBVkJZcEIyZHVabHZRaEJlRmlDSWpQS3BH?=
 =?utf-8?B?TzVJNjhGT2N0Um9tbHA0T0t3emxneXNTQ01vQlBIeHZvRzZKTzl2T01ZeFUw?=
 =?utf-8?B?dGc5NmZVUnl5cjhxL1JPZkNURkRveWZrR3Ficnd1ZXoyZllUL1BrbVd6WnZu?=
 =?utf-8?B?VktLazJwS3E0Tk9JTkZrVmV6T0JGbTRVbjlRbnZFWWwrdmQ1VWo0K0Nnb1Nz?=
 =?utf-8?B?cXdaMEpXOXBDSFA3ODRIbGJmZ3ByeWsrYnE0bThmcTdsTWNTNEtlYjROdmp2?=
 =?utf-8?B?S0ZlSzBEeEtvNE1qM2NXcXM1a1B4eGlsdFdwWEZobmIxUy9tbFBobFhIR01w?=
 =?utf-8?B?MTJKTUVOQmQ0NnB1YkovNnNoUFNOVCt4dXU4c1p0YUt0cUNEQTkwRzVGRnRk?=
 =?utf-8?B?ZVB2a29NcG5Tck5EZzFFTDZmNTZyeEo0UUphWmpQc3VURmExR0R6dUFZdVVS?=
 =?utf-8?B?OGQ3OXE3Q3B4c0JwVEdnNU8yU1laQnNKOFhRZFh2VW5NM0huQTJVTnNBL01y?=
 =?utf-8?B?WUNGdlIrb05xbnVublJyMndMeDQ2L2w1SVZzWmRPM0RsalZnUldneG55SVlq?=
 =?utf-8?B?K3hKcVg4ZlhldFU2VkVWL1RQMXBoSDFMMndoTEZLTXRNdVoxUm83b3BEZ1Nn?=
 =?utf-8?B?Sm81WXJLeHpyanNnZ0ZCY1RVVmZROXg4cjBnUkVSMDhjb3ZESy9jdFAzUDJQ?=
 =?utf-8?B?VVNoV0VNZGZGVzFFWlVVZFpXbnBxNUxhSHplZW41VHFpeDRiUTZMYzlDZi9U?=
 =?utf-8?B?SnBZT2NScDEvTWFRTEY3Uy9aMWpsRGZUZ0FmeVdhMnpnbmlBVGhkdXFZTzdl?=
 =?utf-8?B?b29NbFU2dzdKajRyRXZWS0lKVHhZOEtFL1NqeW9DNE5rT2xKKzhvYU9Oa0Nw?=
 =?utf-8?B?NlkvdUU5dWJzZUVVZVRnT0dvY01DZG1RTnIrMndDU0NtTHB3OFR4Qmt2cmxO?=
 =?utf-8?B?ZGVhVUk0RVU0Z0dmc2pjSVpkU00vY1k5bzlUa0ZvaWk4ZGxJcU13b3hveE1V?=
 =?utf-8?B?Y0dURzdiVklMS2FCSEUxM0F4Y0xZT2RtSENzK1VLTVk1K083aFNIMkI3NDRG?=
 =?utf-8?B?Vk55c1NXOGlXNlgyOGt3Q2djMFMxUm91REVPWjBUYWhBTlhYU3RnRlpubjZE?=
 =?utf-8?B?SXYvSStHb29LLysrbTNjSUF2ajV3bHkrckk1SERYb0YzditDa2RMZjY1eDZD?=
 =?utf-8?B?N3F1UC92SWF4WjlSOVA1ZjRaMmlNa1pzSVZ2cGlHKzFmM3FoUWF5cjgvNUtJ?=
 =?utf-8?Q?IXvb1TmcMEUppPU6JufREjWTZ+81caBAaavRi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc336717-82cf-4260-8d5d-08da21874e02
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 22:03:44.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVX9hdumaRG9tLZDKVpeP6a2Zod5bHQSf7skv4vOUUlJmgVxUpZHP10RmbRR8IYYhHJv3fMDVRt1TjaD++asKFT6YDU+jIYmh0cbWhhwmTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-18_02:2022-04-15,2022-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=823 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204180123
X-Proofpoint-ORIG-GUID: 8BdspZwm4vkAGYV0N0ekoBj8hJBVCIam
X-Proofpoint-GUID: 8BdspZwm4vkAGYV0N0ekoBj8hJBVCIam
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,
Thanks for looking! I've inline comments below.
Eric

On 4/14/22 08:59, Borislav Petkov wrote:
> On Wed, Apr 13, 2022 at 12:42:31PM -0400, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
> 
> What for?
Fair point, a new define isn't necessarily needed. I've now eliminated
CONFIG_CRASH_HOTPLUG and am using CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG
instead.

> 
> Why don't you put all that new code you're adding under an
> MEMORY_HOTPLUG ifdef? It seems you would need to do that when memory
> hotplug is enabled, anyway.
I think I have done that, in patch "crash: add generic infrastructure for crash
hotplug support", I do have code under MEMORY_HOTPLUG as well as HOTPLUG_CPU.
But...

> 
> Also, looking further into your patchset, you have ugly ifdeffery.
> Instead of that, pls add stubs for the !MEMORY_HOTPLUG case so that
> everything is abstracted away in the headers.

I've examined the code with this thought in mind, and I'm not exactly sure how
this code should be restructured for !HOTPLUG stubs. I'd very much appreciate
an example in order to facilitate accommodating the request!

Thanks!
eric

> 
> Thx.
> 
