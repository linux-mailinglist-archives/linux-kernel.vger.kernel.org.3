Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3046F549
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhLIU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:59:36 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43902 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhLIU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:59:35 -0500
Received: by mail-ot1-f46.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so7514427otu.10;
        Thu, 09 Dec 2021 12:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UGHddj+fTMSPCf5h9ElwKaz36LUbyEjOeDU7AiQrxew=;
        b=A3N17UfPBhHpFnN8GKFYzfszM5PdOw/V1DoX1b+F9feIawMufiik7H6icszq13wldI
         NdNFNNqTALy54E7ArycMvFs8GE++bRn9uLYmf/A/byxJhwwj+2SXcoGm5Vwn4J4IVUmP
         L1EB8gO4G8cy+njwfaysGPis22wm4VCQwmNaKWvbz8A2ivPOwkK7W7PhZa51dFxf5BdJ
         m7oP9851G2fs8um2ZvK/R+7h+hWtxpx0kjMVEavKB0HRwqbhh6I1kq06K1isCiu4WGVz
         hnQc5HQ6Q+aGax3uKQkmkOuV6od7t75mfZGoIf+p+DUz2KCAm8LeAJB8aahsJybH1PcG
         PCYQ==
X-Gm-Message-State: AOAM530+1QFGL+xB3CeZvd3lZa8HSpQgqRvyJnm/UBXDONzB2HIGlTSA
        DVebf2RlvF8w6WylsqWUyGFpQB3Uow==
X-Google-Smtp-Source: ABdhPJxBxB2TnQi+NkjobCQwu4jg+eWB3a+XHkZE/sSaPZ2eUvxCNhhDrHRpeaKzAkX3nBtbTK89Fw==
X-Received: by 2002:a05:6830:2053:: with SMTP id f19mr7352299otp.295.1639083361383;
        Thu, 09 Dec 2021 12:56:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m22sm216445ooj.8.2021.12.09.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:56:00 -0800 (PST)
Received: (nullmailer pid 3925939 invoked by uid 1000);
        Thu, 09 Dec 2021 20:55:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     sboyd@kernel.org, u.kleine-koenig@pengutronix.de,
        masneyb@onstation.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, lee.jones@linaro.org,
        linus.walleij@linaro.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209162020.105255-2-nikita@trvn.ru>
References: <20211209162020.105255-1-nikita@trvn.ru> <20211209162020.105255-2-nikita@trvn.ru>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Thu, 09 Dec 2021 14:55:59 -0600
Message-Id: <1639083359.641868.3925938.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 21:20:19 +0500, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pwm/clk-pwm.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/clk-pwm.example.dt.yaml: pwm-flash: $nodename:0: 'pwm-flash' does not match '^pwm(@.*|-[0-9a-f])*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/clk-pwm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1565817

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

