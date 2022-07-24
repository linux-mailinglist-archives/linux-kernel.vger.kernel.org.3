Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60457F53A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiGXNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:31:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69632BF4B;
        Sun, 24 Jul 2022 06:31:06 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.234]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1M4p-1nVmS50YI7-012qlY; Sun, 24 Jul 2022 15:30:22 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C24B13C0C7; Sun, 24 Jul 2022 15:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1658669418; bh=NxfacbS/vhBHPqYb8uO1w1qDGketwG5gsFpiG+2IG2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgsEdEBc2oET/75yHWkBDUpDiCsviWleCn7bTtEwSLJx9bkSqvRqxJy7fwNfwJi40
         K32uYdTFiBjl/i4dvLjJaQzkKLrtVmPNHbkXnS7ozpeV32CuWK0Wat+yiyGIcHrav0
         9MCDmWiGVCy8SDSc9Y6VArKMX74Vgv+bU5QK1MXo=
Date:   Sun, 24 Jul 2022 15:30:18 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: add dtbs_prepare target
Message-ID: <Yt1JavRlr5XStp0+@fjasle.eu>
References: <20220724095919.436126-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220724095919.436126-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:7aZuP66KtFFHI7mmNnclqkg4ZGeICy49EYom7chv0x1Sd1qp1XI
 TTL9sWofH5rg9g6fXTMZZ3tq0x0Bc8TrzhI+k5ALwBIp3udeAGOSi84sU4nGlMN+9CBPbJY
 xT9OR9eV3s523UNzi+/JglR1TQecBK+vlq3at3Gn7Xtt0AMvOq6dqvLhjxfAMKbGPqeE/bk
 d2cGG4LtyZplM/XOaCtUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nCI0pjo1QU8=:4QpIYaY8pygI/C7Cawq0KW
 c2vEU3FwwWOFKTdauKBXX3ZPBW6oXV8vYtfyHa7SPdMNXR4oBf5in5yQvt5nb7eRInlYGCwgu
 ao9p5p395bQUyVY0hgcx013h7IQbY+lNvX0E8izzKBCeZgThfKyQycbbyv9ggZVnecCN6FeRT
 pqYl3kSKyLNFqMNZkFA+N9o491/dj2LvhThooyNTnI3bIckIV8MA3F2dHtZrpYd646i7UX9jk
 nSvz0ozx/Wjvwth73Tna/KnWzMAU1N1naXaSxFUGs6r9uGjiLN0BYe2CxzCEsEvsmwSvYP0Rw
 g+L8vsQkLuZJoZY+l05rMquHezcZ1fOHF1CWs2BY/1ALr8NJQjP/E+mhr9dje+p0uCyt6KsxK
 OvbtUuZ55718wm7ZhAaq8NkDyrz4tA9XLAf+vTBpNRptYpi/8Xgvsy6REW3g4y5lVWosVoMIN
 d6Op8DsYq0JQwV9YAN3ZCd9B7/KAOinNeRXWZnhT6OElTuaa0snf+qbRlg54Gqvu4UDGyARWV
 UfMWm0UHdDZJQ1pCTb5JyO/E+XGHBbnUZfcTzan30+RBPP9wyyeIQKmmYfHtD7m8JoGdUPwBa
 N+M9ZmyBpTqhYjtPiDXHZheyHBxv8GVdFjqUjSpLbxHkUd+MlteaG7IW6CYw6eB5pCsD95dYH
 Q8sLWcbtq1abhRTC4+GAyc5AV4S0VpeJO/b82Sef+aolUSQMtSIoyLBZZbvHBKP40v3r7W98B
 AxZj+aKqNVgnsmINk8F/Su/t3F23Vummc1xV6Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 06:59:19PM +0900, Masahiro Yamada wrote:
> Date:   Sun, 24 Jul 2022 18:59:19 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: linux-kbuild@vger.kernel.org
> Cc: Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
>  <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick
>  Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org
> Subject: [PATCH v2] kbuild: add dtbs_prepare target
> Message-Id: <20220724095919.436126-1-masahiroy@kernel.org>
> X-Mailer: git-send-email 2.34.1
> List-ID: <linux-kbuild.vger.kernel.org>
> X-Mailing-List: linux-kbuild@vger.kernel.org
> 
> Factor out the common prerequisites for DT compilation into the new
> target, dtbs_prepare.
> 
> Add comments to explain why include/config/kernel.release is the
> prerequisite. Our policy is that installation targets must not rebuild
> anything in the tree. If 'make modules_install' is executed as root,
> include/config/kernel.release may be owned by root.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> 
> Changes for v2:
>  - rephase the comment more concise
> 
>  Makefile | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index dee707c98bbe..a2a030f41e65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1370,16 +1370,21 @@ endif
>  
>  ifneq ($(dtstree),)
>  
> -%.dtb: include/config/kernel.release scripts_dtc
> +%.dtb: dtbs_prepare
>  	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>  
> -%.dtbo: include/config/kernel.release scripts_dtc
> +%.dtbo: dtbs_prepare
>  	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>  
> -PHONY += dtbs dtbs_install dtbs_check
> -dtbs: include/config/kernel.release scripts_dtc
> +PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
> +dtbs: dtbs_prepare
>  	$(Q)$(MAKE) $(build)=$(dtstree)
>  
> +# include/config/kernel.release is actually needed when installing DTBs because
> +# INSTALL_DTBS_PATH contains $(KERNELRELEASE). However, we do not want to make
> +# dtbs_install depend on it as dtbs_install may run as root.
> +dtbs_prepare: include/config/kernel.release scripts_dtc
> +
>  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=y
>  dtbs: dt_binding_check
> -- 
> 2.34.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
