Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3B5AE540
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiIFKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiIFKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:22:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9777A759;
        Tue,  6 Sep 2022 03:22:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so10478721wrp.11;
        Tue, 06 Sep 2022 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FO37cN0NhbSvcmbUWhzIYEmiT47YcrB62BYarlZD1xI=;
        b=ZpNatYnfQ8sud2FmqEp8aR06XBWCCNFtvGJjH2zacgcwMK6wmqZk1t0PYu7tX/iq8Y
         OiPSAeU3WXkfWxvIEbzpDJMyAED+y+ek66BEDWPd0+te189LCmJk3PKZUC8GqiU5XKRD
         nu5CkM1mJkFbK/9tkfp75Zpmb3awZ2R/7hd7z4OyWbcQwc3J2STWj6uaE0esTWvssKKm
         fpUK6YKD1kxBr/7wRfa+1swYGSdi7G0QCvBKrdi/lFYiVQBrNXCbyivtYKCKVrj2gEdJ
         /9j8TaHjEvfijJP+Or4+QCfwlN/JoWoavyna4gFiTEFOaf0YIcZ2bV0CBLCXJAo1nLE9
         ndGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FO37cN0NhbSvcmbUWhzIYEmiT47YcrB62BYarlZD1xI=;
        b=XBLklwvdMMGXB2+WHondK2UBUTP+qYuLKRXbo3aomYIMWtxArCVwjGg5sxqaSUg/bf
         +TmX5AeRpqp29IipgikjLhOCXHOmyiIYVX7VSVplNyxviebLmt3GfcWP883KWXmcMH6f
         HGW9ZRKssays7zIgjcuB5fFhL2qUSs6N+gXfcOTeDKIrlTw2yz5ha04iEoIiK76CCBcx
         jxpeTYq5vMW6TX+BmtIBzdvcefM0/r42zLwmo1jB08qe7AtFCRaOtqWzjDU5cZWh8s9u
         wTkefqrbgazSmQfwpcympFMihyBtHmn3M1bAAZOUfoewdMTKNW1ZxFG4Md+AVf97gxdF
         x1+g==
X-Gm-Message-State: ACgBeo1kQAdJNvhS4a5m1oWJBPEqryKNmWaSQZ7Sda1Gw7/I7SESmSWq
        f6U4LzwE+pz5uZROCsaC+yE=
X-Google-Smtp-Source: AA6agR78j7MRQwJPeo/IRiIhLjT4Ww1k4jN5nY5HzNbZeaeP26i4RxdXPB87mlAqe/Cr5CB26q3tmA==
X-Received: by 2002:a05:6000:144f:b0:225:6d79:b44f with SMTP id v15-20020a056000144f00b002256d79b44fmr28650138wrx.190.1662459714478;
        Tue, 06 Sep 2022 03:21:54 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm11922851wrq.80.2022.09.06.03.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 03:21:53 -0700 (PDT)
Message-ID: <c7d0dc8a-f12b-d586-c7ce-10e329fdac2f@gmail.com>
Date:   Tue, 6 Sep 2022 12:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] tty: serial: atmel: fix spelling typo in comment
Content-Language: fr
To:     Jiangshan Yi <13667453960@163.com>, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220906063957.2951323-1-13667453960@163.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220906063957.2951323-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/09/2022 à 08:39, Jiangshan Yi a écrit :
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Acked-by: Richard Genoud <richard.genoud@gmail.com>


> ---
>  drivers/tty/serial/atmel_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 7450d3853031..7f8af2ea3fa5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -40,7 +40,7 @@
>  /* Revisit: We should calculate this based on the actual port settings */
>  #define PDC_RX_TIMEOUT		(3 * 10)		/* 3 bytes */
>  
> -/* The minium number of data FIFOs should be able to contain */
> +/* The minimum number of data FIFOs should be able to contain */
>  #define ATMEL_MIN_FIFO_SIZE	8
>  /*
>   * These two offsets are substracted from the RX FIFO size to define the RTS

