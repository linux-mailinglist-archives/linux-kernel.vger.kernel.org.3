Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790B25A9EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIASKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiIASKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:10:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FAD17A97
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:10:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so3493031pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=lY3VTHB6YVTIIgZzaayFIL1rgC3z2UNKaC3PZ0i8jJk=;
        b=yIxbnQHwAZ9CufCZUcHz0JsAdm30gGUIv9S5VtbaZM0dN5UnFM5bTbPYpKRguqnC4J
         vXZ4OvvU8hWUtO7RKJWPJxi2HMg9p/LA5cCEfQ8DVZobcCQt0xqnrEv+y8wOWyAbNKV4
         qTpRWmunQxaIywfV8p7HWGn0Rje9FG+4jiNrZ/fruK0jmB+21YsPKykeRIP1JlQ1PiGL
         JHemifGJiUFnJwIA/UofINXbR0JW44yGKCI8eD8X/JuMs6A5vao/Fh3qyJHUYuGD0TIf
         Ux3FeI0c/C2QDu85hUAJdH9pKhN/MLWEdvT6pZD4yUNQQM5s/dR8uTB4Pe9c06a+1C3x
         q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lY3VTHB6YVTIIgZzaayFIL1rgC3z2UNKaC3PZ0i8jJk=;
        b=Kw0C7SINJNyZfPdHFS3gqIu6wGt9njgNWohQbpknq47CSj3vE+Ye/KazfyzM33OibM
         u3N8SoR0Tabu9AooN/8NNhVjoPgpM1XwAivMsmvDrqwkNrh2iPnLf4K0OkJ10IWl0K1T
         h/WVT42q+JmKWWmyRnPpZwVVUUHPCIxZrdjGsINIQEiwLdVmlizx6xSOp4rINV5TOSpk
         7XZdJkTxEkrfwDylIx5gaCcmKU4Kye7uo/Aa5qORy1eHtkUpVUc2m0CVBJtz23HGokSr
         4DHb6DbxMSjfK1gwDGMmpd35RL+lcWgTVVC7nNFKsRvqI8c8/MwNuWDmV7mnlhws8z2o
         fTiA==
X-Gm-Message-State: ACgBeo1GaeezeI1aiQuZ4HStu9//QfqaUTG8xnlpc0VlsvthQ9vFjkkj
        Cjm5bbjfgn9tkqcGz8Z7u3IPgzJJKhd0Ug==
X-Google-Smtp-Source: AA6agR5ODczNCIuopf0Fb0Uq7kPEMaZUQNrpir2XxOhi73xuol9EshAzF2ee5rzoX+VZFQBOBQ4Xsg==
X-Received: by 2002:a17:902:c651:b0:174:36ce:49ce with SMTP id s17-20020a170902c65100b0017436ce49cemr31800364pls.87.1662055814225;
        Thu, 01 Sep 2022 11:10:14 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001749381ed8csm10527560plk.254.2022.09.01.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:10:13 -0700 (PDT)
Date:   Thu, 01 Sep 2022 11:10:13 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Sep 2022 11:10:11 PDT (-0700)
Subject:     Re: [PATCH 00/12] riscv: Allwinner D1 platform support
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
CC:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        samuel@sholland.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2022 22:08:03 PDT (-0700), samuel@sholland.org wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1-based boards. Many features are already enabled,
> including USB, Ethernet, and WiFi.
>
> The SoC devicetree uses bindings from the following series which have
> not yet been merged:
> - SRAM controller:
>   https://lore.kernel.org/lkml/20220815041248.53268-1-samuel@sholland.org/
> - NVMEM cell bits property change:
>   https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.org/
> - In-package LDO regulators:
>   https://lore.kernel.org/lkml/20220815043436.20170-1-samuel@sholland.org/
>
> All three of these are required to set the correct I/O domain voltages
> in the pin controller, which I would consider important to have in the
> initial version of the devicetree.
>
> The SoC devicetree does contain one small hack to avoid a dependency on
> the audio codec binding, since that is not ready yet: the codec node
> uses a bare "simple-mfd", "syscon" compatible.
>
>
> Samuel Holland (12):
>   MAINTAINERS: Match the sun20i family of Allwinner SoCs
>   dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles
>   dt-bindings: vendor-prefixes: Add Allwinner D1 board vendors
>   dt-bindings: riscv: Add Allwinner D1 board compatibles
>   riscv: Add the Allwinner SoC family Kconfig option
>   riscv: dts: allwinner: Add the D1 SoC base devicetree
>   riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
>   riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
>   riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
>   riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
>   riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
>   riscv: defconfig: Enable the Allwinner D1 platform and drivers
>
>  .../devicetree/bindings/riscv/cpus.yaml       |   2 +
>  .../devicetree/bindings/riscv/sunxi.yaml      |  64 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>  MAINTAINERS                                   |   2 +-
>  arch/riscv/Kconfig.socs                       |   9 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/allwinner/Makefile        |  10 +
>  .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 242 +++++
>  .../sun20i-d1-common-regulators.dtsi          |  51 +
>  .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  37 +
>  .../sun20i-d1-dongshan-nezha-stu.dts          | 114 +++
>  .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
>  .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
>  .../sun20i-d1-lichee-rv-86-panel.dtsi         |  92 ++
>  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  74 ++
>  .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  84 ++
>  .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 128 +++
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 171 ++++
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  | 900 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |  23 +-
>  20 files changed, 2045 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-common-regulators.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi

I'm assuming these are aimed at the RISC-V tree?  I'm generally OK with 
that, though the DT folks have pointed out a handful of issues that look 
pretty reasonable to me.

I can't find a v2, not sure if I missed it.  No rush on my end, just 
want to make sure I'm not dropping the ball on anything.

Thanks!
