Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4553B02B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiFAVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiFAVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:23:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077AC113FA2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:23:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251K404O028726;
        Wed, 1 Jun 2022 21:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FT79HAU16+hfEc18DlaVkdlUeVxncDZcnM/SfMJjAjU=;
 b=cQmTWwp0P3ugzD//bGQEf9rJFIqMRJ/U50FJeGw8pi6e+PU+j4+odh8Ny9/juZ8InGQR
 LL0zIFCBfrGhu15rJplxpVaiiLR8xnfQCnlBcAS9DqMrqrOagfxAI24iOubb9gGWSFiM
 FwP6OBU9g2M4TQo+QB/1qe+lpu7F5HmeoogwM63CO4x6foj5R7Ls/r/ZDsud7B9/4tcM
 9Fgm9ZeuGQl4m7p/4JUJzegyrj1Te0Rj7clOm2WQR/fODw2WO9zxVvae1kw6B4tJgcW/
 pm8LP5PFuW3ADDi0qrCUNh0jgprYGTUzH1okPXP0vWVLNbEdrFuETgF0RCrKsQzkCvDj Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xrxtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 21:21:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251KtpOK009729;
        Wed, 1 Jun 2022 21:21:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8khegkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 21:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu/vcd1CHT7uPQIYbMB+A1iGeDqqtk7+fLUfpTv6N/GscxTsPH4VRZwU0Q4oMc+RZ75T3byLCIxuYHU7rCzeyPM9iyfTS4DcHk8x5i3BjXAwuvK60vUMLZTTOKugYWTWnWqudJEwr45xq8qWS30kg+OGf2ZY+hAzaSa4LDc0b7DzSaKvPrq3XWXbysY3rPHANhzXkrV2NM5IeYiQB+rBWISh/6JNAu0N7ByhLLM/Y+Rg8upT8k1xrWDwMXNU1GLhdkA8C5mkZEc1fAtZV5O+j/iuF+9EN7wUb7vBbPZGkk8D5Nxbmcz+zaq8P3SYEhVvpCIFcudEB+bmmJwToK9AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT79HAU16+hfEc18DlaVkdlUeVxncDZcnM/SfMJjAjU=;
 b=nxypiE71idCaOFhz8+AqrKnr5lneOPIyCPu1XMg6ZqSbtfXmcBNTSGpauhyW4AxDoJA/AtZjcuzcTVhlOxPS/Zx+0oMSE602XH7QFcxAp93td+aTnH4bFEVeR42FB3/DR3YvTxsnRI5IfyjrrnVEgA7ayQffRn8LsKDn01jaASDszHRsjwC2WR1E/Fq7kcFCK1E9zTB30v59sTTINI2UhK7WVIZdbDdRFL3eTavX04bCZTBfA4oF13jIF2XnTQgMId5pqLLOWQQVFtaJTtNoFXRbBLNrh9/oMvo97HRVSPiDxntMj4uEMq2NvXgJbdZFEY1VPsZJ4ddw/KBnslgpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT79HAU16+hfEc18DlaVkdlUeVxncDZcnM/SfMJjAjU=;
 b=D0LULfLnyYm69LlMusNHaADLiFejkD6GQzL9NbGuJat2+s/rXWwafOFP4uIqvN+Ar1MiETbMGnd8+P4C3BRIuOgmZfkkbLOU8hQWX6hA0nHfgP6k2FsfzuzrPGtRu75BoZVh4YKdTxOlf23yosYUnMbXRsF0q2F9ij8CK1EVnrs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5216.namprd10.prod.outlook.com (2603:10b6:5:38e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Wed, 1 Jun 2022 21:21:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 21:21:20 +0000
Message-ID: <1c315745-3456-6f8f-ed36-39b02ed86044@oracle.com>
Date:   Wed, 1 Jun 2022 16:21:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH V9 0/8] Use copy_process in vhost layer
Content-Language: en-US
From:   michael.christie@oracle.com
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220512214704.104472-1-michael.christie@oracle.com>
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67af4109-1760-4652-d752-08da4414ab8e
X-MS-TrafficTypeDiagnostic: DS7PR10MB5216:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB52166FC7763820E1AD7EDA91F1DF9@DS7PR10MB5216.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHgM/2YVXz3qkzOPN273ssBfbd3AEQqLmgGI20ps0cYtosGbTxPnXz7Ct0n/B0oymCfOPPjwYqRept+Qwrkglvs+J8neDqut3Kt88Y1FWRLr9hbhxl0P197EB3n5hAo4UIStGeBYwK55lVYYezdPZcrEHAAwbjC7faFE1a0SyWCnniOsLSBW1tUX/yiEYC9oZUWb52cTiwLiqxq5otp2s/WIZp4kbKLbQgbXMoS/q1EvytDn0i60Hfeap9jpzpBrleVpKUKzTRdCqnfGRIF/vdyk+/dlOG0jZ45ejv0chMyYyA11t2cUKRH3P6eIA0FfZRptBy/Q0UmGEfmt6EjfSQX0BzAdezi0ZbCguoiVTURiwe5hiJe1eCj8PqM7uPHnsuTuAQttyZ5BJV3W4Bu7Sei7xzrJXo7jJ0ISTd5gUcQahBcPjvH1XcRvBKtLsc23hUxLLpB5NjrFDbbkHiqBs+924E/4JSmaYP3AR4v+OetJrSF+Qk6N6oxsUkIVrFur5y4RwN58XZSTJjyUtIKM2Az46IDLQl0TeHl5BUgPACCmHHHRlkB1ZzUfh8sKsQkubtYdDxgQsziM1uQH1T3yDE/qhaKk775OI2iqns6Ps7lNdm5b85zn/CAyNy3SoYU36ZOS6jzYih/1pK1w7ycIhtrOZV5MO9r+A7d48oSkptZYt2iJXywGmpvrIiZmDEroCWu/KTyPK0I4Woy5/fLs6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66946007)(66556008)(4744005)(38100700002)(36756003)(508600001)(31686004)(5660300002)(8936002)(2906002)(316002)(26005)(6666004)(8676002)(9686003)(6512007)(66476007)(6486002)(83380400001)(86362001)(31696002)(186003)(53546011)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJ5VmwyOGhTd3VDWE1ZUi9VeUxMNFhnVG9GSDA0b2VjYXNiVFpudFlqWkc0?=
 =?utf-8?B?WjNDSUl1a1cwZFJ5OFhMaEdMbHdkYU56ZmJ0ZHFWZ2pnN09SSjRiQ1NNd21Y?=
 =?utf-8?B?dnlyWjBhVzRkVnp1NXE1YitZSDN4bUVOUVFMaTB2N1pJeUJ4ODh1bTRGU24y?=
 =?utf-8?B?Nlo3cmlEdTNjSXIvNy8xK1E2SEpvUjFOYjBFVGhCanF2c1RWeEg4NzFXQUlI?=
 =?utf-8?B?WE0wOTAxWTNnVktDcG9Jak5XcXFlSnZjeE14bGtPeE1EWUZqQXc2SU90blUy?=
 =?utf-8?B?QlFxTDFsT0pQMWxYcEN2T0xnMTJJWjVIazQ2S3pFQWpuTjl6OTZJZUtPZ1Vu?=
 =?utf-8?B?N0NyRDlYUXVlbTdHWHBOTVE1Vzk1S2JGZ1BaY1krN0pabWRTemhBVU9aT01s?=
 =?utf-8?B?aUdzbVVSR1pCbDdncG43dWtmWTNaRnI4UFVNUGJLREp6QnNmdmVKU1pySmV5?=
 =?utf-8?B?aFVyOWFJLzBSOVNhVWhnWHlhRG9ETG9RcW16RTE5cXBBc3pUSmFxTDU5N3ly?=
 =?utf-8?B?K05XR3dpd0tyU1JlYVh6SURLQmRQWHVrSExqSHU1Vlp4dkw0aWtvUWtxWWdu?=
 =?utf-8?B?Nkhzb0tSQ0s0Y1Vldk00VCtwK1J0dFNlaGVrUCt1c0FMZDcrSXRUY0RjbVY3?=
 =?utf-8?B?NnBHem9na3FOcXM0QlVRN2hmNDNoMUJlM1czUkQrOERDams4SGx5OFRHWU8v?=
 =?utf-8?B?NmxxYzRQdHZtamxLbUNSL2FHUU5WeVNXUTdNcDAwZVRUYTgwV2pnZmFPRXov?=
 =?utf-8?B?Y0JFQk1haGdHZWxQaGFWYnV1bTlxMTB2MEVHTTB2NkNDUlJnRm5HS3F0dHV5?=
 =?utf-8?B?QVQrdFhlNTlwTmw1cWhWUllLTnVUVXlPODhWelJNemJxMDkwU3J4ZkdkbXBI?=
 =?utf-8?B?d1VnQWFYaXdqaFRPRGhKamxkUE4vdDIrTktGOWVvODRoYlNUR3lpV0I5OVR5?=
 =?utf-8?B?cElySnd0aTdJbWpyc0Jmb1BLcXB4SDlwck5MZElNQ09IL0N2alZqMmZMc1FS?=
 =?utf-8?B?MEd4Qm5xdzBNaHpaTHJ2OGtzY1dCOUdCelBsNWhLS0xjOVBjRGFXYzhEYkFl?=
 =?utf-8?B?anVFaEFtYTN1Zkt1RmJmZTdzNnBvTVRSUk9JdnNkL0lzYmRyMitNNUFxMEsy?=
 =?utf-8?B?Yk9KODhPdW91VkU5M0ZwTVJyU0N5a0ZtdjZybXNJTUNNL2dLZ0Q3TW13cHNi?=
 =?utf-8?B?ZVJ5UmR6WEl6NmNEQ29VaXo3UXp6L0tMd2xTZk5EakZPa3oySHFxN2F5Vndx?=
 =?utf-8?B?UVhLYzQ3eHRHaG4zb2dBbUFTZWdJVDJaWnhHc2Nza041cm9ONU9LRUNoSHlP?=
 =?utf-8?B?S21tNmcxK1FwTUNMWUU3NG1TbzdPZk04TVNGakF6cGpqSkV0cC9XWm41V0Js?=
 =?utf-8?B?WFJQa3dtamdUbk9QN29hUHlTNGd0NWpzZ3lnSG51ckpYV0lDTG5vcjd2NE1G?=
 =?utf-8?B?REZvb0J1WDlVMmRRbzJmT1BSMzFGdXVnN3JSV0d1djBKZWhnMmptb0ZRc0Jz?=
 =?utf-8?B?QUJqNTJPZVJzOXFybUE4dEJXSlpTM2Rock84YXR4OHZGZnBIcnFSVExRRmtN?=
 =?utf-8?B?bTd6OURzRUR2ZnJFNlV2MWU4NzA0QklIaldFelV5M0MyL2ZidEhVdllOWEZm?=
 =?utf-8?B?ZUUzbDkzcWNlVTFaL3ZIeTVYT3ZOL1ZUbUozUVR1Z0JKcDE0aHgwM1V5Si95?=
 =?utf-8?B?dnBDekdlNlVsejVhby9KRnorNTdBRjk2WHBaUGxRL3RjYndHM3NkVUJlNmVF?=
 =?utf-8?B?RWNzUGh0Y2QxY2hMMjM4YzBBdHdlcU9CTVN0ZjNaRDM4TUxLb1lvUVhqcVZi?=
 =?utf-8?B?ZytCOVVJbWJpRk05TkVzSnNXYjFkTERFUTlFNVgxRzNLY0x1cW03RDN6OEdB?=
 =?utf-8?B?NHZaaExiK3Z4Z1VobEpZUTQwTXI5SXBRamlwN0hpRWxWZmVlTWh4a2dIT09u?=
 =?utf-8?B?SFNxWHJmYjI5K0ZSUUIrd1hNQVFudzJBVWljTHRLVm9PRjVSeE43bkVsNzdw?=
 =?utf-8?B?KzVtTDlKUTFlTFVOYWJGMFdRSjBrVXV2Q2NQR0pIaHY1czdZaS9mMDVhblZB?=
 =?utf-8?B?S3RJZ2ZVRGpBM3JhVHg2V2FrdUsycUsrVERjd1JoWExSamZSR3IwUEVGQkp1?=
 =?utf-8?B?LzB0NTJXSmNWUStjZmdlUGZDOXovaVJDUWtiVUpoSi9WYlhTcG9jUllRTk9l?=
 =?utf-8?B?RmF4YlpLdlhMWDk1clZHSjBqMVRlbjZTb1FXbmZpNzhBTVY4NHA1RUZCWkNS?=
 =?utf-8?B?dDJ6bWpRMStDRUhNNDNFUFV6QlVRV2d3dHl1cTlZWm8yRDZDRDB2cVpjUWd6?=
 =?utf-8?B?QzI2M3B1UGN4WDJaQXNQUkhYR1pYNmR1SWxMN1d6SlR4bFBxNWNoSE02Tzc0?=
 =?utf-8?Q?jUBe7WRSM26VTAXQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af4109-1760-4652-d752-08da4414ab8e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 21:21:19.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdQSwSkXZMAiLgzg8P+Q0X8d1FWu/Hjb93f0+Pir1cJLUrX+2lfnnfA5jubyOMresQCgh/FC6xPhY/EYfMSG/UTxMC5NFDLEU4NSQBtMiGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5216
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_08:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206010084
X-Proofpoint-GUID: J7tDdTCu0izz8hiA3JiUUkjv4LJunMlB
X-Proofpoint-ORIG-GUID: J7tDdTCu0izz8hiA3JiUUkjv4LJunMlB
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 4:46 PM, Mike Christie wrote:
> The following patches were made over Eric's tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
> 
> and his kthread-cleanups-for-v5.19 branch.

Hi Eric,

Did you have more review comments for the patches or are you ok with them
now? I haven't seen any comments the last couple of postings. I've
been watching your trees, so I know you are doing cleanup/improvements
in the areas I needed help with so I know it's still on your radar, but
now I'm worried I'm missing emails/reviews from you :)

Are you also going to push the kthread-cleanups for 5.19 still or is that
going to be 5.20? I have patches that depend and/or have conflicts with
this set so I'm trying to figure out what I should be rebasing and testing
against.
