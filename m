Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D992573679
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiGMMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiGMMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:38:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC351117
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:38:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l15so4705073qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfVKz9EMLwYD8yPKHpb7OTebSfDbc6Ne50FK5Fsr5Pg=;
        b=btxY+bzCWpk6w8uVAzut9aixH3CdtWbtfaW1RLvcWawLdrvPG4UGFFIBfVOiqbK8AF
         zA1mBQm0HTIDebwdRKVfEk1W0v5ge2+9PnyRpqfgIeFJWIpmnzk/bvMd0rW8cIHNlPZU
         131gZD+nL1YLvs2L24aef0uLS7E9vxPqhNf5aK0nv+F6lvNqssy1CHopNrwtuIwGKMN8
         f1VwwHCMHjkp7c40Z9d9NbdBOCKtJVLoYzLBSt+z+gtDD/cX2t/5IPiqz96JxJfzvmRt
         /CX4PI/SdqG36qPMyoyQ5/XaYa4zRzLhyW++Or2dZVNHCftPOWtA9thZm8TbQQR/BqEO
         8mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfVKz9EMLwYD8yPKHpb7OTebSfDbc6Ne50FK5Fsr5Pg=;
        b=GFMaPQffhzWeQxSydTiZnfx0edmmW3WvmdgdEpEa7WS/LnaNl9MP19TGTJDWMuci0B
         tZyqcCNxTKGdwUAMjz55XjLbzPORW49UuhMuP6O8lLyVTf0ZCmvBfwpvy38i8prpZTkw
         cb+pOzTiIqdZFz76qyTLevcg7G2rnQAiR4oyqam82WGpitiKEA179OOKmRSFlYF5aoDd
         e7z3oh8bWrYHv/q15hPAao5v025XgnQ13Eq2G+8I3rW1yA7DvAQV9711AcNhcVEy0WkY
         rXwCoZcOhyNpYEhu4awyNVSvm7CwxFjL3aRxw+U/NO1qUfl5D+h8+oJz3dfMP3DddCHU
         J1Fw==
X-Gm-Message-State: AJIora9gXIR3ArWod688tiIbBw7bgHUW9Cjhno35bNoyFfSNUdtQZeaF
        EEoXlmNuCPPE6YI2XPRjl8rZShGp5Q6+A95l/rM=
X-Google-Smtp-Source: AGRyM1vKYJan05es/s86z6q+lFhXRpeJxPhVx6g39tSR9BfpPxAcYVEoOnodvrQY63sfrHEMpynF8q+WCUhvR6hOV2s=
X-Received: by 2002:ad4:5765:0:b0:473:20e:746c with SMTP id
 r5-20020ad45765000000b00473020e746cmr2768919qvx.128.1657715915813; Wed, 13
 Jul 2022 05:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
 <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com>
 <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com> <CABXGCsNrnYZO6NfF624j0xrBkdF9vjZhcyF8iZrEr4eGcjpSCA@mail.gmail.com>
In-Reply-To: <CABXGCsNrnYZO6NfF624j0xrBkdF9vjZhcyF8iZrEr4eGcjpSCA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 13 Jul 2022 17:38:25 +0500
Message-ID: <CABXGCsMSRg251use+9ZzgXZ_2xreNUh96GQsfDPdkh=xU6QGgA@mail.gmail.com>
Subject: Re: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tzimmermann@suse.de
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

On Sat, Jul 9, 2022 at 5:10 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:

> Hi Christian,
> if you read my initial post. You should see that I tried to bisect the issue.
> But it is very problematic because on each step I see different symptomes.
> And if mark different symptoms with skip step we got at end lot of
> possible commits:
> Here is my bisect from initial post: https://pastebin.com/AhLMNfyv

> [    8.291298] ------------[ cut here ]------------
> [    8.291309] kernel BUG at mm/page_alloc.c:1329!
> [    8.291324] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [    8.291328] CPU: 8 PID: 599 Comm: systemd-udevd Not tainted
> 5.18.0-rc2-003-790b45f1bc6736a8dd48ba5731b6871e0217311e+ #361
> [    8.291333] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
> [    8.291338] RIP: 0010:free_pcp_prepare+0x58d/0x5a0

There will be a 5.19 release soon. I haven't got a working kernel
fresher than the fdaf9a5840ac commit on any machine (all machines have
AMD graphics).

Bisecting the kernel if we considered the mutex issue as "bad" state
and all other non working state as "skip" did not lead to anything
useful.

