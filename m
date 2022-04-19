Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B41506667
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349677AbiDSH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiDSH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:59:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246F13DC2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:57:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l127so6088068pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyBstMesL/nxa3TupnuEQVtjseuVvSQ1qaNlAJTrvJE=;
        b=TA1e5S0BAgjDEk2icHXoMCo70PK5k7JjlIGA3ZR1iXYRZsH5sjEDhjmGvzdDzDPWCk
         VA0wczzlM7JGCVdAgmuz9czKQPJFx+oQ2nso5PMOKVKoM1I/VfKWAXiTi/EC7AvHJ11g
         6tsK4Te/0wTRTsG9hl23SfdKseYEtjKt+jSzL0SDmAqT8qXm169ieSkD8DBuAcH+kOBn
         T+zDD3E2qDSqqJAT478udP1v2dPXEPdAJw7xfe0fyVztr/e4jYIUtlFsunJi5fVRcuXN
         SS2SIJtIm/pV9r6WpDuW0phAIvAT6hNKi22dhX47bIEwN5gaMETyqb56COBMhuzmUqrw
         VWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyBstMesL/nxa3TupnuEQVtjseuVvSQ1qaNlAJTrvJE=;
        b=d6PU8HIpeP+KxhUjXIGCkkmopTDJCz68U+TCcJ5dmbVevFGzcyuD1ZeB+75NxBoO9h
         jL+d1FTNqLrwxJr35bSu1Fj7IX7ZmV40UaZq7idtTCf4mE7OugcRO907JdpziUdXGCRt
         +WhsHmM00itSe6sqCHcn6N5/xt7JLbpP/lFAk2EhWvhEUeDd9HViy9aAuaS976zxfYVr
         h3rH0Ijxi9KI02Gm4h54BOtZKQwKrXr+IGm1vKmyHf/7sj88kEU0yooSIh77jKHI4ACy
         95TAojr2MltKNrYUBTS5JLE4RoDdMe+0WQFX3O4HXoTpo0VrR3vEWbXORsbaqyjHBkOt
         yCrA==
X-Gm-Message-State: AOAM530JtCAl0djz6TQRsEhMcsLSY9sFeAfdIyZf7LFL0XnXiVm7Htp/
        qMLd3GTK0s/w+4bqCjjg5CF4luSZgceA8MH29EAiXg==
X-Google-Smtp-Source: ABdhPJyeansOcVzx6HaT2B4rkPnUrwXIdc20DvE9tv0S+IGZXj3/BWW803aPZ/eQ35BX+bPpQooHbuy7o8x7+Thd6OA=
X-Received: by 2002:a63:4a02:0:b0:39d:b8ac:59a4 with SMTP id
 x2-20020a634a02000000b0039db8ac59a4mr13534988pga.464.1650355024275; Tue, 19
 Apr 2022 00:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org> <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Tue, 19 Apr 2022 09:56:53 +0200
Message-ID: <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
To:     Jun Li <jun.li@nxp.com>
Cc:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 09:53, Jun Li <jun.li@nxp.com> wrote:
> > > > @@ -132,6 +132,7 @@ config EXTCON_PTN5150
> > > >   tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
> > > >   depends on I2C && (GPIOLIB || COMPILE_TEST)
> > > >   select REGMAP_I2C
> > > > + select USB_ROLE_SWITCH
> > >
> > > You do not need to select it. Driver will work without role switch,
> > > won't it? If it works, then probably it should be just imply.
> >
> > Okay, usb role class provider should enable this for me, will drop it.
>
> A second check on this and I think I still need this, there
> maybe some usb controller driver without usb role switch
> + ptn5150 via extcon, so no need USB_ROLE_SWITCH, I need
> select it to avoid build break.

What build problem exactly? Aren't there stubs for !USB_ROLE_SWITCH case?

Best regards,
Krzysztof
