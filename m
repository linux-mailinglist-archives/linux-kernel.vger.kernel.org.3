Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C8584966
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiG2Boo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiG2Bom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:44:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CBE1B7BE;
        Thu, 28 Jul 2022 18:44:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id rq15so31486ejc.10;
        Thu, 28 Jul 2022 18:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aF9gxkNndIgzxO4AAV2+dCxMOnVAFOcQmkQ7z0dG0LQ=;
        b=DkPDztBrjKGeUM8fYgh3HSkhbfjiQ1Do2/grF7UQtK9v28BIKg0JZ27vfyJNxRzttm
         3vXvuKJWjqWpPD0HunGTmKg/NhUka0O07nOS+qJokOgHQPdsQNSmtpx8CNQ5VNJu9GTM
         K8gFEH2/If39puZptjgci66b3Q5rd3xt58Ic0GZ/UGq7cjIcgzBZmU1KbvsnQzdN+S/5
         1HtH07umLN1aiAf51mXocMACYoRm+LiMYIM8+N472n3L8bnHd+RNI4OqIh9het/5iGir
         S8t12mQM6/hq7GEwheCmjTHUdxAy89NucTWTIQHKzq0Qs/+pAhLDR25D55Mp6YyGd3Y2
         eM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aF9gxkNndIgzxO4AAV2+dCxMOnVAFOcQmkQ7z0dG0LQ=;
        b=dFikAwW/psArOiKHKjuwHR3Um20rXhx7iyBrAns3yxeKoMmKQsSK4GIRPo+TLvVDMJ
         ZewmAkoTCefJkXQ3PsdaPn53MAv2rsg1weBVppT8glbQVi9dreAQQ191R/RHDA0VwAvT
         pIhITbRS2SObWcnY9LC0x3Tjk0E4A92tsGPmXjW3fVjlUVOL4AULmbbR9+OB5Unhi/rU
         Noe3Y9Z1/bWWS0ASiymlR5OdIr104TrMK+7TaAGuK2LOkgDT/30FrhUW8MeC2VRW8CEv
         HFcJvRexdYK8WWHtzMMmHeQp22cWFCWUsSfC8zaIu1+DSSzu7Lezl2sekIla5U0hChG6
         R9UA==
X-Gm-Message-State: AJIora+V3oSFFhsEA6MRIMpPblx4afkFW7X9rkA6tC28N+5GoEPYcLmV
        j2yCdNz/JxTfQtgl96QMYoLnEevHqcaYpcrM9jXRqhTgjBo=
X-Google-Smtp-Source: AGRyM1vjQcSp2ZAQaomxl7a1v4biiRSbfuqN2bNchtQAYfANA3sZxwrE0GMkEQoF47S8DtLsOTbRn0bVDeMbcPScxsM=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr1155919ejc.115.1659059079918; Thu, 28
 Jul 2022 18:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <4A5CBF60-9590-417D-ADE7-7C6FDA8520DB@linux.ibm.com>
In-Reply-To: <4A5CBF60-9590-417D-ADE7-7C6FDA8520DB@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Jul 2022 18:44:28 -0700
Message-ID: <CAEf4BzZPaYzhH6zoJVMrOyJOPOcs19xUkmmw2y0uRFF5Z_eznA@mail.gmail.com>
Subject: Re: [next-20220721] Build failure powerpc (tools/bpf)
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Andrii Nakryiko <andrii@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:04 AM Sachin Sant <sachinp@linux.ibm.com> wrote:
>
> next-20220721 build fails on IBM Power server with following error:
>
> libbpf.c: In function 'bpf_program__attach_ksyscall':
> libbpf.c:10130:45: error: '%s' directive argument is null [-Werror=format-truncation=]
>    snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
>                                              ^~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/linux-next/tools/build/Makefile.build:96: /home/linux-next/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
> make[3]: *** [Makefile:157: /home/linux-next/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
> make[2]: *** [Makefile:55: /home/linux-next/tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
> make[1]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> make: *** [Makefile:1439: tools/bpf/resolve_btfids] Error 2
>
> next-20220719 was good. Git bisect points to following commit
>
> Commit 708ac5bea0ce
>     libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
>
>

This was addressed by [0], thanks for report!

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=64893e83f916

> Reverting this commit allows me to build the kernel.
>
> Have attached .config used for build.
>
> - Sachin
>
