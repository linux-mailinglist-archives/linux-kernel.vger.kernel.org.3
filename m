Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D124F2004
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiDDXN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbiDDXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:59 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DC22BDD;
        Mon,  4 Apr 2022 15:52:05 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-dacc470e03so12515171fac.5;
        Mon, 04 Apr 2022 15:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3oWZY+Z6UGSCijTzt5Cq0VUhlgpsnDNsKp/vR2785K4=;
        b=PWBOuFtO2vbArAGoO/rjT3sy0B9/WpiqCYpg+aTgaFAb0ObQWNLGDcHGSJukEeugNK
         VQpu02+MPgqisNYEn+tt5ixLcJFKasnVS4ggir6UgZy2wP3S3KFS19bc0WLAGjmUX/j7
         dOUPdrZLYjQdiSoQY1lPprr5CKtocySo6acpoP+vDG06Gp3OwaF/MvmSYZcF0IxB1etM
         aEKlql5IBauYdEQ2kzTozuY/lhFQtxDW/4k1hhRTbEgnxADCg9dLQoQpgUgpYOCxndax
         2w05ZXTbaKfA/i6xburmJ+My0nyx6JK6YwKZ6s/O2oIgLOWm7nvcVMcFiWd3WtyAVNiy
         QNgw==
X-Gm-Message-State: AOAM532900ogRlS3S4GB0GB4AskfvqyhxdfUJhXazAQQ1BCCnhFWEdsW
        To4gK1oma/RskUJTCCIJHWBzeI7Kzw==
X-Google-Smtp-Source: ABdhPJxGpRqnhPcje+xwduWWUv41om4lAa5vr/NSF5MkKO41yeFF2I/yIaa4F5F7O649/GCoAQvSEg==
X-Received: by 2002:a05:6870:c69a:b0:e1:ec74:e8a7 with SMTP id cv26-20020a056870c69a00b000e1ec74e8a7mr281091oab.184.1649112724598;
        Mon, 04 Apr 2022 15:52:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a056870e29400b000da4a0089c9sm4735868oad.27.2022.04.04.15.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:52:04 -0700 (PDT)
Received: (nullmailer pid 2154303 invoked by uid 1000);
        Mon, 04 Apr 2022 22:52:03 -0000
Date:   Mon, 4 Apr 2022 17:52:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] docs: dt: writing-schema: mention coding style
Message-ID: <Ykt2k1v7IHopnlK0@robh.at.kernel.org>
References: <20220403081849.8051-1-krzysztof.kozlowski@linaro.org>
 <20220403081849.8051-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403081849.8051-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Apr 2022 10:18:49 +0200, Krzysztof Kozlowski wrote:
> Mention the usage of YAML coding style.  Describe explicitly that
> four-space indentation in DTS examples is preferred, because:
> 1. The YAML's default two-space indentation for DTS code makes it
>    significantly less readable.
> 2. Linux coding style tabs would introduce inconsistency (entire file is
>    indented with spaces).
> 3. On the other hand, eight spaces would not align with example's
>    opening '  - |' part.  Four spaces makes the code nicely aligned with
>    it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/example-schema.yaml        | 14 +++++++-------
>  .../devicetree/bindings/writing-schema.rst         |  6 ++++++
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 

Applied, thanks!
