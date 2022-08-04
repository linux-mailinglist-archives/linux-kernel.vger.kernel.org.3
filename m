Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1B58A04E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiHDSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHDSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:11:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217BA4F186;
        Thu,  4 Aug 2022 11:11:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o1so178939qkg.9;
        Thu, 04 Aug 2022 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=37y1pNEyQ+ddREX5K3poWhk+osrjYe1S/O8gGeEYV/s=;
        b=XcUgUM14PB1rlQx8PWU05XJdYwxpGH95vXAU1vNxBwwBGgsb5J9xX61pPBfV5V0ddc
         B7uuHsIwFNy5VdzmEYs4+v0lNIQlUJ6IzCg7B7ZWaqgKH4X7jJRzYmPjW/FR/1C07hGo
         FKzCQMGlZWq+oqTg8J7e1JhAo+VZI5vqD5FPqDoSnHqrx73iRxwiN/AvprUf7LNTAU1X
         4Q7Sven4ksdBwjhdXUYtHz7xsS6X2PwGc8/ZTzGxwninwdSkfyx3kgn4/ReO+Iqf7FGh
         mbLetj4EdRfGkqqGzSfpDINsGjm8KWaH37ksejtLjGWJ0IvHnBU2zckAVGIHuWW2CGJ+
         JX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=37y1pNEyQ+ddREX5K3poWhk+osrjYe1S/O8gGeEYV/s=;
        b=Gty95mr6roseTlWV+BUpnulVPyS0TPqgdXCzs5NIjQKRPO5OQKVblOwu7HlaSdt7rF
         BYmc9u/yn+E89BpLEuldveapqt68W0LJT0nG/jeObBZQJQflXqu9/HsZFxgyMsxqgFtU
         DOWA3S2cXKaHQUy7Ij8PLNHOMiQZcmWAnmK864hvFOXFYVUzcSZD2ikc6oSWYAhYVPs3
         nj7Apz3Z/IHPL0Eaylqo/UUcNAcdzdVBY8eTkOWIfEaupn29SDyJVcubtFgxGN9naoD3
         7j6pXIq6Qg6J1rRjvpCD5gdKV7EM97lR6Ua+XA5h023p9sWLXyYTkrAoU8kv/GBr1Kg6
         gj0A==
X-Gm-Message-State: ACgBeo3NcMAMs7iTpbaPAqxqt1feITrszhEAcz6yk10073oU1u7uFo6w
        WOawIok/5NOir04rVM2iTDk=
X-Google-Smtp-Source: AA6agR4EMHKVAO4xz80mWJI5XkyalMXnqJMhr9DdtUfGt7By7jtilYYT3BzC5TDnMIh6vEefcLO2sQ==
X-Received: by 2002:a05:620a:bcc:b0:6b6:5746:f8f9 with SMTP id s12-20020a05620a0bcc00b006b65746f8f9mr2334700qki.729.1659636688203;
        Thu, 04 Aug 2022 11:11:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bx7-20020a05622a090700b0031ef67386a5sm998062qtb.68.2022.08.04.11.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 11:11:26 -0700 (PDT)
Message-ID: <143a7faf-70fc-010f-bdbd-9f96f918c280@gmail.com>
Date:   Thu, 4 Aug 2022 11:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] dt-bindings: soc: bcm: use absolute path to other
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-2-krzysztof.kozlowski@linaro.org>
 <a70148d3-c87f-969a-b743-11c679d161d3@gmail.com>
 <d83f7689-303f-cecd-882a-ed6e03a8db5b@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <d83f7689-303f-cecd-882a-ed6e03a8db5b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 10:31, Krzysztof Kozlowski wrote:
> On 26/07/2022 17:59, Florian Fainelli wrote:
>> On 7/26/22 04:58, Krzysztof Kozlowski wrote:
>>> Absolute path to other DT schema is preferred over relative one.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Are you applying those patches or do you want the SoC maintainer to do that?
> 
> The best if  you (SoC maintainer) would pick them up. If you cannot or
> it is too late for this, maybe arm-soc could grab them (already Cced).

Arnd ended up picking up patches 1 and 2, FWIW.
-- 
Florian
