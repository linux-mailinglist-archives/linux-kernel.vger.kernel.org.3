Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4095A527B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiH2RCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH2RCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:02:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07448F978;
        Mon, 29 Aug 2022 10:02:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6826E4B7;
        Mon, 29 Aug 2022 17:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6826E4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661792529; bh=lITMwIZo+SwVJ3urgAJn4hEh/JgfK3bMEBBRVndmJi4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B3UwSpOhPlnkHaekPVUWQSaBAr17dmoNouXJYQAUZWIYTlU0SM2AgSH8j0WEQKpHE
         zPiIasVQCe0bEUYo804KgC7lvYIGj0Wqnbc/hW+9ckH8a6vPEzyh2uHQSxGsOaIfze
         RM7onaRh9ZvcDtiZqaKnLdaiFWAvlu2Y1/kSoKeft0ORVNnaqjkpldrtQCT/p4Fsde
         Z9eT1FN5q9xx5iwjyXAh87t4F3xitgkXO7pPjBeAYfz/3MquHZyBFjknB3ICgF/kRu
         YTTpnyVdnkm4hOLUEeI46QpelXRPYx1pkfpkFVRxaRzYua8SRp6L5CncvccHO0GN94
         UGz0ShAo6+VnQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akhil Raj <lf32.dev@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akhil Raj <lf32.dev@gmail.com>
Subject: Re: [PATCH] Remove duplicate words inside documentation
In-Reply-To: <20220827145359.32599-1-lf32.dev@gmail.com>
References: <20220827145359.32599-1-lf32.dev@gmail.com>
Date:   Mon, 29 Aug 2022 11:02:08 -0600
Message-ID: <87a67nouen.fsf@meer.lwn.net>
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

Akhil Raj <lf32.dev@gmail.com> writes:

> I have removed repeated `the` inside the documentation
>
> Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst            | 2 +-
>  Documentation/driver-api/isa.rst                  | 2 +-
>  Documentation/filesystems/caching/backend-api.rst | 2 +-
>  Documentation/locking/seqlock.rst                 | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Patch applied.

If I'm not mistaken, this is your first accepted kernel patch -
congratulations!

Thanks,

jon
