Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E855A5E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiH3IiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiH3IiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:38:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B7C3F6E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:38:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so14534751lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HSZUxHwCGXDS+YuMOYN3fC24hcB2oY1H5zuoWsqqM3w=;
        b=n+eKbYTIBNe3EM3mnDh1hTflPnd90wGSG9Kf+vrhw+c1QaVrIerEWdpQQ6WmKxt0N7
         3VvEmPIJppEBfoUWXgfTduKkXNfnsjiHVEgzGUH8qsqSqjk4sPYjwvlNKqGxSmAQlVap
         W9N7+ZMe3mtYVJqnYm+LNsJfSWep8s6LCvsQFkmOpD+SQu/eui+vSDVE48tFnQvxflpP
         H6AQ7vAFudHIq9Phghsd6nZJI7prO9V8t9vsoO45tB4vypFswu0OM91dx+YvzqKU5bW2
         PiTYc6CPfH53TDTYar85meKEkKnNZkb4AlDU8mWo06STg8brg7BX9zQojyMX8ImBEkOR
         +70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HSZUxHwCGXDS+YuMOYN3fC24hcB2oY1H5zuoWsqqM3w=;
        b=iRTmjwzUWVvXLhzynoO+v+0gpqjAh2REVcHYThQ+JZhOC7iLwmQHr7SqnAnCZ5ssw+
         yEK9TWKN1UieRK/JgNRW/xZOiGZcrqxH07y/hT3VBI8l9DozpcbD+CCKRDs2Kv8l5ojc
         HMEityjGtxx9ALfK/Hxolj32nVQsV/t+WtIlF+0MzIGqijsp8cr4tGozUewadNncnIns
         aXt2Yj3Q8pOD59vRyJ4zCkQWqqo7sh8aY/8NsIUYxHMhMMCzKgU3pvZpDPnK+OogcIkn
         34ciAgrdmc4IZrY7SN49RP1HtFAq9wKS+xOANCusgLMAyeGPnLGJ/0b7s2UHVmp3MG82
         QrXw==
X-Gm-Message-State: ACgBeo0teTGMgvtwzKC7gMtV1rs9vVoPtD1sydcJx2CfMoOaJ1I2JbiQ
        HVOhC12L6dl3UIcC1vGyU+BYng==
X-Google-Smtp-Source: AA6agR7rVhoMtBWs/WDW6GvyBUIi7qOebcd9mjD6Lbw5VMXpYKEN65cTa/Ckvnt1qwsGu1ZzqFMRpA==
X-Received: by 2002:a05:6512:1109:b0:494:68f3:c84 with SMTP id l9-20020a056512110900b0049468f30c84mr3342142lfg.84.1661848681296;
        Tue, 30 Aug 2022 01:38:01 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id k9-20020a2eb749000000b00261eb75fa5dsm1698843ljo.41.2022.08.30.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:38:00 -0700 (PDT)
Message-ID: <89b203ef-1f00-d4d0-b824-5cefcef808a7@linaro.org>
Date:   Tue, 30 Aug 2022 11:37:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819152904.433514-1-oliver@schinagl.nl>
 <YwzJMAaYT/frJLaT@ada.ifak-system.com>
 <20220829151334.GA1596856-robh@kernel.org>
 <59a3b7d9-1886-f237-8a6a-374de17da1b5@schinagl.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59a3b7d9-1886-f237-8a6a-374de17da1b5@schinagl.nl>
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

On 30/08/2022 11:30, Olliver Schinagl wrote:
> Hey all,
> 
> On 29-08-2022 17:13, Rob Herring wrote:
>> On Mon, Aug 29, 2022 at 04:12:00PM +0200, Alexander Dahl wrote:
>>> Hei Olliver,
>>>
>>> Am Fri, Aug 19, 2022 at 05:29:04PM +0200 schrieb Olliver Schinagl:
>>>> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
>>>> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
>>>> added. However, there's a little more very common LED colors.
>>>>
>>>> While the documentation states 'add what is missing', engineers tend to
>>>> be lazy and will just use what currently exists. So this patch will take
>>>> (a) list from online retailers [0], [1], [2] and use the common LED colors
>>>> from there, this being reasonable as this is what is currently available to
>>>> purchase.
>>>>
>>>> Note, that LIME seems to be the modern take to 'Yellow-green' or
>>>> 'Yellowish-green' from some older datasheets.
>>> Just noticed you did not send this to neither linux-leds mailing list
>>> nor the LED subsystem maintainer. Maybe you want to do this in v3?
>> Yes, please do. If Pavel doesn't pick up v3 in a timely manor, then I
>> will.
>>
>> Rob
> 
> Sorry to both, get_maintainers didn't pop those up!

Indeed, I sent a fix for this.

> 
> As Krzyzstof Acked the v2, and no comments for a v3 have been proposed, 
> would that be a changeless v3 just to involve all parties?

Yeah, just resend with get_maintainers output based on
Documentation/devicetree/bindings/leds/ (or on top of my patch).


Best regards,
Krzysztof
