Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D84506616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbiDSHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349477AbiDSHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:41:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E4237C3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:39:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so31073685ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VLisSl5U+vKxlHEi2jsM/uSr3AGr/yP0sJybyysl56g=;
        b=yhRa2r+h7pBhcGnBWVIHpJG0E/SOWXoqFnTw3vVkDbqAu2k06J9tva1bu9Gzy8svwt
         RDDOtKw6Ax76s6d+eUgDVvNOJts+MrTULL2DFF1sVFbCO14c9JuYFZlE+tQ6OaWWj4rJ
         MDh/hhm3ARFz9nSIV+ApMaBnQGHNzRCs8RpWSwS5opbK18cvqlOusgki1VmUAbAAGtP/
         uNywTFQym1ZSuYElrz3xe9L+S11YOIR08iBK8Ys7gyMCv9pTP3l0RVEEOaRzP1nyDusP
         TYNKOb5jFi2s31EkaE4C2CywX/eqzb/G0IkYH5t+A7zydquSQYhsnbvwVyPWT3JvBkE3
         fi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VLisSl5U+vKxlHEi2jsM/uSr3AGr/yP0sJybyysl56g=;
        b=DO/vtUolE4+x/9vM0KoQ9kGjPyrGRFZuAy2r74ta0SZzNIPnN7Yp0lQtH0fM+lPdJY
         320FpzdXm1qd6WxepfHnBiT61iQWX/78g9X3Iqu7AZdmzrLWpEsLYstTP1PEpPlVR2Jc
         B9XZgPtnWxdvhFgwfqCsHxj/4hX5hCrgeuUOB3ikpUyA27BIfzXNDkZdCXndYocb3N8J
         1HUvGFNLKrpokfyxdlTlGgjM1rC6BJuOrPv5iTEVxe45DyGZkjpYsh5ijMYHjSmRRoRA
         ydSrj1dO0KTMKS7c5OJXLzUps6lYYw/X7gQGa4owtApphoyQ5gfk6MIG+5DtXize+4Rp
         bobg==
X-Gm-Message-State: AOAM531yGKVGpXrSlfz0riXQ++9rWwdi5xRQwXoytLKu/MNTN88nmGp0
        EkxNdlWXuULhQYDJrR1yImx2DQ==
X-Google-Smtp-Source: ABdhPJxYJtMgm7zv2VVxzftlKaF5M9cx1/oldQIn65xu7uNBz/9QCwQqmCMMn0/X58ekbNYbUVX2rg==
X-Received: by 2002:a17:906:5d11:b0:6ef:7bdf:e976 with SMTP id g17-20020a1709065d1100b006ef7bdfe976mr10374713ejt.743.1650353952960;
        Tue, 19 Apr 2022 00:39:12 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b006e898c912e5sm5352866eja.217.2022.04.19.00.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:39:12 -0700 (PDT)
Message-ID: <59cda570-2a78-0d7f-091e-02e837fe9ec5@linaro.org>
Date:   Tue, 19 Apr 2022 09:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc: convert sdhci-dove to JSON
 schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
 <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 04:46, Chris Packham wrote:
> Convert the sdhci-dove binding to JSON schema. The optional clocks
> property was not in the original binding document but has been in the
> dove.dtsi since commit 5b03df9ace68 ("ARM: dove: switch to DT clock
> providers").
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
