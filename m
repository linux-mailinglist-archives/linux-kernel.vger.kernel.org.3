Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7074A901E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355465AbiBCVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355441AbiBCVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:42:59 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E8BC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:42:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso3671531otv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rZKb/URIRb4e+1bq8WG2naPTAIt04R1V4A+/AOQJl5M=;
        b=Zf6GC6P6k4E2dueABypEgo62Lv+i3l2RFwhGUQSmjg+1kA2upWJPfHzShEgEzgvVDl
         Ua1Yv3V6RcxXR83e8HKwdEzppPas66GaBIFyXygHC7Lmka9iDN47zmY3oiW3dD/xYq06
         ql137IYDI4LAC4RnEaU4i7kaE9g22NV9vutrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rZKb/URIRb4e+1bq8WG2naPTAIt04R1V4A+/AOQJl5M=;
        b=NGgOeZQFs0RtsDuOFM5eL7niyrPSaIA9AD4I/rnqJb9SgxEeYnuQmsHv1CrUMh/wBE
         fu/XW2AbSBP44Y2MVipbO7p1NSUjG+ERDrL8l30wPv8N+d2mw1gGnHuTPp/ttkdX066T
         H1rixEmGa5uJ6So/uLKkNSSiQDgnsNwh6N74rG8pgNMil9UhCk2GQInF/DPWq+Ee+pdi
         HtxFoYBDTu8GP5hzXk9/Hjp2jGOHIOGFJXu+sYLPKn+9+mh1iraSDVKPiDwxWc/swcfL
         tFG4JpYn6I9JFZSTEnDBBRLoo0fVExvFXhuKly1Qgn5V98Qb49gWhePwzzDRPcWxcNXE
         B4eg==
X-Gm-Message-State: AOAM531ZQLpPtwbO1XEh8l7juzVr+DUqXM4zCaT1xXlloIaYjjvnBCdX
        /trYhi+pjmbwdrtLUj9uuB0tmT/Ddy1xIzftGYtHNg==
X-Google-Smtp-Source: ABdhPJwOrdMT6DEZpuC4Xl8C+ncm9GmabxBxkq3j/gPjgxLIYcBg0xtPPRBeD0/wfYLGAK9zt/aT/y71aEC8gWzGQ54=
X-Received: by 2002:a9d:6f06:: with SMTP id n6mr40779otq.159.1643924578513;
 Thu, 03 Feb 2022 13:42:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:42:58 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.11.Iecb7267402e697a5cfef4cd517116ea5b308ac9e@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.11.Iecb7267402e697a5cfef4cd517116ea5b308ac9e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:42:58 +0000
Message-ID: <CAE-0n51aXPJRBHsmjEs0t4--bfobz6xhTCFjKNN77O1adtq--w@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] arm64: dts: qcom: sc7280: Add a blank line in
 the dp node
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

Quoting Douglas Anderson (2022-02-02 13:23:45)
> It's weird that there's a blank line between the two port nodes but
> not between the attributes and the first port node. Add an extra blank
> line to make it look right.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
