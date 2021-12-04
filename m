Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8374686C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385246AbhLDRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDRyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:54:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820BC061751;
        Sat,  4 Dec 2021 09:50:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8D960ED9;
        Sat,  4 Dec 2021 17:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1D4C341C8;
        Sat,  4 Dec 2021 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638640238;
        bh=s+ik63dAmfrjlC/j0Y0a0PtyupdfmbhVwiYFKIQBD8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfAWqiz4EzBFWN0BCXcDb6gYiXLNKL6IoYeJW/pX7OYRu9scMuiJJdoSO/yXl089O
         D1KgvFK+oif16qtUR0rWiihTWEFta3UpKaQSv3i5VUrMjLvE5k+gO2cQpzh74tGDCg
         w29B85Qyeph7glRa6S/indeJ5SrcjSDxb5LoidwzhUDWV1DId9ZpAT0U06GbRdht7/
         8I1FU6rVFawMj3jeVueDI3OsjNbXr6XF6nDwRPGbYBV9US4JzAgFAZGRloE3+zM3OR
         tOE9JohJij1HwkkC21IRGqHBQjpXh8Gqkb9jgOW+KRGaRPXNqDhGLz/NU4SETNuRBo
         s/CVjr1pi4eCw==
Received: by mail-ed1-f50.google.com with SMTP id o20so24955489eds.10;
        Sat, 04 Dec 2021 09:50:38 -0800 (PST)
X-Gm-Message-State: AOAM530uzKsovPP7o7sUglIvc1obeAnZjC+iYOWb3d0Vcs8QLIfjWwr+
        hsWy148JDABUBuTVjq9mwNW8IVVdrm4WKy0lFA==
X-Google-Smtp-Source: ABdhPJyG/uUnEPaVHkUuCxpNDT8h30alMo2zah2d3OzMYnPU6Qi4lwNW4/braAAARZrtS3ljjIUbVvgWJoy1uXJAO0E=
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr36838701edc.197.1638640236433;
 Sat, 04 Dec 2021 09:50:36 -0800 (PST)
MIME-Version: 1.0
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
 <1638547658-22032-10-git-send-email-srivasam@codeaurora.com>
 <1638574455.248037.1043006.nullmailer@robh.at.kernel.org> <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
 <07f5a5f2-cdf5-75de-9635-0edcd5e5c905@codeaurora.org>
In-Reply-To: <07f5a5f2-cdf5-75de-9635-0edcd5e5c905@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 4 Dec 2021 11:50:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgjdeYmwZUcNFQniYn2TR0frSUEVGfpXs00NvOBcBsfw@mail.gmail.com>
Message-ID: <CAL_JsqJgjdeYmwZUcNFQniYn2TR0frSUEVGfpXs00NvOBcBsfw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        alsa-devel@alsa-project.org, bjorn.andersson@linaro.org,
        judyhsiao@chromium.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        agross@kernel.org, plai@codeaurora.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        perex@perex.cz, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        rohitkr@codeaurora.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 1:59 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
>
> On 12/4/2021 5:08 AM, Rob Herring wrote:
> Thanks for your time and notifying the issue!!!
> > On Fri, Dec 3, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
> >> On Fri, 03 Dec 2021 21:37:37 +0530, Srinivasa Rao Mandadapu wrote:
> >>> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> >>>
> >>> Add bindings for sc7280 lpass cpu driver which supports
> >>> audio over i2s based speaker, soundwire based headset, msm dmics
> >>> and HDMI Port.
> >>>
> >>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> >>> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> >>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> >>> ---
> >>>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 70 +++++++++++++++++++---
> >>>   1 file changed, 62 insertions(+), 8 deletions(-)
> >>>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
> >>          From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> > Are you running the checks before you send out your patches. Because
> > it seems like you keep sending things with the same errors.
> >
> > If there's errors, I'm not going to review this. If you need help
> > getting it to work, then ask.
> Actually, the too short name errors are coming for the existing names
> also. could you please suggest on how to go ahead?

Go read Documentation/devicetree/bindings/example-schema.yaml and the
part about default address sizes.

> >
> > And what's with your email setup? codeaurora.com bounces.
>
>  From December 3 Qualcomm mail domain got changed to quicinc.com from
> codeaurora.org.
>
> May be that's the reason for bouncing.

No idea. Just fix it please. I don't think I've seen this problem from
anyone else.

Rob
