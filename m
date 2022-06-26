Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85D955AE44
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiFZCuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Jun 2022 22:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFZCuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:50:11 -0400
Received: from relay5.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F411A13;
        Sat, 25 Jun 2022 19:50:09 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id D04FD80BF9;
        Sun, 26 Jun 2022 02:50:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8AC4219;
        Sun, 26 Jun 2022 02:50:06 +0000 (UTC)
Message-ID: <a63132e226c2bb7b3f689cb09f7479adea5fe918.camel@perches.com>
Subject: Re: [PATCH] staging: fbtft: fix alignment should match open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     David Reaver <me@davidreaver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 25 Jun 2022 19:50:05 -0700
In-Reply-To: <20220626020002.1577101-1-me@davidreaver.com>
References: <20220626020002.1577101-1-me@davidreaver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: ie1xjhbtnmtckymqa5nbd5owyyick64u
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8AC4219
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+0U75mtrql51gGZXBWbhJ1RhG/AW4Ea4c=
X-HE-Tag: 1656211806-344269
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-25 at 19:00 -0700, David Reaver wrote:
> Fix alignment of this line of code with the previous parenthesis, as
> suggested by checkpatch.pl:
[]
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
[]
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

It's probably better to ignore the message in this case as the first
argument means something and the second and subsequent are the data
being written via a specific macro using NUMARGS.

