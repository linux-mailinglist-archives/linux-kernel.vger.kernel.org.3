Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27FC50EF55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiDZDmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiDZDmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:42:36 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD68ECCD6;
        Mon, 25 Apr 2022 20:39:29 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23Q3d81P027039;
        Tue, 26 Apr 2022 12:39:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23Q3d81P027039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650944348;
        bh=cE9IWqSsjcygXaeh+IQ0oOz27f+MFww1JH1Wh1MQzqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Theeh9+NPHtLRDCzp28IiK8aemkd1IHUZeOjEwX72BKHOHklaxE09sivCv76AeqKd
         1eHCEFubs73avGtewNNP0b4CU27vst9fpDAnh2Xp/XgYZ4DIlWBonsBDPdQTka6EX9
         n8ZqfeddWs7qRPUjcosSSld+SbxmidWZlerzczeGhe7Vd05EHwY3Iy2wXSBLA2yutE
         j5+W8VmGKLor+k4+0GmYpbuGQMESo2emx9kydovQHYB9wHu9Ifp3Cl6PdOAb/xGwvG
         1GCVe9P5w5zMBMq6GKp8mRLiRV0Jw3Cf+F423lcMOqH3i3fg9Z0NnWwCNc3ytZd7T7
         Gn1zGYLwQ8AFg==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id iq10so3707242pjb.0;
        Mon, 25 Apr 2022 20:39:08 -0700 (PDT)
X-Gm-Message-State: AOAM532PQ2Ma/n+aKDC4hqwercvv6nkN49keFK6R51DIZfWfhw5FrVP7
        wbM1Yoi/7LcnGyX//OyheY5hvhEirDahA0m9I00=
X-Google-Smtp-Source: ABdhPJzJPTUDnT+XwMa3n7SZkeEdjnB3IKIbBdRp/3Z8ITsva3hnKIAiIGa8RKJCi/Ob5PTI1yQokBLczQBd5K7eh20=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr35281712pjn.119.1650944347520; Mon, 25
 Apr 2022 20:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220426002551.20171-1-rdunlap@infradead.org>
In-Reply-To: <20220426002551.20171-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Apr 2022 12:38:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcOetx77HcGtwByy6nCEF_XRkMb7n543Z9bdMe8=c9Jw@mail.gmail.com>
Message-ID: <CAK7LNAQcOetx77HcGtwByy6nCEF_XRkMb7n543Z9bdMe8=c9Jw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix a typo
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

On Tue, Apr 26, 2022 at 9:25 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a typo so that it makes sense.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/Makefile
> +++ b/Makefile
> @@ -1386,7 +1386,7 @@ scripts_unifdef: scripts_basic
>  # Install
>
>  # Many distributions have the custom install script, /sbin/installkernel.
> -# If DKMS is installed, 'make install' will eventually recuses back
> +# If DKMS is installed, 'make install' will eventually recurse back
>  # to the this Makefile to build and install external modules.


While you are here, can you fix the next line?

"to the this Makefile"   ->  "to this Makefile"



>  # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
>


-- 
Best Regards
Masahiro Yamada
