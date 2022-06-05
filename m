Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8E53DE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351683AbiFEW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348226AbiFEW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:26:19 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C254A3DC;
        Sun,  5 Jun 2022 15:26:18 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id d129so11492838pgc.9;
        Sun, 05 Jun 2022 15:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r8mYrZdUdj6SOr3fW1rTSyKFl3H7LMMUAEkXqWtIDxg=;
        b=EZIC30L7p/7/7zRTrlWWti7QSlvH0JgB/BYSQq3oPeWej5eblXNmetXp6VWicBStgI
         /C1BfPuBGIKNTVtKmnWO0UyKPRGjE51JMaM/Nlp4x+hHi5qKyUZNDgIFJRtNFw5Sj41t
         JSRlpsOarnVWxGb+Ds/g3ejs5SursQlrXLT/DTmfEUW0i4kgX2MFcDggakZVHirqr/0U
         N3lPizGP9opYh6xW26CesI1HGo/OICVz6Iq0sO5XVHHBra3uMLk725rbZTHkqgLjRWQ1
         1k4FLJs43rP4ApRD604JmZi2Od/gFKaYNEzlZRKfDF5gh4B5tC1rnJB9Kv5WJA4IYjO1
         P44w==
X-Gm-Message-State: AOAM533XjMLqVE3qy2RHpRDMUKbgeJ5UmREr7xOyDgBD+L/vYfaHgniF
        Rk9bGj2zRmGeO0y6agj2CQ==
X-Google-Smtp-Source: ABdhPJw6I4Ot6zcRsVKm0NrEMVfNCEr14EknjAEOa4jSaY2xDnJJY3qJsSLM+sTb2Nf5RCqoqs7ILA==
X-Received: by 2002:a63:8bc7:0:b0:3fc:b8ab:c612 with SMTP id j190-20020a638bc7000000b003fcb8abc612mr18197292pge.535.1654467977490;
        Sun, 05 Jun 2022 15:26:17 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:27d2:a39a:a9b9:e8bc:8bee:41d7])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902e21300b00162529828aesm9066353plb.109.2022.06.05.15.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:26:17 -0700 (PDT)
Received: (nullmailer pid 3639156 invoked by uid 1000);
        Sun, 05 Jun 2022 22:26:14 -0000
Date:   Sun, 5 Jun 2022 17:26:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: power: supply: summit,smb347: use
 absolute path to schema
Message-ID: <20220605222614.GA3639102-robh@kernel.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
 <20220601071911.6435-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071911.6435-4-krzysztof.kozlowski@linaro.org>
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

On Wed, 01 Jun 2022 09:19:11 +0200, Krzysztof Kozlowski wrote:
> Reference regulator schema by absolute path, as expected by DT schema
> coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/summit,smb347-charger.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
