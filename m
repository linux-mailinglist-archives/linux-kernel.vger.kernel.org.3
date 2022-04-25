Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A650EB17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiDYVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiDYVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:12:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B26FA2E;
        Mon, 25 Apr 2022 14:09:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l9-20020a056830268900b006054381dd35so11699735otu.4;
        Mon, 25 Apr 2022 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g17J6sFTPMUFOZrO9IXMP8Nx+aSWZ2iq9i8H5lFtblY=;
        b=Bwjd3J9JaGkkW3IkvJP5kiokTgjlGRJif9MGnM46DuWr3AKs0ni3QAWukxjMxhaZoM
         uaycti6CQpazIJMl4fyTWExYmX5kHNj4FG/e78U/SkK+pu9NfcH+cpynODX5hRjwO7pK
         NN9PfeiNBCi/7xdqRWjMJ5ozemm0vXRsj7gBL+5RP8OXHnOrNqtOjWCKh1LQuCQ05UcE
         avGLU9rKB+BoR4tYkXFVJEj7qtIm2Hpf/3mcUAJZ9BbUDopmb6t1uY9sJVc4B3py8KSm
         MQxywQNBgkeWoP5nCb6GJsReOp/WXPgufYAYdv6FWXWUjKrXldqU1R8P83x1kAzuN7XA
         GhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g17J6sFTPMUFOZrO9IXMP8Nx+aSWZ2iq9i8H5lFtblY=;
        b=CfjCB4bZXkaTX2BLI0KuOa18ceN/lStFiUz0cq0GxRlAHIEh+EXVJ7+x0UEQprAGxm
         dT5lxDRdCeVUrxEKUraathoH/h7kPD8QjNApamKyMcM/xJY3P0OXgf6xGT5ix1Fepx8i
         JIEvOvRdktkukN291hDq8sG3SQyRH0boVxejD2FSAYTjb5ZbzZfXhP7fWrwe9ShT6gXn
         C0VmwsD6btrNzm1FlJoavHUZBrekBX9ZAppcvMbzt4K77ZdGeX17wYJSIGMVAeIlY6FI
         3MG6fN5ZQ77148x9tJ4jZKEowKeDtiq3tjlieOkay1QdRjtjGFa2SGJXWo3luCiAHTjf
         8uCQ==
X-Gm-Message-State: AOAM533vDrLFVyqdqjJ7qbf9nuA1n23+932CTZ8Tta1cITDEC/bmu9t/
        oyvPubfnpR1BKYeqX5hrcE4=
X-Google-Smtp-Source: ABdhPJwiV0xUrnMDRE+FrYkXQ1iC1m4yTl6zBe9e3+YwEcqnzuUw4Q6+8texda10+SXyWGaXAIy66A==
X-Received: by 2002:a05:6830:4b6:b0:605:47ba:2310 with SMTP id l22-20020a05683004b600b0060547ba2310mr7199480otd.301.1650920949900;
        Mon, 25 Apr 2022 14:09:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870a44300b000e9436ea03fsm134545oal.36.2022.04.25.14.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 14:09:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add Atmel AT30TS74
Message-ID: <20220425210907.GA4184243@roeck-us.net>
References: <ea4cd16b-4a04-8857-d08a-53be58b00d28@axentia.se>
 <9c01b1b5-871a-2b34-9f98-766d043e0759@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c01b1b5-871a-2b34-9f98-766d043e0759@axentia.se>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:35:41PM +0200, Peter Rosin wrote:
> Document the Atmel (now Microchip) AT30TS74 which is an LM75 based
> temperature sensor.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to hmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index 72980d083c21..8226e3b5d028 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      enum:
>        - adi,adt75
> +      - atmel,at30ts74
>        - dallas,ds1775
>        - dallas,ds75
>        - dallas,ds7505
