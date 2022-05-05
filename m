Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8551C151
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380125AbiEENya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380177AbiEENyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:54:09 -0400
X-Greylist: delayed 23050 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 06:50:27 PDT
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2421C4;
        Thu,  5 May 2022 06:50:23 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 245Do2Vm001524;
        Thu, 5 May 2022 22:50:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 245Do2Vm001524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651758603;
        bh=9oRpkNgyXXtV+zgGcTivzSiWJg6PL7lzsKUtb+il+xA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCAi+X3iW2LWnS+cyU6Xwt+mVMFWGKNgvm1N4fQyjnqbm5kc3n8AZNfmfQahJf44C
         8baCi4AzET7HA49g1FxlljYCIcyH27XetjJU5oHET938gKf0mwwJvz2T8HhpMNLCrz
         P9Pn3Km3/Y/vQeek7U0RGRx1wEMV/zynJog1koCSG/7blY0+bz+o/+V+nd0dhDVIgT
         ObLR1jGvcZqTTJusj3s304q3S0HOyD8i5NlnZKlgrayMMnTlwQhkOi3xewdpgkQ2UG
         FMtXR+0Z3J9CI9yvcXTbq4t0xxUsKdPB9BdEjyOOS3D5O8xVFTCPswe5Ah2kSLCHdl
         WLmJgONxSW2YA==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id n18so4453578plg.5;
        Thu, 05 May 2022 06:50:03 -0700 (PDT)
X-Gm-Message-State: AOAM5337OApzlSjvMivzBuGPOcIlt85F07dCzPAk70PrPMKs1ZJpu0TO
        ALyzMqaQ7j0d3brF4XksznGsKpYAul0EsDH8fk8=
X-Google-Smtp-Source: ABdhPJwUvU2dd6I2MVotZAWGiD+mCtj6djZTY+lh8nRnnAK5x12OI9taA02MBGobfNqjKVY/3aiklbcYcNl4MlrBSIM=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr6301241pjn.119.1651758602352; Thu, 05
 May 2022 06:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org> <20220505072244.1155033-3-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 May 2022 22:48:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREQt5rPGK8zsti_UA-dGFKfqHsVWbSgMLw-yLoeNkJeA@mail.gmail.com>
Message-ID: <CAK7LNAREQt5rPGK8zsti_UA-dGFKfqHsVWbSgMLw-yLoeNkJeA@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] modpost: change the license of EXPORT_SYMBOL to
 bool type
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-um@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, enum export is tristate, but export_unknown does not make
> sense in any way.
>
> If the symbol name starts with "__ksymtab_", but the section name
> does not start with "___ksymtab+" or "___ksymtab_gpl+", it is not
> an exported symbol. The variable name just happens to start with
> "__ksymtab_". Do not call sym_add_exported() in this case.
>
> __ksymtab_* is internally by EXPORT_SYMBOL(_GPL) but somebody may

I mean
"... is internally used by ..."




-- 
Best Regards
Masahiro Yamada
