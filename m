Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F5515842
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381270AbiD2WRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiD2WRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:17:46 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4FDCAAC;
        Fri, 29 Apr 2022 15:14:27 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso6012463otk.10;
        Fri, 29 Apr 2022 15:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bi/IlfS1Ukb6XMHfNsEGeVVbCrcuj1nGB3hThqmSiwQ=;
        b=Z2vnOfoEnVDTTBN394tbg78Mc5nr55a8kAg3VrI2Z2Lv2ejZcW4qqIKM2yf28ipcLF
         gn3EEl71+DcgpmjYw3mET7fTH9Exq2pbek7mL6OszAFw0rG/Fs9fMGto8g15+opCY2ZT
         qZ4J0a0MAeDbqQXEnF9hWYm1e959nRDA9jsI3NiMrD/BzcsInluQQJLsARwmMy9bI/r5
         rf0rnI+WzYyUekyPY2guHVzcn4pxn7UuwF8+GFOakY8/nHkWo03n+5HSez7mdaWX4fpq
         NZN7C7AZ2CsgseCR+Is0MVyvkrNJ218W3QxTlIX38VtAK+AY2olZJlnRHQW0Y2XFl0Eb
         OC7A==
X-Gm-Message-State: AOAM531z6g6Cmdgk44wAzWdBYGbXxTB6aw85fvi+9QzfiTm9XOjshg3m
        Mzb+fGbtFlSMVniBUKpNGA==
X-Google-Smtp-Source: ABdhPJwlXVbatqkkPMaUm3EJhQzZsLtenNHi0mY9dn7N6UxAXPHnrV03XX+ytU8kGo+MpLfr7Crv6Q==
X-Received: by 2002:a05:6830:2f3:b0:605:f29f:502c with SMTP id r19-20020a05683002f300b00605f29f502cmr559739ote.24.1651270466297;
        Fri, 29 Apr 2022 15:14:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a4adecb000000b0035eb4e5a6cesm1267473oou.36.2022.04.29.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:14:25 -0700 (PDT)
Received: (nullmailer pid 2991411 invoked by uid 1000);
        Fri, 29 Apr 2022 22:14:24 -0000
Date:   Fri, 29 Apr 2022 17:14:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw
 property
Message-ID: <YmxjQCckMnE8de6s@robh.at.kernel.org>
References: <20220426193253.663582-1-dfustini@baylibre.com>
 <20220426193253.663582-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426193253.663582-2-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 12:32:52 -0700, Drew Fustini wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add documentation for ti,scale-data-fw property to enable I2C PMIC
> voltage scaling during deep sleep. The property contains the name of a
> binary file for the CM3 firmware to load.
> 
> Based on previous work by Russ Dill.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [dfustini: split from driver patch and convert to json-schema]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Changes from v1:
> - change 'ti,scale-data-fw' to 'firmware-name'
> - add 'firmware-name' property to the examples
> 
>  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Applied, thanks!
