Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6724523A95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiEKQqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiEKQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:46:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B253E5E6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:46:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d6so3266983ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xj1N8tp59EX/rZwMqCjY9hqLN8tIPGoout6wfaBUGxU=;
        b=cEEp6hmcXVVy4ZSFnPIvcfzIhYDzl89wvKJCGlfQKoYnT906ulI1E3Ys9qSnpoZ5GA
         DvvHDxEvAPRvyyGpSH/YiU0FkJ9Z7FjHY7+t3lpKJ1GW9i7VvfHmLacWDhT30XvQaDO4
         ILdr/4KY2ViUgv+KSGUzzfvdKwXUy9EdyMFJ1dPceMJACuUFJr1KKwa75VK/dOn+TC+r
         dqWsHuTdtOGZrV+RRpntH47USzG21WJKwGNN1PYGMVrcAsH52neWig8wEbRDqbHZGJq8
         RfUUXtsp5g1HLsXgpVYiy+kQ4phSE1uwZv+SF4GAHuq6KZLDixLGx4sAzYuqMv1IChW9
         5n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xj1N8tp59EX/rZwMqCjY9hqLN8tIPGoout6wfaBUGxU=;
        b=kq3e7tE2caZjpFhe1RhnqdQ+3b0P78ZnkcjAQdNJkLQMNGrWzhbsUg/jvtlFV97A7h
         MuOzE8khnvoSJd4aRC1j0eABWxUXksmvTSdw8ZnbGHxsneyLvEliJjAroILWzNxy++7D
         4efhVTj67AXxRYylWAXIyBVzIwsQ6/htoJJWgssycpN6dLLfSGUSCwjnO4vR+63LllU4
         JE5hOwO5zNk/if2dERywsxP+Rqs9KzR9S/v/Oc2okfRhb8Z/wNZQN3B/s1UwSKs8Qvj8
         6RzcCVYvxe65hYbTdvc1LM0WJw2hKiogyvg6Ts7TZQMj8LcC36cTNo2FXfBdp+JJBxEO
         +QnA==
X-Gm-Message-State: AOAM5311uf39xTAQVlm0M4WTyvBLZxh4jYASOF7q8RoACMsTX/K7OvBj
        OXRv78MhyTnsnJ2rWmUnp8tROw==
X-Google-Smtp-Source: ABdhPJxCXNZvBC03q83kl+F9j8XLH2Ll7BgJt1C9jpNbQv4w1Vv8ths6fhK0V/yL0ur+y8MJw5RLZQ==
X-Received: by 2002:a50:8a96:0:b0:425:e046:76d9 with SMTP id j22-20020a508a96000000b00425e04676d9mr29906154edj.115.1652287602823;
        Wed, 11 May 2022 09:46:42 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q20-20020a50c354000000b0042617ba639fsm1480656edb.41.2022.05.11.09.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:46:42 -0700 (PDT)
Message-ID: <72897af0-6f03-cf25-d84b-830020973a4c@linaro.org>
Date:   Wed, 11 May 2022 18:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix
 keypad driver
Content-Language: en-US
To:     Gireesh.Hiremath@in.bosch.com, krzysztof.kozlowski+dt@linaro.org
Cc:     m.felsch@pengutronix.de, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
 <20220510141306.2431-1-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510141306.2431-1-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 16:13, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Hi Krzysztof,
