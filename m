Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A355552B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376952AbiFVUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbiFVUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:00:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25872340D9;
        Wed, 22 Jun 2022 13:00:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d14so13374263pjs.3;
        Wed, 22 Jun 2022 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H32edbNKPR2s6aSUbVdqXXgAauRhWuXF6JcIlX7te90=;
        b=feubf9Ye8kXOE8iOKkdpqX0KE9jZIUPok3HnneyYIupwOdXmBMFRQ6MCrct/bk08zf
         V1vCgwzR7VcDYC6/4S4iHZ1ADNQHYfNxsbo/mpNn5FWPN+OdcSumEHdrdrvgHeoQxb4v
         F+oPTXO/G6jdnNBoLlkBMD6xMr9oCIx5wq4FVX8UNKEPylPOfZ4jkEVdVeeHzSSbD1js
         Dny/3dyttzI2BJcLvx3w/hgn0sZFbTHG9Vjl7830viBY5BponYLOHTLDiUyjm83grEmg
         nr3PWegsASmKLBWybAvzu4kKQsoYKsYnn4AhiZfRpTf/nly6ozUOMPq1s/AyMjOTpLoc
         Pknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H32edbNKPR2s6aSUbVdqXXgAauRhWuXF6JcIlX7te90=;
        b=CrxUrRMHOBm2vwl2k28aLdz8pu7vtFvcyFg5YzGXUglGImPE9Zlpug0ue0neGuYkSM
         TNlgqnmMlWFO1+eHNjayFgOIvwFqOMA2m+BS9mo5EvdtDTFCu4DN0ILlJ9j/ShyhqZeV
         ossrlVKry/PbhlNqLSmDMKslidxzrO+SwrpomgXhQsEgR+MKJxB0ixLmvvSSOS2V+BKV
         gllltMTG1LxcvVLDWVymjO3LMrbp1znjN5gsLOFB0BxLcfI+n1T3PJJHL9nesiY7/EEq
         p7/Rl1csg/hG+nCLZUK9Hx0oB7B8ZTyuxLxBCHnK/0pb8F9PrsWBcQDodK+jUIWTWA4c
         Zeyg==
X-Gm-Message-State: AJIora8j9iAI1sUyKfBhs0YKCAWolkw2uw0+LgZUCQY1r/CCMkqtneS/
        p8HwMLlwiOX/u6/oLGS1L7k=
X-Google-Smtp-Source: AGRyM1sKIvsd40oVsibGqLjkBwUaNFT9Ujo0yPK1ns7KcYb9oiQWsNq3WJQOoXR9ZfC0XJcbdj32ow==
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id h16-20020a170902f71000b0015f165fb50bmr36578095plo.158.1655928034505;
        Wed, 22 Jun 2022 13:00:34 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902714c00b001675991fb7fsm13125784plm.55.2022.06.22.13.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 13:00:33 -0700 (PDT)
Message-ID: <45abff3f-201b-ba6e-fe9a-634fd4413229@gmail.com>
Date:   Thu, 23 Jun 2022 05:00:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] extconn: remove extraneous space before a debug message
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220619084248.21395-1-colin.i.king@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220619084248.21395-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 19. 17:42, Colin Ian King wrote:
> There is an extreneous space before a dev_dbg message, remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/extcon/extcon-palmas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index d2c1a8b89c08..32f8b541770b 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -107,7 +107,7 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
>  				(id_src & PALMAS_USB_ID_INT_SRC_ID_GND)) {
>  		palmas_usb->linkstat = PALMAS_USB_STATE_ID;
>  		extcon_set_state_sync(edev, EXTCON_USB_HOST, true);
> -		dev_dbg(palmas_usb->dev, " USB-HOST cable is attached\n");
> +		dev_dbg(palmas_usb->dev, "USB-HOST cable is attached\n");
>  	}
>  
>  	return IRQ_HANDLED;

Fix the wrong word on patch title and use captital letter of first char as following:
- extconn: remove extraneous space before a debug message
-> extcon: Remove extraneous space before a debug message

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
