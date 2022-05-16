Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA352800A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiEPIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiEPIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:48:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80095.outbound.protection.outlook.com [40.107.8.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D126D6;
        Mon, 16 May 2022 01:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFxKRr55pgocAXgjMQzAWcN4979kjCierMXuiOdjrOqWWGcoY1rAPsUd2azxF65VQ6HFvCXOpE6IQ+/eQ7oBnv0igD1Yr8lmR0gPG+gcHFOXmCSPoCSP1GrIkjog/QKLwTIqmIpdp3WiaJyHREASFEsWsuOcUkotzegTq1DoBKa4hbZvwuoo6C8eTU7An/X/W6Rc3Xbwi5cOOOqFaIqIYdmjEwGZ9T8lPEtuVx4jslqBBc2Ynpzjplw9qZfvJGj9k8DNxxvLmRvYBmMWvHB/rQN2eRkklaz+qQf2Jz4J0PuKdQcxaT9+ufTbkWWc7U7W0BrN/0KDOpNMb/svq7g22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDvNFQ1mQkdXPJ+TOlPV819zmFUh4T83CRxTObhiXYk=;
 b=KiVXO95mtDaKgrZhm12S7L0XQhIGR0RNiLb6D5yY32+9e53e65IyB670dr9NaC/GMuJfhas1oZkC/cmBChM17g0LFmqU+6tuJuOHg8dRobWV0Up8EcFZ8ICgR5o6iJm+1ONpTEo/A8BkxeslTO2LW3WJU+oe9qLpaw7z6MDsRs+6nwxhIGTLqLdaBgAiDKVBIscuiWkdivCx6Wma2ZwG6XtkzzJiHPnxRKqAKqbzEpVnUnMDp71xm2atz0ofuyH4b/pP7XnSCRaeuacgC/6sgLlAFuXydpL9afwe019IniCkEjGrUI/eGuCG83ZvS9tSrjs2UpwiKKL6L2APyqu6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDvNFQ1mQkdXPJ+TOlPV819zmFUh4T83CRxTObhiXYk=;
 b=cRlFIV/oifqb2eD4SK5KPIcgFiEPdafnhMlHZZXXDXMubMVOJSxIs2yJxRxF9ftYrdk1d31SY8o0Ajo9RrAh7+B552yCOyw5R2rVHW5G84/mEw2YUZqVpccRgofIdDitUF6FdBTe+KOdiavAeliHvLXvGM7ED8kPzQ7NIQJe3+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AM0PR10MB2034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 08:47:56 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7d61:b91a:e773:4e]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7d61:b91a:e773:4e%4]) with mapi id 15.20.5250.017; Mon, 16 May 2022
 08:47:56 +0000
Message-ID: <0db186ce-f789-f306-46ed-74ba75dec028@prevas.dk>
Date:   Mon, 16 May 2022 10:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: ERROR: drivers: iscsi: iscsi_target.c
Content-Language: en-US
To:     Test Bot <zgrieee@gmail.com>, linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, torvalds@linux-foundation.org
References: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0103.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::8)
 To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c9e187-eb3d-4adc-43f7-08da3718c5ce
