Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BE506C11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiDSMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352059AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595B1C138;
        Tue, 19 Apr 2022 05:12:49 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso5544460otk.10;
        Tue, 19 Apr 2022 05:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YeAeQ+jnrOWAEKYx6yVLIhj6nj1MTrMjb3kCp0yvejM=;
        b=5BnJudefPH60ydU7i0kARXfEtiaio/bBDebFBW0CYjPigyL3KuTpEBI518hO0iMJDm
         R7BG+XQeC5s++0/297h5+JkRuZJMozZw1vCCjrE4/zOMipsRMLyAy52BEXmJCIJdUO7Z
         klYcb+fE5E6gUyhI2DTE8XJ87vYQSQXJNRn9B+0MwCecmMxLZiLQG0Xw2BnmccFcvk55
         yEbYhEPpvXGm7kH6iwcEvWX9QX9yGsoVYVbbMTLxWnpWIOEofkVyb5uKBagiMIXEdaF5
         id9S7aePnug6bI5HY7QDo8RlekMOzltOoVFG+UBeJQpOck/3AYv7DPfjigz98D+W+ENI
         XRKQ==
X-Gm-Message-State: AOAM531alC6T1bpQfCsXl73F9nuurAYgPpDW1qEkBMakCd5towmzAVi4
        h0T4RbO5vBY1wx+NbxhKBA==
X-Google-Smtp-Source: ABdhPJwg4yHDT6X1rpfqMAom9LqkVyPVB09XL0HDMP6yioLKul+fCnEZLuA8Ej0AcX2iP5IaEGiPdQ==
X-Received: by 2002:a9d:1928:0:b0:604:13d5:b114 with SMTP id j40-20020a9d1928000000b0060413d5b114mr5557181ota.6.1650370368668;
        Tue, 19 Apr 2022 05:12:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x2-20020a4a2a42000000b0033a3c4392c3sm2302555oox.26.2022.04.19.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:12:48 -0700 (PDT)
Received: (nullmailer pid 1977870 invoked by uid 1000);
        Tue, 19 Apr 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomba@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Devicetree <devicetree@vger.kernel.org>
In-Reply-To: <20220419070302.16502-2-a-bhatia1@ti.com>
References: <20220419070302.16502-1-a-bhatia1@ti.com> <20220419070302.16502-2-a-bhatia1@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add missing register & interrupt
Date:   Tue, 19 Apr 2022 07:12:43 -0500
Message-Id: <1650370363.583109.1977869.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 12:33:01 +0530, Aradhya Bhatia wrote:
> The DSS IP on the ti-am65x soc supports an additional register space,
> named "common1". Further. the IP services a maximum number of 2
> interrupts.
> 
> Add the missing register space "common1" and the additional interrupt.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/ti/ti,am65x-dss.example.dts:30.17-18 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/display/ti/ti,am65x-dss.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

