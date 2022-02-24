Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA44C313C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiBXQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:29:06 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D11965C4;
        Thu, 24 Feb 2022 08:28:35 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id j24so3205356oii.11;
        Thu, 24 Feb 2022 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Hw+IXRYrnzmeFFNG8Nc9XPQ/h/ngGDlwqtlbBJf7gQ=;
        b=Sh2QGzb683l2ieej21t4GkmLUpBtgnqaVjfpogjOvadOwHiZ8n8vsYYMBrF6OPZHXm
         B2uxEUVAYMV/PDjX+g/6f5eSl96IDJwaUCAQZOL2KTtT/rf0GelfH2sOZMHnCg8gKa8t
         gqzu9XJwKMqVjxfsSJlagv9oTzJ0kC/2EbI6mMAhJoaErENbgpVM8ZMZzc9RIUq5jI5K
         Ps6rCYYLAO1WRpipIjIcaydl4SxgiNJRAuJPTtLn1qs1gzRnDfiJhCpYUajqYyXVvWJO
         ltj3wKLM35bXEwKVcaPb2eMWRUKl5JtE7jUxn0BRG+D6/x2p075GZIJVxiv9mLvCLP16
         3OYw==
X-Gm-Message-State: AOAM530LRqDAybgoR6pzCfJCwDKerD97x0PybH8TCxEOks7SZddX5ZU/
        Q3eITvaDixVF6jAaZZWWpBpsI39ltg==
X-Google-Smtp-Source: ABdhPJyBSuL4dpeG7BPV2Y0QipvRylf1FyFsNnew64rw4tYkMJ1gXBOSoDp7AJ29P+p4sn9gv7D7Wg==
X-Received: by 2002:aca:b9d5:0:b0:2ce:6ee7:2cde with SMTP id j204-20020acab9d5000000b002ce6ee72cdemr7756180oif.268.1645719063709;
        Thu, 24 Feb 2022 08:11:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d60sm1352253otb.29.2022.02.24.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:11:03 -0800 (PST)
Received: (nullmailer pid 3169955 invoked by uid 1000);
        Thu, 24 Feb 2022 16:11:02 -0000
Date:   Thu, 24 Feb 2022 10:11:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Agathe Porte <agathe.porte@nokia.com>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <YheuFuVz38Rcy5Q1@robh.at.kernel.org>
References: <20220222223610.23098-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222223610.23098-1-linux@roeck-us.net>
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

On Tue, 22 Feb 2022 14:36:09 -0800, Guenter Roeck wrote:
> From: Agathe Porte <agathe.porte@nokia.com>
> 
> Add basic description of the tmp464 driver DT bindings.
> 
> Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v7:
> - No change
> 
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
