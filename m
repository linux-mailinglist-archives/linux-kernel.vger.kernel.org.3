Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71A509AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386810AbiDUIrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386808AbiDUIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:47:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AE1EAFE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:44:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p189so2731908wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7NcpkA7Pw9hAO8IT6wBMBlDV/T3SO7ggWZNFOJPPHDU=;
        b=MQECcGKVohiNS5vFHXZHfPei6sjTLX7AbRBc5gb+1cz+EJcMoDkCvHLLucoHdQZeE7
         Ax4gPbC9KBzX74VcvQfmswh3+AnC3rVzH04Ay1JuVVMj6I57yZbAT2HZJhCbl7i9Ul92
         QUpzdofWN0LsAMMiLXa1JfDaA7YRCPqyoMIsiCDf95O9FMlGMSAkWYoeOwwxHuHXYZya
         53i/uSGduoAvI8Y/JQ/IyAdSAgrm4/hOteE5AdtrMG+srHvdp6SD16TpTVL3xsTNpQuv
         qbojfgiloucpsxE5up5cj0ehLMZQlqMfgbLu8oPRYbPVV4mvOIVc2TvHCeY/B+hYB3LU
         rMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7NcpkA7Pw9hAO8IT6wBMBlDV/T3SO7ggWZNFOJPPHDU=;
        b=OCX5k4C5HNGWEhlWlpMRtnpZ57gw2KtmDOg6MiUtdypJTT0FVik9sBit7rSQMhl7YC
         seQL04KNU0JLpysnDWOI3Lt/5asMAOkWoEUZehLVvAo3MN6Lo4zKp5B+lf82RHjhTyXb
         Rk0t86+//Y9nOxzPtCkXDQd0ArIdL1yk+WhEdJbsU+sDji/i4VazA2CnxGR3rgS7m7aC
         3A31oTH6qEb3BKAGr/xJVfS5sUZlUrVwlAYb2MNLH5EJe59IWTaaennAQO51WrYTvAte
         eq1K1dEp9qddBvWH3qysKsC/ssVbV6Smk532Ti9i7+IoQ0j5oTM8aJ6DinhKdwOFSH8Z
         CeWQ==
X-Gm-Message-State: AOAM5325KEGAy1NTaBHUu3jVHMSK4ijubsXplKK9Zn8DJSpmfX/TpKyj
        8i7IMdD9wUspS0FyWCWZQZa1Bw==
X-Google-Smtp-Source: ABdhPJxo2qSVLuSHhc7uKb9o+3uAOxw4dje5NJIJLKDy6nHZr8RDh9WuhE9wiKBRYMmykUWgl7k3XQ==
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id s25-20020a1cf219000000b0038c782c03bbmr7353742wmc.94.1650530671247;
        Thu, 21 Apr 2022 01:44:31 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:35ba:2677:956:980d? ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2150548wri.0.2022.04.21.01.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 01:44:30 -0700 (PDT)
Message-ID: <0d76ba66-9e2c-510d-780e-26fe9626c1a5@baylibre.com>
Date:   Thu, 21 Apr 2022 10:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yu Tu <yu.tu@amlogic.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
 <d10e27ff-e674-87bd-2c98-63c7040baeb1@amlogic.com>
 <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
 <CAHp75Vc87oTmJ6zVeY2mGbP8Jx_SSDtp39Uq4YhWerDUX9RdQQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAHp75Vc87oTmJ6zVeY2mGbP8Jx_SSDtp39Uq4YhWerDUX9RdQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19/04/2022 10:21, Andy Shevchenko wrote:
> On Tue, Apr 19, 2022 at 10:38 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>> On 19. 04. 22, 9:29, Yu Tu wrote:
>>> On 2022/4/18 20:09, Andy Shevchenko wrote:
>>>> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
> 
> ...
> 
>>>>> +struct meson_uart_data {
>>>>> +       bool has_xtal_div2;
>>>>
>>>> I would prefer to see this as an unsigned int and with a less
>>>> particular name, e.g. xtal_div would suffice.
>>> I don't have a problem with your suggestion.Let's see What Neil has to say.
>>
>> Actually why uint provided it's a boolean value? Or do you mean to store
>> the divisor directly in this member, Andy?
> 
> Yes I was thinking to provide the value and then always provide the
> private data. In such cases we don't need an additional condition.
> 

Actually, the original boolean "has_xtal_div2" is right because it encodes
if the HW has an internal /2 divider for the XTAL clock input path.

The HW historically has a /3 divider on the same path, and new HW now has both.

So the boolean indicates if the /2 divider is present so it can be used.

So I'm in favour of keeping the boolean type.
For the naming, it seems appropriate for me.

Neil
