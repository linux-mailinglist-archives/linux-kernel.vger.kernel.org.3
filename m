Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD61E53B470
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFBHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFBHjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:39:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E22B6A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:39:16 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGQzj-1o0Dex475B-00GtJs for <linux-kernel@vger.kernel.org>; Thu, 02 Jun
 2022 09:39:15 +0200
Received: by mail-yb1-f179.google.com with SMTP id v106so6990922ybi.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:39:14 -0700 (PDT)
X-Gm-Message-State: AOAM532h64DS1y2cu2PYmKKk7cQ8sMdDgBCtndN3EuEj+osufcX063IU
        KcrqzF8DdA8y1m213r/B5/7Ea3fA2zXgq/zPObY=
X-Google-Smtp-Source: ABdhPJxVfhxEh2sV1U0/oHXedOW7Ij9SWgaqXnw+k1hmmKvq9A8gu2wmdTH5eNlILVHHm3z97S0Z2Co5/rXDXyJX6t0=
X-Received: by 2002:a25:1209:0:b0:65d:63f9:e10a with SMTP id
 9-20020a251209000000b0065d63f9e10amr3777324ybs.480.1654155553742; Thu, 02 Jun
 2022 00:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr> <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
 <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
 <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr> <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
In-Reply-To: <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jun 2022 09:38:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1m80u+eVnoSJ-APihjNQ1se9=FG+E6tKBb-hRJx5FAVg@mail.gmail.com>
Message-ID: <CAK8P3a1m80u+eVnoSJ-APihjNQ1se9=FG+E6tKBb-hRJx5FAVg@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bmGudR30UqgCyxb4uB8IfnXmoAhOVyjKEZu/2RkRLoC5XAZmE0B
 p1vzLOCjrRFlA2K3LC1Yjuu6A21oLly70jZi3Id1rr06hILXUdPoI9hshrpo2eBpzjNL3M+
 9yvYBo9Qk+v9AQl/7kgxYMWQmnEE2LTl3DOc6UkFYtaBtnIwCV7yquT5C/1pPB2GmJbwSKt
 CG9NE5myCyjT3bR5j+XSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4iGwRpuhPLk=:2Dm31xDFgrwg97hVht86jI
 vftEpMBZtbwFlXdvAehOw5n+Pkb+tgY6i56F2UKozIVdCrAom3HWgGGkQsAigOl9vjBvdR+vB
 xrWEa8TjiXyyhmZYIsv1s2+1uF+NZuP0e40v1CTpV/mbrU7HHCDzeHGefBGy0Yf2Na5b3/oPz
 io10SGYGQdwv/7BOErNZmx4pQ2p9arzVYZOedPowwnw/kL/lMl9/2zXGPo5/mKPQuK30lSS5x
 0DVc4QpWNepLbunWQ6oq4Sn2S4zQscszfm2wBrpKA+Ghx40WrtMCo4r28tZIRFKOeUNzAKXkB
 ThvbHUZnpaXzEnDGXN/jmiweY7qiGRU50Xmp7BpgRMlC4AlFewIUz9LEhFn1/kEtWsB6UtVcM
 2eYJ7dj1KpQkVVAyz6WZ7hDXdo2tgrvtzbbZkTTNtHGfSUIWvKxwVBd77FllcU57Qa0UqW7Sj
 w365HWBngfzCzgwj1nS+nqZdNY6mekGzcAAyg1NSLNEYwvtA/tEajHVfTVpawmUfw6CQohFGU
 Qs8TSA2pERRFRvetxeUtFRznWkZ4UeACsk94gil2ZvXHJOWa3pwC/7EX/HMh/gD18tFK9kywV
 W1iwNyj46QDdkRsqwECm17SoiyEGIwEXduBsziNplDzTpS41LKekWWt6+OsI73nX0veTL7MrS
 MkACQhQkzpm8ta1aZy/C6hZzNZfvJs1P4vLf9E6dQmpORKEbSz+biffsFqNoHHyP/591CmTPT
 hvjhZEtQRSmUbSNfBr0+Wsk4Nk6dgTxEAwtpvTnZ6+V0dphtPOQrLFfI3Qje/1Zau8h3pnG5r
 bUXlB1W4MnK3mtD3efW389iFF7gZ5rdZFS/Jrrh5RDdgbu2R27tX9Kb85az57p8OZbOrdvRPx
 jDZXVrcVN6ZaAWdm2N4A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 3:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jun 1, 2022 at 3:28 PM Keisuke Nishimura
