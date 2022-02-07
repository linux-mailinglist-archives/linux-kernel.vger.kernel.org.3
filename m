Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FF4AB7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbiBGJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351034AbiBGJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:13:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF1C043187;
        Mon,  7 Feb 2022 01:13:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BC361139;
        Mon,  7 Feb 2022 09:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F1FC340F4;
        Mon,  7 Feb 2022 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644225205;
        bh=loNDVX86jkz7vPamh6R+7NHKKkH44fLHUGIwxCxL54I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3qKS4GcjeFf9L8rovgeNZ8vSs81DbEsRricgR8snuEiTtE5qtGwO+t5ejmjTWnE/
         3p5qPvPUFvK95lfF8emhaz9Oss/BNFFFwYykCdrz9e6TPUpmOwVmooJ8+wO5QH7Ysf
         UBXQXH8lt9nKYUW6VdDMBkxsj3L6CuTJh45w2MlfYSXy0zPcWm00VhtJm1omFzwI3h
         TPZ/mSKnuY0y5ADde8wKQl/t5N9IUhmAULM06+lV+2PHIaWkoqizwy0h3DmK68d7El
         rl6GKzy1PC6EOzhRP7JZi7CXUlFvmzQqG19UCKQw2b6TsJkAf1YbOuB6/uiGgbsy78
         oyw05Ak1bBqCw==
Received: by mail-ua1-f54.google.com with SMTP id w21so21632123uan.7;
        Mon, 07 Feb 2022 01:13:25 -0800 (PST)
X-Gm-Message-State: AOAM5317xhSD5WrrRLUA21mJplKsI9hHjKDgOh18ZfYFvwC314nd0KkY
        fMHQqJdsZ9GXhRmfywN31VTmj7YJnsasjjAijY4=
X-Google-Smtp-Source: ABdhPJxu8H5EnszM02kixttFF4U4u7kjCty3W4zLrxfbfQuHtQaVYD+2dwHDNYwaLA6hLb+W2wZbCs1H8ChTqC6nLBg=
X-Received: by 2002:a05:6102:3bd9:: with SMTP id a25mr4173991vsv.8.1644225204809;
 Mon, 07 Feb 2022 01:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20220130135634.1213301-1-guoren@kernel.org> <20220130135634.1213301-3-guoren@kernel.org>
 <5b59a816-a1a2-1e75-9c78-8bc9be18f70d@sholland.org>
In-Reply-To: <5b59a816-a1a2-1e75-9c78-8bc9be18f70d@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Feb 2022 17:13:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSki27uum+vPEsU50ktuBmkFC=XSr_KuAmKG2pwX2OwtA@mail.gmail.com>
Message-ID: <CAJF2gTSki27uum+vPEsU50ktuBmkFC=XSr_KuAmKG2pwX2OwtA@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] irqchip/sifive-plic: Fixup thead,c900-plic DT
 parse missing
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Samuel Holland <samuel@sholland.org>
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

Hi Marc,

On Wed, Feb 2, 2022 at 12:42 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 1/30/22 7:56 AM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The thead,c900-plic has been used in opensbi to distinguish
> > PLIC [1]. Although PLICs have the same behaviors in Linux,
> > they are different hardware with some custom initializing in
> > firmware(opensbi).
> >
> > Qute opensbi patch commit-msg by Samuel:
> >
> >   The T-HEAD PLIC implementation requires setting a delegation bit
> >   to allow access from S-mode. Now that the T-HEAD PLIC has its own
> >   compatible string, set this bit automatically from the PLIC driver,
> >   instead of reaching into the PLIC's MMIO space from another driver.
> >
> > [1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Samuel Holland <samuel@sholland.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Tested-by: Samuel Holland <samuel@sholland.org>

ping... gently. Any problem with the above patch?

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
