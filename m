Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C65392C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbiEaNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbiEaNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:54:44 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F5DD4;
        Tue, 31 May 2022 06:53:55 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id m82so3532380oif.13;
        Tue, 31 May 2022 06:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4k3vq7qVFqQjuoYQtYlHJSa5PUcZKNyVP9mXHmGrUIY=;
        b=sCkyZsMYgxJbK21qSrm6V4ft9aPyWPgl42Sp7CKHjwaIg5jcdZeiMuXyzVkUI4W74b
         xIr36ykpWusW2BIDsktEW4ft9WEF9tNoX+kXHCpznESDEhU4ypxo1AM/bSn4IIrcw2MO
         5xu6PzfCkzBwOw/figjSAQtG9wkKIPTyXUnpTJVfEZuMBRQYEbd0R6p4bBOco4vyYk0s
         RB98RYMGfWUmTmomlR+at08Lv/1+w8r1PoODB6j2F6vJXdwT1G0H1AgeC/3pHlHN/7Dx
         0nB8lN7ICzg1yNMHFdmFt5oXiTqqwd8w3LTjbAvd1H724x3Xyw16W7SgFSEi4Fnh7pYl
         hPSw==
X-Gm-Message-State: AOAM531DH2nPM4SaaasAcHXmI6dssXR9EIY4XUTw+AwUkAQDXM/dxcxb
        ichXIoIEJmc6EySBJ2gl+F+9rMSdhw==
X-Google-Smtp-Source: ABdhPJwQOjHoUBvDdB7j+dMl7MIS9ke/fwu3hFRc4UmLOTUpNablAae0T4QSsjIYR4rYw0RcXG9gBQ==
X-Received: by 2002:a05:6808:e82:b0:322:4c17:2f61 with SMTP id k2-20020a0568080e8200b003224c172f61mr11749556oil.131.1654005235223;
        Tue, 31 May 2022 06:53:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm8-20020a0568081a8800b00325cda1ffabsm5676933oib.42.2022.05.31.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:53:54 -0700 (PDT)
Received: (nullmailer pid 1657141 invoked by uid 1000);
        Tue, 31 May 2022 13:53:54 -0000
Date:   Tue, 31 May 2022 08:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom,smd: do not use pattern for
 simple rpm-requests string
Message-ID: <20220531135354.GA1654151-robh@kernel.org>
References: <20220524070408.39505-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524070408.39505-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 24 May 2022 09:04:08 +0200, Krzysztof Kozlowski wrote:
> patternProperties should not be used for properties with a simple string
> as name:
> 
>   Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml: patternProperties:^(.*-edge|rpm)$:patternProperties:
>     '^rpm-requests$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#]+\\$$'}
> 
> Fixes: 375eed5f51a8 ("dt-bindings: soc: qcom,smd: convert to dtschema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Now failing in Linus' tree and linux-next and no response, so I've 
applied.

Rob
