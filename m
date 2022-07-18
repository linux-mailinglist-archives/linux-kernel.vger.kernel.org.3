Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216255785F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiGRO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiGRO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:58:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57713AE6F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:58:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IErHCA010450;
        Mon, 18 Jul 2022 14:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=LxR1YqrimuIjlurdtqa0BRqQdV5wvcYSK/DWaTMfYnY=;
 b=MInCD81aXGdxZJCBhNB8jNui0EYGGjiVbGf6Axbomo+itQ/WZY0oShOjVbtHFrRtAZ6U
 LP3DSUO4D0paXoenrNdqblslgbcty5j3T8HA6TS1H69goa32C4XOR8d+fWBMUFGyBK8/
 zr0dno6RNVuFlH4nSnMmLD/ElOXihEbshXS2k2wbtaMdB1LvA/M2kiST07pynzdys5gm
 TLnYaWSfjnM6itMiLYniyBycfuAcaCLu41eMT634Pr2ppDwSv1K60ZXIVuQCBPQ8phdk
 xu1jFaEjCQZD7ogU3B4GOePWPT/39HHuy+B0PasG0PlRMP6ws05GLlxjMJMujifx3I+m hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0um66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:58:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICUmEu006386;
        Mon, 18 Jul 2022 14:58:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gfmw4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiHnxWgdUwa0wQcI2eznRYnxPlEKYD2rgBZcEnAzNG2ob8yDFtlb+dFufJYLWCKt8hq0zYIOnXPeXRYCB6YXV0+bGzqlBFvbqv0eNjXq9EPJWOzzEHoHcpW17thD/dpb39DAE8pfLl17WiZqrMb2rbVpGs6rEroIiqKXGfNdJqkP6vNu7ppCrm1p0a/GEEqhl50+wc7soJClKXjcsDz85xkNQJh0v/dimD5KB+MBOxQjV9vu3eJewppQN+Q4sg+Y6PUT9z+gY9lGG555Ps98MISMHXl/6kIUY3BHDQVvdvO8KYNE+bJJyZ9u3jjyGNmRliwZ2YAfTRFEt0ohPpggww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxR1YqrimuIjlurdtqa0BRqQdV5wvcYSK/DWaTMfYnY=;
 b=A3dayoNSaB7QxWQDAyAcn1SUH9ZR/9FELeujqYmGy8RT9tjeDiqph0qD2FyaoG9maiTYs7zzkFXFyZhEZlOpxtOk8vS8iSxxAFw4GYZC2ZlviGZ9XhGt5DejfwV5MP/6Aounkv4CoAsv4voNWYEMueNfKpMj9QUTktUIDbqcCXf5AEn/T+Ewlkg1FQeDXnZk9fYXr+MwhbvYWknQrEqUS+azSJsblW9BtL8K9Tbu1wbM0fdYUZR9cvLX3tw390CB+vCJhgfEUbgAlYUbqn9vZBsreds6RhsLAiD6U6fPHEi5F7Qa5+uaGBl6x5p+ukiq0CAwMmxHDlEYoJz954z4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxR1YqrimuIjlurdtqa0BRqQdV5wvcYSK/DWaTMfYnY=;
 b=gFzbXUkGuJt6ELcaPFWdzYbDFfzXkyFNrymdci1Q5Lw/jN+WUM/vUCEwSOQa//UEA9cY9Ut9UFOSWnuSeQrU3la4v3HprTCCi9tXX1YQkAh7xO6b+I8let4fgQQW28CF+Kfp2vv6rAITFlaSq89FSMSqAaNQ//9PGo50rD7m8MA=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH7PR10MB6282.namprd10.prod.outlook.com (2603:10b6:510:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 14:58:49 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:58:49 +0000
