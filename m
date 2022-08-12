Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26341591317
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiHLPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiHLPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:33:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E4816A4;
        Fri, 12 Aug 2022 08:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ABC6B8246D;
        Fri, 12 Aug 2022 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295FDC433C1;
        Fri, 12 Aug 2022 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660318409;
        bh=YymeiL+WDfDKCoj1tmnKtG9kNBYdc1gBFHeYC0V+36Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K8V0UPAN+767lxx0acYoJqE+0nqYT8S/28FkXA+2dhyHIkj0cmlwGFdW8HOgKhZ/3
         rZn4L6q/ry3Ncn0qo8FCf2hP5BF6D+MltiC7F19CTg5CyaNh028dy2xo2oJDKWBm6t
         u9IseS5Ausd5jty8iasPLw3M+mioKnPZuwZNxVPC3kDAwCBRF+ekMlq+EhEBBDxvbV
         mjUofxNQbWe55E/Sqhy4zODtvgRORcTxT67pdRInsW6xv1Avj206NzxxbjgwQ2f2Zy
         WoLm4Toj83jjA8zGklaTvQldMELaB1a9x7wgukXXag6lTGCj6yUeTiauHia38asQjC
         qvBn07Y1iUrUQ==
Received: by mail-ua1-f47.google.com with SMTP id f15so434947uao.12;
        Fri, 12 Aug 2022 08:33:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo2HoIPn5yDqW8w5oN92ft9RW58d2zG4sy2fwLLVl8DkAdrnJTtY
        VmsDAvAjE7cajGE/fUpBHCXXIJQxH4qxPT0LGA==
X-Google-Smtp-Source: AA6agR66vMv23MxHlhU/il+hwIYBXtv92JhHAY7m+89EGlZ5dlwcJwMP0buqMazwUiLaB7y24s6RjJRmgxBq8ONC6fs=
X-Received: by 2002:ab0:2505:0:b0:384:cc62:9a75 with SMTP id
 j5-20020ab02505000000b00384cc629a75mr2089792uan.36.1660318408105; Fri, 12 Aug
 2022 08:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220811203151.179258-1-mail@conchuod.ie>
In-Reply-To: <20220811203151.179258-1-mail@conchuod.ie>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Aug 2022 09:33:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
Message-ID: <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
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

On Thu, Aug 11, 2022 at 2:32 PM Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Upgrading dt-schema to v2022.08 brings with it better handling of
> unevaluatedProperties, exposing a previously undetected missing
> property in the cadence sdhci dt-binding:
> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: mmc@20008000: Unevaluated properties are not allowed ('card-detect-delay' was unexpected)
>         From schema: Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Should this have a fixes tag? If anything, it'd be
> Fixes: 84723eec251d ("dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller")
> but idk.

No, the common property 'cd-debounce-delay-ms' should be used instead.

Rob
