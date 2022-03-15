Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32F84D97DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiCOJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbiCOJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:41:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB04EF5F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:40:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bt26so31915282lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pclaPODy93SP2IvMcnpEy/qRzqRnd4X+xxG6eJhSthY=;
        b=v752Jg0r79km/A+aeykRzb13Wv15gCxUVyCnGjqRx5ZoJ1MVQNZf3EFJIwq2L99iM0
         Dd1ajF4WL3XAnsTZuvnfYHpGbcm3kT3L4jFnoohfNvULXNDjsG3Li9aIR3q3be1qP6vv
         FvoKk26Mev+l0JdfAGwrO6J2NtIzLxExBffXDSEI6q4UG+QwCi9/cyOes7ZXCfJ2QLTh
         m7e2HUzXISwfFRSqeZyTdkODnPk2aIpLXCL/fwnM/qA2ieF80GFwdJBrZU99QOB5a1w8
         iK0gH26yZXx3mgsbyDsVnI43/I8AUlbkI2nt7pM4+aZwbkVMbn8yL5pxXq7GDfgUDUb2
         hMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pclaPODy93SP2IvMcnpEy/qRzqRnd4X+xxG6eJhSthY=;
        b=e1Pz/VgLp7rGsqFPZGwQOaQgThOOKYuvXWxMJzsNipQxlRas0Fbq63MH2SfVbNZoUr
         7Lc0iNz0ijgsQsO0ntSGxlhBW25+JZczLjGRWxvJnWQOc/SEIbJWjLnElnlQUjskTZlR
         TuhRWi2NE/35JlhT5YwMsH5WcDZ3cxbnseHwceRRs06rC2+JmB1v7l5aCDM2vZKhKsIS
         tMt0+f7ZrIKt53A2IDoYddbYJZp6XqOqarj4q8fl3d2mLEI8ymKKTZ+z4pJfWLvRkN0V
         CNrfVj3QeZgZGhAc37JsZ02UEKB5FiahiacDBuaf8hAcJGSOeAroMYLAE2ctiBtdrr7i
         lTNA==
X-Gm-Message-State: AOAM531EGy+uYfG5R8jwFwATjiTZPduS7oP6wSBAiGazmPY8As9mMVgB
        czuIYfq8I4iP3ukpimdJGWl0zgNjs8Mrzi/dEQaoXQ==
X-Google-Smtp-Source: ABdhPJzTs17U46nZJ5m9l5tTMbfUia7Iivsjvd4wbCrie4iHkEBVe4aURP543kiy8TW9Sw8LW9gHFcUn3dJ+4MtxOME=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr16879298lfr.233.1647337216430; Tue, 15
 Mar 2022 02:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646820083.git.marc.mattmueller@netmodule.com>
 <d68d8c8edda35a050a6e92b0ff1d57dd3e7c61d6.1646820083.git.marc.mattmueller@netmodule.com>
 <DM6PR04MB65751B0413F8A2FDC72F05B9FC0B9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65751B0413F8A2FDC72F05B9FC0B9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 10:39:40 +0100
Message-ID: <CAPDyKFov8OUvC8KkWm=-e=M5B3y1Lc0Ci4UXQPD1Y6zQnBVuNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: add reliable write setting to sysfs and
 update on read
To:     Avri Altman <avri.altman@wdc.com>,
        Marc Mattmueller <marc.mattmueller@netmodule.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, 10 Mar 2022 at 15:08, Avri Altman <Avri.Altman@wdc.com> wrote:
>
>
> > The mmc reliable write setting (from ext_csd) was not available on the sysfs.
> > Thus, added rel_param and rel_write_set to sysfs and added the update of
> > rel_write_set on sysfs read.
> Here also - why adding ABI when its already available via mmc-utils?
>
> Thanks,
> Avri

FYI, I agree with Avri here. Please use mmc-utils.

In case the values in sysfs become confusing as they may be outdated
at some point, perhaps we should consider dropping them?

Kind regards
Uffe

