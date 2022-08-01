Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721D586AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHAMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiHAMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3895C0D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F5F3601CD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC42EC433D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659355793;
        bh=Dj1WIaCLQ5ggZ5YYu7kWg3EE1ARgkRRqTx0wUE79N1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+VOQW+SUaPWZGfEtTnRKM9wkL7ZL5NmiF2/xp8QvARdIFIZA7xwhjCd9KsNpnlEj
         glohiSMODaiuT6YFBP0kBCMI91LXKRzivrvXau/VHLn8Da5Z0sZDaLJM2uZ3IGx9qE
         zvnkh1t//1KWbMJJNR86u7OBTD8eDZcB3ykxbBJQMeGBTX7xUxZQR3qIZMXHMlXOTx
         LmGPLDG67Mmv9DS5j9Sp9MmxixLjWXf3lXIe6ccFUe/MVy+JF93yJ5bucIVvY+1kPL
         o4cgqpzQWljJQFPmDCoc9xN+dfuKgoN4+qwd134qr3fZjmtGq6uTRwXRnuzy28gbsx
         WqnonsX1TDiug==
Received: by mail-vs1-f48.google.com with SMTP id 129so10962831vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:09:52 -0700 (PDT)
X-Gm-Message-State: AJIora/mr3vPBqSxOiBdXO6ibrKUd3Rj8ob8l5apbVuPPPKsv9ywHVwv
        9H7Yac5RnO++L9OTtR7d7UqcqYXLTVhI4zTgn0s=
X-Google-Smtp-Source: AGRyM1s0etQ9Pvllk/JiNzbTQ6QGqNTG4QGA7PokgrtQugX90IoTP+3B3Ap08D0LMddUwtf24xueuWULWjo15yBKjXY=
X-Received: by 2002:a05:6102:dd4:b0:358:62b5:20a6 with SMTP id
 e20-20020a0561020dd400b0035862b520a6mr5613984vst.84.1659355791817; Mon, 01
 Aug 2022 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn> <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn> <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
 <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn> <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
 <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
 <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn> <ba5e99de-0719-af88-4d94-8860787a4251@loongson.cn>
 <d6cab26afc5829c1b93bc1cc5867ebf22f5c7f47.camel@xry111.site>
In-Reply-To: <d6cab26afc5829c1b93bc1cc5867ebf22f5c7f47.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 1 Aug 2022 20:09:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7pWc2bNtdyoczmANiNLSs_+A1ZVhakMdrZjGFXpMzCfQ@mail.gmail.com>
Message-ID: <CAAhV-H7pWc2bNtdyoczmANiNLSs_+A1ZVhakMdrZjGFXpMzCfQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Lulu Cheng <chenglulu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Mon, Aug 1, 2022 at 7:40 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Mon, 2022-08-01 at 19:28 +0800, Youling Tang wrote:
>
> > > Actually, I really hope kernel image is in the XKVRANGE, rather
> > > than being in XKPRANGE. So that we can limit kernel and modules
> > > be in 4GB range. I think it will make all work normally. :-(
> > >
> >
> > Assuming that the kernel and modules are limited to 4G, the external
> > symbols will be accessed through pcrel32, which means that there is no
> > need to pass the GOT table entry and there is no need for got support
>
> We'll still need to modify GCC to use PC-rel for accessing an object in
> another TU (by default, or an option to control), instead of GOT.  Or
> just add support to GOT relocations here.  But anyway it will be much
> easier as we won't need to handle per-CPU variables specially.
All tlb-mapped kernel may be supported in future, but no now. Because
there are a ton of problems. :)

Huacai
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
