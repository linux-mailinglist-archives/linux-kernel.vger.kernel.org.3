Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A75A1908
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiHYSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbiHYSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:48:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76422B56F2;
        Thu, 25 Aug 2022 11:48:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F19031A;
        Thu, 25 Aug 2022 18:48:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F19031A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661453320; bh=GKo/HAiBH1pXBkoB5hyeNe5OnaTVwZXlZaRMSpQF2cw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TcsXQfqYBT0COO2IbL78QjtCZUDRmFCGfh3DDIdkW584XixMW+lQnzwj+D/kIJXi0
         RMlCYwBI1K2ZhF7sFELlJ2CUs7wWuzHJpPX6JIIAtoDJJTl1c/JKAWycxWJiP+5V0e
         HMxhlCs+2AePO9I/9B0s6tKh3THSK3iOIO0jeEc8ilHkg1sTEydvdjvqaIZuRGwSJn
         spZLldruA8nOuQK+Y1nJuhKRpSYnjNXlsKExuB0drOrLLKSEuWO1SrsGn8iNo3ukaG
         ihIvde59tEbzJ5Rk7r4tCQw1iOQGoVul/+g8klzOhnGz+CeonrL/aDhpdVtBYIcfDR
         cJxA6dvzLutLQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
In-Reply-To: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
Date:   Thu, 25 Aug 2022 12:48:39 -0600
Message-ID: <87a67syxa0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> A quick 'grep "5\.x" . -R' on Documentation shows that README.rst,
> 2.Process.rst and applying-patches.rst all mention the version number "5.x"
> for kernel releases.
>
> As the next release will be version 6.0, updating the version number to 6.x
> in README.rst seems reasonable.
>
> The description in 2.Process.rst is just a description of recent kernel
> releases, it was last updated in the beginning of 2020, and can be
> revisited at any time on a regular basis, independent of changing the
> version number from 5 to 6. So, there is no need to update this document
> now when transitioning from 5.x to 6.x numbering.
>
> The document applying-patches.rst is probably obsolete for most users
> anyway, a reader will sufficiently well understand the steps, even it
> mentions version 5 rather than version 6. So, do not update that to a
> version 6.x numbering scheme.
>
> Update version number from 5.x to 6.x in README.rst only.

I've gone ahead and applied this.

For the other files:

 - I don't think 2.Process.rst needs any immediate attention.  We could
   change the wording from "recent release history" to "The release
   history in early 2022 looked like:" or something like that.  There is
   no reason why it has to be the latest releases.

 - applying-patches.rst should just go.  I didn't prevail last time I
   tried to make that point, but I still don't think that we help
   anybody by dragging 1990's instructions around now.

Thanks,

jon
