Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F7551FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiFTPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbiFTPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:06:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DD12AEE;
        Mon, 20 Jun 2022 07:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqSJna0ZQi5N3UF/4QmSemlEiIUTH+2Be6WuIIyHjqTmeZqBWLoi1EggCvGIafJ/QOujLzXuQQq5818diwCkqlYF+log0Q7v5Kg89CP6nLhXonsig3j7IgYRTjUq0SS7cqcbcFipOmZgxKC/xzKQBXu1Sn9Fx4A6XWNXVa7dKPuVWCQrxoPFErStV4WIpeTF+o7gr86oPeZFEqSdxfE29AeDLgpHFdIO3keJl1uWdVghUhPvPetexBZSxByK4yCShhzK5CuMCJTFANPUfl3YVuy2R2D2XwDtoHPcq3sa8FvAVrzhj4tdTdcidfwLMRlusXprO5bGfpa71C8rD+Vb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgpiwkovJymeC+YfQqa3JWZ4H38AES2mVNmFIrKrrOU=;
 b=joKYL0/5/+x+YZ6cjc5S1wkRpMlX1bBjmAd5PP1ByEPY16sReOVziS608OQyVvsgtWQ9SUVeyEvrhiRAu+xAqerKqTS8T7sNPFYZvWXmQOlYkzoWOnT6gHstySuLQoi6YDwgumvVDBSYkr3tUMrLei+NaiOMyfpjsyra5V1em9B99VOpZHUDx3UF7Dm1ZgTZ9y/wnqN5vOrBQTUn0QKOy6L7wcjIipCd+l6rlBIZmK6ZoKUaU8cxp63bFxEQtJR6x3gzxLJ4hkCmq1YJrTECKGTGFMfUlpyc3rhTOy2AXd8SU4KOeKY5afShpUzIv7MVt9o1xpYDyE9vUEtssgQbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=precisionplanting.com; dmarc=pass action=none
 header.from=precisionplanting.com; dkim=pass header.d=precisionplanting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting365.onmicrosoft.com;
 s=selector1-precisionplanting365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgpiwkovJymeC+YfQqa3JWZ4H38AES2mVNmFIrKrrOU=;
 b=U7iPT0nBk3NiJBxM8/g/4Rp6OBYx3zIf1LopzScbLneC22bjkswFg2SxZPZfSHb+RSkfbckGDBBUJ25UP1PYQ2SkfYrmU1uzUZ1/H8HpbwcQrqb0H4OOkMAlhsW9UqEZhh6w/20rd8RKJsCulx0YS2+553t8cVhK5IfE/BoCVz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=precisionplanting.com;
Received: from SA1PR22MB3196.namprd22.prod.outlook.com (2603:10b6:806:22b::8)
 by CO6PR22MB2865.namprd22.prod.outlook.com (2603:10b6:303:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 14:42:36 +0000
Received: from SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0]) by SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0%5]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 14:42:36 +0000
Message-ID: <59135ae7-47a5-986b-99e2-6f10e4954fa6@precisionplanting.com>
Date:   Mon, 20 Jun 2022 09:42:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        David Owens <daowens01@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
 <46297969-8d1e-15d5-69da-db9019718c24@gmail.com>
 <6506993b-40ac-883c-71e1-707f2e1f647e@gmail.com>
