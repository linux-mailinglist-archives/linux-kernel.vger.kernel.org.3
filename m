Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4864652A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349958AbhLAQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:23:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45418 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349782AbhLAQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:23:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90F00B82029;
        Wed,  1 Dec 2021 16:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C7CC53FD3;
        Wed,  1 Dec 2021 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638375601;
        bh=chsce8M78mn7kNe7wC0N7oHoRMbGOLek3debSSI71+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOHW0jivGD0sfUuHQrNLVKjiJehBs8ZawhYoqnMartRIDeDkWgV74ilz7OXDlVCkN
         +F0ifWgvBBNNuAq5MPgxaSbi8Vle1M4cJJq7s+e8f8qdRC+CummIDpIYL+EQ13rO+o
         3TqlCrkrtINshCtdxo1+qycfrp6K25s/uZ8ltNjv2/1H5x2ARqIof1dw7YJNEuCjmj
         bEdC9jgx0i2b2PqMRUzDoSGktdmu+xzt0Bt3Cc2qFJuqAdDFfMGBxUnpA0YhLG4jEN
         2zikKuE6iMcOTjWICvatacH9slk7rtuWYMJCVlhaiqYW9fs1itREqj6w/KjqoTap5i
         Xno431a5VIOrA==
Received: by mail-ed1-f48.google.com with SMTP id g14so104034017edb.8;
        Wed, 01 Dec 2021 08:20:01 -0800 (PST)
X-Gm-Message-State: AOAM530XBdkTiFZIdxAn2liuwr6EUuHRVV3CGC8WCVTAMg+hvqdD/VlT
        WkvfV6mm8C+TEAhU7drq5Si30BjD1kwr8TkFdA==
X-Google-Smtp-Source: ABdhPJwKFJXoFi/lkb4UGy5sVWQhcLaVrvx8NVkmo+iI+WLXt6vMQKMq3z2rVrv63RjM2MV7aMTzUWqe4fCNNlPByts=
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr9697479edc.197.1638375599265;
 Wed, 01 Dec 2021 08:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
 <4b5bebb0-ed74-8132-1e6b-cb7cbc21439c@canonical.com>
In-Reply-To: <4b5bebb0-ed74-8132-1e6b-cb7cbc21439c@canonical.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 10:19:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJb4nMBoGLcf-bKpi5kEE+zXQ=dfo5JSBhrqPFeLnCsHw@mail.gmail.com>
Message-ID: <CAL_JsqJb4nMBoGLcf-bKpi5kEE+zXQ=dfo5JSBhrqPFeLnCsHw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
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

On Tue, Nov 30, 2021 at 2:04 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/11/2021 18:43, Rob Herring wrote:
> > On Tue, 30 Nov 2021 13:13:21 +0200, Sam Protsenko wrote:
> >> Add constants for choosing USIv2 configuration mode in device tree.
> >> Those are further used in USI driver to figure out which value to write
> >> into SW_CONF register. Also document USIv2 IP-core bindings.
> >>
> >> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >> ---
> >> Changes in v2:
> >>   - Combined dt-bindings doc and dt-bindings header patches
> >>   - Added i2c node to example in bindings doc
> >>   - Added mentioning of shared internal circuits
> >>   - Added USI_V2_NONE value to bindings header
> >>
> >>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> >>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> >>  2 files changed, 152 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dts:35.39-42.15: Warning (unique_unit_address): /example-0/usi@138200c0/serial@13820000: duplicate unit-address (also used in node /example-0/usi@138200c0/i2c@13820000)
>
> Rob,
>
> The checker complains about two nodes with same unit-address, even
> though the node name is different. Does it mean that our idea of
> embedding two children in USI and having enabled only one (used one) is
> wrong?

IIRC, we allow for this exact scenario, and there was a change in dtc
for it. So I'm not sure why this triggered.

Rob
