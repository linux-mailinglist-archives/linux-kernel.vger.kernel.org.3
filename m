Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEE53B4A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiFBH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiFBH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:57:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0869A988;
        Thu,  2 Jun 2022 00:57:09 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h75so6992732ybg.4;
        Thu, 02 Jun 2022 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NxkE9eJbHaVE1GUrrgUR5z3Qleac2ZxUgnV8WSpjMWk=;
        b=XLnMEhnWzju085eSXdhH8CveKCcfBPjZOh1rpGAdGdyElJmQvfhZCgRB+aa6LJFkxZ
         Zwy7NjD3CuEXUL7UUNCtPm0fZ5QsTRkQhB3O8D708rBQVHfsuluWrJ2aUA30y6vg6eYK
         JwPW64qeFIQTrBcO0GWuRQ3SFHW/9OMbMF9lrvsIXaIWbeLjQVeU8sM/1uN0I7dfYkCx
         BwZZa85nsYc3GInG2UPK7KSEu8CVfy0n5JrKXsq3xbEzSovMRvuWQA6CvRa1+h/AItIf
         wdvdzgmGQGc3qJzP4Hb2kzyEtzi+uJpXrOCq836ur+fG/NgmBWYVe9Gf0nFyvYhcmEFw
         qfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NxkE9eJbHaVE1GUrrgUR5z3Qleac2ZxUgnV8WSpjMWk=;
        b=ZZs7zzCWaqS6SzpKxCB0SEEdFPxzQX9JidyVu4sud0Aw2JbpvKDbwjAeYzKlfHBru/
         iTk2GAs1oM7wzQ/k84yOp6nUUouOAsyzka6v9reo2EvtN/MIqDkw7iZwgTuGa2ELfi4W
         1ElkmIut0IEu04fb7eBtOqQCkwJNh44aBMY4wDIoFzOlOEXHTAXVf1LB5RpVw34VX+mC
         fM96v9cIjtvRVNIjd3MfTqJdCCiMrYJsRNoo7funcUKPV2XEmwksTJg44lrWJEMpMsNN
         8zbdr9X0lXkxIvYIXV+jY6zmF4rY1pEWJYa/fp3sRzBysGyU6652n0JgYJ3r6gyOgqiP
         E0VQ==
X-Gm-Message-State: AOAM531g2cKPO7Hym4vuKt48s4zvjOW2Qo0Q7qTADKdpKz3EaQ769fyP
        pVJbg2FJU0+e8JJXsKzvBj7I88wIIIA+KbgiNFM=
X-Google-Smtp-Source: ABdhPJzDwjIB+rdwktPuHUSdTDALpm0UA4wv58tlokwAI1Hh1G8TIboRC4vjhL4g9vUJI+nJdQflzCnmTpzrf8R1Kdo=
X-Received: by 2002:a25:1bc3:0:b0:65d:46e8:6322 with SMTP id
 b186-20020a251bc3000000b0065d46e86322mr3762959ybb.140.1654156629045; Thu, 02
 Jun 2022 00:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com> <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 2 Jun 2022 15:56:55 +0800
Message-ID: <CACT4zj8knKUUsafZ_r5cL50DQDw+vSa_RBi_QCnAS5Y1hB47yw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
To:     "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        "quic_spathi@quicinc.com" <quic_spathi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarthak and others,

I like your patch, I'm not familiar with the whole sleep/wake flow.
But I have a question.

Regarding mmc_poweroff_notify() , there is a parameter notify_type.
In the spec., it has a value 0x04: SLEEP_NOTIFICATION (host is going
to put the device in sleep mode.)
Is there anything that needs to be changed in _mmc_suspend() before
calling mmc_sleepawake(host, true)/mmc_power_off(host)?
Thanks in advance.

Best regards,
Ben

