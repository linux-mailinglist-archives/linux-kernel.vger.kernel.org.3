Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA153CD69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiFCQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiFCQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:43:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298344A3A;
        Fri,  3 Jun 2022 09:43:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so7793380pjt.0;
        Fri, 03 Jun 2022 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AuAWb6wr3U5ZYzaZw4rE0IYBApAjbR2PJcAEHrA6+Iw=;
        b=d4yPnqqouR+ytAC2ZLVf52Yaw+X8gPBlmY1beiTtGuLwGwauvdx9u5LHWz4oQq58/4
         Jp4J6AWnlTDoT2R8kjmWa9bNPbo5BK/hTuIo3K4t793jeeMQfJ5zX0heoq6oGJ1sg4qI
         YP/QinIXgi9f/0pS0IeJaqC+bxC34V0wwFFBRctuORurCvPudaC18UJifSmHd2JcgKn/
         IYLXu2R3Scqdk813CvVMH1KHnE83ur+ECuvLQok76ybwzMU0gIVT8kDZrZqyCumnWqTq
         wd1mgbefK+HdoLIVD/v5/egrUs4CxRr7PAl3cwlJ6EMO7hynV796ealb9MDvtRKMa8mO
         Y7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuAWb6wr3U5ZYzaZw4rE0IYBApAjbR2PJcAEHrA6+Iw=;
        b=anKXf8+qiVbHL/HdiksDjw0d732K/PWX+wPlarwDdgJHcxyPmqBV4DQ/6c43BtJRF3
         51zXmUfBHPTSzNktcjxqwAwSmRCtOs4MAkNEQPns3JuGd6YiSjp3sPxvhcB9QizyRTDU
         ag2wTgmLCwJFiQ7r6o4PPAXwlkb241bFYQaibIFYzfw2CvQtFo2V/jME5sjuDf/JJB7H
         eJjh8fGGbiNa+B3TN/1KweQGOd7CuF3J89wbLDmmumUkHKfW6ggrIymc9uqk9JW0fyHg
         d0w4iN5WkGpe/HnKPren52AThFT/qe+vNiJfqWgr8IyvaOb3bHoZ88M6tNwVUbZXDecs
         +05Q==
X-Gm-Message-State: AOAM530TqrnoxG3uZZLFQQR4eOAKFgjWtLfnLUrRj0zeofmqEqSCcBJ9
        ht4yFw5yG1FaKlrtM0Z4+MA=
X-Google-Smtp-Source: ABdhPJwlE088p+kcNsgtfPkbTvErk1jixHRTtRD603m5NWJwVpEWF5hI71dDVBkOTGz7MsiCxLestA==
X-Received: by 2002:a17:90b:3b4c:b0:1e0:3354:5e5d with SMTP id ot12-20020a17090b3b4c00b001e033545e5dmr47077808pjb.239.1654274630956;
        Fri, 03 Jun 2022 09:43:50 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:aea8:f22c:dcaf:b60e])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902a38c00b00163b2c46ef1sm5550337pla.222.2022.06.03.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:43:50 -0700 (PDT)
Date:   Fri, 3 Jun 2022 09:43:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 2/2] dt-bindings: input: gpio-keys: document label
 and autorepeat properties
Message-ID: <Ypo6Q8/SuPGxp/ac@google.com>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603101601.542054-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:16:01PM +0200, Krzysztof Kozlowski wrote:
> The original text bindings documented "autorepeat" and "label"
> properties (in the device node, beside the nodes with keys).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index 49d388dc8d78..b1c910a5e233 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -15,6 +15,14 @@ properties:
>        - gpio-keys
>        - gpio-keys-polled
>  
> +  autorepeat:
> +    type: boolean
> +    description:
> +      Enable operating system (not hardware) key auto repeat feature.

Should we refer to the generic input device property here instead (one
on described in input.yaml)?

Thanks.

-- 
Dmitry