From:   David Owens <dowens@precisionplanting.com>
In-Reply-To: <6506993b-40ac-883c-71e1-707f2e1f647e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:610:b1::11) To SA1PR22MB3196.namprd22.prod.outlook.com
 (2603:10b6:806:22b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7dc60c-4813-4a9d-304c-08da52cb1e1d
X-MS-TrafficTypeDiagnostic: CO6PR22MB2865:EE_
X-Microsoft-Antispam-PRVS: <CO6PR22MB2865F0D084350FF67D6032E2C0B09@CO6PR22MB2865.namprd22.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cuq9WcnewxIqFNmLFr+6uqo83SgyvIRwtAg8/tYKT8vwvxhwmhhEXXpt4tgoOuMXQBlA21JFu2ZvqTvcop3qY75etEm+gQIVZ74hvZXD20bTGrYy+7Fcr2k9b8xDpOBhIyySP8uDIPqNOTOk3bWy3PTbDprSCsAAeFiKRXPd//CztcqY+dRPg4ELMkcdXS6xrf40ZE6JeNNviQH/UwfR2OuZjr1F9HC9LcvMjtM9/8EwgOj0zGn7UHcmKOK6dRHER6nEroVI38qpgi1IDqzwHaJq7IInk8UzcrJ1p5xPx0JiAXtGO/fdzm6yqHO78fgZ4IH6VSgv0tDtiA6SB4KnpgKXd6dlWc804cXfZ8zUhslVOVhL19dTCM1MQdJcI6HVjOu+91OLyDiZSVEHkOYq1CN5vY0V1MRgAZcds+690OdOZub/7Zug/YFb48g7JTKnzuV068jcLfxcDEzo5cTkeDp/0mx65OCyla+R/DUp9Oj6UNwHR+ixOnPI+I/AtRdaBTl9NCgA3SA+YoXbQ3HUfSfKi5KJGqSB3V+l5FgvdRuFuJfiqP5hwUQYcukSuzh+A0+832LekwBB1zVMLmttczMu2yozZkwLLtQuArTmmUdcFbP7Grmf0ALfiD+r3QV+mZu18k8n4vJMsKw+FUcSnmXvtqMj9EE/OrCvMdPLHcCTt3nzqQf52Qsj87AtK+iFZjx9R6/ODZ5WdUIzMmOJg/Ti8F2WB1RsMntXkJ1lMQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3196.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(53546011)(2906002)(38100700002)(6512007)(5660300002)(7416002)(8936002)(186003)(52116002)(110136005)(2616005)(6506007)(86362001)(31696002)(36756003)(498600001)(66556008)(31686004)(83380400001)(6666004)(6486002)(4326008)(8676002)(66476007)(66946007)(66574015)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhSY0phK2k0Q1M0NzRvclVkQ3FmYTdLNzBaRnh5THBQVXhsMlk0MEhkRkIv?=
 =?utf-8?B?M09pcDhpTWpjZzdRZXdQZm55YmxGSy8zb1BIc1RkUy9sSHFBRnIzT3J3MmtQ?=
 =?utf-8?B?WW9mWURvaHJZamFRK3F1cktIbHljNUg3SVM1c0pLejFWWlhzSithNWpjb2Ex?=
 =?utf-8?B?bW5JZHBTQ1FqdDV4d3pSck1nbmZwLzBUeWJCTHZYbk5HaXFIWWpqMTR3U0xX?=
 =?utf-8?B?TXR0cnJJNnBCN05RMElZZytsNDR6eDlkR09GOXBjYmx6SHYrY2JPMGNYMDIv?=
 =?utf-8?B?akgvTU1MV3NGUDFWd25wMXVzTkNFMHBEZUtZeVVrMjVBNndKK21aWlltamJt?=
 =?utf-8?B?VjdzazF2U2VMQWN2VSs1ZzhXOER0NStraFZMMUt4aUJCV21LTXhwR3h4RTBr?=
 =?utf-8?B?Mlh0L3NaSWFrWHIyalN4OGMvQ2hGOU1kUXJQQnJMYmM0cFZDRzBYL1VnT05X?=
 =?utf-8?B?Nlh0RFB3ZytqTVVGZzJLb0hGSjg3cDJYaEFDSFY5RWlJZno3L2VMQU4zanpi?=
 =?utf-8?B?T3Z0QTExZjlwbmdGQVRmOEpBMmJ3Uit2emJ1dkhWTWd2L0p3N215M2VzY3dS?=
 =?utf-8?B?Y2I4RUVRQ3o0NncwWUt5QzY0ZG9MNDE3UkZ2bytwTnFDUVZvZHlMTkZkcmt5?=
 =?utf-8?B?SWRCQkIvYnRjYS9iTDl2VFN1MU1ZeC9wc0Q1Qm05bU1ORCtjMUswejRkQ3VR?=
 =?utf-8?B?b21pNXlEajBGcTRTYWl5WkZlNUttUjR6d3VyUURySGwzaWxnRnJCTWhsbmJk?=
 =?utf-8?B?cTZBdnlxcDUxOUF6V0xSREZURWRXaEs5UEhBN25ZUHltYTlwOGlLZWZOLzg5?=
 =?utf-8?B?VGdtbSswTUdMMGVVUmVIalZNdjRHejVhZlNuYytVRS8wT21mTm0yUWducE1X?=
 =?utf-8?B?UE9hK2NjdzdHSnpsbFVoUTY5UzNjVXFkSnlKZko1eDZYRmZpWTRlUDYzdlpO?=
 =?utf-8?B?SGpvWkFRK1JNWDB2ckhmUURIelI1QTloRmZ4MUY1OG1uVUZmRmdQTjgzWnQ5?=
 =?utf-8?B?eER4T0lBaWxEOGsveFJmVnA5TEl4aERKbWcyUlhuRncxdGZuUkdlejJiYUtI?=
 =?utf-8?B?cURReVZTeEZtK0RsSDAxTEMxTU5xelNJSTZ2KzhRYUxja2NqbFR1UksvZ256?=
 =?utf-8?B?UlVFMGtBSWxTb0s1ajRMQWRhUjJPdVJTTklnZ2xlZVZYQVVPZzZxRjFIRnh2?=
 =?utf-8?B?d20yZnhNYWxYZDVjQlliNEg2MHhKZHJBUXd1QVpLQngra0ZQTFIvK2ZTV3Nv?=
 =?utf-8?B?eGh2eElMRzN5M3RJeWFIU3VDRWcwZmdjSi92OS90VkhQdHd0bFJ4Q1hDWUE3?=
 =?utf-8?B?RkV5NFNLUzRhNmFxcU51NTlScU1Sak5KLzBWOXFhWW5aWnRVNVYva3JGYU5i?=
 =?utf-8?B?TU9zQ2NFcEFnK3JHdmFybVVoTDdhN2VncUxYOTlHbXZXMS80T1luWndjcnps?=
 =?utf-8?B?THVDcXd5NGlTeVZ3YXVkUTNXei9oczY2SFVjUnlhRGd4THZKNHFySG5icmt6?=
 =?utf-8?B?c1JnL1RtK2pvVm9QbGdKSkc0WWJCRUtseFRzc3FWK1lWQWFsSnMvSi9EbW5w?=
 =?utf-8?B?S2NlT29pNmlBUzZSOUV4ekp1ZTVsZ2ROR0tkcW1pVk1qZXBDdnc4L2J5dGta?=
 =?utf-8?B?c0Q5bDhFb2FKbWUxQUVXMUl3ZmpMWkZjS2hiRy9hSnl1SVJNZGNkV01WNW05?=
 =?utf-8?B?VGhjR1lNNEhzbEJ3ekg0ZEg0bU11Nmg4SVBnWFIyUURXZEZLeVRPTHRkOFdp?=
 =?utf-8?B?OW9Wb3kwcjdjN3BITGpmblhJNTRvRUN6MHJPY2sxUVJuV21CNnF6Sk40WmRv?=
 =?utf-8?B?VzJHczExd3pVMG9QZ3JvNEVlS3o4NmduUmhnZndQWkZZeWx2d2l0OU5qUEw4?=
 =?utf-8?B?VjV1YStRL2V0VUl2YTUzRnJkeDBJLysxcU9QK0dWVmdzOHloaGJ0cWdZY243?=
 =?utf-8?B?QzZTblg4aWpYSC9FY1dRTFhqSDY0Z1NaQTVUTDd4UTZvQlYya2RUT3JwcmxR?=
 =?utf-8?B?SHBydHh4YWdQWHBjWk1vYzdVUmRVNWRHN1JSSURlaFZya2tEUFowc0Q2aE1m?=
 =?utf-8?B?dUdWd0ZpRFljOXNvM2daV2o4b3Q1UW0rVittbzh3OExiZmZ4Q3RNbTBFdXVE?=
 =?utf-8?B?amhlOXgvUEk5MDBHWjgyM1R1cjhrKzQ2TzBGOTV3S0x4akk2cEkvV0QvRDN2?=
 =?utf-8?B?S2QwWFVwVVdabEtveUxweW1BM2ZQMzR0TjVPNHFlNGdzb3dBVW5TMEFCUmsz?=
 =?utf-8?B?ZXZHK0hUbFZ2UG1PcDJ2QnB3b0tmUWJPblhHcS9WMlpTK25pdEhFZng2SFky?=
 =?utf-8?B?NDBpMThFV3NhdXBTREZ3MlRySFRFa1lHdFhQeDN5TE45ckJES3BuVElka1kz?=
 =?utf-8?Q?hE0Zm+ko8WXs49tpkM2AAorW7Yo7q39vlSNNKvHK4dKnd?=
X-MS-Exchange-AntiSpam-MessageData-1: ccdZwyARyIDJF++18hn3Gx+kxwIN5+yFKrM=
X-OriginatorOrg: precisionplanting.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7dc60c-4813-4a9d-304c-08da52cb1e1d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3196.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 14:42:36.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa593af2-61f8-4d4f-988a-e9c4c02b7f57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BMaUG6EkoSaenxYyf6ZhLh2sGSpdIRMzPHIx/HQcIF6vg9/J/inCD3QHnCzslynFcTvy30OnGthDqXATpBaCt4syerNsio+bcbskZAeKuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR22MB2865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 01:36, P=C3=A9ter Ujfalusi wrote:

>
> On 6/18/22 09:26, P=C3=A9ter Ujfalusi wrote:
>>
>> On 6/16/22 23:26, David Owens wrote:
>>> Convert to managed versions of sysfs and clk allocation to simplify
>>> unbinding and error handling in probe.  Managed sysfs node
>>> creation specifically addresses the following error seen the second tim=
e
>>> probe is attempted after sdma_pcm_platform_register() previously reques=
ted
>>> probe deferral>
>>> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp=
/49022000.mcbsp/max_tx_thres'
>> This does not compile (on linux-next)?
> The foillowing diff is needed:
>
> diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
> index 402a57a502e6..bae4f67165c1 100644
> --- a/sound/soc/ti/omap-mcbsp-st.c
> +++ b/sound/soc/ti/omap-mcbsp-st.c
> @@ -296,7 +296,10 @@ static struct attribute *sidetone_attrs[] =3D {
>       &dev_attr_st_taps.attr,
>       NULL,
>  };
> -ATTRIBUTE_GROUPS(sidetone);
> +
> +static const struct attribute_group sidetone_group =3D {
> +     .attrs =3D sidetone_attrs,
> +};
>
>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
>  {
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 176abe4271e9..6fcd860778e9 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -601,7 +601,10 @@ static struct attribute *additional_attrs[] =3D {
>       &dev_attr_dma_op_mode.attr,
>       NULL,
>  };
> -ATTRIBUTE_GROUPS(additional);
> +
> +static const struct attribute_group additional_group =3D {
> +     .attrs =3D additional_attrs,
> +};
>
>  /*
>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.

Thanks for the recommendation, P=C3=A9ter.  I was under the impression ATTR=
IBUTE_GROUPS() resolved to the same attribute_group struct as the change ab=
ove but perhaps that's not the case.  I'll update the patch and resubmit.

-Dave

>
>
>
>> In file included from /home/stens/work/kernel/linux/include/linux/kobjec=
t.h:20,
>>                  from /home/stens/work/kernel/linux/include/linux/module=
.h:21,
>>                  from /home/stens/work/kernel/linux/sound/soc/ti/omap-mc=
bsp-st.c:12:
>> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:18: error=
: 'sidetone_groups' defined but not used [-Werror=3Dunused-variable]
>>   299 | ATTRIBUTE_GROUPS(sidetone);
>>       |                  ^~~~~~~~
>> /home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in def=
inition of macro '__ATTRIBUTE_GROUPS'
>>   154 | static const struct attribute_group *_name##_groups[] =3D {     =
  \
>>       |                                      ^~~~~
>> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:1: note: =
in expansion of macro 'ATTRIBUTE_GROUPS'
>>   299 | ATTRIBUTE_GROUPS(sidetone);
>>       | ^~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[4]: *** [/home/stens/work/kernel/linux/scripts/Makefile.build:250: =
sound/soc/ti/omap-mcbsp-st.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>> In file included from /home/stens/work/kernel/linux/include/linux/kobjec=
t.h:20,
>>                  from /home/stens/work/kernel/linux/include/linux/module=
.h:21,
>>                  from /home/stens/work/kernel/linux/sound/soc/ti/omap-mc=
bsp.c:12:
>> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:18: error: '=
additional_groups' defined but not used [-Werror=3Dunused-variable]
>>   604 | ATTRIBUTE_GROUPS(additional);
>>       |                  ^~~~~~~~~~
>> /home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in def=
inition of macro '__ATTRIBUTE_GROUPS'
>>   154 | static const struct attribute_group *_name##_groups[] =3D {     =
  \
>>       |                                      ^~~~~
>> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:1: note: in =
expansion of macro 'ATTRIBUTE_GROUPS'
>>   604 | ATTRIBUTE_GROUPS(additional);
>>       | ^~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>>
>>> Signed-off-by: David Owens <dowens@precisionplanting.com>
>>> ---
>>>
>>> Changes in v3:
>>>  * Whitespace changes only to allow clean applly
>>>
>>> Changes in v2:
>>>  * Improved error handling
>>>
>>> ---
>>>  sound/soc/ti/omap-mcbsp-priv.h |  2 --
>>>  sound/soc/ti/omap-mcbsp-st.c   | 21 ++++-----------------
>>>  sound/soc/ti/omap-mcbsp.c      | 26 ++++----------------------
>>>  3 files changed, 8 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-p=
riv.h
>>> index 7865cda4bf0a..da519ea1f303 100644
>>> --- a/sound/soc/ti/omap-mcbsp-priv.h
>>> +++ b/sound/soc/ti/omap-mcbsp-priv.h
>>> @@ -316,8 +316,6 @@ static inline int omap_mcbsp_read(struct omap_mcbsp=
 *mcbsp, u16 reg,
>>>
>>>  /* Sidetone specific API */
>>>  int omap_mcbsp_st_init(struct platform_device *pdev);
>>> -void omap_mcbsp_st_cleanup(struct platform_device *pdev);
>>> -
>>>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp);
>>>  int omap_mcbsp_st_stop(struct omap_mcbsp *mcbsp);
>>>
>>> diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.=
c
>>> index 0bc7d26c660a..402a57a502e6 100644
>>> --- a/sound/soc/ti/omap-mcbsp-st.c
>>> +++ b/sound/soc/ti/omap-mcbsp-st.c
>>> @@ -292,14 +292,11 @@ static ssize_t st_taps_store(struct device *dev,
>>>
>>>  static DEVICE_ATTR_RW(st_taps);
>>>
>>> -static const struct attribute *sidetone_attrs[] =3D {
>>> +static struct attribute *sidetone_attrs[] =3D {
>>>     &dev_attr_st_taps.attr,
>>>     NULL,
>>>  };
>>> -
>>> -static const struct attribute_group sidetone_attr_group =3D {
>>> -   .attrs =3D (struct attribute **)sidetone_attrs,
>>> -};
>>> +ATTRIBUTE_GROUPS(sidetone);
>>>
>>>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
>>>  {
>>> @@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev=
)
>>>     if (!st_data)
>>>             return -ENOMEM;
>>>
>>> -   st_data->mcbsp_iclk =3D clk_get(mcbsp->dev, "ick");
>>> +   st_data->mcbsp_iclk =3D devm_clk_get(mcbsp->dev, "ick");
>>>     if (IS_ERR(st_data->mcbsp_iclk)) {
>>>             dev_warn(mcbsp->dev,
>>>                      "Failed to get ick, sidetone might be broken\n");
>>> @@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev=
)
>>>     if (!st_data->io_base_st)
>>>             return -ENOMEM;
>>>
>>> -   ret =3D sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group)=
;
>>> +   ret =3D devm_device_add_group(mcbsp->dev, &sidetone_group);
>>>     if (ret)
>>>             return ret;
>>>
>>> @@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pde=
v)
>>>     return 0;
>>>  }
>>>
>>> -void omap_mcbsp_st_cleanup(struct platform_device *pdev)
>>> -{
>>> -   struct omap_mcbsp *mcbsp =3D platform_get_drvdata(pdev);
>>> -
>>> -   if (mcbsp->st_data) {
>>> -           sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group)=
;
>>> -           clk_put(mcbsp->st_data->mcbsp_iclk);
>>> -   }
>>> -}
>>> -
>>>  static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>>>                                 struct snd_ctl_elem_info *uinfo)
>>>  {
>>> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
>>> index 4479d74f0a45..395493a2d965 100644
>>> --- a/sound/soc/ti/omap-mcbsp.c
>>> +++ b/sound/soc/ti/omap-mcbsp.c
>>> @@ -595,16 +595,13 @@ static ssize_t dma_op_mode_store(struct device *d=
ev,
>>>
>>>  static DEVICE_ATTR_RW(dma_op_mode);
>>>
>>> -static const struct attribute *additional_attrs[] =3D {
>>> +static struct attribute *additional_attrs[] =3D {
>>>     &dev_attr_max_tx_thres.attr,
>>>     &dev_attr_max_rx_thres.attr,
>>>     &dev_attr_dma_op_mode.attr,
>>>     NULL,
>>>  };
>>> -
>>> -static const struct attribute_group additional_attr_group =3D {
>>> -   .attrs =3D (struct attribute **)additional_attrs,
>>> -};
>>> +ATTRIBUTE_GROUPS(additional);
>>>
>>>  /*
>>>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
>>> @@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *=
pdev)
>>>             mcbsp->max_tx_thres =3D max_thres(mcbsp) - 0x10;
>>>             mcbsp->max_rx_thres =3D max_thres(mcbsp) - 0x10;
>>>
>>> -           ret =3D sysfs_create_group(&mcbsp->dev->kobj,
>>> -                                    &additional_attr_group);
>>> +           ret =3D devm_device_add_group(mcbsp->dev, &additional_group=
);
>>>             if (ret) {
>>>                     dev_err(mcbsp->dev,
>>>                             "Unable to create additional controls\n");
>>> @@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device =
*pdev)
>>>             }
>>>     }
>>>
>>> -   ret =3D omap_mcbsp_st_init(pdev);
>>> -   if (ret)
>>> -           goto err_st;
>>> -
>>> -   return 0;
>>> -
>>> -err_st:
>>> -   if (mcbsp->pdata->buffer_size)
>>> -           sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_grou=
p);
>>> -   return ret;
>>> +   return omap_mcbsp_st_init(pdev);
>>>  }
>>>
>>>  /*
>>> @@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_dev=
ice *pdev)
>>>     if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
>>>             cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);
>>>
>>> -   if (mcbsp->pdata->buffer_size)
>>> -           sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_grou=
p);
>>> -
>>> -   omap_mcbsp_st_cleanup(pdev);
>>> -
>>>     return 0;
>>>  }
>>>
This email is intended solely for the use of the individual to whom it is a=
ddressed and may contain confidential and/or privileged material. Any views=
 or opinions presented are solely those of the author and do not necessaril=
y represent those of Precision Planting. If you are not the intended recipi=
ent, be advised that you have received this email in error and that any use=
, dissemination, forwarding, printing, or copying of this email is strictly=
 prohibited. Neither AGCO nor the sender accepts any responsibility for vir=
uses, and it is your responsibility to scan, and virus check the e-mail and=
 its attachment(s) (if any).
