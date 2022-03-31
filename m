Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11094ED7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiCaKp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiCaKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:45:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A03DDD3;
        Thu, 31 Mar 2022 03:44:04 -0700 (PDT)
Received: from mail-lj1-f173.google.com ([209.85.208.173]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9WqY-1ndBfK2fES-005WBS; Thu, 31 Mar 2022 12:44:02 +0200
Received: by mail-lj1-f173.google.com with SMTP id q5so31416863ljb.11;
        Thu, 31 Mar 2022 03:44:02 -0700 (PDT)
X-Gm-Message-State: AOAM5323KREuaVHS2c7IL/So/5JqmC4FfoC8xn5v6/9DcCl67dMXy9r/
        5xMJCBbMTxxtWaCmRkAbJafU6oj1vRoiYNGUiOw=
X-Google-Smtp-Source: ABdhPJxSLzSPG469rbBjqUgenc7GqtDg1G59o6eI2kBV31nJzx0w1XbePWgcX9pqw/Nc6/av9pIeO+axzqEg7/x2jpQ=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr3507386wrw.12.1648721862625; Thu, 31
 Mar 2022 03:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <46aad49867912fc57b669fc54fdb28638cccfcd9.1648551070.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com> <7c4b66f7fe4940cba1b0158803767f6e@sphcmbx02.sunplus.com.tw>
In-Reply-To: <7c4b66f7fe4940cba1b0158803767f6e@sphcmbx02.sunplus.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 12:17:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3edkGMyypwchiJjHDvO4ro6RsOvrhUbEDmP1Obs94mXw@mail.gmail.com>
Message-ID: <CAK8P3a3edkGMyypwchiJjHDvO4ro6RsOvrhUbEDmP1Obs94mXw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:xpTDZlbZOwasZwLrLnRYa79iGksGPPPYKzdPgLjVKaYMjt/vsPC
 oyEIPYjVRFcQyA4PNZJX/xnG+oJDhVU702bzgqxl3euj/jeXIfmG35z5+RqQjAUD1N6BA14
 RLirJQdaGCss6LkjeGsHKBdoFFnUUwdd5MD3AQ1YSn+QY4wqIDYO4X8KAFUpU1WVZYzQVrs
 37JuybXcKR6lNq6ADMJVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b5BZ0dW7EXs=:8DuCFhVrpT8d+PbDr/wvOp
 PZWDHl1XQCObIZ6FlNwQua/oX9HSOrI6HZhcmyYxgsvx8w0KBV6atFGff9Np2qfM2QJfaLLWj
 h9lOC8FgrugUr9IaA9GuelIdkRlY4RvElr59c33Yc0dSrKx5/MggDSjFXEqxW4L2uAorw+y/y
 KGebJt1F5nYspINknuufq9pRqX6DE7M1Lo7GLTLJPgTgasZphjgL0sNpkQ9uSZTbdYrZ1wafZ
 33fqm/6UFfRMRspdWshZ629nHXAWSJSW5M5mwYVWGpWj5rQuNLk0vhcqCnJcMztsI+TlKaf/3
 /3749RSKzSFYYMLfQa7Cmha4HEdMSMH9FUzOOvxowTECv+VbGNMEqmsZyLbaYL57efMUtNKpY
 AwzN0UyMtEwXyoE4CcAVU/Je02d4EZRRTHqY+mC97k6geEPbwidGyCHm4M/CU6UHGWWZxSeYE
 i4vZtd1kSb2gyVjws216tl+5ibZLyb6aKq2swCPgLm2ebDPXR8193TCz3Bck7kOwlXBZOkBy6
 FBU7c+JRvxFeoR9HpQHfr/IcY8LwtkQf6ymGvQLEbHcdWh3flmu9YtjiV8xc/aGZbkgVQCpld
 mt0rzgY6o40rKeklPFCoNwVZIy3+gpdZBmlBXn5G9MzN1Y41ztahzpgyXZFDPxSlhFvF52wMm
 jfPZNGXAyIYgMWsp5NLUdz3JmliK5g2dT0kcfykJ9Xbiq4KFhIom3Y0Xw4zFFFuWXIXKzFy5h
 PErpGfMG8DgyjscU9WQpdrq+tpm7X/Hi0UhWLcFa6zC9OvFTDT1y7iZNnH29xDQ7L1qoyP8cS
 /ureQvGAcdTPhlNMVuI8AOS7YnivdZDj5h9Nym4r1Tqqu94Ve0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:27 AM Tony Huang 黃懷厚 <tony.huang@sunplus.com> wrote:
> > > +static void spmmc_request(struct mmc_host *mmc, struct mmc_request
> > > +*mrq) {
> > > +       struct spmmc_host *host = mmc_priv(mmc);
> > > +       struct mmc_data *data;
> > > +       struct mmc_command *cmd;
> > > +       int ret;
> > > +
> > > +       ret = mutex_lock_interruptible(&host->mrq_lock);
> > > +       if (ret)
> > > +               return;
> >
> > I don't think it's valid to just return here when you get a signal. If nothing can
> > handle the signal, doesn't it just hang?
> >
> > It also appears that you don't release the mutex until the tasklet runs, but it is
> > not valid to release a mutex from a different context.
> >
> > You should get a warning about this when running a kernel with lockdep
> > enabled at compile time. Please rework the locking to make this work.
> >
>         Reomve code:
>     ret = mutex_lock_interruptible(&host->mrq_lock);
>     if (ret)
>          return;
>
>         Below is my modification:
> .    mutex_lock(&host->mrq_lock);

That addresses the problem with the signal handling, but not the lock
imbalance. Please fix that as well.
> >
> > It's better to use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS instead of the
> > SET_ version, then you can remove all the #ifdef checks.
> >
>
>         I use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS.
>         Compile shows error. Error: implicit declaration of function ? ? SYSTEM_SLEEP_PM_OPS? ? Did you mean ? ? SET_SYSTEM_SLEEP_PM_OPS? ?             [-Werror=implicit-function-declaration]

Maybe you are on an old kernel release?

>         I reference other mmc driver.
>         Below is my modification:
>     Compiler is pass.
>
>         #ifdef CONFIG_PM_SLEEP
>         static int spmmc_pm_suspend(struct device *dev)
>         {
>                 pm_runtime_force_suspend(dev);
>
>                 return 0;
>         }

We should fix the other drivers as well. For the moment, just do it
the right way now
instead of copying the #ifdefs.

        Arnd
