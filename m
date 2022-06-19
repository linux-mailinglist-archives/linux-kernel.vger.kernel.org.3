Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B20550C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiFSR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFSR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:58:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B86370
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:58:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v14so11793451wra.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6x9BP2AjM4r3FFQZwLJDm0CAIjFvtNEQQOy44AFf4Gg=;
        b=RebioXFeA/NM3UxANrbTJdIe2uGqe6uSHkN4e9iyWT1uKHjvZs6fLamqA/3BqahfjY
         zD9omRA2AynPRPLFKMsYbNSx3DZF6iZvSjwcTf8fPa6CfjXPqrktpY+i0dWrn+DNumFU
         9dS8FKbt6C/0ZN+rNjxkDuX4sUk8SP9xic2UqR8nt2VyXPXtN+y2qwrUhcsdOyznkjXm
         RU6RGA+wtR540cCG4tG5dSIboEji05TUel5oHs3CR3KdjljU96eXJA8Pe3uPCHJBueDz
         7E7AvyyZgHHgkmd8KSn81Xefi6m7yEcMVS3pykgCjqwDBM8VOWxhxTcLtcLPAZUohFeo
         Lx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6x9BP2AjM4r3FFQZwLJDm0CAIjFvtNEQQOy44AFf4Gg=;
        b=PD6G6rj8vDd5fVZfVGsZfa92YLcSH6MzlKtfCRkSAoYpymHZZc7kOPlwPM79ra/oJX
         G1OWx7ZiqcHL156aXUhSsHdAxJUJS/RZ3xGRW/c8OP7fsIVVv9st85j0gmTY8JiUAJJm
         /RRmVjJFOZiE+mRyOThsLx+dU6FG1A+T9fgHH2f5c1Cqub5pqPtzLwuz2ISETUjCBCnZ
         av8lGQ3765p2TNUCnxr8128dz0iOXnaSyszRxFkSVzlHZ0mp4nQc/5wNdRnTO82FDaRs
         r8QBAsQyzi837W5hLzdFcOFbqk2NH1G+BX7D5tQu2UuFHDNUnW8HY2HhhucFy91nhB/2
         zqNg==
X-Gm-Message-State: AJIora+Dr1IFHNVLr3YjjIdsit3czVo9eJrC2DpD23ZE304D+sDTs1S/
        1kbvlaxdMUzjwQIgrXJd3++jHFiPuRC6w+cMFvo=
X-Google-Smtp-Source: AGRyM1tc6FUksXdJCEszTOAw5xP946fFO3z0jjcCqbCloKRvvfio+83CGjaG/vyVsK7WFpyjylZ3Uw==
X-Received: by 2002:a05:6000:1689:b0:218:3fb1:fd30 with SMTP id y9-20020a056000168900b002183fb1fd30mr19227123wrd.302.1655661514581;
        Sun, 19 Jun 2022 10:58:34 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id l1-20020a1c2501000000b0039747cf8354sm12102073wml.39.2022.06.19.10.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 10:58:33 -0700 (PDT)
Message-ID: <a45b0d2f-6550-3352-68c7-450dc7be8cd2@conchuod.ie>
Date:   Sun, 19 Jun 2022 18:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC 3/6] clk: microchip: mpfs: add reset controller
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220619164935.1492823-1-mail@conchuod.ie>
 <20220619164935.1492823-4-mail@conchuod.ie>
 <19bcf5cb-e291-2c18-b006-f4e9e7adac92@wanadoo.fr>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <19bcf5cb-e291-2c18-b006-f4e9e7adac92@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/2022 18:19, Christophe JAILLET wrote:
> Le 19/06/2022 à 18:49, Conor Dooley a écrit :
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> Add a reset controller to PolarFire SoC's clock driver. This reset
>> controller is registered as an aux device and read/write functions
>> exported to the drivers namespace so that the reset controller can
>> access the peripheral device reset register.
>>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]
> 
>> +static void mpfs_reset_adev_release(struct device *dev)
>> +{
>> +    struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +    auxiliary_device_uninit(adev);
>> +
>> +    kfree(adev->name);
> 
> ?
> 
> Below we have:
>     adev->name = "reset-mpfs";

Aye, good spot thanks.
Was a hangover from me trying to figure out the auxiliary device
naming scheme.
Conor.

> 
> 
>> +    kfree(adev);
>> +}
>> +
>> +static struct auxiliary_device *mpfs_reset_adev_alloc(struct mpfs_clock_data *clk_data)
>> +{
>> +    struct auxiliary_device *adev;
>> +    int ret;
>> +
>> +    adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +    if (!adev)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    adev->name = "reset-mpfs";
>> +    adev->dev.parent = clk_data->dev;
>> +    adev->dev.release = mpfs_reset_adev_release;
>> +    adev->id = 666u;
>> +
>> +    ret = auxiliary_device_init(adev);
>> +    if (ret) {
>> +        kfree(adev);
>> +        return ERR_PTR(ret);
>> +    }
>> +
>> +    return adev;
>> +}
> 
> [...]
