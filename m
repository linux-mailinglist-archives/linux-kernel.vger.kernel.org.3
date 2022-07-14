Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C87E5754F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiGNS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiGNS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:27:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D026A9C8;
        Thu, 14 Jul 2022 11:27:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y195so4745691yby.0;
        Thu, 14 Jul 2022 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHHAmoVicpFFRe1AG6LugNyRwFvXqtAqGnNR8gzDIHA=;
        b=X+bTOZ62pL9/HmA4hfPkyUnh8Me/C2KZ/ywgwKbofh0Mkj7k9F8SZIs5hAlYet0ZuS
         9wIsUiUtQv8cDrlDGhpaHBSPBn8SD2ufXJOMf58GcY/BKtrJIWEwkEdCXP+FZnxyougC
         gtIe9Hez3x057H9WxwBl8yePhP8Otn/0V44tolcpZOqhVn9JlJ43lIyqQU7fRRnPGcxo
         0CR302hMhLECMQPLc/OmR8MUf4WoYmFZftgILsQJNe7wf76m6gS0GNsVK1td68QpK13s
         XgPVnAF29626VjlZKQK6Z7JgdFrSoB48RK2YEAT1PgEJDYIIUuyFzbujAKG/CDEr3lLV
         vrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHHAmoVicpFFRe1AG6LugNyRwFvXqtAqGnNR8gzDIHA=;
        b=58vcWsdNdkkVcYxzEnCXagzl1JnNx/tkViohHTwwOrB+HaVxjKBx3WzDq+aoWiB5uV
         HVnTxQenKQ50l77Q/ZaXD6G8J0MFSE1Kol2JOAfcZVsPMkJ+VB4Mw980neqCeETa1EBB
         NU24GPuKA1kR/+9fxx+VwLhF2ApaBm3X7C0LHt7jCmxUlbpFPIhUMzV+Rrv/wXC8c+Yl
         UW2zU7v8+8Vcjqlh3V3BBQw+BtI+MNV2zxNXeyUddJTM9j//Qw6UcyT3HAvD5c/OuQGs
         EXGA4grtfJJOXyORyZuAnnh6hcXND7jJMNOPuKPHRfZyk6Z0Yob91j2IhhTXGsnZDM8G
         1c2w==
X-Gm-Message-State: AJIora+/PeAmCal25GSAvC96HcIUOod4qTdR4KNTyVy3N8yOdAzqntYi
        1vnG5eMqslbpq+TtmEKBkwuLNKOOcS8w84iPtjbjz6ejNfGdxQ==
X-Google-Smtp-Source: AGRyM1uUoLczGcQp7vuW1nHxcpTA4w0cAng0KFgNrn0RBhSzACka+oUqQjb9tIKlOX4AHuTC5bFiTX12Biy7jWwYBMY=
X-Received: by 2002:a25:44a:0:b0:66e:e25f:e4cb with SMTP id
 71-20020a25044a000000b0066ee25fe4cbmr10380581ybe.158.1657823223558; Thu, 14
 Jul 2022 11:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185514.7d1a2ac9@canb.auug.org.au> <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X> <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
 <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
In-Reply-To: <YtBEXdrsthFamQs8@dev-arch.thelio-3990X>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 14 Jul 2022 19:26:27 +0100
Message-ID: <CADVatmNOV+jn1WSFo=z4F9KqzYAgxCWr0cxTFL_5myJKFkQNzQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 14
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Jul 14, 2022 at 5:29 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 05:21:32PM +0100, Sudip Mukherjee wrote:
> > Hi Nathan,
> >
> > On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Sudip,
> > >
> > > On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > > Hi Stephen,
> > > >
> > > > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > >
> > > > > Changes since 20220713:
> > > >
> > > > Build failures on next-20220714:
> > >
> > > <snip>
> > >

<snip>

>
> Sure! I am not sure that we have tested mips or powerpc allmodconfig now
> that I am thinking about it but we'll certainly take a look at any
> issues that come from them and see what we can do.

The build errors from powerpc allmodconfig with clang:

1)
Error: External symbol 'memset' referenced from prom_init.c

2)
drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is
not a compile-time constant
        gpu_cc_parent,
        ^~~~~~~~~~~~~
drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is
not a compile-time constant
        gpu_cc_parent,
        ^~~~~~~~~~~~~
3)
sound/soc/intel/avs/path.c:815:18: error: stack frame size (2672)
exceeds limit (2048) in 'avs_path_create'
[-Werror,-Wframe-larger-than]
struct avs_path *avs_path_create(struct avs_dev *adev, u32 dma_id,
                 ^
4)
drivers/net/ethernet/mellanox/mlx4/main.c:3332:12: error: stack frame
size (2128) exceeds limit (2048) in 'mlx4_load_one'
[-Werror,-Wframe-larger-than]
static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
           ^
5)
In file included from drivers/scsi/BusLogic.c:51:
drivers/scsi/FlashPoint.c:1712:12: error: stack frame size (2896)
exceeds limit (2048) in 'FlashPoint_HandleInterrupt'
[-Werror,-Wframe-larger-than]
static int FlashPoint_HandleInterrupt(void *pcard)
           ^
6)
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1093:12: error: stack frame size
(2128) exceeds limit (2048) in 'vcn_v3_0_start'
[-Werror,-Wframe-larger-than]


The (1) is also seen with gcc-12 on mainline -
https://lore.kernel.org/lkml/Ys%2FaDKZNhhsENH9S@debian/


-- 
Regards
Sudip
