Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBE577053
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGPRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPRGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:06:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 690F61EEE2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:06:15 -0700 (PDT)
Received: (qmail 73768 invoked by uid 1000); 16 Jul 2022 13:06:14 -0400
Date:   Sat, 16 Jul 2022 13:06:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/storage: fix repeated words in comments
Message-ID: <YtLwBqpS2aYGFF17@rowland.harvard.edu>
References: <20220716135217.49866-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716135217.49866-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:52:17PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
>  Delete the redundant word 'buffer'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/usb/storage/sddr09.c    | 2 +-
>  drivers/usb/storage/transport.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
> index 51bcd4a43690..cb0ae82b4abc 100644
> --- a/drivers/usb/storage/sddr09.c
> +++ b/drivers/usb/storage/sddr09.c
> @@ -1215,7 +1215,7 @@ sddr09_read_map(struct us_data *us) {
>  	/*
>  	 * read 64 bytes for every block (actually 1 << CONTROL_SHIFT)
>  	 * but only use a 64 KB buffer
> -	 * buffer size used must be a multiple of (1 << CONTROL_SHIFT)
> +	 * size used must be a multiple of (1 << CONTROL_SHIFT)

This isn't a redundant word.  There should be a period after the last 
word ("buffer") on the preceding line.

Alan Stern
