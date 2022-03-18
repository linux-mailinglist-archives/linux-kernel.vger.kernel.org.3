Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F144DD9C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiCRMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiCRMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11012D7A80
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B111618F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F24FC340E8;
        Fri, 18 Mar 2022 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647606746;
        bh=aYLil5ROb62UUTxuWnpWvEWzdBhwzA6SungBuJoOFBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLCOsrHBRVDwWVsAF68xETHKpmws2+B7Ixqejlk79KbcwaAAQ/xZgogvxTyZTO77n
         NHKIIfKvFkbRIxfAYsFkZOX8mVhlcRdr0rxGFrfiPJPpORMoog+vVspnolxoG0iOb4
         kBuUiENWDh2qlV9KDUFU9KVUYLIA+rSmvdJRcv2s=
Date:   Fri, 18 Mar 2022 13:32:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     arnd@arndb.de, jirislaby@kernel.org, dsterba@suse.com,
        elder@linaro.org, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Use bitwise instead of arithmetic operator for flags
Message-ID: <YjR7xw4/7AqV82uF@kroah.com>
References: <1647574342-24488-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647574342-24488-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:32:22AM +0800, Haowen Bai wrote:
> to make code clear.

That is an odd changelog comment.  Please read the documentation for how
to write a good changelog text and try again.

thanks,

greg k-h
