Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F65695DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiGFXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGFXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:31:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8F2BB3A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:31:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id b23-20020a9d7557000000b00616c7999865so12856372otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=bLBb96h4o+6m7G+7u8bDwIvQ0631/O8eJZaab+T17s0=;
        b=Vd9gt8Urb8w6iPVD/v7g1pifq9NFSRgh2NgsOEiOp86rfRNkozal3BpenJIcvOsru7
         hd/x3zZjpU27fNbXhoBEFjgDh60CtsSYn2xjmDu5QQC5dwSC8XDrgSgUEz872suYRmAm
         rTEei11GOXk7LwwvlTJdb2p04gTABzcIZMz6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=bLBb96h4o+6m7G+7u8bDwIvQ0631/O8eJZaab+T17s0=;
        b=4OfzAB2w8oFKTXm5VKQMsuSxTn98sq1N/FwM4DXj9wbOZlUat7mk+xCGzTUIPVKQFc
         tOcZpCsr1EoRa8eWs1SiW7api22Ds/CH7Y1QFz9I+0p3wIuWe/IkHBgXjd2cZ//bMOzz
         sRHEotMaIn7bWuxZyYmt+zKpsBbbfBJuvISJsCkvp3/29u9gGxxIeLQi/HLr8u1nAPiV
         2BP1ipNEuo7v2T9cEy+RyOg7LFxhRy4bdJiQiQTa+vyHXaX7q4t3oAd9rRC8pI/tGRfO
         LgPy+zAlEAjRPriw/c0Wp7Jx8+3Kv0uHvUEcakMRN/Kb9ZG+W3mnEHmUzcq5wF7nZhy9
         ITXQ==
X-Gm-Message-State: AJIora/fJ8US1MhQAxdr05w34bcVH80JXL5FYypcRjVSm7gSwfSbeSqj
        VbB8/0lG4GAG2+H/cTezSdaa7bvvtvE6oUd+TM7mlg==
X-Google-Smtp-Source: AGRyM1vNuiQwjPxBKLkD9XvgxVOjYM4F2c7Ajdm7Hss8UtcjtIkKw8yz94vtZ+yqZ/p1OH7O2q6wqiiOuLyTQ0m+HQQ=
X-Received: by 2002:a05:6830:d81:b0:616:c424:6f22 with SMTP id
 bv1-20020a0568300d8100b00616c4246f22mr19265666otb.77.1657150265868; Wed, 06
 Jul 2022 16:31:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Jul 2022 19:31:05 -0400
MIME-Version: 1.0
In-Reply-To: <1656690436-15221-1-git-send-email-quic_khsieh@quicinc.com>
References: <1656690436-15221-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Jul 2022 19:31:05 -0400
Message-ID: <CAE-0n50+-FUxLZZRCGr14csROPK=zqEc=kWfyMK_Qo_q_up3tQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dta: qcom: sc7180: delete vdda-1p2 and vdda-0p9
 from mdss_dp
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        dianders@chromium.org, robdclark@gmail.com, robh+dt@kernel.org,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, quic_mkrishn@quicinc.com,
        quic_kalyant@quicinc.coml, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should have 'dts', not 'dta'.

Quoting Kuogee Hsieh (2022-07-01 08:47:16)
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
