Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9164E6437
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350501AbiCXNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbiCXNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:39:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C228E04
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:38:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4so4757230pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sudomaker-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/sQV5rp+cw1wax1iRP0Va+YLBH7FLeLa8L9B5UtJM84=;
        b=5C0v6M5Hca9omePnMbOPDpTfrC6UCYwPeyi8waSFJfu9um0WM6EYF/qIWVeK5AbbLF
         wkZzp6EmIYdKs5gMZh1XNk47iQlsQ6zX5fntXSaFGB8DcHmIx28bwOtiRIuo5dC4+pqQ
         l1W9DFCo7FFvwRLZi7jKhXI4YAfO3K/rFp6K+jWPQeuU5KTwWssrdLJ+V3kdXBJZAoim
         cc/p4GjzFLFfwizcm5LzYkDpkcYWYpJkWiOJ4WhVkuC5hAN8JFYhzW4GeAXvSoH/BcU3
         QJoDIXAw/8cfSVpOhVPSCP7VrjWofUsuatyWBjvKceUeGgf2sg/0iCbAnXGJ1Dj+KCU7
         oNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/sQV5rp+cw1wax1iRP0Va+YLBH7FLeLa8L9B5UtJM84=;
        b=lJmkOXL27Pj6IsUbZxXrQ34hnSJC2vuLR1M6c9uVC244MujM4KISLowFApYBWbtNE0
         uVEv5GXP2hm8wjdzOi+l+ZmaVgNQQJXlfb9AD6hjP4LXfkQMrge/LBSmk6+BEFZRX5Sf
         X90dc2XAia/z3L6yDqXVTvBeIShGONfJHceGazoSgUvWv63NNjOZrNp56rgHIfXs4Q0X
         03/epaPjtKRxvZCqkudLOOv/X4egcKAOp1GUpyZOkRFkY1ynce4pc2g7oLl9gRZYKFZh
         S1FAS4FbYNvQxtdxLsnY0kxN3LrGUj/yY4voKnYfgpoWHSfxpL0B5MVUCKeg5W/VSUg4
         coHw==
X-Gm-Message-State: AOAM5337lcKznFTVaY0mtId0iHOhVdGXGwCwu5f77gPk4IUxXWCeU57E
        UiF5FlD7y7Bd0vxyropNQFSA1w==
X-Google-Smtp-Source: ABdhPJz1XaJS5LG/TJcD0dYQ+F6zCb5Vf3z0cQhZ4l5Rv2149Mor9j9sUR8PwJik08KZjzFrZAQAWQ==
X-Received: by 2002:a17:902:7888:b0:148:adf2:9725 with SMTP id q8-20020a170902788800b00148adf29725mr5824851pll.136.1648129088094;
        Thu, 24 Mar 2022 06:38:08 -0700 (PDT)
Received: from [172.16.24.11] ([91.219.212.226])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm2765064pgo.88.2022.03.24.06.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 06:38:07 -0700 (PDT)
Message-ID: <5c1f03d1-f72a-bc6b-92b4-927898aa3b2d@sudomaker.com>
Date:   Thu, 24 Mar 2022 21:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pinctrl: Ingenic: Add missing UART2 group C for X1000/E
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ea710c27-00e9-065c-77a3-78e3c5f73ed3@sudomaker.com>
 <3H099R.GNKMFWXCJG5U1@crapouillou.net>
From:   Yunian Yang <reimu@sudomaker.com>
In-Reply-To: <3H099R.GNKMFWXCJG5U1@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for pointing this out. I sent the refined patch.

On 3/24/22 20:10, Paul Cercueil wrote:
> Hi Yunian,
> 
> Le jeu., mars 24 2022 at 20:04:41 +0800, Yunian Yang <reimu@sudomaker.com> a écrit :
>> X1000/E has a third UART2 pin group selection, which uses the TDI(G2) as RX
>> and TDO(G1) as TX. This configuration is becoming increasingly popular in
>> newer core boards, such as the Halley2 v4.1. This is done by enabling
>> function 1 of a "virtual pin" PC31. See section 19.3.3 of the X1000
>> Programming Manual for details.
>>
>> Signed-off-by: Yunian Yang <reimu@sudomaker.com>
>> ---
>>  drivers/pinctrl/pinctrl-ingenic.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
>> index 2712f51eb238..29709059d62b 100644
>> --- a/drivers/pinctrl/pinctrl-ingenic.c
>> +++ b/drivers/pinctrl/pinctrl-ingenic.c
>> @@ -1982,6 +1982,7 @@ static int x1000_uart1_data_a_pins[] = { 0x04, 0x05, };
>>  static int x1000_uart1_data_d_pins[] = { 0x62, 0x63, };
>>  static int x1000_uart1_hwflow_pins[] = { 0x64, 0x65, };
>>  static int x1000_uart2_data_a_pins[] = { 0x02, 0x03, };
>> +static int x1000_uart2_data_c_pins[] = { 0x5f, 0x5f, };
> 
> One should be enough.
> 
> Looks fine otherwise.
> 
> Cheers,
> -Paul
> 
>>  static int x1000_uart2_data_d_pins[] = { 0x65, 0x64, };
>>  static int x1000_sfc_data_pins[] = { 0x1d, 0x1c, 0x1e, 0x1f, };
>>  static int x1000_sfc_clk_pins[] = { 0x1a, };
>> @@ -2058,6 +2059,7 @@ static const struct group_desc x1000_groups[] = {
>>         INGENIC_PIN_GROUP("uart1-data-d", x1000_uart1_data_d, 1),
>>         INGENIC_PIN_GROUP("uart1-hwflow", x1000_uart1_hwflow, 1),
>>         INGENIC_PIN_GROUP("uart2-data-a", x1000_uart2_data_a, 2),
>> +       INGENIC_PIN_GROUP("uart2-data-c", x1000_uart2_data_c, 1),
>>         INGENIC_PIN_GROUP("uart2-data-d", x1000_uart2_data_d, 0),
>>         INGENIC_PIN_GROUP("sfc-data", x1000_sfc_data, 1),
>>         INGENIC_PIN_GROUP("sfc-clk", x1000_sfc_clk, 1),
>> @@ -2115,7 +2117,7 @@ static const char *x1000_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
>>  static const char *x1000_uart1_groups[] = {
>>         "uart1-data-a", "uart1-data-d", "uart1-hwflow",
>>  };
>> -static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-d", };
>> +static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-c", "uart2-data-d", };
>>  static const char *x1000_sfc_groups[] = { "sfc-data", "sfc-clk", "sfc-ce", };
>>  static const char *x1000_ssi_groups[] = {
>>         "ssi-dt-a-22", "ssi-dt-a-29", "ssi-dt-d",
>> -- 
>> 2.30.2
> 
> 

