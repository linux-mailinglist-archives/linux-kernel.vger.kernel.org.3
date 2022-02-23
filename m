Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54D4C180B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiBWQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiBWQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:02:48 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F86D39C;
        Wed, 23 Feb 2022 08:02:19 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so22888785oos.9;
        Wed, 23 Feb 2022 08:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnHAJ2jXJaVVjE1oqZGwvuQytS4K0cKMmmVsJjHc5pk=;
        b=cmlhd8svXculh72aqZrwvwv6LDzoc9l7X83KA0mIFJ4nMQjNbB8GJnZhWINfmOrWIu
         RQy9GCoVDo3uT0bRQeWm+E+2Z09aQKKwlWP/veik3B5DFaoLYiRjIpJEt65B6nYXILqm
         G/vF5ihXJ5sWir1ddrSob6MqeKmbCvPNtf7avkvLaHgGDMEtq9OT+Xew2zbxapmSAOkB
         pbPcaqJ8e+0gAhamdhyeazmMNNwhJ+FVKukhRFliWJUzJd7skDzNezN13RMaFbAeE+e6
         Gf4VCpa0oBKAbLhn/yTrOaTvEqUc9MJUUQqvTg0HiOrqiZvOVvH3j2+4ZJM7CvFRs1IO
         l9VQ==
X-Gm-Message-State: AOAM531tlxHzGRjv8HnFaPaA5G9FJ9i86nHViIyIC8to8z+82oxZoYZL
        zyp20uIg5/r6rTgCUY/fLQ==
X-Google-Smtp-Source: ABdhPJw8XWn4z29aClQvUF5kk1BY9mwbXLVBQPAYTLP4JVYBwZtzfi//QgYZpCES82OuILp12HV5sQ==
X-Received: by 2002:a4a:a8c2:0:b0:319:4f4:18ea with SMTP id r2-20020a4aa8c2000000b0031904f418eamr65183oom.20.1645632138616;
        Wed, 23 Feb 2022 08:02:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w28sm9647ott.14.2022.02.23.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:02:17 -0800 (PST)
Received: (nullmailer pid 1012060 invoked by uid 1000);
        Wed, 23 Feb 2022 16:02:16 -0000
Date:   Wed, 23 Feb 2022 10:02:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <YhZaiAIq7xUig+Wj@robh.at.kernel.org>
References: <20220222220937.18728-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222220937.18728-1-linux@roeck-us.net>
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

On Tue, 22 Feb 2022 14:09:36 -0800, Guenter Roeck wrote:
> From: Agathe Porte <agathe.porte@nokia.com>
> 
> Add basic description of the tmp464 driver DT bindings.
> 
> Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v6:
> - Model ti,n-factor as int32 instead of int8.
> 
> v5:
> - Dropped ti,n-factor from channel@0 example. Added additional
>   channel to examples to show positive ti,n-factor property.
> 
> v4:
> - No changes
> 
> v3:
> - Addedd support for TMP468.
> - Changed number of channels from 0..3 (which was wrong anyway) to 0..8.
> - Changed value range for ti,n-factor to int8, with an example for
>   a negative value.
> - Added myself as driver maintainer.
> 
>  .../devicetree/bindings/hwmon/ti,tmp464.yaml  | 114 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
