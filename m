Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4F518B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiECSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiECSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:00:31 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A793E0F1;
        Tue,  3 May 2022 10:56:58 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so11795732otk.1;
        Tue, 03 May 2022 10:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vq0pE2ihqfsGFKVmyUNJ/bbl6zB4mWl+pigcjVrj/W0=;
        b=zmxLxBnJPW3NcKbWNsYM/jO6+VDXTVmgFBMNWtu5N4X3Gd5IRjdQM9TdtgnIGKEsvg
         C4bazc/sXVZ0VGQBMgNGnU1NbIRO32PZ84yB2bdPtAsre0DPc1kl44GhzcmQRrrdgTOG
         8UN3nVACu4oixKtYuls0wfjutoMOIDCWaez/ZIyugVTY14sAQPmV89OjdpcB/XYp9wby
         Iqd86Jib4B1G5W4AVMnQMRYtp3wWUu/B6IU5A7HT09Dv+mJ2MmqhOJ1quMw/9GqGifq2
         0eqGHMI4Y4qSJTpPfViCfufhN6/4M1tQwnYtka1F+IfOhLxf3SiPESPLJPd3U/QpkC3T
         MrSw==
X-Gm-Message-State: AOAM53097WhJphYuTurkIaG+ppRVMMPtZlowrM4FvHbintUKYN+uiAQb
        mj0R4XK5gW03pVtk0MPlgHStJmDMCw==
X-Google-Smtp-Source: ABdhPJxvdIxFqhzLf7Q5hW6UAIrYzJZiNYchVBcqIK3ZmL7lWCa6YC05zLVRZTiMArKEHvhtSwXxIw==
X-Received: by 2002:a9d:6d99:0:b0:605:67e2:229b with SMTP id x25-20020a9d6d99000000b0060567e2229bmr6251477otp.13.1651600617845;
        Tue, 03 May 2022 10:56:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k16-20020a544710000000b00325cda1ff8asm3492711oik.9.2022.05.03.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:56:57 -0700 (PDT)
Received: (nullmailer pid 3957859 invoked by uid 1000);
        Tue, 03 May 2022 17:56:56 -0000
Date:   Tue, 3 May 2022 12:56:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Renze Nicolai <renze@rnplus.nl>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <YnFs6LSbYOFP8LzV@robh.at.kernel.org>
References: <20220428012707.24921-1-zev@bewilderbeest.net>
 <20220428012707.24921-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428012707.24921-2-zev@bewilderbeest.net>
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

On Wed, 27 Apr 2022 18:27:06 -0700, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
