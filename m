Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4701D54BD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiFNWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiFNWRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:17:16 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6154522EC;
        Tue, 14 Jun 2022 15:17:15 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id y16so7587670ili.13;
        Tue, 14 Jun 2022 15:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Anh4TEWagh/wL2rBGHOroApYX7iOj59aiEo6256SbKM=;
        b=iIYwXAs9cmQUzWHcu4KdDK5aHBRumhDRxDvzWS9pM7lU/crSp7Ytr/HGd2qbpGTg8o
         ZGnWZfXyCWmM8qgdRqBIknL7mmosEdY7mTXSinb5onkiN7OXnkMPVAbSu7XCpj81X4IW
         Gf3oLxTr8LfGavXJW9c18aFBSO69bC1/1jBYXX2jS/vIZEX1w7tGoLyxWDj8hFnlMcyx
         rNrkelDGGAq7uwHdCpRx/U+peS7cVvbpr78oIAkVoccLh9Tm4EIAV+KAGwk44A0ZyTpn
         7etzEz4KbMSfoXOYhma1+4S4iMZ62gZbsy9vfICnjRC2mdlRl5Ix0TqrrfzjD74/H+sv
         Wkow==
X-Gm-Message-State: AJIora/SB+jnJeQns7Nzo789jql6Zb0KF+tLas+bEdiGeFRrG/cox9cO
        qRIovvdc+AEBh/dFgzPct7a+EAu1rA==
X-Google-Smtp-Source: AGRyM1v9bqgvzsUDPWrrL1gU4INLXqJdK/6gGcOPs5LFukW7Ug3hh42G8/XFobeSXPl9ARsa6FUSUQ==
X-Received: by 2002:a05:6e02:16ce:b0:2d3:edec:17a5 with SMTP id 14-20020a056e0216ce00b002d3edec17a5mr4311743ilx.4.1655245034980;
        Tue, 14 Jun 2022 15:17:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f98-20020a0284eb000000b0032df31d45fesm5322400jai.166.2022.06.14.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:17:14 -0700 (PDT)
Received: (nullmailer pid 2823959 invoked by uid 1000);
        Tue, 14 Jun 2022 22:17:12 -0000
Date:   Tue, 14 Jun 2022 16:17:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
Message-ID: <20220614221712.GA2823883-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-4-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 10 Jun 2022 11:17:41 +0300, Serge Semin wrote:
> Indeed in accordance with what is implemented in the AHCI platform driver
> and the way the AHCI DT nodes are defined in the DT files we can add the
> next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
> name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
> by design, AHCI controller can have up to 32 IRQ lines.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 
> Changelog v4:
> - Fix spelling: 'imeplemtned' and 'paltform' in the patch log. (@Hannes)
> - Add the interrupts property constraints. (@Rob)
> - Add forgotten '---' patchlog-changelog separator. (@Sergei)
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml    | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
