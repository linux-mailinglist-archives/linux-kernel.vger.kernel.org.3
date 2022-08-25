Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DCB5A190F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbiHYSue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHYSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:50:31 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC8AB05F;
        Thu, 25 Aug 2022 11:50:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC6232E2;
        Thu, 25 Aug 2022 18:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC6232E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661453430; bh=y42Jf/ag9rU15ToKoopXiKAz4rUlonTv87e8xUVPCd0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RVEMFYtlAdcfdp9M02F2cjSEDTIPcvvWhZlWJbRfuME+Dmdal3T5IUCFQapXOB1VB
         bWZBFis1jPQqM0li0LPjmGGpfVHpN4rXWMQl7fKBY6JCRz9qTHT+TqwwlDeZJ/N9Qa
         J/XMyJz20DRhUzhFYbmC+uBBl/O5jDkW8jOwTGtirHakP5MZroVIAd45KsI+/6I8tk
         b/GHl9/XTl7xMTkFnMhGrjbLOPjg9xvuMUFOqCD0rs99y+jR4xQ4AMK9kE2SVJ8j88
         vr0qvHZrcosA5i7D/KsvAkeZxvh016DI7/h1qHS87UPxKgHzvPREG9ugDHYFt17u0h
         otT7y//sAhkpQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kairui Song <ryncsn@gmail.com>, damon@lists.linux.dev
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v2] Docs/admin-guide/mm/damon/usage: fix the example
 code snip
In-Reply-To: <20220823114053.53305-1-ryncsn@gmail.com>
References: <20220823114053.53305-1-ryncsn@gmail.com>
Date:   Thu, 25 Aug 2022 12:50:29 -0600
Message-ID: <875yigyx6y.fsf@meer.lwn.net>
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

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> The workflow example code is not working since it got the file names
> wrong. So fix this.
>
> Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

I've gone ahead and applied this, thanks.

jon
