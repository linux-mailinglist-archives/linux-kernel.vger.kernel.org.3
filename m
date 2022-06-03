Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40753C88A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiFCKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiFCKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:19:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76EA3B2AA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:19:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v106so12997578ybi.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCANrYMxosIMh+Xvbir+KgFfAUJg6+S8lF+OrF54Av4=;
        b=QQer3CrocRzXUbJga3lT0IkLvDhumQw3omrc4pXZ8kQmhdT77qsC+nSGbTrSlKuBUd
         SCkFr8UUw1STX4eRYdkfUmIt2QCAht10BD+p+MPVoUeAInYnT6OFwC9hPSCsQsiiOxfT
         kobkQkTdkZYzMYu0Awnp5OrBM6veOfZZrVpCwGxhWGxymggg+6AyY4kin49eqx/xn6PI
         8w4DvpKGjeQwc8djJvJogfLdHppjC76lbOf3C6Ysqizv6hWc7KD7Cr3GhVrLiySsPIY8
         YYlxJnCx1Sh8qkMdUMu6/DPS5FCzIsHZ4ez7fXf243TJN+i77BFjgUsJw2BWWNZiqf9H
         BnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCANrYMxosIMh+Xvbir+KgFfAUJg6+S8lF+OrF54Av4=;
        b=sQZwP5gs7AN3G1wk2HxJDN2smJbtVabqQQxnPPyNoA8S/xLUe9BqNI4FnI0+WCQCXn
         P7O4y4yXLDrYayMp58eqez0A4g38vbWiAU1o0RgonsasOAt1ZSnyga6CR8XeKhhAWRGH
         pM76G66WrgO7HJ8Qnmb3sGvAfaF4Cle3EdFhcAoALalN5SlIvzXkl+KZY6AdO4f0yzQ8
         1APEi/jcbvm6S3DD2jIdjB9VNFuEkB0gCgvtSfZbMTYKfAjI00uPw7Xb0gDNNsHbqDvi
         b3Dm+dpUCUZqsc92p1k09dj1chUmlUgN5GQlrME4WFVwD/xbL+wA0UC+/ziBMouQ52G3
         pstw==
X-Gm-Message-State: AOAM532Y4mQDKhKFDmEcJ8XhdTyqWTJ6Q3UuXF3T/3PeZ0c3KifTl+3M
        2wneTqVOspvprXiH1ESnCyeRRM5eXDIMCKfS2Mt3FQ==
X-Google-Smtp-Source: ABdhPJzCQPE37Bt5oIHGrr2jWp33WDnmx62d0Nt6DBKxkJKjMCw9IXg5fe2neGT3z1CVqiY5P3KeqFBug68RmO96NIY=
X-Received: by 2002:a25:1256:0:b0:65d:6433:7993 with SMTP id
 83-20020a251256000000b0065d64337993mr9806001ybs.626.1654251563183; Fri, 03
 Jun 2022 03:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <1654079415-26217-1-git-send-email-quic_srivasam@quicinc.com>
 <1654079415-26217-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50nfwZPdSS7Vw9FiV+Shfn9-bX44hfLq5ey9DBsAy0y4g@mail.gmail.com> <6250a441-6bcd-4ca8-782b-b7a8d9239e46@quicinc.com>
In-Reply-To: <6250a441-6bcd-4ca8-782b-b7a8d9239e46@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:19:11 +0200
Message-ID: <CACRpkdbBRjgNzxYkFPzy3kx45_7vJENp5dTX0MdJw+LSQ=9rvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: sc7280: Add compatible
 string for adsp based platforms
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
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

On Fri, Jun 3, 2022 at 8:09 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
> On 6/2/2022 6:43 AM, Stephen Boyd wrote:

> >> +    enum:
> >> +      - qcom,sc7280-lpass-lpi-pinctrl
> >> +      - qcom,sc7280-lpass-adsp-lpi-pinctrl
> > Can you confirm that this is the same hardware (i.e. same reg property)
> > but just a different compatible string used to convey that the device is
> > using "adsp" mode or not? If so, this looks to be a common pattern for
> > the audio hardware here, where we have two "views" of the hardware, one
> > for adsp mode and one for not adsp mode. I guess the not adsp mode is
> > called "adsp bypass"?
>
> Yes Your understanding is correct. The same hardware in scenario not using ADSP,
>
> and in another enabling DSP.
> >
> > Is that right? Why are we conveying this information via the compatible
> > string?
>
> Could you please suggest better way!.  As pin control driver is the
> first one to probe, I am not getting better approach.
>
> While up-streaming these drivers, concluded to use this approach.

The device tree conveys hardware description and some configuration.

If this is configuration thing, either you could perhaps determine it from the
hardware (if set up in hardware or boot loader) and if that is not possible
it should just be a boolean property of the device
node:

{
    compatible = "...";
    qcom.adsp-mode;
}

If you are probing two different drivers depending on the mode, then there is a
problem of course, but it is a Linux problem not a device tree problem.

Yours,
Linus Walleij
