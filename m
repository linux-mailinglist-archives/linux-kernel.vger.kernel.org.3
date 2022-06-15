Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2AB54D126
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355337AbiFOStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbiFOStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:49:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5224B86C;
        Wed, 15 Jun 2022 11:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E746B82149;
        Wed, 15 Jun 2022 18:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4C5C3411E;
        Wed, 15 Jun 2022 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318938;
        bh=57p8fD3/kBj/dYGAME7c/7JGTNl/V3Qr84RNI2SQO40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwcfQaEPOCGAg/k0cVmoZOYd0R/cIF3mltD9HmbdLyGT/CR7H0nMmhz0L/n8Hc0wl
         TRM8Ffv0dDbdEeDQBYvO7Fjhr1gEmxvLJIU9Z14u3U2AkzmS7z4s2hOV6Isja5tSu/
         PVhpq9UdZiFsZNvCtHxTIiPLH67dOc/y4I1a1l0dnJBqPStFVgRoPLJ3oQLAvKOstF
         pM4C4ehuye92gGJIAG1MDEu8pl3A3sPt1Z3yJCOWQWP07nfHacJaSzVZ+peigUNVtX
         KGm1yZDGQi8PaTPSpiFDPhlAj52PujR67rMBpy12sWS+SVUpDvPquQgzUOP9OpAmBt
         Bj8Z90HUP3zjw==
Date:   Wed, 15 Jun 2022 21:46:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        =?utf-8?B?TWlja2Hvv73vv73vv71sIFNhbGHvv73vv73vv71u?= 
        <mic@linux.microsoft.com>, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] certs: move scripts/check-blacklist-hashes.awk to
 certs/
Message-ID: <YqopGlOudkzi+qn3@iki.fi>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611172233.1494073-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:22:32AM +0900, Masahiro Yamada wrote:
> This script is only used in certs/Makefile, so certs/ is a better
> home for it.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  MAINTAINERS                                   | 1 -
>  certs/Makefile                                | 2 +-
>  {scripts => certs}/check-blacklist-hashes.awk | 0
>  3 files changed, 1 insertion(+), 2 deletions(-)
>  rename {scripts => certs}/check-blacklist-hashes.awk (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9ead83d2a..7c2a7c304824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4627,7 +4627,6 @@ L:	keyrings@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/module-signing.rst
>  F:	certs/
> -F:	scripts/check-blacklist-hashes.awk
>  F:	scripts/sign-file.c
>  F:	tools/certs/
>  
> diff --git a/certs/Makefile b/certs/Makefile
> index a8d628fd5f7b..df7aaeafd19c 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o := -I $(obj)
>  
>  quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
>        cmd_check_and_copy_blacklist_hash_list = \
> -	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> +	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
>  	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
>  
>  $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> diff --git a/scripts/check-blacklist-hashes.awk b/certs/check-blacklist-hashes.awk
> similarity index 100%
> rename from scripts/check-blacklist-hashes.awk
> rename to certs/check-blacklist-hashes.awk
> -- 
> 2.32.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

