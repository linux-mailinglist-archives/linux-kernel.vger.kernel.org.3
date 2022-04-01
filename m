Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C394EE614
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiDACev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiDACeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63371255AB3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23382B82206
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E2EC340ED;
        Fri,  1 Apr 2022 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648780378;
        bh=n0qM4nf5Ta5C6oUtQqbjtn+9oGwp1yQktL1/ylHeBYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJk+lJV8JQGFKgNBkVIy4o07iMRsdKIy9ttLfY+D6ICy/YEw48tMZ7C7Z0pQV/C/0
         8nqNRv+nbehyb7BwUK2QGdvMBJyOESDwL53sOQcu9U53TMd5rwiuRq8x/foOHH4DTB
         Q852v2UhQHMlUfeGBunJmzRccXQMm6EWEBefi6ls=
Date:   Thu, 31 Mar 2022 19:32:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: use mmap_assert_write_locked() instead of open coding it
Message-Id: <20220331193257.c6e52c65346cbc21ba5a7bf5@linux-foundation.org>
In-Reply-To: <10178697.CBVEcFiDRS@mobilepool36.emlix.com>
References: <5827758.TJ1SttVevJ@mobilepool36.emlix.com>
        <YkKo93R1Fm0JXXtS@infradead.org>
        <10178697.CBVEcFiDRS@mobilepool36.emlix.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 08:45:37 +0200 Rolf Eike Beer <eb@emlix.com> wrote:

> You are right, it was in tools/include/linux/kernel.h and I didn't spot the 
> prefix. Andrew, maybe you could just delete the sentence when you add the 
> Reviewed-by?

Did that.  I used simply "In case the lock is actually not held at this
point."

