Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF15F4AF724
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiBIQq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiBIQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:46:27 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300114.outbound.protection.outlook.com [40.107.130.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5847C0612BE;
        Wed,  9 Feb 2022 08:46:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R621St31tc9fzEoA1RldVcugm0M3QxQl5QiQzSOz+KlgIbubtEOaTRf16Rr3DIDWaqYGTuBavEXAmYnCAdY5NH1kQaGAv2haVUJcYYeVhHJ7TjzKWYUw0yUzP4bx37FH4SqK4KSNjp9NYLsS2jr/4Qp+Tlr9rOCr8uLgVX940zUEiYwEO7sbiYNIRNNb7L8KLk9XDLF1SVsHBDH4fISx3QzclC/YmSaJRC4UyrHd+TdYjWlNjL3jIGrhRsZlklz/udZd87fmn18zjGfBQqmQaByBL7O4gnCTtMy0x/guZ2Kiy5XBE4epakWJLb+OaFRcXW+rVVwQbniKomRPOixWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnxRGuLrQDeCjyloU7R6kQ2+KQZA1PDq64e3W0K4p2k=;
 b=c4OUvyG34knEXWzvPaHc13cMxWUKQ9HLphO9olNxs+aiJe/6Cr59AKDk7aNFdxS9h5uFX3+wakdkb7/+RMAwDCXxIYFr0ot9Rjyuljpr7g8JHDjw2GIbzNySGN1EWYcSIKcF/wyi2ZabUCIfJfliQ6RW6oO+ZCag+QxWEsGDbidMjTxy/3WvnvNy7t6VOPHd+Cgx6dfAyqG6AdLopqOyPHX2ApGpRt/sNtlGmqpNrtTPtCq3aZkWdqp1DN0D4VRp73vbaHM0voDqsRVtnxzG7UwFKP67nbWb1h35VS98lnQz1+x0m2Qnk0yZBEVUtq3fRRLVzUeoT6kyGNtPodEzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnxRGuLrQDeCjyloU7R6kQ2+KQZA1PDq64e3W0K4p2k=;
 b=Jya2pabUrk8ThpD0HCx0Npz/oy1nPgYFJg599xSvztNkxHmu3qP4MoXYsSRJkFdIKQuEGDfAZIxlA1j7jOv1BuA+pVccJNCIAdgBCkdnqbpEJ1xqrka9dMhHHHwGEQK5ZVyMfLlmox/5goGVw6e71YCfNLXi0FhtIJF+zt/GpcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2290.apcprd04.prod.outlook.com (2603:1096:203:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 16:46:27 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 16:46:27 +0000
Message-ID: <8016293e-5100-1cda-89ea-8a9b5491132a@quantatw.com>
Date:   Thu, 10 Feb 2022 00:46:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/1] arch: arm: dts: update bletchley dts
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        Allen Wang <Allen_Wang@quantatw.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220209100413.23714-1-potin.lai@quantatw.com>
 <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
From:   POTIN LAI <potin.lai@quantatw.com>
In-Reply-To: <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cee2994-8483-47c6-70a9-08d9ebebb6f7
X-MS-TrafficTypeDiagnostic: HK0PR04MB2290:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2290783BC91D3C53520855A78E2E9@HK0PR04MB2290.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFx3wG86HE/j9K+ceZV5h8aJ5C9gUOe7P2wxIwG6S92GaIv23wi8CC6+cAE2AN4lcJ+Z0hbbJaPqobBDLl8K3n9HWB2Wn/8/CPvVPQxMQ8IUfOV1htPDqAfgxaNt88TdrVS7RUiFsQSNsgORW7K2vp/D+yjXdSfaTednv1d4AY01bpD8L5Fvl6P6ch2sbk3E51t47fcA8VMWtVWrQRogMGBmyHJ01PCmGODFCJMNo04+CuN0CP8vYql3GEtDIxjJlserg17VWbOSrza5SBcQ+/i03aiGmVdA8/WLakGhawZ3cR+13i8mgQC7ZgtRifRPYFw+M4s5fYjWMPuLWl8mZqRhcogRpgzJCHg4Pysyn30AjciBe4nKViil/uppfG728BicJpCgUpDRBiANT7QBUgTzeBGr2SSRFCbWLdB5NHj2kw4foYLxEThMNFp9ZDu6+VDyv4Cl9n3H7i031a9B8RE6NuMcjIobNtEUhb57eue5/NShN9A3wApZj3Hf+aIWpTbKxdID7/Q1lQo7P4hNqp+lddvEHsmjVYZzHOtl4Y94CALcwTSMB9FnYRwk5Wc0QtXD6ZlY7EXO21fJbzhYQjdUPhaB2JLDgGk0IVAxaLcixJoPmQDYVqLzNCYUnUrn3Zu0L+OIyCz8fGAHXCSR8P+k9X6QiJuQMS95ku9E/mpdblAIRTsu2YjkglZsU0H/jpbfTMbuvg1pjCZJedHjqrttmV84/H2f9VO8JKwRFeN+LR2iXvYfEgjatf3RaW8IhkuoP/Cyx+wrhPvN5MWRelHiGVwnfTx59UKQ2HIs6W8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(31686004)(4744005)(15650500001)(5660300002)(6506007)(53546011)(38350700002)(508600001)(6486002)(52116002)(38100700002)(31696002)(8936002)(186003)(6512007)(2616005)(26005)(316002)(54906003)(36756003)(4326008)(8676002)(66946007)(66476007)(86362001)(66556008)(11716005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTEyMEE5ZzVhZVNiaHBoZEx5RVB3VlpPVzVQcHllSmYzZXR6MTk0K2REZld6?=
 =?utf-8?B?cHo4SVROU3Z0a2RFdUZrckU1dlQzU0FMSWdiZkJENXlOejJmUkRNclgwZkZK?=
 =?utf-8?B?Q09Oc3E1d0N1MkVBeWdHZ2Z1bkw4U0QzZ3pia0t3QUpxK3ZBS2d3NmxaWlk4?=
 =?utf-8?B?NDcrSmtienpYUnMrVldFVlhyMVhDV2NLNHcyNEVuWVJ0Vm0zMkhsVStjNThV?=
 =?utf-8?B?M0dSdENTbTVTdFlybTJTMnRTam9LRUhOcFcwMTRJV2F0R25CVkdoVlE2ZzZS?=
 =?utf-8?B?c3RFR0FlYlN1ajZmdkRCR2VTVGZkTEg5Z25ySm5PWUh6WlArL2NOUll0cmpE?=
 =?utf-8?B?eXJOMUp4ZGl0NUhhNHRaR0VUcHEvRVcrbzYwV1VPd2tCc3RaM2NoSVZsK3ZZ?=
 =?utf-8?B?cEFndmw3WmFlcGJybkZ2N2IwYjF0MWtFM3VlOXUzNDd0UGE0a0xiZEo3aXlJ?=
 =?utf-8?B?clBlMVJmdVVXUEtVYS9td1JFU1BjWHVYMXVGNVZwRGkzUVVHM29VRlg4T1VU?=
 =?utf-8?B?NytkdUNaRUpHanBkSWR0TFZxdGxoUGYyMkxVT0o4U3RqM0F2bTJ3eGwya1hw?=
 =?utf-8?B?QXMvMFF4L2ZWWElwckhoc1MyTm93bVpLdU9uZXZSTzdEbHFDMDVKY1A4WTZr?=
 =?utf-8?B?dSt2RlNqMmNzcHlHblVJT2Jpc3oxMVQ3ZXowQVlGaktQWXBsU2dISzZxSGV1?=
 =?utf-8?B?OTl1K3ZKRjVWQlU3VlJFcHdLTlhzU2dkY1NLVU1QdlBPbytSdDY1aThURERF?=
 =?utf-8?B?RmRuY1BYR1JuRDdzay9EcnNYcm5nYlV3YnFPazRKSFd4VUEvdm5kb1k4K3FB?=
 =?utf-8?B?cHMxQnh0TFJBT29GRy9CVEhjVEExMnlSMitkcEZxcnJnWitBenJuMEtZellJ?=
 =?utf-8?B?RVBMR2FpZ2NSbk41blBpWEJYZ3ZDVkFSNmMrbDFyY3RsNnlzdmh2dHFvR09h?=
 =?utf-8?B?Z25tTEFJeU5pbU11eTNnbUhhc1lqQ3YwV2daWm1yZEc5c3RnRk54ZGlPQTZY?=
 =?utf-8?B?b2phMmxJNnhEUmNTQlZ0R3BNcDJxZWQ1N0llNHZSKzNTcjk0K3Y3VDlDb25y?=
 =?utf-8?B?cjZTUlhqdVhSUkRuVmRIYlVrSE9pa2JCZ014TUFPRDI4RVdZejhRRGlUU1d4?=
 =?utf-8?B?TnhRdG5kRithdkhYcVA4Y093dUp6RHQwRTNLd3NoRGtFY2JvUzkrYlc4RnpU?=
 =?utf-8?B?RkhXQitEcE1wd092YnUzemRtMWozMkJ1cUMyQ3NrWWxCdWR1VXZzVGJLMk0y?=
 =?utf-8?B?OXpDU01mamR3SUVLb3JsalhDdUUwcUgvR3lid2VzSnBmcGlDZFV5elFqRjhr?=
 =?utf-8?B?UUVMK0hVRDJMUUZacGxpWHRWMFpOaE00VGlDeSthMzNxMXgyY1Fwd3F0a2hD?=
 =?utf-8?B?eE14VFBINmVQcW9wTkJDMGpSMTR5MXZqV0d0cGdCVUlaYk10UFZCbTZPOGp1?=
 =?utf-8?B?MHRzajVtQ3RabGt6RmxhdWt0ZGo0ejRtcTQvSWxla0UyWVFJQThQR21MamJx?=
 =?utf-8?B?dTJ3cVdmbUFYUUFtSU9LRHZIQUNETnBwUk8zN3hVa2xoOW13SWpHMzRsWmJ1?=
 =?utf-8?B?TloyS0ZoQVFyL052Y2FFeCtBUVF3OExkekRGWXpzNkg5d1d5V3NJR0RBald2?=
 =?utf-8?B?N0hzUkJBZURpaHJtM0t2dTJ5RFN5dS9Yem9EOGdWMGN1cnQ3RExmczVjWmhI?=
 =?utf-8?B?NFlOMHM5T0F2VytZc1VISjR6Mm5jeGtQMC85Wkw5UUtkRTlqL0ljcGxESDJ3?=
 =?utf-8?B?RkNZZWRVQVR4ZzdtQ0JNdzM1UFpMYjY3OE9sRGc3UmlnUHk1V3FYUmVtT1Bk?=
 =?utf-8?B?cXF0VnMvYkY0dElnR1BwQm5vYnd1OWNKV3Fhb1VLNy9LaFRQekxMNmgwWllz?=
 =?utf-8?B?WGduUDB6RGRhWVdSS3BkMWwvK1YzWXAxMUd0UWpITmF6RS9FNWlwZUpZbmtj?=
 =?utf-8?B?bWo4MjhYWVNoakl1MGJzMHZzaERwMlFFcHVuZkhvTnVLYXlaeWtmMFpNL3hR?=
 =?utf-8?B?OUdzWUVraU5NRlVweU00M2NrWDFVZHdhMHpnMENEcG9ZSDRUR3lVK0lIb1Nv?=
 =?utf-8?B?MFJLUFd4Y3FqbU1LT0s1eEhVNlpFa0FnRkVrNTJCa3ZOcmRxOWtxQTZRNXc0?=
 =?utf-8?B?Rnl4dk1kMUtOdkNOM09VUEVoL0FJVEtxR1d2NEVMSWY3OWMwb3dObVB6cGI2?=
 =?utf-8?Q?Kt7d1VGdtzZzIqXNfeeFgIE=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cee2994-8483-47c6-70a9-08d9ebebb6f7
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 16:46:27.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIv/j7q5TdqXKfuXTG6X70W52D19iKjTeVF4HSyRiKmzmqXoeQX0KvTlagHswgDoHmmx4Yh6/t93m2cU1dRZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2290
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Herring 於 9/02/2022 11:33 pm 寫道:
> On Wed, Feb 9, 2022 at 4:04 AM Potin Lai <potin.lai@quantatw.com> wrote:
>> updates:
>> * seperate leds into multiple groups
>> * switch sled numbering to 1-based
>> * disable inchip rtc
>> * add flash1 in fmc
>> * switch spi2 pnor using spi-gpio
>> * update gpio-line-names
>> * add interrupt pin for each sledx_ioexp
>> * enable mdio3
>> * update ADM1278 shunt resistor (300 micro Ohm)
>> * add INA230 for each sled
> Please read documentation on writing commit messages. Answer why you
> are making the change, not what you are changing.
>
> Each bullet should probably be a separate commit. The question to
> answer is are there compatibility issues (what happens with old DT and
> new kernel and vice-versa)?
>
> Rob
Thank you very much for advising, will update this patch in new patch series.

Potin
