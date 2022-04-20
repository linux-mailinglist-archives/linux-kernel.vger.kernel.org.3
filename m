Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1FA50921F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382547AbiDTVhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382542AbiDTVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:37:19 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A2488A1;
        Wed, 20 Apr 2022 14:34:30 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DCB90536;
        Wed, 20 Apr 2022 21:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DCB90536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650490470; bh=6T0lvX8RNX9xGYkNbu6K5mxfaWl3HxhoGMIgYH6RZgk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EQpMNXKGIxm38WSQDxnU2OdP/4CzkhHcofv0U0qShswpXUT1Hkk9mmRTNoIfYP7YN
         yd7D6NQU2ueg5+AjSzzYWO0YAs3ortCaoNy048kqLPG+qR7KUWMRE7oBBldiOwEbHG
         6QPzRlP8bjEAPdGBzvP1d3cj3IgVmxiEezT/GofTarisxddOGNc0uTyrGkE7eyAKaV
         xZdO6L0SfWQkgv4rla7xsCk0Wk7jLC/vbX/wzTw/C9+PKc4Fhyc3USGVAHFRu4lKBM
         SExjDE70Y7pDHa8oXj/tn1s94SQxyY0T1GS0gdbWrDPOSxwbWn6VnWCvtY832M07Lw
         UgolFy9dY8XQg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/2] Docs: Update information at changes.rst
In-Reply-To: <20220420172731.ru7kfrdkmprybtu7@AN5Bruno>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <8735i83xo1.fsf@meer.lwn.net> <20220420172731.ru7kfrdkmprybtu7@AN5Bruno>
Date:   Wed, 20 Apr 2022 15:34:26 -0600
Message-ID: <878rrz30d9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Moreira-Guedes <codeagain@codeagain.dev> writes:

> On Wed, Apr 20, 2022 at 03:35:10AM -0600, Jonathan Corbet wrote:
>> Bruno Moreira-Guedes <codeagain@codeagain.dev> writes:
>> >
>> > The PATCH 1/2 fixes the missing cpio requirement, while PATCH 2/2 fixes
>> > the kernel version reference.
>> >
>> > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
>> 
>> Patches applied, thanks.
> Thanks, Jon! I have also been thinking whether this filename
> ('changes.rst') is a good description of the file contents. Do you think
> renaming it to something like 'requirements.rst' and updating its
> references would be a good patch?

It's best not to rename things unnecessarily, especially relatively
well-known files that a lot of people expect to find in a specific
place.  We've done a lot of renaming over the last few years, but this
is one I might let slide for now.

Thanks,

jon
