Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8594B1995
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbiBJXfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:35:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbiBJXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:35:42 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE35F70;
        Thu, 10 Feb 2022 15:35:41 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y6so20101847ybc.5;
        Thu, 10 Feb 2022 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0OQR6lJELfc5hXAuEQxY1AA157xaZFZkub6I8EmaCE=;
        b=DGdS78rt4WNFSNFgFhdNXJVLTpvBg8SDtuHN5cVVM/yjrUbSIwD/teT8sFZ0iIkuTJ
         hqM+bK+TZ4ypnaX0uJAgX+8rGFAnR0Xx3gUnyHybLfSXjsOPdZeNtRoAaIReSmai81bd
         RrDuW3KsB9l1noVO+ewBhyg2fIQqqzgrSKUaiUvGk6AjrhGzGkLSvE/McY2iy+yu9ZB2
         X4lKH81IgcGkZJuC9er+bmgPKaTUMyOR5+ykEAA38WPF4Hq8nEj7c/wnX+Cj7PS9ZHBD
         Hj5EMSzNolH/Y19mDzzjzvIecrMyROdTW51caGIt1oFQw4ABQLs0H6aFDZLeE4WqCQ+s
         ywWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0OQR6lJELfc5hXAuEQxY1AA157xaZFZkub6I8EmaCE=;
        b=lYPScfzdTMNWfipovjF3/XJQOxac44CLdEkKtsLhd67c43a/AlKy2L6rIdCAhd6rBe
         ogV1wOAJ0T1SvCpNHmr/0lqlxt3/i9ZP5eWP1ap9Lb9ki7rQiKImz7kJvfg6nE5MKVys
         hYgGQB8PhK0jUXHDru+brHs6aronMqsl4RWTFT1ELnlopDtxm12wl72bJZoGmWCY6zK2
         iLll5GfWM21FOoKs0zxWUzRPhLaOH/nUhoq8Z0KFWtlyKZoXupDrlpNd1mJt0TEl4fci
         wGBnBSU0N79MiKydM1bKs7/IMXgvHR4n9SKVqUtGcZxj0h7lBfM7kbEYtmcQvngaTTPg
         y3Uw==
X-Gm-Message-State: AOAM531jepGjjNiPsi5FDlMictVXiISmRQmWVc3n5vqsA3zsgGpCus/I
        vsNH1Wyh7RgsD/zi1EXcRhF1awdlvR8kqH6RV9PQzNoAeFc=
X-Google-Smtp-Source: ABdhPJxZjh/ZB2LxbqndF/NG6fDK29FIN9zEAsqiIy+Bbe+cv8D3FFmaPkaetN5SyZ0IXk77545U1/YrdVeREbCC9Uk=
X-Received: by 2002:a5b:f4b:: with SMTP id y11mr8706490ybr.634.1644536141049;
 Thu, 10 Feb 2022 15:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20220210184340.7eba108a@canb.auug.org.au>
In-Reply-To: <20220210184340.7eba108a@canb.auug.org.au>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 10 Feb 2022 15:35:30 -0800
Message-ID: <CAA5qM4BKwS9W5UCbnfo_xSTJKBuUEyNzUrg0UfGhoxWK5WK3RQ@mail.gmail.com>
Subject: Re: linux-next: boottime warning from todays linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 11:43 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> kernel messages:
>
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
>   Call Trace:
>   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unreliable)
>   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c/0x9f0
>   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
>   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
>   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
>   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
>   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
>
> Presumably introduced by commit
>
>   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to its own file"")
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,
I am trying to see if I can reproduce this.
Could you share the QEMU command line and pseries_le_defconfig?
Latest kernel does not have pseries_le_defconfig so I assume you have
your own version.
Thanks!
- Tong
