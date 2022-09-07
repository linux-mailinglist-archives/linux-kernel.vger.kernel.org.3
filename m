Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50105AFB5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIGEgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:36:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BAE8671C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:36:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z187so13408729pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=4FLct00x9EVngCiNgBMX+7R8EGdypSh+ra2sd+aOfyM=;
        b=gkDrDVZdH6aXz+d6SKgjK7/Q4/QTsUEdn8vF9gjtzlxP2KfbIQ+kJ3K8VzyZCykGZc
         ZKhGoojve8uRVTcItuUVUi3o6GuMwyZ+nQNz0AEeF2k4KLulUe70InzBSvwlT0ebU3Kv
         tWlHdnQWx+7AAdlOqwpEoIbNucbq30/1TxYIH4PE05iImqD6qdPx3prvBaRskVmq1rLh
         vYDztG/c0O6zHHkfKjDi1aTV4dSUHKLoDRsjAnh3jHicXwW5bbKw4cq+ceyeJ5Hzicaf
         P+HJxYgEgapri3rY3OvE7OpwqIvjmqEAQmzf4BxrFxSiWxa5AJIcybem6U57n/vAtzN+
         zQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=4FLct00x9EVngCiNgBMX+7R8EGdypSh+ra2sd+aOfyM=;
        b=B9VbrsJRJjDbEAgwa8AEaftQwtZXCihH49imXsDqnwHysG7cL7Pe+auCQ9Pa/xxOI6
         +ozjBtRHKRxWPsiZ0AP/gAK/lJJz1nYEwYjB+pf6Fr0HS/4DNdEfVSruM/UzfwIsP9OH
         9oA9p2U7t3/AfDYzDTC0OzsSsWHdT07S88a9KAJ0gqssqxVwk/HW5IeUsgZP8l65ab+j
         9B8mOnW1y+R0/tpg37Ozslee6nKsbzXenxjYYCsVT5m8Ffdvl+cwDcy2fNoDzmNty/eA
         sUzEM3P0KNaOcFiF1s4AFzSCDiWRDnaVuhg42ISifuTQ5GPRfZyzFNkbTvMIn1IGGIik
         dAxQ==
X-Gm-Message-State: ACgBeo1k89RI3sDGSMVyrtygX0Zqyo3XrdzA60mLujic4ze17Vi72Ah8
        e5jC+ZEajIYLFvQlHHUGDtrA9M+YGv4=
X-Google-Smtp-Source: AA6agR6Jm0cQe2ABQUc01VWMmQwJjt/MdWuFI+yQjS5LCa6WrDV+OQgAwLmx0VFP/tT6C9HJ6vbxCg==
X-Received: by 2002:a63:4c50:0:b0:429:983d:22f1 with SMTP id m16-20020a634c50000000b00429983d22f1mr1814861pgl.213.1662525386216;
        Tue, 06 Sep 2022 21:36:26 -0700 (PDT)
Received: from localhost ([124.170.18.239])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b00536fc93b8c8sm11220239pfq.20.2022.09.06.21.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 21:36:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Sep 2022 14:36:21 +1000
Message-Id: <CMPW28H38HE0.W6BB976O6ULP@bobo>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc/vdso: link with -z noexecstack
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.11.0
References: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 3, 2022 at 1:25 AM AEST, Christophe Leroy wrote:
> With recent binutils, the following warning appears:
>
>   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.=
2.0/../../../../powerpc64-linux/bin/ld: warning: arch/powerpc/kernel/vdso/g=
etcpu-32.o: missing .note.GNU-stack section implies executable stack
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.=
2.0/../../../../powerpc64-linux/bin/ld: NOTE: This behaviour is deprecated =
and will be removed in a future version of the linker
>
> To avoid that, explicitely tell the linker we don't
> want executable stack.
>
> For more explanations, see commit ffcf9c5700e4 ("x86: link vdso
> and boot with -z noexecstack --no-warn-rwx-segments")
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Removed unrelated change in arch/powerpc/kernel/Makefile

Seems okay. Here too, commit 0d362be5b1420 ("Makefile: link with -z
noexecstack --no-warn-rwx-segments"). Core and x86 are using
no-warn-rwx-segments as well, should we have that just to match
too?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/vdso/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso=
/Makefile
> index 096b0bf1335f..a2e7b0ce5b19 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -92,13 +92,13 @@ include/generated/vdso64-offsets.h: $(obj)/vdso64.so.=
dbg FORCE
> =20
>  # actual build commands
>  quiet_cmd_vdso32ld_and_check =3D VDSO32L $@
> -      cmd_vdso32ld_and_check =3D $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@=
 -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
> +      cmd_vdso32ld_and_check =3D $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@=
 -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) -z noexecstack ; $(cmd_vdso_chec=
k)
>  quiet_cmd_vdso32as =3D VDSO32A $@
>        cmd_vdso32as =3D $(VDSOCC) $(a_flags) $(CC32FLAGS) $(AS32FLAGS) -c=
 -o $@ $<
>  quiet_cmd_vdso32cc =3D VDSO32C $@
>        cmd_vdso32cc =3D $(VDSOCC) $(c_flags) $(CC32FLAGS) -c -o $@ $<
> =20
>  quiet_cmd_vdso64ld_and_check =3D VDSO64L $@
> -      cmd_vdso64ld_and_check =3D $(VDSOCC) $(c_flags) $(CC64FLAGS) -o $@=
 -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
> +      cmd_vdso64ld_and_check =3D $(VDSOCC) $(c_flags) $(CC64FLAGS) -o $@=
 -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) -z noexecstack ; $(cmd_vdso_chec=
k)
>  quiet_cmd_vdso64as =3D VDSO64A $@
>        cmd_vdso64as =3D $(VDSOCC) $(a_flags) $(CC64FLAGS) $(AS64FLAGS) -c=
 -o $@ $<
> --=20
> 2.37.1

