Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C0468098
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383530AbhLCXhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:37:55 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:35705 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383487AbhLCXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:50 -0500
Received: by mail-oi1-f172.google.com with SMTP id m6so8846755oim.2;
        Fri, 03 Dec 2021 15:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=slc3RtjWJ70IyFjnYg6xCGKvBvcnCTAMFh09lWbkjek=;
        b=jd15mJlfGqJS5iEgzAP2amStzUumOMhMPv8mxMCEflbtoKu/qgpnXY/dA6I4fMPVRc
         xpSo+6x5NQj+9rei3atLcea34xRXtWC+FnhFcipHBRgUOOBYNJn+A4zIe8P98iH59nVQ
         1Ctv0fRHW/+f2JQRFwjp/yA7M04TMQyK7E0T6YDqrdAHzlUwtQnWWgtHNjx+FzbYYobS
         4LGVuQvbxyqwpzAH7m3sfcwWYygkADIKb0bBSo46we4t2LBwThO7wwEy+eTK4tzR8m5t
         dnFySZxxUXisOB+ymYsfqXNIqgklGebjTvHX66aweSFPNadefUFXQdq6fpIQnlNiuXOc
         AH0w==
X-Gm-Message-State: AOAM5323iWHzdhgfK78zMlBxQFLhChbDHYyzVLQjxFFF5cBj723wzLuJ
        HViGLC4OMZ+P04pLOjyoew==
X-Google-Smtp-Source: ABdhPJyBqKs2RECYaJ9RF6QpjpusBKfo+tfpB2ONa7QgO/1CXxO3kC9NItNo8IWqQhVntJqv6sGJxg==
X-Received: by 2002:aca:180c:: with SMTP id h12mr12700584oih.138.1638574465907;
        Fri, 03 Dec 2021 15:34:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e16sm869290ook.38.2021.12.03.15.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:25 -0800 (PST)
Received: (nullmailer pid 1043009 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     judyhsiao@chromium.org, bjorn.andersson@linaro.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        tiwai@suse.com, swboyd@chromium.org, agross@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org
In-Reply-To: <1638551345-24979-2-git-send-email-srivasam@codeaurora.com>
References: <1638551345-24979-1-git-send-email-srivasam@codeaurora.com> <1638551345-24979-2-git-send-email-srivasam@codeaurora.com>
Subject: Re: [PATCH v8 1/3] ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.258949.1043008.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 22:39:03 +0530, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Add devicetree bindings documentation file for sc7280 sound card
> registration.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  .../bindings/sound/google,sc7280-herobrine.yaml    | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@0: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@1: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@2: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@3: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@5: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563335

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

