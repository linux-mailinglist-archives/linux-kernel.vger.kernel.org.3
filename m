Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9361F465F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355953AbhLBIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhLBIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:09:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E074C061574
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 00:06:00 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi37so69483516lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aluHyp/G7aUqVf+8EbDwLQk4Mm65sEVYc28AHHhMT+8=;
        b=srBlte0h/pIE8eIgDEkNIA/w/mb8T7IpDroBQMg/hXjMAoakC0zuJy8+giEG9Yyr4c
         3RqpVEeBJ4QwmqooPfGY0OIYfOQpr0bH56AAOkba/OsyPPZyaYT1hnd/agXI3q5YqL4u
         vIki7SZWbElHq6UdjjS+IiO+VZaF7d+zmhtK9K8NKVwbYbLVtz3R2kTXQUveW6PXQyCL
         L7/WYsJjlQhPBbcf6NiHyzFuHH7S9G6LnX3v2Y+xeyR0FGHD1YoTj2yOKBbvwqwYSXnH
         aU+QvrVHDxOAZO5EPftvXqU4PE0kOuprf5a7Wqf5bneJzkQp6Uol8Co2hZUUWJJ9VXLt
         jwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aluHyp/G7aUqVf+8EbDwLQk4Mm65sEVYc28AHHhMT+8=;
        b=YpeJirWtsyg//CkZpUY24WqQ/AO5lQQz5vTHCrqHoagJh0w2twmqOklsa1/v9K+Bz0
         2DtEyNrvI1HtQmCRQrZPKNok4siBoZGXgqsdzzYRbCnkuE5Snyc7uPF2ClASncJ1aw5c
         mFzirw2IbbRpMo28DN15+RvIay+cTy1eulCULHgj8Al6WIIBNoCuuYwoJG9rE2mSSq+y
         QQHX2p/j/62hrhnRqTHNcvaAPpGx3BXcEK9k6/P46C7viDgJNauhd6xcIzqpVoLCEUz4
         SRaoi1NRvkyCR6e0dJ+0+Cx/fnZY9XpKmhi1G1LkbCRmHn3+DprpRP7hRu+HwVsS2TF7
         DVwg==
X-Gm-Message-State: AOAM532qi/C9RPfp4d8R/1PsvRN9nGcUK6NfcBmHoCOFukGb9n8xceVi
        x+4jTlo4gZMpLT9VwZ+WVczQF8ZuAHPina5OaoRCYIzvp+I=
X-Google-Smtp-Source: ABdhPJzSU0H7g5qn7iqaj5X7GydiJkdxhePjijCTTqN7hbpHePmUUPTn1a8wODRmyW2kwN9Xtrx3iyUzRkSqs1mXXVw=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr11143471lfv.233.1638432358467;
 Thu, 02 Dec 2021 00:05:58 -0800 (PST)
MIME-Version: 1.0
References: <1637130012-21846-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAPDyKFqd9ThDUPAYom32w4D8nZYxbvYnJgA9dmQnFu2qEhhMig@mail.gmail.com>
 <SJ0PR02MB8449A2533CEFE1B7EAFEA023CD639@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <SJ0PR02MB8449B93CD2752DC3263DD529CD699@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <f178a0db-c978-42cf-1335-09b19d9574cc@intel.com>
