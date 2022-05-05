Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CD51BA5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbiEEIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348260AbiEEIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:31:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E74A31203
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:27:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id be20so4311748edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5tSgyVPoIjIJTnk8pwe9iFq2l8iCcKVYBSDyP0RRtUw=;
        b=SZERI1K6Set/ar7XavDlXSuhC6TM4i6vWi504UalqyeoSF37mRcDmyXuFm72cjChwb
         gx8eJmlAQ08OwR75gbT5wWjbaTEDH6y0+WG5hTVJgmLcV8bE2/CZ0UEjZWd7zuWEQ5gP
         aqwOZz+mZLlHnttDl8wcoxsMblrTJTC7FOjN2TDCxD9Lw8wj9YPovvTCxinZAOU3K99U
         NNFg1Nifl8dX9/pCm1pVbxMFtmAGYax5uE5a59iLzA46eD9e3EvaF+r09rBd3yFwCvwN
         u1eZiPAt/Ue7aJ0uQOjr8mYBqSG3ByZerT5YRHjoStToy/heQveso+yUiIKVliq/yP9R
         78tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5tSgyVPoIjIJTnk8pwe9iFq2l8iCcKVYBSDyP0RRtUw=;
        b=OeuUdDRyIBruF/eRwBYiyJri+VUFhBBXzXwG8QTS2vW6bUfUoj+Az9nH7+dg8ehAI7
         mA5/S6wADWRG7IsQRylutSB1Kgt/jy8xhnvn6qAMMUDEL9PqHqVmDCzcVDAKskNvMLyV
         t3gWn/bmhA9Dt5eAHXSKUVyYnQW4tFPz31DhTZ/4z01Oem4bICg7H6Hu3EduDKpn4fmq
         9aaztOsr256agDxhQVJVByy618w2FX8Cc3KHdKd5HNLiaTJykTLdVDOLmjFfHXiQNwV4
         E7pF8h4N0EX7Iu1YiWF6vZdBp/IXB9oCuwqoxWnP1hGDwZfrFb1MjKQvzQwz1LFvyFD9
         Ifsg==
X-Gm-Message-State: AOAM532ee0917pJjAhX8CWXuQm9qXC4Fz+bY6hzvCTmYlSLuWOtc+igQ
        tk6a1cVzukp+ntm7wBR5rGaZJQ==
X-Google-Smtp-Source: ABdhPJwgese7bUTlRcmGO1mVDEwMWHdoEWyOzOI+Igy+m5JwTam3fT/88Xt9SiMpZxojkp+JqaQVSw==
X-Received: by 2002:a05:6402:358a:b0:428:136f:766a with SMTP id y10-20020a056402358a00b00428136f766amr7731609edc.403.1651739264889;
        Thu, 05 May 2022 01:27:44 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f6-20020a05640214c600b0042617ba639dsm496805edx.39.2022.05.05.01.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:27:44 -0700 (PDT)
Message-ID: <7674659c-20f4-68da-5a62-5c8e8ebdfe5a@linaro.org>
Date:   Thu, 5 May 2022 10:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad
 driver
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Gireesh.Hiremath@in.bosch.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220504105254.1576-2-Gireesh.Hiremath@in.bosch.com>
 <20220504134817.1490-1-Gireesh.Hiremath@in.bosch.com>
 <20220504141404.onom7x5lycyg3b22@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504141404.onom7x5lycyg3b22@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 16:14, Marco Felsch wrote:
> On 22-05-04, Gireesh.Hiremath@in.bosch.com wrote:
>> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
>>
>> The existing matric_keypad.c use different gpio line for row and colunm,
>> where in mt_matrix_kepad.c use same gpio line for row as well as column.
>> a key can be placed at each intersection of a unique row number 
>> not equal to a unique column and they are diagonally symmetric.
>> Advantage of this is with existed gpio line we can get more keys
>>   
>> example: in matrix_keypad.c for 5 gpio line possible matrix is 2X3 or 3X2
>> and maximum possible keys are 6 but 
>> in mt_matrix_kepad.c for same 5 gpio line possible matrix is 5X5 and maximum
>> possible buttons are 10, below table will discribe that
> 
> Nobody should stop you to increase the amount of max. possible keys, so
> this isn't a real block.
> 
>> 	------------------------------------------------------
>> 	|Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
>> 	------------------------------------------------------
>> 	| GPIO 0 |  X    | KEY_9  | KEY_2  | KEY_3  | KEY_1  |
>> 	------------------------------------------------------
>> 	| GPIO 1 | KEY_9 |  X     | KEY_6  | KEY_5  |  KEY_0 |
>> 	------------------------------------------------------
>> 	| GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
>> 	------------------------------------------------------
>> 	| GPIO 3 | KEY_3 | KEY_5  | KEY_4  |  X     | KEY_8  |
>> 	------------------------------------------------------
>> 	| GPIO 4 | KEY_1 |  KEY_0 | KEY_7  | KEY_8  |  X     |
>> 	------------------------------------------------------
>> 	X - invalid key
>> 	KEY_x - preferred key code
> 
> That should be pointed somewhere very clearly, thanks for the
> description. Also what is than the benefit of the original matrix_keypad
> driver?

It looks like this driver has smaller number of features than
matrix-keypad, so it should be integrated into the matrix-keypad.
matrix-keypad features are superset to this one.

Best regards,
Krzysztof
