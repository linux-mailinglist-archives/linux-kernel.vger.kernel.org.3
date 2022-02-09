Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034DA4AE7B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbiBIDDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359748AbiBICvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:51:24 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D5C061355;
        Tue,  8 Feb 2022 18:50:29 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q8so1143420oiw.7;
        Tue, 08 Feb 2022 18:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZEq/8mCOjzwD9orqDe6jz1KcZnSjH/KbDDATUNgRXs=;
        b=60WVH3fjF2nh+OBiYMCJFuUgFjNojCT3qpp3AvHCl2iKDn1JlydG7szmTbHYUdOWFh
         j8MujpjjIoCUEb5I+h1M83u0JvAS2d+TgsTZ5wxxboazyZ1/peIinmq27dfDuAbvkAC4
         jQ/5NCFkkn7+T6EVFd7kyv34MyChPAGQh96hunTXGFGoerHriC7pGXPF9UWEVPklhm+e
         f7oUdAXNZO/AN0li8Fic+tuObxUUegTFTGVui8V1HYyu6c9dBpBGGvjGkus6BDHJLL3z
         YrIXvXhJvI5CruA/sFFQKVf1YkQx0lauNzO4+4FBBA3gr/9rzoSUDdJj5RPW/Zg0sGw0
         y89w==
X-Gm-Message-State: AOAM532Hu6yzXoF+L3uM8Bm+j+PVtNlgIUosOhsFqbG/6AuWxfI2uW++
        7bdllDT68kC/j3qYuHIyUg==
X-Google-Smtp-Source: ABdhPJzDEYPyns9BvQ6gTLcGbC5N/bskfIdJfxxkiSmrX8PqpKdHv731s/65kutbSlVvehqXCGGzMg==
X-Received: by 2002:aca:b708:: with SMTP id h8mr69166oif.137.1644375028706;
        Tue, 08 Feb 2022 18:50:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 5sm2226607oag.11.2022.02.08.18.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:50:27 -0800 (PST)
Received: (nullmailer pid 3520304 invoked by uid 1000);
        Wed, 09 Feb 2022 02:50:27 -0000
Date:   Tue, 8 Feb 2022 20:50:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add Vicor
 Corporation
Message-ID: <YgMr84b8BKHBNQwq@robh.at.kernel.org>
References: <cover.1642434222.git.sylv@sylv.io>
 <58d2c7501edf746f3677681327c283fc3faaf872.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d2c7501edf746f3677681327c283fc3faaf872.1642434222.git.sylv@sylv.io>
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

On Mon, Jan 17, 2022 at 05:12:47PM +0100, Marcello Sylvester Bauer wrote:
> Add vendor prefix for Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 66d6432fd781..8a2a205d6d34 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1273,6 +1273,8 @@ patternProperties:
>    "^vdl,.*":
>      description: Van der Laan b.v.
>    "^via,.*":
> +    description: Vicor Corporation

You just changed the description for VIA.

> +  "^vicor,.*":
>      description: VIA Technologies, Inc.
>    "^videostrong,.*":
>      description: Videostrong Technology Co., Ltd.
> -- 
> 2.33.1
> 
> 
