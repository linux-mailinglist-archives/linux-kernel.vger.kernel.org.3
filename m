Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A0523455
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiEKNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiEKNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:35:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F01A4D3D;
        Wed, 11 May 2022 06:35:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dk23so4090357ejb.8;
        Wed, 11 May 2022 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms4IDLqZyPZEHxNrMd0btLhoMLeIHNUPT9ze1DMC0rY=;
        b=b6PqNPlOT1b5n0ZwMSJFTOWuIVZybJXt7gUtC32lfxydPEwh8eTC/LgwvVWE/S0YoO
         z/RvEfLIOhASm7OpJiz0iqKj8nap0nKnyh2+32Ej6sur1kmI5NH6ivKXO/cVEeSkfmBt
         eOPtXXafMPkPhN0ozaoPgjbl4KgX46Kqe6tbD6Isu+jwUxF9v6jdjkDD+AyodduLapA0
         Hobs6Vq0yDDLibD0QzWiK40cgI9Lj9b/03XNgKFokA7r4o0FiW/z4Wsjna8IC1KKgyV7
         IAQxy+Y5z8vGSuq1/ez7/ROSlVUTjKQDoBgo3+HwsYmYLZ2H5aEYc+1zFaUQOL0LUVlJ
         9apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms4IDLqZyPZEHxNrMd0btLhoMLeIHNUPT9ze1DMC0rY=;
        b=nqsID0vInnUeIiY7hvuC3gXM5T9WRrQlX3Q70tvEBXTtdLKqzJAb3Dh8Z2NBbKv4hC
         K5FfeiboI68LkovPWzO8xJzsjulnFehOhLvAbb5Icx//Y6SfxpBNOIVxiY2OssQJUOWl
         xXqr4/xBFGWNs2EZ1JVLcp0puwupNvNt0OVZTOXgsUjVhpiAkWaW6d9LZqRnia6lffF+
         cCToPzwmbEcGDs/peyKhOrUuc4bafBAscYi3pnf1QEH9iBvZm0pehuY1v1BT/tN+nDjv
         5/eZTL62NRopmZ/yOhz/US/eq1rDeusEETLl778ZdnmDS+78B5FJSR1U1gjRrC4Xa37R
         7N7w==
X-Gm-Message-State: AOAM533q8+tFJxNvZtBjTVCjHrPWhPMD80758u6IbpkHZ1EztRIDP6O0
        UqsVQOVmsX0YpfTF4HMOQvZskxZf8RLTUeER85w=
X-Google-Smtp-Source: ABdhPJwm48w9xaikhsGpSBVYiaDfH3RoQAMGR695rlQUewHzVEO1FE9SMr/7XxcFVYHqMbN3+K6odlfP/wdn05UafQs=
X-Received: by 2002:a17:907:9720:b0:6f4:31d4:925f with SMTP id
 jg32-20020a170907972000b006f431d4925fmr24761326ejc.658.1652276133336; Wed, 11
 May 2022 06:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220511115911.54960-1-max.oss.09@gmail.com> <20220511115911.54960-4-max.oss.09@gmail.com>
 <CAOMZO5AboNfb_E-4QVurZ6UTYephsOakW0QrAU8xRAMe8_zRow@mail.gmail.com> <CAEHkU3U=58qittoNazqXrkYKO9gs7VU3VW_67823fs+dt6r6eA@mail.gmail.com>
In-Reply-To: <CAEHkU3U=58qittoNazqXrkYKO9gs7VU3VW_67823fs+dt6r6eA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 May 2022 10:35:20 -0300
Message-ID: <CAOMZO5BkcpNN+UVLTq+1-y7KdqDC9GAX5_FFqb930OaCewT_jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify
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

On Wed, May 11, 2022 at 10:32 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

> I disagree. Just setting the invert without at the same changing the
> brightness-levels does
> change the user experience way more than when one adapts the available
> duty cycles
> at the same time.
>
> With the change to use the PWM with inverted polarity the PWM signals
> is inverted to
> how it was before this patch. Keeping the brightness-levels will then
> have a big brightness
> jump from 0 to 127 duty cycle, the other 6 steps will then be barely noticable.
>
> I.e. before the change the brightness for level [0..7] was
> ['off', 128/255, 64/255, 32/255, 16/255, 8/255, 4/255, 'off'],
> if one only inverts the polarity it will be
> ['off', 128/255, 191/255, 223/255, 239/255, 247/255, 255/255].
> With the proposed patch it will be
> ['off', 4/255, 8/255, 16/255, 32/255, 64/255, 128/255, 255/255].

Ok, please add an explanation to the commit log as to why you are
changing the brightness levels
like you did here. Thanks
