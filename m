Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BAF50E101
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiDYNFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiDYNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:05:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138E13D76;
        Mon, 25 Apr 2022 06:02:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650891765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2Y0dk0v2QhhujXXXiV6zOwcfBigja4CJ2899Lak04o=;
        b=lStpSrmmi4KYtp03TySWwHgabipO3ogBfSK5wdUnufrg7j0LlNeKzlwp5Ch5HiaPcMVhbu
        Y9hwchP4opHl2U5R3kan3RpEAWEdXo15bnkqpP+rk4VOEe5M8dUNZtRNQZ6g1qUmwhhRFB
        rmpZzivYfuJf17PIFWuRCewkaudD/0sPlCx5WAFWQamyQ0HVjMDoH10ozxQ0n7c5TwUx3f
        dcHM9Lt9EwMq+2WpOWEnAWQRNvJUQpD7x4NSzmm4AivvUj2pyECgUn57AyJTQgGvzrK5pl
        oDitvN7PZ/ypsO7eSiUqdsFttsb0Jv4ndX2LMasnkZv2QgziOuuYZDc9co7wlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650891765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2Y0dk0v2QhhujXXXiV6zOwcfBigja4CJ2899Lak04o=;
        b=e2i6+Jb+88UVFeoH0DcTYq4uExD9X1HqWqx+jjouEVhdijW9+DqwoTLHMxFDre4EYVA8rP
        AQZYUOIOFr2iKeBw==
To:     Colin Ian King <colin.i.king@gmail.com>, Tom Rix <trix@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kernel/irq/matrix.c: remove redundant assignment to
 variable 'end'
In-Reply-To: <20220422110418.1264778-1-colin.i.king@gmail.com>
References: <20220422110418.1264778-1-colin.i.king@gmail.com>
Date:   Mon, 25 Apr 2022 15:02:44 +0200
Message-ID: <87sfq11fkb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin,

On Fri, Apr 22 2022 at 12:04, Colin Ian King wrote:

can you please stop using file paths as subsystem prefix in the patch
subject?

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

I fixed it up once more, but you can really spare me the effort.

Thanks,

        tglx
