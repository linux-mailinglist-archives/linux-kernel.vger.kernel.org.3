Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5CF4CCA57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiCCX5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiCCX5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:57:45 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7B177D05
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:56:59 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so7631276oob.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dwS/mMF8qJmYYFw5VmuECBUPxWsibvAI/Ds5lWtd2zw=;
        b=m3CuSnC6oqRK7aLG2h0vxrP4TOLlZDKAr7awdinW0GQ+2rTNU0x8oFNQaIC6BKZDnf
         f7Wd88R/LOLltHPGAnGsC3is2wcwatS1i7hZkbOSbcMdRoALrNUtKXIO6QYyOV/vM8ug
         9RjL+6SkC+yvItdZYFvOoFlcdye7yd/JziLlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dwS/mMF8qJmYYFw5VmuECBUPxWsibvAI/Ds5lWtd2zw=;
        b=UOmJ7w1678OQIH1IDgcCSfUjeoWbyrYJDSKyLVKxAHhzx6Ys0ETbuqvvtASQi9B6fu
         eqqMyUKaILQQlzKYXHYzu3zT6tPkg8muJmKRGUfUaVZyfSpO6Q6eVoPb/bBG79/xzCjp
         ZQJ7vumGXtw5l5YRP0W4UZvdOQ3lJNNbaFj0gt99O9ZaYYO+ugT+fLLM6kOWBarklq7B
         1HHmCboVOQGsMctA9w4apo1U6fgdwwcE7UtDizBoKKSanUElU2vEY1pkO/4HAqofq8Ga
         bFXtpDrS3DqcRBjDDMGJ+maTZ3mGmI7AbQMQsLOCsQIeVtNZTRU7bUQkkEiPyj1pwKZz
         qSzw==
X-Gm-Message-State: AOAM533wK6w/yI76a99QlJXt++e+nAgfqGXWH9Exwq/J28jUz/TIhspD
        BMYZsX4UbCTp9wh5DS5ksRW4p3q3pPhwdaQhChkvQOMOpYc=
X-Google-Smtp-Source: ABdhPJz9sD1I3KbDT/hqOHCp+SihiCCexPpGaQx23kjAJ6wYmV8w9stGqBBZwbhsZ/sDw1S7g/QJrnQLCxhDbWxdoi0=
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id
 gk24-20020a0568703c1800b000d722ed20b0mr6012444oab.32.1646351818426; Thu, 03
 Mar 2022 15:56:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 15:56:58 -0800
MIME-Version: 1.0
In-Reply-To: <CAA8EJpqkK8q7g8q56rfiOO22ykxgycJTpSJKHuhcqGk05nsVzA@mail.gmail.com>
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com> <CAA8EJpqkK8q7g8q56rfiOO22ykxgycJTpSJKHuhcqGk05nsVzA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 15:56:57 -0800
Message-ID: <CAE-0n53jGQcn=NThrrW92NL-cry8yrFErdSYTHHEHWW48b3xbg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64/dts/qcom/sm8250: remove assigned-clock-rate
 property for mdp clk
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-03-03 15:50:50)
> On Thu, 3 Mar 2022 at 12:40, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
> >
> > Kernel clock driver assumes that initial rate is the
> > max rate for that clock and was not allowing it to scale
> > beyond the assigned clock value.
> >
> > Drop the assigned clock rate property and vote on the mdp clock as per
> > calculated value during the usecase.
> >
> > Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
>
> Please remove the Fixes tags from all commits. Otherwise the patches
> might be picked up into earlier kernels, which do not have a patch
> adding a vote on the MDP clock.

What patch is that? The Fixes tag could point to that commit.
