Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAC5391D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbiEaNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEaNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9608FD66;
        Tue, 31 May 2022 06:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 787B961202;
        Tue, 31 May 2022 13:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE73EC3411E;
        Tue, 31 May 2022 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654004021;
        bh=Z1whR2Seo++h8Uvy3NRM8CLdGeRMk3/5Fhy4XLisltk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cPVxm69Jbg+3fiO8JqUkXLXOD3pdyUhd1MlQm0oMnsnf55jefml2siTeRt11DQHj6
         j2XvEIwBhLIetl2w51tLK3B2a0OH2Z6D0nlXRYIg/OwhCh9PiTgvXzmtIqsaGVmCk/
         NKbc9Y8PlTLEjGx6hE7AsqZPZ63XO8dLqIFkWoRvf5c1NjMqCoIcoSwXF5SVIY5lUk
         8yy0Ek1jNVgbeKugcbrmeNa6X6xfwxRoEHv9D7y02QUzG4xMThGu6A77YkIcbXIDCO
         zWyzDcprTUSJlyHWEJ6vSN13Fe2Y5DFL0DOsh5h6/dcJ5SSJVn1Q0Awe0RVh1hSBfx
         aAMov2J80OI8w==
Received: by mail-ua1-f53.google.com with SMTP id y2so4793056uan.4;
        Tue, 31 May 2022 06:33:41 -0700 (PDT)
X-Gm-Message-State: AOAM5324/hXJsqjrtMtCRbOakjadASmODKos4GyTpqOlmof57aZFGCif
        vS608GbBZKgVhquTEXhTU7PfvLVes8cgunM4mg==
X-Google-Smtp-Source: ABdhPJzfl2q8a4/jnTVhQHUMa2kRAa20r2HuCUl7f2SfBzhtY8jiaU660L5f3oIf9EZfTKfxQZBl0thsed79l8nNzVE=
X-Received: by 2002:ab0:4ac1:0:b0:351:ed7d:e65c with SMTP id
 t1-20020ab04ac1000000b00351ed7de65cmr22397280uae.36.1654004020745; Tue, 31
 May 2022 06:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220523172515.5941-1-dipenp@nvidia.com>
In-Reply-To: <20220523172515.5941-1-dipenp@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 May 2022 08:33:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
Message-ID: <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:25 PM Dipen Patel <dipenp@nvidia.com> wrote:
>
> During the repository renaming from hte to timestamp, $id path was not
> updated accordingly. This patch corrects $id path.
>
> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Ping. Still failing in linux-next.

>
> diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> index 4c25ba248a72..fd6a7b51f571 100644
> --- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
> +$id: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Hardware timestamp providers
> diff --git a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> index 68d764ac040a..6456515c3d26 100644
> --- a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
> +$id: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: HTE Consumer Device Tree Bindings
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index 69e8402d95e5..c31e207d1652 100644
> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
> +$id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Tegra194 on chip generic hardware timestamping engine (HTE)
>
> base-commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
> --
> 2.17.1
>
