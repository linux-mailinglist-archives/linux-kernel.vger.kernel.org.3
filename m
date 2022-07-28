Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1D584092
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiG1OHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiG1OHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:07:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401CB7F1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:07:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t17so3087074lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XURwmQrh3pi3kMw2kzj18VPxjyFA7fJIbFKY450RC7I=;
        b=qRGvHVeB02lb7PCsFuzh7wZCEHah7TU2JwUE6V6ElvhENbjDki89kU8OEIUZ9iWGFC
         BUuOdg76Z4r7uFqKrGaPCwzWTmcBvk9XDMcEiDZ0uVVWX9bHcw3Qws+QNr2wb/a8Cvmn
         xgGzp/9b0Gaqfbf4COE+OfjCye3EM3WZhCfiOyFKtXbfdtTnmEjhQLik0UXkLFeoWW2O
         A1IAF/qiguMdPPIsVAfRHk4l8yeTSxQFg4Lbt9nbrWBNCa4tVyi20KDydOuAFbqmHr7h
         9Kqvwe0Lab0ngMkz08xS302Z5j2hEzgP/FNAccSHtTZhfQYWgPFv/q8i+SRHJwldY3qv
         XKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XURwmQrh3pi3kMw2kzj18VPxjyFA7fJIbFKY450RC7I=;
        b=NMhCJtIv2Jsc/J/riXuwPXfnD4/7KO7w3iidKnEL2XxzPLu7zYklCxb268lH8OKai2
         gQ1bRkNN17qr5mIxObpEhDWW3Q8iNv7nX3H5fS++JMcNLsAeagVG68vTDa7yvZEJIznM
         DloDxb3ZZCzNwqaHRDReQ7WPiK6pWloFRMnqHTFkxVTzfaouxOiTr0EVdePouUIRAU1V
         wm/oGuJA8t5mN5CBmictJTBlmlnuQjpXvnNroLR48HOhHEW2uKpOsXxxWWpv2P5hXLbA
         1Ipb2/dXsfVLRXyMLwzUhl2NKhvbHRZUeXPtEZSXeLJEk997uQ0X+f1eWRMU++1woppq
         AVfg==
X-Gm-Message-State: AJIora/58XIYYGLg38baNzJHgcqJgcbbyLa56SwQQrpN7DbVnx6jv/FA
        Zt/gSiiheMRTIHyhyIC9/e8Aaw==
X-Google-Smtp-Source: AGRyM1sfj4KYcQ5fKo9HTWhxAnNgSyXWMVlNIWukceO//mHIgTAQ3IqTgcBO/4pGY1LTDh/sHPwfgQ==
X-Received: by 2002:a19:710b:0:b0:48a:cf83:7551 with SMTP id m11-20020a19710b000000b0048acf837551mr334407lfc.137.1659017264043;
        Thu, 28 Jul 2022 07:07:44 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05651c231200b0025e119e9276sm158570ljb.99.2022.07.28.07.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:07:43 -0700 (PDT)
Message-ID: <24964892-d421-6104-c72a-187b484f99c6@linaro.org>
Date:   Thu, 28 Jul 2022 16:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] drm: panel: Add novatek nt35596s panel driver
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Molly Sophia <mollysophia379@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220728023555.8952-1-mollysophia379@gmail.com>
 <20220728023555.8952-3-mollysophia379@gmail.com>
 <1685ecd6-cfe7-c2f1-add5-6bfff055fa06@linaro.org>
 <YuKUNeazoho6LPTJ@ravnborg.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YuKUNeazoho6LPTJ@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 15:50, Sam Ravnborg wrote:
> Hi Krzysztof
> On Thu, Jul 28, 2022 at 02:17:29PM +0200, Krzysztof Kozlowski wrote:
>> On 28/07/2022 04:35, Molly Sophia wrote:
>>> Novatek NT35596s is a generic DSI IC that drives command and video mode
>>> panels. Add the driver for it. Currently add support for the LCD panel
>>> from JDI connected with this IC, as found on Xiaomi Mi Mix2s phones.
>>>
>>> Changes in v4:
>>> - No change.
>>>
>>> Changes in v3:
>>> - Embed the support into existing driver (panel-novatek-nt36672a), as
>>>   these two IC are similar with different initialization commands.
>>>
>>
>> This does not go to commit msg (---).
> It depends...
> 
> In the drm sub-system the general rule is if someone cares to write it,
> then it deserves to be added to the commit message.
> So for drm patches it is perfectly fine to have the history part
> included in the commit message.
> 
> These sub-system differences does not makes it easier - I know.

OK, but I find it weird to store "No change" in commit log :)


Best regards,
Krzysztof
