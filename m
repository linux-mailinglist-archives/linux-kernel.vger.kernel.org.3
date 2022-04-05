Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866D4F4C09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575551AbiDEXIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457669AbiDEQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:32:16 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B47BF00A;
        Tue,  5 Apr 2022 09:30:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B8E77608;
        Tue,  5 Apr 2022 16:30:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B8E77608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649176216; bh=yij2fHsXTf4G+j5va51uVCSzBxLR4AmBmwSualkA3To=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Re3UZ78E/X9xogYjhRmUCeC4BE4weHRkssFjQKYLpcfQMFb08YPhHw7SiVat969tp
         UIIIuQKlsW7Lrhae31WV/th451Jr1Lqxm3qrFHIYtujgvKBS1CFKjupfE5eLVgRKz4
         t2zS2kqzcqqQIzL/zFeM/7UYBWQ7rH0edgWhAtgFRUdVEIj/3NQXEP+aMONZbzxcdF
         EbDlooIGHHxn+vlhyTkxxNfDtOrp7dmAkzfrPQ6Qclz1RA3w+ibWAR3eqAb9orpp11
         DDdm7FUr4OJcewWt1TyeSmV2blaPxifx/D2W6BkGs04A9OL6h+0BC/CXD0CLNNts94
         dETfHvbBpCP9Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chin En Lin <shiyn.lin@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Chin En Lin <shiyn.lin@gmail.com>
Subject: Re: [PATCH v2] Documentation: x86: Fix obsolete name of page fault
 handler
In-Reply-To: <20220318142536.116761-1-shiyn.lin@gmail.com>
References: <20220318142536.116761-1-shiyn.lin@gmail.com>
Date:   Tue, 05 Apr 2022 10:30:16 -0600
Message-ID: <878rsjebmv.fsf@meer.lwn.net>
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

Chin En Lin <shiyn.lin@gmail.com> writes:

> Since commit 91eeafea1e4b ("x86/entry: Switch page fault exception to
> IDTENTRY_RAW"), the function name of the page fault handler is out of date.
> And because of commit aa37c51b9421 ("x86/mm: Break out user address space
> handling"), the description of search_exception_table is not correct
> anymore. It may mislead the user who wants to use the documentation to
> figure out the page fault handler.
>
> Also, fix typo and add the parentheses after function and macro name.

"Also" in a changelog like this is an indication that you've moved on to
an independent change that should be done as its own patch.  That is
certainly true of typo fixes and such, which should be separated out
from more substantive changes.

> Signed-off-by: Chin En Lin <shiyn.lin@gmail.com>
> ---
>  Documentation/x86/exception-tables.rst | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Nonetheless, the patch seems clear enough and nobody has objected, so
I've applied it.

Thanks,

jon
