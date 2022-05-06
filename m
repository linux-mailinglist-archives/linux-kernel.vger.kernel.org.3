Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7079D51DAFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbiEFOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442466AbiEFOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:48:43 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169C6D190
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:44:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j12so2769837oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=IrGhAf8TvV1+E9bi9/Ma/MzKkcxs8bjSiuW7AdbHj10=;
        b=iyFoKvTrfpRKCBsXUXUX+C1h00muFmucmok8yVCJR7FsfzWPAtT5MxIzagEWZb83nl
         AR+nfua6Qz2yFVqt9zrMsk31BjNIccsX72OMNxmRB5cSvBehcgklvdBT0ljZT6HNswev
         Y4WGg7HupVphEebL1yOpay6NGtvZiJUiuTIWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=IrGhAf8TvV1+E9bi9/Ma/MzKkcxs8bjSiuW7AdbHj10=;
        b=HVbGb4hpZNiXbmENRNYv717NqbIA9D3WDwRrk2QKzIkkNoBn+XcvncFcFL/gAJLh5Q
         MOlVPEisEoM1petV+xmiSIo383mvPO+/qtQr6b2NDy+7dolF5lTdJGk+7DbYwgUa0xCo
         vjClQwyrIWVI3PNrOrfF9FcHIZx3COEUjbImYJr2QX6T0nHgLKuj/YGvZDMiRjzGhEjl
         eTyKBr/gKy55vwHNcI5bf0bYMpLTbVFEvXai7eVFwAkRWlk7qCKZbqo1msG5cn+CA/T8
         gsgi0aTZlTQo0xSOjZ5fgQWrb10x8DcLhPy/PlZkEY4BEJ7wg9T8djv6HP2WUEur0nOA
         mZvQ==
X-Gm-Message-State: AOAM5322+JNETruh9IBKzfykv5a1+yDMqJ9hW6xWkachcAXjs+flfxR/
        0MBIB/NIGQhhKKrTc4pHMezPa22mldtetnuWxHiNmw==
X-Google-Smtp-Source: ABdhPJw7bQwzWzC9sS1y3njKBFmnz4Z0mL3MD1dU1YjYy+cB1RCpKFRBcWRleK/TbJ1nK5YF+oPuRJkx0FfFsttPfG0=
X-Received: by 2002:a05:6808:23ce:b0:326:6698:c271 with SMTP id
 bq14-20020a05680823ce00b003266698c271mr1558571oib.193.1651848287287; Fri, 06
 May 2022 07:44:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:44:46 -0400
MIME-Version: 1.0
In-Reply-To: <1651742739-12338-10-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com> <1651742739-12338-10-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:44:46 -0400
Message-ID: <CAE-0n50ZetEPdNxm+VvLD-Fja_TNTYC=ig9E-eAV0GEdhqybsg@mail.gmail.com>
Subject: Re: [PATCH V11 9/9] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-05 02:25:39)
> Add pm8008 infra and regulators support for sc7280 idp.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
