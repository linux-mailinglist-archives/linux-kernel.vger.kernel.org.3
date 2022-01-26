Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500E49CA66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiAZNIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:08:38 -0500
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:61678
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233873AbiAZNIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:08:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGvlSC/PFXQgsvd0W6nrN1zw2VU3bHQ8hapkxi06UoNZRLaDc8fOZflaL7xwNp5vKCAoBUwrDA0oZAG8nLggU4SfZeNu3nlMs6nu4/Rnf0Sy1jOZRBQJKfDXvEbYZtJOvKH0WlDRt5wSSIbnWkvRxpm1D6Fvs/2xWFqH73F3vyOM3McImLcY2V1FkuVnGX3z3kXCwFZHuqU6KmqpM2twVUQo+jmm6bVI6VQrmwcI4MFig5fyxMsfDgkvrDlGl3/3hHLf7IuQCJ0sRZg0UpbyIfB/vGa2yPQ9ZmDRqwD4OiW49M82RydSHOU9OCVWv/DRL+B5yR9NoQn2Ej4lII3rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX2W+NHM72bAc22hweY2t8Y2Ds+qtg9k1Hw1/4EFXQE=;
 b=JkumDb9Md8wyBEbJdnAbt14kXT7ZEpa2qkylEWCv4FjZyo6OYMcg2Sgo/eykHjcgEq/JghmLoywuV87bNPS+PzCkbjhGGzlK/1ghgz/tVXnTcxLsyU2435cV0W2YoPMfJT5vWnc55ML007QYbg7JQ87jb/Cvc3rAYa5Q9mNZhKqmltaV9yyx45cE6sWajAlY1BE8czW9V7mHnbzjgKht+ayCNLDXDg9cLH76z1jdz4gAIonrwMwXIKIOeoHF3QkYU+viNP88c8xjXSRSf3wh/o4MS5pSr0rz0liJRxjasJ73Hvk908PJViWTWZeXtBVtqrV2oXG+cXOXNVJ3QGwvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t2datacom.onmicrosoft.com; s=selector1-t2datacom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX2W+NHM72bAc22hweY2t8Y2Ds+qtg9k1Hw1/4EFXQE=;
 b=IY3Ccfxg/5fTdiXJBuTNgPVG0Gp86XMaz+c8hf+mPH/R60XSiZ/mFoFcbAcQ1aFqWoexyNNuWkMWDysWM+p8R0lS0Gw3f0df+nE6wWa5+v9gR22hTfcdfoRW8yVfHQ1LMQG5daebrzVBhNr5xI0VfUeZaeI0YYLiFpwXyfezKQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=t2data.com;
Received: from DB9P251MB0618.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:334::22)
 by PAXP251MB0242.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:209::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 13:08:34 +0000
