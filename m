Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067D153FAC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiFGKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiFGKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4762DC0E09;
        Tue,  7 Jun 2022 03:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D03C561373;
        Tue,  7 Jun 2022 10:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87BC34119;
        Tue,  7 Jun 2022 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654596219;
        bh=u1B8uxzMCkFey7cgXnz/vr+zToHpWFs1K5+BWxxYloU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K26BYJKPorCQqVcj8VFZH7g9DPuMkA/G8siXvq9Rkg3Q2HYIh8PuG+u/cFCKsjBYY
         gNaYErecq/8WR+Oi6yHa8vmhhQmSAFgAcgTiFGlp934idTcwd6gg83YBH6bfwFRfuk
         /XqYUH88dY44xe56sijpmV9e06rHlp0vC0PannW61RJZ9Y9WjTGsNwkMIU09Lv29jj
         wJ/C0UDg/U+Rq1OZ+mgy46Gd/DD4W5RK/aPXs6RXjcqg6ltHNpux6aH8qsYY1snSHx
         HOLGQj6AEsxuCU29cx+NfqEuqGNQnVtmCB10ZSDNeaYVtmu4vAuXqpDsv8jua93gV5
         CoLlhPJTAwRag==
Date:   Tue, 7 Jun 2022 13:01:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
Message-ID: <Yp8iCErgXDFBvhzJ@iki.fi>
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 01:31:59PM +0100, David Howells wrote:
> There's a rule in certs/Makefile for which the command begins with eight
> spaces.  This results in:
> 
> 	../certs/Makefile:21: FORCE prerequisite is missing
> 	../certs/Makefile:21: *** missing separator.  Stop.
> 
> Fix this by turning the spaces into a tab.
> 
> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Mickaël Salaün <mic@linux.microsoft.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: keyrings@vger.kernel.org
> ---
> 
>  certs/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index bb904f90f139..cb1a9da3fc58 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o += -I$(srctree)
>  
>  targets += blacklist_hashes_checked
>  $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> -       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> +	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>  else
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> 
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
