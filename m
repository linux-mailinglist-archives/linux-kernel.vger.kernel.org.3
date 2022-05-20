Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6C52EFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351304AbiETQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiETQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:03:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D005179C1F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g207so4392219qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rl6lj9qx0jl8NDnbz3wyyCTgYol3jXu1zxcrwsJAVY0=;
        b=hEocKPTB0k/SuvhhyFT5SNEVGtwTVR9duxGaCyxkEPY5PB/c8W8gWNKQ7wBHvRQDTN
         v9JzO9ixObe7EqTnDEf+inUVqwi6/umiSrQFKktXHWrFUYsML5SMrrO8CRU51wbuky3i
         Wl+xXCZOIJ3zhbLnT8eJCt4tUv+9hDCNqaXW/v79Pfq2q6zMeOCAuRCwBBK6qpk8D5Nd
         +YGCkUJyHdekQg4X91lKQuCIjd/kPPyhS5Uv76TlZrckHPyN51WKd42D6fHaO5E2v4pk
         r5vGMgpedKX1tbFxC2h0WBTKV2GYdZ9xdxdoV5NUIjV14YE66alofZdAacWqFHmzdGDW
         czSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rl6lj9qx0jl8NDnbz3wyyCTgYol3jXu1zxcrwsJAVY0=;
        b=nhgUIo4D7imGJdDtU7Jr9UZ0KBPocBZXNQsorR5153JVLQuhpzmNK79btPsfR9HkEA
         ZnRx8t59mTB4yWpF8GUjTvf5MUxayKUJrJMUJfxE+GY3QqBewu1TVmtk4XZ3bQ4VwiGk
         kYQWSssyS/vOxoSUyC/4sAIUkC0+lq1OKntuoyEJWs3YGqJrNHDU7A5YY2VSP6/jFV3i
         oiJlEjpMmLSyjQnELL5bxBODXkeV4XacXp5Bu2PBap7Offutm65FJRntdk4huSwMzsHU
         sk6RUQQeEBYrMdD0YVbyckBgAvu17RbQGSen1Rgq4t2boqZsOpWaw57et+kzSqFIQxlk
         BNYg==
X-Gm-Message-State: AOAM5339e+e/7m38DgTWFUdmMO9C60WVRJeZiFqUznNP3sM//JYZA4Nh
        Dzqvw93pIuId8MG/WQy6LE8K3KBrwx6I9HQydVcuog==
X-Google-Smtp-Source: ABdhPJyZI37QRWTmfOC38IDzqhvOTFVeCbuF71qmUeFydjmoyAbLvyiloaSslSvLRc7a3lrInN3ClO7mlUtVPua/8TU=
X-Received: by 2002:a05:620a:4311:b0:67e:8a0f:4cd5 with SMTP id
 u17-20020a05620a431100b0067e8a0f4cd5mr6809701qko.363.1653062589769; Fri, 20
 May 2022 09:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <1653001902-26910-1-git-send-email-quic_khsieh@quicinc.com>
 <1653001902-26910-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52yT6S4TLpc2e2-kkbMB2Fu2PcZskG-ZFLo7y1YVTyazQ@mail.gmail.com> <609bb4fc-1503-81ef-6fd8-dbb862c4ef80@quicinc.com>
In-Reply-To: <609bb4fc-1503-81ef-6fd8-dbb862c4ef80@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 20 May 2022 19:02:58 +0300
Message-ID: <CAA8EJpqaGqHrdtX6NUHs2YOgeievpkbm8JbwQOU8+KoW4YNf2g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] phy: qcom-edp: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 20 May 2022 at 18:09, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 5/19/2022 5:19 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-05-19 16:11:40)
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> >> index cacd32f..78b7306 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> >> @@ -87,14 +87,19 @@ struct qcom_edp {
> >>
> >>          struct clk_bulk_data clks[2];
> >>          struct regulator_bulk_data supplies[2];
> >> +       int enable_load[2];
> >>   };
> >>
> >>   static int qcom_edp_phy_init(struct phy *phy)
> >>   {
> >>          struct qcom_edp *edp = phy_get_drvdata(phy);
> >>          int ret;
> >> +       int i;
> >>
> >> -       ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
> >> +       for (i = 0; i < 2; i++)
> > Use ARRAY_SIZE(edp->supplies)?
> >
> >> +               regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);
> >> +
> >> +       ret = regulator_bulk_enable(2, edp->supplies);
> > Why is ARRAY_SIZE() usage removed?
>
>
> remove it base on Dmitry's comment.

Ugh. I asked to remove the num_consumers variable, not the ARRAY_SIZE.

>
> I will restore it back to use ARRY_SIZE
>
>
> >
> >>          if (ret)
> >>                  return ret;
> >>



-- 
With best wishes
Dmitry
