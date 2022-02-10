Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040A4B0266
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiBJBbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:31:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBJBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:31:45 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579DC43
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:31:47 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id i5so4478293oih.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=8+Nru2NcToVw10SMtgwpUUD5V5gNRuUchLBb5mwzcTo=;
        b=TXHV4iS/LnExFOG16+ujTQmMvV1cNm5vPFzItoWZDg8A8T/YPbRQnR5VB+jSEMaxFU
         Pt/WKTUgnSrBXxgCyeIzvTEs7ZzqHTpju3FkNOxVi1T4xx3SI1l6pK+TLwjynJqb/OSP
         R19+UJ4qOCkEjvQcpQOFlPTR99isRfg19NWdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=8+Nru2NcToVw10SMtgwpUUD5V5gNRuUchLBb5mwzcTo=;
        b=O9idf7zZbUif7xS2eNnhcTrHQ+a4DfsMnJ46NZvF4p2CfUJzeo3ohSvKO+YLbLvwhx
         HXCqrvlhQo1/5MlGGcoo04XUXOFKimYUS9DWVED+OFHmA3tNbkAPIy1c0w/x/X5VPJ7h
         k3gxW7bXUqxu+/JqxwJMs83YOViy4CSo95ljgJI2f1pl03Z4zTvurBa067rAm8UXSKoj
         rMUgMmKUujhVfCny3NjFVhzk2lXgUjppL4EtTXfmE0XK6NUaVxXmo1hHg+hywhtzWLYY
         RhWbvm09QpXgJeVAWPs7Hg4pTrZWmF3wciBFgmn82JSyWB5ddlEKxmWi5yHVEOo1kY7w
         dLzA==
X-Gm-Message-State: AOAM533fLbVnw9P31pLgmBrBChzWu1nvOZC5ItisvCgMpJO7ewHB+Ia4
        vlm0K5edBtl6NpsFsh6pT25D9XULvtR6g7XjRpmGoEcD/Q4=
X-Google-Smtp-Source: ABdhPJziJIFTknz84SWo9mVGHh0qE57URGU8n7DntwMHca8it42Jy2AZliHDBlgXQCx9Gscxm97mfnNa5Z0YJT9CftY=
X-Received: by 2002:a05:6870:d413:: with SMTP id i19mr1648649oag.54.1644451410730;
 Wed, 09 Feb 2022 16:03:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 16:03:30 -0800
MIME-Version: 1.0
In-Reply-To: <a1c2a7e6-8d76-6ee6-4bc4-e7ea8013af02@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50jBeOnkpogPFm+zqTf8bqQs-Bo0Gma658uFE6aA=Edxg@mail.gmail.com> <a1c2a7e6-8d76-6ee6-4bc4-e7ea8013af02@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 16:03:30 -0800
Message-ID: <CAE-0n52LqrdLXk4=WMQY3WXVYLjpwXH+FP2z71gKMAkjiPR4Xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: Add wcd9380 pinmux
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-09 06:26:58)
>
> On 2/9/2022 2:42 AM, Stephen Boyd wrote:
> > Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:14)
> >
> >> +                       pins = "gpio83";
> >> +                       function = "gpio";
> >> +                       drive-strength = <16>;
> >> +                       output-high;
> >> +       };
> >> +
> >> +       wcd938x_reset_sleep: wcd938x_reset_sleep {
> >> +                       pins = "gpio83";
> >> +                       function = "gpio";
> >> +                       drive-strength = <16>;
> >> +                       bias-disable;
> >> +                       output-low;
> > Why doesn't the device drive the reset gpio by requesting the gpio and
> > asserting and deasserting it? We shouldn't need to use pinctrl settings
> > to toggle reset gpios.
> Okay. Verified without these nodes and didn't see any impact. But
> similar way it's mentioned in sm8250-mtp.dts. Could You please suggest
> on it how to go ahead on this?.

I'd expect the wcd938x codec device node to have a 'reset-gpios'
property like

	reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>

and then the driver to request that gpio via

	reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

so it gets the gpio during driver probe. Then the gpio can be deasserted
during suspend and reasserted on resume, if that's even important?
