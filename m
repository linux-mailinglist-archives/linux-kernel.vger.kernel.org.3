Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D2563CA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGAXFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGAXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED36D56B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3415623AF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF29C3411E;
        Fri,  1 Jul 2022 23:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656716720;
        bh=WnyYw9JAEHoRQ4a7AdP/qqOINnrE9Dzf8lU87SgBPkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qX4eslRZE/kcr7jWS5PJL7+2R5LOtjLPRDFgJkVBL07SNIvBAn8mPNX5sA3d2ukw7
         JXovN2pcwmoHQ3fQy13gwlR+roncGiv7CbJUbYXW4ClvfBTAQKENWpHABwtiiy9DyI
         0qTPUTZyQiGsDcIPv3BcMRhopt0OSoAp7ThJGxAo=
Date:   Fri, 1 Jul 2022 16:05:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Subject: Re: [PATCH] mm/mmap.c: Fix typo and space mistake
Message-Id: <20220701160519.d82a059335264dda21b9871d@linux-foundation.org>
In-Reply-To: <20220630083124.71336-1-jiaming@nfschina.com>
References: <20220630083124.71336-1-jiaming@nfschina.com>
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

On Thu, 30 Jun 2022 16:31:24 +0800 Zhang Jiaming <jiaming@nfschina.com> wrote:

> Change 'writeable' to 'writable'.
> Delete or add spaces around ','.
> 

"writeable" is actually OK.  Less common than "writable".

I do feel the patch is too minor to bother changing the kernel for,
sorry.
