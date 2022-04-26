Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343F50F0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiDZGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiDZGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E81229E3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62A7F612D1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C050AC385A4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650954150;
        bh=GrOAZVVQ/R3qESFmB6K9j+YKkA1RomF1reYz1F8tQ1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vRiwGaJcIYAp4A9L5NVO2Sr01XH/RAu89Cp29Al/eSRhVrFBOGTIIkbUzg5Wx2U8x
         qgBQ3iWrQKhPcaSgJcv9wvsCK1+h9p9qnZVbgO2c5Vy3kf9wfh/MEFlkZl124BH0hZ
         z44FeyAQ/jc4pZcbuk3KsJOb9Jh6erVsE9fRhXgkZImJvxb9aXURn5l3LJJYQ4L8Bn
         gLhRhDGJj3RmiSpWqGUa+en1V5mHSgq2LtgP0Hc7EeWlp8/gOSOOoHD3ev2oSCY2Zu
         7oOJhr7hrNjjyCkQIUAXZ34bytR2mQHI9XDLl+1IzENXUsisfNcBsRX+RuE6Rw0YXu
         S+PoKe06X9D0Q==
Received: by mail-vs1-f52.google.com with SMTP id d2so9495117vsd.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:22:30 -0700 (PDT)
X-Gm-Message-State: AOAM532dXzTRHBBbg3nevwlaPRRbLYFZAXuZE1UxB+jSLterlj3/L4nA
        v5EnDYJVejfU5p79yMtH+R3ptNhRED3sYCkOQqc=
X-Google-Smtp-Source: ABdhPJxHM08tDWKEqh3dfn41b7uQsUekJkJTEgUx6ZJGzh9kexwGAqDOrHpx93X8d/uQE0QcgAMW5+M3iuIkTRQgy1M=
X-Received: by 2002:a05:6102:150f:b0:32c:e4f2:77b4 with SMTP id
 f15-20020a056102150f00b0032ce4f277b4mr442485vsv.51.1650954149754; Mon, 25 Apr
 2022 23:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220426015751.88582-1-lihuafei1@huawei.com>
In-Reply-To: <20220426015751.88582-1-lihuafei1@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 26 Apr 2022 14:22:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR6hL1DfaGpPqfVwtmCHaVYK1nz_-W-h_mye34UjeeAcg@mail.gmail.com>
Message-ID: <CAJF2gTR6hL1DfaGpPqfVwtmCHaVYK1nz_-W-h_mye34UjeeAcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: ftrace: Fix the comments about the number of
 ftrace instruction
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, jszhang@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, liaochang1@huawei.com,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Pekka Enberg <penberg@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:59 AM Li Huafei <lihuafei1@huawei.com> wrote:
>
> When DYNAMIC_FTRACE is enabled, we put four instructions in front of the
> function for ftrace use, not five.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  arch/riscv/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4716f4cdc038..63f457650fa4 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -73,7 +73,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>  }
>
>  /*
> - * Put 5 instructions with 16 bytes at the front of function within
> + * Put 4 instructions with 16 bytes at the front of function within
Yeah, 5 instructions are for mcount, -fpatchable-function-entry=8
cause 8 16bit instructions.

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")

I recommend just delete "4 instructions with"
- * Put 5 instructions with 16 bytes at the front of function within
- * patchable function entry nops' area.
+ * Put 16 bytes at the front of the function within the patchable
+ * function entry nops' area.

>   * patchable function entry nops' area.
>   *
>   * 0: REG_S  ra, -SZREG(sp)
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
