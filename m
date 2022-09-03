Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5765AC00C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiICRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:36:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86CF43E64;
        Sat,  3 Sep 2022 10:36:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z23so5266744ljk.1;
        Sat, 03 Sep 2022 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZEpzXYWkDiqZ5PfolVXwS9YgE7NUrPs9icXqPHy6se8=;
        b=fPsiLMyqMj1EayQP9y9vHrrZeT1nqRSULD85UGJThaQg1N6XlvCB5citWgk6f6OQFx
         EF2PzdEZsOQytQFTEJmxH1r0sKmHubF64ivaCFuhuPQGGWBAIpEg4cv/F8RQBnA/9KoX
         yaZ2/Zjk3FgQXgS/SeSE4VoBR/LNpLYjBFN6MiNo+nJNybHd1Ga2t+CZrmPZPsH67/Mh
         ISUBEAJpnhNVje3TDn5KoSWY0B/EoZS6cDBy6qfq09YIsCWUC2fBxprOyvXf+chkVzWU
         eCw/T0Vq/jQqJkec9v7An7H0ZndE5oZ9RfJugAa5H6DHZA/FEFgHXr9DjZT4yVvxnaRL
         ywMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZEpzXYWkDiqZ5PfolVXwS9YgE7NUrPs9icXqPHy6se8=;
        b=kRxrnwtosya697mQsbsY82sHzy/0mKNmjO9rRELdWIAj2UmSq40Oo+TYFyWBtzBBUp
         gIBGZppPS3VzNSh9yRsg8DNSGnFnBmZXXRKGRG2h7gHU6ZcVGN8HxCQsaDejrkZun23t
         3LeG38nEaLc6uEJuAr+PXUq0y1DTNPlopXmmha/HMUIaW6VSCum8vaCmI6VT5/jKDcLq
         RnoVIpqgJNXFP272MD/f/PSP3UFKzE0tOhLSw3S8jZ/WD+EwUp+Eb4CKtEQFTUVox93A
         ZLILir+cHll7yNmf89GWA87EqMkS+vTQFBWrmZog3pbUpT8tQmaBlT6y49dGpkGmIqkn
         4rSg==
X-Gm-Message-State: ACgBeo0G6eEV44m6sT12sAu6HUaFqPYkfVjsThNxJKPOw2ITSmOvlBC6
        w2fHls6IiL74+N2R4J5NQdd4Qe2T+JXvDCakXVE=
X-Google-Smtp-Source: AA6agR4/NNQ8qk0+nNJFEnT1dHs8jfBJypCIaOuCTOWm5NjCgp90if/KArL1upvTg+DXcXvp+oGFaiYzfFv8FLCqINQ=
X-Received: by 2002:a2e:b541:0:b0:265:9da1:24c9 with SMTP id
 a1-20020a2eb541000000b002659da124c9mr8411921ljn.396.1662226558758; Sat, 03
 Sep 2022 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220901024526.2833232-1-jiucheng.xu@amlogic.com> <20220901024526.2833232-2-jiucheng.xu@amlogic.com>
In-Reply-To: <20220901024526.2833232-2-jiucheng.xu@amlogic.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 3 Sep 2022 10:35:47 -0700
Message-ID: <CAFXsbZoFYp_SNEjH0QE=A09JQe8qt1APwnNb9u6KsO5UAL50-A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 7:45 PM Jiucheng Xu <jiucheng.xu@amlogic.com> wrote:
>
> Add a user guide to show how to use DDR PMU to
> monitor DDR bandwidth on Amlogic G12 SoC
>
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes v6 -> v5:
>   - No change
>
> Changes v5 -> v4:
>   - Fix building warning
>
> Changes v3 -> v4:
>   - No change
>
> Changes v2 -> v3:
>   - Rename doc name from aml-ddr-pmu.rst to meson-ddr-pmu.rst
>
> Changes v1 -> v2:
>   - Nothing was changed
> ---
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  .../admin-guide/perf/meson-ddr-pmu.rst        | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/meson-ddr-pmu.rst
>
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 69b23f087c05..997a28e156c1 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -17,3 +17,4 @@ Performance monitor support
>     xgene-pmu
>     arm_dsu_pmu
>     thunderx2-pmu
> +   meson-ddr-pmu
> diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> new file mode 100644
> index 000000000000..28e9910940d0
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================================
> +Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
> +===========================================================
> +
> +There is a bandwidth monitor inside the DRAM contorller. The monitor include

Fix spelling of word "controller" and add an s to the end of include

> +4 channels which can count the read/write request of accessing DRAM individually.
> +It can be helpful to show if the performance bottleneck is on DDR bandwidth.
> +
> +Currently, this driver supports the following 5 Perf events:
> +
> ++ meson_ddr_bw/total_rw_bytes/
> ++ meson_ddr_bw/chan_1_rw_bytes/
> ++ meson_ddr_bw/chan_2_rw_bytes/
> ++ meson_ddr_bw/chan_3_rw_bytes/
> ++ meson_ddr_bw/chan_4_rw_bytes/
> +
> +meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related events.
> +Each channel support using keywords as filter, which can let the channel
> +to monitor the individual IP module in SoC.
> +
> +The following keywords are the filter:
> +
> ++ arm             - DDR access request from CPU
> ++ vpu_read1       - DDR access request from OSD + VPP read
> ++ gpu             - DDR access request from 3D GPU
> ++ pcie            - DDR access request from PCIe controller
> ++ hdcp            - DDR access request from HDCP controller
> ++ hevc_front      - DDR access request from HEVC codec front end
> ++ usb3_0          - DDR access request from USB3.0 controller
> ++ hevc_back       - DDR access request from HEVC codec back end
> ++ h265enc         - DDR access request from HEVC encoder
> ++ vpu_read2       - DDR access request from DI read
> ++ vpu_write1      - DDR access request from VDIN write
> ++ vpu_write2      - DDR access request from di write
> ++ vdec            - DDR access request from legacy codec video decoder
> ++ hcodec          - DDR access request from H264 encoder
> ++ ge2d            - DDR access request from ge2d
> ++ spicc1          - DDR access request from SPI controller 1
> ++ usb0            - DDR access request from USB2.0 controller 0
> ++ dma             - DDR access request from system DMA controller 1
> ++ arb0            - DDR access request from arb0
> ++ sd_emmc_b       - DDR access request from SD eMMC b controller
> ++ usb1            - DDR access request from USB2.0 controller 1
> ++ audio           - DDR access request from Audio module
> ++ sd_emmc_c       - DDR access request from SD eMMC c controller
> ++ spicc2          - DDR access request from SPI controller 2
> ++ ethernet        - DDR access request from Ethernet controller
> +
> +
> +The following command is to show the total DDR bandwidth:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> +
> +This command will print the total DDR bandwidth per second.
> +
> +The following commands are to show how to use filter parameters:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
> +      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
> +      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
> +
> +The 1st command show how to use channel 1 to monitor the DDR bandwidth from ARM.
> +The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
> +The 3rd command show using channel 3 to monitor the sum of ARM and GPU.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac8a98dfbacc..8ee68e699e6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1054,6 +1054,7 @@ AMLOGIC DDR PMU DRIVER
>  M:     Jiucheng Xu <jiucheng.xu@amlogic.com>
>  S:     Supported
>  W:     http://www.amlogic.com
> +F:     Documentation/admin-guide/perf/meson-ddr-pmu.rst
>  F:     drivers/perf/amlogic/
>  F:     include/soc/amlogic/
>
> --
> 2.25.1
>
