Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECF4E72B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358292AbiCYMFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245177AbiCYMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:05:48 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1973E0DA;
        Fri, 25 Mar 2022 05:04:14 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j18so10573873wrd.6;
        Fri, 25 Mar 2022 05:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cmql6JRQ4c+pfus1T3jTl6YluToyjT6hqrJlEdFHfgI=;
        b=RJnMXBsUk/10brXTiB51lFUuk616nysVb3ZCxotWTlyZzuJTmLjoDvxQ9QtrDkhkHC
         jyRm5dHgJw9kQ83MiOH6KzRQH+imbhA8ny6oSK/e+bTWlm7IL6vhPgRIxT1JT6+EFH0a
         Iv005ALQHlfGi92MmLBkSPXyMCNnhkRgabLSZ5bClAOuYc9tQDF3vxXH/iXKe321GgVs
         W4BfI62lmgJRunQaTTd8YvZL7C35g8eH5cqykYOEUPZ+e5lzVgWaUyazL3LStqoL3nIQ
         WeZQULQGBgp1Z0/FmZLW+hgPb9rlDQevPV6piUU7mIBVqhvfA8l23SlIJVuxXtrgbu9M
         QHeg==
X-Gm-Message-State: AOAM530mfLwn4Zks7n3hUFUnauWEitbNzRfLsXwwaszo8iFjeow9jPZN
        0+oShp1YbzsjgIDpNhCxmlw=
X-Google-Smtp-Source: ABdhPJx0ClysJ7KNwSAJKEBVMwNIF5/Yw+qZwhx9lGesOO/nVGuzlQyfUlzR+/7TBICx+R1lmvd/7Q==
X-Received: by 2002:a5d:6510:0:b0:204:a6f:1226 with SMTP id x16-20020a5d6510000000b002040a6f1226mr8807000wru.59.1648209852534;
        Fri, 25 Mar 2022 05:04:12 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id l12-20020a056000022c00b00203ee262d12sm4666907wrz.116.2022.03.25.05.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:04:12 -0700 (PDT)
Message-ID: <475d2af6-38cd-47a1-61b2-6b1298bf505d@kernel.org>
Date:   Fri, 25 Mar 2022 13:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: xenon: add marvell,sdhci-xenon
 compatible
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, huziji@marvell.com,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
 <20220325000745.1708610-4-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325000745.1708610-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 01:07, Chris Packham wrote:
> The armada-37xx SoC dtsi includes this as a compatible string. Add it to
> the dt-binding.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - new
> 
>  .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index 326ac3fa36b5..776bed5046fa 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -31,6 +31,10 @@ properties:
>            - const: marvell,armada-ap807-sdhci
>            - const: marvell,armada-ap806-sdhci
>  
> +      - items:
> +          - const: marvell,armada-3700-sdhci
> +          - const: marvell,sdhci-xenon

Do you know of any usages of marvell,armada-3700-sdhci alone (without
sdhci-xenon)? If not, it should be removed from the enum before (the one
added in your patch #2). It does not look correct to have it both as
standalone compatible and one compatible with sdhci-xenon. Either it is
compatible with sdhci-xenon or not. :)

I suggested before to make this change here as separate patch, but I
think I missed the fact that it is simple correction of
armada-3700-sdhci compatible. Such simple corrections can be done within
same patch as conversion, with explanation in commit msg (which was
missing in your v1).

To avoid unnecessary patch changes you could squash it with v1 and
include this in the commit msg (actually extend it to say that you are
correcting the 3700-sdhci compatible), or create patch #2 that way:

+    oneOf:
+      - enum:
+          - marvell,armada-cp110-sdhci
+          - marvell,armada-ap806-sdhci
+      - items:
+          - const: marvell,armada-ap807-sdhci
+          - const: marvell,armada-ap806-sdhci
+      - items:
+          - marvell,armada-3700-sdhci

so now you will only add xenon here. But then it is so small patch that
with explanation we usually include it in conversion.

Best regards,
Krzysztof
