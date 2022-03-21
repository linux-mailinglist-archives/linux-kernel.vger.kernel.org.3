Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59484E27C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiCUNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbiCUNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:36:40 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC4045079;
        Mon, 21 Mar 2022 06:35:14 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id k10so4670874oia.0;
        Mon, 21 Mar 2022 06:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9yHBFvAmotgj/IqBA0AuyCu3wDLvOQFxKhwN+eCLBMw=;
        b=VYHizoU0TNVl0J36Szh7Rzmxfm2HXTbTvOqc/5FvWf1/P++WUam1MbJLFUf5GYcABb
         vJysgxU7EPpox/lJvT7zLSTuAadhGfkk+BvCFO5BtylziSeZE/S/m9fCdGAMelPjkDPr
         0tKE9hjMO3kqP9a4rj6ukfL6utqYeRk+9FTywPy7HJXn/Tu7DoFiasOf0Q/TEgLTsbIN
         qGAuX2A2GYbB5jKIScVf6u+nnw+yY7eOaMTqILTBQn2jK8zfG5AR6A1dGykUocwNo7rS
         8H3oKvZq1i52EQ6vRuJlGwxtfhKhGfj0R80t5mg4ZKWxMOLVsw5fNU7ExUKRKR0GmN8o
         um1g==
X-Gm-Message-State: AOAM531ZYTAK/RJhLo6OrMlLlHTrJYkSdDH+E8sFLJm4dnQflzGGOzxr
        vhfSusZNwBaGnhfgMz67nQ==
X-Google-Smtp-Source: ABdhPJw70yBMj/HnL99fXmgwqAbCYFqxmA+8bkEnDSsHVCZzESWK309igckM3Lgg4pHysUWDvWDa1Q==
X-Received: by 2002:a05:6808:28b:b0:2ee:36b8:8619 with SMTP id z11-20020a056808028b00b002ee36b88619mr13273266oic.275.1647869713552;
        Mon, 21 Mar 2022 06:35:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w22-20020acaad16000000b002d9c98e551bsm7255683oie.36.2022.03.21.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:35:12 -0700 (PDT)
Received: (nullmailer pid 4125319 invoked by uid 1000);
        Mon, 21 Mar 2022 13:35:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20220320113430.26076-15-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com> <20220320113430.26076-15-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 14/18] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Mon, 21 Mar 2022 08:35:11 -0500
Message-Id: <1647869711.854036.4125318.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2022 12:34:26 +0100, Ansuel Smith wrote:
> Convert qcom,krait-cc to yaml Documentation.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,krait-cc.example.dt.yaml: clock-controller: clocks: [[4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1607456

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