On Wed, May 25, 2022 at 12:31 AM Kamasali Satyanarayan (Consultant)
(QUIC) <quic_kamasali@quicinc.com> wrote:
>
> Hi,
>
> These patches will be further taken by Sarthak.
>
> Thanks,
> Satya
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, April 27, 2022 1:06 PM
> To: quic_spathi <quic_spathi@quicinc.com>
> Cc: avri.altman@wdc.com; linus.walleij@linaro.org; shawn.lin@rock-chips.c=
om; merez@codeaurora.org; s.shtylyov@omp.ru; huijin.park@samsung.com; brian=
norris@chromium.org; digetx@gmail.com; linux-mmc@vger.kernel.org; linux-ker=
nel@vger.kernel.org; Veerabhadrarao Badiganti <vbadigan@codeaurora.org>; Sh=
aik Sajida Bhanu <sbhanu@codeaurora.org>; Kamasali Satyanarayan (Consultant=
) (QUIC) <quic_kamasali@quicinc.com>
> Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
>
> On Tue, 26 Apr 2022 at 11:04, Srinivasarao Pathipati <quic_spathi@quicinc=
.com> wrote:
> >
> > From: Maya Erez <merez@codeaurora.org>
> >
> > This change adds the ability to partially initialize the MMC card by
> > using card Sleep/Awake sequence (CMD5).
> > Card will be sent to Sleep state during runtime/system suspend and
> > will be woken up during runtime/system resume.
> > By using this sequence the card doesn't need full initialization which
> > gives time reduction in system/runtime resume path.
> >
> > Signed-off-by: Maya Erez <merez@codeaurora.org>
> > Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> > Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> > Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
>
> It seems like this patch has been posted before [1]. Let me repeat my que=
stion sent back then.
>
> It would be nice if you could provide some more exact numbers of what the=
 gain is for a couple of different eMMCs, to justify the change.
> Can you please do that?
>
> Kind regards
> Uffe
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/patch/1591277381-7734-1-gi=
t-send-email-vbadigan@codeaurora.org/
>
> > ---
> >  drivers/mmc/core/mmc.c   | 149 +++++++++++++++++++++++++++++++++++++++=
+++++---
> >  include/linux/mmc/card.h |   4 ++
> >  include/linux/mmc/host.h |   2 +
> >  3 files changed, 146 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > 9ab915b..8691c00 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1942,7 +1942,14 @@ static int mmc_sleep_busy_cb(void *cb_data, bool=
 *busy)
