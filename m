Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF534FEFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiDMGaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiDMGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:30:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A44093C;
        Tue, 12 Apr 2022 23:28:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j6so679007qkp.9;
        Tue, 12 Apr 2022 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQXd2jV2y0H/jmnC3zsa4bcZYEpr7db5gHWElQ3LxHo=;
        b=AvEuQTFPadwF9B77e3hFm5DnRzYyP8mYjU5oKInOTekImMPQ9N1mTIms5cmjhh5hfX
         LkSFJbC8gnLmJpgwY9zA4JI9A+RTpDk5xxPfFD0tF0qxtIC1rK0grKMt/tLDK8cS23fT
         RulFwQP5jljqMXD5I54GLeZedam6rTu20H2OlNPRx5/9V/Vn8nf/+xNxosavSCJY/SCu
         +poIEZNxeCdfOF4HvSyXtg1difDMot4a7EYKqtr2rJrY4OKZ+FFp5sutGw0baRndzwRM
         OmTkbR4cyxBWSnly8W0CvNAabWt3/+9Tr+h92US8UHNUlCwCRzxn0emaPr/vkcSVEKYA
         vplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQXd2jV2y0H/jmnC3zsa4bcZYEpr7db5gHWElQ3LxHo=;
        b=AYLwmWLEH7leIN+QHqPkA7KzuyvuCxzrza3+nt0Pd2p7QYs8PlGyAENd0jPNES52kk
         PSf/jgL0814QywtGZpaFRgx3WcpdcNKLpCpIGWR8s0TzdGRNRdKATPAiTt/tXk0onavd
         XfqecNxVD2/I8qlccAYPR9WnhiKEbgFj2ygg+0/APjJdx17qeE7VBx2UntBTw/JJN37Q
         skSqNqXbMCfYG55+PNhnkpxsykEHhGHXN7ORBTlh8I362puPJ6DacnifEvDSLb5BuQwX
         kRtz3MbMDG7DFpttoDhx4HR2i1dbHXa6olQRobv1BeGxRc4JYKZVPpSVUe5/HY02LqGG
         C5Yw==
X-Gm-Message-State: AOAM530x+RX0BKWTDc4HkVuVE5e9B2LTjBg095e6p7YbGwBwIlsdrOCL
        6lgTVOtJu+/djetZHpJ6UGToUO4N6dku5ilm64Y=
X-Google-Smtp-Source: ABdhPJxSAul1DQiuip/zXWO7y/5rdjzwToJfLdrqCdPR32d03sINv0FlPWqCmtrCOu+ed1zUDp0D9fKwELAyHXivy54=
X-Received: by 2002:a05:620a:bd5:b0:67d:15ed:2fcd with SMTP id
 s21-20020a05620a0bd500b0067d15ed2fcdmr5870340qki.81.1649831281235; Tue, 12
 Apr 2022 23:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220413060729.27639-1-arinc.unal@arinc9.com> <20220413060729.27639-9-arinc.unal@arinc9.com>
In-Reply-To: <20220413060729.27639-9-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 13 Apr 2022 08:27:50 +0200
Message-ID: <CAMhs-H8W990kGWPtVkLLXj4wr0+v8aEgv42K6Ffh+k=misYvGQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] MAINTAINERS: add Ralink pinctrl driver
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 8:08 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Add a new section for the Ralink pinctrl driver and add me and Sergio as
> the maintainers.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..cbd0c3e180bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16502,6 +16502,13 @@ L:     linux-mips@vger.kernel.org
>  S:     Maintained
>  F:     arch/mips/boot/dts/ralink/mt7621*
>
> +RALINK PINCTRL DRIVER
> +M:     Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> +M:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +L:     linux-mips@vger.kernel.org
> +S:     Maintained
> +F:     drivers/pinctrl/ralink/*

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
