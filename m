Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E540959A30B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiHSRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352167AbiHSRvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:51:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71702C12D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:25:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q2so4329784edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qzkYwMAvtyCh+8EMy7xCsIla1LIY8R7DNTHAUz0os4I=;
        b=m5eMFu3nPHM0b9xCXd42yvSzIy6NRnYZPewwOGO5BVMGgwKnDLOGfSFJDOIvU94kDL
         I8mrTDyDsaDg0cF+Dz6llUdBkgKXT9/8uXQuWDSafDakxnvBnEkaj4yEHMr01PLb8BuL
         5wk1BcBYzaPsFcEnW9qZJ1PgirWEPWk1qulXFs/eoulcGYsMpxoXxgBJsNwP1qYZDsy7
         DrQs/pNeL9Q9iftvFr+mtFfdErPj4wUwEu4sSbIdz8TR+gvILK7xLTyg/m/MtX9O0Tjy
         82cLDWBOIoZmPuZcMNmttdzYMs9IhrWe6EACiQPQNxHjiCdyVy8Dbf2fa+Y7ojJZoEur
         3Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qzkYwMAvtyCh+8EMy7xCsIla1LIY8R7DNTHAUz0os4I=;
        b=lskvkgS50dsLMa+M9Wk9MQHEcQp6fpxw2m4F03LBQGTR3g2V8na6b7IYRbPyZEjD91
         f7GCwRPLhAn6kdyNS4Z5SzjfzT36z5cznEasQAT2CrpGI94lPZlz6fA1nG16vn9Dnx9P
         a7krLeAnTw1vNX9bl2woeMy2GOm6VquITzwbTlZ4NC1W0F1YRj8Jqfx5OZgtQZuaJ+lO
         QHjqXYqJBp8aOVycPdyvjBigoLF4PHGAe+08zJfKESTsSRFzEe7q11WXytVKTcTxj+tu
         MRPDuauzI6Tb7N9KVow0vf0RMRTkGR8aDXK7iOWosG/4QIZi0AoylIWSVPYzvLXjis4/
         Yy2Q==
X-Gm-Message-State: ACgBeo0wi2Q7ziGFovM8bJLtYRmmdfM64OqLUL1A6czeP/Xzw6/efAnt
        rEjN90g/uuWmJhb1WSNkVDRXOdrL1ND7fTRcdybBPKR1Gx1vow==
X-Google-Smtp-Source: AA6agR4xeUfyO9PUiWAnoGFIOuh+WIOVeXWdawvtypKh9M5LE6JbKb1hr9u1STK+EEhPb7d+ysfeAamEXb6BOH+h1eE=
X-Received: by 2002:a05:6402:50ce:b0:43d:559d:43f4 with SMTP id
 h14-20020a05640250ce00b0043d559d43f4mr6697005edb.325.1660929937682; Fri, 19
 Aug 2022 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220818035105.5510-1-steev@kali.org> <CAMi1Hd2uqbs7mmX+FbNxsnqxTCkBW1CbR3En5f+ov7XZ87qPrA@mail.gmail.com>
In-Reply-To: <CAMi1Hd2uqbs7mmX+FbNxsnqxTCkBW1CbR3En5f+ov7XZ87qPrA@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Fri, 19 Aug 2022 12:25:26 -0500
Message-ID: <CAKXuJqjnoZh1azpdAk-QbPQsOK6bLf-RCng1PgA+p6esQj0g7Q@mail.gmail.com>
Subject: Re: [PATCH] soundwire: qcom: remove unneeded check
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh perfect, I'm not sure how I missed that when I was searching.  This
can be abandoned but it's nice to know I got the fix right :D

On Fri, Aug 19, 2022 at 3:51 AM Amit Pundir <amit.pundir@linaro.org> wrote:
>
> Hi Steev,
>
> Thank you for looking into this crash. Srini submitted the same fix
> earlier this week
> https://www.spinics.net/lists/alsa-devel/msg146137.html
>
> Regards,
> Amit Pundir
>
> On Thu, 18 Aug 2022 at 09:21, Steev Klimaszewski <steev@kali.org> wrote:
> >
> > commit 1fd0d85affe4d6 ("soundwire: qcom: Add flag for software clock gating check")
> > added a flag for software clock gating check, however in commit
> > 33ba01788889666 ("soundwire: qcom: Add support for controlling audio CGCR from HLOS")
> > the same check was added without the flag, so we would still end up failing
> > the software clock gating check.
> >
> > Originally reported by Amit Pundir on DB845c, I also saw it on the
> > Lenovo Yoga C630, right before the splat, we would see
> >
> > qcom-soundwire wcd934x-soundwire.6.auto: Failed to get audio_cgcr reset required for soundwire-v1.6.0
> >
> > however, SDM845 has a soundwire-v1.3.0
> >
> > Since the flag was added in 1fd0d85affe, lets just remove this one.
> >
> > Fixes: 33ba01788889 ("soundwire: qcom: Add support for controlling audio CGCR from HLOS")
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > Reported-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> >  drivers/soundwire/qcom.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> > index 709a7c1e0704..b621f7fb866f 100644
> > --- a/drivers/soundwire/qcom.c
> > +++ b/drivers/soundwire/qcom.c
> > @@ -1355,10 +1355,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
> >         ctrl->bus.compute_params = &qcom_swrm_compute_params;
> >         ctrl->bus.clk_stop_timeout = 300;
> >
> > -       ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> > -       if (IS_ERR(ctrl->audio_cgcr))
> > -               dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
> > -
> >         ret = qcom_swrm_get_port_config(ctrl);
> >         if (ret)
> >                 goto err_clk;
> > --
> > 2.35.1
> >
