Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1CB59F909
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiHXMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHXMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:09:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E548EA3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:09:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so23725041lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3TZjmvONtK+gD+5sSDysrTZUWAGyVBjcACbDwWxOOvw=;
        b=RRHEsX/ysVQZ6JyBzwErwijne1lD5wlx7AGV/gWrn65CDcgowCDkt7JC+Cm0tBaiwH
         oz22Dut5ITtXGj3ZMCj9f5zmYpWkaLI+ik0P7yQDS1smbBdUkOScpz+hqO0bpzbORsv/
         c4W68grZbPLzvKdseLJ8hy8ihYHKE+g3KUBUcFnrC262yFNk+CGFwx586aghwC130qxf
         3HPynR9Tw6eYdWik1W48lwsIVEbkyOxkRMub9OMQPkhkedDOqQAoVhJw20XQT/8oHefU
         Wh8x5f8KndgOpClUoIbfvF8WpHpiMbvW+UqqlgOHJuvr31TThn2uYmVqtIkZOkh0bGTS
         9uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3TZjmvONtK+gD+5sSDysrTZUWAGyVBjcACbDwWxOOvw=;
        b=gptq+S+D1gc81gA4wIw8HR7AAz4rdpVj6jAcmdshuci500QXzidUjQz0rUeXlfLxhh
         aFPfdz/MdN0HEpL8Tc8QnrPCHFPJy3FDLLSheN6igwGOw/7etpBSI7aRCCcuGIVEeeGv
         QoQFKP1R7aMjHHPWC+at3QRkzGAWJMucj7Bbh+HfRH4qhMqELNT74P2WgleWArCvxP3Y
         h4Noy2QUBvQEswN5k+Ijf50Eeh7FZBA5cgMQ044WYxxLPo/3H9I/lbFmbKMOs9W2KuX8
         JNctBPoHCnjJp8vbRGBoDIW/M8KCwHNhS44nf9O1uwwXsL5g/NNkGgTt84qT57GQn/NH
         dNyg==
X-Gm-Message-State: ACgBeo1nlznx+iOa5yX5K/LsmYBOuz1kjJOlqSp2epCjE80dkYYv6MJR
        UFMpxD4BEPktG2T5Ppy+SwMkqw==
X-Google-Smtp-Source: AA6agR66BNqFRXO4lN3u5lLo+pWSPom69F2kZ9+2AcybGpKKS+H6Jlgvu2CQEopxn1zWw9YmCgv5lQ==
X-Received: by 2002:a05:6512:541:b0:492:e86c:1def with SMTP id h1-20020a056512054100b00492e86c1defmr3882332lfl.644.1661342942843;
        Wed, 24 Aug 2022 05:09:02 -0700 (PDT)
Received: from [10.243.4.185] ([193.94.200.84])
        by smtp.gmail.com with ESMTPSA id u5-20020a05651c130500b0025fdf9eec1dsm2820718lja.111.2022.08.24.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:09:02 -0700 (PDT)
Message-ID: <d499ec9a-a1e3-83e0-b66f-346a9186b4a6@linaro.org>
Date:   Wed, 24 Aug 2022 15:08:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ST ST95HF DRIVER security bug
Content-Language: en-US
To:     =?UTF-8?B?157Xmdeb15DXnCDXqdeY16jXkNeV16E=?= 
        <mdstrauss91@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAAMXCFnzLX-yWKSJ5JoBxcE8E0=cSQeDExGoFBxhkusUNeYncg@mail.gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-nfc@lists.01.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAMXCFnzLX-yWKSJ5JoBxcE8E0=cSQeDExGoFBxhkusUNeYncg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 12:10, מיכאל שטראוס wrote:
> Hi,
> I found a small security bug in the ST95HF driver in Linux kernel .
> Thought it is responsible to report it to you guys so you we can patch it
> up.

Please use scripts/get_maintainers.pl to Cc relevant people. You got the
same comment last time as well...

> CVE ID was requested,  when it is reserved I will update.
> 
> ST ST95HF DRIVER
> ST95HF is an integrated transceiver for NFC made by ST,
> Buffer overflow can be triggered by the attacker by providing malicious
> size in one of the SPI receive registers.
> 
> *Details:*
> ```jsx
> unsigned char st95hf_response_arr[2];
> ret = st95hf_spi_recv_response(&st95context->spicontext,
>       st95hf_response_arr);
> ...
> 
> /* Support of long frame */
> if (receivebuff[0] & 0x60)
> len += (((receivebuff[0] & 0x60) >> 5) << 8) | receivebuff[1];
> else
> len += receivebuff[1];
> 
> /* Now make a transfer to read only relevant bytes */
> tx_takedata.rx_buf = &receivebuff[2];
> tx_takedata.len = len - 2;
> 
> spi_message_init(&m);
> spi_message_add_tail(&tx_takedata, &m);
> ```
> Driver sets a buffer of 2 bytes for the input bytes but actually allows the
> driver to overflow it with any valid SPI message (short or long frame) in
> the tx_takedata stage.
> It seems like a mistake, but i may be missing something and i am totally
> wrong.
> 
> *Effected commits:* Current source includes issue.

What does it mean "current source"? Please be specific which exactly
kernel version is affected, which commit introduced it.

> *Exploitable:* I actually think vulnerability can be exploitable by any
> device on the SPI bus.

Then the risk is quite low, right? SPI busses are not user hot-pluggable
except some development boards (so again a real niche). Basically it's
impact is negligible, considering that system would need to have such
device reported and configured (which for DT systems is static) and at
the same time malfunctioning or behaving incorrectly?

You already sent me a message about it in May and this does not bring
anything particularly new since then. You did not respond to my reply
that time, although maybe that's continuation.

Anyway proper analyzing of this issue and a patch would be nice.

> *Code:*
> <https://github.com/torvalds/linux/blame/master/drivers/nfc/st95hf/core.c#L284>
> https://github.com/torvalds/linux/blame/master/drivers/nfc/st95hf/core.c#L284
> ,
> https://github.com/torvalds/linux/blob/master/drivers/nfc/st95hf/spi.c#L107
> 
> I was not able to understand if the remote device has ability to trigger
> the issue or only the SPI connected device?


What does it mean "remote device"? NFC? NFC tag does not talk over SPI...

Best regards,
Krzysztof
