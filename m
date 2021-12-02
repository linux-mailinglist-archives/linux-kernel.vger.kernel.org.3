Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F89466AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhLBUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:06:40 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38543 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbhLBUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:06:38 -0500
Received: by mail-oi1-f172.google.com with SMTP id r26so1376328oiw.5;
        Thu, 02 Dec 2021 12:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tdFnY4wzmt+MgdOT2Tq5J82thiu5XzZLbDcTwtxSNYk=;
        b=CqSeMDPexP+Eq9nX4P+8phtQxZua0E6a1us2n3o+PbsS97AwiIWXQqm9L73vkR4LPl
         LKKYLzniiyBzQLW+sJKBOZPdNriRhONmv+sTycDz94u4qv8gnaPp/bSYb8GjGAOBnP5o
         jLVsW4h93LyLYdhPVlHo62JlVmfw32mdbSAAhuysDgsvrjjscd7t9XnRrz61L0v1S/AZ
         4zbTMPZxO17bCFdhNyqKY8fHOoV87eLFXpQbiUKt2yVP+wxA1BHiQp+rY05P3kbH+3yR
         D9ttf92WhLcrkJDIcS3oeJjdlACrNQnbrsYP1cWuxwN6pvRGMggHtMZhT0L+0jV9VOPe
         l+Wg==
X-Gm-Message-State: AOAM5339Pfv3ilX+UC4MfNtLpV22DZbEOhPaCuA8io0PgYL/Q+jIJNsm
        c/sYB4ydwKBLkxpFdD03HA==
X-Google-Smtp-Source: ABdhPJy+Vf8yrVBOrncV37VxW9c3c7Y/RAVX3OHOeNP3Xt7D8Nw+7TsHiQ6ZGDEM3eK2Axdz+VoWvQ==
X-Received: by 2002:a05:6808:1a01:: with SMTP id bk1mr6236903oib.46.1638475395629;
        Thu, 02 Dec 2021 12:03:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a5sm203291otd.74.2021.12.02.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 12:03:14 -0800 (PST)
Received: (nullmailer pid 1112575 invoked by uid 1000);
        Thu, 02 Dec 2021 20:03:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, tiwai@suse.com,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        bgoswami@codeaurora.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, swboyd@chromium.org,
        srinivas.kandagatla@linaro.org, agross@kernel.org, perex@perex.cz,
        linux-arm-msm@vger.kernel.org, broonie@kernel.org,
        plai@codeaurora.org, bjorn.andersson@linaro.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        judyhsiao@chromium.org
In-Reply-To: <1638459806-27600-9-git-send-email-srivasam@codeaurora.com>
References: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com> <1638459806-27600-9-git-send-email-srivasam@codeaurora.com>
Subject: Re: [PATCH v7 08/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
Date:   Thu, 02 Dec 2021 14:03:13 -0600
Message-Id: <1638475393.161838.1112574.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 21:13:24 +0530, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Add bindings for sc7280 lpass cpu driver which supports
> audio over i2s based speaker, soundwire based headset, msm dmics
> and HDMI Port.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 70 +++++++++++++++++++---
>  1 file changed, 62 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg-names: ['lpass-hdmiif', 'lpass-lpaif'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupts: [[0, 160, 1], [0, 268, 1]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupt-names: ['lpass-irq-lpaif', 'lpass-irq-hdmi'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: iommus: [[4294967295, 4128, 0], [4294967295, 4146, 0]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1562819

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

