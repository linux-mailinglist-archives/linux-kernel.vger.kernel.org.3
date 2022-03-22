Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4934E3F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiCVNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiCVNPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:15:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883E7657;
        Tue, 22 Mar 2022 06:14:11 -0700 (PDT)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdNPq-1o5i2U0Hse-00ZMsx; Tue, 22 Mar 2022 14:14:10 +0100
Received: by mail-wm1-f42.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso1677405wmr.1;
        Tue, 22 Mar 2022 06:14:09 -0700 (PDT)
X-Gm-Message-State: AOAM533cgpzCjEn8RKb+oacCxiOqclq7sNEBUv1wx13rcYhb0cCZY9Sf
        6z7GdX4qWofWV4rjg0cCqO99IBmnIu4Xs/+oxWs=
X-Google-Smtp-Source: ABdhPJyHDWv/mDC8WwrAR2wIUWCLvYl74QCY8Bcoo4lV+G5Q4bMm4glI5YH/lSfsRyVIlxl4wVhx+pOkDz4xDrytxAc=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr1599974wmq.174.1647954849655; Tue, 22
 Mar 2022 06:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-6-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 14:13:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Message-ID: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2bBe4cyn3++cwdW/0rs3Hoz8DBuyuGh94rq9xa3h/Q6bApTSrfY
 ciBXTMWnVq9a5Xq03Pb3yMhPSS+qsMnk+uHi+2G5tNhkE+nqVZZ0cxS4jOcC+eVIaRgN5t2
 LHCe8O3qi239if3Uuh3SpA4qrmYc8rYmqzxihzkknqPBGqZj7YR9hfVPXBPhV3E3R/FceQr
 DelYM8HEErILnBlgDObhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8GIhNQ+L9zA=:88M/Tj2uslOfKziF5bGUEx
 ndkAQDGpGYjiNfMnIPDzl+ccdtQUu1Ia4F91AK/cCCjy3QO1lb+MWNou+vrl5baSdfW9yM7Wj
 agfBbSfCXedENbHWA2kEwKfnhsgC/dtTO9ZYGswPyeeh4gqA6vEeXmYf3oAJ6UVI0DR6v5Hwq
 dBGhe1st3MftRG/HH8G/L6P5lM0Pj9b7m0+atjxjz8T7GStEJU0Qxy2/kTTPWzScmZdFzknMX
 S5bFy7OHoIFsscCGGwF7TO02IQJ1qKU0TPWbr1A0w6bMqtcZZjVSeLHkYYIrmmDNImInDEnYl
 /MxexH4G7+lg2f0sSnB0UXn0Idf0dHbfxon7hun6VBjD4JxRvMn7+8cGhEqAPfYwLeZBv+CMJ
 X7G0tRpILH5Gd/N/D3ORxJJVqE5McKK3u4/wjTnwupoEi/vbSiqXCfTa7CtHX1Zf/ZNSmdduT
 Yre8x5U0gesKT9qLFkd6lam7/1f6d7TkjH4280wPiGNuNRMZWlzqGVY/H5MDiO3jVuNl8pl65
 wsT7rQLa+y8M9FGQswGpvEoSMHI18x4jM6p33//1bT5g0VaO5FPQVV/IK6GMTLG5LBZpKv28v
 /osGUKYzcmuhrLLwtfb3P+3LLG+W/gNzfQ3bse+zq+eGftKbD1xSpKtYuT3L+QIb3vsVY7TXi
 J0M0dOyxpIUaG7DEf9gMobC4SogephW1TLy3eRP3jssWj/Qhd4OPehlr2y07/lDbZnUk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

> +
> +#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)

I generally don't like the custom printing macros, please just open-code
the prints where they are used, that makes it easier for other kernel
developers to see exactly what is being printed.

> +enum { APPLE_RTKIT_WORK_MSG,
> +       APPLE_RTKIT_WORK_REINIT,
> +};
> +
> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
> +       APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
> +       APPLE_RTKIT_PWR_STATE_GATED = 0x02,
> +       APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
> +       APPLE_RTKIT_PWR_STATE_ON = 0x20,
> +};

This is an odd indentation style, I would insert a newline after the 'enum {'

> +static int apple_rtkit_worker(void *data)
> +{
> +       struct apple_rtkit *rtk = data;
> +       struct apple_rtkit_work work;
> +
> +       while (!kthread_should_stop()) {
> +               wait_event_interruptible(rtk->wq,
> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
> +                                                kthread_should_stop());
> +
> +               if (kthread_should_stop())
> +                       break;
> +
> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
> +                                           &rtk->work_lock) == 1) {
> +                       switch (work.type) {
> +                       case APPLE_RTKIT_WORK_MSG:
> +                               apple_rtkit_rx(rtk, &work.msg);
> +                               break;
> +                       case APPLE_RTKIT_WORK_REINIT:
> +                               apple_rtkit_do_reinit(rtk);
> +                               break;
> +                       }
> +               }

It looks like you add quite a bit of complexity by using a custom
worker thread implementation. Can you explain what this is
needed for? Isn't this roughly the same thing that one would
get more easily with create_singlethread_workqueue()?

> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)

Instead of allowing the interface to be used without CONFIG_APPLE_RTKIT,
I think it is sufficient to allow the driver itself to be built with
CONFIG_COMPILE_TEST (as you already do), and then have
drivers using it marked as 'depends on APPLE_RTKIT'
unconditionally.

> +/*
> + * Initializes the internal state required to handle RTKit. This
> + * should usually be called within _probe.
> + *
> + * @dev: Pointer to the device node this coprocessor is assocated with
> + * @cookie: opaque cookie passed to all functions defined in rtkit_ops
> + * @mbox_name: mailbox name used to communicate with the co-processor
> + * @mbox_idx: mailbox index to be used if mbox_name is NULL
> + * @ops: pointer to rtkit_ops to be used for this co-processor
> + */
> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
> +                                    const char *mbox_name, int mbox_idx,
> +                                    const struct apple_rtkit_ops *ops);
> +
> +/*
> + * Dev-res managed version of apple_rtkit_init.
> + */
> +struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
> +                                         const char *mbox_name, int mbox_idx,
> +                                         const struct apple_rtkit_ops *ops);

Do we need to export both of these?

         Arnd
