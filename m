Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFC526056
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379631AbiEMKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiEMKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:53:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5712181CD;
        Fri, 13 May 2022 03:53:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j6so15435594ejc.13;
        Fri, 13 May 2022 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWVJvwsGE3WVOqhfUYTwQYp/p0p+hpGDNsU5mTlsoz0=;
        b=MLv3S9QPgRCNHi/TxXZ/rHDfMviz7puR61CX7fRdin2cicZ2/4x7Fx4OWqDIuDHwoF
         j8yvRUV6rdpDRs3x2tz5mmsOXgy/hbZjbNMBQ3GiSayTtehYim3PRp4HjcUvACO+xMmR
         K0K2AI+zM9lETZylp6+XPI4vKY8/ur3hif157+Y3QF7nlqLHS/KEEUksNuvPW7rqEWZR
         mOenM72TWH+B6RCE/n6Qo86mL3Nq6dWtpqx1K9jNgNSFJHJCH4dYP+Xd7jmVaQl/TK6C
         amBTj6ceJBR0zYHdWAwI46Pnguv1DmUzhFywqEecuO95XpsZnpPgJvEh8ci3ecTO/tPA
         HiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWVJvwsGE3WVOqhfUYTwQYp/p0p+hpGDNsU5mTlsoz0=;
        b=bV/c2MADLHZC738H5a7Wjy77P8mGIX0SC+lOLmHR6bJf0hzwHoZp6jO9Hd9urCkCJM
         YaG1f/CpNN57knxXwSrj2OTZTCFQu6Goci+ePy5fzObAYuwXoT+GaRtkRtBKBq6265Ng
         8bcGYbqMDyWhr6jaXe0BkY0BhVv90brueLnKg8bFbO0ORJzAKqpnn8JFXjXg8zPelan2
         NjmY8LS3elF0DaRy2i2tXBJmYucsn9JaSaYcew3pSA9+9df2e0v8vMb+1uLK8VA/WChE
         syeYGlaGuFF+BqY+EzdXItiP4MQOqB6TsH1OFOZFwxbMO8XQJmDpDm6FqaWbB1YfT6zg
         foxQ==
X-Gm-Message-State: AOAM533DmYyf+lokiaVh2w+hzmJVxPfciQNuRHqyLOTK99rFNAU6bePX
        PoGCT6AiLvLW49u/FVwoqdaSGnBMR/4FGzQ8i/A=
X-Google-Smtp-Source: ABdhPJyFZ03+m/z56osQbJPTI/j/4uVvS1oPcoZQF85rOa88+OzqgS/IG7zeMEE6Do1nkJbhtQyUlzddci4G3cyBdB8=
X-Received: by 2002:a17:906:c14b:b0:6f8:e6bb:f8d5 with SMTP id
 dp11-20020a170906c14b00b006f8e6bbf8d5mr3690483ejc.4.1652439213746; Fri, 13
 May 2022 03:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220513102616.48040-1-max.oss.09@gmail.com> <20220513102616.48040-4-max.oss.09@gmail.com>
In-Reply-To: <20220513102616.48040-4-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 May 2022 07:53:23 -0300
Message-ID: <CAOMZO5Au5_=0enWpfQBOK6_62r_5iL4m-pd93Px-NUO9dXb5-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify
 inverted backlight
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, May 13, 2022 at 7:27 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Set #pwm-cells to the default 3 to gain access to the parameter
> which allows inverting the PWM signal. This is useful to specify
> a backlight which has its highest brightness at 0.
>
> With the change to use the PWM with inverted polarity the PWM signal
> is inverted to how it was before this patch.
> This changes the meaning of the values in the brightness-levels
> property. I.e. the duty-cycle changes from x/255 to (255-x)/255.
> Keeping the brightness-levels will then have a big brightness
> jump from 0 to 127 duty cycle, the other 6 steps will then be
> barely noticeable.
>
> Change the brightness-levels to provide the same brightness-levels
> as before.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Thanks for the rework:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
