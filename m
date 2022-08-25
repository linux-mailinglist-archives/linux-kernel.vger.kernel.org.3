Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11F55A1626
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiHYPxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242057AbiHYPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB15FAEE;
        Thu, 25 Aug 2022 08:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C24F261AE3;
        Thu, 25 Aug 2022 15:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE96C433C1;
        Thu, 25 Aug 2022 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661442797;
        bh=lcl0vFTidpVdCOlQ3D9Yl/rRaZDjfQugFVAoRUqha8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jqxe7QUENdxC+gytu3TxThwit/EfLlQHnkccRGNLQOZ6PBe1Toqe3uco3h1/mcfeu
         YyeiIVp5qWt4PUc4ibtQQwt6B5FP+PzOYIa3TQ0PC25SeAtoF/n6BqPpbXXVK4ZPYE
         ytlxYISoDfQTnD54yCUswWcuS7kc/7dyJ7hNjQeSaNgJI564jpdxqyaCHay+0I4yJM
         fqLdq1V+5p/mJIltMaki/RYaSbCzX88DnByrbVGWCdCa+DbArKCjxqsmIKbPcNhxSQ
         48V/tM3s/ni3SQu9ID7dP5qE7ndI3KEdhK1Qppe3g3eW0cHvK5E5ae9o2yC2XqM797
         GjyVnppzbeZiw==
Received: by mail-vs1-f50.google.com with SMTP id q67so12593844vsa.1;
        Thu, 25 Aug 2022 08:53:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo0c5PfozBX9B7FsSqoby45WPGX9TjAIH+jM5V3/UheDjgyOseCy
        RwVfqjIiQ3Ndw4sHC9WPIBbGxQthS8WuXc9F7A==
X-Google-Smtp-Source: AA6agR5wMPz3vGOLHjIiEsWE1bPB5gczSr90xEz4RUDpYOFrP7ZdunCI0sCZKIwnTvt0ascTgcJfmkWLr4e/phRUu8k=
X-Received: by 2002:a67:c09c:0:b0:390:9073:1122 with SMTP id
 x28-20020a67c09c000000b0039090731122mr1785643vsi.85.1661442796213; Thu, 25
 Aug 2022 08:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-14-p.zabel@pengutronix.de> <Yk9DtXO/yUIO45gN@robh.at.kernel.org>
 <BY5PR12MB55444E24360883E7AD731E77C6C29@BY5PR12MB5544.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB55444E24360883E7AD731E77C6C29@BY5PR12MB5544.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 10:53:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+g=oXz+j-D_xpMuiaumM5akKpJcdhm8LgRhuE0Uf1_bQ@mail.gmail.com>
Message-ID: <CAL_Jsq+g=oXz+j-D_xpMuiaumM5akKpJcdhm8LgRhuE0Uf1_bQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] dt-bindings: reset: Convert to yaml
To:     Stephen Warren <swarren@nvidia.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, May 4, 2022 at 8:08 PM Stephen Warren <swarren@nvidia.com> wrote:
>
> Rob Herring <robh@kernel.org> wrote at Thursday, April 7, 2022 2:04 PM:
> > On Thu, Apr 07, 2022 at 05:43:38PM +0200, Philipp Zabel wrote:
> > > Convert the common reset controller and reset consumer device tree
> > > bindings to YAML schema.
> >
> > In general, common bindings should go in DT schema repo:
> >
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reset/reset.yaml
> >
> > Though part of the issue is dtschema is dual licensed and all the
> > exsting text is GPL2, so permission to relicense is needed. That's why
> > the schemas are just the schema and little description ATM. Shouldn't
> > be too hard here with Stephen/NVIDIA being the only copyright holder.
>
> All the work I did for NVIDIA should be (c) NVIDIA, i.e.:
>
> # Copyright (c) 2012, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>
> I have checked with NVIDIA legal etc, and NVIDIA gives permission to
> relicense any file they hold copyright on within the
> Documentation/devicetree/bindings directory of the Linux kernel source
> tree to MIT-only, e.g. for inclusion into the new dtschema repository.

Great! However, the license for dtschema is BSD-2-Clause. Is BSD okay?
While MIT is similar and compatible, I'd prefer not to have a
proliferation of different licenses simply because people don't pay
attention when copying things.

There's another header relicensing now[1], gpio.h, which NVIDIA contributed to.

Rob

[1] https://lore.kernel.org/all/20220825104505.79718-1-etienne.carriere@linaro.org/
