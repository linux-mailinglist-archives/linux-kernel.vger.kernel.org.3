Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982452051E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiEITUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiEITUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:20:42 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C473413B8FA;
        Mon,  9 May 2022 12:16:47 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-edeb6c3642so15842537fac.3;
        Mon, 09 May 2022 12:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=J9UHLsCgwlEtwC93yM9iNbxfAUErMfSSi5tgfl2OGhA=;
        b=x4l4b7QYZH/8VG+e8un3hJFaqkzuJYSVh0+KD6z0bqk7/u2fmMA+3I/girlbti7Fyz
         bj8WFIox0ZRPnPXmR/foBaVfCnewv99VHMD/9u+n8O90OXtq4/jKrkY9n/HYPsdAaYOR
         1n1XIpk8OugBVOyiTCHhU3C9NfxeikUws3Vct4bZnCmb8CaF8KWFeRspkQ6ML2lMjf8w
         SfL8Gp6SvJvj4jp9HMclsKhtRCReqXwQmRfDhHrFE2uSmibaerMahNMNgPSIOQt1SDiS
         2cw08xa4T6QGoHgIQsBkiIMgtDYprWHkGFmHA5WPGZmNL7/+nYXLWoFZeyHc+lHvr3d7
         gWEA==
X-Gm-Message-State: AOAM533Rz8fHMu+RjsDU5WSYUvg2nmIi1GeqynmZIZcP6RDd6UrFsTZG
        4bTQSYdDmgQ1vc6dZwnGIg==
X-Google-Smtp-Source: ABdhPJyygcw6TMCxSg9TGmvmJfsyB7vAnz1q+HGku1a2ZCtUU9MEEi3VMOYqBXydfOmx6zjApJz/vA==
X-Received: by 2002:a05:6870:344f:b0:e2:c4c0:86a5 with SMTP id i15-20020a056870344f00b000e2c4c086a5mr8157215oah.189.1652123807049;
        Mon, 09 May 2022 12:16:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be8-20020a056808218800b00325cf57766bsm4720560oib.1.2022.05.09.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 12:16:46 -0700 (PDT)
Received: (nullmailer pid 27400 invoked by uid 1000);
        Mon, 09 May 2022 19:16:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] dt-bindings: clock: stm32mp1: adapt example for "st,stm32mp1-rcc-secure"
Date:   Mon, 09 May 2022 14:16:45 -0500
Message-Id: <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
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

On Mon, 09 May 2022 15:46:58 +0200, Alexandre Torgue wrote:
> For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
> required properties.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts:27.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dtb] Error 1
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

