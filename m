Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6C540225
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiFGPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiFGPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:11:24 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D387C0442;
        Tue,  7 Jun 2022 08:11:23 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id y17so14424450ilj.11;
        Tue, 07 Jun 2022 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZvply317AePPx+C+0gJXDyN0OP2009ot+8UwJNT7lc=;
        b=FTcRX9ipSHK/ojC+7ruR8nyN0QIL3q0nFud0/9lsp+ucrid7EPvBTVpAvdvtIncq20
         8zJ1cWmGnYN7GoW6s3oBSp5A9YOHzfjom+JrvN8Ep9m7bUhpb0TCNABkJbVCWZqb6svA
         AteiultwzoN6WUWwSfBQqbVmu7dnsymNPbyjgKYxw8iT1hcSKE2bvyAo2V2nzHgJW33I
         E/pNvaEY3ErJOtYNwEYJ48yg3bzojU37OK5ODE+/Q93aauc9TPJfYDYGArMJSknnvwM8
         08eoT3/DFA+8ZzFE2CZSMhAXylvD0sAF+gs2j5VQukr42FubwiWSwLL409x/BSgDLLGD
         MixQ==
X-Gm-Message-State: AOAM530p/pUha+4OY94eNk8OCCsy+7ypZvDXRB5q4IjUo5FSKBEhFEkB
        XG2tuKREx8IWOcKEeRHMAQ==
X-Google-Smtp-Source: ABdhPJx/aj8OkTZ5sZWk9M29SQS/0eDgBTSzLYMt1Sjvv9q41ldddqHu8JdQx/N4vjM5hJPYMOdyQg==
X-Received: by 2002:a05:6e02:164b:b0:2d3:ccea:ff38 with SMTP id v11-20020a056e02164b00b002d3cceaff38mr16702955ilu.37.1654614682299;
        Tue, 07 Jun 2022 08:11:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b14-20020a05663805ae00b00331d98c9a7fsm409601jar.40.2022.06.07.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:11:21 -0700 (PDT)
Received: (nullmailer pid 3258163 invoked by uid 1000);
        Tue, 07 Jun 2022 15:11:19 -0000
Date:   Tue, 7 Jun 2022 09:11:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        Nancy Lin =?utf-8?B?KOael+aso+ieoik=?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: Re: [RESEND v4 1/3] dt-bindings: mediatek: add vdosys1 RDMA
 definition for mt8195
Message-ID: <20220607151119.GA3254370-robh@kernel.org>
References: <20220606051131.14182-1-rex-bc.chen@mediatek.com>
 <20220606051131.14182-2-rex-bc.chen@mediatek.com>
 <1654520033.524963.534472.nullmailer@robh.at.kernel.org>
 <8598b46381861bd36008cc87599c73863cb4b98e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8598b46381861bd36008cc87599c73863cb4b98e.camel@mediatek.com>
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

On Mon, Jun 06, 2022 at 09:30:42PM +0800, Rex-BC Chen wrote:
> On Mon, 2022-06-06 at 20:53 +0800, Rob Herring wrote:
> > On Mon, 06 Jun 2022 13:11:29 +0800, Bo-Chen Chen wrote:
> > > From: "Nancy.Lin" <nancy.lin@mediatek.com>
> > > 
> > > Add vdosys1 RDMA definition.
> > > 
> > > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Tested-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88
> > > +++++++++++++++++++
> > >  1 file changed, 88 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > > rdma.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m
> > dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/display/mediatek/mediatek,md
> > p-rdma.yaml: properties:compatible: [{'const': 'mediatek,mt8195-vdo1-
> > rdma'}] is not of type 'object', 'boolean'
> > 	from schema $id: 
> > https://urldefense.com/v3/__http://json-schema.org/draft-07/schema*__;Iw!!CTRNKA9wMg0ARbw!3hhZrSKSWnCN5Bha9laiHlB5JCx9_p-ksaYDZmoCLQRi1tI4KJCcTJQva2vds3j3bwKF$
> >  
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/display/mediatek/mediatek,md
> > p-rdma.yaml: ignoring, error in schema: properties: compatible
> > Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > rdma.example.dtb:0:0: /example-0/soc/rdma@1c104000: failed to match
> > any schema with compatible: ['mediatek,mt8195-vdo1-rdma']
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a
> > patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up
> > to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> Hello Rob,
> 
> We found that if we write this, and the error will disapear:
>  properties:
>    compatible:
> -    - const: mediatek,mt8195-vdo1-rdma
> +    items:
> +      - const: mediatek,mt8195-vdo1-rdma
> 
> But from Krzysztof's review[1], he adviced us to drop items.
> 
> Is there any suggsetion for this error or do we have any
> misunderstanding?

The '-' is important.

compatible:
  const: mediatek,mt8195-vdo1-rdma
