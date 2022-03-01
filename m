Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C04C8D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiCAOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiCAOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:07:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9935985B3;
        Tue,  1 Mar 2022 06:07:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82C83B818D1;
        Tue,  1 Mar 2022 14:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371FBC340F7;
        Tue,  1 Mar 2022 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646143626;
        bh=EclZqpMJR1tYEAmca7b905ZIwmOC5TaIXkHf5lThpIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JWjRHH8IYu+kF4Po1soEE6Ewr8+HCEUmDtGX95Ck9OyUqQML+GyWqI479v8uK9W9z
         BGHCwdZoAux+WuSQLTuoq0R1NZ4vIvelieDU7f7JCKlLsTk5R+Dohqhgt7rmyh2Gow
         DH6P5EGDBG0JvLLE40p+8eS/6YNbNIuELP3X1iUyRhgXubGx2cnEyPbWaPn9H9rpmL
         U2xpHA1g2Ekfet26kIzpkDQyIoSPwv0h0YA59GPmZASjXp1ZxNRjJYJexFunabZUGf
         wUvIfrFjgNAybe4GQAwBVuWfSoca2W6gwoqLzs0fBc/CM3L7K2LyMsi8s4hZAh3qcI
         L9kk3ISLRrdDA==
Received: by mail-ed1-f44.google.com with SMTP id w3so22111366edu.8;
        Tue, 01 Mar 2022 06:07:06 -0800 (PST)
X-Gm-Message-State: AOAM531ed6G+1/vJsgJAIeVxx1YJvGp/tF/B61BcKsFEKkUfOIBePtxd
        bnt/5hXWzwYFRzm6ZpGpCuIQ/Ky1sB2iDTJ7Qw==
X-Google-Smtp-Source: ABdhPJwmaTZSRCBxdhtl1HfQ8MmkEGVxX0jRBq7/dxH/OHiYeN+U4x2bgyRCgL5udfuw1JmC1YQsVAmSw2fYxqTzjFI=
X-Received: by 2002:aa7:d415:0:b0:410:a0fa:dc40 with SMTP id
 z21-20020aa7d415000000b00410a0fadc40mr24270451edq.46.1646143624441; Tue, 01
 Mar 2022 06:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
 <20220208091326.12495-3-yifeng.zhao@rock-chips.com> <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
 <CAMdYzYryTb4Gvv3XENgUOSrutr7S-5a7GOMRahXWWZOeL1qKWA@mail.gmail.com>
In-Reply-To: <CAMdYzYryTb4Gvv3XENgUOSrutr7S-5a7GOMRahXWWZOeL1qKWA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 1 Mar 2022 08:06:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsLU5-bJVRWv_TzGUZdFHOx7tdzqV2piNfacNkXg=zww@mail.gmail.com>
Message-ID: <CAL_JsqLsLU5-bJVRWv_TzGUZdFHOx7tdzqV2piNfacNkXg=zww@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
To:     Peter Geis <pgwipeout@gmail.com>, Vinod <vkoul@kernel.org>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
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

On Mon, Feb 28, 2022 at 3:37 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 2:18 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Feb 8, 2022 at 3:15 AM Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote:
> > >
> > > Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > > ---
> > >
> > > Changes in v8: None
> > > Changes in v7:
> > > - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
> > >
> > > Changes in v5:
> > > - modify description for ssc and ext-refclk
> > > - remove apb reset
> > >
> > > Changes in v4:
> > > - restyle
> > > - remove some minItems
> > > - add more properties
> > > - remove reset-names
> > > - move #phy-cells
> > > - add rockchip,rk3568-pipe-grf
> > > - add rockchip,rk3568-pipe-phy-grf
> > >
> > > Changes in v3: None
> > > Changes in v2:
> > > - Fix dtschema/dtc warnings/errors
> > >
> > >  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
> > >  1 file changed, 109 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> >
> > This now fails in linux-next:
> >
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> > syscon@fdc50000: compatible: 'oneOf' conditional failed, one must be
> > fixed:
> >  ['rockchip,rk3568-pipe-grf', 'syscon'] is too short
> >  'rockchip,rk3568-pipe-grf' is not one of ['rockchip,rk3288-sgrf',
> > 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> > From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> > syscon@fdc70000: compatible: 'oneOf' conditional failed, one must be
> > fixed:
> >  ['rockchip,rk3568-pipe-phy-grf', 'syscon'] is too short
> >  'rockchip,rk3568-pipe-phy-grf' is not one of ['rockchip,rk3288-sgrf',
> > 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> > From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> >
> >
> > The problem appears to be that patch 1 was applied incorrectly and the
> > compatibles ended up in the wrong section (the one requiring
> > 'simple-mfd'). Patch 1 probably conflicts as my bot will just skip the
> > patch if it conflicts which is why this had a different error report.
>
> Good Afternoon Rob,
>
> This is fixed in the first patch of my rk356x dwc3 enablement series:
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220228135700.1089526-2-pgwipeout@gmail.com/

Where does that say Vinod incorrectly applied the original patch and
needs to apply it? What's the status of the series? Do we have to wait
for the rest of the series to be applied?

Rob
