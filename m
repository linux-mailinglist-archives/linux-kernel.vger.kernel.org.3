Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39C4AF56A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiBIPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiBIPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:35:18 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247EC05CB88;
        Wed,  9 Feb 2022 07:35:16 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so2878745oov.3;
        Wed, 09 Feb 2022 07:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=H19TdmlGQeOvqWibXwnTgQaKpp298rj11z4re+ZlqzE=;
        b=Qv7Z09fs87ryzqrGn5m7pW0Sdh8/Pkx/Mttyo15ehEc4zQqhRagjUfDYcMVUxJPzCi
         1Rhs/MRAgdGrYM7W3xBvIvovOA/C1QAUkzR2S0xvqpkbLrjFDeUNxYJ8QtdHYQOxshUN
         Cu60nkmabbP+m/GpKlk1gxW5WmTfkKCHRRnbpuMJGjObCgPOcSHspK09/lMPxq6jL5Sr
         iaMBQqhSKP6CrR4s6+P3CTC7Epzn4SBsykM5MgVlZ1+t5A1i97JXVwvKV+yKWZGZcxVK
         Eo7ng9lLmDiLRZYJhUbbbp5FaZhWJBqcU5u+XdmpyxArVWMiRQNVvGxfHyov1mBy8QbI
         ihLg==
X-Gm-Message-State: AOAM530aAfENL16Hp6b/cEw9Cxx3CEghvAOFlG86vbGimfRuAEdbvpu+
        TxXFscG8gD7hRSH0BnCMfg==
X-Google-Smtp-Source: ABdhPJxKdqFqfL7xuc3s+WdsojPu3tY6PLqK4sVB4rB6S59yfpnWW0p0L5BzV9TGDFMjVhphJCSaLg==
X-Received: by 2002:a05:6870:12cc:: with SMTP id 12mr902265oam.215.1644420916147;
        Wed, 09 Feb 2022 07:35:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t2sm6862136ooo.24.2022.02.09.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:35:15 -0800 (PST)
Received: (nullmailer pid 391817 invoked by uid 1000);
        Wed, 09 Feb 2022 15:35:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, perex@perex.cz,
        plai@codeaurora.org, agross@kernel.org, tiwai@suse.com,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com
In-Reply-To: <1644413181-26358-2-git-send-email-quic_srivasam@quicinc.com>
References: <1644413181-26358-1-git-send-email-quic_srivasam@quicinc.com> <1644413181-26358-2-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [RESEND v8 1/3] ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
Date:   Wed, 09 Feb 2022 09:35:08 -0600
Message-Id: <1644420908.409006.391816.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 18:56:19 +0530, Srinivasa Rao Mandadapu wrote:
> Add devicetree bindings documentation file for sc7280 sound card
> registration.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

See https://patchwork.ozlabs.org/patch/1590375

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

