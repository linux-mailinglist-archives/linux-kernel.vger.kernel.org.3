Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E650B151
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444738AbiDVHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444651AbiDVHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:24:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546145005F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:22:01 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4BFBB2D3;
        Fri, 22 Apr 2022 07:22:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BFBB2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650612121; bh=3JPPuZ2UfziPTfNN7iLT4YLUFPLT4ayIFEmKrIc2mkg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BED3eAYOQ7FIm+3r3hULoP4loUm0Q0F6NzEGsMY8Mgp5d9jJoF+AKcHY5RtVhRgg5
         HtXdxz7db4GTF4FjDNmI5tGQ5c0v3pgx2haHJIoTdj0dZWfzQJAGVF4bi+iC8H9k9O
         9xiRKFUV4bgfJnYzP9M1cy9ieOZ4FWVfu+lacxk+syJI46xR9NpAvH/t6zy+8V5k5s
         KcFn8y5FoswX1zwZnYdTlHHQWHboYMS5BPdUy8afLP28aNlVSXeqCYqtExEhy5WfNR
         GPPw+xNWVQPNiGc32Lv11HyQhx8T/q8dSFPofrK8Of2UM1lCgWx9wjB9a9TvSdYpAG
         AJsyq4mfcTmcA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the jc_docs tree
In-Reply-To: <YmJMBnBV8wO4aco9@sol.localdomain>
References: <20220422135927.7fa82fa4@canb.auug.org.au>
 <YmJMBnBV8wO4aco9@sol.localdomain>
Date:   Fri, 22 Apr 2022 01:21:56 -0600
Message-ID: <87wnfhzip7.fsf@meer.lwn.net>
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

Eric Biggers <ebiggers@kernel.org> writes:

> That's not exactly the correct resolution, since it dropped the change to the
> text of this paragraph that my patch made ("HalfSipHash" => "the hsiphash
> functions").
>
> We should get the updates to this file to go through one tree.  Jason, probably
> you'd want it to be yours?

If you want changes to parts of Documentation/ to not go through the
docs tree, just say the word and I'll avoid it.  A MAINTAINERS file
addition to direct those patches youward would also not be misplaced.

Meanwhile, Jason, if you want to pick up the offending patches directly,
I can drop them from docs-next.

Thanks,

jon
