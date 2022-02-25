Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8884C4D63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiBYSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiBYSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:13:15 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9E181E61
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:12:41 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so4174877otn.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=P6W6fSTOMdI6DLwtXjDNtCkqRboRbExm2e87efd8TAE=;
        b=eIqzJQNGDjQoI00BNU+tJKXsaDa99HFdSsv0vWvNAr5r4lBlpfHfcamK2xc1519ppu
         sXVYfJq14r21w2I5V2MinOcLw41/s2PGQeFw73sUF9MS1lZ0BMokG9riYG/xhOm+z3LY
         cf0JHDdyinFanzE+Angaxs/OHpfBM977UqwKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=P6W6fSTOMdI6DLwtXjDNtCkqRboRbExm2e87efd8TAE=;
        b=5kydXnyd9vSXTMk4PUBDXh5++dp+L2b3dbJGbFH5D9YH7nbrPErrstw7bl1dSbW0xi
         VIReCZx/o0SF4zWlzPrf3Np7P/xdtBwLC6k+8IphodESq5HKZr1tV12qcHWti6R41liS
         zEktufqK0E7SdGZlHUE9cCkKel37+nlIk4qvzE/M4GFoaUUdbZrPeBx4nmejl7SZhUhE
         4QDt6/7K8e6DgDsxCO6nV8m6PLMPomCFLc5iTtE8qi3AIPTySttBwasgHFozxtwMpaJP
         5fT0vKFYc6SG3PBnVtQ8uUAMHbZkiVWuzrzrhIr6walEv3pzMurt+v2EpCWtG3ZYzAsy
         EHJQ==
X-Gm-Message-State: AOAM5314Jc3cr76Ey0Lt79dRtWTDBGIFu+XI0SwBMtDmxm+/I8ZmNR9F
        LLi86InfU3aygsddf7LGtjTUwDABmOmOck7jaQTSzA==
X-Google-Smtp-Source: ABdhPJyZelvN2oaHvgHZQWDJl2h3BY/MvV7fI/x3v4r3uWyib6RzcGk21LpfwuLPgerrS7SuRls6Hqk4L9/OaKQ12j8=
X-Received: by 2002:a9d:22e9:0:b0:5ac:1754:342c with SMTP id
 y96-20020a9d22e9000000b005ac1754342cmr3289214ota.159.1645812761131; Fri, 25
 Feb 2022 10:12:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 10:12:40 -0800
MIME-Version: 1.0
In-Reply-To: <1645804670-21898-3-git-send-email-quic_vpolimer@quicinc.com>
References: <1645804670-21898-1-git-send-email-quic_vpolimer@quicinc.com> <1645804670-21898-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 10:12:40 -0800
Message-ID: <CAE-0n50q4WitTP-dBUwGAWkkF+_hisCHQLntRf7MOi=KSyxQpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm/disp/dpu1: set mdp clk to the maximum
 frequency in opp table
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-02-25 07:57:50)
> use max clock during resume sequence from the opp table.

s/use/Use/

> The clock will be scaled down when framework sends an update.
>
> Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")

Presumably this is the wrong fixes tag, see below.

>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index d550f90..3288f52 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1319,6 +1319,7 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
>         struct drm_device *ddev;
>         struct dss_module_power *mp = &dpu_kms->mp;
>         int i;
> +       unsigned long max_freq = ULONG_MAX;
>
>         ddev = dpu_kms->dev;
>
> @@ -1333,6 +1334,8 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
>                 return rc;
>         }
>
> +       dev_pm_opp_find_freq_floor(dev, &max_freq);

This isn't exactly a cheap thing to do every runtime resume. Please get
the max frequency during probe and stash it somewhere to avoid making
this call over and over again.

> +       dev_pm_opp_set_rate(dev, max_freq);

This is entirely new. The assigned clock rates from DT aren't set during
runtime resume, only during device probe. My question is, if this is
needed now then does it mean we've been running the clk at low speed
after the first runtime suspend and never been pushing it back up again?

>         dpu_vbif_init_memtypes(dpu_kms);
>
>         drm_for_each_encoder(encoder, ddev)
