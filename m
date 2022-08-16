Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867A9596154
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiHPRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHPRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:41:54 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578E721801;
        Tue, 16 Aug 2022 10:41:53 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id p184so5428808iod.6;
        Tue, 16 Aug 2022 10:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oUc8/JAVRGYQdzHPekaJ5tKmjToQt+wFD4OM5Ca99TM=;
        b=X3AvPy77vehfJ1Wgugx4kdpUtsbng2SETIx0TnnkyOLdulpg4318h86frj1kkWPUJG
         Qpt1O6ZDqqesLUh40lUDsaQuOpa+aifoOWp0A0bTPWQs1aSJ9v61UV7249bm46k0bvwd
         u0SDcT6scPg+faXqwSu0EsSX0sKHBeyv/m1YrVKb3jUPvB0AseVeEdUdMDMw/qENAMzf
         oyL1oaGHNVp9s7ykUnZw75+wA8V7scnSQUDiks/3h22eBVy5kzWk+b6wi1CJkameWRmm
         CTrlT0JxooksjHhl+RR3dYR1vtWjZArhVJP5wtrVcaBJRVaMzW0w2MIu0DUOCfGd6OTM
         +1hQ==
X-Gm-Message-State: ACgBeo2xJ7X7NZouWb3YOMZvsYJEymUokxkUMvYbc7+ZwRAgqJVU8/O2
        uhUII38YESGSV8uqGPGQkQ==
X-Google-Smtp-Source: AA6agR6cUHUKvVK+LEKfxY4oc/RAmHjZ0PXs5hefNGMfG5jUr6CgsfZBgF8tsvgYxH87jf8z73AF/Q==
X-Received: by 2002:a05:6638:1409:b0:33f:8472:8f0e with SMTP id k9-20020a056638140900b0033f84728f0emr10469031jad.194.1660671712464;
        Tue, 16 Aug 2022 10:41:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z3-20020a027a43000000b0034690882489sm2024720jad.171.2022.08.16.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:41:52 -0700 (PDT)
Received: (nullmailer pid 2435809 invoked by uid 1000);
        Tue, 16 Aug 2022 17:41:50 -0000
Date:   Tue, 16 Aug 2022 11:41:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Move renesas.yaml from arm to
 soc
Message-ID: <20220816174150.GA2428940-robh@kernel.org>
References: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:17:08PM +0100, Lad Prabhakar wrote:
> renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> to the soc/renesas folder instead. This is in preparation for adding a new
> SoC (RZ/Five) from Renesas which is based on RISC-V.

Please post this as part of the above.

bindings/soc/ is just a dumping ground for stuff that doesn't fit 
anywhere. We've mostly cleaned bindings/arm/ of that, so I don't really 
want to start that again. I would propose bindings/board/ instead if we 
move in this direction.

> 
> While at it drop the old entry for renesas.yaml from MAINTAINERS file and
> there is no need to update the new file path of renesas.yaml as we already
> have an entry for Documentation/devicetree/bindings/soc/renesas/ folder.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/{arm => soc/renesas}/renesas.yaml       | 2 +-
>  MAINTAINERS                                                     | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (99%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> similarity index 99%
> rename from Documentation/devicetree/bindings/arm/renesas.yaml
> rename to Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index ff80152f092f..7aae35c5f6aa 100644
> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/arm/renesas.yaml#
> +$id: http://devicetree.org/schemas/soc/renesas/renesas.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3058091899f..e42a7524e3f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2658,7 +2658,6 @@ S:	Supported
>  Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  C:	irc://irc.libera.chat/renesas-soc
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
> -F:	Documentation/devicetree/bindings/arm/renesas.yaml
>  F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
>  F:	Documentation/devicetree/bindings/soc/renesas/
>  F:	arch/arm64/boot/dts/renesas/
> -- 
> 2.17.1
> 
> 
