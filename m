Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A724BC42D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiBSBAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:00:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiBSBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:00:23 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11D65FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:00:05 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d310db3812so83526457b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3p1TOHnp8ibReid/wlK2AdeCyYC3VYEsyH0rt4m/18=;
        b=Q6ad1wBmQLiGWGDUHiw3DYzrQq8jQBW0rGotDaYSJJSR48pS+3vN2M7i+PTu/xG/1V
         RCf/caCxaPMWHcrekyhl6T1ks1q71CtxMVw020/2JIcj+2spY5GhHMcnoiI7LUFK2fT5
         cwH5fAYxIfoldIoCummO70wSxdyLdxUOJvJw2mnWc6kPCGJGV/xE1LC8jBpJq1E8liWo
         Q3uOWKZ2ci3ZKQnGIta21g/tiRusFCoy06NERifc37aLbIB6YG2XBMbuI8qn1BmZSbX4
         FWfXZYlfRp8fuugMg6GkqymrGvJ9ip1Kqt7LPFOKxN3fi3XX0uOO535N25m2Ntll+4H7
         JC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3p1TOHnp8ibReid/wlK2AdeCyYC3VYEsyH0rt4m/18=;
        b=rorlX4PLHCFlmieyeKP9XsWrqqeiYUT8QIbmnwPL/j/DpI93y82Zhq/RMgGsQsvHBk
         V6QTbqTQnNK946tuLm8+ukBVyRWNvfRAHUr/8ddaSl7kXqJCPyDnCznlv2C2Q+XWdZiA
         Z7We/R0ZtHuPtc/KQ1vEcaNWsrPsm7kLOiaiz0lB+YMTB7hwVLiELSVctiWpj12PpMu3
         dTrLlCBVCf4iyi6oByXfPYp4HnHhwYcm2P6IE0XNAxElvzW0Akc2fV+2xu38Nisc9HRt
         SNp+2jz9kBGD/rv319hDqsXyZkVeUASeUK8FI22O4J9UcZegNoWlh0Lv3vv7KoP5kkul
         9GSg==
X-Gm-Message-State: AOAM533LlEFUoM3WfyrVGItYb0uPpAKzpyfXWkM34MwzTpf1PHM7gdYV
        aG1j2XFZD2YLnANkYM7n/ImSqdJgtCVJCg9gEZDJ4A==
X-Google-Smtp-Source: ABdhPJy5lvr/5BdU9dWCEkrmF1Limpcr1nd4UMux2+ecuOsy226OZ8G7s89yorkXyPof85uI3HTJ+H1z33ObBuYxibc=
X-Received: by 2002:a81:f92:0:b0:2d0:5383:7ca with SMTP id 140-20020a810f92000000b002d0538307camr10333597ywp.268.1645232403490;
 Fri, 18 Feb 2022 17:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20211122080938.20623-1-shawn.guo@linaro.org>
In-Reply-To: <20211122080938.20623-1-shawn.guo@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 01:59:52 +0100
Message-ID: <CACRpkdZBGZfB6qLHYc=VqudQSO117v=b1C=VdsuxogJ9Q59N5A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: qcm2290: Add GPIO wakeirq map
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 9:09 AM Shawn Guo <shawn.guo@linaro.org> wrote:

> It adds the map of wakeup capable GPIOs and the pins at MPM wake
> controller on QCM2290, so that these GPIOs can wake up the SoC from
> vlow/vmin low power mode.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Ooops missed patch, I just applied it.

Yours,
Linus Walleij