> >         return 0;
> >  }
> >
> > -static int mmc_sleep(struct mmc_host *host)
> > +static int mmc_can_sleepawake(struct mmc_host *host) {
> > +       return host && (host->caps2 & MMC_CAP2_SLEEP_AWAKE) && host->ca=
rd &&
> > +               (host->card->ext_csd.rev >=3D 3);
> > +
> > +}
> > +
> > +static int mmc_sleepawake(struct mmc_host *host, bool sleep)
> >  {
> >         struct mmc_command cmd =3D {};
> >         struct mmc_card *card =3D host->card; @@ -1953,14 +1960,17 @@
> > static int mmc_sleep(struct mmc_host *host)
> >         /* Re-tuning can't be done once the card is deselected */
> >         mmc_retune_hold(host);
> >
> > -       err =3D mmc_deselect_cards(host);
> > -       if (err)
> > -               goto out_release;
> > +       if (sleep) {
> > +               err =3D mmc_deselect_cards(host);
> > +               if (err)
> > +                       goto out_release;
> > +       }
> >
> >         cmd.opcode =3D MMC_SLEEP_AWAKE;
> >         cmd.arg =3D card->rca << 16;
> > -       cmd.arg |=3D 1 << 15;
> >         use_r1b_resp =3D mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
> > +       if (sleep)
> > +               cmd.arg |=3D 1 << 15;
> >
> >         err =3D mmc_wait_for_cmd(host, &cmd, 0);
> >         if (err)
> > @@ -1982,6 +1992,9 @@ static int mmc_sleep(struct mmc_host *host)
> >
> >         err =3D __mmc_poll_for_busy(host, 0, timeout_ms,
> > &mmc_sleep_busy_cb, host);
> >
> > +       if (!sleep)
> > +               err =3D mmc_select_card(card);
> > +
> >  out_release:
> >         mmc_retune_release(host);
> >         return err;
> > @@ -2080,6 +2093,66 @@ static int _mmc_flush_cache(struct mmc_host *hos=
t)
> >                         pr_err("%s: cache flush error %d\n",
> >                                mmc_hostname(host), err);
> >         }
> > +       return err;
> > +}
> > +
> > +static int mmc_cache_card_ext_csd(struct mmc_host *host) {
> > +       int err;
> > +       u8 *ext_csd;
> > +       struct mmc_card *card =3D host->card;
> > +
> > +       err =3D mmc_get_ext_csd(card, &ext_csd);
> > +       if (err || !ext_csd) {
> > +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> > +                       mmc_hostname(host), __func__, err);
> > +               return err;
> > +       }
> > +       /* only cache read/write fields that the sw changes */
> > +       card->ext_csd.raw_ext_csd_cmdq =3D ext_csd[EXT_CSD_CMDQ_MODE_EN=
];
> > +       card->ext_csd.raw_ext_csd_cache_ctrl =3D ext_csd[EXT_CSD_CACHE_=
CTRL];
> > +       card->ext_csd.raw_ext_csd_bus_width =3D ext_csd[EXT_CSD_BUS_WID=
TH];
> > +       card->ext_csd.raw_ext_csd_hs_timing =3D
> > + ext_csd[EXT_CSD_HS_TIMING];
> > +
> > +       kfree(ext_csd);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mmc_test_awake_ext_csd(struct mmc_host *host) {
> > +       int err;
> > +       u8 *ext_csd;
> > +       struct mmc_card *card =3D host->card;
> > +
> > +       err =3D mmc_get_ext_csd(card, &ext_csd);
> > +       if (err) {
> > +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> > +                       mmc_hostname(host), __func__, err);
> > +               return err;
> > +       }
> > +
> > +       /* only compare read/write fields that the sw changes */
> > +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%=
d:%d) bus_width (%d:%d) timing(%d:%d)\n",
> > +               mmc_hostname(host), __func__,
> > +               card->ext_csd.raw_ext_csd_cmdq,
> > +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
> > +               card->ext_csd.raw_ext_csd_cache_ctrl,
> > +               ext_csd[EXT_CSD_CACHE_CTRL],
> > +               card->ext_csd.raw_ext_csd_bus_width,
> > +               ext_csd[EXT_CSD_BUS_WIDTH],
> > +               card->ext_csd.raw_ext_csd_hs_timing,
> > +               ext_csd[EXT_CSD_HS_TIMING]);
> > +       err =3D !((card->ext_csd.raw_ext_csd_cmdq =3D=3D
> > +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
> > +               (card->ext_csd.raw_ext_csd_cache_ctrl =3D=3D
> > +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
> > +               (card->ext_csd.raw_ext_csd_bus_width =3D=3D
> > +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
> > +               (card->ext_csd.raw_ext_csd_hs_timing =3D=3D
> > +                       ext_csd[EXT_CSD_HS_TIMING]));
> > +
> > +       kfree(ext_csd);
> >
> >         return err;
> >  }
> > @@ -2103,8 +2176,12 @@ static int _mmc_suspend(struct mmc_host *host, b=
ool is_suspend)
> >             ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
> >              (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
> >                 err =3D mmc_poweroff_notify(host->card, notify_type);
> > -       else if (mmc_can_sleep(host->card))
> > -               err =3D mmc_sleep(host);
> > +       if (mmc_can_sleepawake(host)) {
> > +               memcpy(&host->cached_ios, &host->ios, sizeof(host->cach=
ed_ios));
> > +                mmc_cache_card_ext_csd(host);
> > +       }
> > +       if (mmc_can_sleep(host->card))
> > +               err =3D mmc_sleepawake(host, true);
> >         else if (!mmc_host_is_spi(host))
> >                 err =3D mmc_deselect_cards(host);
> >
> > @@ -2117,6 +2194,48 @@ static int _mmc_suspend(struct mmc_host *host, b=
ool is_suspend)
> >         return err;
> >  }
> >
> > +static int mmc_partial_init(struct mmc_host *host) {
> > +       int err =3D 0;
> > +       struct mmc_card *card =3D host->card;
> > +
> > +       mmc_set_bus_width(host, host->cached_ios.bus_width);
> > +       mmc_set_timing(host, host->cached_ios.timing);
> > +       if (host->cached_ios.enhanced_strobe) {
> > +               host->ios.enhanced_strobe =3D true;
> > +               if (host->ops->hs400_enhanced_strobe)
> > +                       host->ops->hs400_enhanced_strobe(host, &host->i=
os);
> > +       }
> > +       mmc_set_clock(host, host->cached_ios.clock);
> > +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
> > +
> > +       if (!mmc_card_hs400es(card) &&
> > +                       (mmc_card_hs200(card) || mmc_card_hs400(card)))=
 {
> > +               err =3D mmc_execute_tuning(card);
> > +               if (err) {
> > +                       pr_err("%s: %s: Tuning failed (%d)\n",
> > +                               mmc_hostname(host), __func__, err);
> > +                       goto out;
> > +               }
> > +       }
> > +       /*
> > +        * The ext_csd is read to make sure the card did not went throu=
gh
> > +        * Power-failure during sleep period.
> > +        * A subset of the W/E_P, W/C_P register will be tested. In cas=
e
> > +        * these registers values are different from the values that we=
re
> > +        * cached during suspend, we will conclude that a Power-failure=
 occurred
> > +        * and will do full initialization sequence.
> > +        */
> > +       err =3D mmc_test_awake_ext_csd(host);
> > +       if (err) {
> > +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
> > +                       mmc_hostname(host), __func__, err);
> > +               goto out;
> > +       }
> > +out:
> > +       return err;
> > +}
> > +
> >  /*
> >   * Suspend callback
> >   */
> > @@ -2139,7 +2258,7 @@ static int mmc_suspend(struct mmc_host *host)
> >   */
> >  static int _mmc_resume(struct mmc_host *host)  {
> > -       int err =3D 0;
> > +       int err =3D -EINVAL;
> >
> >         mmc_claim_host(host);
> >
> > @@ -2147,7 +2266,19 @@ static int _mmc_resume(struct mmc_host *host)
> >                 goto out;
> >
> >         mmc_power_up(host, host->card->ocr);
> > -       err =3D mmc_init_card(host, host->card->ocr, host->card);
> > +
> > +       if (mmc_can_sleepawake(host)) {
> > +               err =3D mmc_sleepawake(host, false);
> > +               if (!err)
> > +                       err =3D mmc_partial_init(host);
> > +               else
> > +                       pr_err("%s: %s: awake failed (%d), fallback to =
full init\n",
> > +                               mmc_hostname(host), __func__, err);
> > +       }
> > +
> > +       if (err)
> > +               err =3D mmc_init_card(host, host->card->ocr, host->card=
);
> > +
> >         mmc_card_clr_suspended(host->card);
> >
> >  out:
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 37f9758..ed7f6f7 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -86,6 +86,8 @@ struct mmc_ext_csd {
> >         unsigned int            data_tag_unit_size;     /* DATA TAG UNI=
T size */
> >         unsigned int            boot_ro_lock;           /* ro lock supp=
ort */
> >         bool                    boot_ro_lockable;
> > +       u8                      raw_ext_csd_cmdq;       /* 15 */
> > +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
> >         bool                    ffu_capable;    /* Firmware upgrade sup=
port */
> >         bool                    cmdq_en;        /* Command Queue enable=
d */
> >         bool                    cmdq_support;   /* Command Queue suppor=
ted */
> > @@ -96,7 +98,9 @@ struct mmc_ext_csd {
> >         u8                      raw_partition_support;  /* 160 */
> >         u8                      raw_rpmb_size_mult;     /* 168 */
> >         u8                      raw_erased_mem_count;   /* 181 */
> > +       u8                      raw_ext_csd_bus_width;  /* 183 */
> >         u8                      strobe_support;         /* 184 */
> > +       u8                      raw_ext_csd_hs_timing;  /* 185 */
> >         u8                      raw_ext_csd_structure;  /* 194 */
> >         u8                      raw_card_type;          /* 196 */
> >         u8                      raw_driver_strength;    /* 197 */
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index c38072e..a9ddf7a 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -422,6 +422,7 @@ struct mmc_host {
> >  #else
> >  #define MMC_CAP2_CRYPTO                0
> >  #endif
> > +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake (CMD=
5) */
> >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that =
has GPT entry at a non-standard location */
> >
> >         int                     fixed_drv_type; /* fixed driver type fo=
r non-removable media */
> > @@ -441,6 +442,7 @@ struct mmc_host {
> >         spinlock_t              lock;           /* lock for claim and b=
us ops */
> >
> >         struct mmc_ios          ios;            /* current io bus setti=
ngs */
> > +       struct mmc_ios          cached_ios;
> >
> >         /* group bitfields together to minimize padding */
> >         unsigned int            use_spi_crc:1;
> > --
> > 2.7.4
> >
