Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA751F2C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiEIDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiEIC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 22:57:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F167719DF;
        Sun,  8 May 2022 19:53:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j6so9904564qkp.9;
        Sun, 08 May 2022 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LoAV4vKHtDWHYcjx/HccDNScwoaBWI78ZMg1Lhzn0Kc=;
        b=AV0eCAcM4dwQEL2GYa+8ylnliPw/IllGlpfo370R8veFGqCZINAxqbvS7tANJ2s101
         hqpowH7o2P1pFracXHKx/CFSSdKuDTQXovwowr4M2wabCy9szm+KmIlFL3q2XVP9aSFD
         euwnuzZhA0WJTHPb7z/Uyl6lOIjxAQRO6XfiogAA1qmX/hRLF+RfjujPcVeU9N47JyqJ
         OyE28U2bGJlE8aYPrC0FVFBZYKdD3vZwr6JNPThX8buSxKqGRR3MZbWEWSvMminsWp6l
         xjgximImsPkhRHnAnBBDRdfAWOBekT+9n9Dd5qkxMLoEch5PPmEkKAUNCoElVpTo+Kkh
         SPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LoAV4vKHtDWHYcjx/HccDNScwoaBWI78ZMg1Lhzn0Kc=;
        b=FwCRDuNUoEwuNH7NZSQYW0sHGuw8WIWtlMynqG2PZfBVUVnUGWn3uffO7mCRqBSJXz
         XKNoTXAbyrBXkhQNgpXBAd3IhC5n43qod/hooE8zL3eIwnGqvoEVnsdYEbIJblff5lwz
         57Gq0VxORH8qO89YKC8kMkXqe/YzlogREcrMSitcjGkNfsl11/fJy96LsXeO7WyN2x1v
         ebrXBGJjEK6T4E2jFdFtCkfGBxaHrmY2FvXeWu1JEiAJjlVmIbbVnwKzgkPbL3M1gaGM
         Fr9CUQP11Sm3GuntB9PTepd1qGpdeDfSQ8Yj/FVVOOk3CW+ILrlsT/i33QETPDMgCce5
         FMPQ==
X-Gm-Message-State: AOAM533s2teMsVsoPXxU3a8QS5uT+zWp+X7PtTsvPi5xpaoA4zDLsYQ3
        YWmOvNW4rE4Vinlg0rgfTjjnA6ENsGUrJBD/btU=
X-Google-Smtp-Source: ABdhPJxcLQ/dM1ItCcc01DCsbquqlE4w8IbwGnFnYAlwRZQbOLCKc6tQdBjxm5j6pTgbELgQk1Va1n/i48Ro1zrORrM=
X-Received: by 2002:a37:ad16:0:b0:6a0:1468:4513 with SMTP id
 f22-20020a37ad16000000b006a014684513mr10207672qkm.96.1652064833037; Sun, 08
 May 2022 19:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220425125546.4129-3-johnson.wang@mediatek.com>
 <202204271737.oAuTwqZH-lkp@intel.com> <a72b6333be0d8a2065477e47222c309a0d520fd4.camel@mediatek.com>
 <abc836d8-b7da-c9da-6936-567df7206ca5@intel.com> <CAGXv+5Hpcm12h0LNPaQ+svdtCa5AaMkC=qS8WaShWQc2oxQfJg@mail.gmail.com>
