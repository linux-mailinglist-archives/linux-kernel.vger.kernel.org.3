Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5614D76CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiCMQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiCMQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:33:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95D53706
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:32:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e6so16545206lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgbGltuaJRuITqNo6niNlVF62PUXiwOYLBSZYU1DMZY=;
        b=HavKRC7e7SCp/3v05JphI4/Yz7bPK7gwb8+Df9JEKBuE7/JkdMsZJSL9kMd2cn1Kjm
         Glg7VkMXOTEPAMd2Yc3IXAZ1MdptomgRPgppe1ltEzHQTBbBDiL4oJKjoppDx1aoZOTD
         341LeLMT7W8/nKRFkcv2QkUL0CWh9xnZOBw9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgbGltuaJRuITqNo6niNlVF62PUXiwOYLBSZYU1DMZY=;
        b=354b+9NZ2A1NUKACEQO0MyiagMI/HwCmHRflRrY0+joC9eTYAYJzG+GdTJyLC+VGNo
         1efTgK6Q+rz4GVnomRJVv0mUQmxufEO8TDfZ8ZaKbc2nykX/iGN+pySIJD/GxaVGKYSg
         Tnq32u670D/tYweRRnfBDNUiUlVe5cwwnTiuSV2t2anENyByCrqzms7vBdJkqEH6iSQU
         E7/cU61Jn+MG06u3+pGKhNZcu0esWQ5+oYi5jcEvF8qFLNu9jXG5NqbfbxF+DeJBQzLi
         QIqHq81wDtYh0rTExDfxNT7Zui64akFqUhHQXGLcEwi3NEeAicGjGTfjhi/olVpb/+JT
         hbpQ==
X-Gm-Message-State: AOAM531OGCOhqhS62cPhcC9d0RwY6v8ylFYuv8/YmyWOGd9kolH5qBNv
        iL3FZliUceuvGBUDrx9JjV42vQJC1emijEpCEb9uUQ==
X-Google-Smtp-Source: ABdhPJzST1eUNK0xE/Hz0ZdqgE+l5aHR3jttA2qgChiJRwiYskuy/WzQ5S7vXdDtSk9wjGiEFoZf5azBb3KRXlY9L6s=
X-Received: by 2002:a05:6512:22d4:b0:448:61b9:e61d with SMTP id
 g20-20020a05651222d400b0044861b9e61dmr10744148lfu.662.1647189150954; Sun, 13
 Mar 2022 09:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220217165559.313366-1-dario.binacchi@amarulasolutions.com>
 <20220217165559.313366-2-dario.binacchi@amarulasolutions.com> <YhgGZylBoxlou9ka@robh.at.kernel.org>
In-Reply-To: <YhgGZylBoxlou9ka@robh.at.kernel.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Sun, 13 Mar 2022 17:32:20 +0100
Message-ID: <CABGWkvqerAqEn4y-WHvxjhmZXtuiP8ptDib5qktso1BMnsMfhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 24, 2022 at 11:27 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 17, 2022 at 05:55:53PM +0100, Dario Binacchi wrote:
> > It allows to change the M06/M12 default scan rate.
> >
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > index 2e8da7470513..aa8517c6f65b 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > @@ -85,6 +85,14 @@ properties:
> >      minimum: 0
> >      maximum: 80
> >
> > +  report-rate:
>
> Use property unit suffix: report-rate-hz
>
> This should probably be moved to touchscreen.yaml as it seems common.

I did some checks but IMHO I think it's better to consider it as a
property of the
driver.

Thanks and regards
Dario

>
> > +    description: Allows setting the scan rate.
> > +                 M06 supports range from 3 (30 Hz) to 14 (140 Hz).
>
> You're using 3 or 30 in this case? Should be 30, but it's not clear. I'd
> just list the range in Hz and leave the conversion detail to the driver.
>
> > +                 M12 supports range from 1 (1 Hz) to 255 (255 Hz).
>
> Use '|' if formatting (newline) is significant.
>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 255
> > +
> >    touchscreen-size-x: true
> >    touchscreen-size-y: true
> >    touchscreen-fuzz-x: true
> > --
> > 2.32.0
> >
> >



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
