Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7F586D75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiHAPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:12:19 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B1CEE24;
        Mon,  1 Aug 2022 08:12:18 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id v185so8573944ioe.11;
        Mon, 01 Aug 2022 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=00WqQczM5k8faqmOf4LEoLA+1YSvWY/3Za2518s+4uU=;
        b=biWCPeRyJmYxNRAY8hfPT8rc/2mR0eopkr27JUMW/M/+8eOcb/4Q8aF8+IpG9NMDJx
         muwl2gSWrZUhoWbAEYA1AeMJpqFzq/FPFW8+jtLJ03eOVpRceY5lYd2zWYeyE9OSUd3d
         VqZanhrIvlPpxnApzsxE78oRo+5Hmxz+di0OIdzaGWqWOjEMNwkMipwPrKl4eLCuvqaa
         OON6E4qyc7UhvmW5zZ1cPt9FHLt48YZOWXnsBtCDHJOFKyBYv7l47k9Rs7rKJzZ5uTtQ
         fOaZHnERUwGYm0zn07NItH0A6nKdmj7pr+eDAwgKx1DQRohx2aOCEIy+z8uD/Oip8tbk
         U8qw==
X-Gm-Message-State: AJIora/Z+Y3o1/IuoOTXw5qQhLGU7LYuSyxL3Ycc0aIE80fZod2M0uMY
        P4YfZ+cq497+8DicHSQ3rg==
X-Google-Smtp-Source: AGRyM1thp9kA3Eh3vTT9FeBlCAt4d8hWHWj0c/lOM7jBCyA4dUJ52JMSYKOcy7OtWDaBMrJUXGty4Q==
X-Received: by 2002:a05:6602:27cc:b0:5f0:876e:126b with SMTP id l12-20020a05660227cc00b005f0876e126bmr5557146ios.129.1659366738051;
        Mon, 01 Aug 2022 08:12:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y92-20020a029565000000b0033edc51d7e3sm5350067jah.64.2022.08.01.08.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:12:17 -0700 (PDT)
Received: (nullmailer pid 1029847 invoked by uid 1000);
        Mon, 01 Aug 2022 15:12:16 -0000
Date:   Mon, 1 Aug 2022 09:12:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remove the dead code in cmd_mk_schema
Message-ID: <20220801151216.GA1026724-robh@kernel.org>
References: <20220729052112.3235325-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729052112.3235325-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:21:12PM +0900, Masahiro Yamada wrote:
> Since commit 2783a7f56f99 ("dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
> dt-validate"), the processed schema takes all the YAML files.
> 
> Remove the dead code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Documentation/devicetree/bindings/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

I also sent out a similar patch[1].

> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index c9953f86b19d..223df2a023fd 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -42,10 +42,8 @@ quiet_cmd_chk_bindings = CHKDT   $@
>  
>  quiet_cmd_mk_schema = SCHEMA  $@
>        cmd_mk_schema = f=$$(mktemp) ; \
> -                      $(if $(DT_MK_SCHEMA_FLAGS), \
> -                           printf '%s\n' $(real-prereqs), \
> -                           $(find_all_cmd)) > $$f ; \
> -                      $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
> +		      $(find_all_cmd) > $$f ; \
> +		      $(DT_MK_SCHEMA) -j @$$f > $@ ; \

I want to keep DT_MK_SCHEMA_FLAGS because I'm working on a new optional 
flag to pass.

Rob

[1] https://lore.kernel.org/all/20220727211100.3249417-1-robh@kernel.org/
