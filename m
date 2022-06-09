Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2754529E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbiFIRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiFIRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:05:52 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3335C3677
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:05:46 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LJr884xv7zMqbwC;
        Thu,  9 Jun 2022 19:05:44 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LJr880HbBzlm74f;
        Thu,  9 Jun 2022 19:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1654794344;
        bh=gB6G43Fk8EhYn4BH21oNx9y44yniLbvvjM64FMg7kcc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nP+3ue5OOVjznB09vHxysn9H2CKOCbFjc2vSSxN81mlmv0XDowKiK6ob8rYUgINUg
         iq0Jvcdm7D6yDhyi9jfDxmlfqOqYTpMkvUSnMePc0wg7uOOA4jxoAC4TEm68Z4csmq
         Sk4QC/RTBq0CCifB9ivTuXxuqhlBX/OR4AuH0gG4=
Message-ID: <486b1b80-9932-aab6-138d-434c541c934a@digikod.net>
Date:   Thu, 9 Jun 2022 19:05:43 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2022 14:31, David Howells wrote:
> There's a rule in certs/Makefile for which the command begins with eight
> spaces.  This results in:
> 
> 	../certs/Makefile:21: FORCE prerequisite is missing
> 	../certs/Makefile:21: *** missing separator.  Stop.
> 
> Fix this by turning the spaces into a tab.

These spaces were not part of my patch but they are indeed in this file 
now: https://lore.kernel.org/r/20210712170313.884724-3-mic@digikod.net

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>


> 
> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Mickaël Salaün <mic@linux.microsoft.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: keyrings@vger.kernel.org
> ---
> 
>   certs/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index bb904f90f139..cb1a9da3fc58 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o += -I$(srctree)
>   
>   targets += blacklist_hashes_checked
>   $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> -       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> +	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>   else
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> 
> 
