Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA14EE553
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbiDAAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbiDAAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:25:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87E13E156;
        Thu, 31 Mar 2022 17:23:28 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so1067644fac.7;
        Thu, 31 Mar 2022 17:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fOE48022hc3x2gliekkxOTZif4fFeGF8GjZh2xBtXt4=;
        b=0DiOJkLRd+kb6NFK0DgYOHAR+5lHwWW7BqnesaJBExS7rYXgRLxsZv+Q1LdOMphEQI
         tgBn3cV4aDQL9P+ZwFlV3250fBxOAtFWUNKdOqqpkkmbDcmssXhYidKb2+SR/SQnqytu
         e2TSODwv3GGtY8KzwbxuyEAhSi/BrcHlX9tUMlk+wRzgqzpWULg3EiT1nAaamwb8yD1J
         XsK0I/N9428POslgdHIKHyaymYgaDNFKNbpAYgO+voAViw8tRitJTs109PNtiy3gQN+b
         RfB10SUGE6JbqznEkxK5LtBX0NqZeAhIjlHc3vzpAE74UTuJUp/UAl0RjxLIuwZF8E8q
         uRJA==
X-Gm-Message-State: AOAM530zis2DgyjSVItCitrpgmyPt1DX4a/nxT/7TW6V10j67hkdRRKr
        rHpJfjVCzSapOdmSJP+sfQ==
X-Google-Smtp-Source: ABdhPJwXfYSy4UVEgOmFowj/6TwnmGvQgex34BICM0iH5iTXjzsfi8KjQFplYq0mWrD5dTSk3o6wOQ==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr3969928oaa.9.1648772607461;
        Thu, 31 Mar 2022 17:23:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a05683014ce00b005b23657f66esm483609otq.31.2022.03.31.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:23:26 -0700 (PDT)
Received: (nullmailer pid 1773996 invoked by uid 1000);
        Fri, 01 Apr 2022 00:23:25 -0000
Date:   Thu, 31 Mar 2022 19:23:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, krzk+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: crypto: sun8i-ce: remove extra line
Message-ID: <YkZF/STFg9u1g1BZ@robh.at.kernel.org>
References: <20220324144233.1119495-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324144233.1119495-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:42:33PM +0000, Corentin Labbe wrote:
> yamllint complains about this extra line.

It does? Where?

Or maybe we already fixed...

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
> index 00648f9d9278..026a9f9e1aeb 100644
> --- a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
> @@ -82,4 +82,3 @@ examples:
>        clock-names = "bus", "mod";
>        resets = <&ccu RST_BUS_CE>;
>      };
> -
> -- 
> 2.34.1
> 
> 
