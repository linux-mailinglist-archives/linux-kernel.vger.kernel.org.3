Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2834F4EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581495AbiDEXj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457534AbiDEQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:06:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E76DDA;
        Tue,  5 Apr 2022 09:04:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BDB9B30D;
        Tue,  5 Apr 2022 16:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BDB9B30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649174671; bh=TxBmXjw0W5sHQw6Es3eDilnc949OOAkzg4pcLoQ5pHQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H4wh1pAW3CX+E4t5+ZvJ1Yzlz+YIDiiBS73DsABifoeqlVDs6pNd0teUfo+bFDHt3
         wxs4VOMCk4RFH/z7SJCbwXlgXIc8uLCHsklfTIjFr+uvWDb7xONGlSP+PE5HPi2gMd
         wNJaBTBsvvGnPnAeNTH7JGmXk2UuGIxGs1o8jnUhu+cQH9G5nTg37ZNbr92A5ByNED
         4WLtnJYOOrXKUnDr8Y8NBH1o2yHtcBTjuZ4IrHCq4DNuzust44nzQJlw1kmFPkEyeA
         XAdFVNf4xdgfL4HuWs8mk0tumHeL1kdZfTv8WfV4ANcLNb22Da+4hpS9ptiy9OrTk7
         UYPVArPCpiZNQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Documentation: doc-guide: Add missing page titles
In-Reply-To: <20220329045235.11879-1-bagasdotme@gmail.com>
References: <20220329045235.11879-1-bagasdotme@gmail.com>
Date:   Tue, 05 Apr 2022 10:04:30 -0600
Message-ID: <87sfqrectt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The kernel documentation guidelines [1] lists that there should have page
> title.
>
> Add missing page title for kernel-doc.rst and sphinx.rst, in accordance
> to the guideline.
>
> Changes since v3 [2]:
>   - Clarify that there is no output differences except formatting
>     semantics in [1/2]
>   - Drop Suggested-by trailer from Akira Yokosawa in [1/2] 
>
> [1]: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation
> [2]:
> https://lore.kernel.org/linux-doc/20220328065030.24936-1-bagasdotme@gmail.com/
>
> Bagas Sanjaya (2):
>   Documentation: kernel-doc: Promote two chapter headings to page title
>   Documentation: sphinx: replace "Introduction" chapter heading with
>     page title
>
>  Documentation/doc-guide/kernel-doc.rst | 2 ++
>  Documentation/doc-guide/sphinx.rst     | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

OK, I think this improves the situation overall, so I've applied these,
thanks.

jon