Even if we consider "bad" all commits in which the kernel does not
work, this also does not lead to anything good.
Below I did it:
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [fdaf9a5840acaab18694a19e0eb0aa51162eeeed] Merge tag
'folio-5.19' of git://git.infradead.org/users/willy/pagecache
git bisect good fdaf9a5840acaab18694a19e0eb0aa51162eeeed
# status: waiting for bad commit, 1 good commit known
# bad: [babf0bb978e3c9fce6c4eba6b744c8754fd43d8e] Merge tag
'xfs-5.19-for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad babf0bb978e3c9fce6c4eba6b744c8754fd43d8e

# 01 - good: [86c87bea6b42100c67418af690919c44de6ede6e] Merge tag
'devicetree-for-5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good 86c87bea6b42100c67418af690919c44de6ede6e

# 02 - observed initial problem with mutex
# bad: [43ab20c599f4dc4c3972a8386ef4ca3943b5f9cd] drm/i915/gt: Fix
build error without CONFIG_PM
git bisect bad 43ab20c599f4dc4c3972a8386ef4ca3943b5f9cd

# 03 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x58d/0x5a0
# bad: [790b45f1bc6736a8dd48ba5731b6871e0217311e] drm/i915/bios: Parse
the seamless DRRS min refresh rate
git bisect bad 790b45f1bc6736a8dd48ba5731b6871e0217311e

# 04 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x455/0x650
# bad: [c6ed9f66eb70aeaac9998bd3552ada740d90e20c]
drm/nouveau/gr/gf100-: change gf108_gr_fwif from global to static
git bisect bad c6ed9f66eb70aeaac9998bd3552ada740d90e20c

# 05 good: [3123109284176b1532874591f7c81f3837bbdc17] Linux 5.18-rc1
git bisect good 3123109284176b1532874591f7c81f3837bbdc17

# 06 good: [711c7adc4687250deb550ee8a6994203f817b2ca] drm: exynos:
dsi: Use drm panel_bridge API
git bisect good 711c7adc4687250deb550ee8a6994203f817b2ca

# 07 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x35e/0x410
# bad: [047a1b877ed48098bed71fcfb1d4891e1b54441d] dma-buf &
drm/amdgpu: remove dma_resv workaround
git bisect bad 047a1b877ed48098bed71fcfb1d4891e1b54441d

# 08 good: [644704740b8282c9ee9483a38666ee4a4561c37c] drm/amdgpu: use
dma_resv_for_each_fence for CS workaround v2
git bisect good 644704740b8282c9ee9483a38666ee4a4561c37c

# 09 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x35e/0x410
# bad: [61fe0ab26e36998cebec48805d6873e31f0d79d7] drm/gma500: fix a
missing break in psb_intel_crtc_mode_set
git bisect bad 61fe0ab26e36998cebec48805d6873e31f0d79d7

# 10 good: [1c3b2a27def609473ed13b1cd668cb10deab49b4] drm/nouveau/clk:
Fix an incorrect NULL check on list iterator
git bisect good 1c3b2a27def609473ed13b1cd668cb10deab49b4

# 11 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x35e/0x410
# bad: [aa46154355e1e81ef746470d2e88bdb283508bff] drm/ingenic: Add
ingenic_drm_bridge_atomic_enable and disable
git bisect bad aa46154355e1e81ef746470d2e88bdb283508bff

# 12 good: [71d637823cac7748079a912e0373476c7cf6f985] dma-buf: finally
make dma_resv_excl_fence private v2
git bisect good 71d637823cac7748079a912e0373476c7cf6f985

# 13 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x35e/0x410
# bad: [33f2069fb6a9c2d6509accc39521d3f4d6369576] drm/nouveau: support
more than one write fence in fenv50_wndw_prepare_fb
git bisect bad 33f2069fb6a9c2d6509accc39521d3f4d6369576

# 14 - observed invalid opcode: 0000 [#1] PREEMPT SMP NOPTI - RIP:
0010:free_pcp_prepare+0x35e/0x410
# bad: [9cbbd694a58bdf24def2462276514c90cab7cf80] Merge drm/drm-next
into drm-misc-next
git bisect bad 9cbbd694a58bdf24def2462276514c90cab7cf80

# first bad commit: [9cbbd694a58bdf24def2462276514c90cab7cf80] Merge
drm/drm-next into drm-misc-next


Need an alternative way to find the problem. And then the kernel will
be released not working.

-- 
Best Regards,
Mike Gavrilov.
