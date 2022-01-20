Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5C494637
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358349AbiATDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:45:29 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:44595 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiATDp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:45:27 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 20K3j7hK015923;
        Thu, 20 Jan 2022 12:45:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 20K3j7hK015923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642650307;
        bh=7vOCa1EwRVjNQiVNJY7X3ClvIdlYKBH70ga98U88m48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5g72YhPTAKMDMFe+h9sgmmJDvQE3fXaXvwQEId5yLQHFPcfP+oBVeG2DPlA1CxnZ
         yXq985HkE14k4U3yVvozN2Fp3h58KDsW6L3YsHoVCi9cgeALjqhjSIpZOvBmqojVjG
         G1p8/nV4njutS9Vf6CDSETstf24Q0LyfGfRCTuyTzP0xWyONzFoYBCMVt0wmoFHgmf
         BmqaZk/GqnK0lEVnp5hX/jGSgBXo/B+RLZ7e5s/ZVVFRz5x2npOpRd69nrqzoM4/Dp
         Gl05QJtCYX1gUpyV/Vze2TpzDmO8sxkBed1dDJtgxqYWgvrZ2bzH98Upy72r+k/OOG
         7DgwR43ZXs2ig==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id e8so4087475plh.8;
        Wed, 19 Jan 2022 19:45:07 -0800 (PST)
X-Gm-Message-State: AOAM5307rZWoYRU+NG784kRPf7v36ruLOOBAL70GUs6L2Z8+681oOqcB
        qlUGFN0G7QjEhFcgJPdfDrfFe4u0+sP9QUBZPo0=
X-Google-Smtp-Source: ABdhPJzvOtpfBt3FIkatKyGm4oub595p3e4tDYENTOGy5csYrk2qPRpSYSnqoIuAaEDPUA6K//Lt0bjkZR2to6ZxpJE=
X-Received: by 2002:a17:902:6a89:b0:149:732e:d335 with SMTP id
 n9-20020a1709026a8900b00149732ed335mr36549385plk.136.1642650306633; Wed, 19
 Jan 2022 19:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20220103012402.GA25177@altlinux.org>
In-Reply-To: <20220103012402.GA25177@altlinux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 20 Jan 2022 12:44:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1JRypVRMaYiqN8m424zey+aLw38S1W3bpt4uZH-UKGQ@mail.gmail.com>
Message-ID: <CAK7LNAQ1JRypVRMaYiqN8m424zey+aLw38S1W3bpt4uZH-UKGQ@mail.gmail.com>
Subject: Re: [PATCH] usr/include/Makefile: add linux/nfc.h to the compile-test coverage
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 10:24 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> As linux/nfc.h userspace compilation was finally fixed by commits
> 79b69a83705e621b258ac6d8ae6d3bfdb4b930aa and
> 7175f02c4e5f5a9430113ab9ca0fd0ce98b28a51, there is no need to keep
> the compile-test exception for it in usr/include/Makefile.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied to linux-kbuild.
Thanks.



> ---
>  usr/include/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 1c2ae1368079..295d51e6ade0 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -34,7 +34,6 @@ no-header-test += linux/hdlc/ioctl.h
>  no-header-test += linux/ivtv.h
>  no-header-test += linux/kexec.h
>  no-header-test += linux/matroxfb.h
> -no-header-test += linux/nfc.h
>  no-header-test += linux/omap3isp.h
>  no-header-test += linux/omapfb.h
>  no-header-test += linux/patchkey.h
>
> --
> ldv



-- 
Best Regards
Masahiro Yamada
