Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E446855B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhLDObh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhLDObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:31:37 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C9C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 06:28:11 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id m19so3765482vko.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATc16WWtCcR8jUe6fibytkicXJ7JqnP1WJvtGJ1JYG8=;
        b=b9LNeX0fhXS4Lma2JLx5C7MG2H0cZBeJH8tYd2AZ7hd350a4rDRpnqh6zjP+q2uVDC
         /2B5RQF3Xs7NKpjz13v0lp6yOeth8spyv5zDypDos5JUqxMxDobHPWokZhXs5sdQcTem
         bgtW7zjPfXUfteywFCk4Tu1qZBmHk7zHKkSnkHa1ynYyBbkkdHqV1F+n1uXLBvRpkFmN
         bakzMecHWj33/R9txe02OjbLEr0XWfago4gRHHQscExsJHr+N6nkvLZtdEoizqokBENm
         tEpGK+rDd74Y4TCS0y+1ZaL1Kc+gfWKTeAxW1xzaH4fTPjtnwlGoTuQt/JJHYcKLEjwg
         BEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATc16WWtCcR8jUe6fibytkicXJ7JqnP1WJvtGJ1JYG8=;
        b=ZROHfz4P7okz202UgH7LXsZKz5tfa6IntwOOPZg/utHMAWvRwiRNi3mKtKe01XaVRw
         HwFtBeNM53z+0z3lr6ofzmofX3y97oB+cWzfjSDObhvaqbaibpit8Kl1rUN1Wf2rxYOK
         Mc0kjL8Ex1Dv19WazJK3QVrheH8+5H0TQYGb9KaZtYaO4w0HjX+Ecy/pyCG8S9ksmByI
         bEv9ObZJvCVp3am3jqVIruG9pOVwDbJsvRTm9BHeMcwTHM8TKl7lwtwh/CIlkmzLNTUt
         RUz1whJIxInLoglLwIk30CDY15bQRX0FLsFXY6mH39EqdDgVhnTXKRT8+9GYQHcR3CAt
         c7MA==
X-Gm-Message-State: AOAM531Hqn8gyNBAv+NKGQ/JUix1jMnF1vP2R7HWNMdBnX9g8eEPO4yu
        kU3k1+YGoBSSxtEkTIGhl0/YQmbyKhanDLU3JbqKgQ==
X-Google-Smtp-Source: ABdhPJw2w7MhlaMAGEDp/OboJf6AaW8ZvKhMK6p1HiGFUrq0bh+XYZSyYu7+pvPNDEzlw2dDnBMrYtRfs4EjCCNo5tA=
X-Received: by 2002:a1f:a08c:: with SMTP id j134mr29652382vke.35.1638628090612;
 Sat, 04 Dec 2021 06:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
 <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com>
 <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com> <8460edd6-efaf-3ae7-594c-0d1495d57abf@canonical.com>
In-Reply-To: <8460edd6-efaf-3ae7-594c-0d1495d57abf@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 4 Dec 2021 16:27:59 +0200
Message-ID: <CAPLW+4=x4Qm2AO6_h9NdypQV5t-j3QW-kqVSsSGkmmsu0n5fzA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 13:28, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 03/12/2021 21:40, Rob Herring wrote:
> > On Fri, Dec 3, 2021 at 1:36 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >>
> >> On Tue, 30 Nov 2021 at 21:31, Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
> >>>> Add constants for choosing USIv2 configuration mode in device tree.
> >>>> Those are further used in USI driver to figure out which value to write
> >>>> into SW_CONF register. Also document USIv2 IP-core bindings.
> >>>>
> >>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >>>> ---
> >>>> Changes in v2:
> >>>>   - Combined dt-bindings doc and dt-bindings header patches
> >>>>   - Added i2c node to example in bindings doc
> >>>>   - Added mentioning of shared internal circuits
> >>>>   - Added USI_V2_NONE value to bindings header
> >>>>
> >>>>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> >>>>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> >>>>  2 files changed, 152 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >>>>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..a822bc62b3cd
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >>>> @@ -0,0 +1,135 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Samsung's Exynos USI (Universal Serial Interface) binding
> >>>> +
> >>>> +maintainers:
> >>>> +  - Sam Protsenko <semen.protsenko@linaro.org>
> >>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>>> +
> >>>> +description: |
> >>>> +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
> >>>> +  USI shares almost all internal circuits within each protocol, so only one
> >>>> +  protocol can be chosen at a time. USI is modeled as a node with zero or more
> >>>> +  child nodes, each representing a serial sub-node device. The mode setting
> >>>> +  selects which particular function will be used.
> >>>> +
> >>>> +  Refer to next bindings documentation for information on protocol subnodes that
> >>>> +  can exist under USI node:
> >>>> +
> >>>> +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> >>>> +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> >>>> +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> >>>> +
> >>>> +properties:
> >>>> +  $nodename:
> >>>> +    pattern: "^usi@[0-9a-f]+$"
> >>>> +
> >>>> +  compatible:
> >>>> +    const: samsung,exynos-usi-v2
> >>>
> >>> Use SoC based compatibles.
> >>>
> >>
> >> In this particular case, I'd really prefer to have it like this. Most
> >> likely we'll only have USIv1 and USIv1 in the end, and I think that
> >> would be more clear to have USI version in compatible, rather than SoC
> >> name. Please let me know if you have a strong opinion on this one --
> >> if so I'll re-send.
> >
> > Fine if you have some evidence the ratio of versions to SoC are much
> > more than 1:1 and the versions correspond to something (IOW, you
> > aren't making them up).
> >
> > We went down the version # path with QCom and in the end about every
> > SoC had a different version.
>
> I am against v1/v2 versions. The documentation in Samsung was always
> poor in that matter. There were mistakes or confusions so it wasn't
> always obvious which IP-block version comes with which SoC. Not
> mentioning that several contributors do not have access to Samsung
> datasheets and they submit code based on GPL compliance packages, so
> they won't know which version they have for given SoC.
>
> OTOH there is no single benefit of using USI v1/v2, except "liking".
>

Ok, I'll do as you ask. In general I agree, but I still think in this
particular case using "usi" in compatible is feasible. Anyway, I have
no strong opinion on this one, and it's easy to rework.

> Best regards,
> Krzysztof
