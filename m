Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDF481CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbhL3OOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbhL3OOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:14:46 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:14:45 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id i130so21735410qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIiHEJXmhVq0VBafG1mogzpPwrmMW4FruUD/NmecsX4=;
        b=v2hIyW3mD6FmJ8nkeft+cv6KuVC1JDxtGiR2QFqmE90D7SaoYnF5CB/FKe3h9JwOyq
         /I6mAjM/ssDxFxSSX7wxbUTseuVA4Zuj4iwEoAV7cdbqCjzZJfa+MvYLfMn2myxyq+cZ
         Cp3qJdFlJth6krKQcCtQLgt17jme53BYOgvsoN5KAyfbvcafNi4bj5ejB3w2TFeyZPMH
         Lgiw4wQZ7QipW3UrHtkF1Sq7x/beho5bu9SjSXqX+s1aAhPJ0ELi3+zd5n7TPHeVHe+N
         4AE4Qlbew+zsjT60mRIGyW2N1jNoGoP8csJbdLLCzlfLR3tEC7SS3GVGbKNYHkZKHHMN
         H03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIiHEJXmhVq0VBafG1mogzpPwrmMW4FruUD/NmecsX4=;
        b=ts5sRUjreqRxihtMElkKMkSJHN/xgs5VR5c1WaNhHHashwdKYxwrhZjFVR1HXi3SfB
         3r5fteydC/2lOln700Fof3VNmoMeIBqSgyD4hJXYxfBB/B3HCDx6XCduovh5YkBgXpeE
         yPHgW/z6hEiJQIj6OofhtDFY535dQjlfyheSQjdw6Tcx0O1yNg8bukcvCmeRCASwMkEq
         x7wvER4OiQvOd+9GdgierwkyMrVuSaBwX64kL9SpEfuJGfzavY4MhLMh8qaN9UVvbzDV
         IgAehf6Lp/iYVXEds/QmBqOImyNWlqpsUXkIQ8LyadbUsGyGzfZX6Z4aONlhX6OCGQDk
         YFeA==
X-Gm-Message-State: AOAM531kZU+IEtiOcK5zl5QEY8GqboOnY0NTz4UbR91zwb6vaLJzt8UL
        MbcsGjGcP/KuQfGyX9VToavxZGE9xTNr4JJWtrtwcQ==
X-Google-Smtp-Source: ABdhPJwiPhF1WQpKvdE8hOeE3MBy5zy9jvFyDBDOF14ZRUSR7yDBFMcY79AZCN5Dj2E2nbfMQHBa9NJGEFhbiHTXthI=
X-Received: by 2002:a37:b8b:: with SMTP id 133mr19734621qkl.59.1640873684877;
 Thu, 30 Dec 2021 06:14:44 -0800 (PST)
MIME-Version: 1.0
References: <1640856276-14697-1-git-send-email-quic_rajeevny@quicinc.com> <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
In-Reply-To: <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Dec 2021 17:14:34 +0300
Message-ID: <CAA8EJppoe8ebU-yNKF6fbuDK4nf=09eNzVvaq_wQ+qKdjWEf4w@mail.gmail.com>
Subject: Re: [v1 1/2] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, airlied@linux.ie, daniel@ffwll.ch,
        swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 at 12:25, Rajeev Nandan <quic_rajeevny@quicinc.com> wrote:
>
> Add 10nm dsi phy tuning properties for phy drive strength and
> phy drive level adjustemnt.
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
> +
>  required:
>    - compatible
>    - reg
> @@ -64,5 +76,12 @@ examples:
>           clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>                    <&rpmhcc RPMH_CXO_CLK>;
>           clock-names = "iface", "ref";
> +
> +         phy-drive-strength-cfg = [00 00
> +                                   00 00
> +                                   00 00
> +                                   00 00
> +                                   00 00];
> +         phy-drive-level-cfg = [59 59 59 59 59];

And second notice. This interface seems to be too register-centric.
You provide register values without any actual way to interpret them.
I'd prefer to have something closer to pinctrl. Specify strength and
level in some logical way and then in the driver interpret that into
register values.

-- 
With best wishes
Dmitry
