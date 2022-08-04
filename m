Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9004658981B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiHDHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiHDHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:07:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0661B3E;
        Thu,  4 Aug 2022 00:07:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so12515274ejb.12;
        Thu, 04 Aug 2022 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tNYjvdH86S2UFNUtFTO0Ym4RZvNgdxqohXRh3u17y0=;
        b=iISBakQM+KhpORSAdwWKu6+Oq3YQYY+hKhzjxD+MjvvIeZVHWb5j3C9ax/7Y4lagKL
         H7qStbRFh2yhGRMe1E8pf8GEkzmcS53fIg3/pUrd1fkoR8lyuZYot6uV2Yb/jK0TUYoz
         zY0J2ZjiwHZl0oaRdlA2cFV7mId9QLrKkU5CjrEiLW0zbFFdczgxmeIl8XsenBqly0mT
         CvyZHGcWJS9vw32k/7uEmKdb3esAjwBoe7NUmpj1SYqjgKXkRrrRBj+ayYT1h7YFB66u
         VI1pEi9W0tx80CiNSBbc1H78nvAShAGJLIDyF68+ipFfwi9L98BAAeoOhDS3OC9DebZ2
         S85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tNYjvdH86S2UFNUtFTO0Ym4RZvNgdxqohXRh3u17y0=;
        b=oHrBGiYEDwvDhODtNxfDSAIMU5hzooK0zCf9zzVnH6NfyufzY4k+rBM7w1lIG1B5oZ
         xBHyfaFINDjyGbQwSS75bcmOYXncX4S8Nc7Z7hJS0AoWaEPD3G3i6Gf8dTnDgZw5WqcK
         RKDxFMNLpCgQYLms1YR9e5wSsxD6wj3u83ZLkDZ/U+Qk4gtpNADcQuNenGtghdIkLlil
         c9g/XDZBREuTr6SXXb8PC90pHGvqMgZVmmHpS+AP2yVBgm7S5eBMpOeudGQEXelIN1W1
         ARFPZ57Ovkw6oT/ezZKYDHG9hv8OuJSwlMhyNfejxRSxyWg61n1MzkPZOd+QUDoY8wc5
         iKSg==
X-Gm-Message-State: ACgBeo1gZyfOD5gZvW7b7YiMA8Bw1RQEOb4EzIvmdvwstuPrShMv8jZV
        28qr1LM3Z2o5+Zve5WtHrcyEjULlsBXlVjyC+rKoruR0AE0=
X-Google-Smtp-Source: AA6agR7YMNcfmKToFJf89LOx3azGb6RKBSee7DlUdqWqPn6KEUH7do4CfBR02eYBaYxueKug3aCy/tWr+ksjMZNKZkM=
X-Received: by 2002:a17:907:75d5:b0:730:b051:d93f with SMTP id
 jl21-20020a17090775d500b00730b051d93fmr376508ejc.568.1659596857030; Thu, 04
 Aug 2022 00:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090218.1313187-1-kkamagui@gmail.com> <CAGRyCJHX1X238TkiTaML3WJ+rdc1-m82_d3Ut4jCVDmuQ=cMOQ@mail.gmail.com>
 <CAHjaAcT2fzpfJ563Jx5n3eYyrZD0vHNLr713qTZ=trrDjPaU=A@mail.gmail.com>
In-Reply-To: <CAHjaAcT2fzpfJ563Jx5n3eYyrZD0vHNLr713qTZ=trrDjPaU=A@mail.gmail.com>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Thu, 4 Aug 2022 09:08:24 +0200
Message-ID: <CAGRyCJGTXWNPmF6ZgTJuxzy++rbpS_irJAhv7Jrhg0BMqqwA3w@mail.gmail.com>
Subject: Re: [PATCH] net: usb: cdc_mbim: adding Microsoft mobile broadband modem
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Oliver Neukum <oliver@neukum.org>,
        David Miller <davem@davemloft.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Seunghun,

Il giorno mer 3 ago 2022 alle ore 14:56 Seunghun Han
<kkamagui@gmail.com> ha scritto:
>
> Hello Daniele,
>
> On Wed, Aug 3, 2022 at 7:58 PM Daniele Palmas <dnlplm@gmail.com> wrote:
> >
> > Just for reference, are you allowed to disclose which chipsets these
> > modems are based on?
> >
> > Thanks,
> > Daniele
>
> I'm not sure which chipsets are used for them. In the Windows
> environment, the information that I could find was Microsoft Surface
> Mobile Broadband Modem. Some people guess they are based on Qualcomm
> Snapdragon X16 and successors, but I could find no evidence about
> them.
>
> If you know the way, would you tell me how I can find or confirm it?
>

Unfortunately I'm not aware of any specific place for that: I wrongly
thought that you were involved in the development of the modem and you
knew the chipset.

However, sometimes the name of the chipset is left in the firmware
revision: you can try looking if there's any hint in the output of the
device caps request. If it's a Qualcomm modem it should probably also
support QMI-over-MBIM service, so maybe you can also try a few DMS
requests (--dms-get-software-version, --dms-get-revision...).

Sometimes also the USB descriptors can be useful.

Regards,
Daniele

> Best regards,
> Seunghun
