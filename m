Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031F3578BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiGRUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiGRUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:34:43 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE411C1C;
        Mon, 18 Jul 2022 13:34:43 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h145so10264503iof.9;
        Mon, 18 Jul 2022 13:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fwNczFHD3Vu7v1FlEOjKVfCQSdrj4GhMrwGGzxY8cs=;
        b=nM/ONu/4PDPwn2RQsUGVFa8oYAiNyeO3gHMZ67pelCPbWxdt8DmH5HOm+qS7hxSpb+
         ZOWp5eQu0BiZdgFM5brwp4yKIrsjpqgg7CC2on/snt2ZtqZVlYBuU05tUKBu4uS6sqJ2
         JlFyoSBxEFEnzOyxsURtV9+vJErVwGyWxAyfoZZ77u6gnI9gBMFwokV+aKCaI80xzQwx
         kDbF8qRP32USqkyKYAAlc3DW8ZrK7lIU44adytvrImRig2QlL87l4yBl5IToX4md+weD
         WgCyR5cwQSktNA0gLYdXQ8l2TV6cefM+2gFeUK0Llbf2TVSmqzGGoxzbgcfg+FazW0WE
         rR6w==
X-Gm-Message-State: AJIora/jllFCcglKgSDFTGHMaBeDkP2zuwY/pZ68vJnBAzrHEE8xYyYc
        rYoojQZsvcdMIJaCCTby4w==
X-Google-Smtp-Source: AGRyM1vfV3f9iJDVM+Ly0aKtxIJ9fMd4Qa130TnYOdinhVI9JcFvVhVnA/tmbNIXemlEq95sibFZ9A==
X-Received: by 2002:a6b:fd0e:0:b0:67b:7fe0:c29c with SMTP id c14-20020a6bfd0e000000b0067b7fe0c29cmr13312725ioi.5.1658176482305;
        Mon, 18 Jul 2022 13:34:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g63-20020a028545000000b0032e49fcc241sm5792945jai.176.2022.07.18.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:34:40 -0700 (PDT)
Received: (nullmailer pid 3503906 invoked by uid 1000);
        Mon, 18 Jul 2022 20:34:39 -0000
Date:   Mon, 18 Jul 2022 14:34:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220718203439.GA3503849-robh@kernel.org>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
 <20220713052917.27036-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713052917.27036-21-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 08:29:13 +0300, Serge Semin wrote:
> Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> with the next specific settings: two SATA ports, cascaded CSR access based
> on two clock domains (APB and AXI), selectable source of the reference
> clock (though stable work is currently available from the external source
> only), two reset lanes for the application and SATA ports domains. Other
> than that the device is fully compatible with the generic DWC AHCI SATA
> bindings.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Drop macro usage from the example node.
> 
> Changelog v4:
> - Use the DWC AHCI port properties definition from the DWC AHCI SATA
>   common schema. (@Rob)
> - Drop Baikal-T1 syscon reference and implement the clock signal
>   source in the framework of the clock controller. (@Rob)
> 
> Changelog v5:
> - Drop generic compatible fallback "snps,dwc-ahci". (@Rob)
> - Define SATA-port pattern property to be applicable for two ports
>   only.
> - Drop "|" qualifier from the description property.
> ---
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
