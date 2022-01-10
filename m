Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B392489580
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbiAJJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbiAJJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:43:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:43:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k30so7977595wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rzhy6yEPJVlT7RLq5OS2aYkHYtU0ICRm0bniQL4KIpc=;
        b=gGJCnpebj8VuX8+ZFZDudraazK3ixsOrmItH9h/ZjnnxVHz4RBuyDwMhG80kB2gBSm
         YyaD7Dde6eXTnhBze161WX2Aw3Rcft7scBrj0AtOFwmbqhAjLNdIBbSVM/KhJkHFg4ua
         YyTIyZMAp5NzYSv3sEgki0yq+bQLS4IHiWplx0osb5Ih38TQPadm6wSZF+UEZfJPYPxk
         bvLoVDT/lxL4pna7BRn+ar7mbo+fNPO45xfa76D5jsk00IHp8FFdInVfrxtT9+v8zXE6
         lCzukCMUMaa5dOi2ID8+bMVC4wZBvaXngcovPX9ZdQkEXReIosSGnyIJ3VDB0IQgb/kd
         +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Rzhy6yEPJVlT7RLq5OS2aYkHYtU0ICRm0bniQL4KIpc=;
        b=bkwJAEbXN4pKW5Blq8wTHaHbJgaHJJyPT/mBW+a4IFI3/4zm5Bt9lp2POBXRyYE+4q
         PMLXiKoBGH4wf484fM9kQmlgUx4RvjjZPggyzmjH1lOY907vCTJN9Ytf5s1HuGijhks3
         ZmcWSTgxZ1UqYQHMPUVLx1SmryLyhIlXLYCqma7cmIauXyMyMrAwd8d6itdhJSxbnBjt
         5pV2cDFAaZsGo7pqZJl7VAMlU8vXgIF9vBU2OLbGgOCuEppfsqQKq52w40DUsc3GdsEj
         fxj/Vb0lmKFWyyhBTImW8td4XUSxkhy88hAGMobdV1DbPagPnYepU5R6eETnqOvCiurR
         Dnew==
X-Gm-Message-State: AOAM530CF2dakf4aR+jgZjErUcxvkP2uK5vuXao74ijWcsVgGZ1PtFLE
        COgYJw57/eaxShW+TwqIG3s/Bg==
X-Google-Smtp-Source: ABdhPJxNhr//nhb1+5lbwdo8C/T3TotD1T9N8DhX4EvRDmin16/DX9D97BInHHOT1C6UgTytdSAN5g==
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr2788363wrh.335.1641807783340;
        Mon, 10 Jan 2022 01:43:03 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id q14sm6373285wro.58.2022.01.10.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:43:03 -0800 (PST)
Subject: Re: [PATCH V4 0/5] the UART driver compatible with
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110085604.18042-1-yu.tu@amlogic.com>
 <1f4b9288-c7ff-c895-425c-187d058642b9@baylibre.com>
 <a19771e6-d1d4-d1ef-9819-21e2147aad16@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d14fdcd5-99c2-6aa0-085e-5355ecc0febf@baylibre.com>
Date:   Mon, 10 Jan 2022 10:43:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a19771e6-d1d4-d1ef-9819-21e2147aad16@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2022 10:35, Yu Tu wrote:
> Hi Neil,
>     Thank you very much for your reply.
> 
> On 2022/1/10 17:27, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On 10/01/2022 09:55, Yu Tu wrote:
>>> Using the common Clock code to describe the UART baud rate
>>> clock makes it easier for the UART driver to be compatible
>>> with the baud rate requirements of the UART IP on different
>>> meson chips. Add Meson S4 SoC compatible.
>>>
>>> Yu Tu (5):
>>>    dt-bindings: serial: meson: Drop compatible = amlogic,meson-gx-uart.
>>>    tty: serial: meson: Request the register region in meson_uart_probe()
>>>    tty: serial: meson: The UART baud rate calculation is described using
>>>      the common clock code.
>>>    tty: serial: meson: Make the bit24 and bit [26,27] of the UART_REG5
>>>      register writable
>>>    tty: serial: meson: Added S4 SOC compatibility.
>>
>> Weird, the subjects are fine in the cover letter but are all truncated in the email thread:
>> [PATCH V4 0/5] the UART driver compatible with
>> [PATCH V4 1/5] dt-bindings: serial: meson: Drop
>> [PATCH V4 2/5] tty: serial: meson: Request the register
>> ...
>> Only the last one is OK.
>>
> I saw the subject was a little long, I changed it manually, do I need to regenerate and send?

yes please, the mail subject will be the commit title so it must be short but descriptive enough.

"dt-bindings: serial: meson: Drop" is too short.

"dt-bindings: serial: meson: Drop compatible = amlogic,meson-gx-uart" is ok but formulation is wrong,
and remove special characters like "=", "[", "]"...

The best title could be :
"dt-bindings: serial: meson: Drop legacy amlogic,meson-gx-uart compatible"

If the subject it too long, reduce it and enhance the commit message with the details.

Neil

>>
>>>
>>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
>>> discussed in the email
>>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
>>> the DTS before it can be deleted
>>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>>> in the email.
>>>
>>> Link:https://lore.kernel.org/linux-amlogic/20211230102110.3861-4-yu.tu@amlogic.com/
>>>
>>>   .../bindings/serial/amlogic,meson-uart.yaml   |  10 +-
>>>   drivers/tty/serial/meson_uart.c               | 244 ++++++++++++------
>>>   2 files changed, 177 insertions(+), 77 deletions(-)
>>>
>>