>
> >
> > Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
> > ---
> >  drivers/mmc/core/mmc.c   | 29 +++++++++++++++++++++++++++++
> >  include/linux/mmc/card.h |  1 +
> >  include/linux/mmc/mmc.h  |  1 +
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > d9537c894e33..a64d1ecb0de9 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -364,6 +364,10 @@ static int
> > mmc_update_ext_csd_runtime_params(struct mmc_card *card, u8
> > *ext_csd)  {
> >         int err = 0;
> >
> > +       /* eMMC v4.41 or later */
> > +       if (card->ext_csd.rev >= 5)
> > +               card->ext_csd.rel_wr_set = ext_csd[EXT_CSD_WR_REL_SET];
> > +
> >         /* eMMC v5 or later */
> >         if (card->ext_csd.rev >= 7) {
> >                 card->ext_csd.pre_eol_info = ext_csd[EXT_CSD_PRE_EOL_INFO];
> > @@ -587,6 +591,7 @@ static int mmc_decode_ext_csd(struct mmc_card
> > *card, u8 *ext_csd)
> >                 }
> >
> >                 card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
> > +               card->ext_csd.rel_wr_set = ext_csd[EXT_CSD_WR_REL_SET];
> >                 card->ext_csd.rst_n_function =
> > ext_csd[EXT_CSD_RST_N_FUNCTION];
> >
> >                 /*
> > @@ -820,6 +825,7 @@ MMC_DEV_ATTR(name, "%s\n", card-
> > >cid.prod_name);  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
> > MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);  MMC_DEV_ATTR(rev,
> > "0x%x\n", card->ext_csd.rev);
> > +MMC_DEV_ATTR(rel_param, "0x%02x\n", card->ext_csd.rel_param);
> >  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> > MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
> >                 card->ext_csd.enhanced_area_offset);
> > @@ -886,6 +892,27 @@ static ssize_t pre_eol_info_show(struct device
> > *dev,
> >
> >  static DEVICE_ATTR_RO(pre_eol_info);
> >
> > +static ssize_t rel_write_set_show(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 char *buf) {
> > +       int err = 0;
> > +       struct mmc_card *card = mmc_dev_to_card(dev);
> > +
> > +       /* before eMMC v4.41 */
> > +       if (card->ext_csd.rev < 5)
> > +               return sprintf(buf, "%s\n", "-");
> > +
> > +       /* eMMC v4.41 or later */
> > +       err = mmc_update_csd(card);
> > +       if (err)
> > +               return (ssize_t)err;
> > +
> > +       return sprintf(buf, "0x%02x\n", card->ext_csd.rel_wr_set); }
> > +
> > +static DEVICE_ATTR_RO(rel_write_set);
> > +
> >  static ssize_t mmc_fwrev_show(struct device *dev,
> >                               struct device_attribute *attr,
> >                               char *buf) @@ -931,6 +958,8 @@ static struct attribute
> > *mmc_std_attrs[] = {
> >         &dev_attr_oemid.attr,
> >         &dev_attr_prv.attr,
> >         &dev_attr_rev.attr,
> > +       &dev_attr_rel_param.attr,
> > +       &dev_attr_rel_write_set.attr,
> >         &dev_attr_pre_eol_info.attr,
> >         &dev_attr_life_time.attr,
> >         &dev_attr_serial.attr,
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> > 37f975875102..21c47893fcb4 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -48,6 +48,7 @@ struct mmc_ext_csd {
> >         u8                      sec_feature_support;
> >         u8                      rel_sectors;
> >         u8                      rel_param;
> > +       u8                      rel_wr_set;
> >         bool                    enhanced_rpmb_supported;
> >         u8                      part_config;
> >         u8                      cache_ctrl;
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> > d9a65c6a8816..42afd442a70a 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -266,6 +266,7 @@ static inline bool mmc_ready_for_data(u32 status)
> >  #define EXT_CSD_BKOPS_START            164     /* W */
> >  #define EXT_CSD_SANITIZE_START         165     /* W */
> >  #define EXT_CSD_WR_REL_PARAM           166     /* RO */
> > +#define EXT_CSD_WR_REL_SET             167     /* R/W */
> >  #define EXT_CSD_RPMB_MULT              168     /* RO */
> >  #define EXT_CSD_FW_CONFIG              169     /* R/W */
> >  #define EXT_CSD_BOOT_WP                        173     /* R/W */
> > --
> > 2.20.1
>
