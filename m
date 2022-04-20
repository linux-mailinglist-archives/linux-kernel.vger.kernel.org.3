Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F297508970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378545AbiDTNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbiDTNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:38:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FF1AE48
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:36:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bg24so1963910pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lXdyjsZwzid6gzFZsYx+3FvAzRzuWVqc4HAM59uiv4I=;
        b=TrZDrs3kSql9sib4o8UH2aejnB9lVPUBoAig3WO81PdWJ8jQpG2MxBkFcDMf8NBWou
         /FVnq8rG4GwfPxJSFY8qmtnxlBvSPNaxIQ47Z0BjaV3alza9bo2WSBMOLtDknFzUpYwH
         J7MIq8ULFWzX4lVq/3p62Vrqu3mZK9H4Mvsl9jA/DNBp8NaYXXQxol/qLJhIu3CzGIvL
         MzK/u0YsEw3JXizDM3rHwfPp/35uCo+BpDRmPsVRPQ62kmC9RR4mKLX1zmx8QvGzBReX
         znz0RqTRuVVrF19Hg9nEY8q/N1Ubm6cUnFI+NnsyAbIxpa0z6m9DPhbarakYNydJR1/K
         ffQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lXdyjsZwzid6gzFZsYx+3FvAzRzuWVqc4HAM59uiv4I=;
        b=U9Ouyl+Aeccqkufb+uvvhk/FjhoQ9btEkEwbH0E0yFVgbZ/Rqonq+ZvxgS71/WZsjr
         +dcplMsA2gPpUSp5us9Vo74otmjvojvK970dpYKnDx3f8yQEYx+jVhsxQwZiFDdtPmP4
         yAwtXl119rYLPLs2ieBvfV/OK78BIklY49flUMJbvj9WE+e0sD9SGkeH98RGfY40pQhY
         3E5+DNWTiPJ5N0Arka9qhbjZEMMyU93xIZ4gPuP9V6ADKbOaeTOYpmkxQ2wPnOXZSLFQ
         RacG55g3f5ULd4zfHkKH/V1HyxWMePYUC4E9K2LwjQxsUbt1beKwGId8oalCLu8WJfBW
         hVjw==
X-Gm-Message-State: AOAM530ab/cyrUXcCcdt3uAGBLl8lJD4jdfSHWiuCE0u3j1zJKce1Hxp
        UdUi2ZrQ7aB6aKxkV8rraD4=
X-Google-Smtp-Source: ABdhPJxtsG9w1ifLwHhGzp8j2IssoTIdZkBYyWeL5HF0RqiBvpRYeBJtoZ/6uVakf9ISJs8wuN4Uxw==
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id m20-20020a17090a7f9400b001cb1853da1bmr4470119pjl.14.1650461766581;
        Wed, 20 Apr 2022 06:36:06 -0700 (PDT)
Received: from [172.16.10.243] ([106.39.150.10])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00235300b0050a858af58fsm10143884pfj.145.2022.04.20.06.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:36:06 -0700 (PDT)
Message-ID: <4e3309d9-879f-3385-3e8e-0fa1a31ddd9a@gmail.com>
Date:   Wed, 20 Apr 2022 21:35:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
 <20220420021855.8224-1-linmq006@gmail.com> <YmAD6MIuKdjgm7Yu@sirena.org.uk>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YmAD6MIuKdjgm7Yu@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/20 21:00, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 02:18:52AM +0000, Miaoqian Lin wrote:
>> This will call twice platform_device_put()
>> if both platform_device_add() and snd_soc_register_card() fails.
>> return early on error  to avoid duplicating the error code logic.
>>
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>> changes in v2:
>> - use return statement to return early when fails
>> - rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP")
> Why rebase on top of that seemingly random commit?  Is there some sort
> of dependency here?

Hi, it the head of master in when I made this patch. It's because you pointed out

that patch v1 doesn't apply against current code. But I am not sure what's the problem.

So I ensure the codebase is up-to-date. If this patch have no conflict, you can ignore it.

