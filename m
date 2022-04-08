Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B334FA02C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiDHXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiDHXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:42:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1322033D;
        Fri,  8 Apr 2022 16:40:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2e5e31c34bfso112264477b3.10;
        Fri, 08 Apr 2022 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDYsEC3z7SNIXo2ZbPYZJ0K7GPHxLPSJLvLN0Mo6YeA=;
        b=SrtG1cIIGngnrFigTQwOPcRWD9gWwODKny8+yA2dRJ8NMUeLG7Z/Brj7jWL7ZAMLWN
         vgrZjOkmH+xgG24cFoDeVlBwgmDRmkulFpZ56fPpCYVJfch64Pxi513sZcjG/ZZbBAie
         KDrQmiXckMAjZazqTJD9fk8IQXb5qTn7NXYktG071Fxg6HPk2JbBJkz347bS9eqtFxbZ
         Qilaj/4T/7PrV8kzlgj28FnEyXSNjq1+l44cMWS1lSg4f1gI5HQ5xD2wHSC5J9/m27dQ
         +fPdnR5/PhF4abWi/Rdf29ODoItNuM/gwaqWPuyS3nxJxqQEssVCVVph9bMQTxpbUtxv
         goiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDYsEC3z7SNIXo2ZbPYZJ0K7GPHxLPSJLvLN0Mo6YeA=;
        b=ZufWZpVzjMkXdvXtaIgX2wlTOTLfQT0pGj5FUIrCmDkpOYVogrMr+NSx2++8osXgYZ
         Z6/Pc27VhFrKdVP8eqktkF7D/xQ/13onhC8ZMz5TwL+0BZDGqux6o7qqgvHT2TyfFQDu
         M+9ZpSlusLuwlIist8HwT488gsQP8fiS+8nnxaK+yV56HHVxUC35TyU27YATO3zW9Krv
         vjFWno/3EYjxt14wYmKhdy2VpaNobOqrgZrbeXv8vXYenwqHrB5GleHl41iqmby7C+Nl
         Cmkxp0FT3Nvo1XmHfPBvrAzG/cj1Fl9kjVFHHfBB1iyOEEtb4LH2ASE0W/ywzCUmfQpB
         Qzyg==
X-Gm-Message-State: AOAM531xwfd4kEtZPcXFcA4y2Nf5v0yXG7HpjRLC4ViuNZwRWz5MmRFx
        xugdZoXqbeIn19NvMz1VgYZgWHIjiN9IO8tsyA0=
X-Google-Smtp-Source: ABdhPJyGGqoOO05Ee10K3J4si37XiW9q1IlMMjK/151pERb6e4/d3IA3oUeJUT5N2Tc1vVQq+6pYokhAbTnYnN4lvaU=
X-Received: by 2002:a81:578c:0:b0:2e6:2488:7ef8 with SMTP id
 l134-20020a81578c000000b002e624887ef8mr18095272ywb.519.1649461199435; Fri, 08
 Apr 2022 16:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220408151237.3165046-1-pgwipeout@gmail.com> <20220408151237.3165046-4-pgwipeout@gmail.com>
 <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
In-Reply-To: <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 8 Apr 2022 19:39:48 -0400
Message-ID: <CAMdYzYrK2KV1svrHS=zMjGYh=dUis-JKjgYHaeOB4LQWXM1+4A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Apr 8, 2022 at 12:14 PM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Hi

Good Evening,

>
> seems like usb (2+3) is broken in 5.18-rc1
>
> i see controllers, ports are powered, but no device detection.
>
> maybe anyone else have same behaviour with different board?

Yes, it seems you are correct, there has been a regression with xhci
between v5.17 and v5.18.
I'm bisecting now.

>
> regards Frank

Thanks for reporting it!
Very Respectfully,
Peter Geis
