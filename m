Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DB51C9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385551AbiEEUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385539AbiEEUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:04:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD6E0A;
        Thu,  5 May 2022 13:00:15 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3Kc8-1nwE5E2FiE-010Ok2; Thu, 05 May 2022 21:58:54 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id D902E3C088; Thu,  5 May 2022 21:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651780732; bh=vYIqL3eaKPYTYqh4k5jXwkhNTTztM7wW6tSG2tFIoVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4igcJXNQ6jjMIy7+cvVTEgWda4gX4BGzFgc7p/3G/PPrXH5KnPaO9BbsMe0pF8/U
         rHYW+CseTNlFByUDSrQsRm0SzcsCVT+gdo9n/LMYX1w7wqci7S3Dg5ro7RlvAgeR65
         G4lesugCBZB2rNVh7mesgZQWRu4Ba9MtFG7WTFzc=
Date:   Thu, 5 May 2022 21:58:52 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 03/15] modpost: merge
 add_{intree_flag,retpoline,staging_flag} to add_header
Message-ID: <YnQsfA8kHDDpnBcU@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-4-masahiroy@kernel.org>
X-Provags-ID: V03:K1:9IUa2J8sJMvk7749DgPeiJiaBu6FL73EwQpRS6B0dgVLx4t442T
 osDTAH9JsajKHG1lcsCY/9daT/X0HMjejOOquvET7hizcj77zh+VoRDgizFgA6ppO3DNYhC
 ZFQG9l9TC1kFRKPb2hox/iIdOgwzdJ8ls3hX24wQeR4DTg1vK/y+O+Ik6M0XZfmHcX9omoG
 nqm6EIfPIJk6jK9uV1jbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbwNODae88U=:tAHOR6f0wimj/5peX0H7sJ
 qOXoXweEAyAP3gkzUjCzGoXNLVAif4i5vu22l0XQ4vlCrU99K1sleCBKtx+KfX4bR/9KPzp3h
 wabj/Rt1H64uxoelOJfoHkUEOH2DarMgVRYSv2I/uCbE277VYeXbayYjeOA+YWQ2V7WFkp0be
 fjAtMDa+OWWLkFVc6ObvTIsbeCxCnzaBrpAgIKisgHvnkui2BxKXUSU/2+g8bbX/FUwZBYKIa
 e/s9cgQ6Qdi6i0lpSBUgCBeEGObMuTaoodpnfhBDHMBR2vuqopL+Cul/MCehEy8w3X2llmwcA
 b5zKFLYOrKFlVTZ9yDpYdgbLSNo0ppMB+mHS6Ibx5XJUpo0fA/RU7Jp3OWXNvW//lDanmXHBZ
 SDZ5FjebLti6UbTjb7RKLPdY3om845p009yO0DElLqxY1dq9Shp4oZlVLTCwnqIt6d1p+FNso
 OE2qPMJYSjP6rQr1mS36P+G4xFYdV98rMVzUh0PBNRQlbuqRcATTW3MOBM7HWfiQCBNGyCxpN
 x5oElC04i/ztleBl7z5zL7lzA3kJ5GlPNg3v2nAhTJKcw+90CNxzJYb1TCnHDUPf6bXxNv+jB
 rjKr64REmHqXVO0Fy1gurXWgrHNONJMtFpF1/a29zOprou70jcQEzp8Xy7rF1U1D8not7PUx3
 yRmAEErm1dQbZkB1yBg4kDVsHIFCkJ9W+IQ4GkKsx6PCHfFX96kTuzBXWxEXp05qkHIY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:32PM +0900 Masahiro Yamada wrote:
> add_intree_flag(), add_retpoline(), and add_staging_flag() are small
> enough to be merged into add_header().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v3:
>   - New patch
> 
>  scripts/mod/modpost.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ebd80c77fa03..ae8e4a4dcfd2 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2200,25 +2200,17 @@ static void add_header(struct buffer *b, struct module *mod)
>  			      "#endif\n");
>  	buf_printf(b, "\t.arch = MODULE_ARCH_INIT,\n");
>  	buf_printf(b, "};\n");
> -}
>  
> -static void add_intree_flag(struct buffer *b, int is_intree)
> -{
> -	if (is_intree)
> +	if (!external_module)
>  		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
> -}
>  
> -/* Cannot check for assembler */
> -static void add_retpoline(struct buffer *b)
> -{
> -	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
> -	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
> -	buf_printf(b, "#endif\n");
> -}
> +	buf_printf(b,
> +		   "\n"
> +		   "#ifdef CONFIG_RETPOLINE\n"
> +		   "MODULE_INFO(retpoline, \"Y\");\n"
> +		   "#endif\n");
>  
> -static void add_staging_flag(struct buffer *b, const char *name)
> -{
> -	if (strstarts(name, "drivers/staging"))
> +	if (strstarts(mod->name, "drivers/staging"))
>  		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
>  }
>  
> @@ -2544,9 +2536,6 @@ int main(int argc, char **argv)
>  		check_exports(mod);
>  
>  		add_header(&buf, mod);
> -		add_intree_flag(&buf, !external_module);
> -		add_retpoline(&buf);
> -		add_staging_flag(&buf, mod->name);
>  		add_versions(&buf, mod);
>  		add_depends(&buf, mod);
>  		add_moddevtable(&buf, mod);
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
