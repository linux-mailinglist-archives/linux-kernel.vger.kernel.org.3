Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47A571B46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiGLNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiGLNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA019A5F3;
        Tue, 12 Jul 2022 06:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4622E61796;
        Tue, 12 Jul 2022 13:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDADC341C8;
        Tue, 12 Jul 2022 13:30:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P2TcjJWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657632625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYdthUeGZbvaA1t+1LojU/ybGXAAcEY8rEaTs7qHYZs=;
        b=P2TcjJWIleqZJ5SKMIVhWV32GAoQryf+5uggPBT1cAXl3zFuVJ5R/lMVVCF8XEuvI1pauA
        xMOegPqMJrhaO5e71sfm1ndu9cwGOzLVfkltFBYK9e7IO3Jcoo5QhHUY6pi3IX2DmIq9Ke
        iZExEcoT/GlKa7aIXrQtg6ehVgjQJAU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b53cc393 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 12 Jul 2022 13:30:25 +0000 (UTC)
Date:   Tue, 12 Jul 2022 15:30:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-doc@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: siphash: Fix typo in the name of
 offsetofend macro
Message-ID: <Ys13bqGuPYBUGg3O@zx2c4.com>
References: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
 <87fsj6bhwb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsj6bhwb.fsf@meer.lwn.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Tue, Jul 12, 2022 at 07:05:40AM -0600, Jonathan Corbet wrote:
> Dov Murik <dovmurik@linux.ibm.com> writes:
> 
> > The siphash documentation misspelled "offsetendof" instead of
> > "offsetofend".
> >
> > Fixes: 2c956a60778cbb ("siphash: add cryptographically secure PRF")
> 
> When you send a patch with a Fixes tag it's always a good idea to CC the
> author of the patch being fixed.  Adding Jason...let me know if you'd
> like me to grab this.

Thanks for CC'ing me. Sure, feel free to take this:

    Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Jason
