Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022D534A69
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiEZGf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiEZGfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA5C0381;
        Wed, 25 May 2022 23:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE02A61A59;
        Thu, 26 May 2022 06:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16EC3411E;
        Thu, 26 May 2022 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653546917;
        bh=1cAp80bTJyt3PM3tkIBsRd7S7DG4whv4JC7Lw2p4wIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MlqWG47+sc/mUnoO6pxKGQYI6aiWZnfSKY62JguCW/fsks1pcBQGbuuxEH88Bqqrs
         lNjH8u81l+yWhu8dYKV1ZmOuxq/9hVhlh9pK5bg935/iE22LRjR+r5CbTaHvmEbhCu
         v2uCShFwRovXW7icOebhWh8PgMDyMGg1zU+ol5uU5OqfKYzkxuWic+N2xkSWFpLQZx
         DFi3LyQxhOGcDRUmhgJX6Qqpem9tQtaR9orQshlrHWWUBRdgqo5gGX+EOYoxjb7enu
         76vqsARjhv7f+3x8sopGy0kvqsGKOukY7IQolz3JbCQGKBnyQNxDbWXV20lrIxxNEU
         jsF4gki85PaEQ==
Received: by mail-vs1-f53.google.com with SMTP id 68so547276vse.11;
        Wed, 25 May 2022 23:35:17 -0700 (PDT)
X-Gm-Message-State: AOAM532ne1VDJGn352thTDfeNskYg3aw9mFMxHmnLyubA7W4Dk/izt01
        ti30HW+WRBTjzNCr8b2VZbD42Gi5L8V/AJKC1lQ=
X-Google-Smtp-Source: ABdhPJxTTY4z6afDlpjeqiscSirX/OECn/GIIqVJf8IOJmpD5wMNmExm18nHWlQYCagHM/GbRYqNvx6AVYYZESENOmA=
X-Received: by 2002:a67:d71b:0:b0:337:e6b7:1158 with SMTP id
 p27-20020a67d71b000000b00337e6b71158mr2893990vsj.2.1653546915886; Wed, 25 May
 2022 23:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220526130228.332e59a7@canb.auug.org.au>
In-Reply-To: <20220526130228.332e59a7@canb.auug.org.au>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 May 2022 14:35:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQDjTAOjFBCL4oJCx0NnuBc_16M=1HEs54q+ehGX-mW3w@mail.gmail.com>
Message-ID: <CAJF2gTQDjTAOjFBCL4oJCx0NnuBc_16M=1HEs54q+ehGX-mW3w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the risc-v tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Safe manual merge, thx.

On Thu, May 26, 2022 at 11:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   arch/x86/Kconfig
>
> between commit:
>
>   0cbed0ee1dbc ("arch: Add SYSVIPC_COMPAT for all architectures")
>
> from the risc-v tree and commit:
>
>   758cd94a0e16 ("x86/Kconfig: Fix indentation and add endif comments to arch/x86/Kconfig")
>
> from the tip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/x86/Kconfig
> index 98eaa8870f28,4d610ae216ce..000000000000
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@@ -2869,7 -2861,11 +2867,7 @@@ config COMPA
>   if COMPAT
>   config COMPAT_FOR_U64_ALIGNMENT
>         def_bool y
> - endif
>  -
>  -config SYSVIPC_COMPAT
>  -      def_bool y
>  -      depends on SYSVIPC
> + endif # COMPAT
>
>   endmenu
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
