Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B356051C9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385613AbiEET70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385464AbiEET66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:58:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC35F24B;
        Thu,  5 May 2022 12:55:13 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3K9E-1nwDkz0qKw-010OY9; Thu, 05 May 2022 21:53:59 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 156A33C088; Thu,  5 May 2022 21:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651780437; bh=dBGPpUTd6f50KRn9utFIdPZJncpaOpFQeh/8wziuA/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BA/UrMfyunASKGi7EkzUpzPsPi2aei9LQHExoWZtA5QFmz+nF8ch9crJVNxlyXlAo
         9/Na54bbnRtHOJVT/Cu1rd++ItUCRwJYL1sK4BZ0RkHyXPHaNQRVN2803zQ7qVDZ9q
         IFpDp5e19gxb+cnRkH0vRcmlOzVJGX4BOzBrpews=
Date:   Thu, 5 May 2022 21:53:56 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-um@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 02/15] modpost: change the license of EXPORT_SYMBOL to
 bool type
Message-ID: <YnQrVI1r+Unp2vn+@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-3-masahiroy@kernel.org>
 <CAK7LNAREQt5rPGK8zsti_UA-dGFKfqHsVWbSgMLw-yLoeNkJeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAREQt5rPGK8zsti_UA-dGFKfqHsVWbSgMLw-yLoeNkJeA@mail.gmail.com>
X-Provags-ID: V03:K1:eVIKbsZAbmzWlKtPrBj9Mb+vBbXXzsRynicJaMbmbzeysZP9arT
 xtUnuIVyv55qPraP+CQORaltSCsWVTcv/yBmJe397a5RhE4lqPF/7NTAdPbhqJt+3Gh8g92
 ZoO+xpkipSHT4m8eoWenn52JjlnfRIYuJaTzy/dfT9T33OOig4RA8icWKQqDbDJT1r+AETo
 wW4IQZEr5rVf+AzQyOwXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O1718LcMWqY=:suNSu7o6nKuRoYHjwHkK7V
 I5JxHIqIanjGfPigUPLhylAYRpIOBsQUko5BnQ6W4am6/4Rk1hQN6SjvKN5TJ+Ie4NSKLKRUU
 /rCUpt8uxsEkDWvgPp2uG0z6DNKPTzqh8GOV+zc/pZy4BIyyREB8aD/ArpRnIaRaYTcqnn56q
 XUSx9OWW0FgRVVjXnPgkQwU3vCboB03AivsI9pjAaunR2mMKkgjkV9UgoLuBEtCr1gGEQLY5q
 z4gY0BE70xMtqT8byLS8fXfYh0Cd9tmtCdH1UvMI0eN9ObwTzYhaRtzGMaFmzNcYu/HJGpADG
 S8KLRMdZq3HDg9PtUi/8323eqrhjuEFIx9AcoFTVjHgQkAUqar0NTGwnCGXtlJ6By8bb1mW1N
 dlSRIjRe39kgHYAcF4eWrvXUorPWsok/1vGuGljWIdqmDlUxyf6IaxJH9iEdRJZi4QMOYsrru
 GwTY6TZBAAM7xXkzedF/IBOT6zwIoooV1swVFW6ldMo75vnpOkJ7OtLQBARHpTDtcdpjFN9oA
 tonNUBC+ZHeQ8bmR1CcgL4nvBkdAa5mIRaypRTPGCOtPxEvwMhuyASvdQkdxOCbWJbK9uZa9l
 h7U5WP0/B6y9l/upnfY5B/pSb4v9X4o2Cxgjvspp3ACwnhKVDVDlZ1Sgugg3sGpeXE/AU4xsl
 9YYc4OOhpf0rxjgHtRHcZ4fJ+MpGjD+n2/wd9yTekkkDcgbJ19y5X+rdO48X0t3Q0g0c=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:48:55PM +0900 Masahiro Yamada wrote:
> On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Currently, enum export is tristate, but export_unknown does not make
> > sense in any way.
> >
> > If the symbol name starts with "__ksymtab_", but the section name
> > does not start with "___ksymtab+" or "___ksymtab_gpl+", it is not
> > an exported symbol. The variable name just happens to start with
> > "__ksymtab_". Do not call sym_add_exported() in this case.
> >
> > __ksymtab_* is internally by EXPORT_SYMBOL(_GPL) but somebody may
> 
> I mean
> "... is internally used by ..."

Looks good to me; a nice cleanup.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
