Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEB53E3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiFFHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiFFHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A52ED7E;
        Mon,  6 Jun 2022 00:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D4B611B8;
        Mon,  6 Jun 2022 07:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F406C3411C;
        Mon,  6 Jun 2022 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654501809;
        bh=+PxN/7lvs+ASkg1d8jxQyQDR3Lobei2q0DKdDD97ktw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pwhUPAgaA9QhCiYGxDCk9eaj+IbeH14pxMoRfl/UTuwE4GXzoYOBl4rA6IAUn3UFj
         Lwqs+cP1bZszz57GB4GEvJ0hK3haysGkh1X7amUqlumPRQGwOC8DCOiDVNJa3ll4sy
         IRy0KfTytHS1YUq5kNx42jRzpmuSgsGn3/1mua3vv2pwYM/6XmbMBc1VOYjMc2EYPw
         LQhRzq4eChFBoN8NeV37mnWAWY8evcKp2k9uEzD3+AIKugyzMS8gm4KxRxhbQVPnFQ
         ASj/eKEU1SvqU9NfY6FNot0pOndtpCe2iN7Dz/J/Wv8ojapA5qChLQo92lcvhwP+/G
         YzmIL0X/RVLOw==
Date:   Mon, 6 Jun 2022 08:50:02 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] gpio: Fix kernel-doc comments to nested union
Message-ID: <20220606085002.714b7e98@sal.lan>
In-Reply-To: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
References: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 6 Jun 2022 13:44:24 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Commit 48ec13d36d3f ("gpio: Properly document parent data union")
> is supposed to have fixed a warning from "make htmldocs" regarding
> kernel-doc comments to union members.  However, the same warning
> still remains [1].
> 
> Fix the issue by following the example found in section "Nested
> structs/unions" of Documentation/doc-guide/kernel-doc.rst.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 48ec13d36d3f ("gpio: Properly document parent data union")
> Link: https://lore.kernel.org/r/20220606093302.21febee3@canb.auug.org.au/ [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/gpio/driver.h | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index b1e0f1f8ee2e..54c3c6506503 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -167,21 +167,24 @@ struct gpio_irq_chip {
>  	 */
>  	irq_flow_handler_t parent_handler;
>  
> -	/**
> -	 * @parent_handler_data:
> -	 *
> -	 * If @per_parent_data is false, @parent_handler_data is a single
> -	 * pointer used as the data associated with every parent interrupt.
> -	 *
> -	 * @parent_handler_data_array:
> -	 *
> -	 * If @per_parent_data is true, @parent_handler_data_array is
> -	 * an array of @num_parents pointers, and is used to associate
> -	 * different data for each parent. This cannot be NULL if
> -	 * @per_parent_data is true.
> -	 */
>  	union {
> +		/**
> +		 * @parent_handler_data:
> +		 *
> +		 * If @per_parent_data is false, @parent_handler_data is a
> +		 * single pointer used as the data associated with every
> +		 * parent interrupt.
> +		 */
>  		void *parent_handler_data;
> +
> +		/**
> +		 * @parent_handler_data_array:
> +		 *
> +		 * If @per_parent_data is true, @parent_handler_data_array is
> +		 * an array of @num_parents pointers, and is used to associate
> +		 * different data for each parent. This cannot be NULL if
> +		 * @per_parent_data is true.
> +		 */
>  		void **parent_handler_data_array;
>  	};

Yeah, kernel-doc expects inlined comments to be just before each
declaration like the above.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Regards,
Mauro
