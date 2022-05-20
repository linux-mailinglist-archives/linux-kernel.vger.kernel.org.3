Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F6852EFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351207AbiETP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiETP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:58:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F5A7768
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A29F7B82C4E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A757BC385A9;
        Fri, 20 May 2022 15:58:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zsj7/ThU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653062284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWbprvAWOP/8Se2WWbgIE/e2A5IGGQwBIYVgj+qhc+o=;
        b=Zsj7/ThUlf1u+6Z23/DCpFprqR53SGl/uk8Af1iBIJ55Qc9X4dA5YAzkmsisYa+oIJqzpJ
        Xx7o8YuIGeCm5R/ukx/F/T7P80WJzWH76H+7U53MdLUwoM3dc24GOk4ddH/O7psUFXL4Ou
        /BaqriAh3a7F0NBWmWlZdeQcbpoRFfo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e82306b4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:58:04 +0000 (UTC)
Date:   Fri, 20 May 2022 17:58:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe6iltcPVcTL6dD@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe3vFmqx4Yua0a1@zx2c4.com>
 <72344aad-b5ad-b317-d36d-385cb16d5204@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72344aad-b5ad-b317-d36d-385cb16d5204@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 09:51:06AM -0600, Jens Axboe wrote:
> ABI. Obviously that can happen sometimes, but I think this one is
> exactly the poster child of breakage that should NOT happen. We took
> away a feature that someone depended on.

I suppose somebody (Meta, I presume) *did* notice the breakage, which is
sign enough.

Jason