> 
>>>>> both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
>>>>> my openion is not to merge both.
>>>>
>>>> IMHO from the user/system-integrator pov it is looking the same and so
>>>> one driver should be fine. To distinguish between both modes we could
>>>> add dt-property or add a new dt-compatible like "gpio-matrix-keypad-v2".
>>>>
>>>
>>> as mentioned above our keypad is not complete matrix keypad  and it will
>>> not be compatible with matrix_keypad diver. that is the reason we derived
>>> mt matrix keypad driver.
>>>
>>> to avoid confusion, we will rename the driver as bosch_mt_keypad.c
>>> if you suggest.
>>
>> Sending a new version while discussions are ongoing is not how we reach
>> consensus.
> 
> I apologize for sending new version.
> 
>>
>> Make the driver as part of matrix-keypad driver or bring real arguments
>> why it cannot be merged.
> 
> I tryied to put real hardware scenario which used in 
> Bosch Power tool measuring devices.
> Keypad schematic as below, it is reduced matrix keypad compared
> to standard matrix keypad 
> 
>                      Pin8 (gpio1 16)-----------------------
>                      Pin7 (gpio1 20)--------------------- |
>                      Pin6 (gpio1 22)------------------- | |
>                      Pin5 (gpio2 21)----------------- | | |
>                      Pin4 (ground  )--------------- | | | |
>                      Pin3 (gpio1 31)------------- | | | | |
>                      Pin2 (gpio1 23)----------- | | | | | |
>                      Pin1 (gpio1 24)--------- | | | | | | |
>                                             | | | | | | | |
>                                             | | | | | | | |
>                                             | | | | | | | |
>     |------------|---------|----------------- | | | | | | |-----------|
>     |  Button1   |         |  Button2         | | | | | |    Button3  | 
>     |      _|_   |         |   _|_            | | | | | |       _|_   | 
>     |  |--o   o--|         |--o   o-----------| | | | | |------o   o--|       
>     |  |                                      | | | | | |             |
>     |  |         |----------------------------| | | | | |             |
>     |  | Button4 |            Button5           | | | | |  Button6    |
>     |  |   _|_   |              _|_             | | | | |    _|_      |
>     |  |--o   o--|         |---o   o------------| | | | |---o   o-----|
>     |  |                   |                      | | |               |
>     |  |                   |------------------|---| | |-----------|   |
>     |  |                                      |     |             |   |
>     |  |------------------------------|       |     |---------|   |   |
>     |                                 |       |               |   |   |
>     |   Button7              Button8  |	      |    Button9    |   |   |
>     |      _|_                _|_     |	      |       _|_     |   |   |
>     |-----o   o-----|--------o   o----|       |------o   o----|   |   |
>                     |                 |                           |   |
>                     |                 |---------------------------|   |
>                     |                                                 |
>                     |-------------------------------------------------|
> 
> 
>     ____________________________________
>     | Button  | Pin activation| Keymap |
>     |----------------------------------|
>     |Button1  |	    1,6       | KEY_7  |
>     |----------------------------------|
>     |Button2  |	    1,2       | KEY_8  |
>     |----------------------------------|
>     |Button3  |	    7,8       | KEY_9  |
>     |----------------------------------|
>     |Button4  |	    2,6       | KEY_4  |
>     |----------------------------------|
>     |Button5  |	    3,4       | KEY_5  |
>     |----------------------------------|
>     |Button6  |	    6,7       | KEY_6  |
>     |----------------------------------|
>     |Button7  |	    1,8       | KEY_1  |
>     |----------------------------------|
>     |Button8  |	    6,8       | KEY_2  |
>     |----------------------------------|
>     |Button9  |	    4,5       | KEY_3  |
>     |----------------------------------|
> 				
> for Button5 and Button9 we used standard gpio_keys.c driver.
> 
> Button1,2,3,4,6,7,8 are not in standard row and column format,
> found difficulty to apply matrix keypad drive to these button.
> 
> to solve this we came with vendor specific driver like
> mt_matrix_keypad.c by taking matrix_keypad as reference.
> 
> after your review comment I felt it should named as
> bosch_keypad.c to show as vendor specific.
> 
> in this driver all gpio lines act as row as well as column,
> a key can be placed at each intersection of a unique row
> number not equal to a unique column and they are diagonally
> symmetric.
> we can skip keymap for the valid intersection of gpio and
> invalid keymap for row equal to column.
> 
> the matrix table as below for above schematic
> 
>     ------------------------------------------------------
>     |Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
>     ------------------------------------------------------
>     | GPIO 0 |  X    | KEY_9  | KEY_2  |   X    | KEY_1  |
>     ------------------------------------------------------
>     | GPIO 1 | KEY_9 |  X     | KEY_6  |   X    |  X     |
>     ------------------------------------------------------
>     | GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
>     ------------------------------------------------------
>     | GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
>     ------------------------------------------------------
>     | GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
>     ------------------------------------------------------
>     X - invalid key
>     KEY_x - preferred key code
> 
> 
> in Device tree we avoided row and column 
> and passed gpio info as line-gpios
> 
> line-gpios = <
>           &gpio1 24 1     /*gpio_56*/
>           &gpio1 23 1     /*gpio_55*/
>           &gpio1 22 1     /*gpio_54*/
>           &gpio1 20 1     /*gpio_52*/
>           &gpio1 16 1     /*gpio_48*/
>         >;
>         linux,keymap = <
>                 0x00000000 /* row 0, col 0, KEY_RESERVED */
>                 0x0001000a /* row 0, col 1, KEY_9 */
>                 0x00020003 /* row 0, col 2, KEY_2 */
>                 0x00030000 /* row 0, col 3, KEY_RESERVED */
>                 0x00040002 /* row 0, col 4, KEY_1 */
>                 0x0100000a /* row 1, col 0, KEY_9 */
>                 0x01010000 /* row 1, col 1, KEY_RESERVED */
>                 0x01020007 /* row 1, col 2, KEY_6 */
>                 0x01030000 /* row 1, col 3, KEY_RESERVED */
>                 0x01040000 /* row 1, col 4, KEY_RESERVED */
>                 0x02000003 /* row 2, col 0, KEY_2 */
>                 0x02010007 /* row 2, col 1, KEY_6 */
>                 0x02020000 /* row 2, col 2, KEY_RESERVED */
>                 0x02030005 /* row 2, col 3, KEY_4 */
>                 0x02040008 /* row 2, col 4, KEY_7 */
>                 0x03000000 /* row 3, col 0, KEY_RESERVED */
>                 0x03010000 /* row 3, col 1, KEY_RESERVED */
>                 0x03020005 /* row 3, col 2, KEY_4 */
>                 0x03030000 /* row 3, col 3, KEY_RESERVED */
>                 0x03040009 /* row 3, col 4, KEY_8 */
>                 0x04000002 /* row 4, col 0, KEY_1 */
>                 0x04010000 /* row 4, col 1, KEY_RESERVED */
>                 0x04020008 /* row 4, col 2, KEY_7 */
>                 0x04030009 /* row 4, col 3, KEY_8 */
>                 0x04040000 /* row 4, col 4, KEY_RESERVED */
>         >;
> 
> this driver approch may be usefull for the embadded device
> which are using reduced matrix keypad

You wrote pretty long message explaining how the device works, but I
still do not see the answer to questions - why it cannot be part of
matrix keypad?

"It looks like this driver has smaller number of features than
matrix-keypad, so it should be integrated into the matrix-keypad.
matrix-keypad features are superset to this one."

"But anyway this should be just merged into matrix-keypad. It's a
simpler set of that binding."


Best regards,
Krzysztof
