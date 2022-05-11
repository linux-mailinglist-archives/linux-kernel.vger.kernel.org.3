Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65EB522C16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiEKGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiEKGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:09:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E730106A7D;
        Tue, 10 May 2022 23:09:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k2so1417663wrd.5;
        Tue, 10 May 2022 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VHraj8d06YM+De4Pnpm/ftVhB4j15aURh4OR3XtQQs=;
        b=eRq98BENscelG1cmv/7KdEfz37qy++0ZvRiGwjts7OYmQnJYTfoyhT12xutzugvRIb
         xA91PdIdQlQlYtyXshVyKPlGA29Ly68zQbYZW9BypgLRH6rgbm8Uq8OwhtQpGViAuWx+
         ir9yaQ3hCoV7+0wSmnwSP/4RSjOH4RY146Xmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VHraj8d06YM+De4Pnpm/ftVhB4j15aURh4OR3XtQQs=;
        b=q2yKX7o4uadC7GZlNv3aLrjZfV48cMp51gKBTKKPKy5jF6OHknbGF6UtvdcCbT+jGG
         0pK+Lg6g6dA7IEI4yKDZ6KGTmPtKYi4AGxVmgqm8V0GansSyWr39swtpZz6ly8S+8Nen
         aJBIq4p539jQaIDz4EWJQzpN+m4doXR8nm0lM2cgvu0BQRf4bOEihX9OVMoXAKDh1FVK
         DdHOsT2piyW/UvPFVs8uU/rpicNBZn52ZtiNuheEcl3JZml7cB6A0D2j/iULcz6fCcP+
         37hgSkRisuCtv93piIxr2bibBoFX2DK5jRhzzp2Z2Adgwcy88OFdr4rIbAbpHTAlAj2d
         7+QA==
X-Gm-Message-State: AOAM533EBQgTgZXeJqUCckWRZVmD8bA/bHe2SDnpkpQ9xKsX/ASV21iG
        mviXsl0n+J4QWDuMXbFXkUtzD9N1Rn9dkdWyiCY=
X-Google-Smtp-Source: ABdhPJyjDLNrgyQtYLmk0GuQSBajTH2voVldGLT2eHhEtoR8SqbzkHxfdWJfAsyGl8t5S9qpn5RGgyG9B1Gia/zSL8U=
X-Received: by 2002:a5d:6d04:0:b0:20c:52de:9ce4 with SMTP id
 e4-20020a5d6d04000000b0020c52de9ce4mr22646590wrq.572.1652249384925; Tue, 10
 May 2022 23:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 May 2022 06:09:33 +0000
Message-ID: <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARM: dts: aspeed: bletchley: update dts file base on
 DVT schematic
To:     Potin Lai <potin.lai.pt@gmail.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 15:14, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> This patch series update Facebook Bletchley BMC devicetree base on DVT
> schematic.
>
> - EHCI: enable ehci0 for detecting and accessing usb device on sled
> - MDIO Bus: enable mdio0 for accessing switch registers
> - SPI2 Flash: switch spi driver back to aspeed-smc to improve performance
> - EEPROM: add eeprom node on each sled
> - GPIO:
>   - add PCA9536 IOEPX node on each sled
>   - update gpio line names

These look fine to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Patrick, did you want to review them before I merge?

>
> Potin Lai (6):
>   ARM: dts: aspeed: bletchley: enable ehci0 device node
>   ARM: dts: aspeed: bletchley: switch spi2 driver to aspeed-smc
>   ARM: dts: aspeed: bletchley: Enable mdio0 bus
>   ARM: dts: aspeed: bletchley: update gpio0 line names
>   ARM: dts: aspeed: bletchley: add pca9536 node on each sled
>   ARM: dts: aspeed: bletchley: add eeprom node on each sled
>
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 180 ++++++++++++++----
>  1 file changed, 145 insertions(+), 35 deletions(-)
>
> --
> 2.17.1
>
