Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B98466B09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348972AbhLBUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:48:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51170 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbhLBUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:48:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE617B82478;
        Thu,  2 Dec 2021 20:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BB8C53FD1;
        Thu,  2 Dec 2021 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638477877;
        bh=D+XIVtJBMJs6vJlJVkfubqTw2gl+Mh7CJ9ZRrFKA0R4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hiHyCQ1237rTv8Tp6276FGKCYm3JCk6Ml5zsrxqfAXeGJnuDaKMDQnVTeCNEZ7870
         Gnkgx7FG3lxMdmu+ndqjYmhw5GJRY/M8Kr3T3qMnfHXQUR+m8iiXdpsIF1YI2sQjve
         pjTNZziNRSNXti7JgKMutTGlyeSc+6yUHZl9FL/5LiZltOny0oZxUflB1oAYjGQesb
         D4uH6VXNWpDsWNLnfddncksvWOXxSh7i8KLfeh+GmVm3hjK8KFs5BuhaTjhFeEbFYs
         rCIn5SDcCqJ+tYLV0ZPDXMGe0RsiQQ9UNry92rgEmnFPMuWCP36JHaujE2C6ICdHuk
         Z7h4AY8tDFmJA==
Received: by mail-ed1-f53.google.com with SMTP id z5so3045942edd.3;
        Thu, 02 Dec 2021 12:44:37 -0800 (PST)
X-Gm-Message-State: AOAM533hw/+V4v5uQJuCV3SfYj/oj73STwuhiwRQRedFD6g/uHknPjDX
        Nb5edHdNLU5vcZE0AMwlDi+9mAEmaXllYcaWLA==
X-Google-Smtp-Source: ABdhPJyzThOhhiZuR6ye1HIiOYkJBH+7pZpAES4RrvIAKS54c2WOOBHFZcf0F8jp2b9OzH5zBx/GUv/DYwgH126mvgg=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr17641007ejb.128.1638477875718;
 Thu, 02 Dec 2021 12:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
 <4b5bebb0-ed74-8132-1e6b-cb7cbc21439c@canonical.com> <CAL_JsqJb4nMBoGLcf-bKpi5kEE+zXQ=dfo5JSBhrqPFeLnCsHw@mail.gmail.com>
 <CAPLW+4=Zdvf4HRNUeVMR9URLSdA867hdXVLYy+k47yLH82uTnA@mail.gmail.com>
In-Reply-To: <CAPLW+4=Zdvf4HRNUeVMR9URLSdA867hdXVLYy+k47yLH82uTnA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Dec 2021 14:44:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FTB+mWOyCBwLFifk8obpMh1ysJ6pqpUzSoW7jzo5FAg@mail.gmail.com>
Message-ID: <CAL_Jsq+FTB+mWOyCBwLFifk8obpMh1ysJ6pqpUzSoW7jzo5FAg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-serial@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 5:01 AM Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Wed, 1 Dec 2021 at 18:20, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Nov 30, 2021 at 2:04 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> > >
> > > On 30/11/2021 18:43, Rob Herring wrote:
> > > > On Tue, 30 Nov 2021 13:13:21 +0200, Sam Protsenko wrote:
> > > >> Add constants for choosing USIv2 configuration mode in device tree.
> > > >> Those are further used in USI driver to figure out which value to write
> > > >> into SW_CONF register. Also document USIv2 IP-core bindings.
> > > >>
> > > >> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > >> ---
> > > >> Changes in v2:
> > > >>   - Combined dt-bindings doc and dt-bindings header patches
> > > >>   - Added i2c node to example in bindings doc
> > > >>   - Added mentioning of shared internal circuits
> > > >>   - Added USI_V2_NONE value to bindings header
> > > >>
> > > >>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> > > >>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> > > >>  2 files changed, 152 insertions(+)
> > > >>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > >>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> > > >>
> > > >
> > > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > >
> > > > yamllint warnings/errors:
> > > >
> > > > dtschema/dtc warnings/errors:
> > > > Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dts:35.39-42.15: Warning (unique_unit_address): /example-0/usi@138200c0/serial@13820000: duplicate unit-address (also used in node /example-0/usi@138200c0/i2c@13820000)
> > >
> > > Rob,
> > >
> > > The checker complains about two nodes with same unit-address, even
> > > though the node name is different. Does it mean that our idea of
> > > embedding two children in USI and having enabled only one (used one) is
> > > wrong?
> >
> > IIRC, we allow for this exact scenario, and there was a change in dtc
> > for it. So I'm not sure why this triggered.
> >
>
> It's triggered from WARNING(unique_unit_address, ...), because it
> calls static void check_unique_unit_address_common() function with
> disable_check=false. I guess we should interpret that this way: the
> warning makes sense in regular case, when having the same unit address
> for two nodes is wrong. So the warning is reasonable, it's just not
> relevant in this particular case. What can be done:
>
>   1. We can introduce some specific property to mark nodes with
> duplicated address as intentional. check_unique_unit_address_common()
> can be extended then to omit checking the nodes if that property is
> present.
>   2. We can just ignore that warning in this particular case (and
> similar cases).
>   3. We can add some disambiguation note to that warning message, like
> "if it's intentional -- please ignore this message"
>
> I'm all for option (3), as it's the easiest one, and still reasonable.
> Rob, what do you think? Can we just ignore that warning in further
> versions of this patch series?

Just change the dtc flags to '-Wno-unique_unit_address
-Wunique_unit_address_if_enabled' for both examples and dtbs.

Rob
