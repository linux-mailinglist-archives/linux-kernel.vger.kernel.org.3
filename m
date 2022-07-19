Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4C57A16A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiGSO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiGSO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:26:05 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F442727;
        Tue, 19 Jul 2022 07:11:03 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id z132so11893096iof.0;
        Tue, 19 Jul 2022 07:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Y5OqVVuKuyGM5tSfFefSufSVX//uNjIb8bTox4lv9B4=;
        b=sbVLlffOvKsk9zAPDc5VDE7WHWprmWzqgPNrasC78yRrWgBjQsuv2OMYWrIePeJaKb
         N/Rh5iiG57EtSelIeuoIsYeCsi21iFrHnSbZICper1hli/Lzy1o9kaXWLTZxFaSpCpcL
         icFS/QFChlbncuXuv6zjEsmfo11IKvNArMMpHrjOsFQEIiRRl+5a+386YbB8H7wO0KJ0
         /deaDxgJzzqmOgEu9ZzReQu2QIHDxDDKrVJ9A1MbciIGUCemKQX1IupYK8EqjrRI5Kd2
         5CGEAm5xCYyuJ4w+OsV2AWHdbD+axZx1+92lCl6v6m4z+dH52HjQbtGuVhAfbua2gr7P
         ze5A==
X-Gm-Message-State: AJIora8ODp6IIgg8RB/zQFrLj4bMO/uLtBX7FafsywimdNFKuvFyN0Gc
        CP1wYirq965SNh+TUnOn55skWhWgfg==
X-Google-Smtp-Source: AGRyM1tmPybaNriO5iuTlCMQP3qIIAb3WcIZg9dLpekVyr22JqnJHiC9sY3jNqs/TtBNJeyAOdtU7A==
X-Received: by 2002:a05:6638:264d:b0:33f:5cb4:935f with SMTP id n13-20020a056638264d00b0033f5cb4935fmr16848739jat.98.1658239862483;
        Tue, 19 Jul 2022 07:11:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g16-20020a926b10000000b002dc1f1a7cc2sm5853691ilc.31.2022.07.19.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:11:02 -0700 (PDT)
Received: (nullmailer pid 1153345 invoked by uid 1000);
        Tue, 19 Jul 2022 14:11:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20220718213051.1475108-4-caleb@connolly.tech>
References: <20220718213051.1475108-1-caleb@connolly.tech> <20220718213051.1475108-4-caleb@connolly.tech>
Subject: Re: [PATCH 3/4] dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
Date:   Tue, 19 Jul 2022 08:11:00 -0600
Message-Id: <1658239860.441333.1153344.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 22:30:50 +0100, Caleb Connolly wrote:
> From: Sumit Semwal <sumit.semwal@linaro.org>
> 
> LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> [caleb: convert to yaml]
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../bindings/display/panel/lg,43408.yaml      | 41 +++++++++++++++++++
>  .../display/panel/panel-simple-dsi.yaml       |  2 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/panel/lg,43408.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/panel/lg,43408.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/lg,43408.yaml: duplicate '$id' value 'http://devicetree.org/schemas/display/panel/panel-lvds.yaml#'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

