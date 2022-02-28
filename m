Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97A4C789F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiB1TS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiB1TS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:18:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08172AE0E;
        Mon, 28 Feb 2022 11:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDD061591;
        Mon, 28 Feb 2022 19:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1516C340F5;
        Mon, 28 Feb 2022 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075848;
        bh=JkDmyeEmmXea1GNMh+ea50O5xH/GdJK7J/MFl2xT9pI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T5+sbXQr+txub7PPNUE655CqmIIyXX2jYpT+4bQOCL/cZ0lbbvbQQaJ2qy4QRIGO8
         R/l6aXScWqj/P/KnrnPQB9/3REIRXX0YQjN5X8U4DFqGVNcZOgSBIY3Ny3cx1/vO8s
         W+W0m1gUd1nfG3Du6056W3QmKyU5S/4FnVMYVnAs2TUFtEv2VMzq2q8VS32fmAN2Kc
         S2QRDE9P4moomaoC61pU1N8cwAINGmWMBjPdzUTtMR0wm6ByNgfjTFLM2afUTFl6Kr
         b9EmhoMvT+3mZ8KwVWcCXFe4La6aL8Xs3mew063WG0Iv8qED62rvYBJRbq2w3oD6ao
         XS0FVfbGgMMmw==
Received: by mail-ej1-f41.google.com with SMTP id dr20so2163067ejc.6;
        Mon, 28 Feb 2022 11:17:28 -0800 (PST)
X-Gm-Message-State: AOAM530eQtlicSeOCKwEUladpDrzohAB1RBOx47+AvR+NdeI4jXfFDI9
        /zQTL7JtPWNVoE5Ayv6pEAjSl2a+Q4zfosWCIQ==
X-Google-Smtp-Source: ABdhPJzemuH2iSFIpM+lnwxjfrCpLm5SpZx3xhmzJ4VXFjGtpP47wRGXYUIVlALLhQ7zhzIrLyZ4SCgcqaxUDQf2muc=
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id
 w4-20020a170906d20400b006d6df17835emr1262347ejz.20.1646075847094; Mon, 28 Feb
 2022 11:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com> <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
In-Reply-To: <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Feb 2022 13:17:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
Message-ID: <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, Vinod <vkoul@kernel.org>
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Lee Jones <lee.jones@linaro.org>, wulf <wulf@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>
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

On Tue, Feb 8, 2022 at 3:15 AM Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote:
>
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changes in v8: None
> Changes in v7:
> - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
>
> Changes in v5:
> - modify description for ssc and ext-refclk
> - remove apb reset
>
> Changes in v4:
> - restyle
> - remove some minItems
> - add more properties
> - remove reset-names
> - move #phy-cells
> - add rockchip,rk3568-pipe-grf
> - add rockchip,rk3568-pipe-phy-grf
>
> Changes in v3: None
> Changes in v2:
> - Fix dtschema/dtc warnings/errors
>
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml

This now fails in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
syscon@fdc50000: compatible: 'oneOf' conditional failed, one must be
fixed:
 ['rockchip,rk3568-pipe-grf', 'syscon'] is too short
 'rockchip,rk3568-pipe-grf' is not one of ['rockchip,rk3288-sgrf',
'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
syscon@fdc70000: compatible: 'oneOf' conditional failed, one must be
fixed:
 ['rockchip,rk3568-pipe-phy-grf', 'syscon'] is too short
 'rockchip,rk3568-pipe-phy-grf' is not one of ['rockchip,rk3288-sgrf',
'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml


The problem appears to be that patch 1 was applied incorrectly and the
compatibles ended up in the wrong section (the one requiring
'simple-mfd'). Patch 1 probably conflicts as my bot will just skip the
patch if it conflicts which is why this had a different error report.

Rob