> <keisuke.nishimura@inria.fr> wrote:
> >
> >
> > I found 13 definitions of packed structure that contains:
> >  > - spinlock_t
> >  > - atomic_t
> >  > - dma_addr_t
> >  > - phys_addr_t
> >  > - size_t
> >  > - struct mutex
> >  > - struct device
> >
> > - raw_spinlock_t
>
> Ok, so I don't think dma_addr_t/phys_addr_t/size_t are problematic,
> they are just regular integers.
>
> And 'struct device' is problematic only as it then contains any of the
> atomic types (which it does)
is
I suggested this list because they are problematic for different reasons:

- any atomics are clearly broken here

- dma_addr_t/phys_addr_t are sometimes put into hardware data
  structures in coherent DMA allocations. This is broken because these
  types are variably-sized depending on the architecture, and annotating
  structures in uncached memory as __packed is also broken on
  architectures that have neither coherent DMA nor unaligned access
  (most 32-bit mips and armv5), where this will result in a series of
  expensive one-byte uncached load/store instructions.

- having any complex kernel data structure embedded in a __packed
  struct is a red flag, because there should not be a need to mark
  it packed for compatibility with either hardware or user space.
  If the structure is actually misaligned, passing a pointer for the
  embedded struct into an interface that expects an aligned pointer
  is undefined behavior in C, and gcc may decide to do something
  bad here even on architectures that can access unaligned
  pointers.

> > security/tomoyo/common.h: atomic_t in tomoyo_shared_acl_head
> > drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h: spinlock_t in key_map
> > arch/s390/include/asm/kvm_host.h: atomic_t in kvm_s390_sie_block
>
> So these do look problematic.
>
> I'm not actually clear on why tomoyo_shared_acl_head would be packed.
> That makes no sense to me.
>
> Same goes for key_map, it's not clear what the reason for that
> __packed is, and it's clearly bogus. It might work, almost by mistake,
> but it's wrong to try to pack that spinlock_t.
>
> The s390 kvm use actually looks fine: the structure is packed, but
> it's also aligned, and the spin-lock is at the beginning, so the
> "packing" part is about the other members, not the first one.

Right, I think the coccinelle script should nor report structures
that are both packed and aligned.

> The two that look wrong look like they will probably work anyway
> (they'll presumably be effectively word-aligned, and that's sufficient
> for spinlocks in practice).
>
> But let's cc the tomoyo and chelsio people.

I think both of them work because the structures are always
embedded inside of larger structures that have at least word
alignment. This is the thing I was looking for, and the
__packed attribute was added in error, most likely copied
from somewhere else.

Looking at the other ones:

include/linux/ti-emif-sram.h: phys_addr_t in ti_emif_pm_data

No misalignment because of the __aligned(8), but this
might go wrong if the emif firmware relies on the structure
layout to have a 32-bit phys_addr_t.

drivers/scsi/wd719x.h: dma_addr_t in wd719x_scb

This one is correct, as the structure has 64 bytes of
hardware data and a few members that are only accessed
by the kernel. There should still be an __aligned(8)
for efficiency.

drivers/net/wireless/intel/ipw2x00/ipw2200.h: dma_addr_t in clx2_queue

Al marked the incorrect __packed annotations in 2008,
see 83f7d57c37e8 ("ipw2200 annotations and fixes").
Mostly harmless but the __packed should just get removed here.

> drivers/infiniband/hw/irdma/osdep.h: dma_addr_t in irdma_dma_mem
> drivers/infiniband/core/mad_priv.h: size_t in ib_mad_private

Same here: harmless but __packed should be removed, possibly
while reordering members by size.

> drivers/crypto/qat/qat_common/qat_asym_algs.c:
> - dma_addr_t in qat_rsa_ctx
> - dma_addr_t in qat_dh_ctx

Probably harmless because the structure is __aligned(64), but I'm
completely puzzled by what the author was actually trying to
achieve here. There are also 'bool' members in the packed struct,
which is probably something we want to look for as well.

> drivers/atm/idt77252.h: dma_addr_t in idt77252_skb_prv

This is a bug on architectures with 64-bit dma_addr_t, it should
be an __le32, and the structure should be __aligned() as a DMA
descriptor.

> drivers/net/wireless/ath/ath10k/core.h: dma_addr_t in ath10k_skb_cb
> drivers/net/wireless/ath/ath11k/core.h: dma_addr_t in ath10k_skb_cb

Should almost certainly not be __packed, fixing these will
likely improve performance on mips32 routers using ath10k

> drivers/crypto/ccp/ccp-dev.h: dma_addr_t in ccp_dma_info

This looks ok, the "__packed __aligned(4)" here can save
a bit of stack space as intended.

I think that SmPL script worked great, almost every instance is
something that ought to be changed, as long as it stops reporting
those structures that are also __aligned(). I would extend it to
also report structures with 'bool', 'enum', or any pointer, but that
could give more false-positives. Maybe have a separate script
for those instances embedding atomics or spinlocks (very broken)
vs the other members (causes more harm than good or might
need alignment).

       Arnd
