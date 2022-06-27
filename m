Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD55B507
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiF0BlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiF0BlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:41:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF212AF5;
        Sun, 26 Jun 2022 18:41:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so15939131eja.8;
        Sun, 26 Jun 2022 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOZyz54bapplfevA6IoBBeOERMm6lF270gKiNU+5SS0=;
        b=OY08AUHrqEyhZjPXHAwu/Re4XSwQ7eUOOJRTBZERy68JFYUIuxDYh2JhzL5E1nUahd
         Dyb5j9ezXf4gtKt5Y5Hlx3uM0qv/nYytspUtm9XbBMzc5imUwpyNacMdYdgytv8bDI1R
         nqn1D6ihujCaB6Z4EzoS/NN9Urbnkp3R7nWF6cgUQFrn/YmdUuNj/XH4cUsFM/89DT3r
         MX5lLmITv1TnFRgJL2vsASVg4KFSwbbEPU9DFsziuHSboui/oVqBlxddRkdq8ptIRZOZ
         yI275ggimItq5HLOC4a7eQ76WyFC+JkZF4FHeZpyT5qB1dFgDLoCdGWReTQzppehDtIE
         B6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOZyz54bapplfevA6IoBBeOERMm6lF270gKiNU+5SS0=;
        b=qN18RlPleJ4AXrNE5R8KHwH2TLYOi8D2mf3X6eOHITVbwqOwaaSbbQpU0i+TnHoJ2j
         +iVAPar3SmU6ORgadYj0JzW+PaAHLl3DoJ8uk861TOWfwzEPl2d36v73oTB41UgnvK+P
         +6NB0eBQ0yqOjR/vOhdlXwOvWpDB1PeKLneNXxRSwNb1cO9ERCsNkNuE0+y3i+w8KSGP
         EMxx2G5zX8jZ7DEfFfVkC/+sRINXxsS/c+KeiKo5kexDEVJ3Kv9tIhALpIpTsbn7vIZp
         zhIFcdfhbtRu2RGDJnm1OLhlsCIwSBE0Dj1/jBwxH5347pxHqLkLrWeBa/RC9a9WS26n
         OYGw==
X-Gm-Message-State: AJIora/NeT1PMlh+k0oKRfxzu5jT29Dykul7GRDJyAZM2ARrDdZ2weCX
        6dgu8g+xREmfhSdrTaMr9aL5ClpkXXXZBFD7u40=
X-Google-Smtp-Source: AGRyM1s7ySWKu6udqIOVdcXsWUV3jdlPVn3AuS2PaJH44x+HWk/ZbqP4+oYVj114c0ZZlNcMePIp98lzsU0Fa7/TE6o=
X-Received: by 2002:a17:906:38ca:b0:722:e836:1d85 with SMTP id
 r10-20020a17090638ca00b00722e8361d85mr10421852ejd.194.1656294064765; Sun, 26
 Jun 2022 18:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien> <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
 <877d554zvj.fsf@meer.lwn.net>
In-Reply-To: <877d554zvj.fsf@meer.lwn.net>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 27 Jun 2022 09:40:23 +0800
Message-ID: <CAD-N9QX8w1pmYw85Og_vhOE63GgL3ZF4+5uLc6kBjBiJr_F3_w@mail.gmail.com>
Subject: Re: [PATCH] dev-tools: fix one invalid url
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-doc@vger.kernel.org,
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

On Sat, Jun 25, 2022 at 3:37 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dongliang Mu <mudongliangabcd@gmail.com> writes:
>
> > On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >>
> >>
> >>
> >> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
> >>
> >> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> >> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >> > >
> >> > > Fix the invalid url about Semantic Patch Language
> >> > >
> >> >
> >> > I think what this patch doing is to point SPL reference URL from old
> >> > Coccinelle documentation (doc root) to actual SPL doc entry on new
> >> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> >> > description and title.
> >>
> >> Agreed, thanks for the suggestion.
> >
> > Okay. Let's modify the title to "modify SPL reference URL to actual
> > SPL doc entry".
>
> Normally, the way to effect such a modification is to submit a new
> version of the patch reflecting the change.

I know this rule. It seems I forget to send a v2 patch.

>
> I've applied the original patch and made the change, but it's better not
> to ask maintainers to do that.

This change is surely on my part. I am sorry to forget about this v2 patch.

>
> Thanks,
>
> jon
