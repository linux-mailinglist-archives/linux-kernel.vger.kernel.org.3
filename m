Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CA5A612C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiH3KwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiH3Kvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:51:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670DF14D8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:51:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k22so10910189ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=e1hN6u3b87oGXUwDtR5NW7sGRX93ClE7I6RCTP747nA=;
        b=sFhnzPlIb+FancITooLULAVcUz2hglMvTCtBdqmvF6tRXgvAEbWlhSrvThObhZU2q2
         jJSlV7xiDXzCi1OhH+CbH2oX4NSQaBosZUrZH8OZXRkh6wQvT0GsN99m1WeGZDqlUbxC
         v7nhR8BT/K7bZDNBZAsViBbsXje9xPNjOhbHyvAdxl1tt3WR4k45pW9nInvcotXVin/C
         hPBZwrfhcIzfj2WLJGIJMLhjsMiIsmlH61Ya+/bfKBbFvvew6B549EjXqLoIY7ajmlj5
         who8iAH3DWXRqaHIInSE1WPuEIR4XFood7iCMz1HSYmHpj5E9RG1jhh3iPRy3hC9Danm
         oANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e1hN6u3b87oGXUwDtR5NW7sGRX93ClE7I6RCTP747nA=;
        b=ssZF3NoGngiq+DxLdHd1zvM/1eJ5BhiSYQFZFYdU2v3U47yQf6p1T0Q6hFWzntekP0
         KI3TUMCgoH/H3KPeYeWPoIbLaT77N0jDs+RB8o7BgUFOBDpzS0f82txez21oVK3H7GF4
         DOisE2vbnQ/JDngKfgCBlKbZQam5zMoIH3TbLwSPUNQD0Z5N5AFZLiCZI9BAR9CO3JXB
         b4+khkvCNaC5+LHKoxOK0DMfJCtzDOjCIE906SBko0hRrE13/zKGASrkyx2vIoCTHZgM
         nM4ERcdwwmbmvbxZKOIT2mQWZY+xc8qoK+jnyljXa+P0qcT6hpex6R1mE3GPKYI5Eaqy
         ceOw==
X-Gm-Message-State: ACgBeo0zlxi3ApipNyRgi5mSywfWCnyrkZZDBqPuWvZAzes5owRgXggV
        EY9cvhJd9V7SPqMRtRWvDGtN6g==
X-Google-Smtp-Source: AA6agR5v0PT16Rdmu1bSg98MXyeZl7RNSOvY0CUjkIpj4W8Ea2EcduQQvevDfM4Dpo6TfmHeijnijA==
X-Received: by 2002:a05:651c:105a:b0:267:5d3d:2b25 with SMTP id x26-20020a05651c105a00b002675d3d2b25mr823185ljm.370.1661856678233;
        Tue, 30 Aug 2022 03:51:18 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004946bec4e61sm684730lfs.140.2022.08.30.03.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:51:17 -0700 (PDT)
Message-ID: <34fd836d-56f1-3d88-0571-349aef95fe96@linaro.org>
Date:   Tue, 30 Aug 2022 13:51:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
 <YwkSi1IIRsW2Hc/u@sirena.org.uk>
 <a5266af6-af19-48f9-8bc6-94c171ba6d0c@linaro.org>
 <Yw3oA6pVp3PMxfA3@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yw3oA6pVp3PMxfA3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 13:35, Mark Brown wrote:
> On Sat, Aug 27, 2022 at 12:02:39PM +0300, Krzysztof Kozlowski wrote:
> 
>> True, it's not the same build coverage need as subsystem/interface
>> dependencies, but still:
>> 1. Drivers can be built independently, so why not?
>> 2. There is no drawback in allowing to building them independently
>> (compile test).
>> 3. The parent MFD device could also depend on something (RK817 and
>> MFD_LOCHNAGAR depends on I2C and OF; CPCAP on SPI), so it's not always
>> the case of just enabling parent. IOW, you can compile test codecs
>> without I2C and SPI which is valuable itself.
> 
>> I find the last reason actually quite valid and applicable here. If you
>> wish I can add it to the commit msg.
> 
> You've already found one case where there's a dependency being
> pulled in by the parent, I suspect there's more.  There's a
> tradeoff between getting coverage and having to deal with the
> noise from randconfigs.

Yeah, that was my mistake because did not spot it has "select
REGMAP_I2C". For such cases the benefit is indeed gone.

Best regards,
Krzysztof
