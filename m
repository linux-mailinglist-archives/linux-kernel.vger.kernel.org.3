Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8D4C86A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiCAIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiCAIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:38:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8193D4B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:37:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so290969wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Bjp8bu/V7hHD3VpGYDoJC/mynoVixsr7Wlp3VBAAB34=;
        b=jB9dTHl0ZbrDHcOJJ2GrOdlzNievMcIiRarIbozNdeG/rG/9w0KyeHH6oqa9lAbBj8
         i8vXhXAKaIxGpv2kFYuyN9LKpGE/aDfk9oulyWVsmEGC52wAa6NYYAq8tmA4g8WZ5X2o
         AgCqygCuF2s1QommkpmXIBDAiVrBmuX1ntoUB2fJ1n8qHA9/uXFomGPAeA1d0s6jbeHc
         ZVknLWbNur9Yo/8UyBRDRLkPe5oSAMiP8jEjnohPoAXUaxQiA3XbFDs6B6XAwhI5lKx0
         gfWa/hkniGYeMuerIRY1eMFZp+1oRGEE2kIvabz1+B7lg0dLzw57IPYPAk0IJkQp4wS3
         Ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Bjp8bu/V7hHD3VpGYDoJC/mynoVixsr7Wlp3VBAAB34=;
        b=Mh1Hfc3JSl4uksoZj9CiR1T43mTiQPPKWKliGpw/jfus2u40M5aijhiLXom4nGGmAj
         U4DdvPs0c0jLxuza7FB7e9oLTNW3blv3s4w2/ReomEe1Bf8bumAOPu5lA6vO3lklfXwT
         bEHgXYqd0ZvcOi9Ac/3DizWuPcFjSS286f2I7npYuwvcT05axE40HYzac2nR0hXYGhq2
         SZpg2deTEcGsYh6qbuQRz5NkeYGc465S882BrRDuxD0R91mMcuIu6b5K0zLhF/9QEUeM
         XgN6kzx/Ipk6ptZr+Og5tYpGIexuUOgRIsZRICh6D+EooMd0Ole5PZ8oC7jAKJzehD5T
         MscA==
X-Gm-Message-State: AOAM530ly0v1rZuh5E9P6ogX++lSafesbsxt3jqM6F+DmuK15CN9sHd+
        zC4I3aioCT5FxEnRM9VVDZ7oLA==
X-Google-Smtp-Source: ABdhPJxJUGFf/M6eRzGrrAlQbwPmgNpu3MAZhl/EtCY7Va6S0HfFZiOQ1EyGDusS9fkFzLu+OlIwTw==
X-Received: by 2002:a05:600c:19c9:b0:352:d507:9e89 with SMTP id u9-20020a05600c19c900b00352d5079e89mr16067204wmq.92.1646123877623;
        Tue, 01 Mar 2022 00:37:57 -0800 (PST)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y7-20020adff147000000b001dbd1b9812fsm18249092wro.45.2022.03.01.00.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:37:57 -0800 (PST)
Message-ID: <5f7d9d73-d74c-1eb6-1711-ac3de67e6203@baylibre.com>
Date:   Tue, 1 Mar 2022 09:37:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <849a95fd-ae81-9a3b-0c06-dd7826af9eb2@baylibre.com>
 <154c3e60-f111-6760-aa08-b9851d66b034@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <154c3e60-f111-6760-aa08-b9851d66b034@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/2022 08:57, Yu Tu wrote:
> Hi Neil,
> 
> On 2022/3/1 15:25, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> Le 25/02/2022 à 08:39, Yu Tu a écrit :
>>> Using the common Clock code to describe the UART baud rate
>>> clock makes it easier for the UART driver to be compatible
>>> with the baud rate requirements of the UART IP on different
>>> meson chips. Add Meson S4 SoC compatible.
>>>
>>> The test method:
>>> Start the console and run the following commands in turn:
>>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>>>
>>> Since most SoCs are too old, I was able to find all the platforms myself
>>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
>>> G12A and S4.
>>>
>>> Yu Tu (6):
>>>    tty: serial: meson: Move request the register region to probe
>>>    tty: serial: meson: Use devm_ioremap_resource to get register mapped
>>>      memory
>>>    tty: serial: meson: Describes the calculation of the UART baud rate
>>>      clock using a clock frame
>>>    tty: serial: meson: Make some bit of the REG5 register writable
>>>    tty: serial: meson: The system stuck when you run the stty command on
>>>      the console to change the baud rate
>>>    tty: serial: meson: Added S4 SOC compatibility
>>>
>>> V6 -> V7: To solve the system stuck when you run the stty command on
>>> the console to change the baud rate.
>>> V5 -> V6: Change error format as discussed in the email.
>>> V4 -> V5: Change error format.
>>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>>> in the email.
>>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
>>> the DTS before it can be deleted
>>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
>>> discussed in the email
>>>
>>> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
>>>
>>>   drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>>>   1 file changed, 154 insertions(+), 67 deletions(-)
>>>
>>>
>>> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8
>>
>> Could you send the emails To Kevin, Jerome, Martin & me, and put the various lists in CC instead ? otherwise we are not notified when the patch is accepted by the tty maintainer.
> The fact is that sending is adding you up, you see
> Link: https://lore.kernel.org/linux-amlogic/20220225073922.3947-1-yu.tu@amlogic.com/

It's not the point, the order of recipient in Cc and To is important since they are used
by maintainers to track patch for review and to notify when patches are taken in their tree.

So please make sure the recipients are correctly set before sending the patches.

Neil

>>
>> Thanks,
>> Neil
>>

