Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB515546DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351532AbiFVJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiFVJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:39:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833C3981E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:39:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f16so14124734pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eZuimc27f8Pqx0RQsLsBHNNfdo94Bdud+D0vm/+ZMoo=;
        b=f3EUpz+z/jQCeQOfMlCi4fu48cWtjwc5zZts00M/IAooB248+eqwZ6DzU9QTIe3OsW
         jDJJqg0F/Rfqc51dYAJH0MK815A80X+jYQ1Xh3mpWVMdVtkRZmXQw+HgOv1Yq5zRCiUx
         8ztsdUrs5WA1vYg1CRQpe6vIuQKXpVSX6u50vO5JFSwXSPl47MhJr6bpqS7TQSyCOP68
         jzOtW20ZKz82c7fpY41nIby7jvFBFaIqp3/0+yJnf/1P0VlvkhdZP6GP5UQl8t5YJH4M
         4WcA0JM6/4DXPx/IZZyYshdnMO3syo9fv+Evzywc2meEBedhFcBdrEd4GgjtfJwbsTr/
         kV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eZuimc27f8Pqx0RQsLsBHNNfdo94Bdud+D0vm/+ZMoo=;
        b=G40+w7udnkKaBsuYRkOR9Xm2op5H7smJ8W2zyOUGaOGb8Hqgo17XyAoAfHjscdHhSu
         /XpjyEdtctXXZgglROvmnWIRJLEbDdnSgSEDe+nZq5mxtZLGkrLePUuw/9hGeaH3QaM3
         PNo8Y3Wv8a2BVTjGZFWUX4Dq9E3Xh7BhUJy3WFzrXbFdMUfD5NCL0PfiDv/j0WLlHLaS
         6hoObijtLKkdLkYu/bOigtIKP8QBNIS+bRD2y6vBfZdntnmM9IVBY0buVltSWEv13gVw
         GprrxWLduTnDXQ5BCSgQWY8YVjjmj5hNba0H3lnB5odTtpJzAyA1lRXrF8nqXp8db1wx
         auoQ==
X-Gm-Message-State: AJIora+wxjEcT1iN4tZF31MlEGWo/k6UUFVUksMXlIeXgZh1ofLP/0jb
        Pox0M3W36fubfG5PXQO4gzk=
X-Google-Smtp-Source: AGRyM1tOJUJ0/GTAXewuQvGrQZ1e6hRCejFVbD6cTCC9SUCX6WgFrfI7uoAsm1gZqn21xccAS9icfg==
X-Received: by 2002:a17:90b:1e44:b0:1ec:cc44:be77 with SMTP id pi4-20020a17090b1e4400b001eccc44be77mr8043387pjb.34.1655890761985;
        Wed, 22 Jun 2022 02:39:21 -0700 (PDT)
Received: from [172.16.4.182] ([219.142.145.112])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b0051bd9981ccbsm12904842pff.39.2022.06.22.02.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:39:20 -0700 (PDT)
Message-ID: <e0b562d2-fd93-647f-0980-ceadb3a48677@gmail.com>
Date:   Wed, 22 Jun 2022 17:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] irqchip: Add missing of_ndoe_get() in its_of_probe()
Content-Language: en-US
To:     Liang He <windhl@126.com>, Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20220622062138.4095598-1-windhl@126.com>
 <87mte52khd.wl-maz@kernel.org>
 <229e8ea9.5a09.1818a7b7a35.Coremail.windhl@126.com>
 <87letp2j9e.wl-maz@kernel.org>
 <1b3e9050.5eb9.1818a8c64d3.Coremail.windhl@126.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <1b3e9050.5eb9.1818a8c64d3.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/6/22 16:34, Liang He wrote:
>
>
> At 2022-06-22 16:29:49, "Marc Zyngier" <maz@kernel.org> wrote:
>> On Wed, 22 Jun 2022 09:15:56 +0100,
>> "Liang He" <windhl@126.com> wrote:
>>>
>>>
>>> At 2022-06-22 16:03:26, "Marc Zyngier" <maz@kernel.org> wrote:
>>>> + Miaoqian Lin
>>>>
>>>> On Wed, 22 Jun 2022 07:21:38 +0100,
>>>> Liang He <windhl@126.com> wrote:
>>>>> We need to add missing of_node_get() for of_find_matching_node() to
>>>>> keep refcount balance.
>>>>>
>>>>> Note: of_find_matching_node() will decrease the refcount of its first
>>>>> arg.
>>>>>
>>>>> Signed-off-by: Liang He <windhl@126.com>
>>>> [...]
>>>>
>>>> Please send these refcount fixes as a series for all the irqchip
>>>> drivers, not one every other day.
>>>>
>>> Sorry, I will group similar bugs  in future.
>>>
>>>
>>>> And please synchronise with Miaoqian Lin, as you are obviously both
>>>> chasing the same bugs.
>>>>
>>>> Thanks,
>>>>
>>>> 	M.
>>> Yes, before I send any new bug, I will confirm that this bug has not
>>> been reported in lore.kernel.org.
>> This is not what I meant. I am asking you to actively coordinate with
>> Miaoqian, working with them as a team instead of you both sending
>> competing series. I would like to see one series with patches from you
>> both.
> OK, I get it. This depends on Miaoqian.

Sure, I would like to work with Liang to fix these bugs.

>
> @linm006@gmail.com
>
>>> By the way, this is a bug missing |GET|, not |PUT|, which is
>>> different with Miaoqian's and my patches before.
It's a nice catch and I haven't noticed before.
>> Well, yet another reason for you both to work together, as you are
>> complementing each other.
>>
>> Thanks,
>>
>> 	M.
>>
>> -- 
>> Without deviation from the norm, progress is not possible.
