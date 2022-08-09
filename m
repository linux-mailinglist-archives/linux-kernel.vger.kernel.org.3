Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181A58DA36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiHIOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiHIOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:21:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297812745;
        Tue,  9 Aug 2022 07:21:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so1305137pjz.1;
        Tue, 09 Aug 2022 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=bEh+wwLVHA5bFmeGIiv3pq/kyT0bJnwEWBvwDkgXm6g=;
        b=HHzzaBhUEV9ZA0bnSyzbjihYJV0FW/lD7Di40zWTTS8aBbRJOjP0CAGQ1BGZkSGG8Q
         jWV3nNmtuIiTCus+Av5mFEp6Ybc2lf4ro/rJyvPob2KZ/LyezvLuKjEMzl2Widmio4Ub
         CUB6IkVIFPnCjSt4kFJTbVpNYtsUR8mIpa27SAqjVRBWJS/QDFM7VucLLARp/4zq1Qqv
         lETbWuIBUaqHNZKqFYnpCVKOOdgcSK4HvOi3nNakQg2IF4yqD72qW3i9sdg0B2yPmLNp
         0FBrdikul9Tf29TC4Pz0bjZulJIbyfRwh4kD+/WR6cFydb2GOpZsi0OXgc6q8W2YKNlm
         TryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=bEh+wwLVHA5bFmeGIiv3pq/kyT0bJnwEWBvwDkgXm6g=;
        b=dwt0tlqbRRTjZgEy75dWNORyqrOfRK/kSXHgcc1fTpOeAvKj4vp9BRxJlKzTd6M//V
         sDiHlXYHXgKKuTspdxS7CtdXeKZNBBssEgPHpue+fuI7j+d0P/PYAn3sbk8XuE+Ap0ee
         F5voRPzMU4dKByxE1z3LFNGxreSMNtXmvZJ4e1pdi3kgkiX9TYZJNbA5YCiTcBFlwoCq
         NT53MFiEdcP7ha+4r0lKrfPvOYFdQLjD+HdAITYBcyoZPkVW29pty5Sfs5NsZSWyopec
         92FsVFwbv7Xi1J1cZAULGvAoglM8h42Tq+aQbfyagizb1SgORFob4X9tygM5+JJUOHSU
         bgxw==
X-Gm-Message-State: ACgBeo1x7BZaOa1JhPMTqjiYk5/Ucctbi+/56fdpYEoJzRhtWgb6Q9nH
        b737jQx/YcYCf55CeaRyGsY=
X-Google-Smtp-Source: AA6agR6bbPT492glnh8e1KF/bFik6WFEaYwUy+ijzOEiB+PSGLMMb1oVudpZL1GuyNmIOwsjmiVJKw==
X-Received: by 2002:a17:902:d48f:b0:16f:a73:bf04 with SMTP id c15-20020a170902d48f00b0016f0a73bf04mr23963872plg.43.1660054903206;
        Tue, 09 Aug 2022 07:21:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x66-20020a626345000000b0052e987c64efsm10352651pfb.174.2022.08.09.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:21:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Aug 2022 07:21:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: sparx5: use correct clock
Message-ID: <20220809142139.GA2105857@roeck-us.net>
References: <20220809112209.241045-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809112209.241045-1-robert.marko@sartura.hr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 01:22:08PM +0200, Robert Marko wrote:
> SparX-5 temperature sensor uses system reference clock and not the AHB bus
> clock as indicated by the register information [1].
> 
> So, correct the clock description as well the included example.
> 
> [1] https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=hsiowrap,temp_sensor,temp_sensor_cfg,clk_cycles_1us
> 
> Fixes: f5520753c16f ("dt-bindings: hwmon: Add Sparx5 temperature sensor")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/microchip,sparx5-temp.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
> index 76be625d5646..51e8619dbf3c 100644
> --- a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
> @@ -22,7 +22,7 @@ properties:
>  
>    clocks:
>      items:
> -      - description: AHB reference clock
> +      - description: System reference clock
>  
>    '#thermal-sensor-cells':
>      const: 0
> @@ -40,5 +40,5 @@ examples:
>          compatible = "microchip,sparx5-temp";
>          reg = <0x10508110 0xc>;
>          #thermal-sensor-cells = <0>;
> -        clocks = <&ahb_clk>;
> +        clocks = <&sys_clk>;
>      };
