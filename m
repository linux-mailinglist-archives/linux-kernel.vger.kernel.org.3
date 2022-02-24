Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB44C2D42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiBXNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBXNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:37:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2A1704DE;
        Thu, 24 Feb 2022 05:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC2B61AC1;
        Thu, 24 Feb 2022 13:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CF1C340F3;
        Thu, 24 Feb 2022 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709789;
        bh=2AyDGGxNktap1GCSav7/Y8s2uvS64c1pBQZnymqFe4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yx8yWvUQOht5FU2AlaqGvIfI122/dDiBnDkK+tqYL3Ic+coI1fnkKszdfJpI+QGjA
         T4B3Wmo4FowqKhjLPetwZzGsXo4Yls5WtH7ngewbrTZxSr2I8sahtgky6UH0X+BUWG
         /+u+2KDhGZKAB7aXNhBjBB70u1MY2UdzE6mAfi5uTMtabjYS9+AKI1te384+UG1+Uw
         CcGQmtT9dOyQTSkMdXbfx2CEXW0VGDCwjkCaQr5lvZ02YMG/Ew9/8LfWsvHewRYF8m
         hTDqJOG1qo1Z3tub6i9p9qzFQkT4MygK+PXEzGgeVdasBkCPQ2rs/jEy0e21wdXCkp
         NF4Yxssd24Mrg==
Received: by mail-ej1-f50.google.com with SMTP id gb39so4430947ejc.1;
        Thu, 24 Feb 2022 05:36:29 -0800 (PST)
X-Gm-Message-State: AOAM533bVw1SvDixlcN2w1X7ddVQnAvzzGWwAQuq4ewChotFwh+Vra+U
        w6tqh/ilT5Q0pfBBABTbaFLH4edI4ncegLZw9Q==
X-Google-Smtp-Source: ABdhPJy7XTemJd1RIWN/eP2rQzg/ge+Oq4JXuQXOPiNrDJ5gTr0cji2l71T4OyRxESJMLHTt6j3u3RnnCiQeFL4+i2I=
X-Received: by 2002:a17:906:181a:b0:6d0:ebf5:c064 with SMTP id
 v26-20020a170906181a00b006d0ebf5c064mr2223818eje.82.1645709787743; Thu, 24
 Feb 2022 05:36:27 -0800 (PST)
MIME-Version: 1.0
References: <6a86f8c481be417972ef1b1e3b902ccf95706547.1645149279.git.lhjeff911@gmail.com>
In-Reply-To: <6a86f8c481be417972ef1b1e3b902ccf95706547.1645149279.git.lhjeff911@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Feb 2022 07:36:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tMG_8nYaZDaU2pPgy7+bXfPxATSeoJKKyR=kv=x=70g@mail.gmail.com>
Message-ID: <CAL_Jsq+tMG_8nYaZDaU2pPgy7+bXfPxATSeoJKKyR=kv=x=70g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: delete unused required and adjust the item.
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 7:56 PM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> delete unused required(clock-name)
> adjust position (interrupts)

Why? This seems like an unnecessary change.

Please write complete sentences that answer why this change is needed,
not what the change is. The diff describes what changed. In this case,
quoting the warning you are fixing is typical.

>
> Fixes: 3b8ab4da34 ("spi: Fix test error for sp7021")
>

There should not be a blank line here.

> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> index 298eac2..9df08d7 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -47,10 +47,9 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - interrupts
>    - interrupt-names
> +  - interrupts
>    - clocks
> -  - clocks-names
>    - resets
>    - pinctrl-names
>    - pinctrl-0
> --
> 2.7.4
>
