Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7958EFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiHJP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHJP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:59:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4E61B02
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:59:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so16524559ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tGGr2AGZztDX6+tZMGrOYrHeGGoDqGQ1tYNC+VSx13Q=;
        b=Mlt/MjxfsLWcD9iPu9I0ODmpCnykm+KkvRAPxKNDkfAqKjLXbzmRMl3M2yP7wXOTpG
         km0GgaHvYvNd2tQB0bpHChUZRE3Eoi4cHUaKSf+dCq/ExLvIGFwc6tYbAm709FJdaI/o
         msIk9RsRT6NvWcfUT7gR0H7ynZ+zmAAH2DTJL3Z4yGNigK89XCC5dax/WauUWnK+k2ud
         1vmfnkFxZevDGlaliaamwV6MdWQP8ws34p/SZyjQ7EGLxN9+uAo1D44yQZjecSgYQ0Sy
         9ik1dBw78JX24d2PiKfhbIPLO8AZ/rVTkiS8bimtl9fUfQrOfP0JkbI+u0kNjE+GZdTw
         KqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tGGr2AGZztDX6+tZMGrOYrHeGGoDqGQ1tYNC+VSx13Q=;
        b=zXRDUe+Faf5eRXQP2qhLj6vLUK5H8NSO/bcAh3e16OBqZwkkg2vmEKaMFLg+mWWRHx
         mZPvh4nFG/ayQWzuYzGSe7QIzkIUi08WuNrW9MSpcZVOQvLKjwEgqkW7m3d50Do852Ib
         J/iWU9ZcRFnq+TygWbyLNC0LKT8PYqOvTK6lmm0upNVcF4tsVWzcZcYx424VgGVz2D4N
         w35nYc0iZ6UzND2YPI0nx74uIohewPFFINhFwUm2v05RdcyHqVN6p/IUlwiT6fYv3Xyg
         67sL19shX5qmou7IUAVEMG1KjPY2QrWjccQfVBtW4R2lk8UL0LUIj8TLXqKLAE1o/2/L
         7KVg==
X-Gm-Message-State: ACgBeo1ECN2ZTDsfT3Wx2767bcbB2YTcrJ+eNAbmBcryaAxOeTYBMmGd
        8CZUgjA7GW9/BBQtDECmOElU0uDc7ADgNf4CxKUYMQ==
X-Google-Smtp-Source: AA6agR5PJKk9otPssXVvunRZe074et6SoggEbvClwQ1XcJFXIIBLguZLLqurUVa6Qf+jdTWkiNUkEQNSNoXzoTH6kBY=
X-Received: by 2002:a2e:9950:0:b0:25e:5777:a17b with SMTP id
 r16-20020a2e9950000000b0025e5777a17bmr8951036ljj.32.1660147169656; Wed, 10
 Aug 2022 08:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <202208102343.yHsh1iyB-lkp@intel.com>
In-Reply-To: <202208102343.yHsh1iyB-lkp@intel.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 10 Aug 2022 11:59:18 -0400
Message-ID: <CAPoiz9x=Uy0q-Z9hB+xmGMfCvAz=Z1iLvHfRsNe6=Ac37Ui+Wg@mail.gmail.com>
Subject: Re: [jonmason-ntb:ntb-next-hacking 16/18] drivers/irqchip/irq-imx-mu-msi.c:128:
 undefined reference to `pci_msi_unmask_irq'
To:     kernel test robot <lkp@intel.com>
Cc:     Frank Li <Frank.Li@nxp.com>, kbuild-all@lists.01.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:47 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/jonmason/ntb ntb-next-hacking
> head:   d90921d21692b59734d2452efea346217a526f44
> commit: 1db755129d2544df84dc197095c14170cfa419c7 [16/18] irqchip: imx mu worked as msi controller
> config: arm64-randconfig-r022-20220810 (https://download.01.org/0day-ci/archive/20220810/202208102343.yHsh1iyB-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/jonmason/ntb/commit/1db755129d2544df84dc197095c14170cfa419c7
>         git remote add jonmason-ntb https://github.com/jonmason/ntb
>         git fetch --no-tags jonmason-ntb ntb-next-hacking
>         git checkout 1db755129d2544df84dc197095c14170cfa419c7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: ID map text too big or misaligned
>    aarch64-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function `imx_mu_msi_unmask_irq':
> >> drivers/irqchip/irq-imx-mu-msi.c:128: undefined reference to `pci_msi_unmask_irq'
>    aarch64-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function `imx_mu_msi_mask_irq':
> >> drivers/irqchip/irq-imx-mu-msi.c:120: undefined reference to `pci_msi_mask_irq'
>
>
> vim +128 drivers/irqchip/irq-imx-mu-msi.c
>
>    115
>    116  static void imx_mu_msi_mask_irq(struct irq_data *data)
>    117  {
>    118          struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
>    119
>  > 120          pci_msi_mask_irq(data);
>    121          imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
>    122  }
>    123
>    124  static void imx_mu_msi_unmask_irq(struct irq_data *data)
>    125  {
>    126          struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
>    127
>  > 128          pci_msi_unmask_irq(data);
>    129          imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq), 0);
>    130  }
>    131
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

And deleting this branch now.  Never intended this branch to be for
public consumption....

Thanks,
Jon
