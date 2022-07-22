Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC857DF78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiGVKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:15:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410047748B;
        Fri, 22 Jul 2022 03:14:57 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.124]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5W4y-1nPhFb30ry-016vQa; Fri, 22 Jul 2022 12:13:53 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 2AD5A3C0C7;
        Fri, 22 Jul 2022 12:13:36 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D35264E42; Fri, 22 Jul 2022 12:13:19 +0200 (CEST)
Date:   Fri, 22 Jul 2022 12:13:19 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: add dtbs_prepare target
Message-ID: <Ytp4PyBcCfRsVaG5@bergen.fjasle.eu>
References: <20220716093122.137494-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220716093122.137494-1-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:kBSYKIANld+Cd82WhQj0ATFo241QPlk9m2Lo9LNLuxwvoUtSFoe
 SMFA1GDRjr8mDkW9Ve4RGsdf/fC38OftrWKxTtPD7ySiPcJEDncQD/nZG1TP4QweOktO9UE
 gTz8LYeAYzOYIO2bGcf/AjqKpmTSB55ysCIUt9tvp2Xa5sUPVLX1UPOkoOnaYqU4e4yrDnr
 rSVTQOAXpCTeKt7pUqtDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Kzuzhkgnbs=:QxOY4QgM7lnnYHAt63zcRu
 h7fZudyRJbGPXieX9UCe0tE7ggda4rRNbN6ds+MgKu/g2gugg1t4QifFxUYyZG5Z0EIHBM2L5
 YWWUqAI4h93Bt77Rj9WsOcePZUBVRPUfS3aarDHdkH7ZbBEvU6jJZvvjYZJBycF7Xu47IZXqz
 usgVRiPjODHQUbF1rhAuHA6Q4iTUPMm4UbQfv9XsVIa0aIvYFRIliCaCxX2HqPY4h6QTvsSYU
 IlgD+gpXhTKR7cCYx73wSae6cvK/CfZSO5OUxe/40PXJHECewQikyB6uuUSP+CkleIJVjxf0c
 w8HcA9kkP6SXV7GZL7iWajd+4FeM6Vj7zzArSAEy8Gwx/i1UTdgAnn17mABMZa6HSZIxSQ/mk
 FX7ZVYeeJIO5a/my3mACGV2njgk3RZjH3gIxiQN/e5/whjTcJJSCHSzormDH8sT/dc2ac6bOv
 fKonYNW+G+ffbAKEpWCXLTzYmfL+C1RaomqZXW6L10i/jS1hH7Ssy+RzuaFHxbN+fiGv0f0oX
 VDKNmvDCdX0TQsFpPqb08qXSnQO8Yl0WC202iJgOaWS7q05mkpjvY1u5SAP2Gkux0KjCSR/Ou
 WuPY/mbKyrZXUYf/2JerVYuowL44P5DXuKFH1J0VIE99VjJ+UcHTQHeFjcVvURNxEinuuP1pj
 Msm3xyu7BF+/1vOVdNivu1TrbApjYq0jYnNGnhuYGZCxNl9n5NL39Zgfn/PuCppDla9qoNKs4
 z97b7jmZbYFQU8/Ixc/Iz1kL2GUroe/JiQN55Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 18:31:22 +0900 Masahiro Yamada wrote:
> Factor out the common prerequisites for DT compilation into the new
> target, dtbs_prepare.
> 
> Add comments in case you wonder why include/config/kernel.release is
> the prerequisite. Our policy is that installation targets must not
> (re)compile any build artifacts in the tree. If we make modules_install
> depend on include/config/kernel.release and it is executed under the
> root privilege, it may be owned by root.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a9bd55edb75e..8aa4dbb8f878 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1367,16 +1367,22 @@ endif
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

Is there a reason, why both rules are not unified?  I guess it is, but 
I can't see it.

>  
> -PHONY += dtbs dtbs_install dtbs_check
> -dtbs: include/config/kernel.release scripts_dtc
> +PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
> +dtbs: dtbs_prepare
>  	$(Q)$(MAKE) $(build)=$(dtstree)
>  
> +# include/config/kernel.release is not actually required for building DTBs,
> +# but for installing DTBs because INSTALL_DTBS_PATH contains $(KERNELRELEASE).
> +# We do not want to move it to dtbs_install. The policy is installation
> +# targets (, which may run as root) must not modify the tree.

Is the comma after the opening parenthesis intended?

Kind regards,
Nicolas

> +dtbs_prepare: include/config/kernel.release scripts_dtc
> +
>  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=y
>  dtbs: dt_binding_check
> -- 
> 2.34.1
