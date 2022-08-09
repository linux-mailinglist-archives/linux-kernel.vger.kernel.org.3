Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12758E10E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbiHIU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHIU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:27:43 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A815711;
        Tue,  9 Aug 2022 13:27:42 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id j20so7171750ila.6;
        Tue, 09 Aug 2022 13:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JAxi2taMBqU97xW2nRyGEmAgrHRKwxpf6eF7hjGDQMQ=;
        b=Ct6bnimjBWi7FWLgHxXSNPTva1KFkoaAuzCT3l3Ss/ajmEaI1kQOXSdJ53sDtSrl8u
         IKDJMNs4TZgRFHP5HqeFApa5UGw3vP6Mo7Ktx4NCBii+yJyKc2lSpNGBsDYR9A8qN/80
         HIZ1stfVhL6FxrWQfEoeP9vlH9iGqO1NpR4TebEpvMpKGjVxxhd4ZL2vZlv4ke8yN+7Z
         GobgavCd3cPbnFWia/aZro0bsoTbinj3JRMQ9FVSywQNuv2J3Jrxa4p4grSqdpZN6v/R
         b77jZudOUyssvk1nXS/Y5EvzFMp0DLpSbD+Q99nIy8l4mffcZhJFulbKZdzZAvUoUAYn
         qgwQ==
X-Gm-Message-State: ACgBeo016Qum+z5xhpTwfcjvzcYvIAukHoVuLGQeM/L4zcAegKIGE7dl
        2hCAXL8MCfXqRZMdS4lKdHnZcLGkVw==
X-Google-Smtp-Source: AA6agR5nKaMYQe2jBBZjyGFoVwLhDfFp2MhqK2wp+GMIvM1V20HeGNu0scIylSgfzizPyRRpZ2UTwQ==
X-Received: by 2002:a05:6e02:17c7:b0:2de:ae1d:35a6 with SMTP id z7-20020a056e0217c700b002deae1d35a6mr10979709ilu.123.1660076862150;
        Tue, 09 Aug 2022 13:27:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k18-20020a023352000000b0032b3a7817acsm6515500jak.112.2022.08.09.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:27:41 -0700 (PDT)
Received: (nullmailer pid 2339013 invoked by uid 1000);
        Tue, 09 Aug 2022 20:27:39 -0000
Date:   Tue, 9 Aug 2022 14:27:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, dan.carpenter@oracle.com,
        linux@roeck-us.net, linux-pm@vger.kernel.org, rafael@kernel.org,
        michael@walle.cc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: thermal: Fix missing required
 property
Message-ID: <20220809202739.GA2338957-robh@kernel.org>
References: <20220809085629.509116-1-daniel.lezcano@linaro.org>
 <20220809085629.509116-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809085629.509116-3-daniel.lezcano@linaro.org>
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

On Tue, 09 Aug 2022 10:56:28 +0200, Daniel Lezcano wrote:
> When the thermal zone description was converted to yaml schema, the
> required 'trips' property was forgotten.
> 
> The initial text bindings was describing:
> 
> "
> [ ... ]
> 
> * Thermal zone nodes
> 
> The thermal zone node is the node containing all the required info
> for describing a thermal zone, including its cooling device bindings. The
> thermal zone node must contain, apart from its own properties, one sub-node
> containing trip nodes and one sub-node containing all the zone cooling maps.
> 
> Required properties:
> - polling-delay:        The maximum number of milliseconds to wait between polls
>   Type: unsigned        when checking this thermal zone.
>   Size: one cell
> 
> - polling-delay-passive: The maximum number of milliseconds to wait
>   Type: unsigned        between polls when performing passive cooling.
>   Size: one cell
> 
> - thermal-sensors:      A list of thermal sensor phandles and sensor specifier
>   Type: list of         used while monitoring the thermal zone.
>   phandles + sensor
>   specifier
> 
> - trips:                A sub-node which is a container of only trip point nodes
>   Type: sub-node        required to describe the thermal zone.
> 
> Optional property:
> - cooling-maps:         A sub-node which is a container of only cooling device
>   Type: sub-node        map nodes, used to describe the relation between trips
>                         and cooling devices.
>   [ ... ]
> 
> "
> 
> Now the schema describes:
> 
> "
>     [ ... ]
> 
>     required:
>       - polling-delay
>       - polling-delay-passive
>       - thermal-sensors
> 
>     [ ... ]
> "
> 
> Add the missing 'trips' property in the required properties.
> 
> Fixed: 1202a442a31fd ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
