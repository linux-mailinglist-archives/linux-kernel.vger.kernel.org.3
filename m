Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B3590577
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiHKRNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiHKRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:12:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC545F5A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:53:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so5639695pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=QSpm1V+Ji47xL0bb4a9x9poHrFEc/OWZ59EiV9Me3Jo=;
        b=X/u+FLkyzkuFdNfRE6blckihWwEe3TVdXw9DwZWy9d6NmFNRbqRIMZgNpQ1i0+5NZ+
         HPCExhGijUIVKwqUQvCM/RCTK4WG5knu0PEDJ9mGHGpczh44JzBRSUghHAWbo/eWjGPV
         Y5kpLfcGXHCvhDMnVbfnZ5P5cfwe3A90NsBHWuwDFuWDUmJQFI8MKy828C5d0EyH7/TZ
         DqM1l1lG1PyonBhq57LVAXrlmrNHbbXFrJ9VbfNXPDknsOO7UZb413p43bbnDNXvjPqx
         B7FTCG68mGzEE6eA/M3LwJKiSEFGOTkQLkGoKZT907VWu6GVat1dOmnn81YUEoBi8QPE
         D5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=QSpm1V+Ji47xL0bb4a9x9poHrFEc/OWZ59EiV9Me3Jo=;
        b=f844sNIh0fWpMysQ9KHsLjUUfHfxFD5fEos1/6EMw9SMVM/Pe9O0+35vcCc9Km6hFK
         FkS0te6ZEGFsujAuEpQE7Fdf4RsoRXv8wahHcHa8GJUnG6Ph/LyOJ4xuUedaQ+mJBhEC
         ynnlGUpsutR9TxYTUAURCVCQAhzhL0VyY7bVIqrzGP7lsU+qROGnx5/zzCLjjtFsw/pC
         mCdklEO+gQlWpq4EXiTZNqROwpMhU3+pqlQasG6AC+WwDJkt2JhPloTJUE2o/ymkNorr
         sq26pGS0UL1emmbohi377VZgAd3lQLOsCIRiSwpvtWqrV9Dw4QjfpBO3TT97wBr0Mujc
         154Q==
X-Gm-Message-State: ACgBeo093TQOGTJthwlJ9CY4CuhO6pNcQe7+KngpZyRmy7EcJKSYb+qs
        XcSsu7z6tVcn3HTKQw7bQMromA==
X-Google-Smtp-Source: AA6agR5ueu1dLkkrusSuI3DsSk9yaavTbdaR+6RE9jVrGKdK+odMpnXIKdJ10mwvIfyJbJqa43rTNg==
X-Received: by 2002:a17:902:dac5:b0:16f:63c:3e91 with SMTP id q5-20020a170902dac500b0016f063c3e91mr66920plx.169.1660236805100;
        Thu, 11 Aug 2022 09:53:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7952b000000b00528c22fbb45sm4441125pfp.141.2022.08.11.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:53:24 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:53:24 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 09:53:07 PDT (-0700)
Subject:     Re: [PATCH v2 1/2] riscv/purgatory: hard-code obj-y in Makefile
In-Reply-To: <20220725021902.625630-1-masahiroy@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org, bp@suse.de,
        lizhengyu3@huawei.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-e4e57be3-7448-411f-9633-af8a320edf45@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 19:19:01 PDT (-0700), masahiroy@kernel.org wrote:
> The purgatory/ directory is entirely guarded in arch/riscv/Kbuild.
> CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.
>
> $(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
> this Makefile for building.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> (no changes since v1)
>
>  arch/riscv/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index d4df200f7edf..c2d14e2f345d 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -92,4 +92,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>  	$(call if_changed,bin2c)
>
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY)	+= kexec-purgatory.o
> +obj-y += kexec-purgatory.o

Thanks, these are on for-next.
