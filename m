Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C74F85B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbiDGRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346022AbiDGRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:18:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2ADB2EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:16:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u14so6236194pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CzjnguXiadlz7eUY9Kx6829Is7Jt6JaiEaPs+5sqqTA=;
        b=FJ1qN4a5bVhIVqPz+llJc+3m0NxSx14176vB3YwGMMqbFFd7DF300IuvPiiFbY3DYI
         jlfeGcnzmuptkWrsHOCwZAcOAFceTx3nM3m7kJDHX4w3s1kdb3hn4NBYZfJPiPwV8fVv
         fLHh0HqH3V31MlMTLoxyGq1UUGxwhgaOsQkKaNLUOucnXuRK1xX36Ryy5fIjdInxDw6+
         r57NNFPjU0p00GyZxiIJndYJfs4csq6zOhkkpYRHWkxKQpxJZw7Q6/R2+N0D+EfQhwYF
         cULrVncucRpwZTcwYOJOwPcjqlAUmUV+TIW9dfl2teEOwLl2nIAQpm6mb3DcvOt/WuaW
         uLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CzjnguXiadlz7eUY9Kx6829Is7Jt6JaiEaPs+5sqqTA=;
        b=C9c7SbkzDH+0xr1KL5PaEbzHVZlUI/sYeoKN3qnyEv9qJKDUsMdw1b42UVEU05wO5H
         wEGq8lMUfLc0ivbZ55EKWqgtdg+o5mbj+9+U1XjejwzlU6Lh6TtEfkZLsTrMjeurpeCM
         Gz8LVzfk2RJSPy1udeXz31XGnJjoSFtwuD5Nf94PFt2rbHGJc4eWBiOMSzrZnBWtLsPL
         UkPaK5XTPklR2dZnuMaogSKBLBCAWpZGDvHEXhziR5CBCK5cOuy7c4ofC8pyLMZ/1fQe
         5aldN59Q7KIntVL1kZ67rWe+2zWhIhnLmxbZDtm95maEi8foHkdHTyrhg7K+1tp8S8gV
         BELw==
X-Gm-Message-State: AOAM532y6jH2ME9P+rrrTnZbUPW1cNpi6uZYTBY3L5Iwd7hvMAfMCFmf
        8iJEOy+ZJ+jDBqn4jc5mx2A=
X-Google-Smtp-Source: ABdhPJwP7cEeCx5ye1HcJ+QRcDwu2/wTSd5heTYmutBYTgXHY7Lzwr/v9H4cd8Np28CzJsv60CRj4A==
X-Received: by 2002:a17:903:205:b0:157:c51:12cd with SMTP id r5-20020a170903020500b001570c5112cdmr3342521plh.94.1649351806027;
        Thu, 07 Apr 2022 10:16:46 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id il3-20020a17090b164300b001c6d5ed3cacsm10209485pjb.1.2022.04.07.10.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 10:16:45 -0700 (PDT)
Message-ID: <57747e9a-10e0-e4f6-0644-5225396802f9@gmail.com>
Date:   Fri, 8 Apr 2022 02:16:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
 <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
 <96dae189-c0ff-4054-3d00-41c3b44c2cd6@gmail.com>
 <Yk8Ktyyt0veW4g+j@sirena.org.uk>
 <f86a10e1-b5a7-5c59-8e53-cec65d97234b@gmail.com>
 <Yk8TLUnEHRKstyxq@sirena.org.uk>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <Yk8TLUnEHRKstyxq@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/08 1:37, Mark Brown wrote:
> j
> On Fri, Apr 08, 2022 at 01:11:22AM +0900, Akihiko Odaki wrote:
>> On 2022/04/08 1:00, Mark Brown wrote:
> 
>>> That bit is very common but there's still machine specific aspects - is
>>> the required hardware wired up, if it is wired up how exactly are things
>>> wired (separate microphone jack, headset jack, one of many jacks?).  A
>>> lot of the machine driver part of things is about labeling things so
>>> that it can be displayed in a way that's easy to connect to the physical
>>> system.  Generally the machine driver would define a jack and then
>>> connect the CODEC to it.
> 
>> Whether the required hardware wired is told from the user of the codec via
>> jack's type specified with snd_soc_card_jack_new(). The other details live
>> in the codec.
> 
> So I'm confused about what problem this patch is intended to fix.  It
> really sounds like there's some issue with the driver not using standard
> interfaces that you're trying to work around but the changelog is not at
> all clear.  The "doesn't use DAPM" bit is a bit of a warning sign, it
> sounds like the audio signals to and from the CODEC aren't being
> connected to the jack properly.
> 
> Look at how other devices with jack detection hardware handle this and
> follow a similar pattern.

The situation actually seems quite a mess. You can find many drivers not 
using DAPM pins by searching for snd_soc_card_jack_new() calls with 
num_pins argument is 0. ams-delta-audio is exceptional as it adds DAPM 
pins later with snd_soc_jack_add_pins().

They do not have kcontrols for the jacks. The only exception is 
skl_hda_dsp_generic which calls snd_jack_add_new_kctl() as my patch 
does. Looking at other devices is probably not helpful to find an 
alternative in this case.

Regards,
Akihiko Odaki
