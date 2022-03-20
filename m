Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B514E1D66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbiCTSW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbiCTSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:22:56 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7F4B2461;
        Sun, 20 Mar 2022 11:21:33 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id g8so10373641qke.2;
        Sun, 20 Mar 2022 11:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPdW0uQBICw2w2s6z7oX0GuZ2TK0AjcRKwcp07VDTDw=;
        b=E6z3VV4bxe5/39iTC4mTV3w4kqrrbRU8xDbR+BKTCN3jO4POy/JwETfcrgLiwVIXAc
         rpOyTnnwHdSAp0gfXAGyhj6luvqlJR4yC8ock5s8dOEMB/2jzgZANa1GjGqcWZQHpsxq
         WpwvqIrrSJt8s0O3ObF2n9yKSomYCUVLHrwh/qvkJZ1xEr1qS53iE0uASCGk/1xdmqtW
         j+MoWscgtI/Zmoy7tMo47Fh+wZpAFgtyDIXM5JtOUMvuOEbE8CgrWkE7g7fEUvQpNdyo
         seQqukyUnr+1jU9rbdoeAnGtKJ3esJ2NlKdlIO8Nme8y7MlX0mMzfmfoI0Kn1pb2As8b
         wOXg==
X-Gm-Message-State: AOAM533PJNA7SoklXp76C6nA/Q0S7jUuS+9l+phLizD/l+8ZoO8h6bgC
        IACk81mo5YSfyT6H5IF9EQ==
X-Google-Smtp-Source: ABdhPJzm2Wq9gtCCw6Qe4aAHLbmv/3ntFY0cGl2S5wwgMTsq9ONra4LkTTv0rGAIbzvI9XBq2JoGlQ==
X-Received: by 2002:a37:2e42:0:b0:67e:6d80:2707 with SMTP id u63-20020a372e42000000b0067e6d802707mr5256523qkh.365.1647800492624;
        Sun, 20 Mar 2022 11:21:32 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm10092811qtb.28.2022.03.20.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:21:31 -0700 (PDT)
Received: (nullmailer pid 3157573 invoked by uid 1000);
        Sun, 20 Mar 2022 18:20:08 -0000
Date:   Sun, 20 Mar 2022 14:20:08 -0400
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>,
        Rob Herring <robh+dt@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: Add apple,efuses
Message-ID: <YjdwWHQNg8Ro+DIr@robh.at.kernel.org>
References: <20220312165837.40687-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312165837.40687-1-sven@svenpeter.dev>
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

On Sat, 12 Mar 2022 17:58:36 +0100, Sven Peter wrote:
> Apple SoCs come with eFuses used to store factory-programmed data
> such as calibration settings for the PCIe and Type-C PHY.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v2 -> v3:
>   - added r-b tag
> v1 -> v2:
>   - fixed indentation issue pointed out by Krzysztof Kozlowski
> 
>  .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
