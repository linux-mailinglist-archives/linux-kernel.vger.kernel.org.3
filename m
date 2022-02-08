Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0824ACF76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbiBHDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiBHDDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:03:33 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E11C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:03:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Qud1Ma+nY1rHtGs/91orSBGK9VJtzxkLIE0sw/YK7j1taeUfbto4ufvd3t1ztKmzDNMXYvwF1qrNttYvLeJ2Op+7jH8tYN48Q6h5d9VJcrHS9tecImTcOQVkd1IEokP1YmniL0SZ0+Q6OxAJEQNSEa4jONefzyzdGxTIiXBhcx6d0miZIxl146fxggA1b2Iyd7p7PmbFgbYAsTiSPXCSoglPrZpF4l8+fcb38sbQ4od3DixAbnV0IBCNPUK+dY2i3JqvfDIbik5BfLgYeOwtKz60yUzxS8/LtLq090N7fGjGVOpMc9/vJLevkGSwxiiJHAAJ+2iEF3Tgdvk8LXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mHtNUTZY2QI1a4EOyNrygkOCxRJBUBk4mM6GchT8mc=;
 b=nsdNEabVjf4/tq9+PfRpaYfVVQsGJaLRIYQo33e+zeANWtA13riNVSaHnKodrxyzsVBoDiPGudQbH5MMkjk2VpKRa3QAUmB9Z0peEaMbKFl6tTDVEsCKpQhu38KtSkp1MtNpiKq3XRv5e7UxxvQKbK3x74SHxbb+oPROljqzYw1+xIVsuvsRG+/BOkBfjRHKkRyGYw/qCO95YeJ4sHL4XQMkx/cd9k2ajCHby6cpoTVE6bJ/cv28+1726X0q19213k8DiQrgCTjD7/zyFrATQjyVtEq9IAfLoxtPpJmnCtUJx6EFSVtD43TpxWcG4dGBKEOoj8AbyF30o0WF1slpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHtNUTZY2QI1a4EOyNrygkOCxRJBUBk4mM6GchT8mc=;
 b=lESOGrQUi27sQynkRcQ3oEY6HuweJaLP4ir1SNJ5bceF1GtcoOecnOP/lmnoD/GrYeUgOhWGfheF4LdifCfjUU5PhMTlA9By47jC08RwsFCx/BYfowGojN8PfMFb1nEde8dLwTbhElAidTk1tOhJVYlubqVmoTOQZYzZB9giQ64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB3165.apcprd02.prod.outlook.com (2603:1096:404:4f::13)
 by KL1PR02MB5339.apcprd02.prod.outlook.com (2603:1096:820:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 03:03:28 +0000
Received: from TY2PR02MB3165.apcprd02.prod.outlook.com
 ([fe80::cc04:c674:b67b:baac]) by TY2PR02MB3165.apcprd02.prod.outlook.com
 ([fe80::cc04:c674:b67b:baac%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 03:03:28 +0000
Message-ID: <d1d46df7-e761-5086-571f-d35bba2f8e69@oppo.com>
Date:   Tue, 8 Feb 2022 11:03:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: add atomic write related options
 to f2fs_io write command
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220202201727.3410310-1-daeho43@gmail.com>
From:   Chao Yu <chao.yu@oppo.com>
In-Reply-To: <20220202201727.3410310-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To TY2PR02MB3165.apcprd02.prod.outlook.com
 (2603:1096:404:4f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26156fab-6888-45de-4c28-08d9eaaf944e
X-MS-TrafficTypeDiagnostic: KL1PR02MB5339:EE_
X-Microsoft-Antispam-PRVS: <KL1PR02MB53395B6F3CAE9CFB8BB79A5C922D9@KL1PR02MB5339.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v5pp07U2kqr2lL+qLV6Ub3TG5RS5yDo3KcrW5PGAi0Eqe0O+SRLoylA6h9n5fsiBzNoxNB2dxMKFhzZTJYxe2gLBRMaLWerHv6Vw+WjkvrtCx3LVG0OmUI+qy9LAlP6uKOOIz3MwH1yw63pMPsr6pjw1A8rvld3+Ig5EI/fe3fKdRpP6Kg4LNo6hUT0Wg0Z1bIiPeujSRGEgTa2lYnDqNe5S0czL2dlM7iSijdOrlKKkpNvCNW/wDXwGv20yICZgyURhxgAw4/Wc0QSkShMf4DMFZ0Micz0f7KKv48hNo0YBVuFyILqN0GUrZ2EXDGND6+FUJtYFVlk8bhQL4jgTHtDuBZTJQaIoTELbRhQV3QeJzvvFFyfDU+RLHcpziUMHGFhMk6TQcWd+TESQXHxqzhpkJQlE5qRV2qUDOWJha1D/nAid5Uu9LAQcaCN2/qPXXlZKV+h8/AxuVHLxoH2CkAWUjIyIaaYW4RQ0VdsoSRFLMfrn3tVBlaE21xOKzygWkq8GVCNoj1hs0h7HEBJ9TMPMQ7wRT643sF92uMg+U0M6+51P5IKy7OAWpXqYeSReddgHyR9nMs1ZcAuejFDgbhOKFe34nPkO47LcR4JqotP+aEWfEgr47tJb/AMUxdWCgyJvJi1IMDyT1FnUx3hj1vjkcs/h6q5x3yRiFaduI1XrgiGeyG3StZmohFX0DoipYRc3Kynq+M4suyYkY+j4ZqJTpq4z/xmCWTXgFxku2TLzALaW2WNJwzWkHFkC5rvMhGR5MJ66BEbL05XciTspA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB3165.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(316002)(86362001)(6666004)(31696002)(44832011)(6506007)(6512007)(52116002)(53546011)(8936002)(66476007)(4326008)(6486002)(31686004)(66946007)(66556008)(8676002)(186003)(38350700002)(508600001)(2616005)(38100700002)(26005)(5660300002)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJHNEhqcFhNdmJra2syUGhNbEprQ1hlYm1VR3dCNGR5NE13ZUdKZ0ZyQXlR?=
 =?utf-8?B?QzU5T3NwR0RoclQxMkdmeU1ESUswVm9JSzVVWlpMTmEvRnRPTnFEZ1NGUUhl?=
 =?utf-8?B?V29aNW90TytpQmhDaDlvMWpKS29pK2tJYm1uL2h6dURHNVFRbWdOQkI2TkJJ?=
 =?utf-8?B?TkUwY1BuNFE2WEs3WndZd0cyMWdpM1ErNVdUM05qNjZ6WFBkd0l3WE5EQ2pL?=
 =?utf-8?B?WUxTNE5RNmV0Szk5blRYU0pSRVc5NFVVd3A4bVh2enF6STBLV3dIVFFVZllJ?=
 =?utf-8?B?eStsTGNiS0RESzlMdWQ4bHJmb3ZKTWY1Rm50RXh1TGdTZnNWVGVzY1d2VXFO?=
 =?utf-8?B?MWcwR1ZKbHoyTVFYVG1BelFmbTg5dGxzZ1FUcGh1aFRuYWwwa05XTzJuR2k3?=
 =?utf-8?B?TEtjaXBIaHpjUVNvWU1zNFVyT091Njg5YVZFV2JiWXFYN21xNDhtN3hTVStU?=
 =?utf-8?B?cHZRSnhTV3JPQ1c2OHBqbUdEbU5yeVBNM25uQUgyOC9NeUw1V0tNWVhxT3FN?=
 =?utf-8?B?LzNRTkg1cXpWL3RIaW1Qa3B1ZnZlelZXc1hmWStSVEV4TTlUdU14L0xSRFVt?=
 =?utf-8?B?b01IQUxGZVp0YXVsdmhRRGRSa0pDNzJOS0tmZHFkRE11am5nQnI2YWVEa0tX?=
 =?utf-8?B?eU5QTGh2TlU2b3JLOHIyVDErT20vZWVpcWpFelU0RFFXNlJKamFaS0hQNGFp?=
 =?utf-8?B?Zmd5MGJvYk9ORVYrK2Z2K3lQdStCSTAyU2JrVUNZbTBrZlNxdTYzWVN0cWFl?=
 =?utf-8?B?RmJoMk01ME5pcUhxRHVSbE4wZkxSai8wRHhZdGNrajV1VUU3SFdDUkdOeFVY?=
 =?utf-8?B?aUR6b29Pa3RKaEJEaUtDTnc5Y210djZnakRrdzNRem9tTlJKdUoyUmpUc0Rz?=
 =?utf-8?B?Smh2Ylk2dHl6UzIzcE51anFqNlZucjFPcmU3MjRxTWxBN0xzbW5Sb0FQTkRw?=
 =?utf-8?B?Ykp6a21MVUhWb0VoVGU5Tzhwbk40VDZoRUdORUpnUG8zZHdqV2JaRzk4RUxk?=
 =?utf-8?B?L08vVG1tc1pMQTVUSGh5ZEh1SDJicnE2cFRmamg2R3E1ejJLdEtpTUh0dndK?=
 =?utf-8?B?REZDSEJCQWVOOEFqbWRLOWVwMktUaTBsVkJzSXRQYzBIbVhKZDRxZFE1S1E2?=
 =?utf-8?B?em5MZ3ArS0MyS2Z1SVk4Tm84Um1jSGlFY0lsckZCZ0Y4cmJ0VkFPUHVram80?=
 =?utf-8?B?SUVEbGVEQTR6SUFnRkxGT1EwbnJqWkRLRmE2K3BqNFRpNnY0aFB5c09XcUY5?=
 =?utf-8?B?Z1pPdEUzVTNDdkZsMXdUcjgreGFjVlFPRE84bmh3eUk0azYwS1o1czZmNy91?=
 =?utf-8?B?bUdZdUNkcURCRUhBNzM1WlRIMndmMUVBL2lFYWJHaTVIUnBtWGQwa3V2b216?=
 =?utf-8?B?VzRGczA0QisraFdVakdoR3RFNmV2ZzlNMTZ4Q2o2MDBzYW16Q01IVVdBZDJz?=
 =?utf-8?B?OW5nWG1QY3RCWSs0Zk5JUmNTNmc0a3RVN3N3WGFoVDB4Nm5WdG93MUh4UUxr?=
 =?utf-8?B?OXcrV1hUeFk2aFJXaXpxV2RPbHZ6SDM4eGZnQVRGRHlRY1kzQVhnaWNHY3px?=
 =?utf-8?B?T1B5RFU2dnM2cjFyWmdXTW90d2FQWU5hYVdyZjVHMGxpVnhFd2Q5M3kwZ2hL?=
 =?utf-8?B?K0dGWDRBQk9YaGpvVlo3YzRWUzJFN3g1ZnNreUsvVDJiTlo2ZFA4NDliRWd1?=
 =?utf-8?B?dThpeXJENnJ2V0JML2k4VUsyR0xKU2JqWjFOaXVqN05ZZ1NpWnBhczZFZDY2?=
 =?utf-8?B?NDRnUTYrQzhnMXpyQlJGTmtrQ044aUtnVkRDSWgzaVBIQmZkelNGSUg4UitT?=
 =?utf-8?B?ODBjaTdxb003WnBTZVA3bTUxSzVHUEE3SXUzZGczeVZKU0JWR2RhVHFZNWFo?=
 =?utf-8?B?S3dPLzYwOW81Z3hKanJndjY3RnN6QWczVnBDS1BTNEE4UGlWWnJJMHB1RERx?=
 =?utf-8?B?VW51V0lNbmdTSVhHdExsM3pRNGFBR1V3ZXZlUnpTakdsWVNVaU1oT1pOUFFP?=
 =?utf-8?B?bDVqaGZIeWJESzQvSmFTeEpLQXBtSis2TDIwNHNTTnNhdk5DS0JGYVV4aDNB?=
 =?utf-8?B?c0grOC9pcEtVSnRXSTRaRTFVMmk1UEs2MVpZdVdQVHdHYlVyNnBTRTVMVmlz?=
 =?utf-8?B?bVBVeGwxY3dUbnlRQXl1V0tBWEh1NVR4MkF6bnZXbE45N09IaUkyL3E0Yjdu?=
 =?utf-8?Q?wjbP/B/MEYx3mxgiMfBBtQs=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26156fab-6888-45de-4c28-08d9eaaf944e
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB3165.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:03:28.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvQ2fZxvjDrSx8+pJ/y8TahKQoAftTy+ptMs8K1NroZYtAYdnimwbqjObQ5aQgVx45k1fXBP+Eu2cYYKGFS2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/3 4:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two option to f2fs_io "write" command.
>   - atomic_commit : atomic write & commit
>   - atomic_abort  : atomic write & abort
> Also, added an optional option {delay}, which is in ms unit and optional
> only for atomic_commit and atomic_abort.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
