Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52F52AB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiEQS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiEQS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:58:46 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31F50053;
        Tue, 17 May 2022 11:58:43 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n24so23399209oie.12;
        Tue, 17 May 2022 11:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I3ZXSbwtXnbTG8zgREWqc9qR1l4Fnmm+ZYjnu3VE+lA=;
        b=NDwXTTqbD78D3KSTibz24Jk/Cup9BFXX2Jlv5BfbExMWzCa+ktFigktaczkIy0h9uK
         iVEMNz5t4DEdEuev9KN8Ad0FjwqM5ULyA/GKLszoGOs+BBDGe6FibdqhURdSbTp0iIIC
         U/UQ/SPQvUtr0vkkTT9mBAlBEZRG3y9XjqGYKLcgEKNei6XLlszSAKkmymUutwmW0nw8
         /j3AQhqWlpTlJy6qTyjlUvvEgHBQLm3qY0c+Z7psf2JnritNVHq+j4NP8wg/v+mkVhLV
         sVcVjS7Y5+6f9FbDItnjgi57GtrQCGghvzsnzoaQIEO6OUF2l7LABVZbCOsVZJz41VZ6
         dcWQ==
X-Gm-Message-State: AOAM530hg6D/7JwVkkJZJYW+CYFIqlBZ6JMmksERQeXAPNVtujD4xpnw
        3uph71mqD53AXB+8u6LJiQ==
X-Google-Smtp-Source: ABdhPJxrzDvBkqwcRQsKquYBOMXgBblq7AmcvwunVmwPxmIQE/e9kRoM0tLUsgCYudhkP+buO0TuJA==
X-Received: by 2002:aca:c20b:0:b0:326:d448:43fb with SMTP id s11-20020acac20b000000b00326d44843fbmr16849871oif.12.1652813922797;
        Tue, 17 May 2022 11:58:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp17-20020a056870659100b000e686d1387csm112570oab.22.2022.05.17.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:58:41 -0700 (PDT)
Received: (nullmailer pid 1424064 invoked by uid 1000);
        Tue, 17 May 2022 18:58:41 -0000
Date:   Tue, 17 May 2022 13:58:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop
 dma-coherent property declaration
Message-ID: <20220517185841.GA1388602-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 02:17:48AM +0300, Serge Semin wrote:
> It's redundant to have the 'dma-coherent' property explicitly specified in
> the DT schema because it's a generic property described in the core
> DT-schema by which the property is always evaluated.

It is not redundant.

The core schema defines the property (as a boolean), but this schema 
defines it being used in this binding. Otherwise, it won't be allowed.

Rob
