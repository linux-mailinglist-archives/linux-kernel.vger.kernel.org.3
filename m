Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FEE57067B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGKPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiGKPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A357696F;
        Mon, 11 Jul 2022 07:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9B5A61582;
        Mon, 11 Jul 2022 14:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA62C34115;
        Mon, 11 Jul 2022 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657551583;
        bh=dxZGKngfKO1Un0ysAWdBwrkK8xmIWeIei9M7jEZdOHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGwk1jTuNGOtpzHLQ7/aldklQ4LAtQOSBbU+hNaaRFVKhRQBPEbIk14EDNRiubnXH
         xc5ETYEeLmrbgkdEvLWPOVDBqn4kQpo9dUqZ2AuuGDBHBRuoV406k9kaI+KN867EdD
         v/fMt8rcjQfkhnMy87zktIzILzf4T8zZtfCNwx7AuGJHfKvon8lXc+aR4cZqHbDV1M
         M4ibjcxGLSNTqO1IDyudF9xbDd8hzsv4weSah2mk5lUhSYe4/RPJr/QeJIGZ+fp1xV
         ocVMh/BCEFRW5dnbOmvsL8yvd9baP8OKXmjc9+jQE4YxWr/9w8Smsdqn/zf+5+szQ8
         60nlq1Rbh9q7A==
Date:   Mon, 11 Jul 2022 08:59:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Block: bio.c:1232:6: error: variable 'i' is used uninitialized
 whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
Message-ID: <Ysw627zSWSrEzrUZ@kbusch-mbp>
References: <CA+G9fYtDr=tqPmM6f9aGQOfqkxUo-yP-kHBQG787D0Cj6oO-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtDr=tqPmM6f9aGQOfqkxUo-yP-kHBQG787D0Cj6oO-dg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:14:10PM +0530, Naresh Kamboju wrote:
> Following regression found with clang i386 and x86 builds failed on
> Linux next-20220711 tag. Please find the build error logs.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Sorry, I needed to send a v2 of this patch. I didn't realize this was already
merged (it doesn't appear in the block tree), though, so I'm not sure if I need
send a fixup patch or the correct version now.
