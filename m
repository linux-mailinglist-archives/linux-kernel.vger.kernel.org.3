Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CA4A901B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355435AbiBCVmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355407AbiBCVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:42:47 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A966C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:42:47 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k23-20020a4abd97000000b002ebc94445a0so2728493oop.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WREVPwec3iC01fYWFpUdqurvNb9mKMYsUsOyLHky5g0=;
        b=PWNKbXLEPfwihe3YmJXYidwzzuTGFbgcFjj1LEQ6oosYJT/ffZy/JOxwah6x+NCvcT
         vO/JEzw0IEXFwSwXjZf1bi9W/iZhSW5hW5dtfFbcdYYSwkDvarIZSv1c5icbeCsUM4ZY
         77tXSHkUKySii7TZ1Y1Jwt9rR3Ds7yM8/w2pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WREVPwec3iC01fYWFpUdqurvNb9mKMYsUsOyLHky5g0=;
        b=gOuGOj2qkNmJyebmbKE9V4yaovflQuzqCS6VuCuT6wGwBISVZF9gQHiSihTBbIU8Im
         JNgfaIvh9dBJxr8zEkG3Us3JpdqftbWtmLswhAT+UCjavx17yO6OqqBE1zr+sWk09Xki
         K7sg3k/uVTQmLeJe1I3vETZAoD4SadjRuL9fOQj+0FHOjtfmkljDYusnBHAHTIF1R7Jt
         YC6ZgYFz7LAnBmk9aALEyz9ns5YMiSPgsY1a4GXSSJ+5xnWoNoaQj66lgw5Xqve7TEq+
         l8ebXIjDH4PfRt4DSbpwyl3FOVQophqjROTu+abaAaMTIWAPwUof0Wf59+aBwJP6x+x8
         dAPA==
X-Gm-Message-State: AOAM530ilzS1amqn5PMKgOGIafq1d9TIFB6oa3QAUG8Weg93Jo75Ewcx
        E5XNNvWmoQI1vSCYDDCC2z9XjoA+erDZSXmzMVpYhw==
X-Google-Smtp-Source: ABdhPJz6GlWrK4UDhf7Zf4JC02r3OD3UibnfhZVrjPj4zcCaQn9bExRe0gU1dZ2/lecOLFpLycK1zyTIlzBm52I0m0Q=
X-Received: by 2002:a05:6870:d413:: with SMTP id i19mr16103oag.54.1643924566714;
 Thu, 03 Feb 2022 13:42:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:42:46 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.10.Id346b23642f91e16d68d75f44bcdb5b9fbd155ea@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.10.Id346b23642f91e16d68d75f44bcdb5b9fbd155ea@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:42:46 +0000
Message-ID: <CAE-0n52SD5+cwSRLZXzKJhdrX4KdF9vqOfCUOA3fT2Uy4tmFjQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] arm64: dts: qcom: sc7280: Move dp_hot_plug_det
 pull from SoC dtsi file
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-02-02 13:23:44)
> Pulls should be in the board files, not in the SoC dtsi
> file. Remove. Even though the sc7280 boards don't currently refer to
> dp_hot_plug_det, let's re-add the pulls there just to keep this as a
> no-op change. If boards don't need this / don't want it later then we
> can remove it from them.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
