Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0CA54BD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbiFNWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbiFNWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:17:35 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15CE18E3B;
        Tue, 14 Jun 2022 15:17:32 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id f7so7621677ilr.5;
        Tue, 14 Jun 2022 15:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlEqC6vkj6C3Sdtuk0iXJCFFYdPTzdPTWFY/49tYQzk=;
        b=wMySDS15eCL+QBRs53LItKmcwrpLMPXdkLXU2Qw79seB6MR9OeFo1m61wPRK3D2MIe
         phgRBMqo+xTuenUu3cHdCsVEvIK2yHHzj0KNVN/+1+1dUhafp1KYTfNW6OLBXHU2hsN4
         97aBvemCYOzVA9ROP40zf0zWwGndtn8bZ6DQhFbQhgV7ZZT7oe9sluFeb7ASXOphQo/D
         0aB+KIacR88zHYUmV8Vn7VzUQjO4CK7OFy/LDpnuAOMjlYpFFQ8uwvzk+j86dCRgpgGS
         QVV8rdj6eUvcHE9CfLDHq6HBkEeSMa4WP/Qpbrmmbs5j+GJgHjwxatN/7gTY4ffG1fLS
         0rsA==
X-Gm-Message-State: AJIora/619n+7m/a4O5XVz18spLj2JWnpBRrjM42XLaPLto2b/ldecEM
        /j6gPCzUOCnJ/e82bUgHL8NKr6txdw==
X-Google-Smtp-Source: AGRyM1vvD9keE6+vqlsBRRskZIzfchTZlpAdw/MRaCFN0i6Gf7aaf+F1m2nkZjaQO7FRmRF/T1UcFg==
X-Received: by 2002:a05:6e02:d52:b0:2d5:2e0f:184b with SMTP id h18-20020a056e020d5200b002d52e0f184bmr4199730ilj.207.1655245051923;
        Tue, 14 Jun 2022 15:17:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y37-20020a029528000000b00331e8b4c421sm5302331jah.34.2022.06.14.15.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:17:31 -0700 (PDT)
Received: (nullmailer pid 2824451 invoked by uid 1000);
        Tue, 14 Jun 2022 22:17:30 -0000
Date:   Tue, 14 Jun 2022 16:17:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Hannes Reinecke <hare@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 05/23] dt-bindings: ata: sata-brcm: Apply common AHCI
 schema
Message-ID: <20220614221730.GA2824385-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-6-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 10 Jun 2022 11:17:43 +0300, Serge Semin wrote:
> The Broadcom SATA controller is obviously based on the AHCI standard. The
> device driver uses the kernel AHCI library to work with it. Therefore we
> can be have a more thorough DT-bindings evaluation by referring to the
> AHCI-common schema instead of using the more relaxed SATA-common one.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch added on v4 lap of the review procedure.
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