Received: from DB9P251MB0618.EURP251.PROD.OUTLOOK.COM
 ([fe80::10ab:30da:9dfb:56fe]) by DB9P251MB0618.EURP251.PROD.OUTLOOK.COM
 ([fe80::10ab:30da:9dfb:56fe%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 13:08:34 +0000
Message-ID: <17d7548a-9f6b-dacc-2f96-9d625fc080a5@t2data.com>
Date:   Wed, 26 Jan 2022 14:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Christian Melki <christian.melki@t2data.com>
Subject: linux-firmware embedded usecase, licenses.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::19)
 To DB9P251MB0618.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:334::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22468841-54ff-45dd-630b-08d9e0ccf56e
X-MS-TrafficTypeDiagnostic: PAXP251MB0242:EE_
X-Microsoft-Antispam-PRVS: <PAXP251MB0242D8319090B7614D629322DA209@PAXP251MB0242.EURP251.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPcygxsvNcvRHdpRRO+LlYHwPiMob/CSnthN/+AJp7/gh+iiRUuoSVpLjfObRByrCjmjAbygq5UVNTH6Ceoh0+FU/mdoxFnDrndsr5z30/DwLfGMbgubeBjydOvCgPqIV18OcXWNfSNvlJOu1rx1VzXYUwoI81pIxvvkd54gsaaZ4lVwA0IOOMzAgxOG6KKIvYGgSkkA/voZPKjndpiuKKoX3c/PZNx0VrJj2VDMGRDLsyqbfpRdwydk1/grQlP2Qa1gWE/yJ/ElnvMi1K/1QD5L03ZpwIflP8sinPJ8qLsWhr17XK7kbM0KRxX8HXy/X13MpJD9QjvldAswXODS29SMLfd6WJK6//bnVzHsH5W3tEZPNkdYsyb4iLg6aZjZd9Mnonu22JW9JZJqSwd49M+uCEBxvIq+wEL8bx1tFLh3OAqOi5qck2BTTKyKiv/AQQedlv2al/Qnz/LYaV7zjOzhO8Cnh0OhmvF/XYd+yVpriXCyAiv4RWylIIYt2DkvNrZtfHV18z2a6pnPSKnulAEfUbuax42tt2OxOmaRfLKg1QbXaK8A3jQsEXz2i4IMH1Da1PQJrNO0kwzDFmckP+uEXSoKoQYBOmLd1k+nrEjZu+zAgTUhl9i93Fe2ogwycUUIEeTD4Pp4Ncxaa03bLo+jxK25m+uP78cTGdZSh1tkRc4BDDIlptHm+xWsCKNPIXOI7bpHmjgzCvHbGuB2i+NiYo7V9MTqoO72UIPEVnaencE0/o+Ek4+3mq8d4D+IHRGHKiZ69nZLC4X9Fj1Ndt1ZztVmG1iIUM7uZz4VBC26K2AH5ctV+uduUYjTuvnMt8fTWcieGt/oXJ7FFBc8HI0NgEizsdco6j+jeBcBipo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0618.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(136003)(376002)(366004)(39830400003)(6512007)(31696002)(508600001)(6486002)(966005)(52116002)(186003)(26005)(86362001)(2906002)(2616005)(6916009)(38100700002)(36756003)(8936002)(4326008)(4744005)(6666004)(38350700002)(44832011)(5660300002)(8676002)(31686004)(66946007)(66556008)(66476007)(316002)(6506007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhZTzVxdi9DR1JTY1JZRGdtYWMxU0pxblpHR2hZYWZnSDdnYUxOOFlIRmhC?=
 =?utf-8?B?Z1I4QlFoY09aYWJrL1l4eHcxTVNhWlhwd2ludnVqUG50RmFhWkNsSzhldTF6?=
 =?utf-8?B?TUxYSU1PTElHTFhqVUtHMkplQlRpaUtGWU9xYzhnNHZVVHdVWWFBNWJKYUw3?=
 =?utf-8?B?blV3RU1NVVcrNk1sRi9DekRBU2JBVHFDdkJ2WW13YmhZNDQ2aTdnc0wzZlVM?=
 =?utf-8?B?aHRNdE9qalBpdkc5UGpoYzJYMWhkMy9mRWh1WWRYd0ZzaGUvQnFrWnEyVmNi?=
 =?utf-8?B?QnBjNDYzV2pGM1VsSGpNNktieHBqMFhmNXZEUmJtSWNRK2lrRW43c3lxdlVL?=
 =?utf-8?B?NHU1YVRvZ3RKbXh3dmt6d0JBR3ZXNTg5U1Zic1pmTVNkR1cvZ2I5YVN4Sk9Y?=
 =?utf-8?B?cTd0WUR0ZFB4WDkxNkRRd0VxbndDeGFrVyt1ZHhuTElyMmZoTTQ2WFh4aXZ5?=
 =?utf-8?B?ejI1VmtuSlRvQVZES2xrQUVkRkpZUHliaUlQTG9VRUFKUUh4S0t4WnVaWTFD?=
 =?utf-8?B?S1NFbVdLRDZ2endFOUZQdUhTQjY4K04rRTkrZDIzUFpoWldwbFVWd1pwcHky?=
 =?utf-8?B?bXE5NnlTckFVYlhoOGgvTGRPV20wbFRnblNlOGRPRGpvYmRTS0M1MFdHRFNN?=
 =?utf-8?B?SHgvM2RHekR5WGdxazVPc2greTVocklEMFF5OStReWE1eE9ldlNRbFZFdnhQ?=
 =?utf-8?B?SEpFRkpKUnZyVjF5eDVtQjZNL2pMeWpLMjNmczE4azRZaVcwaUNsSjZDN3dD?=
 =?utf-8?B?ZkhCbjhUT0M2T0lzeGljUXhEKytLVlZiNXVDS1lXeXczT3RubzIrK2dvR3J1?=
 =?utf-8?B?T1pBRE8rUFBuTlNRRFNNUWhYRTNSbTdtRWlQNzdQalVBUjdML2tudDRVRFcz?=
 =?utf-8?B?VUJFVkNTdk01N3cweEZLU2d2WWZvelNJRkJUQU9CcSs2dWJqbkU1SDJYd2pR?=
 =?utf-8?B?Uk0wdkhHQXFaTWpuRlFQSFZDaGdmM1FoWENCOUgyR21nYUk5UU01cU9sblFL?=
 =?utf-8?B?LzAwVkFyVnRKNE9IcU5pekpwVHdpMU9pbC9PZU52MHI5L00yWjlhVmhOME5l?=
 =?utf-8?B?UTQ2dTBjelNGOEQyQk5XTnJpMVI5MkFiNTBYeTZtTlR0WFM5aHE2cjlrVm91?=
 =?utf-8?B?bEVFcjFYdmp6bEgxRGxZNjgwVW10aEdnYzNDdTdTN3hNTURQb1ludzZzSm1a?=
 =?utf-8?B?SlJXZVlhaDFJSlhUVHY3bjY1L1BwNGM3RXl4Z2k3dWMwQjFpVFFwMEU1NXhX?=
 =?utf-8?B?UnBFZHBhcS80aTFaYWdaNkFqSy9oOEZqWHJ2aVJRc0NPRHJWcUg3dWRVTXp2?=
 =?utf-8?B?QTNraW5yMkl2UHJDZ2d6SE1xdDFhTlQ5ODNwRVNabnUzUDlkTGh5MExJRzd2?=
 =?utf-8?B?Z2I3cTdKVjVTNnppcVZsYVhlcG80Qmt0NDZZZkF4cDNoRDcyRUZuTS9JWHpG?=
 =?utf-8?B?V3hCZExIa2hGMDd0SWF0QldGazlWVFl0UzNNbU5TVE1WMnpGYUZWeHZzWnNT?=
 =?utf-8?B?WVcxOTAvZ082c0dqUjZxOGc1KzAyd3NoVGY4NE11d1A1VXRpS0V6Zk04azlO?=
 =?utf-8?B?L2ZuZzZFY3d0NGtoWWVGUFJ5ekVTY2g5MU5TckZkTkFqb1V6VDdQZFEwWitj?=
 =?utf-8?B?aWw2SmdVbkVMOHdyS3lVT0ZselkrV0wrQ1N1VG1oajl0dUtDRVFIdTRVaGhZ?=
 =?utf-8?B?MVR5TnA4WlhscUsrbGovNUxpbnpPNWpKdk5SejZaV0RDNnorY0ZJOFBuYnVH?=
 =?utf-8?B?VTdYcWtwYWhCeVRidW5hejBKc1F6ckxGVDRqMkRGYUR3Wkx6bjlBcmtDT3M4?=
 =?utf-8?B?WXhNbWNsSmFSUUJTb05DK2owTTgyWCtCNFIrSC9OeExDM2dKTU9XS1MxM0tw?=
 =?utf-8?B?RWh1S09WdDdrVUhjczZoNCttUzg2N1pBekJGY1pmWTR4MUZHVEZXcmpEenda?=
 =?utf-8?B?eWV2RDZVVHdPcHhSSDB5bitWandDdm52R0FFREcxLytyT1o5YUxMdlR0YWVJ?=
 =?utf-8?B?WUxJa25yTWhJVCs5OFdnczdCaTdkZngrMEd5dVlScnp6ck1pMG41cUlKM0s0?=
 =?utf-8?B?M2c2NUV2QlJNeDN3d0ZrMFIwaXl1VGxMNHdLek4zUk1GampKblNxN1ZwY3lN?=
 =?utf-8?B?bitaSVBwM0lleDNxV2V1N0U4ZjJHR1diRWNHZVRFQ2FZR3ZSUUhsWG5yUFRT?=
 =?utf-8?B?TkFNQnhMbTZ1MzNvZG85OWx1bWtlcGg4QngxcnQya2l5bUpHaTQ4dFlBU0hO?=
 =?utf-8?Q?vpSBDkDByZC9lmSjS53fwmVZ4k3tzT4oesOoD4Uqhs=3D?=
X-OriginatorOrg: t2data.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22468841-54ff-45dd-630b-08d9e0ccf56e
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0618.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 13:08:34.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 27928da5-aacd-4ba1-9566-c748a6863e6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIRApw651QhaOqm4aAdn69XnAmMGz4t5ufLGatJAqX0Aa+KGGF3pZ5/rTIj7YKuSFXuq37DxqRWouLSK8F+M36boiUbxfFyLznQnPb/Tz1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have this usecase where I include selected parts of linux-firmware on 
an embedded machine. As the entire archive is pretty large, only the 
needed bits are copied.

Now my issue is that typical embedded build environments create their 
own little version of license/information selection hell. They do it so 
they can figure out which files belong to what license, etc.

https://github.com/buildroot/buildroot/blob/master/package/linux-firmware/linux-firmware.mk
https://git.yoctoproject.org/poky/plain/meta/recipes-kernel/linux-firmware/linux-firmware_20211216.bb
(and others)

So instead of everyone trying to work out the same information (and 
checking the integrity of that on every release), it would be nice if 
the WHENCE file was a bit more structured. That would help something 
like copy-firmware.sh (or similar) to do most of the mundane bits.

Regards,
Christian
