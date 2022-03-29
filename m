Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEB4EAFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiC2PMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiC2PMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:12:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B17522CC;
        Tue, 29 Mar 2022 08:10:21 -0700 (PDT)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYtoe-1nUrt61Sro-00UrdT; Tue, 29 Mar 2022 17:10:20 +0200
Received: by mail-wm1-f54.google.com with SMTP id r204-20020a1c44d5000000b0038ccb70e239so1406116wma.3;
        Tue, 29 Mar 2022 08:10:20 -0700 (PDT)
X-Gm-Message-State: AOAM531uCDccBNB8TxD4GKHG3zBHalbonhtDBgEVZqpf1zLHjY56dGFm
        8K4aoSgYFJKYwVsOvig2G3pJkljG/E5xBFoGkbw=
X-Google-Smtp-Source: ABdhPJy1J5xaryus8X4nFV6ubkK8diotbwfxO4GiSu5zF+wuBLiP5QA+mjqckcwLSa9RHUv88mORXl0v0ubH+5QCE64=
X-Received: by 2002:a05:600c:1e0b:b0:38c:9ac5:b486 with SMTP id
 ay11-20020a05600c1e0b00b0038c9ac5b486mr100357wmb.71.1648566619950; Tue, 29
 Mar 2022 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com> <46aad49867912fc57b669fc54fdb28638cccfcd9.1648551070.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <46aad49867912fc57b669fc54fdb28638cccfcd9.1648551070.git.tonyhuang.sunplus@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Mar 2022 17:10:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com>
Message-ID: <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, lhjeff911@gmail.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Tony Huang <tony.huang@sunplus.com>, lh.kuo@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OW6ybkuzuYCfxijmsioYK+OSNW7E2KgMfVayWbofgwQomK+oPCP
 wXw4bApq9HvOJPG2tWxRbIV9+afCXeH4UfQlSS7kTVqazSIj48S+9O+vfEU3JCdnruU0HZI
 ooneO1/e8kk3rOmeHPdkvhJnyjDhDgFvbh7wG+aWXVYFyKgSlC204Oypz4t7J8ZD9YsanZU
 AK2l31XA2xkNNCoxmBxuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+9itSpFYgyk=:13dbzQkzEwFSyL+fpVeNvL
 8wSlv9F1PvRAw3PVGCZ3H4ukXgWvdJvJCiwwJCXyeLQTvW8PNQpoNOnGRII26kc2T+Vkao7+G
 iXxh0kTZmFOnFsKHjCZS0eMw7FiQJsz62F7PpSehd7hrCZuV9R66HARFGtbLoFIM4+sJnS2Rk
 ZByHWMIV4ScG/6SLPXOaCLvrGUHfVcq8KxQ4cVNxb8KvauecPXHAk6vj3M00rSyrUKHbmz8I+
 qFMOLz47sC12u1gaof3lLWwEjgmWtwUfji7Jy65HSGcfKF7yWf32DBKAQCEd1mRI8WDpKV1Hj
 F1H87KcezNy75KX2i4Ek8zCuR8Xt0/9nEaQUMyeOmbq0/MliBMBrBuQDEtcQ6EV93L93hloOp
 oMlvDi6g/R5mGr33260HgB7y85EhAGLttVLFs4N0BV3ayDS8vL7p9yx2LeUTpSz85pTv192JW
 k0NsXBFUa74SgEALxWIAnOZvNbpH6XNnCEBcCC0U1+6iE4OLzJYOjVmgJRU+fwJ+OX2M0ihFc
 VQHpg9s63MRwQ+Z2uyBEeOxOfHGVo7X1HZm1BfHBtxySKmpGnDJOYCWGCmRwpSwG3AFEL4H4J
 FUGTs4xQdYaLqyneUJNCxQ4YY5QBKwH5QOeBadNmpAnmD++oTpMrhr1GKZtTwZvNkce/nyInR
 tWFNUF1xiQacWQN9sPCHad9rVIylSrP4xfqMz7FkwKAnEghezegjYCrMV/vbCJ0se8Es=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 4:42 PM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> Add mmc driver for Sunplus SP7021
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>

There should be a description of the device in the changelog, not just the same
text as the subject.

> +static void spmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct spmmc_host *host = mmc_priv(mmc);
> +       struct mmc_data *data;
> +       struct mmc_command *cmd;
> +       int ret;
> +
> +       ret = mutex_lock_interruptible(&host->mrq_lock);
> +       if (ret)
> +               return;

I don't think it's valid to just return here when you get a signal. If
nothing can
handle the signal, doesn't it just hang?

It also appears that you don't release the mutex until the tasklet runs,
but it is not valid to release a mutex from a different context.

You should get a warning about this when running a kernel with lockdep
enabled at compile time. Please rework the locking to make this work.

> +#endif /* ifdef CONFIG_PM_RUNTIME */
> +
> +static const struct dev_pm_ops spmmc_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
> +#ifdef CONFIG_PM_RUNTIME
> +       SET_RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
> +#endif
> +};
> +#endif /* ifdef CONFIG_PM */

It's better to use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS instead
of the SET_ version, then you can remove all the #ifdef checks.

       Arnd
