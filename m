Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF024E9FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiC1TeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiC1TeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CC5DE4E;
        Mon, 28 Mar 2022 12:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9265B61291;
        Mon, 28 Mar 2022 19:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CFBC340F3;
        Mon, 28 Mar 2022 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648495940;
        bh=hsj7vpD6VzgwgqTGJwuQLzl4hvMkV3jhPtqSZ0sfeDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SNrCTUVspAbKGzkl/lkX7LEl6vPIPwqohKfQS9j4wkOpVeD4AC+KSvULMyl9G55Jg
         cvfYgsKOx6Hu8vQjstDuuVmtLUToCxVMBhEA7FrUd5cZIm75Qm+TeRN9RS4aPKnQ8s
         4VdTQMh25Fzqi23HYRD5azwSQUL4od4FBcYQ/fGPYvBUJXJjbspEqr29SZYyM1f0wB
         ZVDQ0hnYEbkmvCEmJc0CRniluyzKwTE0RE7mMXVz3f34vh8LVY8Ic7yvjqtJelPsvg
         1p3dQa/I00QKG5gziprxkUBf0YEhl/dnQRJSI8QDwxDggof97taB5T49zkVWsy22d/
         cmkv6heGq2EfQ==
Received: by mail-ej1-f48.google.com with SMTP id o10so30824503ejd.1;
        Mon, 28 Mar 2022 12:32:20 -0700 (PDT)
X-Gm-Message-State: AOAM532Vt9SL/rAbaUw2fVxZBHBUACmcNubMghaB6Dncb4XhBzOJ9gN7
        kaQv/Kdvr6DHo0Xl2T35jEwBempx0RUVYS0vOA==
X-Google-Smtp-Source: ABdhPJzS6HE1I5dwIXHt3Z8+oNfExeRu/Ld613R99JBEBBtqUIPwWmfatFTRXQVhLFWR4Q056OlfLe821+lCv3qLtzU=
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id
 e14-20020a17090658ce00b006dab5481bbbmr29647735ejs.14.1648495939083; Mon, 28
 Mar 2022 12:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru> <20220324001628.13028-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-3-Sergey.Semin@baikalelectronics.ru>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Mar 2022 14:32:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnnVKmCA6he_A-OAgu1xD1bjHBy4_eXf64q2LJ9+L3_g@mail.gmail.com>
Message-ID: <CAL_JsqKnnVKmCA6he_A-OAgu1xD1bjHBy4_eXf64q2LJ9+L3_g@mail.gmail.com>
Subject: Re: [PATCH 02/21] dt-bindings: ata: Convert AHCI-bindings to DT schema
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 7:16 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Currently the DT bindings of Generic AHCI Controllers are described by
> means of the legacy text file. Since such format is deprecated in favor of
> the DT schema. Let's convert the Generic AHCI Controllers bindings file
> then to the corresponding yaml files. There will be two of them: a DT
> schema with a set of properties applied to all AHCI-compatible devices,
> and a DT schema validating an AHCI-controller on a generic platform. So if
> a controller conforms to the Serial ATA AHCI interface specification with
> just peculiar platform environment settings like clock sources, PHYs,
> power regulators or resets, then the generic AHCI bindings should work for
> it. Otherwise a dedicated DT-schema needs to be created.
>
> So a common AHCI SATA controller DT-node is supposed to be equipped with
> at least compatible, reg and interrupts properties. It can optionally
> contain clocks, resets, {ahci,target,phy}-supply and phys phandles. In
> addition the property "ports-implemented" can be specified in order to
> define the number of implemented SATA ports. An AHCI SATA controller
> DT-node can also have a set of sub-nodes representing its ports, for each
> of which an individual power source and PHY phandle can be specified.
>
> Note we have omitted the next compatible strings
> "marvell,armada-380-ahci", "marvell,armada-3700-ahci", "snps,dwc-ahci",
> "snps,spear-ahci" since the corresponding controllers are handled by the
> dedicated drivers now, thus are supposed to have their own DT-schema
> defined. dma-coherent has also been discarded since it's a generic
> property and is evaluated by the dt-schema parser.
>
> Also note that if there is the "reg-names" property specified for a AHCI
> DT-node then it is supposed to at least have the "ahci" sub-string as an
> indicator of the AHCI-compatible registers space.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 110 ++++++++++++++++++
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 -------------
>  .../devicetree/bindings/ata/generic-ahci.yaml |  89 ++++++++++++++
>  3 files changed, 199 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/generic-ahci.yaml

This has already been converted and is in Linus' tree now for v5.18.

Rob
