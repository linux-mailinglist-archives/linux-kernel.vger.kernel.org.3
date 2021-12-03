Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D94680B1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354192AbhLCXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbhLCXlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:41:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A37C061751;
        Fri,  3 Dec 2021 15:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBD662D2F;
        Fri,  3 Dec 2021 23:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20828C53FAD;
        Fri,  3 Dec 2021 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638574700;
        bh=ugjl0H7vwIDAKErgbbl0nHdANyCUHl1G37yscnbU5YY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6r9KGXEbceJ0Up6Zpwiczm/NBz1vJdPLKlKmw7rcXBkFMqH0o7YkVaWlccMMdQ6a
         EA8EmX77KnwxPXtzbIqgWoZj9quNOcjXGXGkKawHekDwCarjZmrDto8iz15Vuk/ESB
         +0bS/DWq/epaBlE7NepAatAGNylv/vUrXvDtY2WnWyooZFavy8tXg1I0JwUme/LGTo
         5oPyOKv0ofbANpwqtgiy6E0RoGRdwj93fPnoWHO4nhDibSU6YOhsWctZ4fr1bdsd6m
         1WsA5bnbHOF0TmZueQ6N9q9j1CGZTi9i7OjCJkn2mLcoX87yjzh9xCbyUVE2W4RW1t
         AaymrUsj6eDIA==
Received: by mail-ed1-f49.google.com with SMTP id y12so17397624eda.12;
        Fri, 03 Dec 2021 15:38:20 -0800 (PST)
X-Gm-Message-State: AOAM530pDPA7JGb9NUuPKGvCx87aHGcHacWijv2rFUylzEzd558cuRhN
        FwXmKaaE89wOXQsNtRfOiLvyeT0HCbhvYnd+JA==
X-Google-Smtp-Source: ABdhPJw+XO3cjO5SrZ8n1uXXjNbXhXGWsrFPtegxV4Y0/WHLg25PF4V8x+BXMIt5VKVNdrF0HCq7JUvus1wH1rof8RI=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr26234009ejc.363.1638574698507;
 Fri, 03 Dec 2021 15:38:18 -0800 (PST)
MIME-Version: 1.0
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
 <1638547658-22032-10-git-send-email-srivasam@codeaurora.com> <1638574455.248037.1043006.nullmailer@robh.at.kernel.org>
In-Reply-To: <1638574455.248037.1043006.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 3 Dec 2021 17:38:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
Message-ID: <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     alsa-devel@alsa-project.org, bjorn.andersson@linaro.org,
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

On Fri, Dec 3, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 03 Dec 2021 21:37:37 +0530, Srinivasa Rao Mandadapu wrote:
> > From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> >
> > Add bindings for sc7280 lpass cpu driver which supports
> > audio over i2s based speaker, soundwire based headset, msm dmics
> > and HDMI Port.
> >
> > Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> > Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> > Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> > ---
> >  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 70 +++++++++++++++++++---
> >  1 file changed, 62 insertions(+), 8 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

Are you running the checks before you send out your patches. Because
it seems like you keep sending things with the same errors.

If there's errors, I'm not going to review this. If you need help
getting it to work, then ask.

And what's with your email setup? codeaurora.com bounces.

Rob
