Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9355A44FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH2IYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiH2IYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:24:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D257551
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bq11so9168695wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uFRiffIvzQ9QFbO1m9r0+ADVKxOh8ctJA6Vb37LR4lM=;
        b=DShOJXq5b87D/6GDp/67rnM6rxx9a26JTD4M6JJ98xkpuLmxEduKx+iN+vEG0rToOh
         f1A87IWi5SID7QBCR9Ymnr192zeMv1P/HMm/TVQQbDNz0ZYdhOWObOrF0pO3Jd98OIvE
         WYheNOU6zbenz7Wo+L4irgajhj+V5piQwtvO43VuNoOHZPVjPE0QxZwC3vXoVzBqQt7e
         rgzSBO84hyT5YXV4mnIkm6mPMZsd3WZ1fpcFoidfUS+UAw9nhyAxb4dTzL3tP1Ho8Aex
         9sPejLEeYKjuNBZDk6GxIxvNqtMmUPygZ5a/kOTvtN1bR/kWI+GbTtvqR8NoD/0211Il
         PlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uFRiffIvzQ9QFbO1m9r0+ADVKxOh8ctJA6Vb37LR4lM=;
        b=a9msvnZP8FXeeNLPp812gMowlUQsaTRMwXGpUrtSsdFwEUUwZZ5iT7tQIhzcKX/Xqt
         Pw1SIp4WgX/hqTBnkeKWXp7NNZWLtMvtZ9q0Rp5S1n2IXZ+BK/WWoNSgs7POh/CofdJf
         +fMQFtpFfPjdbhjJ6Rl5287mNdzlER+gIzHB1bf9xpqKLY5fcTlw5hyLerMmZ7Ivfl/O
         sWj7xd/MDCtcy3SiibWOiVNCoVbMYIAwMl9TarytLSeIfqcTQv3Em/vfH15eWd+RWmuf
         P0wJXEZ/xgmYsg+n09zOACIAd48GkLa2r3ZlW+GpuYXAQRAEstEPEDB0Bn7jwquy50Ih
         p7AA==
X-Gm-Message-State: ACgBeo3hghYLQYq5PA4S14AhMw22ekSwR9qXf5HivFhWVzw/veOecScB
        ZeFirPH4Bzo9D9DzglFI5c1hLg==
X-Google-Smtp-Source: AA6agR6JS+DZb+wFfzIPJ1CsDKrTCDWPQF9AJL39E3gMEVQHkxXNrkWzYJYM1oTdX5JQaMuz8KWgmg==
X-Received: by 2002:a05:6000:1c14:b0:226:deb1:d7cc with SMTP id ba20-20020a0560001c1400b00226deb1d7ccmr846314wrb.494.1661761479688;
        Mon, 29 Aug 2022 01:24:39 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4452000000b00225307f43fbsm6283277wrr.44.2022.08.29.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 01:24:39 -0700 (PDT)
Date:   Mon, 29 Aug 2022 10:24:38 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kbuild-all@lists.01.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] clk: mediatek: add driver for MT8365 SoC
Message-ID: <20220829082438.ayz2qqav63odn3t6@blmsp>
References: <20220822152652.3499972-5-msp@baylibre.com>
 <202208241051.Xi9D8DaW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202208241051.Xi9D8DaW-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 24, 2022 at 10:57:12AM +0800, kernel test robot wrote:
> Hi Markus,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on robh/for-next linus/master v6.0-rc2 next-20220823]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220824/202208241051.Xi9D8DaW-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/51c1bac1ab0d284ab6c444966eee437c23095a85
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
>         git checkout 51c1bac1ab0d284ab6c444966eee437c23095a85
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "mtk_clk_register_gates_with_dev" [drivers/clk/mediatek/clk-mt8365-mm.ko] undefined!

This series is based on this patch
https://lore.kernel.org/linux-mediatek/20220813083249.45427-1-y.oudjana@protonmail.com/
which is not yet applied but adds the required EXPORT.

Best,
Markus
