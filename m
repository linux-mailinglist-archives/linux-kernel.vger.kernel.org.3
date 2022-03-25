Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8744E727D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357713AbiCYL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357525AbiCYL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:56:31 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36260BCB6;
        Fri, 25 Mar 2022 04:54:57 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r13so10520843wrr.9;
        Fri, 25 Mar 2022 04:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wfO/NgKZ7H/qKA+QCI+ODq0tIwjvgLb32lCfr243Wio=;
        b=PjQ72ppjZJv71Q7Lsc1DCsD3OBT8iqTJclAni1GB8mJK9rjfbf+zXcupuTU554blja
         FEKWJw7In4hw4MOVjiUKiWE7gBN3h/X36neZVFv2TZ4rBfePUTsCERymzVc4KajSs2tC
         /sH5hRGAjQAHOyj4veDG0+0szQOCXKj5U4om4dlPbhs3aQfuZYdxHTIhI8fxXhZ+PM5l
         us6BJoRoTm+qEXFLdNuQ+vh6zn72RDa7uiX9f3hkaKVVzRT1hlqO7oY6g/IG8SOi7z5J
         X3dJ6BZfV4i2PFgbEpL1S3kfSOUwslQ9FnOEgCL7Es1x5EUvVdVS34wtZ0Xf7wUXqfTQ
         0EZA==
X-Gm-Message-State: AOAM531heWHSszkjgUnWbdohoompHROB41pnU9XaT4/ETFs5WicqncqB
        TsdNhDvAORr9r4ipe/2NIAk=
X-Google-Smtp-Source: ABdhPJyqx1hl6cEgGobyDAh7rmlx2h8IO+ILO7En01TltDi+G500EhEPBMZCB2sr6uU1h34LFuv1pw==
X-Received: by 2002:adf:fc06:0:b0:204:975:acfb with SMTP id i6-20020adffc06000000b002040975acfbmr8958788wrr.486.1648209295383;
        Fri, 25 Mar 2022 04:54:55 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm8261916wmc.22.2022.03.25.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:54:54 -0700 (PDT)
Message-ID: <86f96cb1-aca4-2c55-fb34-ed35582af2f9@kernel.org>
Date:   Fri, 25 Mar 2022 12:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, huziji@marvell.com,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
 <20220325000745.1708610-3-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325000745.1708610-3-chris.packham@alliedtelesis.co.nz>
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
> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> as required by the generic mmc-controller schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - Don't accept ap807 without ap806
>     - Add ref: string for pad-type
>     Changes in v2:
>     - Update MAINTAINERS entry
>     - Incorporate feedback from Krzysztof
> 
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 272 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 273 insertions(+), 174 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
