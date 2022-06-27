Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7D55B5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiF0Dhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiF0Dhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:37:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0638AF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:37:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 68so7906115pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZGdnY3KbWnCYUqlD2Tg/rbiCuvHAPMPJ9V1d/S5oQvo=;
        b=ANd7UlFvkBole8OUfoCuu+17te83yhYUW9WYSxowheE/gI4kj9C07Ett8MnWDrE+uV
         Bd1XUKgGTgxon9qHdiS4vX7My6G2TgsWLLk2oxF4kDqW3FIFKjhpqxTpcFcxvlmUyflY
         fuprfPQkQX/hEl3K8RUb2FTxnMfQBk0Cze+QahTxg23WbAlDsI7P1YBV90eVC/WFOoAA
         SF2Uvq4j3XJt8C7Rz1U4PxOx+gueD0oSxYMtw43kcjpYlhulPLjJau3RJRkJlyC/tS4w
         GkNfYlR8VkQ8h0lPAafoDGKlTlzB00Xf17/db1i6XuUXVUXsFmlUr1oldWfmUZQbbLb6
         V7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZGdnY3KbWnCYUqlD2Tg/rbiCuvHAPMPJ9V1d/S5oQvo=;
        b=gQiz/otf/9rg3KWtlzvn8rDuF164CVVg6iyA0XcppMnivqFqc48h9GLHgWaHrMt9dg
         l8CkPfQUfekA2SKlQVQjkxfkCr/Kjpkgz/k5qc/9wvLO4XGqDei3bpG8rXN6soKuLqra
         lOuoM1UnWJIMPIUTwNqU+j4rSUIAAFPPVeDx7arLRKRs4FfNEF7/M0dRZVOJzQD3lEXj
         4dvzlCOeCHudjBKwy6jfzbU4EPwdh4QVdTWkzTeiETdr7O0nO7hTtGvj0cRh1lQieZOk
         1OQEdGaIEtS+TWlkVSA0UI+Hjsty1sRjeb2r28leIDhlFj4ivkWRNhoy55ts1aavVbAe
         znqw==
X-Gm-Message-State: AJIora/JD/HT2MZY7CgIwa252oSy3m4rZA6pBSVjSii8UFRxNz7w2MNZ
        gXmvouBeReJ124ppvn6wF1RYrrGAEfg=
X-Google-Smtp-Source: AGRyM1t/rJDWaPyGQnfWEEjCMkhPT+YxcFL8Bnh8Kgys0TcjXCetcdf6wLt+0/OOublkgWpxIwoK0g==
X-Received: by 2002:a63:b341:0:b0:40d:677:881a with SMTP id x1-20020a63b341000000b0040d0677881amr10886401pgt.407.1656301060029;
        Sun, 26 Jun 2022 20:37:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f80-20020a623853000000b005252380a87bsm5895004pfa.59.2022.06.26.20.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 20:37:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 26 Jun 2022 20:37:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc4
Message-ID: <20220627033738.GA3344900@roeck-us.net>
References: <CAHk-=wjRt2bxDDT9-Uq337dAg6jipZfetgSsHejggU=JHmyK6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRt2bxDDT9-Uq337dAg6jipZfetgSsHejggU=JHmyK6A@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 02:50:03PM -0700, Linus Torvalds wrote:
[ ... ]
> 
> Please do go test. Thanks,

Build results:
	total: 149 pass: 148 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

Build failure is

Error log:
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o

A suggested fix is at
https://lore.kernel.org/lkml/20220618232737.2036722-1-linux@roeck-us.net/
but drm maintainers don't seem to be happy with it. I am not aware of an
alternate patch.

I still see the following runtime warning.

WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
refcount_t: underflow; use-after-free.

for which a fix is available in -next (ARM: 9207/1: amba: fix refcount
underflow if amba_device_add() fails).

Also, there is

WARNING: CPU: 0 PID: 1 at kernel/smp.c:905 smp_call_function_many_cond+0x280/0x544

which is seen on some arm platforms if KFENCE is enabled. This is not a
new problem. I'll probably disable KFENCE on affected platforms to reduce
the noise.

Guenter
