Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C510A5B0FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGWaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIGWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BB554CA2;
        Wed,  7 Sep 2022 15:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11896B81F27;
        Wed,  7 Sep 2022 22:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495D9C433D6;
        Wed,  7 Sep 2022 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662589817;
        bh=icUrwow2CfL0XBxzTtlHd9U90jN+X9EkDzy9xW2u15w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8fEiVnYdONLg4RYOnaYni7CG0VvoCxIZn0T6K99IIfhvScjtIRaOt19syHlKmEil
         t8eQLP01qbrGEqu2bL0WD40A1KOvexY13ymExhqqa3bh7c6D2qonaIVG5EYYhH1nsG
         d1GHZ79kMApd+lcxU46r0rUc7wauR0AJL3bJiUf4=
Date:   Wed, 7 Sep 2022 15:30:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, x86@kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, peterz@infradead.org, bp@alien8.de,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-Id: <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
In-Reply-To: <20220829212918.4039240-1-dave@stgolabs.net>
References: <20220829212918.4039240-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really dislike the term "flush".  Sometimes it means writeback,
sometimes it means invalidate.  Perhaps at other times it means
both.

Can we please be very clear in comments and changelogs about exactly
what this "flush" does.   With bonus points for being more specific in the 
function naming?
