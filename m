Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75F4CBB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiCCKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiCCKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:42:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7D17B0FA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:41:33 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j15so2252126lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/He5PBfzR9b46Np3sBPyvvvufWEvrJyXSblzv0l4h0=;
        b=IfDTZ8mnsY+X/hCoFAZGPnck06QKboadm/ipoHjQMtZ0eJpqXXd/HWh7hgdK0K6qp7
         w8Zg5X+eS58yqGYkplFo7h2FfwKcCmnZj2glx/KsuYh0U93v6JjpZPWch3GIW0ccZYod
         ow2PYGroE6B75BwiPgbiIj4lYCiGZXZytYEfsvgp8QmULFohUizZY4XyAA/fmY5jbu99
         XUP5WzWej4ITjnbLZwupR9BBVUhMsb54BGLVV2dr19xZ0JeeedfJwZxz5yztjRDDRCxz
         1gbNNQtKF9aHbZhEdy6RTDuElWrcr1uDNurfk0GaVyghTEzxy/wog9wVlQMvqmA1uKwK
         B1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/He5PBfzR9b46Np3sBPyvvvufWEvrJyXSblzv0l4h0=;
        b=eSCZSnYDNPYrFjskumHJApcmd3ZzT+yyqxaD+/7BtFMLIuKNLjxGtiLY/FsCn1+kfD
         +6JxY4oR26QQZ7Va67RQoU+UITNrU0bSCaKurIIQIsBBoZVyOZSV52jbnXpBpa9rjOHe
         MCQ1VNRQeVUTOvVdDbiLG3jFgbWxZnoGdX+fgra+MXzsmBzC5ZQNhk5DeNEfVhf+fA7U
         DbnUggGQz+0Hhcbg9DXcxoSKvR/Ob4G+ys54jCDhosvkrN4jHLJl8f1PQxf84WdCX/q/
         QSpYKyrDTs9OZffVMQvCdIPUnZiVgqkCKNcmQpoPaddkDxQ2fFB6ZGUvZriMI++skYtN
         MAyg==
X-Gm-Message-State: AOAM533uimueORpKgRJ1T1wGtnCusjAss9I1IcLzg3Y/gBgfAI/pkKal
        FbygwPNc/NIPUkVlbIZMNd0j7ItvkQTQ+8gXOaOAnQ==
X-Google-Smtp-Source: ABdhPJyj3Rk8sSBj5VBB1o9Ac4exoe3sztkfuVm5kHNefHJL6csmr+I21vP4c/Fc2zfkpfoBhdIJbTtTJ34rKaZIbig=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr1540165lfb.254.1646304091630; Thu, 03
 Mar 2022 02:41:31 -0800 (PST)
MIME-Version: 1.0
References: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
 <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
 <20220302082034.GA5723@math.uni-bielefeld.de> <6715A5BE-CA64-4A3D-8EE5-5BEEB63F268A@goldelico.com>
