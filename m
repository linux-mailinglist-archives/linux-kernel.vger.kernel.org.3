Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386C04797CB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 01:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhLRAYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 19:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLRAYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 19:24:22 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE5C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:24:22 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d2so3800200qki.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrbf0sSEoAPLaTiCBgE/b+YOlhdzxcuXyPDYx5Keb6g=;
        b=brzIfJsBMLDyv2YY60oB5GBCbP7Z8MPjYQYB6n6XDXmDoQch8gr6qYVT3bi21jMhWZ
         SD0ktUmdYZtYICbBtzKsGg2tm+fcbwAfyPzOdlWq+mEnrib/lZNt+Ifhz3BadpQsQlGB
         Z81H9+ibfWZDPwg8qQgjoUZuHrstDYO44tnqzjG6N2qY+w2R5wotvTLZLYB2ACh+7TfM
         KbWvvdzUYsauURANjIYHOTxsdeTlkn59MwBV+KjxCQNrfAiJ3E209ywCWfJyxgb4VbWF
         lNakUU1m5dCN0LtlGgL5RMa8u/QSHB1Ymq/eojz56p5CR1i5mePSGP9xT4ElTQwlqaD2
         f6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrbf0sSEoAPLaTiCBgE/b+YOlhdzxcuXyPDYx5Keb6g=;
        b=mY73ccTBIQqaEwSoqOZBWGSvnxmPGEYgrdrSxTdCp0oK/AlSBxo+Hy/BwVzkWHTh0K
         NWFVPm1oGEoV2zk48D60mg8r6sEj29yI3lio5gI3ZMs6U73oFgQQWi4Bye5Nq7prRJvD
         9JM4OKSPTF7DhbAbDc0h1a2y2ZlP+1o53H8jBjyrO0+7pSJIMMqj7puTEIREL23Ssm3x
         3vF8TOjIlpUi/K2TRuHfgBHkW2ExHq7sp17nmCeY8qm7OoG65WckOMkBvHjT71RFuwXw
         l/B7w59mMI33E1fi525J5rEf5mlFzGSfHlekNgAieiIn5JpkrXrKTWcqa5ZS7RQCdhGC
         0CcQ==
X-Gm-Message-State: AOAM531ZUGqsocQuNonomcE6f7TY3pekaFEjPsO4Tdenir0415PqIIyP
        L8MZVGec0KpM6PNeWmmwjuQfRaeh8LQp2jJJ2AbYdg==
X-Google-Smtp-Source: ABdhPJwlobTf8LRUEovchJAZU7IAz9VeLeEkalM8LAnVjqrKAYqP58yb87QGzCDludo/ieEUMBB4VYfi8IzvMFTryMk=
X-Received: by 2002:a05:620a:461e:: with SMTP id br30mr3519722qkb.363.1639787061459;
 Fri, 17 Dec 2021 16:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20211217125757.1193256-1-balbi@kernel.org>
In-Reply-To: <20211217125757.1193256-1-balbi@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 18 Dec 2021 03:24:10 +0300
Message-ID: <CAA8EJpoTGyWZRfHnEEMFLVn+JtUxJ7Lv+CL2arxVxU=2vWuHXg@mail.gmail.com>
Subject: Re: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable
 framebuffer for Surface Duo
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Dec 2021 at 15:58, Felipe Balbi <balbi@kernel.org> wrote:
>
> From: Felipe Balbi <felipe.balbi@microsoft.com>
>
> Hi folks,
>
> I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
> through some internal docs, it came to my attention that the bootloader
> will fill up the framebuffer address and size to a memory node names
> splash_region. Adding the node, I can see the address of the
> framebuffer. Creating the relevant framebuffer device using
> simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
> of=/dev/fb0 and fb-test. None of which manage to get rid of what's
> already on the screen, put there by the bootloader (platform Logo).
>
> Wondering if any of you have seen a behavior such as this and how did
> you manage to get framebuffer working on SM8150 (I see at least Sony
> Xperia has the node).

What issues do you have with the DRM_MSM/DPU1 driver? I think it supports 8150.

>
> Felipe Balbi (2):
>   arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
>   arm64: boot: dts: qcom: surface duo: add minimal framebuffer
>
>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> --
> 2.34.1



-- 
With best wishes
Dmitry
