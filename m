Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE5D485E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiAFCHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344590AbiAFCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:07:12 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79420C061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:07:12 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j185so1690688oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=N8EyGGSmrvvI6zU1aQmKy8o54cZnNfEr69UiGzAV5Xg=;
        b=NxFVhNfzmEq5RCDmuy44ry2eINp5RIBA/UI9lnUXVtNeRh1g4inZSBQgJsaOiHkpuZ
         M8H0h59pBbxHadQ2QoWie5KzIFcXOp4pq8Fe+9w4RMK8jtEGvk+ZQ+f64XTDbv5wcr+Q
         op3ubfY18FPsSkmWAWki/KrbF3BFhxuvFOAu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=N8EyGGSmrvvI6zU1aQmKy8o54cZnNfEr69UiGzAV5Xg=;
        b=2yGjTj+Qlb2LgRv6Jq69JsTlugW/G893mNG1F90gv9NsA03ekLFz8Q88ZB5zifzP+H
         zzYO5vpfiQVf9TrEHBvQK3RrzDWe5DNSZycO7VRzqagZwOMZ+plh8IBvEYo/7Pu2j3Ka
         q+qE4vbktmsYq/bcpmdNiN6F/nDQ1XC1fZ8mM/KYwwz0ZfxrLq3+bD7SPp/lGotHAWfy
         6jrXKe444JrDIM6fbk8HAWeuWRqeYzCsfjWyNp1AIg3sDj09uf83kjLPFZ5GbUVYiGrC
         eRgg8977OOD7X1xxRHyoeMCv8C4+q3P60GdVWa/qdHsGtU5aOQKSt6SoSn4gaUP/hiK9
         3qUg==
X-Gm-Message-State: AOAM530Oqr91SHW5u40gw501nBndieT7G4MShBvwLYXdsAB1vB6NJYT8
        BSURpShVToDysjbiwYSoWJDJGLc/68Kf+omFlj+Gfw==
X-Google-Smtp-Source: ABdhPJwMibIsFOJg1O7S6ixK9lYcwLkrgBiGvGU8C/v/R7joI0S4Kl3kddaxfXVhULAlQHivvDuZi7OlcYqOesAmHjQ=
X-Received: by 2002:aca:a953:: with SMTP id s80mr4711191oie.164.1641434831728;
 Wed, 05 Jan 2022 18:07:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jan 2022 18:07:11 -0800
MIME-Version: 1.0
In-Reply-To: <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
References: <1640856276-14697-1-git-send-email-quic_rajeevny@quicinc.com> <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 5 Jan 2022 18:07:11 -0800
Message-ID: <CAE-0n52xCvmFe4O9LfoHe7zSaWGH2dF2GGhROr60tb-DV=V8Sg@mail.gmail.com>
Subject: Re: [v1 1/2] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajeev Nandan (2021-12-30 01:24:35)
> Add 10nm dsi phy tuning properties for phy drive strength and
> phy drive level adjustemnt.

s/adjustemnt/adjustment/

Please add the details about parasitics and eye shape tuning to this
commit text.

>
> Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
> ---
>  .../devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> index 4399715..9406982 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> @@ -35,6 +35,18 @@ properties:
>        Connected to DSI0_MIPI_DSI_PLL_VDDA0P9 pin for sc7180 target and
>        connected to VDDA_MIPI_DSI_0_PLL_0P9 pin for sdm845 target
>
> +  phy-drive-strength-cfg:
> +    type: array
> +    description:
> +      Register values of DSIPHY_RESCODE_OFFSET_TOP and DSIPHY_RESCODE_OFFSET_BOT
> +      for all five lanes to adjust the phy drive strength.
> +
> +  phy-drive-level-cfg:
> +    type: array
> +    description:
> +      Register values of DSIPHY_RESCODE_OFFSET_TOP for all five lanes to adjust
> +      phy drive level/amplitude.

It would be better to put human understandable values into DT here. This
looks like a black box to anyone outside of qcom, so they won't know how
to tune or set these register values.

At least for phy-drive-level-cfg it sounds like it could be some sort of
property that is a u32 array of 5 elements for each lane indicating some
sort of amplitude, i.e.

	phy-max-amplitudes = <0 1 2 3 4>;
	phy-min-amplitudes = <0 1 2 3 4>;

where each index corresponds to a particular lane. Then the driver can
parse the amplitude and convert it into some sort of register value.