In-Reply-To: <6715A5BE-CA64-4A3D-8EE5-5BEEB63F268A@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Mar 2022 11:40:55 +0100
Message-ID: <CAPDyKFqMs6FsJHVOoVmZxzBPgUdLoqa-xeLfvkQi1pn=8k1h6Q@mail.gmail.com>
Subject: Re: [BUG] mmc: core: adjust polling interval for CMD1
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Huijin Park <huijin.park@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 10:40, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi,
>
> > Am 02.03.2022 um 09:20 schrieb Jean Rene Dawin <jdawin@math.uni-bielefeld.de>:
> >
> > Ulf Hansson wrote on Tue  1/03/22 14:38:
> >> On Thu, 17 Feb 2022 at 21:12, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>>
> >>
> >> From: Ulf Hansson <ulf.hansson@linaro.org>
> >> Date: Tue, 1 Mar 2022 14:24:21 +0100
> >> Subject: [PATCH] mmc: core: Extend timeout to 2s for MMC_SEND_OP_COND
> >>
> >> It looks like the timeout for the MMC_SEND_OP_COND (CMD1) might have become
> >> a bit too small due to recent changes. Therefore, let's extend it to 2s,
> >> which is probably more inline with its previous value, to fix the reported
> >> timeout problems.
> >>
> >> While at it, let's add a define for the timeout value, rather than using
> >> a hard-coded value for it.
> >>
> >> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> >> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> Cc: Huijin Park <huijin.park@samsung.com>
> >> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >> drivers/mmc/core/mmc_ops.c | 4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >> index d63d1c735335..1f57174b3cf3 100644
> >> --- a/drivers/mmc/core/mmc_ops.c
> >> +++ b/drivers/mmc/core/mmc_ops.c
> >> @@ -21,6 +21,7 @@
> >>
> >> #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
> >> #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> >> +#define MMC_OP_COND_TIMEOUT_MS         2000 /* 2s */
> >>
> >> static const u8 tuning_blk_pattern_4bit[] = {
> >>        0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> >> @@ -232,7 +233,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> >> ocr, u32 *rocr)
> >>        cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
> >>        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> >>
> >> -       err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
> >> +       err = __mmc_poll_for_busy(host, MMC_OP_COND_TIMEOUT_MS,
> >> +                                 &__mmc_send_op_cond_cb, &cb_data);
> >>        if (err)
> >>                return err;
> >>
> >> --
> >> 2.25.1
> >
> > Hi,
> >
> > thanks. But testing with this patch still gives the same errors:
> >
> > [   52.259940] mmc1: Card stuck being busy! __mmc_poll_for_busy
> > [   52.273380] mmc1: error -110 doing runtime resume
> >
> > and the system gets stuck eventually.
>
> Same result from my tests.
>
> BR and thanks,
> Nikolaus

Alright, it starts to sound like we might need a revert (or at least a
way to restore the previous behaviour) - even if that would just paper
over the real problem. The real problem is more likely related to how
the host driver manages restoring of the power to the card, which
happens when runtime resuming it.

In any case, just to make sure the loop timeout itself isn't the
problem, can you run the below debug patch please? The intent is to
figure out how long the worst case timeout is, when it's working with
CMD1. As soon as the timeout exceeds the worst case, there is a
message printed to the log.

The below patch is based upon that the offending commit has been reverted.

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Mar 2022 11:00:04 +0100
Subject: [PATCH] mmc: core: DEBUG - Measure and log worst case CMD1 loop

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 11 +++++++++++
 include/linux/mmc/host.h   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 9946733a34c6..3f03d9e8a3a4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -177,11 +177,15 @@ int mmc_send_op_cond(struct mmc_host *host, u32
ocr, u32 *rocr)
 {
        struct mmc_command cmd = {};
        int i, err = 0;
+       s64 cmd1_ms;
+       ktime_t time_start;

        cmd.opcode = MMC_SEND_OP_COND;
        cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;

+       time_start = ktime_get();
+
        for (i = 100; i; i--) {
                err = mmc_wait_for_cmd(host, &cmd, 0);
                if (err)
@@ -211,6 +215,13 @@ int mmc_send_op_cond(struct mmc_host *host, u32
ocr, u32 *rocr)
                        cmd.arg = cmd.resp[0] | BIT(30);
        }

+       cmd1_ms = ktime_to_ms(ktime_sub(ktime_get(), time_start));
+       if (!err && cmd1_ms > host->cmd1_ms) {
+               pr_warn("%s: CMD1 timeout increased to %lld ms, loop=%d\n",
+                       mmc_hostname(host), cmd1_ms, i);
+               host->cmd1_ms = cmd1_ms;
+       }
+
        if (rocr && !mmc_host_is_spi(host))
                *rocr = cmd.resp[0];

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7afb57cab00b..c2ca3bb05620 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -301,6 +301,7 @@ struct mmc_host {
        unsigned int            f_min;
        unsigned int            f_max;
        unsigned int            f_init;
+       s64                     cmd1_ms;
        u32                     ocr_avail;
        u32                     ocr_avail_sdio; /* SDIO-specific OCR */
        u32                     ocr_avail_sd;   /* SD-specific OCR */
-- 
2.25.1