X-MS-TrafficTypeDiagnostic: AM0PR10MB2034:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB20347A2FCEC1786703A03B5193CF9@AM0PR10MB2034.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjirmxJwk5tP23SoKF7Ohcfb5iyLAsqKIEwdBKiyPzvfQ4Aisr1Azjj8UegJAGllYbOi8MI02OGf7k2UYlHhF1wULejUyR5UWPIEpSyMRqIzXIqSAakWUEABZbZV/Lv4Y5aLRZYOYzOB9N+6KBSujP7rJLNK8z7+wfwqq4Noz1/I8rGaokbQxOJVvQfWsaotm9maXXk8HYio2QBy/5h4GSi8Th6HlaWSqNf+MqkBU3txr074Y26Zl1XZPyl7xT/G/4+Gewq5PcgVX5XoKX994m79cMtaayBnqnKnEWPeqieZ1kShASkD9jLhDJWZ1dmkiiX8Sa39qqMqDp0uKelUTu1SsPI44qunPD9gmPQxqWdt53J3Wa2YvMH8CigBUwKfNPeL02gG0+7+4sj1zwWtWTuTJRL3PJm60HHbPkTxxApeNIZqURHpkc1SvJ+Rk1eJRHud7vVu/HQYokw1eYjUbbev7OhFY3PQooYeXuhx8LvSfyoUU97h/qh07qD+sn6wyJoJE6QXIa8IlQlTEvg+ZHut8LXrAlaYP6oCNHYRoYQn1fiFMIPxVZf/SO5/frCP3Jx/IYQ2kbtrUKVYbHuw/kcz/y/q6RxNv9wHxpwZdayf0VZFnlWjcFbTZOW9QM3Oot71mAziZLG0BLfz9n5Q9Z+GsfuLmAnpuodBFKioIA948N0HudFr5eTI58+zQzGlil77j6S1ANazTZerphb0Hbf3xNYZvrcJy/tlIiwCEZZM9gcelNS8g3dNcS9bhKzJR6vaiYGz5ZMT0A+FBYWTyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8676002)(66556008)(66476007)(66946007)(31696002)(4326008)(26005)(52116002)(186003)(8936002)(508600001)(8976002)(44832011)(38350700002)(5660300002)(4744005)(38100700002)(6486002)(2906002)(36756003)(2616005)(6666004)(316002)(6512007)(31686004)(83380400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHN0S3hQc01xLzE1Mm8yS21ONklwa1hscDZFZExPb1NMdGp4UG9YQVhvRzZq?=
 =?utf-8?B?bkxOckh2Y3VORTNxTXFJRmIreDJMWnp5MG1pRUNEQzJrS3ZyYjRaTnF3eXpP?=
 =?utf-8?B?QXh1QVBaVWVzY1Y5S3RsbkZxWTF5RWFCYnJ4UitwU25UNm1ERitZajYydEls?=
 =?utf-8?B?Q1l4dGZGNWRycnR0OCswVFZWUTM3Q1RFS0lVcHpKQjhLTlN3WGsvbm5HdkFU?=
 =?utf-8?B?OG9scVMxVHpuZ2wraHYvdTdKSmpCY29MWUtMMUd4QXM3Qmg4YTBHVzNXbXNU?=
 =?utf-8?B?czlmVG5Vd2xiUk84M0ZzSnhBSStTS0U3UXlDWDJIL1gwSVAxOTJmYm9kRFdR?=
 =?utf-8?B?dkpHWW80a3lNSDFjb0xEOCtYbUdYOTZVOU1ocXRIMFg3c1pZZXA2b2JjOTZJ?=
 =?utf-8?B?cmZQcXdjd3FXU0RTV2ZvSDg3bzNUaSt2M1JScmxrWlVjYUx4MWRFOHRpalgz?=
 =?utf-8?B?cDg3SFVSSWY2NWtYL1V5NG1tQUJFdDBja2Q2VGU1aWg4eVo0MmQ3S04rbHdu?=
 =?utf-8?B?VmlaVy9kWEZyamw3RzJHU1VRUlRQeW5CeVJsaVJxalpGbSt4YlJqMkJyS2VN?=
 =?utf-8?B?YkFuam14OUkzSEFBdm1vUGRGK2c0TGVveldiNkhzQmhzcldMQVF6SmJHaUpx?=
 =?utf-8?B?Ymc2QkJtK1M4anE1TXBoMUJXSENaWitpa3RvMWVwei9HYTJUSHNGM1drb2Jh?=
 =?utf-8?B?NjlyZ051bTNiQ1Q1cjlPdGZUNWoxeTVFNnJkZVpLQkFMOHRscVhwWDJNd0g2?=
 =?utf-8?B?RWk3VUtobUJWQ081SEtMdlNiaHJqR0s2T0FEU1ppVFduTTN1SGU3Kzk0alEr?=
 =?utf-8?B?OXROZTZDR1JqY2R6T3hGT3VRSzFWUW1zdVNUbE9Zb1RXSU1pak92Z1I2ZnNC?=
 =?utf-8?B?UlplVW10d05DbUhSeWQySUxEV1hlQXVuWDRJc1Z0OEJ2S2R0KzlPQkxQMjdv?=
 =?utf-8?B?RFlJMm9QNVBWL2Y3UWtpUjdaaHBzVDZTcVQwMlYzUTVhZ2RXLzNhRERXK2FC?=
 =?utf-8?B?UnFSKyt1Uy9EajM5UVB4VzBPNHdvNmhKWEx3SktEV2xkMGt4WU5MOS9FeklB?=
 =?utf-8?B?Nll5V1kydW01Wk12eWtrdW53eXBYN0Exc1Vhc2xra1ZCM3kxeGM5T2JabjBX?=
 =?utf-8?B?eUg1dVFXWU9yM2Q5Nm1VT0ZOMHgzNzdXMUYxdVJvZytSeTBzUVVUSXZVQWoy?=
 =?utf-8?B?SDk1bE5BYzBvVzdZcGlycU10dG1UVXBFbVlnQ3orN2NrYktHSHRwaDNvNlF3?=
 =?utf-8?B?MmFkSDZuK1NPODljT0c1UW9PUm94K0xBS1VxejBrY2RsM1I1b1h4SnNRMmgx?=
 =?utf-8?B?WDV0NUdNY2xDQVUxSFBaNUhnL0JlWk1EVmpmUndMSFJqZGUvVnI5cnBOQkFy?=
 =?utf-8?B?NmRBbDFOUzhKaXk2aXV1bWptSnJmWm5sOHhRbFlyS3FaK3FFNXFiMTZTWmJh?=
 =?utf-8?B?SFBQcDVDTWQ5TWZnRWdCWDdUK3YrVVlobFNmOCtVbjlTWjlrcStjMjNNb0lY?=
 =?utf-8?B?MEl6S3BiRUlWNjd2ckVId3hnQzdOYk9MbXpla1QxbCtNRDJhc0MvOXA1UHRF?=
 =?utf-8?B?MkRPOTVPYmVkdnZTdDlncEdCSHlQeFdwejZJY1dQNkFzMUpQbEU4SkxyQ0ho?=
 =?utf-8?B?MnQ5aTVhcGFFd3Q2T3VqQU5xWG11eHpJMWNDa2VsRGtVdzBlbmFUSXJ0dWRM?=
 =?utf-8?B?Zld3VFFxYm9GWXk1SSs3bUlsZkNBV0t2QStkVTBId1psQzJWVllSMEhrUVBR?=
 =?utf-8?B?UTZycFhoUzFaM29abTQxdjAyUUtkOXZaN2U3Y2dobU9uMllDakQveVdFNjlF?=
 =?utf-8?B?KzRlRGUxQS8wQjZOVGJGQzNFSVg4cEFsZzdxN21xVWpEelBoQ0VuN3JCQmdo?=
 =?utf-8?B?SnlaOTJEc3FyU2dGTU9WanRCWmtxSWxjWEFPeEdwbEhSWE1RcWI0bzJoWjhV?=
 =?utf-8?B?bEJUZFF3MDJYci9NaS9hS2lvdU93ZXpXdFY1NUdhUkJXU0hsSGhDcWdSS3hB?=
 =?utf-8?B?L2JDUDVUbGdaYyt0ZHlpL1BCWVR2ZmhIbUdyMlVKNzNJanNDdmVSUUg1ZUhZ?=
 =?utf-8?B?eUNSdlQ0blhBcnlIOE9EOTBiRUJBR05yU3UvV1FTMVVuRE96TlBjQlVxbStJ?=
 =?utf-8?B?bVJTV1BmNzdDdTdKMTQzTDZFYkJUL3pZeWFQZE9iMm95RGx1a1lFVFI4N254?=
 =?utf-8?B?UWZPeml2eFdrVy9KUkpTTzM5STBTK1dyci92LzFVZnJ3RVlxKzBlUDlWYWlG?=
 =?utf-8?B?SE85NTRUNDJDQVBYMjZjblN4Mi9vb21VbkJWOWpxSTFWdjJ6ZXVRdWU2RUcz?=
 =?utf-8?B?eDlLaFhiSU5xT1VMZElHVStLQTFlUDQwRm5KRkxsNTBpaVM0TDIzUGNUaHJr?=
 =?utf-8?Q?7na8HFxTPBOXSTcs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c9e187-eb3d-4adc-43f7-08da3718c5ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:47:56.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl3FEYzRdwNz0mzYSQOwUw4VCcCZJrSzKt/XBfAax+fvvIdweLKudIx4X1uXIMtzXa1siUw8fP920kIoCw/JWgp1z8cHDUWvEF+alwU25yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2034
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 20.42, Test Bot wrote:
> Hi,
> 
> I automatically test (RC) kernel and caught ERROR word.
> Please ignore, if its unimportant.
> 
> Kernel: 5.18-rc6
> Arch: x86_64 (SMP)
> Compiler: 7.5.0 (gcc)
> 
> Codebase Block:
> 
> void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
> {
>         int ord, cpu;
>         cpumask_t conn_allowed_cpumask;
> 
>         cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
>                     cpu_online_mask);
> 
>        cpumask_clear(conn->conn_cpumask);
>         ord = conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
>         for_each_cpu(cpu, &conn_allowed_cpumask) {
>                 if (ord-- == 0) {
>                         cpumask_set_cpu(cpu, conn->conn_cpumask);
>                         return;
>                 }
>         }
>         dump_stack();
>         cpumask_setall(conn->conn_cpumask);
> }

Hm, looks like cpumask.h should also expose a wrapper for
bitmap_ord_to_pos ...

Rasmus
