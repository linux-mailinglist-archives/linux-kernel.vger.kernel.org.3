Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8740053EB17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiFFMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbiFFMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:54:02 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAB02528F;
        Mon,  6 Jun 2022 05:54:01 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id f7so11846563ilr.5;
        Mon, 06 Jun 2022 05:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=RgW4935QCsAGMmkhuRJMk7RJh1JHfN66O7hxz5zZQuI=;
        b=MQ9RkyQH4F4XbqfJGKSvPTC8yewM8QJbIltZY2E4Yd/Txm1PL4PSKLFTPo4Sl+jAHY
         /bHjZfgDteH++Z478AJrwGo5A3cZ4exh63MwNdZAiH6irEijUqTkfMdjJT4Heq8hebAA
         Z5iucwT98ojpgGPy7YeDDuy0BWOqFFGMzUVfmenFleLaUp1f6VLxCcYD4TzevoYPEA1B
         kCjoBUAIE1xBhgrpTikNM9wSEbAEaJQwdKVIAif3DEK9Gpuab29Z8Zg34Jl4cIJgL+zK
         HR2GVgnAftb35aPKIuYVY7FJhrN/3D3aQAY3NfWQIBCSuS3wWT5qi7nCc5HHKsUtaRVZ
         eswg==
X-Gm-Message-State: AOAM530SNh8HOh0ejdlDR0Qb9mL7xSp5wivZEv67oUAs+zq0FHyu3a2V
        vjRSJ/AfaqSeIQ1lC59eQg==
X-Google-Smtp-Source: ABdhPJx8Ddb/0qM1ktVNbazk8LwdBo/5aLQiFZIdEU/GvqAx//WMhBNcB+l9qZAtxabGJJtIVk9sHQ==
X-Received: by 2002:a05:6e02:1d91:b0:2d3:bef3:a073 with SMTP id h17-20020a056e021d9100b002d3bef3a073mr14231575ila.60.1654520040280;
        Mon, 06 Jun 2022 05:54:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y15-20020a92950f000000b002d3adf71893sm6194943ilh.20.2022.06.06.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 05:53:59 -0700 (PDT)
Received: (nullmailer pid 534473 invoked by uid 1000);
        Mon, 06 Jun 2022 12:53:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, pavel@ucw.cz, nancy.lin@mediatek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de
In-Reply-To: <20220606051131.14182-2-rex-bc.chen@mediatek.com>
References: <20220606051131.14182-1-rex-bc.chen@mediatek.com> <20220606051131.14182-2-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v4 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition for mt8195
Date:   Mon, 06 Jun 2022 07:53:53 -0500
Message-Id: <1654520033.524963.534472.nullmailer@robh.at.kernel.org>
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

On Mon, 06 Jun 2022 13:11:29 +0800, Bo-Chen Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml: properties:compatible: [{'const': 'mediatek,mt8195-vdo1-rdma'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.example.dtb:0:0: /example-0/soc/rdma@1c104000: failed to match any schema with compatible: ['mediatek,mt8195-vdo1-rdma']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

