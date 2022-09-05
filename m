Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E315AD32B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiIEMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiIEMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:42:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046F5F238
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:37:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k9so11234006wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=QwM9pjS8vOQW1a1STYq71WLO8dxfYAsXiAlllIOYMN8=;
        b=q8nEcRgVsOrOU1VFDfPIB27R/2mM02Druvaoqf8Su3GfKhPcPrkLSfHnsjcdDg2AEw
         uCRXvSP6hg0J2YFbFY1DY0nTlWo3ITvCkb7TB8zuOH+n90RKd+sYCl0D4mbSl1LP8ikZ
         jFyFUQceu2hJK1saRg/ZufPdyRlFSCxMqO2HMOi0dGPQlyT/JUkKllKPc3AvwllhQLDs
         jlPBfv5j4i1vkUOBdBE/6hIh1ZYAw2Uky3j86WKysmjH9XA76/gP5+LHecuVlHzzPwGJ
         XPtgD5qKUEOX/atbh+5mmvgKuwfk0iQcfA6PHM5rf06SJgTV8VVFo3JM9qe+pt8Twi0e
         O8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=QwM9pjS8vOQW1a1STYq71WLO8dxfYAsXiAlllIOYMN8=;
        b=Z3enraupYeJ7XRTEL2JALUCJFJnKsu32dUwVYiSwWr4J/2AAySlF/aRmAisp5XSIG+
         nsctYilqf9+2ZEJ/nyOA6wIt/psCX+YZN/0Ofq+CCZ4rdt9xJUcq3o0H2csVSa9z5CJH
         G0BJ5ncSMgSFhOXBbSVmamZ4aMJle8G76rTlfvjHkkziclx5v9W5ZC8PlhS2PMbXZv9g
         qpOZyklHuGneUjqDBmGn9q3/77YihTwR+bWuWDDEjUvBwYCsFDyd7//C4Ef31iQt0GJ3
         30GuOboniL8yJMivMWT5bUxeV1WHnnMqAyMl8lK2Wo9+iznRtyhMkn+RyVe2cUrmhr+t
         U8vg==
X-Gm-Message-State: ACgBeo0crzMTwsnYacz+1rcxfHiQozwah8a0DsqIqO740fpZX9EBHq51
        JwhUmBvr7XBtclwruJUMTNJC0A==
X-Google-Smtp-Source: AA6agR7Fv8c2V+OgVGbhYzvF0iVD7ZtJgvDsUEj0Oadue3v7WJjZRCNM6ua7SGOrhlkYox4vxWdvrA==
X-Received: by 2002:a5d:64cf:0:b0:220:6d8e:1db0 with SMTP id f15-20020a5d64cf000000b002206d8e1db0mr23297118wri.564.1662381427668;
        Mon, 05 Sep 2022 05:37:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f365:27e9:453c:4c15? ([2a01:e0a:982:cbb0:f365:27e9:453c:4c15])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003a54f49c1c8sm10534879wmk.12.2022.09.05.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:37:06 -0700 (PDT)
Message-ID: <b9886af8-8580-e553-13b4-d730d1113456@baylibre.com>
Date:   Mon, 5 Sep 2022 14:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v8 0/5] fix the meson NFC clock
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220905075027.19114-1-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220905075027.19114-1-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/09/2022 09:50, Liang Yang wrote:
> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
> which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
> the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
> a common MMC and NAND sub-clock was discussed and planed to be implemented
> as NFC clock provider, but now this series of patches of a common MMC and
> NAND sub-clock are never being accepted and the current binding was never
> valid. the reasons are:
> 1. EMMC and NAND, which are mutually exclusive anyway
> 2. coupling the EMMC and NAND.
> 3. it seems that a common MMC and NAND sub-clock is over engineered.
> and let us see the link for more information:
> https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
> so The meson nfc can't work now, let us rework the clock.
>
> Changes since v7 [8]
>   - use COMMON_CLK && (ARCH_MESON || COMPILE_TEST) instead of
>     ARCH_MESON || COMPILE_TEST || COMMON_CLK.
>   - collect the review and ack
>
> Changes since v6 [7]
>   - use COMMON_CLK instead of !HAVE_LEGACY_CLK
>
> Changes since v5 [6]
>   - add change log for patch 3/5
>   - add patch 5/5 to fix the reporting error of test robot
>
> Changes since v4 [5]
>   - split the dt binding patch into two patches, one for fixing,
>     clock, the other for coverting to yaml
>   - split the nfc driver patch into two patches, one for fixing
>     clock, the other for refining the get nfc resource.
>
> Changes since v3 [4]
>   - use devm_platform_ioremap_resource_byname
>   - dt_binding_check for mtd/amlogic,meson-nand.yaml
>
> Changes since v2 [3]
>   - use fw_name from dts, instead the wrong way using __clk_get_name
>   - reg resource size change to 0x800
>   - use reg-names
>
> Changes since v1 [2]
>   - use clk_parent_data instead of parent_names
>   - define a reg resource instead of sd_emmc_c_clkc
>
> [1] https://lore.kernel.org/r/20220106033130.37623-1-liang.yang@amlogic.com
>      https://lore.kernel.org/r/20220106032504.23310-1-liang.yang@amlogic.com
> [2] https://lore.kernel.org/all/20220217063346.21691-1-liang.yang@amlogic.com
> [3] https://lore.kernel.org/all/20220318124121.26117-1-liang.yang@amlogic.com
> [4] https://lore.kernel.org/all/20220402074921.13316-1-liang.yang@amlogic.com/
> [5] https://lore.kernel.org/all/20220513123404.48513-1-liang.yang@amlogic.com/
> [6] https://lore.kernel.org/all/20220607064731.13367-1-liang.yang@amlogic.com/
> [7] https://lore.kernel.org/all/20220624131257.29906-1-liang.yang@amlogic.com/
>
> Liang Yang (5):
>    dt-bindings: nand: meson: fix meson nfc clock
>    mtd: rawnand: meson: fix the clock
>    mtd: rawnand: meson: refine resource getting in probe
>    dt-bindings: nand: meson: convert txt to yaml
>    mtd: rawnand: meson: not support legacy clock
>
>   .../bindings/mtd/amlogic,meson-nand.txt       | 60 -------------
>   .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>   drivers/mtd/nand/raw/Kconfig                  |  2 +-
>   drivers/mtd/nand/raw/meson_nand.c             | 86 +++++++++---------
>   4 files changed, 131 insertions(+), 105 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>
It seems you sent only patch 4

Neil

