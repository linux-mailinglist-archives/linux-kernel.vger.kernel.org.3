Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2051C14F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380070AbiEENxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380092AbiEENxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:53:01 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B03580F3;
        Thu,  5 May 2022 06:49:17 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 245DmkEn024632;
        Thu, 5 May 2022 22:48:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 245DmkEn024632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651758527;
        bh=IwgRHAG5zKPpb5J9wkpkLch62sbAeAXe6UUEy7oZWx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NflHOQ1SchzCR927Orbp99xHnhXDwx7JXWhpuBdOf/cUqIo6ylza5ViSTZ7IBceOT
         m7jWAdq5TunKPvbD29oIs9McC7ob3Q69bPLQtO2A9Ms5UiwdREp+7m0GwUQxQiiU/l
         LIVS398bOHNSvzLoWWUIhWY2A+s4IA6J2OaKgeeZ0maCi5sWsUwInNYax4jqlN5XjW
         hnmz7yusN4hbezVU0p96lLLzlIKtjFdmXXgsKWx2TcK2f38VvpkZptcu7UT07vcTwc
         pnbjO3YtH0M7tDN+LxnHW4KbKN4Rb+zGVGZ7qJ4+TI/DjpvmsHs2Qo/xOn2gy6OVMq
         XHV6zYVLmwfNA==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so8100056pjq.0;
        Thu, 05 May 2022 06:48:46 -0700 (PDT)
X-Gm-Message-State: AOAM530jDBej785LKza5OOXLDAIHEYUEibKhvohCa0BSlO9A7bj9tujf
        bZ7ZLhctlxOU8Kt+gs7pgTjKrVwL4bFsSfnX8/I=
X-Google-Smtp-Source: ABdhPJzApibcjGgodp1cj6GknF4zl8wLJYozCpjDCgLel5+3apjJYN7oU5/9F2ILR+v/DVL9JLafRpIVkNmZ+N0NzwQ=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr7726753pll.136.1651758526119; Thu, 05
 May 2022 06:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org>
 <20220501084032.1025918-22-masahiroy@kernel.org> <YnLgo+y5tR86hBL5@bergen.fjasle.eu>
In-Reply-To: <YnLgo+y5tR86hBL5@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 May 2022 22:47:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMNbOVwE7xMX6=R7cQwcoifwcQvfc37_2PyjQC5jFa6w@mail.gmail.com>
Message-ID: <CAK7LNASMNbOVwE7xMX6=R7cQwcoifwcQvfc37_2PyjQC5jFa6w@mail.gmail.com>
Subject: Re: [PATCH v2 21/26] genksyms: adjust the output format for .cmd files
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 5:23 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On s=C3=B8. 01. mai 2022 kl. 17.40 Masahiro Yamada wrote:
> > genksyms output symbol versions in the linker script format.
>
> output -> outputs ?
>
> > The output format depends on CONFIG_MODULE_REL_CRCS.
>
> Looking at the patch itself, I think the sentence above should be
> inverted, as all rel_crc special handling is removed.  Or did I get it
> wrong?

I admit this commit description is unclear.

In v3, the patch is simpler and the commit message is clearer.

Thanks.



--=20
Best Regards
Masahiro Yamada
