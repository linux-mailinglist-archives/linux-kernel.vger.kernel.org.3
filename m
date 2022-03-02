Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE704CA120
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiCBJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbiCBJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:47:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED14B8229
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:46:29 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 69B7C3F5FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646214388;
        bh=/i/Tl5JDYxHy1DfeqPaVUUr4WPXCyRWi21gK1tt8oLA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Z0iLz+Q5TyiKheYP6UTnya+zncGbH+RViExGQ6DCLKlQYStSjv99UaOJFqChE4Jjl
         qCKXI0wDUrJO6xmHMCCy7qOvrPMvX9wnx/l5CMhhLebiw2KCLfuaKvvHu94Xxrpea9
         CUx5sNPEYjl4ZpeOcSbMui4pI/yAo/E6gBQjmR5fzWENCa3WZWO+QsQmVp2JMcqQS7
         xvSdGGaHVXqDipi3r/9vXt+4T2n2by/GmOn2qhjEEG7ICd33q2qWJH10qwedz/B5cw
         v+h/Lc5oKPppEdGUw+2dSRd+pM5o9Pj1b6vf0SuFDmjgJ2wbcWB7knc8DnDNRcol7f
         VoE4oMdtsllZQ==
Received: by mail-ed1-f72.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so698224edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/i/Tl5JDYxHy1DfeqPaVUUr4WPXCyRWi21gK1tt8oLA=;
        b=EZ1e6rja6c33Wzld+r10M6Z3YazQNzSUIjWuR1rg7vNwsGLcIsdXvECWTj5Ot2o+LK
         lvc2A4Knt65AFt90+OZkRbFqs9ImdBJFYqzNA/rlX/NbiRg1Vp1lGW7N2z/RmWEZWN40
         bNOeveQ8YzOE6iNmJO2EDwRE1O1fDo6H9sFYvvBlT9UdjrbpLZ0+WaZJDfDNudkgvjES
         Ge+Nqir3w7qtRgWRR4x4bvmIAK04am2zQ+8V9JTAr7WVBH+fiEflHDjTLa+D5Nofx3Fx
         o6sl1nK5WKd9oucosdOGQeIRMu2Oay1Hn6t+AfHM1keUBmZnvAThW4Fqp2zc5qnKJ6xy
         IyYQ==
X-Gm-Message-State: AOAM533zhf4CEpQstyA7iPlZbCb5fknIx1kBABN/iT+GF6EOle42cxLx
        q6E8YoOzYZQiMJ0PkE1gzmpB2qZ/SheGTdj7fx0kElR8GEgjMgwg8tY6O4fi1KOcR15oVigZKXm
        Luo4H7sS7eJGKPBGGwJa8DGe6HJzCFBjpGqLw2dwmsA==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr23515481ejc.401.1646214387402;
        Wed, 02 Mar 2022 01:46:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPOkiH4a9QCn+Wd7L5hlKw9lulPSI6MAqtbvWliZVQXaUWpoXaMt7gC/299TK5aFIrth7zTg==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr23515473ejc.401.1646214387252;
        Wed, 02 Mar 2022 01:46:27 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ho12-20020a1709070e8c00b006ce3f158e87sm6159767ejc.2.2022.03.02.01.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:46:26 -0800 (PST)
Message-ID: <16c07205-cd2d-fb9a-771e-7874a568026c@canonical.com>
Date:   Wed, 2 Mar 2022 10:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/5] dt-bindings: Add power-domains property to
 ahci-platform
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301152421.57281-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 16:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some SoC using power-domains property so add it here
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v4: none
> changes in v3:
>   - new patch
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
