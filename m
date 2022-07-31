Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4A585EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiGaMGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiGaMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9911811;
        Sun, 31 Jul 2022 05:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB5DDB80D22;
        Sun, 31 Jul 2022 12:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D0C433C1;
        Sun, 31 Jul 2022 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659269187;
        bh=Se9FkQxANlAwHjxN1LjC3vcQxv0TnFP/HKCkwE0T6M4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wjw5g8DRjJmSGtjsy1LbvwlnQD6A9I3CwUrbAyJcw5+oSDR0LQNNtLIvuZtQa5YQQ
         8jDmK8mvpE448lObTZIXVmc/NOZgD33VTUaieN2gl5gyXyNVNgwgKdJikkDn/BvBtp
         udRpw+U+1EPsEtNDjc1n3EyXpTEonb96FSFNlA2TmHHiDbFZKwxoCNTOfOTVGK0UGp
         iElnN0V8HUc/KELY5s7qmjtuuYGgiAiCqrR84AJBEEpfguTJiT4VNS/MFDVnRbAeUu
         hS3O4gacQZTWeASOw8Hesz6ua3g2Utv1qly302tu/s/UgTAIrapPcv2TJfcYnMekYc
         p4Mj/lmw2pn8A==
Date:   Sun, 31 Jul 2022 13:16:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: Whitespace cleanup
Message-ID: <20220731131640.6c3be253@jic23-huawei>
In-Reply-To: <20220727181855.589052-1-joetalbott@gmail.com>
References: <20220727181855.589052-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 14:18:53 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> Fix whitespace warnings reported by checkpatch.pl.
Hi Joe,

Series applied to the togreg branch of iio.git and pushed
out as testing.  Note I'll rebase that branch on rc1 once
available and not push out as togreg until after that.

Thanks,

Jonathan

> 
> Joe Simmons-Talbott (2):
>   iio: Add blank lines after declarations.
>   iio: Fix indentation for multiline conditional.
> 
>  drivers/iio/industrialio-buffer.c  | 5 +++--
>  drivers/iio/industrialio-core.c    | 7 +++++++
>  drivers/iio/industrialio-trigger.c | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 

