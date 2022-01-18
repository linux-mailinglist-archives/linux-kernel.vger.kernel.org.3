Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1C491370
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiARBc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:32:58 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38790 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiARBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:32:53 -0500
Received: by mail-ot1-f46.google.com with SMTP id g1-20020a9d6481000000b00592d01f2b6eso18162960otl.5;
        Mon, 17 Jan 2022 17:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oEIoapL8xzQ/CNjfq2UGe67vWBp5fLU9YTddyRNF7D4=;
        b=GNfQplyF1rLc8HJLS/qQAdEJqtOomWbdk5Cbhq1JqmFXgO6bnVlUFvwuPH3TI2ilcF
         YtZZ4p/0DERPNY/15DTrKnvihPuO+eLf6tpeR8fMYk/hvk3DIJ87awwKALLKC+flnnEc
         UnDL5T+4a2KGc6sm0jfh3caanWCw4OtO4Fp4KCKke6ykk5xe5TTNkgYkD2W2Pleo2kgE
         92Lsx1oyastJEIjsgbNtfgEKhOjvpq32D2hl36H1zByI9oqIKfcQ4c4shvbS83HeXHgy
         AIXGH+oWnwZ7SNbbaRYCkBk8t92sgt3opOA4wQtUQtufG8o8XeMe9ubmJui/5ukf7nAB
         lF9w==
X-Gm-Message-State: AOAM531X/7gPi+TO+YVR7OFVwAtGM22BmiYbh25Nn5qnCSIelB11N4T6
        qUpIHWlrQIgoGt5eWP0hrA==
X-Google-Smtp-Source: ABdhPJxOcSm7CNH2As9w3aynJ/Eeqk3Ioa3pKfpotJB614dy5Nud1iEbQPEcyuCYuwFps9Ymm1QLMQ==
X-Received: by 2002:a9d:4106:: with SMTP id o6mr11937606ote.139.1642469573136;
        Mon, 17 Jan 2022 17:32:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c26sm6300180otr.65.2022.01.17.17.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:32:52 -0800 (PST)
Received: (nullmailer pid 545747 invoked by uid 1000);
        Tue, 18 Jan 2022 01:32:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220117165247.15718-1-cristian.pop@analog.com>
References: <20220117165247.15718-1-cristian.pop@analog.com>
Subject: Re: [PATCH v1 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Mon, 17 Jan 2022 19:32:47 -0600
Message-Id: <1642469567.789557.545746.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 18:52:46 +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml:10:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml:36:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml:42:1: [warning] wrong indentation: expected 2 but found 0 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1580930

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

