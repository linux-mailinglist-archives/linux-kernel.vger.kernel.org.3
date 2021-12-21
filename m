Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24F047C237
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhLUPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhLUPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:06:09 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C303FC061574;
        Tue, 21 Dec 2021 07:06:08 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso4151977ooa.6;
        Tue, 21 Dec 2021 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxJLCKdii3ZBovJHJ1Lr3yRQh18xoe4Lj056VTHDmPs=;
        b=Bmi5loPyz4cI2aCEOWBDEYFQ9TCEhRGQ/HbaJrSJMboimVrnqFVdjV8oZIJR+9qvlN
         wwBsDAXcsLHe3RxzPV4w7svfUcVTYs475u7liaAoCWEEWzJdQpzGlsJhEBJjP5M3usx5
         OkWo9d9nPtLYwovRpqkFYOvyK7N1H4Y8SbbZ+lhut5dmtevxHuEIfL73MDgQrKdmHkOl
         ekJ0D/RLKHkDR6HvFsdlNYc9M32iwIQfRg3TxifCoDOfwTCePyuJSFnABfefiDb1R0c+
         Ln+A7g2SLgdKryjiMhNqVkhRQK+GxwezP/ecb5B/bWRcD03jZ4Beolb2jqu16df4OmN5
         doCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxJLCKdii3ZBovJHJ1Lr3yRQh18xoe4Lj056VTHDmPs=;
        b=VfmIv4/sfFoOqo5+1lO7POaL4kZ3twdZbHMjM2uubByCSrMkO7loAJ4iB5uqPa05qP
         AESsHZO7LvZIuX/RBKjtutupEbX2cEwJUV4j6Tdi9XOZVCLZ7o8csPtsiP7L//TfUM+O
         dYQZnEg1ud1lSIyp1tAIDloRpZv3xRiqI8dAcRMJqKaYxeas5lp/l0Ojd5NZyYtiAzQo
         YtGDvNbA0Wn8J75cmABPBicO6nwhU9J6XAxKX++1hTctLF1Hgtav+kkshhVdyQWZRKs8
         F9YoeZmiieP7V3bbpNriQruvMbw3s7A0OQ1YvLj8d+4DR2stVKA25HYzNN4xouFk+HDS
         iUZQ==
X-Gm-Message-State: AOAM530FD2TPDY1Zlwo23L5DUUs2Nr52OY5DWIqULEweKp5suSGZfApO
        XDcJwDH3bM0ePNY81YoMoPI=
X-Google-Smtp-Source: ABdhPJzEJ0TU1QntJG/hNFU4s47BueQ+uqlLdOa0Zwitm0SaVEivs3kbUclw4G26Y/dYVSwKDc7ZEw==
X-Received: by 2002:a4a:d453:: with SMTP id p19mr2210473oos.85.1640099168111;
        Tue, 21 Dec 2021 07:06:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bq5sm4248283oib.55.2021.12.21.07.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:06:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 7/9] watchdog: max77620: add support for the max77714
 variant
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <20211211203432.32446-1-luca@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <72d7d229-75da-603d-0b71-46db8e32af2b@roeck-us.net>
Date:   Tue, 21 Dec 2021 07:06:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211211203432.32446-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 12:34 PM, Luca Ceresoli wrote:
> The MAX77714 is a MFD chip whose watchdog has the same programming
> procedures as the MAX77620 watchdog, but most register offsets and bit
> masks are different, as well as some features.
> 
> Support the MAX77714 watchdog by adding a variant description table holding
> the differences.
> 
> All the features implemented by this driver are available on the MAX77714
> except for the lack of a WDTOFFC bit. Instead of using a "HAS_*" flag we
> handle this by holding in the cnfg_glbl2_cfg_bits struct field the bits
> (i.e. the features) to enable in the CNFG_GLBL2 register. These bits differ
> among the two models. This implementation allows to avoid any conditional
> code, keeping the execution flow unchanged.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 


Reviewed-by: Guenter Roeck <linux@roeck-us.net>


