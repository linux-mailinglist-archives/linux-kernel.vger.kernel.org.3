Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F74EACAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiC2LwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiC2LwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:52:18 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325982498B3;
        Tue, 29 Mar 2022 04:50:34 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-df0940c4eeso4936687fac.8;
        Tue, 29 Mar 2022 04:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Asq1gr+EClGnhk914HvUDEJ2f/aYCxusbmU0iqu5d+k=;
        b=HqhSYR9OX1Ehho2Qd7PCbmuzFOoJl0ac/fHCruq6yEijuG6a+Spdkc9EoVqOgzphOn
         5VMN57OQz8D9hnXcR36RvLo6X+uIE5AiR+Rq+7caplXoZ1iA/XA0+PA44FJC969IKCLA
         ZX8nqDdOjj7Ouv7uENaVxSUQcw40DYftOHza3UUANX/p4oRd4npyhOya1GaPkI+ZInla
         iBSd0ysm3dmwKyFowG4B8+UmXDl//AHWQlx56sbceKo7glWvPx7iUuqpF8ujs85tMpBB
         hJtQ05IksBpQP4x4m52J8Wbk/u2HDqRN5+gRemA8e0JwsFfEsUUXSxu7rcGw0DFgTyOJ
         sJzw==
X-Gm-Message-State: AOAM531dB+vbGxVnzBDT3q1bMVWLDx013++iICRCHtOzv4578zPpDiwR
        F43maePF/YPTQf6Q2Zj8WA==
X-Google-Smtp-Source: ABdhPJwhXc/RcfACLDL7HBgskD+zZRsxdYTdp0owC7QOUhyQPnfvmfacgZDo4zTnaIfsjFP54TlaFQ==
X-Received: by 2002:a05:6870:8327:b0:d7:8685:5129 with SMTP id p39-20020a056870832700b000d786855129mr1861270oae.75.1648554633457;
        Tue, 29 Mar 2022 04:50:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fz16-20020a056870ed9000b000dde87bcdfdsm7911413oab.53.2022.03.29.04.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:50:32 -0700 (PDT)
Received: (nullmailer pid 350366 invoked by uid 1000);
        Tue, 29 Mar 2022 11:50:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, amitk@kernel.org,
        krzysztof.kozlowski@canonical.com, lh.kuo@sunplus.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org, wells.lu@sunplus.com
In-Reply-To: <5c3d0ab5baa9126b544a8f54ac5c773269ee1944.1648531197.git.lhjeff911@gmail.com>
References: <cover.1648531197.git.lhjeff911@gmail.com> <5c3d0ab5baa9126b544a8f54ac5c773269ee1944.1648531197.git.lhjeff911@gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Date:   Tue, 29 Mar 2022 06:50:29 -0500
Message-Id: <1648554629.886096.350365.nullmailer@robh.at.kernel.org>
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

On Tue, 29 Mar 2022 13:24:32 +0800, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v6:
>  - Modify yaml file.
>  - Addressed comments from Mr. Krzysztof Kozlowski
> 
>  .../bindings/thermal/sunplus-thermal.yaml          | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/thermal/sunplus-thermal.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1610480

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

