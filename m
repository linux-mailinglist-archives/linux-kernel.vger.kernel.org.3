Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4C53EAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiFFQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbiFFQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:08:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED945FDD;
        Mon,  6 Jun 2022 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BTkBGPOQBnugqSzn8eLuGd4rM1iSDLOsvnLCslHwyGE=; b=hgTPHiBYlfwkGkI63QfFhvMbyB
        4srPt4mfRmF1EbDrRBueAz1xHa22G14lX1rbiaVLA6TsVxzTZ2XoHL1V2Zlz+uqFHhw5CtNCsIGyo
        j6cxzassqK2CA+vFfaQrxGnW+HXBV/L3Chcl7a52m9igHcVSp3NkOTsdTLiJVFVEYP64v13fU7fFY
        JCe5M8MxG5WhrZFaLvlHPqefR+NQkgfCs87WAgKzJ5nymVNXZpVyM9Q2jXnfYxcc5EQEH65ScSm+8
        XUKA/QWDplvvXv3kyo/4rmT8xqxSfwAO2Jcke8TQCXR55m1LA3Ul9hqZvW+Muc3xqDJ9LRzsCIMC9
        DBgsmWzg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyFGl-005Ue0-RQ; Mon, 06 Jun 2022 16:07:56 +0000
Message-ID: <d4de59db-62ba-22c3-3fc4-c69aa46b5c7a@infradead.org>
Date:   Mon, 6 Jun 2022 09:07:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 23/23] arch: m68k: q40: README: drop references to IDE
 driver
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <39b24f99f5b71eb5ac025b438b7eb2a0df2258a1.1654529011.git.mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <39b24f99f5b71eb5ac025b438b7eb2a0df2258a1.1654529011.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/22 08:25, Mauro Carvalho Chehab wrote:
> Since IDE support was deleted by Christoph Hellwig <hch@lst.de>,
> Jun 16 2021, drop the left-over from README file.
> 
> Fixes: b7fb14d3ac63 ("ide: remove the legacy ide driver")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>  arch/m68k/q40/README | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
> index a4991d2d8af6..4db6db54d57a 100644
> --- a/arch/m68k/q40/README
> +++ b/arch/m68k/q40/README
> @@ -30,9 +30,7 @@ drivers used by the Q40, apart from the very obvious (console etc.):
>  		     genrtc.c		# RTC
>  		char/joystick/*		# most of this should work, not
>  				        # in default config.in
> -	        block/q40ide.c		# startup for ide
> -		      ide*		# see Documentation/ide/ide.rst
> -		      floppy.c		# normal PC driver, DMA emu in asm/floppy.h
> +	        block/floppy.c		# normal PC driver, DMA emu in asm/floppy.h
>  					# and arch/m68k/kernel/entry.S
>  					# see drivers/block/README.fd
>  		net/ne.c

-- 
~Randy
