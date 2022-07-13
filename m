Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C0573D75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiGMUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGMUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:01:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896A10FC2;
        Wed, 13 Jul 2022 13:01:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 568A52B2;
        Wed, 13 Jul 2022 20:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 568A52B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742507; bh=qR/ndmsxBAWfwkoYfqXoUzyvIUoYjmUhbtnaGPh/PvI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=awIu3yYmC32JpQjlAZq/v8s0Id5oXJcpPqQUeWYWQ3vEfEMFTUJmVgazKXjJebgE5
         7gu5lAUkQtrB8v5sUY1B5ShtiZY2jmZJ3zt8QFQ8y+Aky1B7x4o8anZithNuKGvIgB
         jv33ssnYgmuPTxRUUYlMJFdXdRSqF81Epoq0L0tyM9Y8FOeYKyTDP0wYV34e2cGghW
         1CFXekARvZ3ok/5EPfnC8PsqTGQ8G63Prn0ZxlABczeBteBgeugX+/De46PJ9PM/6j
         4QM7UjXPVe7hXXOkcMoOuJIRFAI0b174XT0Xdt04i3BVhvGllXspp2zcR0VS7dvVVW
         Kwa4WceNFCH1w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-doc@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: siphash: Fix typo in the name of
 offsetofend macro
In-Reply-To: <Ys13bqGuPYBUGg3O@zx2c4.com>
References: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
 <87fsj6bhwb.fsf@meer.lwn.net> <Ys13bqGuPYBUGg3O@zx2c4.com>
Date:   Wed, 13 Jul 2022 14:01:46 -0600
Message-ID: <87fsj44w9h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Hi Jon,
>
> On Tue, Jul 12, 2022 at 07:05:40AM -0600, Jonathan Corbet wrote:
>> Dov Murik <dovmurik@linux.ibm.com> writes:
>> 
>> > The siphash documentation misspelled "offsetendof" instead of
>> > "offsetofend".
>> >
>> > Fixes: 2c956a60778cbb ("siphash: add cryptographically secure PRF")
>> 
>> When you send a patch with a Fixes tag it's always a good idea to CC the
>> author of the patch being fixed.  Adding Jason...let me know if you'd
>> like me to grab this.
>
> Thanks for CC'ing me. Sure, feel free to take this:
>
>     Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Applied, thanks.

jon
