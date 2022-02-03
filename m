Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4B4A8FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354726AbiBCVYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBCVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:24:02 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F24C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:24:02 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u13so6150781oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mFCoCNzXJqQmBPGmpGLMQ/uDTw/arZ60RPDkmkAmvcM=;
        b=X9B+VWIM+Ueb2wMTtVcqXGBXMsJvg92EaCbJS5Lrb8sY0n7o30x+gUx+Q6cvRrxjfh
         4RFW7XwAz8boyhMLjyTEYSZWuEQDta0bt/3Cvl4Cck1g8VEKzwJq1CISOmCeTuFYHIyb
         EkOB1WN1V7lWrYfL5CP9zFHTMbOq8icSYgmUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mFCoCNzXJqQmBPGmpGLMQ/uDTw/arZ60RPDkmkAmvcM=;
        b=FuE2m8G4huSv7QWc1u2OyTpu74KvbL24RB1Tv8OTOntH/rQcR8z/x0v1nkuXs1fvZr
         6oxLBpkxMRVAMTq98ou0qwcxM8PQAEqFc5O048X2gcmRJoYGWNlRu8Og/PU/QvjqNK2v
         RINBYCoO7dB1vSnrR6lzXdrBk7WeiILTpWe5xc7pLClNLYNjA1FO8GnJbv3vd944wa+a
         C7dYjs0Ci8bZQMign2OtsTPO5rfFW+fH0l/JZT/sDokZy2r35tPLQ9sBzIO2sJG0Hs2x
         QaPVbaD5oaYEe0as9lyEeZbhi77sk25XT58W0won+ppAHk1qDNqakpnpdtDIQeUGXRmv
         aUwA==
X-Gm-Message-State: AOAM530aN3kI5o5tgbH6fKWg/Rl/ChccWIWcL0PpCp/EhPfQmLEhRzpl
        WokEiwXd4V1PpTUV8Y6VFge4rNBxlPcFjU0PkLKCsogTe6I=
X-Google-Smtp-Source: ABdhPJxOyWKbVr8mR+7m+pTrPwUwsXvdE1QAEYRkR9DKBNuxJ6lIKEDLx782mJcqVTw8QOn4+56Rzvr1UzlZz8BO8Z8=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr8697745oib.40.1643923441665;
 Thu, 03 Feb 2022 13:24:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:24:01 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.1.I7b284531f1c992932f7eef8abaf7cc5548064f33@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.1.I7b284531f1c992932f7eef8abaf7cc5548064f33@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:24:01 +0000
Message-ID: <CAE-0n52tvHrr-Mj+RssP_OpxZv9m3puUcwhtQxd9PjTsZ==K6w@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] arm64: dts: qcom: sc7180-trogdor: Add
 "-regulator" suffix to pp3300_hub
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

Quoting Douglas Anderson (2022-02-02 13:23:35)
> All of the other fixed regulators have the "-regulator" suffix. Add it
> to pp3300_hub to match.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