In-Reply-To: <f178a0db-c978-42cf-1335-09b19d9574cc@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Dec 2021 09:05:21 +0100
Message-ID: <CAPDyKFpihKExf2qiPuHtbJitP-q21rFCY-MNMdvAvbQd1C2_jA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat sysfs entry
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 08:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 02/12/2021 08:42, Sajida Bhanu (Temp) (QUIC) wrote:
> > Gentle Reminder.
> >
> > Thanks,
> > Sajida
> > -----Original Message-----
> > From: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
> > Sent: Friday, November 26, 2021 10:54 AM
> > To: Ulf Hansson <ulf.hansson@linaro.org>; Sajida Bhanu (Temp) (QUIC) <q=
uic_c_sbhanu@quicinc.com>
> > Cc: adrian.hunter@intel.com; riteshh@codeaurora.org; Asutosh Das (asd) =
<asutoshd@quicinc.com>; agross@kernel.org; bjorn.andersson@linaro.org; linu=
x-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.ker=
nel.org; stummala@codeaurora.org; vbadigan@codeaurora.org; Ram Prakash Gupt=
a (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati (QUIC) <quic_pra=
galla@quicinc.com>; sartgarg@codeaurora.org; nitirawa@codeaurora.org; sayal=
il@codeaurora.org
> > Subject: RE: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat s=
ysfs entry
> >
> >
> >
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, November 25, 2021 5:01 PM
> > To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
> > Cc: adrian.hunter@intel.com; riteshh@codeaurora.org; Asutosh Das (asd) =
<asutoshd@quicinc.com>; agross@kernel.org; bjorn.andersson@linaro.org; linu=
x-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.ker=
nel.org; stummala@codeaurora.org; vbadigan@codeaurora.org; Ram Prakash Gupt=
a (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati (QUIC) <quic_pra=
galla@quicinc.com>; sartgarg@codeaurora.org; nitirawa@codeaurora.org; sayal=
il@codeaurora.org
> > Subject: Re: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat s=
ysfs entry
> >
> > On Wed, 17 Nov 2021 at 07:20, Shaik Sajida Bhanu <quic_c_sbhanu@quicinc=
.com> wrote:
> >>
> >> Add sysfs entry to query eMMC and SD card errors statistics.
> >> This feature is useful for debug and testing.
> >>
> >> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> >> ---
> >>  drivers/mmc/host/cqhci.h     |   1 +
> >>  drivers/mmc/host/sdhci-msm.c | 192 ++++++++++++++++++++++++++++++++++=
+++++++++
> >>  drivers/mmc/host/sdhci.c     |  17 ++++
> >>  drivers/mmc/host/sdhci.h     |   1 +
> >>  include/linux/mmc/host.h     |   1 +
> >>  5 files changed, 212 insertions(+)
> >
> > To allow an easier review, I strongly suggest splitting up the changes =
in smaller pieces. Maybe in three steps: add interfaces, implement them, ad=
d sysfs - or something along those lines.
> >
> > I am also trying to understand the benefit of having these stats availa=
ble. Can you perhaps share a little bit of background on how they are usabl=
e for you? Is it for debug purpose or does it have other purposes too?
> >
> > If it turns out that we agree on finding these stats valuable for us, t=
hen I am inclined to think that this should be integrated closer with the m=
mc core.
> >
> > The error codes that are propagated to the core from failed requests ar=
e common error codes, so we should be able to use that information from the=
 core itself, I think.
> >
> > Kind regards
> > Uffe
> >
> > Hi Ulf,
> >
> > Thanks for the review
> >
> > I am also trying to understand the benefit of having these stats availa=
ble. Can you perhaps share a little bit of background on how they are usabl=
e for you? Is it for debug purpose or does it have other purposes too?
> >
> >>>>>>>>>>>>> These changes for debug purpose only .. if any errors occur=
red while testing eMMC and SD card those will be captured in these sysfs en=
tries ,  we can directly go and check the sysfs entries and get to know wha=
t is the error occurred in driver level.
>
> I would suggest using debugfs and adding support in mmc host debugfs
> e.g.
>
> static inline void mmc_debugfs_err_stats_enable(struct mmc_host *mmc)
> {
>         mmc->err_stats_enabled =3D true;
> }
>
> enum mmc_err_stat {
>         MMC_ERR_CMD_TIMEOUT,
>         MMC_ERR_CMD_CRC,
>         MMC_ERR_DAT_TIMEOUT,
>         MMC_ERR_DAT_CRC,
>         MMC_ERR_AUTO_CMD,
>         MMC_ERR_ADMA,
>         MMC_ERR_TUNING,
>         MMC_ERR_CMDQ_RED,
>         MMC_ERR_CMDQ_GCE,
>         MMC_ERR_CMDQ_ICCE,
>         MMC_ERR_REQ_TIMEOUT,
>         MMC_ERR_CMDQ_REQ_TIMEOUT,
>         MMC_ERR_ICE_CFG,
>         MMC_ERR_MAX,
> };
>
> static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc, enum m=
mc_err_stat stat)
> {
>         mmc->err_stats[stat] +=3D 1;
> }
>
> And amend mmc_add_host_debugfs() to create the err_stats file etc.
>
> sdhci.c could call mmc_debugfs_err_stats_enable() and mmc_debugfs_err_sta=
ts_inc() as needed.
> cqhci.c could call mmc_debugfs_err_stats_inc() as needed.
>
> Ulf, does that sound reasonable?

Yes, it does! Thanks for having a closer look!

[...]

Kind regards
Uffe
