Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7556D21B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGKAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKAKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EEB15714;
        Sun, 10 Jul 2022 17:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45AB260FCB;
        Mon, 11 Jul 2022 00:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A55C3411E;
        Mon, 11 Jul 2022 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657498209;
        bh=+F9YL090Ob/Y03kL/DzycGK6iSAWPTVALwZmsSBa0S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwliBKCdFJSZZPg3Lct3qOjaBKwqkHQXx7OhyJFcUK9T+61zNjEHmh++cDUWXK+0Y
         Ua5i5K6N13sG5ErdRIe0oZkYD6H8WHQzWtmgMkhqPxxITt067a3MlD7WkSjQjxcLNN
         vKerkDmaRAt9GNyDn2eBdiCAaSYsnr5AK9WV1BBkn7Mkm3f6RLvITjlbTFy7IMltPo
         PTM/Qu6oAVKiSSlsN672iEQ0L1zXlnTaXe0Aa6Ubrw851uNFG9sNPB72ztTo7dvncb
         5xpoSl7BDerFeOesEPMP/OA7W37G811KTnvHzm/nYKVyPlLBuRCdXXBqSkql7fRdFL
         1a/IdDu52mDFw==
Date:   Mon, 11 Jul 2022 03:10:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] keys/keyctl: Fix typo in string
Message-ID: <YstqXEPmPV2YUfWN@kernel.org>
References: <20220704025248.3695-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704025248.3695-1-zeming@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:52:48AM +0800, Li zeming wrote:
> Remove the repeated ',' from string
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  security/keys/keyctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 96a92a645216..2be09642dd13 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1175,7 +1175,7 @@ static long keyctl_instantiate_key_common(key_serial_t id,
>  	void *payload;
>  	long ret;
>  
> -	kenter("%d,,%zu,%d", id, plen, ringid);
> +	kenter("%d,%zu,%d", id, plen, ringid);
>  
>  	if (!plen)
>  		from = NULL;
> -- 
> 2.18.2
> 

Please, add

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")

BR, Jarkko
