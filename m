Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9953F54E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiFGEzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiFGEzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:55:44 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E7D4108;
        Mon,  6 Jun 2022 21:55:43 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id m82so22437701oif.13;
        Mon, 06 Jun 2022 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2211zWwQvbcPN7vdSNJ04+hIY6NzzlbGtJIuGZkSz00=;
        b=IOL0TRCfqdzC90Ys8X4dMh0qui/ckanQGO6ak7TANlght56IvkwFGcRCKDSvruzRCk
         2/GwrDL5ZiV7glEjgRu17tLjaW6/m465fq/zLgU55Zy9BoGciIjprTniWx0v4r94pbY9
         SG+VVSa+AgT/7LyoJaV+MN4+mWwupPzxIB26/ObWWoC0LMowsCwarXLgdWwb56AbxBGZ
         3pHTGi31zf/7HQwpERFCg7+G0sig8bmx0MXBzmgY/sg9fyQWGt1YbERDLUXb2L3Of7WK
         7Mh68W1Q7kj/GXnwTQFb7OuhRFt0Sqg76mcwCEgNIwK629e3JNVMJqJvr5w6GT5d5oEH
         yNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2211zWwQvbcPN7vdSNJ04+hIY6NzzlbGtJIuGZkSz00=;
        b=vm/iLrAECYIOIRxb/UupVzP7qfUDW7DSBe4f24QkaAsPJhtea2mV8f5BqiYDiW1jeb
         vJpsFSl78cik+MZhiYMREj4sGwkY48CLplJ9Yf9QCnLx2HOMCzfgt5LYBWOoUjK570Ho
         7av9iQAk34LuVRkEYsKAHKiQXvEnRyuuf/Fl3pXcV5q9w6hhXdc0HVYThYI3Z1nAD6/C
         eyMXf48NEIUHlVJJQ/E68Ska7oshRysxaFirSafpkgCONasmLCwzjbg18bcE061D9P7Z
         e14Utv5TMW0XezohYy4+WVb8fOphANstqH727HErzqku+S/A5FG8HfAV0gWlTF9uK0eH
         v+1w==
X-Gm-Message-State: AOAM533hmg9Mns7Jb24oANOkYQnEogvvpbjfIYr6FMnhE3CfgxrH3m11
        4nTj6bcozEtZe4sU6033FhQiop9QwKqUsPPd/9Lq8jaOncQ=
X-Google-Smtp-Source: ABdhPJyMINfZsSWQuDY+tdpS3uwFQEf7ov+suuod63s6UXkz60pqt1xhAqQKsZM6fAypZIKLFnPoowS3vhPWD0hg7fY=
X-Received: by 2002:a05:6808:171c:b0:2f9:c685:f4d9 with SMTP id
 bc28-20020a056808171c00b002f9c685f4d9mr16344983oib.21.1654577742369; Mon, 06
 Jun 2022 21:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220606212239.1360877-1-robh@kernel.org>
In-Reply-To: <20220606212239.1360877-1-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 7 Jun 2022 06:55:31 +0200
Message-ID: <CAMhs-H9kXsjipHbCXt--yKhNSohDHDiZrUgb04=T4dhTpda4=Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: ralink: Fix 'enum' lists with
 duplicate entries
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
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

On Mon, Jun 6, 2022 at 11:22 PM Rob Herring <robh@kernel.org> wrote:
>
> There's no reason to list the same value twice in an 'enum'. This was fixed
> treewide in commit c3b006819426 ("dt-bindings: Fix 'enum' lists with
> duplicate entries"), but this one got added in the merge window.
>
> A meta-schema change will catch future cases.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../pinctrl/ralink,mt7620-pinctrl.yaml        | 26 +++++++++++-------
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 27 +++++++++----------
>  2 files changed, 28 insertions(+), 25 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
