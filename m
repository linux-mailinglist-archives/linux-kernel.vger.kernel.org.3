Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93549332F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351108AbiASCz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:55:57 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41889 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiASCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:55:56 -0500
Received: by mail-oi1-f175.google.com with SMTP id q186so1959745oih.8;
        Tue, 18 Jan 2022 18:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=t3D84s22Oolj32pMqN5T5BSiSx4A49lC82hppCs7CKM=;
        b=IxLcflU1WB9ISc2gx2HLCaZXi2vegdFuCI/LYzqI44FITtQDpVpZ+thk9zTmTMblYy
         olvNM5uS1PVcDl+xvMCnHRp/KBlefHcxu2SKaR1NqO2FzOE4DSIMMcyw2blYdR83YSL6
         eCffDGFq7NjmqY0FI0v1gcigk3B2gQbJlk8/oC7f+R8mDUNzZuxpERN2ZoOSCnJ656KC
         RkpRQ2b038+Ay7WIh/Rmu0yZp0nqkLB3dA7qI1JVvb1XaFo9Md/nhO5HW49qQeVkMDeW
         We8XmAo1zbL0scF2P8i/M5ZAOS08yr1Am2umshTeNd0l6yZS+Mf88KpPTNjcEHnZ777A
         Jd+Q==
X-Gm-Message-State: AOAM533MkUGZTQiKfDhHxbQEI0eSYS0W5xdwFOronWjvukmQwRf7u+EW
        klZVmafafzOGNVCxi/IBVBQoa2glUA==
X-Google-Smtp-Source: ABdhPJxWPk/4JazQRxSmtdjWTlYKgQKtlRmNCjy/io2ffPWcsPP52lezzSlf1MFrIadiGvpm/AWPZg==
X-Received: by 2002:a54:4483:: with SMTP id v3mr1347255oiv.39.1642560956337;
        Tue, 18 Jan 2022 18:55:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s9sm4662965oov.4.2022.01.18.18.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 18:55:55 -0800 (PST)
Received: (nullmailer pid 2537492 invoked by uid 1000);
        Wed, 19 Jan 2022 02:55:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        alyssa@rosenzweig.io, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, kettenis@openbsd.org,
        sven@svenpeter.dev, marcan@marcan.st, devicetree@vger.kernel.org
In-Reply-To: <20220118191839.64086-2-povik+lin@protonmail.com>
References: <20220118191839.64086-1-povik+lin@protonmail.com> <20220118191839.64086-2-povik+lin@protonmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add Apple NCO
Date:   Tue, 18 Jan 2022 20:55:53 -0600
Message-Id: <1642560953.424905.2537491.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 19:21:03 +0000, Martin Povišer wrote:
> The NCO block found on Apple SoCs is a programmable clock generator
> performing fractional division of a high frequency input clock.
> 
> Signed-off-by: Martin Povišer <povik+lin@protonmail.com>
> ---
>  .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/apple,nco.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1581480

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

