Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8261750C2AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiDVWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiDVWTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:19:00 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F319F40A;
        Fri, 22 Apr 2022 14:10:55 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2afb80550so9927047fac.1;
        Fri, 22 Apr 2022 14:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TRqLMDnSfOMMJvwbNg5ERReNlJdUDaY3MArVueheMwI=;
        b=GhYHRpqBvKKO9sr47sI+pTi77FehE9JxaYfyE+nY+wkkIBiiaGJYndwZn6XVLPyIGx
         3RM8ASxcoZk6LGSw6OOI9z6pFToV9OJ+IOA+TAVMyJ6DO2DpCexJxCXtetgHGjgG/P/P
         ZPw/a59OIdcf9K6BDyamVGSImjbzk3CZrBNFXx9pkamXFwEKAFNBIf40x8Va/34gOlzw
         VrBCvQ0G4+V+VZJYCHaezLR09DCHmHNBhdI6NO+Bbu5mXqVK6DxfHblbPDIzw5hckn9P
         dFlzguZErABcuryRHr5ws7cYDNv0uWpwzhHKW0NP2kcb0o881Xttz9YjjgreVm4TtKQH
         HgUw==
X-Gm-Message-State: AOAM530HqPZqGxoAUpuVc7SY9HBPFaxvLs/EeUULLB5KOTT+3Rqd3oJb
        GVbdO6DsobKLBAoLUWj+gg==
X-Google-Smtp-Source: ABdhPJwCauAsquMdMwIxtueLYrwWVUnabgWI6OXGiVbx2Y27f+yF57TQi+4z5TpOQRa/HCe7vuQsXw==
X-Received: by 2002:a05:6870:79a:b0:e9:109a:1391 with SMTP id en26-20020a056870079a00b000e9109a1391mr800216oab.105.1650661855024;
        Fri, 22 Apr 2022 14:10:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf26-20020a056808191a00b00324f4d15aa1sm667603oib.12.2022.04.22.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:54 -0700 (PDT)
Received: (nullmailer pid 2784286 invoked by uid 1000);
        Fri, 22 Apr 2022 21:10:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     icenowy@outlook.com
Cc:     Maxime Ripard <mripard@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-input@vger.kernel.org, Icenowy Zheng <icenowy@sipeed.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org
In-Reply-To:  <BYAPR20MB2472D625C876D97E95CB6078BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
References:  <BYAPR20MB2472D625C876D97E95CB6078BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: sun4i-lradc-keys: add R329 LRADC binding
Date:   Fri, 22 Apr 2022 16:10:47 -0500
Message-Id: <1650661847.262817.2784285.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 00:07:43 +0800, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@sipeed.com>
> 
> R329 has similar LRADC with previous Allwinner SoCs, but with bus clock
> and reset.
> 
> Add binding for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml: then:properties:required: ['clocks', 'resets'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml: ignoring, error in schema: then: properties: required
Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.example.dtb:0:0: /example-0/lradc@1c22800: failed to match any schema with compatible: ['allwinner,sun4i-a10-lradc-keys']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