Date:   Mon, 18 Jul 2022 16:58:49 +0200
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     Ken Moffat <zarniwhoop@ntlworld.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Retbleed, Zen2 and STIBP
Message-ID: <YtV1KT5l8KpoJWGT@localhost.localdomain>
References: <YtUXda9ymAI0ED7n@llamedos.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtUXda9ymAI0ED7n@llamedos.localdomain>
X-ClientProxiedBy: PR0P264CA0229.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::25) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc0e658-fd87-4ca2-a296-08da68ce04e5
X-MS-TrafficTypeDiagnostic: PH7PR10MB6282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaW6wBZBfmMnCKipCJ4dew+n34ptOFno7qX5kfXeDzMtTercmk6n1gXmS9CQmPsoGfBP0uvGrAMx9MlPSsrHjz4pCqldmcuDeuKlsklOh5EPNRat7jpk3jJ+Gthl4KXbwPukCL2m3bZu85w8c/Ei0FQAoTLsnW4kp0L+wP8tLZ5ELTxxualAJEQK4BLzRi0h5GjZsjMQ3+XLwIEsN2iNPDyPffxs6iSqorvrvTnI6ryb8OU/9R6wwC5T9ohkyO01vbU4z3/oxqPO3JYos67Uv7m2ZqUFvN5CgoBt0mdclmmyuCgnbfhUBPf5KthTQZ9PGCnMGIfCHCm5k60rkgNk94eq2YyHgVWdd7nKTxlqCWFTsryrg85sEnKjvPT5R8/uad5Uw4PaMdAdZ6lSjSID25jglPUyfoMSa7biacYwA+dFnylSzQQvc3tDz5l76XRB+q32INbJrYn9miiVOS1QwZEuXEi1NIdyTuVpVNOAJaf1Q1Wuf64pCugbrBz/qkQQOpTp7ayIQR/5XyGs5VMXLOty/JjQGHAhNbH8SJS+6IwAnHS3b4n7AubaGBGMFQ9qzdB8G5ngbehlAPoGlAz3cLFN1xD6+fehpUGOqbuBxKhwErY1ZfOVRtz3lfrGenZk0ej9KVjg8GG3YfeY2rSn+JOXDyg24gPoZhC+Ng3LIItwIGbfSyDGBwNM371HzLLy/7BUnTm2GPN2YKs9Whj14Bj7mLZPafljyD/C0Vogdl5Net+S1IZQ+bqMfNts7H0/Cqw3xDCuWUBj3vnrEmxSvC0k4MDFd6s0PGlM3YnDCNY42/I40THbD5aCccjBXHKjpzEiWu0lme6f7b6GngN+wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(66476007)(66946007)(66556008)(6506007)(38100700002)(6916009)(8676002)(4326008)(316002)(478600001)(6512007)(9686003)(26005)(8936002)(6486002)(966005)(5660300002)(44832011)(2906002)(41300700001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhHczMxMnJ5K29MT1JVdzNhZmpFbjFiSUtha1JwYXBacWVmYjUycDYzNmVs?=
 =?utf-8?B?Mll1NllPOXlUSC9lNUZOUDNxb0hETXNZU1VPUDFrb1lER0hQczJPNEhwQ3RJ?=
 =?utf-8?B?QUMyUjdJeHQ1cE13MDhnQVZreTRnREoyd3RneDA5YWtXNStVNEJEeTlkWmdt?=
 =?utf-8?B?ZzRCdlVDTnAybnBVMlgzWnFSRTRmUCtJVExHTEIwcTdvV1pzVjNWQkxlNG1a?=
 =?utf-8?B?d0dEVDdnU3I1YmRobVE2aXg3MjhjV0xtQis0c0IvbnkxdlE2bU45V0xjYzFS?=
 =?utf-8?B?VlhRSUZYOVU0YTBlRHdUQXFtSVRNN0lCbXpHMDNKNHdqNUt2WEpPOXBMQ1VG?=
 =?utf-8?B?eEJaRzVFZ01HWCtQSFdkZHdrcnRYM01UeUNPUHRBc0dCVzc0c2VOdjlnb1JE?=
 =?utf-8?B?NnR5b0lrSlBHU0lZR0hWam12a2NIa3o1QVYwQUNIdTNyeE56OFluN3h5cE50?=
 =?utf-8?B?TFJjYkkxVjVZVTNQMHU3OURSUFc3Z0lCZDM0THJBQjYwMTVzWTJlUHRVeEEv?=
 =?utf-8?B?dmtGRjVPUFExWkQvdDVCeWozeUtjVHcwVUMzWnFKS3l2NTlKMnhwa0FaN2k0?=
 =?utf-8?B?VGUyTmwyUm12QnRiV1ZJLzdPL0hhT1VsMmZPNTlsWTVMbHZUajllZldrR3N2?=
 =?utf-8?B?NU1QUDN4U3VoYURQTFRITFRQNDRSQUFRaFk5ZEw2bWVLb0wydHdhczNWUHRS?=
 =?utf-8?B?ejZ1ZE9ncUs5Rm9LWDBhYWQwdHpZeVUxVW5QdklKUXlBd1JWa2laRkRLeXJP?=
 =?utf-8?B?ZlhKWUFJcnJyb2xDTWFoZ2tSWE5QZVhyUkptTUdCTUpxN0VCMWxyVWNOelNK?=
 =?utf-8?B?dEFPeTRFSThsYUNnRzdhU0t6RHlvbVUzY1cwR25zU0pJTUJpYUZwSUFjVFp0?=
 =?utf-8?B?SW5BV05ZRDB4Z0RPL0FyYStOSENTd21PVUl0eTlEMXlMS1dlR0E3cXhvUVhM?=
 =?utf-8?B?RzRyNE55TWtBdHZSeGZxbHJwSzdyTWRvTXFYQzdGMExCYS9WbFg5K2pWeFJQ?=
 =?utf-8?B?dDBFOVorVHUrQUp0Y05lTUNJcWRUa0VGbVk0TXZ6TDkzQ3VEbWZpOW1DdmdG?=
 =?utf-8?B?U0IxcE54MjhtcXNQNG1GTW9lVFNUOWx6RkIzdi9ZTHRzM21oODJ0VUtqTkJR?=
 =?utf-8?B?M0I5YUdLaXY2VWEwWnpOL3VFb2IxTitIYXdwT0o5QWZqdTNUZDJqNmxxT0h6?=
 =?utf-8?B?VlBUb3JQT0lRZEJwNFgwY3pla3VkdC9OUXA1dzNlb1BHWCt4ZFZXd0JESDRD?=
 =?utf-8?B?SVI4UGFTQ0taY3FiODN5eXlncmFnTTBUSFZmY2V5cXAxWDNKVzJoNkdhTndQ?=
 =?utf-8?B?NEtvRmhtWlRGcDg4ZFBKODJpbFNORXZJUlFUNGUzYmVuQWdQa0dxOHZUNmxo?=
 =?utf-8?B?Y2xLeHVWRUxpdzdsRkN4SGJjaW10WnFOak0razJNa1lNMjBKUy9rdXY1WWVv?=
 =?utf-8?B?NG02Q0pBUWlKVDJ3T3oyVXJtTTQxQ09BbU13aGhYcTlTRjdhVk5CMUdCZUZM?=
 =?utf-8?B?aVJPclR0NTh6QkxvMzRXOGJqSUU5aW1KVm9sUHI1eG1EaU81K2RDVWx3YlFj?=
 =?utf-8?B?bmozSTQ1RzU1Y1VUeHhQYkxQdUtpdTNudXVqVGJHQlllcVcrczNlSi9tVnJ0?=
 =?utf-8?B?WUlGTW1WVFMydk42SXJxU2pxM2RVYWp2eG9KYWdSbzBGN2M1R3BrN0lsbmRa?=
 =?utf-8?B?UWpvNXZISnVRS2NFc1NJZXdWL1NicTVKNWtSaHRYaWtUTjhIMDRDdDZ3dzRh?=
 =?utf-8?B?YnRGSytJNzI0dmpjSTRBSmpQdFlHZlpBZ0tJYXFDc1gvbDB6RHl1U1FUcWly?=
 =?utf-8?B?UjcxS3ZmSGNFRm1GRkxPWE1Eb040R0kzbS82ZGY0TiswVWQ2U3lGcXZTanpa?=
 =?utf-8?B?N1BicjBNM2haMTdkY1p5SWp5RjcwMkY2UkRLZEtmbngwaWdsSzJOVWpzTmtP?=
 =?utf-8?B?TDhGekNQSVJoQkp4QmlRNmRoYlhzaC9DS1FVcTFXcWgyMUdTTUJudXdTaGdu?=
 =?utf-8?B?Q2dnWFJRSFlENVdqSWErSGxpQis4d25vb1RCK0NHMHRyS3hyRXV1Rkx6bGpS?=
 =?utf-8?B?VFlUM0o5VFZybWszaVp4bkhFZkY0WGpOTWZXTDFSTjcwWnlqZk9WdlNmUldQ?=
 =?utf-8?B?UzZTL0tLK0pleHdpbFRFK0pLVksxV2VVVjFlWnpJYS9vdzRCc09sa1V1bXZz?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc0e658-fd87-4ca2-a296-08da68ce04e5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:58:48.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vae++Pic+Q+ThIkQB6mH6S/q86HGYGEQdjXax6PXj9+s2zvH27yGcjISZdh9I2T4GeLl9dUg+qMub2gGyVfcvrPkh1+nK/GdU3xuRnoIHIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_14,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180065
X-Proofpoint-GUID: oZr-8l-l4CAkbn72_kk8bWO9frPTb2Ol
X-Proofpoint-ORIG-GUID: oZr-8l-l4CAkbn72_kk8bWO9frPTb2Ol
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:19:01AM +0100, Ken Moffat wrote:
> Probably like most people, I find the detail of the available
> retbleed mitigations obscure.  In particular, for zen2 the options
> *might* include ibpb or unret.
> 
> But I have failed to find what 'unret' actually means.  Any
> pointers, please ?
> 
> While ibpb might be available (and slow), on my Renoir with
> microcode level (0860106h) there were no newer microcode versions
> available when I last looked (a few weeks ago) but note 7 at the
> bottom of
> https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v
> 7_20220712.pdf
> implies that the relevant bit is only set on Renoir in 0860109h and
> later.
> 
> Some of the text in that pdf implies that at least one of the
> options could be set if not already set from the microcode, but the
> amount of detail leaves me totally lost.
> 
> Assuming, for the moment, that I might want to try this full
> mitigation, is there any way to set this in the absence of newer
> microcode ?
> 
> Or should I just accept that the best I can get is 'unret', whatever
> that means ?
> 
> ĸen

'unret' = AMD JMP2RET i.e. replace all 'ret' instructions with
'jmp __x86_return_thunk', and safe training the thunk code upon
kernel/hypervisor entry. This is a purely software mitigation,
it doesn't require any microcode.

AMD JMP2RET is described in this document:
https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v7_20220712.pdf

alex.