In-Reply-To: <CAGXv+5Hpcm12h0LNPaQ+svdtCa5AaMkC=qS8WaShWQc2oxQfJg@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 9 May 2022 11:53:16 +0900
Message-ID: <CAGTfZH2Oc6ADQtFiNqa+R=rDPPrKAyEUw_9DY54trr7kU34_Rw@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v3 2/2] PM / devfreq: mediatek: Introduce
 MediaTek CCI devfreq driver
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, May 9, 2022 at 10:53 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Apr 28, 2022 at 7:39 PM Chen, Rong A <rong.a.chen@intel.com> wrote:
> > On 4/27/2022 6:11 PM, Johnson Wang wrote:
> > > On Wed, 2022-04-27 at 17:25 +0800, kernel test robot wrote:
> > >> Hi Johnson,
> > >>
> > >> Thank you for the patch! Perhaps something to improve:
> > >>
> > >> [auto build test WARNING on robh/for-next]
> > >> [also build test WARNING on linus/master v5.18-rc4 next-20220427]
> > >> [If your patch is applied to the wrong git tree, kindly drop us a
> > >> note.
> > >> And when submitting patch, we suggest to use '--base' as documented
> > >> in
> > >>
> > > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMS_s9zEZ$
> > >>   ]
> > >>
> > >> url:
> > >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Johnson-Wang/Introduce-MediaTek-CCI-devfreq-driver/20220425-205820__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMc1U_tqz$
> > >>
> > >> base:
> > >> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMUzTprof$
> > >>    for-next
> > >> config: hexagon-allyesconfig (
> > >> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220427/202204271737.oAuTwqZH-lkp@intel.com/config__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMaVRzbSL$
> > >>   )
> > >> compiler: clang version 15.0.0 (
> > >> https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMRqw5IY-$
> > >> $  1cddcfdc3c683b393df1a5c9063252eb60e52818)
> > >> reproduce (this is a W=1 build):
> > >>          wget
> > >> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMQLiD-i9$
> > >>    -O ~/bin/make.cross
> > >>          chmod +x ~/bin/make.cross
> > >>          #
> > >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commit/98b34c0587837b0e5b880b11a52433f8f0eee19f__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMU5yd7Y2$
> > >>
> > >>          git remote add linux-review
> > >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMW4ldtnH$
> > >>
> > >>          git fetch --no-tags linux-review Johnson-Wang/Introduce-
> > >> MediaTek-CCI-devfreq-driver/20220425-205820
> > >>          git checkout 98b34c0587837b0e5b880b11a52433f8f0eee19f
> > >>          # save the config file
> > >>          mkdir build_dir && cp config build_dir/.config
> > >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > >> W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash block/partitions/
> > >> drivers/devfreq/ drivers/iio/imu/ drivers/misc/lkdtm/
> > >>
> > >> If you fix the issue, kindly add following tag as appropriate
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >> All warnings (new ones prefixed by >>):
> > >>
> > >>     drivers/devfreq/mtk-cci-devfreq.c:372:16: error: no member named
> > >> 'parent_type' in 'struct devfreq_passive_data'
> > >>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
> > >>             ~~~~~~~~~~~~  ^
> > >>     drivers/devfreq/mtk-cci-devfreq.c:372:30: error: use of undeclared
> > >> identifier 'CPUFREQ_PARENT_DEV'
> > >>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
> > >>                                         ^
> > >>>> drivers/devfreq/mtk-cci-devfreq.c:379:4: warning: format
> > >>>> specifies type 'int' but the argument has type 'long' [-Wformat]
> > >>
> > >>                             PTR_ERR(drv->devfreq));
> > >>                             ^~~~~~~~~~~~~~~~~~~~~
> > >>     include/linux/dev_printk.h:144:65: note: expanded from macro
> > >> 'dev_err'
> > >>             dev_printk_index_wrap(_dev_err, KERN_ERR, dev,
> > >> dev_fmt(fmt), ##__VA_ARGS__)
> > >>                                                                    ~~~
> > >>       ^~~~~~~~~~~
> > >>     include/linux/dev_printk.h:110:23: note: expanded from macro
> > >> 'dev_printk_index_wrap'
> > >>                     _p_func(dev, fmt,
> > >> ##__VA_ARGS__);                       \
> > >>                                  ~~~    ^~~~~~~~~~~
> > >>     1 warning and 2 errors generated.
> > >>
> > >>
> > >> vim +379 drivers/devfreq/mtk-cci-devfreq.c
> > >>
> > >>     255
> > >>     256      static int mtk_ccifreq_probe(struct platform_device
> > >> *pdev)
> > >>     257      {
> > >>     258              struct device *dev = &pdev->dev;
> > >>     259              struct mtk_ccifreq_drv *drv;
> > >>     260              struct devfreq_passive_data *passive_data;
> > >>     261              struct dev_pm_opp *opp;
> > >>     262              unsigned long rate, opp_volt;
> > >>     263              int ret;
> > >>     264
> > >>     265              drv = devm_kzalloc(dev, sizeof(*drv),
> > >> GFP_KERNEL);
> > >>     266              if (!drv)
> > >>     267                      return -ENOMEM;
> > >>     268
> > >>     269              drv->dev = dev;
> > >>     270              drv->soc_data = (const struct
> > >> mtk_ccifreq_platform_data *)
> > >>     271                                      of_device_get_match_dat
> > >> a(&pdev->dev);
> > >>     272              mutex_init(&drv->reg_lock);
> > >>     273              platform_set_drvdata(pdev, drv);
> > >>     274
> > >>     275              drv->cci_clk = devm_clk_get(dev, "cci");
> > >>     276              if (IS_ERR(drv->cci_clk)) {
> > >>     277                      ret = PTR_ERR(drv->cci_clk);
> > >>     278                      return dev_err_probe(dev, ret,
> > >>     279                                           "failed to get cci
> > >> clk: %d\n", ret);
> > >>     280              }
> > >>     281
> > >>     282              drv->inter_clk = devm_clk_get(dev,
> > >> "intermediate");
> > >>     283              if (IS_ERR(drv->inter_clk)) {
> > >>     284                      ret = PTR_ERR(drv->inter_clk);
> > >>     285                      dev_err_probe(dev, ret,
> > >>     286                                    "failed to get
> > >> intermediate clk: %d\n", ret);
> > >>     287                      goto out_free_resources;
> > >>     288              }
> > >>     289
> > >>     290              drv->proc_reg =
> > >> devm_regulator_get_optional(dev, "proc");
> > >>     291              if (IS_ERR(drv->proc_reg)) {
> > >>     292                      ret = PTR_ERR(drv->proc_reg);
> > >>     293                      dev_err_probe(dev, ret,
> > >>     294                                    "failed to get proc
> > >> regulator: %d\n", ret);
> > >>     295                      goto out_free_resources;
> > >>     296              }
> > >>     297
> > >>     298              ret = regulator_enable(drv->proc_reg);
> > >>     299              if (ret) {
> > >>     300                      dev_err(dev, "failed to enable proc
> > >> regulator\n");
> > >>     301                      goto out_free_resources;
> > >>     302              }
> > >>     303
> > >>     304              drv->sram_reg = regulator_get_optional(dev,
> > >> "sram");
> > >>     305              if (IS_ERR(drv->sram_reg))
> > >>     306                      drv->sram_reg = NULL;
> > >>     307              else {
> > >>     308                      ret = regulator_enable(drv->sram_reg);
> > >>     309                      if (ret) {
> > >>     310                              dev_err(dev, "failed to enable
> > >> sram regulator\n");
> > >>     311                              goto out_free_resources;
> > >>     312                      }
> > >>     313              }
> > >>     314
> > >>     315              /*
> > >>     316               * We assume min voltage is 0 and tracking
> > >> target voltage using
> > >>     317               * min_volt_shift for each iteration.
> > >>     318               * The retry_max is 3 times of expeted
> > >> iteration count.
> > >>     319               */
> > >>     320              drv->vtrack_max = 3 * DIV_ROUND_UP(max(drv-
> > >>> soc_data->sram_max_volt,
> > >>     321                                                     drv-
> > >>> soc_data->proc_max_volt),
> > >>     322                                                 drv-
> > >>> soc_data->min_volt_shift);
> > >>     323
> > >>     324              ret = clk_prepare_enable(drv->cci_clk);
> > >>     325              if (ret)
> > >>     326                      goto out_free_resources;
> > >>     327
> > >>     328              ret = clk_prepare_enable(drv->inter_clk);
> > >>     329              if (ret)
> > >>     330                      goto out_disable_cci_clk;
> > >>     331
> > >>     332              ret = dev_pm_opp_of_add_table(dev);
> > >>     333              if (ret) {
> > >>     334                      dev_err(dev, "failed to add opp table:
> > >> %d\n", ret);
> > >>     335                      goto out_disable_inter_clk;
> > >>     336              }
> > >>     337
> > >>     338              rate = clk_get_rate(drv->inter_clk);
> > >>     339              opp = dev_pm_opp_find_freq_ceil(dev, &rate);
> > >>     340              if (IS_ERR(opp)) {
> > >>     341                      ret = PTR_ERR(opp);
> > >>     342                      dev_err(dev, "failed to get
> > >> intermediate opp: %d\n", ret);
> > >>     343                      goto out_remove_opp_table;
> > >>     344              }
> > >>     345              drv->inter_voltage =
> > >> dev_pm_opp_get_voltage(opp);
> > >>     346              dev_pm_opp_put(opp);
> > >>     347
> > >>     348              rate = U32_MAX;
> > >>     349              opp = dev_pm_opp_find_freq_floor(drv->dev,
> > >> &rate);
> > >>     350              if (IS_ERR(opp)) {
> > >>     351                      dev_err(dev, "failed to get opp\n");
> > >>     352                      ret = PTR_ERR(opp);
> > >>     353                      goto out_remove_opp_table;
> > >>     354              }
> > >>     355
> > >>     356              opp_volt = dev_pm_opp_get_voltage(opp);
> > >>     357              dev_pm_opp_put(opp);
> > >>     358              ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> > >>     359              if (ret) {
> > >>     360                      dev_err(dev, "failed to scale to
> > >> highest voltage %lu in proc_reg\n",
> > >>     361                              opp_volt);
> > >>     362                      goto out_remove_opp_table;
> > >>     363              }
> > >>     364
> > >>     365              passive_data = devm_kzalloc(dev, sizeof(struct
> > >> devfreq_passive_data),
> > >>     366                                          GFP_KERNEL);
> > >>     367              if (!passive_data) {
> > >>     368                      ret = -ENOMEM;
> > >>     369                      goto out_remove_opp_table;
> > >>     370              }
> > >>     371
> > >>     372              passive_data->parent_type = CPUFREQ_PARENT_DEV;
> > >>     373              drv->devfreq = devm_devfreq_add_device(dev,
> > >> &mtk_ccifreq_profile,
> > >>     374                                                     DEVFREQ_
> > >> GOV_PASSIVE,
> > >>     375                                                     passive_
> > >> data);
> > >>     376              if (IS_ERR(drv->devfreq)) {
> > >>     377                      ret = -EPROBE_DEFER;
> > >>     378                      dev_err(dev, "failed to add devfreq
> > >> device: %d\n",
> > >>   > 379                              PTR_ERR(drv->devfreq));
> > >>     380                      goto out_remove_opp_table;
> > >>     381              }
> > >>     382
> > >>     383              drv->opp_nb.notifier_call =
> > >> mtk_ccifreq_opp_notifier;
> > >>     384              ret = dev_pm_opp_register_notifier(dev, &drv-
> > >>> opp_nb);
> > >>     385              if (ret) {
> > >>     386                      dev_err(dev, "failed to register opp
> > >> notifier: %d\n", ret);
> > >>     387                      goto out_remove_devfreq_device;
> > >>     388              }
> > >>     389              return 0;
> > >>     390
> > >>     391      out_remove_devfreq_device:
> > >>     392              devm_devfreq_remove_device(dev, drv->devfreq);
> > >>     393
> > >>     394      out_remove_opp_table:
> > >>     395              dev_pm_opp_of_remove_table(dev);
> > >>     396
> > >>     397      out_disable_inter_clk:
> > >>     398              clk_disable_unprepare(drv->inter_clk);
> > >>     399
> > >>     400      out_disable_cci_clk:
> > >>     401              clk_disable_unprepare(drv->cci_clk);
> > >>     402
> > >>     403      out_free_resources:
> > >>     404              if (regulator_is_enabled(drv->proc_reg))
> > >>     405                      regulator_disable(drv->proc_reg);
> > >>     406              if (drv->sram_reg && regulator_is_enabled(drv-
> > >>> sram_reg))
> > >>     407                      regulator_disable(drv->sram_reg);
> > >>     408
> > >>     409              if (!IS_ERR(drv->proc_reg))
> > >>     410                      regulator_put(drv->proc_reg);
> > >>     411              if (!IS_ERR(drv->sram_reg))
> > >>     412                      regulator_put(drv->sram_reg);
> > >>     413              if (!IS_ERR(drv->cci_clk))
> > >>     414                      clk_put(drv->cci_clk);
> > >>     415              if (!IS_ERR(drv->inter_clk))
> > >>     416                      clk_put(drv->inter_clk);
> > >>     417
> > >>     418              return ret;
> > >>     419      }
> > >>     420
> > >>
> > >
> > > Hi "kernel test robot",
> > >
> > > Thanks for your review.
> > >
> > > This patch is based on chanwoo/devfreq-testing[1]
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
> >
> > Hi Johnson,
> >
> > Thanks for the feedback, we'll take a look too.
>
> I think the last patch on that branch might be broken.

You mean the patch[1]. Without this patch[1], there are no problems?
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=ea1011fba665b95fc28f682c9b131799a88b11ae

When you tested these patches with patchset[2] without last patch[1]
if there are no problems, please reply to patchset[2] with your Tested-by tag.
[2] https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/


--
Best Regards,
Chanwoo Choi
