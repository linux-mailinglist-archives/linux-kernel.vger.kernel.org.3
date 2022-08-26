Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E705A201E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiHZFHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:07:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C275A6C11;
        Thu, 25 Aug 2022 22:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA399B80ABF;
        Fri, 26 Aug 2022 05:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4FDC433D7;
        Fri, 26 Aug 2022 05:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661490433;
        bh=EhUBCrNn3AH2IoZWBlmeQVBIcyb6d3XAKROe8g5mp34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQZmA42nG8dvoHBFwRSrpQCkeVcTbAEBxs4ImjTc0FNoy9LLpe86uKOtMmsTZWyL7
         NtlkeDvViQsYaTZQHYsSF73jWeMRunRL7fyIHnvfXT+eLA6agFU6j54kYtV2xuOkLM
         HxqmP3YdMYe1pt1zpgWZ2u4yLZiyf8qTuP1uKm0LBd8F4varwUFAQS2Ra6OmSF3e2G
         Dap4eNNHbXu78oaIAJVMr7elaAHrP2prPchejJ+RDhLxVRnJL67z98zvXor9wAl2xl
         LCA2o0aCM+4wH28NSzgTTxG7OljTWm5H7mR18MpX3SMV9/O9P42D34Xof/lSSETr9H
         wWNrYQbh5QqJA==
Date:   Thu, 25 Aug 2022 22:07:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A . Donenfeld " <Jason@zx2c4.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
Message-ID: <YwhU/0XHDGIuiu5T@sol.localdomain>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-3-ebiggers@kernel.org>
 <YwhPtnL6yVG0K2Lo@sol.localdomain>
 <YwhQIRVc60u4B9Bs@gondor.apana.org.au>
 <YwhQmcgPpe2fpx86@sol.localdomain>
 <YwhRpUcbqs1GGGU6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwhRpUcbqs1GGGU6@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:52:53PM +0800, Herbert Xu wrote:
> On Thu, Aug 25, 2022 at 09:48:25PM -0700, Eric Biggers wrote:
> >
> > The one I'm commenting on (patch 2 of 3).  But patch 1 is needed as a
> > prerequisite.
> 
> Oh so it's just dropping the select? Can you please send me a
> separate patch for the crypto tree with a Fixes header? I'll
> deal with the merge conflict.
> 

Done: https://lore.kernel.org/r/20220826050456.101321-1-ebiggers@kernel.org

- Eric
