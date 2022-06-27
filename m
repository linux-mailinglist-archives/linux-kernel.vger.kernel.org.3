Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26755DEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiF0TMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiF0TMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:12:46 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D75FFD;
        Mon, 27 Jun 2022 12:12:38 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id p69so10553310iod.10;
        Mon, 27 Jun 2022 12:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rBNw7xXQioxzgqOQKpFDuGhIR7glkYA10EWg8sjqgd4=;
        b=GgRYLjvgXk+EiH+QJ8KSHl+VyxMifw6CQSFYEOh7C1JnCUMv7Ig1yAxlWqw3eT07Ur
         P/se4HDRVfgT7vNmQmeRhHZhuK1ZdeVxP2c8Zo43iLp7TQb6PmkeQXuLvbmuxshBD86c
         eqBxWqqKxJbf7iNxXYhnYU70lJkJqp0KC24xR3bL8asgfC69iWl3ZkjgdPEAOr3U13Gq
         WLLnWU4YcvlT1UK9Hz8Sug0tnzVYML9JAZLyf59w79FzuycyT+Ds/ZOvMgU9BzE8sS4E
         bQ9wWuiOef5Rjocw58eYqjmLtCyfmWUWe9PO5Is+qJ6oihrzZaeqxKCytvyxdCRkokoU
         VCZA==
X-Gm-Message-State: AJIora9lbjzUdJvcQv4639QfcKJkv0v19tQt75IFIG2t2JNA0dmvflVG
        dlhk29wqZheK2h7XhRZBIw==
X-Google-Smtp-Source: AGRyM1u2B6Wf8qeEwHG7bcsztdsHikAwGp9sb2uWhc4F9Mv0d1Tnjqyg8TLRYOrF2g2p1n5I0n92IA==
X-Received: by 2002:a05:6638:1686:b0:331:c1ed:9f55 with SMTP id f6-20020a056638168600b00331c1ed9f55mr9142195jat.201.1656357157501;
        Mon, 27 Jun 2022 12:12:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e020d8600b002d90ac862b6sm4876207ilj.55.2022.06.27.12.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:12:36 -0700 (PDT)
Received: (nullmailer pid 2785808 invoked by uid 1000);
        Mon, 27 Jun 2022 19:12:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623193702.817996-3-nfraprado@collabora.com>
References: <20220623193702.817996-1-nfraprado@collabora.com> <20220623193702.817996-3-nfraprado@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: mtk-xhci: Make all clocks required
Date:   Mon, 27 Jun 2022 13:12:35 -0600
Message-Id: <1656357155.295131.2785807.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 15:37:00 -0400, Nícolas F. R. A. Prado wrote:
> All of the clocks listed in the binding are always wired to the XHCI
> controller hardware blocks on all SoCs. The reason some clocks were made
> optional in the binding was to account for the fact that depending on
> the SoC, some of the clocks might be fixed (ie not controlled by
> software).
> 
> Given that the devicetree should represent the hardware, make all clocks
> required in the binding. Subsequent patches will make the DTS changes to
> specify fixed-clocks for the clocks that aren't controllable.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Undid clock list changes that allowed middle clocks to be missing from
>   v1 and made all clocks required instead
> - Rewrote commit message and title
> 
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11271000: usb@11270000:clocks: [[4294967295, 94], [4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11271000: usb@11270000:clock-names: ['sys_ck', 'ref_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11270000: clocks: [[4294967295, 94], [4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11270000: clock-names: ['sys_ck', 'ref_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@112c1000: usb@11270000:clocks: [[4294967295, 94], [4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@112c1000: usb@11270000:clock-names: ['sys_ck', 'ref_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11270000: clocks: [[4294967295, 94], [4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11270000: clock-names: ['sys_ck', 'ref_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11201000: usb@11200000:clocks: [[4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11201000: usb@11200000:clock-names: ['sys_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11200000: clocks: [[4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb: usb@11200000: clock-names: ['sys_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.example.dtb: usb@11270000: clocks: [[4294967295, 94], [4294967295]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.example.dtb: usb@11270000: clock-names: ['sys_ck', 'ref_ck'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

