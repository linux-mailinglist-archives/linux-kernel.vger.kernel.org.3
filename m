Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B553A0B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351246AbiFAJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351171AbiFAJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1D18FD76
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC3F6152F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70232C385A5;
        Wed,  1 Jun 2022 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654076105;
        bh=fh9C+l4WXBO/9+rE1BEUsHimABjoUujQsVhJBdNO+yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvJHGvyEUldjq7/zjX7flnErdq6uqeZpbbK71xMky5wuaHksRp13sOjboRUg7RTpE
         ozv0kPi5VAU95TJvZkS6DyKdo7Iudee9Gnv6jw3mmxqQrYsM4Mg/at2k6u71PxqXS0
         84oYA6YB8oyrYvnM+kbVPzgIorO4UJGwV5RpOsio=
Date:   Wed, 1 Jun 2022 11:34:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     keliu <liuke94@huawei.com>
Cc:     TheSven73@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: Directly use ida_alloc()/free()
Message-ID: <Ypcyv2YahZ+lS40D@kroah.com>
References: <20220527062938.2356319-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527062938.2356319-1-liuke94@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:29:38AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 6 +++---
>  drivers/staging/fieldbus/dev_core.c            | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

As my bot said, you need to properly document and fix up your author
name on all of these patches.  I'll drop them all from my patch queue,
please fix up and actually test-build your changes before sending them
out again.

thanks,

greg k-h
