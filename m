Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E54A9018
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355330AbiBCVmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiBCVmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:42:06 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D8C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:42:06 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso3669877otv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=1BxE8YrTuPNLTocALV6/dOU/1D5W0XfJUbvbeKGiPBo=;
        b=I9qwWeSwwd9Ufz80dvJWBpyNEbwUjhW9GdJMAXk1Nhrun9bh0tqq5mhj+AZWC8THbH
         kVDXVjlvQo+5HCNVYEVxTvRRPKRUwt6wE3j7EI6kdNfK/SFpkMwiZB6uaw5cR3G+/xJB
         RbeiLr1nzW2EwVeppn2XLmELRCDM7Q9av0WAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=1BxE8YrTuPNLTocALV6/dOU/1D5W0XfJUbvbeKGiPBo=;
        b=Ef8/VUlVmJL2Id/kl0sNRMUsCzgnAZb5vpdJqVqScbYKbE1QCHEUNlH9Hiqcdz/kwn
         tA+E08Y26Oy/JfhcCa1TK3XZDTJxivWsDiwYcQaiUZtDRVdQI+uf/icxZxvHezwV5Qf7
         bfNcd94N/0vY8x7+fzH6nKuA4BpyXaTVnCQIlTuVbie2M47CT3NdObPaB7jW/2n2QLP/
         xx/qSQWiOORjHI2AN1aLtbvQOWI1MZd8reJkYWPO5k6b2FbKjw67PeZVY2y6TM/UPlWt
         Dux6B9pqKSL6ye5sTQfHjVAuDLBeck49bStwLH0r2Za2Z4KMl+So4/N1i6TNhbB4T0or
         j1Mg==
X-Gm-Message-State: AOAM533j6ZDBrNaHtR6KP1ceWOedYvW3BvMq6eg/iADbx+GB7w6AxZ7Y
        NtaYooxS8xnZNjBRoWKl/Q9dwRhAq+ilDrHf53mteg==
X-Google-Smtp-Source: ABdhPJyDxej66/Vt63TI6nQJctzlFybAxj0ayifCcZGw+L0kXIomsk8EMooLGggnX21HzTuDw9+EZ5yGVUvwNda0wVg=
X-Received: by 2002:a9d:6f06:: with SMTP id n6mr39642otq.159.1643924525682;
 Thu, 03 Feb 2022 13:42:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:42:05 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.9.I5f367dcce8107f2186b2aad4aef0dfcfafa034b9@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.9.I5f367dcce8107f2186b2aad4aef0dfcfafa034b9@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:42:05 +0000
Message-ID: <CAE-0n51N4wB7aTRbZR3zh3hjz56vdkFNwOSuKjU7n9gd_JDcvA@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: sc7280: Disable pull from pcie1_clkreq
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

Quoting Douglas Anderson (2022-02-02 13:23:43)
> I believe that the PCIe clkreq pin is an output. That means we
> shouldn't have a pull enabled for it. Turn it off.

It sounds like it's a request from the PCI device to the PCI phy that
the clk should be on. I googled pcie clkreq open drain and this pdf[1]
says

"The CLKREQ# signal is an open drain, active low signal that is driven
low by the PCI Express M.2 add-I Card function to request that the PCI
Express reference clock be available (active clock state) in order to
allow the PCI Express interface to send/receive data"

so presumably if there isn't an external pull on the signal the open
drain feature will not work and the PCIe device won't be able to drive
it low.

[1] https://advdownload.advantech.com/productfile/PIS/96FD80-P512-LIS/Product%20-%20Datasheet/96FD80-P512-LIS_datasheet20180110154919.pdf
