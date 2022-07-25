Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B457FF12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiGYMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGYMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:37:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D72DEFD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76CC2B80DE9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42692C341C6;
        Mon, 25 Jul 2022 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658752630;
        bh=bCsOpz9X2hR0QmGK+xFNkciFND5VFgzVrdblUuzHv8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtR+bADfVSDPLoyLfOllYL37Mo34syaE8mZYC5nIT+kxCLlG8PvrxtxldO/a1r+3T
         ppRwfR3LZInSW/IRlogHcUUCWZHn13pPi9I5WaD1GwfAg8CwxPwZ4IaIg7UZKk5jLE
         N6MfUn/BtkGJO1bmnngHKAVTFsn5iZcTyjR5waLo=
Date:   Mon, 25 Jul 2022 14:37:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tury <renyu@nfschina.com>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
Subject: Re: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by
 kmalloc(),vmalloc()
Message-ID: <Yt6OcTErVYiGYRXq@kroah.com>
References: <20220725081153.20228-1-renyu@nfschina.com>
 <Yt5XZN3CdTprfjwk@kroah.com>
 <bd13881e-6a78-8831-18a8-5b022e8648ce@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd13881e-6a78-8831-18a8-5b022e8648ce@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Jul 25, 2022 at 05:54:15PM +0800, tury wrote:
> When there is insufficient memory, the allocation will fail.

And have you ever seen that happen here?  The issue is for small
allocations, they never will fail.

> the return value is void,so i think it is ok .

Why?

> should i have changed comment to something like this ?
> 
> As the possible alloc failure of the kmalloc() and vmalloc(),
> the return pointer could be NULL.therefore it should be better to check it.

Please wrap your lines properly, and use '.' correctly.

thanks,

greg k-h
