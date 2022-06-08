Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D266542C94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiFHKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiFHKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:02:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1746B7F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:42:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC54721C27;
        Wed,  8 Jun 2022 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654681330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puXxdi25LGyGFvq7a5BBHZdXBRmygOr9wt6hwW7GUSM=;
        b=mZ1+pzLPt9vUFms9Lo0TES46yTN5Mor7jcVMIBPcuEn80D8I1fjsBEU2IwZRP2uGS3eopy
        2vIxCAYzquUhdGJ/+Waqs6vdYvAOAxYQUSjGjixJb/2IlRibMVQVngCGOdQT0dNXJaQb5K
        IHvj4973xaktjYUDwCItVHAtKJAC5hE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFBEB2C141;
        Wed,  8 Jun 2022 09:42:10 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:42:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: remove rng_has_arch_random()
Message-ID: <YqBu73Buvna+hROC@alley>
References: <20220608083459.1179854-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608083459.1179854-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-06-08 10:34:59, Jason A. Donenfeld wrote:
> With arch randomness being used by every distro and enabled in
> defconfigs, the distinction between rng_has_arch_random() and
> rng_is_initialized() is now rather small. In fact, the places where they
> differ are now places where paranoid users and system builders really
> don't want arch randomness to be used, in which case we should respect
> that choice, or places where arch randomness is known to be broken, in
> which case that choice is all the more important. So this commit just
> removes the function and its one user.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I am not expert on random numbers but it sounds reasonable.
Anyway, the change in vsprintf.c looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>    # vsprintf.c

Best Regards,
Petr
