Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBC513371
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbiD1MVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiD1MVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:21:18 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED475ADD4A;
        Thu, 28 Apr 2022 05:17:59 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id s131so5149337oie.1;
        Thu, 28 Apr 2022 05:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oqNXD0idBs6+FKIlnsEQo6osQwhhpCXlDbeX0RQIYO0=;
        b=iu0rpz4Linyr/GsGO+6I/ZeaYm/Zp6CjayP+pdLq3C9IRYMVz/+kFPyfutCas+fGzO
         G19mfXw67ioXhkItAwGuK87/p9C6lpyeLakKqmsSEiR132MmI6Q2r8S0qRXaf9pxTf00
         2aoj+LnOX9aR6leQSh1nxL3R6uon7FfuDKPUMGLGH8qwQZ/RbVNOMl5x8Uy+FlrJrc+z
         qI2/v7u1YUfBkuM1S0QuxFVABX8D1ZHgVbj7RMA9QzKBDik8QQ7N4fI5O4RJKDpJeLCe
         WAqS+9qlWiUyJ5+2rQvUGVgwwlsh8cHQ8OIkt/rhPofomhoqGQmD+/7cXzXh0yz6jsGK
         hFjw==
X-Gm-Message-State: AOAM533JI4gUlI7szyARCkdUaw2WK6/ju5KpVXXaF27BLHNLOwiZbrEP
        t17JjZPTa0TDcPkuI8ZGK3pexUDiQg==
X-Google-Smtp-Source: ABdhPJz79Uyli5XuXZ/YbldCnIdSvSISWDE5Fl8O5kQTkx6KQr64F68etKJsVQXHaxzZGCB40WZDIg==
X-Received: by 2002:a05:6808:1589:b0:322:9102:5503 with SMTP id t9-20020a056808158900b0032291025503mr15696224oiw.68.1651148279242;
        Thu, 28 Apr 2022 05:17:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j17-20020a4a92d1000000b0035ea6671d8esm999857ooh.35.2022.04.28.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 05:17:58 -0700 (PDT)
Received: (nullmailer pid 1999481 invoked by uid 1000);
        Thu, 28 Apr 2022 12:17:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        trevor.wu@mediatek.com, broonie@kernel.org, robh+dt@kernel.org,
        aaronyu@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, julianbraha@gmail.com,
        tzungbi@google.com
In-Reply-To: <20220428093355.16172-17-jiaxin.yu@mediatek.com>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com> <20220428093355.16172-17-jiaxin.yu@mediatek.com>
Subject: Re: [v4 16/18] dt-bindings: mediatek: mt8186: add mt8186-mt6366-da7219-max98357 document
Date:   Thu, 28 Apr 2022 07:17:57 -0500
Message-Id: <1651148277.902080.1999480.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:33:53 +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml:30:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml:40:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

