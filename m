Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9552461AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbhK2PgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:36:09 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38746 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbhK2Pdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:33:53 -0500
Received: by mail-ot1-f52.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso26035908ota.5;
        Mon, 29 Nov 2021 07:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IHW21EJJaFsjtKii3QyjjOk6u0tmQm40OqSYo2XVvpY=;
        b=C3/7mZSgXx5Sr5XHVXE7xx+kwuDajcMmv9uItPFL8mX4Xq64esj9lvneqkmnn0unZj
         DvxLzrqvkK5LtM/IACN8n4kbow1MOqotNhSwvmxWwsjvI48EB78Th35mUcnMLW0mX/pq
         tF5zx4aU7uMIWVgZmrxT4FLzDC3+qkFyd8Cig/9ELODVg6+9f35ulIaFnA/QgWCxaV53
         WUuzPY9E7LdWOgczoIw997qltArNzD+PSx0swYhI7vYHtBsolSNBeihUo7hucaTmkrSd
         eiNuMDPEIIFKQqF4C7lPsFXwg0ic6kZY3Dx7ps4EWUwPGwf6ZvOYrsXFVDTaxYk7cpgH
         Rnaw==
X-Gm-Message-State: AOAM531JvlUVt/a7Ig+quckkWib87VP6kTs7zAcgWmA3S1IPdNpZY83S
        h/i/MufCQm6l9ov6Esk18EwkbUqTPA==
X-Google-Smtp-Source: ABdhPJzMxws8aBwkYu5Y4Vyo/5nJjM0G2eN0MOp8LBdPYKE786MgbuyWn3iCd8lQa16GyeQVW+n4xA==
X-Received: by 2002:a05:6830:3195:: with SMTP id p21mr42398254ots.56.1638199834988;
        Mon, 29 Nov 2021 07:30:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e16sm2260820ook.38.2021.11.29.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:30:34 -0800 (PST)
Received: (nullmailer pid 123619 invoked by uid 1000);
        Mon, 29 Nov 2021 15:30:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     ekangupt@qti.qualcomm.com, jeyr@codeaurora.org,
        bkumar@qti.qualcomm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <20211129101931.28154-1-srinivas.kandagatla@linaro.org>
References: <20211129101931.28154-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon, 29 Nov 2021 09:30:31 -0600
Message-Id: <1638199831.140753.123618.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 10:19:30 +0000, Srinivas Kandagatla wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 ----------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dt.yaml:0:0: /example-0/adsp-pil: failed to match any schema with compatible: ['qqcom,msm8996-adsp-pil']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561085

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

