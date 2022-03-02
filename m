Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9894CAB1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiCBRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiCBRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:05:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D411A32;
        Wed,  2 Mar 2022 09:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E109261923;
        Wed,  2 Mar 2022 17:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A256C340F8;
        Wed,  2 Mar 2022 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240661;
        bh=Icqzp9SWIKc87+ugA8V1Jg/Egl5KGIZgDSmOGMm1YjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XlN89rRBvF+GlGzocnWiX3bxrAI2gW6UwYY9sVM2abvIaNKse/VLFty1vRTc36Lnb
         SSdHHvC8+2f2xs+Ai+f5bVGIc8xGogCj6Xyb3IQod3sJNXMpuMbh4JtLyo9FuyGkdw
         QeBMia/6AvkZY4fLDs3RGxSd9SeT98vWiiplnvECmf9Llo3Gs8qymYHZUxLFsgwJYU
         tv+h0w8B4RKHuO09aJMWRTYACMp+HDRufCp5FtTLwnLm4Bcwn/PmxRjlHgSf+8G+tN
         O847KYrkTuVKbaDKHuhpSwE9AdztBEOaKZZFVcGY81gCrxvtANDYA62iBj0dPtefFM
         p1yp2/FLiHc5g==
Received: by mail-qt1-f172.google.com with SMTP id w1so2223762qtj.2;
        Wed, 02 Mar 2022 09:04:21 -0800 (PST)
X-Gm-Message-State: AOAM531YYhk0294cAtarzAowPBKj/rN84kxan5QIUj8rYjcmjc2WKhhr
        8u9j4COXkZMscPZt1XHPVWoVml7Rku4vi6FzpQ==
X-Google-Smtp-Source: ABdhPJzVh9qPRrBt75o8AJLwWVKH7Kq5B4Apg3LHn1XCzh/s46oA4VubuT2CvtvTNnOdmGBFZvtsF8c7sASSb8loYU0=
X-Received: by 2002:ac8:4e56:0:b0:2de:7120:61c9 with SMTP id
 e22-20020ac84e56000000b002de712061c9mr24266586qtw.684.1646240660169; Wed, 02
 Mar 2022 09:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20220302143427.447748-1-vkoul@kernel.org>
In-Reply-To: <20220302143427.447748-1-vkoul@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Mar 2022 11:04:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
Message-ID: <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Geis <pgwipeout@gmail.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> combo phy register compatible") as that was wrongly merged, so better to
> drop the wrong patch
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> I am applying this to phy-next to fix the issue

Reverting will just cause a different warning that it is undocumented.
The fix in the other thread won't apply either if you revert.

Rob
