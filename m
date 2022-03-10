Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBA4D4ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiCJOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbiCJOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:19:37 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5EC559B;
        Thu, 10 Mar 2022 06:16:26 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o22so4648505qta.8;
        Thu, 10 Mar 2022 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2L8OR5koUh2CDVJY7FcCTDkGe8HG516p7zFzZPDOUYA=;
        b=NnkiLgsEZB4dZyt1H8ltHuaieq6L4WSw2AG364q8ofxQwnVhizrC3MKo+CTq4HeWqI
         PPXTdUf7CrJBMWocGLjt5un9QvOPxFqYsFYY3QZvMiVizagUCufylO97Diz1mQqnt1t3
         UINlKk30iYZrlU2kDThBq4FbK+Eb2wQj2DITIdW/5k9i8i/ODbzsAcjvYynPbZt+W8aD
         H/sG4JBdYeYQX4YXAJUsP8UujuxmYHhYFLCY6R1lpZdB4lhc0ezu2bxoTYDCLX6BDRUm
         go5/DhjyXe5gYUyB+faVrBVqPu6JFfGJt2v42p3/4VHjXcNvR+85IRGNVEQONve4zlzC
         t+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2L8OR5koUh2CDVJY7FcCTDkGe8HG516p7zFzZPDOUYA=;
        b=zYmJsX1G/dWzUn2EB7damWRj/08Bp4pYXYyMXhQniZV+60DJoKkRurFrFYqJJgvaD9
         7+cQBgJqV9y1QWqzkiCWr+9Q2jmT7bhctj4arZhBcFDaIlFQ8/zA0fot6fw9zpWllG48
         4xGOc6adZpxM9T1cUBEqwP1Us4rCjIiFrDPiDmiQaNKYJtWfJZzpD33Jji/q5jxyA6C/
         4V5hmturRU7l+Fy3K13PwAy/tHTazRtixOJsgJ5qsWImCN+x7+dWE42xa2fIkFvP7mcT
         YYacm8/0kRaOswjlNJZ4uT4AjLyjizZwzVkD6PEm78w9YSTkz49ny5TTWz/RPhZq3xNR
         w6KA==
X-Gm-Message-State: AOAM5310nahwiWsp+8NQhSSwFE9Bqv5J7g4LYT5TMbPk9ihmprLgfPTu
        tb0z9kpsWA14mzts0XdQQdsLZLrKlR/gCtP0agI=
X-Google-Smtp-Source: ABdhPJy0vcFKq3czcAkuCKChovxMM8akI73joMv8l5k6Zzq/zj/9f/Pyn2v7HMfvT8wBCVN4ICZVgzd3wKyaV7cJyn8=
X-Received: by 2002:ac8:7f51:0:b0:2dd:dbca:1f40 with SMTP id
 g17-20020ac87f51000000b002dddbca1f40mr3924359qtk.463.1646921784722; Thu, 10
 Mar 2022 06:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20220310140542.7483-1-arinc.unal@arinc9.com>
In-Reply-To: <20220310140542.7483-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 10 Mar 2022 15:16:13 +0100
Message-ID: <CAMhs-H_+UXiYQdpE_WKAgEw0=1s5DA0ftQwD1w+W2vORQxFdKQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: rt2880: add missing pin groups and functions
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, erkin.bozoglu@xeront.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:06 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Add the missing pin groups:
> jtag, wdt
>
> Add the missing functions:
> i2s, jtag, pcie refclk, pcie rst, pcm, spdif2, spdif3, wdt refclk, wdt rs=
t
>
> Sort pin groups and functions in alphabetical order. Fix a typo.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
> I didn't know the order to put the missing groups and functions so I sort=
ed
> them in alphabetical order, let me know if it's not ok.
>
> Ar=C4=B1n=C3=A7
>
> ---
>  .../bindings/pinctrl/ralink,rt2880-pinmux.yaml        | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
     Sergio Paracuellos
