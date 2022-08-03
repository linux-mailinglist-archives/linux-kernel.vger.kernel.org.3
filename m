Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399275886C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiHCFeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiHCFeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:34:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CAF2CDE9;
        Tue,  2 Aug 2022 22:34:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w15so8686008ljw.1;
        Tue, 02 Aug 2022 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m/mpVF2yi0tEdHzO4TUHj1gXlq1RjxX5J9jK9yNPyWM=;
        b=Hyx9KJx2zDiy9tLp2uInAaAHZvdobyDOFVUKfRBQsQT+Q/9H2+GsfP0PGsyKAhN7hF
         /vXRLSVKFLu/1Oe7MURdfNvKVfEUCgY2aTPf+RxGiiTxAEsRrxZU3leJ8YEyvfU4O+cZ
         HOOyMWUIk6R/4M8GytJmlEhrurbm24xfj4aXYRYu9dTvCM4HR+Wil7SIWe81vys3Vlxt
         jy56jDHSg7O5r2cw/T9ZH2z/O5daPFEvXTnr5hmSiRtekvxlaMOAPJCzU36uQ6BCY7ef
         phqekqOCJnibtfnFoJcWEIZ2RUm/CAnbacWX69orip0VU/erkMrTV0c1OnM5rNnsPK9G
         Kj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m/mpVF2yi0tEdHzO4TUHj1gXlq1RjxX5J9jK9yNPyWM=;
        b=dTdu58EdHNgifLniBouiES2FxptoJBPoooz7lxkzDqai3ThhIVddyfJBrjgkFBOhro
         psz1giYNBmw5ZxK09n42uytToY6S8qgQyP+KALvsB9Q3r3BSFq+g78m84xc9FCicLAz5
         HwYZL0HhsPg0M/E8jrGMLb1QZ0ffXjUwr6Ni8WjF36jCQj1DcTzTKVi3QmHf5TgMDImU
         7qClj3gTtqsDadEjYd9BwQAO0ArqPvhIDp/vA/FN63I+sx1rOmWlaiveYZUxYG+AY9o1
         LS4HQW8Re//QRF9VcMjZ/Pn9BBrfoYZvIKKTmO5Ugx333oAhpK1dkf1MLtMp6Dw2T9Up
         O4xQ==
X-Gm-Message-State: ACgBeo0HGwcKpJhrhcC89kQfa2s+GNVhCvZ1MSkpwTAfAGDLo4BsxO+h
        ZCxr6bvd9BAVtX+EuUHNPjPHcCA2eYSdhClU4A==
X-Google-Smtp-Source: AA6agR646p7FUT0NrQdMUfoV4D1TzismNFplFcOD7RivvPBOTxpiN3xQf1ZwkL+BAI3hpDd8UJUujM/YjGLIVlVm29I=
X-Received: by 2002:a05:651c:1a26:b0:25e:5c81:efd7 with SMTP id
 by38-20020a05651c1a2600b0025e5c81efd7mr1962677ljb.307.1659504857436; Tue, 02
 Aug 2022 22:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
 <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p8>
 <CAGaU9a_YZDxaeOCErnQwFF9mE7bARDf4sw3F3ai1DiWwNVMFcw@mail.gmail.com> <20220803041126epcms2p82bafb63e4f135d09017519ed3066f914@epcms2p8>
In-Reply-To: <20220803041126epcms2p82bafb63e4f135d09017519ed3066f914@epcms2p8>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 3 Aug 2022 13:34:05 +0800
Message-ID: <CAGaU9a8Xxvtc0=Ci=ztwya=GqFZ0WB3p4wSo-QvLADdF3Fj+4Q@mail.gmail.com>
Subject: Re: (2) [PATCH v6 5/6] scsi: ufs: wb: Modify messages
To:     j-young.choi@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Jinyoung,

On Wed, Aug 3, 2022 at 12:11 PM Jinyoung CHOI <j-young.choi@samsung.com> wrote:
>
> Hi, Stanley,
>
> >Hi,
> >
> >On Tue, Aug 2, 2022 at 4:29 PM Jinyoung CHOI <j-young.choi@samsung.com> wrote:
> >>
> >> Messages are modified to fit the format of others.
> >>
> >> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> >> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> >> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
> >> ---
> >>  drivers/ufs/core/ufs-sysfs.c |  2 +-
> >>  drivers/ufs/core/ufshcd.c    | 23 +++++++++++------------
> >>  2 files changed, 12 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> >> index 2c0b7f45de4b..117272cf7d61 100644
> >> --- a/drivers/ufs/core/ufs-sysfs.c
> >> +++ b/drivers/ufs/core/ufs-sysfs.c
> >> @@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
> >>                  * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
> >>                  * on/off will be done while clock scaling up/down.
> >>                  */
> >> -               dev_warn(dev, "To control WB through wb_on is not allowed!\n");
> >> +               dev_warn(dev, "It is not allowed to configure WB!\n");
> >>                 return -EOPNOTSUPP;
> >>         }
> >>
> >> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> >> index 5099d161f115..dcd7f03db2a2 100644
> >> --- a/drivers/ufs/core/ufshcd.c
> >> +++ b/drivers/ufs/core/ufshcd.c
> >> @@ -5737,13 +5737,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
> >>
> >>         ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
> >>         if (ret) {
> >> -               dev_err(hba->dev, "%s Write Booster %s failed %d\n",
> >> -                       __func__, enable ? "enable" : "disable", ret);
> >> +               dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
> >> +                       __func__, enable ? "enabling" : "disabling", ret);
> >>                 return ret;
> >>         }
> >>
> >>         hba->dev_info.wb_enabled = enable;
> >> -       dev_info(hba->dev, "%s Write Booster %s\n",
> >> +       dev_info(hba->dev, "%s: Write Booster %s\n",
> >>                         __func__, enable ? "enabled" : "disabled");
> >
> >You need to rebase this patch to follow the latest change as
> >https://lore.kernel.org/all/20220709000027.3929970-1-bjorn.andersson@linaro.org/
>
> I am currently working on the latest 5.20/scsi-staging.
> In this case, can I refer the commit of 5.19/scsi-fixes
> and add commit to 5.20/scsi-staging?
> Or can I reflect it in my change?
> I have no experience, so please guide. :)
>
> Thank you for checking.
> Jinyoung.
>
>

I did not notice that the below patch is merged to 5.19/scsi-fixes, so
I guess perhaps you could keep working on the latest
5.20/scsi-staging, and then Martin would help resolve the conflict.
https://lore.kernel.org/all/20220709000027.3929970-1-bjorn.andersson@linaro.org/

Thanks,

Stanley
