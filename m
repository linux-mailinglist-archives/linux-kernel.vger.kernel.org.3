Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BE4BAC96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbiBQWaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:30:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBQWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:30:05 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E41688D2;
        Thu, 17 Feb 2022 14:29:49 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id c14so1728967ioa.12;
        Thu, 17 Feb 2022 14:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnQZ/XVI2d+Uh+6Ldde6wFLG1VvmeDYtfCvHXu1q1KA=;
        b=VcTKjfvPGwp9Ib+GMbsOwYDfnBFoRn+5xkh+gHQiASvIyGiteu79bIAr+cfowMBogO
         h1JmgYXJs5grYWM4It1MceYfgccydWaIk9b8sfmslpcxAf9LcBAdvY4f+hmf8fjAy+7C
         8ytG1m6giC2CYsbq24+p8L354hcNbBilgifQaOnU5u6GGXKO+8mbajVbicT+Gzi7YiNN
         /dIu3Ql99AG27NWxcz40eFkD+aPI8oRRF/mqQVhcdL9n/w97g7Jm6HYpg2291e2Yy+O6
         yF69CV3UjQ4RZWrqtxhT23Y0MFbr2BV+IxDJA+Ps39tpodlaAJh4A8nAINlxGV8n/3om
         pNEw==
X-Gm-Message-State: AOAM530Zb9ngEh1YLYWSCvEeNWim3ZJ/ogfWZ3v5VjxPWozGG/2EBHv7
        3xbMGU5pgip7LRy/FFvqy7U1KJjy/g==
X-Google-Smtp-Source: ABdhPJz6c9XVOuShkma10QMJfE7I6CAMqH832p+ozhWq/1YE8ugd+LEwcbJGo1US0FEAjcbGGVb3yQ==
X-Received: by 2002:a5d:8898:0:b0:638:d203:d393 with SMTP id d24-20020a5d8898000000b00638d203d393mr3409414ioo.96.1645136989053;
        Thu, 17 Feb 2022 14:29:49 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q14sm2829387iow.1.2022.02.17.14.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:29:48 -0800 (PST)
Received: (nullmailer pid 3884914 invoked by uid 1000);
        Thu, 17 Feb 2022 22:29:46 -0000
Date:   Thu, 17 Feb 2022 16:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Message-ID: <Yg7MWpBeV6c4zgnY@robh.at.kernel.org>
References: <20220217101241.71702-1-cristian.pop@analog.com>
 <1645115995.366904.3365324.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645115995.366904.3365324.nullmailer@robh.at.kernel.org>
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

On Thu, Feb 17, 2022 at 10:39:55AM -0600, Rob Herring wrote:
> On Thu, 17 Feb 2022 12:12:40 +0200, Cristian Pop wrote:
> > Add device tree bindings for the ADMV4420 K band downconverter.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> > changes in v3:
> >  - Fix indentation
> >  - Rename property 'adi,lo-freq-hz' to 'adi,lo-freq-khz'

-khz is not a documented unit suffix. Does neither hz nor mhz not give 
enough resolution and range?

> >  .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: ignoring, error in schema: properties: adi,lo-freq-khz
> Documentation/devicetree/bindings/iio/frequency/adi,admv4420.example.dt.yaml:0:0: /example-0/spi/admv4420@0: failed to match any schema with compatible: ['adi,admv4420']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1594130
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> 
