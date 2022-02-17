Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579A4BA637
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiBQQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiBQQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:16 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13142B2FFE;
        Thu, 17 Feb 2022 08:40:01 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id w7so4352860ioj.5;
        Thu, 17 Feb 2022 08:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ImFtJ/tr17hOJEhG0RpI04/WvpMzuYJGOCoRC+P1jcU=;
        b=uoZFYlK2lPzGl/GNG4GvLM1NjCiHXFoibz+JougiJOWf3vacG7hCXg66xfi7VIE35U
         zGTNvi09507l1sSM5B2HFRV0Gca9PM+qO2BRhNBhYt7FTcDIjuzv2HE8pNQcBV1FND00
         64CdZT1sFsus9zEUAJTJHkcuv8hU2fm9NEqpEgz3YMPxXbumSKZNDxELSDUC3tLJg1uU
         duvL8eYqOMpU770hL4xCQtLt/gIfoEqSgf0xgGyDn5vzB1n8bmDnw3w7S7kaGEjy54zk
         l3pf0mqJhQhHufMt9wvuRZkVO39N7qv5EyPigkfuCu87UGFMFjmeUvp7bssAC8qr1hH1
         uowQ==
X-Gm-Message-State: AOAM531AQa9HW8m/p2xwS1YKnNdbYt+M/AYO6rSEiZ6FRhrJvNtYQfPo
        RyVnTmmj06EXtcg4DZVdwg==
X-Google-Smtp-Source: ABdhPJxHAw5LycZ1OYewf0GTZlfWxLt30hNfXF/X8mHzJU61uFavkrIgkSk2a0vYVPgrTG8BAsOUEA==
X-Received: by 2002:a6b:6c0e:0:b0:637:7360:c680 with SMTP id a14-20020a6b6c0e000000b006377360c680mr2556409ioh.201.1645116000761;
        Thu, 17 Feb 2022 08:40:00 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j14sm2049211ilc.62.2022.02.17.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:40:00 -0800 (PST)
Received: (nullmailer pid 3365329 invoked by uid 1000);
        Thu, 17 Feb 2022 16:39:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20220217105523.1525122-4-15330273260@189.cn>
References: <20220217105523.1525122-1-15330273260@189.cn> <20220217105523.1525122-4-15330273260@189.cn>
Subject: Re: [PATCH v9 3/4] Documentation/dt: Add descriptions for loongson display controller
Date:   Thu, 17 Feb 2022 10:39:55 -0600
Message-Id: <1645115995.391878.3365328.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Feb 2022 18:55:22 +0800, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
> 
> Add DT documentation for loongson display controller found in
> LS2K1000, LS2K0500, LS7A1000 and LS7A2000.
> 
> v2: DT binding docs and includes should be a separate patch,
>     fix a warnning because of that.
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
./Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml: ignoring, error in schema: properties: interrupts
Error: Documentation/devicetree/bindings/display/loongson/loongson,display-controller.example.dts:22.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/display/loongson/loongson,display-controller.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594138

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

