Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59BF515A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382104AbiD3DhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiD3DhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:37:11 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB7A76D4;
        Fri, 29 Apr 2022 20:33:51 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23U3XaJ2029668;
        Sat, 30 Apr 2022 12:33:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23U3XaJ2029668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651289617;
        bh=TIGdeb7xdEs/9JV0A7VVLKMrZAPeq/6T37UNVZaHg3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lhUWW5QN/Ne1yWqXx1I52pvBhj3CHTCAlLDnmKDwUo+cSdC4LMDZSpByuTqtoa5zE
         uPZE79G5UvSYRfhV+x3EdslLYWr3kTWMPAfqCjxhTMtG3wZ/crFVfSwMdM3JFzllr5
         XDXrpbjQUNAuVCDpfUqmV16CG80fXjhcH/9U2eRM+SzSKNQZz0PW4I6pbGPH/UNT9p
         P8F3k+c9mkITW9PqFx/duH+MN9UYVo0B8r3lZzb8PMVWMMnhLQrIqyjGw4QxWqV/IJ
         8aRaZRyuHyqffnrBYUAEiYosrczmEMt6z960wi5hbO9YkSeXYtVBiT2GBOdezyNSo0
         /3XV6rPebGmrg==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id p6so8601359pjm.1;
        Fri, 29 Apr 2022 20:33:37 -0700 (PDT)
X-Gm-Message-State: AOAM530VAjprWwTSyaY5dw72Pho6bGH881O/5m2EC0+w7CGGhjGMLGq4
        NT5vzBpVgb1C+gJjZjmSu14mzHAZCJt2Di27Dys=
X-Google-Smtp-Source: ABdhPJyA7Kh8t38Tgnc7vWeywS0wR/hs6+Uy9mFeW8PUhdl6yVt/CqvOS2lmy8s86o/fRQJQo7INLG5ZVa4ItHZCUPw=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr2302881pjy.77.1651289616490; Fri, 29
 Apr 2022 20:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220426035318.3932-1-rdunlap@infradead.org>
In-Reply-To: <20220426035318.3932-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Apr 2022 12:32:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR86Z2R+CsPZSk-cwi950HGMDptEkdXUD1ZmDz9byfwgg@mail.gmail.com>
Message-ID: <CAK7LNAR86Z2R+CsPZSk-cwi950HGMDptEkdXUD1ZmDz9byfwgg@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: fix 2 typos
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix typos in comments so that they make sense.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> ---
> v2: drop an extra adjective (Masahiro)
>
>  Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/Makefile
> +++ b/Makefile
> @@ -1386,8 +1386,8 @@ scripts_unifdef: scripts_basic
>  # Install
>
>  # Many distributions have the custom install script, /sbin/installkernel.
> -# If DKMS is installed, 'make install' will eventually recuses back
> -# to the this Makefile to build and install external modules.
> +# If DKMS is installed, 'make install' will eventually recurse back
> +# to this Makefile to build and install external modules.
>  # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
>
>  install: sub_make_done :=

Applied to linux-kbuild. Thanks.


-- 
Best Regards
Masahiro Yamada
