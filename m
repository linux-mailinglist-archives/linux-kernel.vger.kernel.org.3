Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715658EF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiHJPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiHJPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:11:41 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA876555E;
        Wed, 10 Aug 2022 08:11:40 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y82so5543602iof.7;
        Wed, 10 Aug 2022 08:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=MtwwWFYU1Uoel2FqSmOeukCvUy+Ds67fehOcNXE8e9w=;
        b=5OcVIxy4M7azII0QXUgCZTFqCvBtHElHqlNnsIN6bA3U1bKESkudlC7Zlt30SX1xVj
         SA7jLbwKPYGJ3NKcmazsI8NgSiVKhS3JKf4MJ7YC0jd7nSIPlcJsYE1s/5QMwQ4oHQ0k
         5J5mOJo9/Rtsp4BYCvAEzVdZEkRl2n+xG/PQrdYG4PiKTZoccirRrtaSR0HTD1tVvLf0
         sg++Q9922PEQPG1Sq0Ej9FiQj1QviaM/t9RlAr1xo5vhfpSQ6MxMNOW4tACNU72hjHL2
         pdh32F53bNZgxEDwQ1Q0Aw+RfFQCfv0mSq04P4H/Omlx8Lc6xJwu0x0u77t1YwpRNwTj
         9HpQ==
X-Gm-Message-State: ACgBeo0f2EfGd/MecNVSGnlHsW/7mP3kU/KVvkzbwJhjBRTLWjUeRMWV
        NsHraqOJVneVzF0XxZSMdJjBWn10BQ==
X-Google-Smtp-Source: AA6agR5vrJZdRv+YRIgJJ5Erl93GQ3Lmfstkt/XR693az+1RfFDbqQ8RgIQeE4J/wOYVSqToOFJCbA==
X-Received: by 2002:a05:6638:1386:b0:342:8d69:71c2 with SMTP id w6-20020a056638138600b003428d6971c2mr12471346jad.315.1660144299569;
        Wed, 10 Aug 2022 08:11:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m14-20020a026d0e000000b0034322c00433sm2680940jac.53.2022.08.10.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:11:38 -0700 (PDT)
Received: (nullmailer pid 4155390 invoked by uid 1000);
        Wed, 10 Aug 2022 15:11:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
In-Reply-To: <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp> <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
Subject: Re: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
Date:   Wed, 10 Aug 2022 09:11:36 -0600
Message-Id: <1660144296.251859.4155389.nullmailer@robh.at.kernel.org>
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

On Wed, 10 Aug 2022 22:28:19 +0900, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> Chengelog v2:
> - no change
> 
> Changelog v3:
> - no change
> ---
>  .../bindings/media/toshiba,visconti-viif.yaml | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml:14:111: [warning] line too long (112 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml: properties:port:properties:endpoint:properties:data-lanes:items: 'oneOf' conditional failed, one must be fixed:
	{'minItems': 1, 'maxItems': 4, 'items': [{'const': 1}, {'const': 2}, {'const': 3}, {'const': 4}]} should not be valid under {'required': ['maxItems']}
		hint: "maxItems" is not needed with an "items" list
	{'minItems': 1, 'maxItems': 4, 'items': [{'const': 1}, {'const': 2}, {'const': 3}, {'const': 4}]} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml: ignoring, error in schema: properties: port: properties: endpoint: properties: data-lanes: items
Documentation/devicetree/bindings/media/toshiba,visconti-viif.example.dtb:0:0: /example-0/soc/viif@1c000000: failed to match any schema with compatible: ['toshiba,visconti-viif']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

