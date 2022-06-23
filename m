Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6D558A33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiFWUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiFWUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:34:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9960C7E;
        Thu, 23 Jun 2022 13:34:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r20so437836wra.1;
        Thu, 23 Jun 2022 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IK/XCGAwWKhc4dZa86Nh3vaAkVdDBZoCXA0duTVjqDQ=;
        b=gYaWWKTLbWBMByASORPVMc8CxPoGbr8pioEUymVhlmvBZLN8LoSARszNyJgfFej41z
         rnPlmHOZPjROJg9n411VO4Y6wY9fP65bGZf/Gq1IrOIKeDeXUabzFF7CJXjxqn/cTIln
         2uSL38+TGWqC9kSQqvJz/Qy8+ck4c47dcfF32Uc5Sf5Y6NG5chuVM1PGpMzJl3J8atW3
         B8VkCVATtmfUC6xfEKL9DX1YYTSLiE+z8KPUCx7AOZItbp1Nl+DkliPvDEcE7ctf57Qi
         lJUtws9CIIgQV7SaxLuCtAi0k1ERnxXrGSQW6OJGPyqk7M4jCys5SxkVaQ2lloXz/R/Z
         ThYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IK/XCGAwWKhc4dZa86Nh3vaAkVdDBZoCXA0duTVjqDQ=;
        b=hRcA5qm3ZkFNBso5NPaEDe5vZL4J0Z+u75KN+n5MBGl8iMECqABWdQu3KAzUnVVGCt
         2pkrliJn7g4qFQZajKbqSY9qZueumGwu4BUNsadE3qiWWyHQmjggBeyb8GrFdar6/FNW
         xXsbsTuB/N3kBhn5IFpwYc2E8Vgi9r93IIM6fqwmt3UY9i1FHBJaqoRRNl/XwEPS+/pK
         I4a0whFbNiVBng3Mw1LXxCf9N+10HTPy55tk/2xjIp5Sc9qMkIoKSfpJ9utrfQLXqNNs
         RGANs3o3mT/Cc3UNAWU1cm/ywavK2QOrlpjCoobC2Jp6+1H+9Uwy3lI52T5+/v1FoWJ+
         bq4w==
X-Gm-Message-State: AJIora8kSYO1BYVWGAcNhgZ+V1Bv+yVtvuI9jFykJmLXCX5B/ymjQp6E
        /z7/UrTFEzpSW3L5vvQG1DE=
X-Google-Smtp-Source: AGRyM1snb1laNeZAsPIQd3dxnawiGNhk+UGfN5ihQx8QZ4cdi8LYJtk5LQihHXV1jMBUlcrHVvmA6A==
X-Received: by 2002:adf:df09:0:b0:21b:8a8d:99c8 with SMTP id y9-20020adfdf09000000b0021b8a8d99c8mr9696887wrl.152.1656016482596;
        Thu, 23 Jun 2022 13:34:42 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b0021b96cdf68fsm312754wrs.97.2022.06.23.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:34:42 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
 <YqDLflKTsYaupArl@sirena.org.uk>
 <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
 <CANhJrGMqUmnSvyNRgRyp40YnGQkD3N_2AZLn94NDp+4RG0_x5w@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Chen-Yu Tsai <wens@csie.org>,
        jic23@kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>, lars@metafoo.de,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 02/17] regmap-irq: Add get_irq_reg to support unusual
 register layouts
In-reply-to: <CANhJrGMqUmnSvyNRgRyp40YnGQkD3N_2AZLn94NDp+4RG0_x5w@mail.gmail.com>
Date:   Thu, 23 Jun 2022 21:35:47 +0100
Message-ID: <AX8g6eUgSrGJYBxU1YYNt2559CtK9b5G@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matti Vaittinen <mazziesaccount@gmail.com> writes:

> Hi dee Ho peeps!
>
> Sorry for the late reply.
>
> pe 10. kes=C3=A4k. 2022 klo 18.43 Aidan MacDonald
> (aidanmacdonald.0x0@gmail.com) kirjoitti:
>>
>> Mark Brown <broonie@kernel.org> writes:
>>
>> > On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:
>> >
>> >> -    if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>> >> +    if (chip->get_irq_reg) {
>> >> +            reg =3D chip->get_irq_reg(base_reg, i);
>> >> +    } else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
>> >
>> > It seems like it would be cleaner and clearer to refactor things so th=
at
>> > we always have a get_irq_reg() with standard chips getting given a
>> > default implementation which implements the current behaviour.
>>
>> I don't think that is a good way to clean things up. I only intended
>> get_irq_reg() to be a quick hack to solve a problem; in my opinion it
>> would be a poor abstraction to base the API around.
>>
>> What I'd suggest is something that will simplify regmap-irq. Instead of
>> defining the base registers, etc. in the chip, introduce a new struct
>> to describe a register group:
>>
>>     struct regmap_irq_reg_group {
>>         unsigned int status_base;
>>         unsigned int mask_base;
>>         ...
>>
>>         unsigned int irq_reg_stride;
>>
>>         int num_regs;
>>     };
>>
>> The idea is that the registers in a group are linearly mapped using the
>> formula "base + (i * irq_reg_stride)". Then it's possible to allow for
>> multiple register groups in regmap_irq_chip:
>>
>>     struct regmap_irq_chip {
>>         const struct regmap_irq_reg_group *groups;
>>         unsigned int num_groups;
>>
>>         unsigned int main_status_base;
>>         unsigned int num_main_status_bits;
>>         int num_main_regs;
>>
>>         ...
>>     };
>>
>> It should be straightforward to fit existing chips into this model.
>>
>> - Chips that use a main status + sub-block IRQ layout will define
>>   one register group for each sub-block and continue to describe the
>>   location of the main status registers inside of regmap_irq_chip.
>>   A group will only get polled if the corresponding main status bit
>>   is set -- n'th group is polled if n'th bit is set.
>
> Does this work for devices where a single main status bit can flag
> IRQs in more than one sub-registers?
>
> Best Regards
>  -- Matti

No, I realized once I got into the refactor that what I outlined here
wouldn't fit that use case well, which is what rohm-bd71828 needs.

There are some other complications with this approach, like how to
go between IRQs and register groups efficiently, and it's generally
a rather heavyweight solution. It might be useful for handling very
hierarchical chips, but I couldn't justify the added complexity when
most chips don't need it -- after all most chips behind slow busses
will have a small number of interrupts and a fairly flat structure.

In the end I went with Mark's suggestion to factor things out around
->get_irq_reg(). At first I thought there might be too many "gotchas"
that'd limit its usefulness, but in the end it proved to be a better
option and a lot easier to implement.
