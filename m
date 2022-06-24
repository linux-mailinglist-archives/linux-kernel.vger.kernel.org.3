Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9555A212
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiFXTrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:47:31 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1FD82691;
        Fri, 24 Jun 2022 12:47:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2203E31A;
        Fri, 24 Jun 2022 19:47:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2203E31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656100050; bh=5M1OQZAtB4dqYN5TPxJPGihAtQg5IBVNnMf4zWxe6SM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NOLMKEoEWgEQCZiTw15GDOgIgGu7w/YiO0ttqunn4PoZNykSEtsn81PqwybPslOcb
         LMUlDqXvMnV7zw3hJd8R254IUVbyOQTy5aG3YAEU3G8t/aw7GcQGQIcRCUxRSZoQQj
         3+ZaJ/Ap4EF6hZpZEI9uMS2rZZCIJtAbvvWTeJvMqVZP7F91ydwjag9201fOeTdJfF
         lm1p8v6KQudeYQyhAXV4oqkOTSYmawRh0xnnnzMB0C5AP4IccFxnsnELZv9yE3HjLu
         0vQIfAWzoAQ7+vDxXQOLIcvCTjFAmEUCzRdBOewdqkDmGLK95WCXVPv9U+Ti+Lz+Ke
         VRKqna0bZNDBQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
In-Reply-To: <20220603195626.121922-1-dlatypov@google.com>
References: <20220603195626.121922-1-dlatypov@google.com>
Date:   Fri, 24 Jun 2022 13:47:29 -0600
Message-ID: <87pmix3ktq.fsf@meer.lwn.net>
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

Daniel Latypov <dlatypov@google.com> writes:

> The information is duplicated now in run_wrapper.rst, which was added in
> commit 46201d47d6c4 ("Documentation: kunit: Reorganize documentation
> related to running tests").
>
> You cna compare these pages here:
> https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/run_wrapper.html
> https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/kunit-tool.html
>
> We should have deleted it in then but it got overlooked.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

So not that long ago these patches were going through Shuah...it seems
that's not happening anymore?  I can pick up kunit docs patches,
certainly.  I've taken the silence on these as assent and applied them.

Thanks,

jon
