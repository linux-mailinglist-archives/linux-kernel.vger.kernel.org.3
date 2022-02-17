Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D24BABE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiBQVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:39:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiBQVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:39:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE1C2E75;
        Thu, 17 Feb 2022 13:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55E26B8248E;
        Thu, 17 Feb 2022 21:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADF6C36AE2;
        Thu, 17 Feb 2022 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645133945;
        bh=cSPYXK1JW5UK6sE5McEoYlfjZ/NZ0FAAfdbIUE9k830=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pAQWn4Peh7EqlXhkYcEfu2RCqsRvgYztaVYRebyg8WU/zZb8UbfTofV6yzUTSHQ6U
         EXZUco6QHD9omCg+m/OeMBQ447BEAzYpx7PTyoYz5BUpVqvEdv4SgZPDzBMSsxEcC/
         hHuGBmqKS6mlToqzpJhXxobL5fveSEL6CaXdetkWoS8+u3v0eD4S+ayGqSKnePtWQ0
         H+1vJUYl7zHSWbLZh8JcuSSUbfWVYRZwFZOv0h9Yia3FrvyfLpHGDxQY1pT/zI0t5F
         S4J+GiEU6wS279URzi/KiumL4If4qIIYV6dLFQHZMOEXyhWe3FlOFVkxgD+mHiE2Ol
         f2VVuIX6hFw9g==
Received: by mail-ej1-f45.google.com with SMTP id a23so10360402eju.3;
        Thu, 17 Feb 2022 13:39:04 -0800 (PST)
X-Gm-Message-State: AOAM532X8XJXOzO4Pz9CIeHNlw8iiff2ZapDxGuzGyLWDU2d4u1xe0F4
        PbttIQgnJXSCFcfYVJoyJ5Bot7ntCQejxQZTzg==
X-Google-Smtp-Source: ABdhPJxlrvsn0M9oD3a/hsk9VOmrl1n2EhdiqnAbIxgbtJltj4GV/17YOEggdpjFx6SRI36nR53yiVeqeV8PQLPYwjU=
X-Received: by 2002:a17:906:960c:b0:6cf:cd37:658c with SMTP id
 s12-20020a170906960c00b006cfcd37658cmr4049578ejx.325.1645133943296; Thu, 17
 Feb 2022 13:39:03 -0800 (PST)
MIME-Version: 1.0
References: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
In-Reply-To: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Feb 2022 15:38:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJO=4A5f_26KNcoMWJj3YWxd=qnwE7V90MUCW9muYtH1g@mail.gmail.com>
Message-ID: <CAL_JsqJO=4A5f_26KNcoMWJj3YWxd=qnwE7V90MUCW9muYtH1g@mail.gmail.com>
Subject: Re: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 7:46 PM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> Remove the include path and modify parameters for fix error for bt binding test
>
> Fixes: a708078eeb99  ("spi: Add Sunplus SP7021 schema")
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Unfortunately, this fix exposes another issue:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dt.yaml:
spi@9C002D80: 'clocks-names' is a required property
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

Please test your stuff!

Rob
