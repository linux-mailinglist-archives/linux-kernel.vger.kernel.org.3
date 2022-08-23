Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1091959ECB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiHWTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiHWTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38055D11EB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ca13so17951670ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HDcgc6OUnOjUxJicIucPyi00x/uE2rgP4ZhCVYRaya4=;
        b=M0bosexAr3X3AiHofQY+LmL8o8KKKyNRORbRR8NilxIGrpdmbAuxD2Hcn7YayVkhx/
         QertnlrES63fY0UiaEbLZ7m0m0AeMvSKsZkIL4trc82xFRdGTPhfCJnBxyXVEwmxosEl
         J8HwQNWi5dkfzQpSt+/jb7iRHkN5P1TR1ObjOZGOIIxG+17Y2iYKj46oOjDyCIcPGGXx
         ILrJNXYEmcym1uQe6bo2QY0LCAl2A12J4I4Z5Od7Q0lvhZNNSaIj1tK8E7q8ZAzwVqhl
         UGZVl9MaALuO6jpWAHf5vQjS277ysNU77epuiu/BRvt15CO9FhsD225GmNb6h7OWaeIY
         InHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HDcgc6OUnOjUxJicIucPyi00x/uE2rgP4ZhCVYRaya4=;
        b=J4bN+8ZDsPsyODSjZ6jFg0ssTpb6riQZ1ar7LuW6lPkkPck29vKApmmRBkOaYIk+FD
         X3+c+HRIhGH14sKYY616cSDPaHjfmYF0DqAKU84UiZFBaLndoetv6h/ClejULeYpjz0o
         ny4Q6vOewc3Kt4FTWxUr6smR0ctjUOMeB8QpIQl+pqoYyIuHT2DTnrsemCTYwIWg+Z3A
         uHWqBdsmxLbM+nY/sLUpwOKPlIuo3cET5kz6F4/KV9p6DoW5mwvR4iEymMkoNDtTKEwI
         FMt376W9bgXCTF2EQk9/4wzvcHrXnstdlF2KgZN7f23yCtLqvYYv2D3SkFWyHigRgvsD
         53MQ==
X-Gm-Message-State: ACgBeo34ZyDQj++6z68CLX52hgQz264o7jrdFp2/RrvqexWUfMNFmE58
        bgRFCckXXyXnCWqpRc5SnNg=
X-Google-Smtp-Source: AA6agR4HaGfkUpd1Cc36ZFyz+klvn03thzdj46FVcP5CY8SKUIFENtJMFrG1bShE3q+ZnskLjkQZVQ==
X-Received: by 2002:a17:906:3bd2:b0:731:3f03:1697 with SMTP id v18-20020a1709063bd200b007313f031697mr607759ejf.289.1661280598764;
        Tue, 23 Aug 2022 11:49:58 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id s15-20020aa7c54f000000b0044733adf4e9sm802097edr.12.2022.08.23.11.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 11:49:58 -0700 (PDT)
Message-ID: <91772e44-856d-cdee-e685-ff2ba4523c2e@gmail.com>
Date:   Tue, 23 Aug 2022 20:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: start cleaning up led blinking
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220822201329.95559-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220822201329.95559-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 22:13, Martin Kaiser wrote:
> The code for led blinking contains too many states and state variables.
> This series is a first tiny step towards cleaning things up.
> 
> Martin Kaiser (3):
>    staging: r8188eu: don't restart "no link" blinking unnecessarily
>    staging: r8188eu: always cancel blink_work
>    staging: r8188eu: always update the status variables
> 
>   drivers/staging/r8188eu/core/rtw_led.c | 36 ++++++++++++--------------
>   1 file changed, 17 insertions(+), 19 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
