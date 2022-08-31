Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766675A7F09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiHaNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHaNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:37:41 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 06:37:36 PDT
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5436262B;
        Wed, 31 Aug 2022 06:37:36 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 27VD9wFf001483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Aug 2022 22:40:00 +0930
Date:   Wed, 31 Aug 2022 22:39:58 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] USB: serial: ch341: fixes for older devices
Message-ID: <Yw9dpgmPbEz6nkxg@marvin.atrad.com.au>
References: <20220831081525.30557-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831081525.30557-1-johan@kernel.org>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:15:23AM +0200, Johan Hovold wrote:
> Jonathan Woithe reported that there was a regression for some older
> ch341 devices in 4.10. Turns out there were two of them.
> 
> Jonathan, feel free to reply to this mail with a Tested-by tag. You've
> already tested these changes during development even if I've since split
> the patch in two. And thanks again for your careful testing while
> tracking this down.

Tested-by: Jonathan Woithe <jwoithe@just42.net>

> Johan Hovold (2):
>   USB: serial: ch341: fix lost character on LCR updates
>   USB: serial: ch341: fix disabled rx timer on older devices
> 
>  drivers/usb/serial/ch341.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> -- 
> 2.35.1
