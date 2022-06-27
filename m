Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D255DA92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiF0N5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiF0N5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618FB492;
        Mon, 27 Jun 2022 06:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A6860C86;
        Mon, 27 Jun 2022 13:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D34C3411D;
        Mon, 27 Jun 2022 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338218;
        bh=CJOgDl3yKXDiC5HaH/8sINEC7qK1aC5cCyVmQXJOweg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PNpA4zHA+xlOOo9au8hbyIJjE9gCOhR+pWBUrTF4+nbiPW01BtXNjJyV5MWDhcNp
         g/HlTtbvDt43T8Zi2Z3zAJGjHQJLV1ZVV5TE8rtFcguxN4PuIUVSMVB8jyig1GQEEZ
         kp3HAGqMh6mKHpon/1Hr9GrEOHF7C0RBZu96RXu8=
Date:   Mon, 27 Jun 2022 15:56:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Staudt <max@enpas.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Add N_CAN327 line discipline ID for ELM327 based
 CAN driver
Message-ID: <Yrm3J6C3bkanjfyq@kroah.com>
References: <20220618180134.9890-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618180134.9890-1-max@enpas.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 08:01:34PM +0200, Max Staudt wrote:
> The actual driver will be added via the CAN tree.
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
> Dear TTY maintainers,
> 
> The CAN people (well, a subset) have spoken and decided to accept the
> can327 driver (formerly elmcan), an ldisc based CAN driver allowing CAN
> experiments with commodity hardware.
> 
> After several rounds of reviews, the final condition is for you to
> accept this patch for N_CAN327, so here goes - please add this new line
> discipline to the list, and once this filters through, the driver itself
> will be added to can-next :)

Great, will go to Linus before 5.19-final is out.

thanks,

greg k-h
