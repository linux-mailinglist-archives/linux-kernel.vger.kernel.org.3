Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315E52C929
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiESBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiESBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C424606EF;
        Wed, 18 May 2022 18:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788C9617C1;
        Thu, 19 May 2022 01:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0865C34113;
        Thu, 19 May 2022 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652922961;
        bh=4Chm6xML4mWgEF6mVPZfP9tob/66eosW2tYLbukSKuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZxtTQGFLSvXTl/WNJKiSMifryXrMmXYOZbj/s+rTfRTkQEHBh0mMaNglXEMclf7pF
         eKQbqMcFummxLDTMmrfBvbnjO+PM+L0G9oV/rxGEBQuHs8THJSL7rT9sXgSiJqGxC6
         E0k6iu97mmuvNQPZcf4E7dw6tzXFyJm2a5Qwzy093Yfx/LW1o4xDYmSqpY9Z7sqSyU
         sWeudSxmuM6G2tQxex2tM8UbQ8aiFxf6hJ69aWNKQRSb3n8vnqyXqLyiz21uQcTkca
         RO2o2norLyr1LkCEvTqez0kEzezNer/oW2HSu3mKxX1eElixCwoXR6PeDXLu+4dwcy
         6qn6lcxKzlmlA==
Received: by mail-vk1-f171.google.com with SMTP id t12so2046509vkt.5;
        Wed, 18 May 2022 18:16:01 -0700 (PDT)
X-Gm-Message-State: AOAM533+Xc+kLoYIri9LM/KypTl5vHZaLP2trvHGDC/6TvXmgmxK95aL
        zGO29TD0axlgqstU26E2hzykIVaJP3eYxPD2TRU=
X-Google-Smtp-Source: ABdhPJwQ0XBOizV1zF/tYqQm+w92KmR6Cwb2rfYMjIJmCD1E+9pvyrBuwwWnAIEvIU7pt8qHL54exl5k/3TZp4HVUUg=
X-Received: by 2002:a1f:1609:0:b0:34d:ff24:30ef with SMTP id
 9-20020a1f1609000000b0034dff2430efmr1065232vkw.14.1652922960673; Wed, 18 May
 2022 18:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220519105448.74a4447e@canb.auug.org.au> <20220519110008.586bc47f@canb.auug.org.au>
 <20220519110403.7e797df7@canb.auug.org.au>
In-Reply-To: <20220519110403.7e797df7@canb.auug.org.au>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 19 May 2022 09:15:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6PF44ZZPro1w1RzOMHBwYUA0pxYQuC+pxu-XpTnJ8qyA@mail.gmail.com>
Message-ID: <CAAhV-H6PF44ZZPro1w1RzOMHBwYUA0pxYQuC+pxu-XpTnJ8qyA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pm tree with the loongarch tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen,

On Thu, May 19, 2022 at 9:04 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Thu, 19 May 2022 11:00:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 19 May 2022 10:54:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> >
> > >  +  u32 count;
> > >  +};
> > >  +
> > >  +/* LPC Interrupt Controller */
> > >  +
> > >  +struct acpi_madt_lpc_pic {
> > >  +  struct acpi_subtable_header header;
> > >  +  u8 version;
> > >  +  u64 address;
> > >  +  u16 size;
> > >  +  u8 cascade;
> > > ++
> > > + /* 17: OEM data */
> > > +
> > > + struct acpi_madt_oem_data {
> > > +   u8 oem_data[0];
> > >   };
> > >
> > >   /*
> >
> > I missed adding the closing brace after struct acpi_madt_lpc_pic.  I
> > have added that to my resolution now.
>
> Not a good morning :-( I also forgot the comma after
> "ACPI_MADT_TYPE_RESERVED = 24".  Added now.
As you said before, my tree lacks a MAINTAINERS entry, can I rebase my
tree to fix that now? Or is it too late?

Huacai
>
> --
> Cheers,
> Stephen Rothwell
