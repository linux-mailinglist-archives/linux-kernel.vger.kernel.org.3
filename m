Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34614CC896
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiCCWHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiCCWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C9172E75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:06:41 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id k2so6130719oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=r7kKCHWz3Rfv0TQHHwtEWE4mf+UhKdYlq+PNtd3O+F8=;
        b=Z/JYd4+V376HcbtMkvRBhrUgb5bIqQI7F34q31nMVDyB5DKCMuF39gIVI7GHkLnK5z
         xwecd6zPlWqMWR83kkWkOdDZRbFCWNM5KowBFcTzELnIZyrazGRjk+9YjZMMPeCzfSen
         Dc4coFcuRY/XfS2qdlrDgBfiaAjeb+BrfQnDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=r7kKCHWz3Rfv0TQHHwtEWE4mf+UhKdYlq+PNtd3O+F8=;
        b=JFlw1Hm+tbVVMCfNC3Wk+S4kQa99NJ6GNKupVPkq38mJMOOPZ1T7xdtj2LyGTqI8C0
         sbt9xDgBSjrNXX++h9CCyCVnPj1t/pufEMbJGXWvegvEBMzMkjnBMRHUIEmdWLLHgtMz
         QeX7eeIUDlDZupsWp8XCSdif+FlT87Rug7TCS1PqXU7h8G6u8m7YvR+6uddSfKww+v90
         NOQm+zvxSMUZBLDQHk+UaX8Xbs/Egs+fKE98AlK4pWF7rCewFhIBArDrw3kNwtWZ+Zlg
         xE+J5xmKNBBeBu3ybjNSyj1ZV+a+P6ZGgGPJfpI8gZEeR0TiOyI+m/Z1kaF1IRioHR+s
         6y6w==
X-Gm-Message-State: AOAM533idpRttErRDA4HuAi/TaMEG0i+9aQ2FgNTHdKQbuh6gRtweCWh
        XmRvauky38+Dc5Nxt8NBQpo0Z/mGXKbc6m6YN+RQFQ==
X-Google-Smtp-Source: ABdhPJyMZuWL+CCeZIqQWqg/RiahdrvQ8SCiVP/B4EwHgyJoeXa1tCMmS59sHA3zE1RwwWN0mnFkZj+JMSwmHPiUj3g=
X-Received: by 2002:aca:3346:0:b0:2d9:91f9:a7f2 with SMTP id
 z67-20020aca3346000000b002d991f9a7f2mr809414oiz.32.1646345200874; Thu, 03 Mar
 2022 14:06:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 14:06:40 -0800
MIME-Version: 1.0
In-Reply-To: <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com> <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 14:06:40 -0800
Message-ID: <CAE-0n50sRHDaBdKADrqXMR1Dc7s=Stj_eY3Go=VPTTHRHtiUPQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64/dts/qcom/sm8250: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-03-03 01:40:01)
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.
>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.
>
> Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
