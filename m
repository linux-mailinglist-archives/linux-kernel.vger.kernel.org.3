Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14A490A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiAQOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:14:32 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:53707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiAQOOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:14:30 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MW9zm-1mq5UX48xm-00XY0E; Mon, 17 Jan 2022 15:14:28 +0100
Received: by mail-ot1-f47.google.com with SMTP id z25-20020a0568301db900b005946f536d85so10915434oti.9;
        Mon, 17 Jan 2022 06:14:27 -0800 (PST)
X-Gm-Message-State: AOAM533cx2DY4ezMGcz9Dp4SmrypnQ/rNQYkiAtJtCttThp0g2nXlTXB
        wxJQx/LDtHODwg4xpn5PjmyB0qmy9Pn9bcWTrRw=
X-Google-Smtp-Source: ABdhPJw1ZgWjaWLjO9h+cg20DOEimvvTBW13bNSm+HZXqb0f0qzN/HOYU/ee29hk5wVbuIP+kAiil5AV4Egwenxh/3Q=
X-Received: by 2002:a05:6830:2095:: with SMTP id y21mr14368395otq.368.1642428866253;
 Mon, 17 Jan 2022 06:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb@epcas5p4.samsung.com>
 <20220113121143.22280-14-alim.akhtar@samsung.com> <53c17ddc-a049-72ed-7237-de23db7889da@canonical.com>
 <085801d80967$e4b8fe00$ae2afa00$@samsung.com> <5ab62673-8d46-ec1d-1c80-696421ab69ca@canonical.com>
 <00c901d80ba5$c9ae6ab0$5d0b4010$@samsung.com>
In-Reply-To: <00c901d80ba5$c9ae6ab0$5d0b4010$@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jan 2022 15:14:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a31bCHNcNWrLX+QW+4RuK=DBpxLA_j5BFKxXxXKCT8PFQ@mail.gmail.com>
Message-ID: <CAK8P3a31bCHNcNWrLX+QW+4RuK=DBpxLA_j5BFKxXxXKCT8PFQ@mail.gmail.com>
Subject: Re: [PATCH 13/23] dt-bindings: arm: add Tesla FSD ARM SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, linux-fsd@tesla.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:24N6xeoiYsAwDCwG/g1ccQwp/aLIZxRscTCgYfZBm6XDjm27c0j
 /tcPNW7VkzXi9kI4Zu7ZwMRVCHnM+CugzQpTyCePsAugiKnFwqRHEjroc1vFWIO9SiuFawj
 mJJwKNnvKOSuIn1PhT2fy7oRpqSvvbwJk3aNB/Z0ywPQqNwxz/QmBHWB69L6Ygzbag02u1y
 1ANfl+bqeOiGmE2Lv0B+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:imzZbDZYUKI=:YJPP852sg4V1fiKELbhu/u
 429EhvznxoAnL6+f085u7xEKEKwHy6GTt4+ld1K/eaTF+St9C4Xoxq/aDhfmQcjNZ9gpjDq8e
 YnB0nlY6KKj5yWnIaHq29c6tK7aaRkUt690csAlO4wgtKsFRmTM3n5BuzddWMFDU2E7qDOKT3
 8pPxz+UQkrh7ALvW1MAPZhUZSI3NsMyyc1qbwYQlUpK0EHoCfKqtPnosunX5JRQOVSrb7gDpb
 JOR85vmTCN9dEEC7MKtiXWsIO4RE6gdNkRpgXrmmfySvxNLz2Wq/fuDmxuFeL69JAGNY/08oL
 XNKsypMGqZMbf+qgYWuTe6gsNWF2E1MJbqwkubJBrMfRHtdrmzM/8/EsbJbDJlQxC7thQq2Wx
 qn3asg42y0bInflbRqaLFNPZH+DYBq2sTFIhFWExa7UrlNb8qIiShe+kssZjlsfnqj7zEtGcu
 sgDEmZpG9utUCOUYfpxnAV1AtpZvgPG2JflP2FCVZ7obqJcltUwftqDhIlc522jKFnYMtitDS
 qCoh8RIqu+1eq0IcGnrokcu5miUWielz69aDXtLCWLLeolI0Ybg6axWSnoQEsGsmbkyQgZk20
 4k59xJZXNdxYEx9pRyIgHyEkXbXmPIjUEb2S3y4g/n8Vso+jCbDugCenRG0CMfKligzdo5csM
 8NV/oLAL+w6sTT2ZrExlGZ4USQtL+NbxN1OtSuZRli4OmD6ie9vPxS2jTPnBKI80zv0VbhCG8
 sCgyCP8M39xFDLnOfk4RmKCk9iaEWbpDB+YzrOJDS9DKoG1SS0autHLoSM2kvIO1ciECU0UeA
 Z+R9fY/X6w8GWcwPKZJkAZPb3d7776PtL7sf3PcNdJOLf+ebxM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 2:26 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
> >I cannot judge how different this is from Exynos subarchitecture - looking at
> >patches it is not different - so I could understand a FSD sub-arch with only one
> >SoC.
> >
> I understand, it is a bit difficult to visualize it with the current patch set.
> As discuss on the other thread, FSD is different, more over the vendor is different, internal design is different.

Is it based on another SoC design then? Most new SoCs are derived from
some other
one, so it makes sense to put it into the same family. E.g. the Apple
M1 takes bits from
both Exynos and PA-Semi SoCs but has more newly added components than
either one.

I would argue that if this SoC shares the pinctrl, clock, spi, adc,
and timer implementation
with Exynos, we should consider it part of the Exynos family,
regardless of what other
blocks may exist next to those.

       Arnd
