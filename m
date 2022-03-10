Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DD4D5177
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiCJSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbiCJSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:18:12 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0313D906;
        Thu, 10 Mar 2022 10:17:10 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so7728071ooa.10;
        Thu, 10 Mar 2022 10:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6BWSW4vUXtb6Zn/KM/YH6Iar9Snb8Amni/kNF2TPhI=;
        b=bIhouM5HUH5gT0dFbqn33edSQ7g2/wDybf7r79pSoFrSMYEV10jfaN0BhX6wM2MhyY
         eRdykjRom8KmDyhvjwO1b7GvIrCUlEyMTbuQavqtyCkG1dMlvhtTc4gufBM7e+Zpm/ta
         X3S9iiu3R/JmpK4ErObj6MgAM0VyUtTkzAvjl4rizujblItlSfD5XzJ2DzfDiYpHp0Hu
         i4ag2VG9cg2pLVY+Xjp3E6YuJ3AmA4qp+2Bz1dcnpkkuYh9b8NEQxNsEhuQmUx1Co51J
         +Y7ypRzwQ8ijCPjPYZQPRq7mOPKGvhV0pS67mZRxil3aXwzNgxoWgVCEJf6lRaKs3xJB
         tGqQ==
X-Gm-Message-State: AOAM530Bd0UnfF2tussff7/z1SOU96ZLlH7FVutNaD2IggCo67h0lFDD
        +83o/OXwKV90d241ouXYDg==
X-Google-Smtp-Source: ABdhPJzpcfJhz3jsk4nC85EmodiMwC7aPQpcbxZqL/2c408GwZfrVYG01TUlRfTDa6pGFmXX0KY7KQ==
X-Received: by 2002:a05:6870:618a:b0:da:b3f:324b with SMTP id a10-20020a056870618a00b000da0b3f324bmr3568443oah.251.1646936229684;
        Thu, 10 Mar 2022 10:17:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a056870888d00b000d103280accsm2569260oam.16.2022.03.10.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:17:08 -0800 (PST)
Received: (nullmailer pid 1799395 invoked by uid 1000);
        Thu, 10 Mar 2022 18:17:07 -0000
Date:   Thu, 10 Mar 2022 12:17:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lin Huang <hl@rock-chips.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 01/15] dt-bindings: devfreq: rk3399_dmc: Convert to
 YAML
Message-ID: <YipAo5zWp/MF0NW6@robh.at.kernel.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
 <20220308110825.v4.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308110825.v4.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022 11:08:47 -0800, Brian Norris wrote:
> I want to add, deprecate, and bugfix some properties, as well as add the
> first users. This is easier with a proper schema.
> 
> The transformation is mostly straightforward, plus a few notable tweaks:
> 
>  * Renamed rockchip,dram_speed_bin to rockchip,ddr3_speed_bin. The
>    driver code and the example matched, but the description was
>    different. I went with the implementation. Note that this property is
>    also slated for deprecation/deletion in the subsequent patches.
> 
>  * Drop upthreshold and downdifferential properties from the example.
>    These were undocumented (so, wouldn't pass validation), but were
>    representing software properties (governor tweaks). I drop them from
>    the driver in subsequent patches.
> 
>  * Rename clock from pclk_ddr_mon to dmc_clk. The driver, DT example,
>    and all downstream users matched -- the binding definition was the
>    exception. Anyway, "dmc_clk" is a more appropriately generic name.
> 
>  * Choose a better filename and location (this is a memory controller).
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v4:
>  * Update .yaml to use more "default" entries, instead of free-form text
>  * s/phandle-array/phandle/
>  * Move to .../memory-controllers, update filename
> 
> Changes in v3:
>  * Add |maxItems| for devfreq-events
>  * Improve deprecation notes
> 
> Changes in v2:
>  * rename to 'memory-controller' in example
>  * place 'required' after properties
>  * drop superluous free-form references and repetitions of other
>    bindings
>  * fix for yamllint
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 212 ------------
>  .../rockchip,rk3399-dmc.yaml                  | 306 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
