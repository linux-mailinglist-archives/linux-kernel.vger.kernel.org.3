Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF49584451
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiG1Qne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiG1Qnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:43:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3283FA34
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:43:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t22so3689617lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ifxIHR3wtak3AIe6LDQHDjxyjywk+Xw7XLUojedre8M=;
        b=YalcY9JaDXdQcIzKQp3YdhK9ZeTXE76yICCoLbuHt8DInn6KLS0lp1iaz9FrUBZzD7
         W9DKjHXveOAhimxyHObvbSU8GWgaFP9v+7WLxSBenjVoiBHUcfMa4PYg9I7+vfn4Qf6K
         /V/sahsY2bfkmWtnQgAnwOnlmqOQnoOsYP4oZzNJUZ1gblqMnox0xa6jwzOdhk6AswNf
         5DEmeXvGjpCXItix6DyjVzZHKYAx8MBpJWEYecdP0MfcHVAQDQdppriyQoyAMm2FxeTs
         WxRSK2sxQthldnxBOhA3twuNrzN82+Z0xHqocky3N+mrdnwoTdt5AvueX0cBb9xTfFNx
         r03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ifxIHR3wtak3AIe6LDQHDjxyjywk+Xw7XLUojedre8M=;
        b=IdOtmIQxtj3Rg1B4hYicGsfNNKtPP/tVBWr0zd3jksC6nROwqxWDMWskoFy3qvbMYd
         /ic4ZTllM52FsEcCL4bn+DBx4FWaMEHvb0gGKkkXE5S9egdxxATZ0V2MaU6P1cJEAzJj
         YBqVT8FYPn3u63Es4CXZqKC5Q0mUAxo6zFQs66Jp4ctaqFB/TeYHsqcPB/nf7lTgffDi
         XNV++nAMphFKejbUFZ2FP7QSB39UbS7HHpUBW+ABvGcpQ2SZfyJnHPL9v/U0d+ZgZ4/J
         Ixo+qaa0Rv/+wen0kBI/MnuHUDCfEOVhOsgG8srjzzdYI2Q1XmJQFA+Ui7Yghw0d6xDi
         3Krw==
X-Gm-Message-State: AJIora/ezjb/bfnuEJQ0yzKwMz7Hpky+zju+7MMyXLuobApyaZasyqrn
        MjijI0llX9EEcpMlQEcuQNUQew==
X-Google-Smtp-Source: AGRyM1vl7Q3/uugOjXvtVSvHQJheTOR4ZXmBs5by8XTGTHg5bhIlv+yJ8NGuEP7jhMejdlWPD4vKWQ==
X-Received: by 2002:a05:6512:20c7:b0:48a:a653:f50d with SMTP id u7-20020a05651220c700b0048aa653f50dmr4273359lfr.261.1659026609909;
        Thu, 28 Jul 2022 09:43:29 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id k9-20020ac24f09000000b0048a918717c3sm271421lfr.57.2022.07.28.09.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 09:43:29 -0700 (PDT)
Message-ID: <33cd5fd3-f673-4d46-b063-e3615a648d6c@linaro.org>
Date:   Thu, 28 Jul 2022 18:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC v1 2/2] devicetree: bindings: bus: add Wiegand driver
 documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, elder@linaro.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
 <20220728091712.13395-2-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728091712.13395-2-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 11:17, Martin Zaťovič wrote:
> Wiegand write-only driver requires definitions of two GPIO lines
> in the devicetree. This adds the documentation of their
> definitions.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>

You didn't test the bindings, did you?

Best regards,
Krzysztof
