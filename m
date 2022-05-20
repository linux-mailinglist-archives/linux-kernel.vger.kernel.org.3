Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F75152F1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350586AbiETRgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiETRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:36:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4B80227
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:36:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so7926164plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGTJhxGq4NRXnqMsGQiqbCMB+N3bs1Q8cueXx9EoXoc=;
        b=Vdn1Q04weaeDmve1R0VnEbxYbLnsYVgVtMFoJBSb2LnRquGBT8YF9uJ6sT//LxT5Vc
         zr1pqnrJEie4BUL2q5H4wyhHIldR429BTbCdXIrqeFTMlgIPqwsXKeUR3D6iVYelunXM
         PSgBvAL3Da1xW1mEQ2Ip+aDGc26hqOYxUaYYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGTJhxGq4NRXnqMsGQiqbCMB+N3bs1Q8cueXx9EoXoc=;
        b=NzbjruB5Gx9FkQN0AO/FH0VQSsIR4/yWJmAoEJwrL+fQcn0KlIp/pnIKHb0rGD96Ea
         gYJ4xmYW4qxoDmo18XN5r2wMhKg2OZ7yxtvkIOK59ZeptpR1tAWtqzq76yvg0jyI0B8x
         vn0fXaD803HGVKps5NpqpLBg2KxYymLuGylY9GEECMDobuOyWPjt5JG6g6O93o2MxWvJ
         guWZQpuFV3bqfAXti7lJ7jCac2pE9teeuU28eY+YxZVyFix7GcT76Il9gYXFvGo+gE96
         OvKIP+R4zggpjoPf/yA2yPmofrxOV4qq5vYk0m22F4870D6dlwMFLlg3IkJhjP4UpuJs
         tZwQ==
X-Gm-Message-State: AOAM530JE54nTS6gGhQjQ33EFI9iFszjk3GxK3FzXtyvCOp3pXMjE22r
        Mmr+Nh3yKqZ6tqZqkwFi4GZqhw==
X-Google-Smtp-Source: ABdhPJxpuxzegEOsmYqFaMkZd1lrc6b7kou9uzD1zcGtYR43ETtk8hSvIjCQ5rY8JthgeEXXzOmATw==
X-Received: by 2002:a17:903:41c1:b0:161:bec6:b308 with SMTP id u1-20020a17090341c100b00161bec6b308mr11030318ple.161.1653068178945;
        Fri, 20 May 2022 10:36:18 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:5332:2096:60a3:3455])
        by smtp.gmail.com with UTF8SMTPSA id f2-20020a170902f38200b0015e8d4eb24fsm25680ple.153.2022.05.20.10.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 10:36:18 -0700 (PDT)
Date:   Fri, 20 May 2022 10:36:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, cychiang@google.com, judyhsiao@google.com,
        tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 2/3] arm64: dts: qcom: sc7280: Add
 sc7280-herobrine-audio-rt5682.dtsi
Message-ID: <YofRket193lxAg6F@google.com>
References: <20220520161004.1141554-1-judyhsiao@chromium.org>
 <20220520161004.1141554-3-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520161004.1141554-3-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:10:03PM +0000, Judy Hsiao wrote:
> Audio dtsi for sc7280 boards that using rt5682 headset codec:
> 1. Add dt nodes for sound card which use I2S playback and record
>    through rt5682s and I2S playback through max98357a.
> 2. Enable lpass cpu node and add pin control and dai-links.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> new file mode 100644
> index 000000000000..d83e99f1d417
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + * This file defines the common audio settings for the child boards using rt5682 codec.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/ {
> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
> +	sound: sound {

nit: the label might not be needed, unless we expect board files to override
settings. But well, there is also nothing inherently wrong with having it :)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
