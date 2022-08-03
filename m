Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F858909A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiHCQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:37:15 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD595AC;
        Wed,  3 Aug 2022 09:37:13 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 273Gaq3r030112;
        Thu, 4 Aug 2022 01:36:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 273Gaq3r030112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659544614;
        bh=ysJgM4fZWZmqQUC+nTSmxgg0XgP0ESWrADh1sTBXrx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqKkEB8TUNqgcMB3vxvO5v+Vou4ynr2CFtx15kRnc78z3UeRNlQlAS9ueaOP/Y2oR
         QiwTPQEQuUkSDim1bfqGyPS4WOt0pZxjRNKZ8vV980ORIS/EenbCLLtDnb7oNlziXi
         DPaoaGn068Re0KDA8lWwpZNDEzhBaJUZIq5qBOc7sjM/ic2IQrWOYbyaJlVX5pF6HA
         bkVXzDVabdJy5y3dIO0U3lNKJWhC3kaGlPzAMqn9hGhVtUU6WVAxyC6uOJ7eSrxdqi
         i+u+t4M2jDXknR4Zz5bLdqWQgAt6vj90nz3kXAQjHUYvV3ByjZjifjYXIoavQ4yudF
         NYT7bQj9vSfGw==
X-Nifty-SrcIP: [209.85.128.53]
Received: by mail-wm1-f53.google.com with SMTP id v5so8990809wmj.0;
        Wed, 03 Aug 2022 09:36:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo0kDBDakGFQSX5LuESA8JIBsb/I43xPPoPhrrDdYL+X9cpXwhQ+
        d+iw4OsguYYVynmxNsu4MhAVv3Irj873oJw0rhw=
X-Google-Smtp-Source: AA6agR70PHxcjjt6xjXHpj6sPCYxedkdq/Dm3+iBk1Pbvk7vEWk36K0NGUFTvplRbvSmgDtHPouJKSYQ2XLlgZ7uC4A=
X-Received: by 2002:a05:600c:4349:b0:3a4:a4fa:450 with SMTP id
 r9-20020a05600c434900b003a4a4fa0450mr3391470wme.157.1659544611993; Wed, 03
 Aug 2022 09:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220801093902.1506297-1-masahiroy@kernel.org> <CAKwvOd=cBXzA9SfYtK-h_dAqLyg=5iZ6YjztTfNschKUMBTK9Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=cBXzA9SfYtK-h_dAqLyg=5iZ6YjztTfNschKUMBTK9Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Aug 2022 01:35:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBpsFzYfCLwHEzjYNWnM9BLX3tEzvmPKjiKWzkU-yjrg@mail.gmail.com>
Message-ID: <CAK7LNARBpsFzYfCLwHEzjYNWnM9BLX3tEzvmPKjiKWzkU-yjrg@mail.gmail.com>
Subject: Re: [PATCH 1/4] modpost: shorten warning messages in report_sec_mismatch()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 3:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Aug 1, 2022 at 2:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Each section mismatch results in long warning messages. Too much.
>
> :(
>
> Yes; they are too verbose.  That said, I have found the
> recommendations about annotations for function attributes handy in the
> past and would be sad to see them go.  They remind me of "note"
> diagnostics from the compiler that add additional context to
> "warning"/"error" diagnostics on what the recommended next steps are
> for fixing them.
>
> Is there a "happy middle ground" here?

I do not know.
modpost became painfully ugly.


Moreover, the current hint is not necessarily precise.
("lacks a __initdata" in the following)



[sample code]
int dummy __initdata;
void set_dummy(void) { dummy = 1; }


[warning]
WARNING: modpost: vmlinux.o(.text+0x194412): Section mismatch in
reference from the function set_dummy() to the variable
.init.data:dummy
The function set_dummy() references
the variable __initdata dummy.
This is often because set_dummy lacks a __initdata
annotation or the annotation of dummy is wrong.




--
Best Regards


Masahiro Yamada
