Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11148E409
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiANGIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiANGIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:08:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F2C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:08:17 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso8990004otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=K4p5fqUDkXH1ATZQd2cSahMZ7ElmoT3wb+zGFFFvjXY=;
        b=fQQ7OHtYEd12KQp6LdWt6b2dKIV2H1dB4IRu648jqxy2ZRSoHPjrc24kOoPpp3TpbP
         3vLuF2ngNJKgnwCNjlY2qLBob2s43Ots2e/KyD9RtlQuanD/hJqZzrMwtWRkZ8QQJzq1
         +5s58jiMlPBZND4ELMykYJ4ZfoUPURYw729yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=K4p5fqUDkXH1ATZQd2cSahMZ7ElmoT3wb+zGFFFvjXY=;
        b=svMGjc8YGXwUH5baY9QpoZJSGATaHOimTgnHzjFtGnjCeohpYdv3cV5dfh9WrvdagR
         PJfSmxxC00bQFY8n/CjFe1hl9EeMx3kE1+LxpT1AfKkUox5CxGRRN/r2wS8EAe5wDvMG
         ipZONbOjK7CpnlkcB7WD6htk0ethOVJPeAQcNGzG167ikwn663LxhBDifdyYr78CMEqX
         5Mm8glSOYF7qgPOemHdFPhxrxrGU9XAXYMJ16oe3eJ9tA/1h9jrz0/le9m/Zl1nWXJMo
         CScaXzwZ3cA3vAoant59chcU3FqY7F4mBQbN918lyp3jaEvUF9lUxqSrjcLFpnrlGtj8
         E8yQ==
X-Gm-Message-State: AOAM533BpOdE95HxoKSnrXteHqMw+D/fWbti4Kch7kRXnhlcUht/kTs5
        GI9McAys/3Eo4btN3ciYDP3FY08EFOThO0L+4VTuFA==
X-Google-Smtp-Source: ABdhPJzDfPw43c+GugW1jZY1RjzaNveoHNFQ/lVRUmmopat5KQaPTt8XtQ5a2FikuYK0q6YMDK7GEUS+iNWmsvy56y0=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr5551097otk.159.1642140496433;
 Thu, 13 Jan 2022 22:08:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Jan 2022 22:08:16 -0800
MIME-Version: 1.0
In-Reply-To: <20220113164233.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid>
References: <20220114004303.905808-1-dianders@chromium.org> <20220113164233.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 13 Jan 2022 22:08:16 -0800
Message-ID: <CAE-0n50N=vFC3wpPh7O6eqWMNyT8n-Q0ssU+CkgJH2DY7T6SoQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7280: Fix gmu unit address
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     quic_rjendra@quicinc.com, sibis@codeaurora.org,
        kgodara1@codeaurora.org, mka@chromium.org, pmaliset@codeaurora.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-01-13 16:43:00)
> When processing sc7280 device trees, I can see:
>
>   Warning (simple_bus_reg): /soc@0/gmu@3d69000:
>     simple-bus unit address format error, expected "3d6a000"
>
> There's a clear typo in the node name. Fix it.
>
> Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

BTW, gmu isn't a "standard" node name so might be worth replacing that
with something else but I have no idea what. Maybe "firmware" or
"power-controller"?
