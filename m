Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419F0473179
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbhLMQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:20:18 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36778 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhLMQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:20:17 -0500
Received: by mail-oi1-f173.google.com with SMTP id t23so23824288oiw.3;
        Mon, 13 Dec 2021 08:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=l6ZLi0PGoBXQBBSQe+jVt6PyRuLOnFoXjb9xaIaFyd8=;
        b=mNcUluL8xrpArS1CghTI+1LulROVJzBrLCSryQi21g1h8bj1oKz4ViWvRLljWktwIa
         PQNIcPNdMdx6nockIGGXzgmG09nYOMon/IgeVQw8+G+rOrEX6t24bqwndPoh5zqEGtKk
         X83oPkXG+ohp71zuq/fFFc8mERuzDldTuPAUTRFfIDXGAharXo7vzuIYN64xvCKbqAHe
         Wa29P2iCwZBEzl3pjKiVjGWDYpb9SrCED7BGpWpRL1dPWuhLO0bc4LNW1Lwl2FcwhuAf
         yDoE7TiQWBHJLHUqiFwlrBVCTKgK1RE+pLZfcitbPKi/YPym5r327OVfIDa9+3gUkR0E
         kocg==
X-Gm-Message-State: AOAM532UXLYWH8NjGns5Ow5kSzPS9MiZV+MzHC6v/yd3LjJW+bgk+2DY
        cy2gDw7aUeVzM/BhMy/n6Q==
X-Google-Smtp-Source: ABdhPJxD5WHxXNNHT+o8W64P92PeYWFg6nzCIiFA7fdbpNK3L3FRy93EXTKDfdFeGxasBHOlryCJpQ==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr28900955oiw.9.1639412416725;
        Mon, 13 Dec 2021 08:20:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e21sm2219792ote.72.2021.12.13.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:20:16 -0800 (PST)
Received: (nullmailer pid 1139463 invoked by uid 1000);
        Mon, 13 Dec 2021 16:20:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20211213072355.4079568-4-hsinyi@chromium.org>
References: <20211213072355.4079568-1-hsinyi@chromium.org> <20211213072355.4079568-4-hsinyi@chromium.org>
Subject: Re: [PATCH 4/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Mon, 13 Dec 2021 10:20:15 -0600
Message-Id: <1639412415.371102.1139462.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 15:23:55 +0800, Hsin-Yi Wang wrote:
> Makomo is known as Lenovo 100e Gen 2 Chromebook.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../devicetree/bindings/arm/mediatek.yaml          | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:31:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'google,makomo-rev4-sku0'}, {'const': 'google,makomo-rev5-sku0'}, {'const': 'google,makomo'}, {'const': 'mediatek,mt8183'}]}] is not of type 'object'
	{'const': 'google,makomo-rev4-sku0'} is not of type 'string'
	{'const': 'google,makomo-rev5-sku0'} is not of type 'string'
	{'const': 'google,makomo'} is not of type 'string'
	{'const': 'mediatek,mt8183'} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:32:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'google,makomo-rev4-sku1'}, {'const': 'google,makomo-rev5-sku1'}, {'const': 'google,makomo'}, {'const': 'mediatek,mt8183'}]}] is not of type 'object'
	{'const': 'google,makomo-rev4-sku1'} is not of type 'string'
	{'const': 'google,makomo-rev5-sku1'} is not of type 'string'
	{'const': 'google,makomo'} is not of type 'string'
	{'const': 'mediatek,mt8183'} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek.yaml: ignoring, error in schema: properties: compatible: oneOf: 31: items
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/mediatek.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1567163

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

