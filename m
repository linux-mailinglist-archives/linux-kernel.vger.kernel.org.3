Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14A554B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354358AbiFVNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353545AbiFVNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878E93701E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E7A0B81F2A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A54C34114;
        Wed, 22 Jun 2022 13:40:11 +0000 (UTC)
Message-ID: <489a9048-6559-dca6-a4a1-50cba7105820@linux-m68k.org>
Date:   Wed, 22 Jun 2022 23:40:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] m68k:coldfire:Fix typos in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220622073553.64991-1-yuanjilin@cdjrlc.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20220622073553.64991-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jilin,

This same change was recently submitted by Xiang wangx, and that has
been added to the m68knommu git tree (for-next branch). See:

     https://lore.kernel.org/lkml/6fe2468a-9664-30f7-7f17-9093289eb4b6@linux-m68k.org/T/

Regards
Greg


On 22/6/22 17:35, Jilin Yuan wrote:
> The "the" should be replaced by "of" instead.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>   arch/m68k/coldfire/intc-2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/intc-2.c b/arch/m68k/coldfire/intc-2.c
> index 995093357c59..f74f0e473119 100644
> --- a/arch/m68k/coldfire/intc-2.c
> +++ b/arch/m68k/coldfire/intc-2.c
> @@ -7,7 +7,7 @@
>    * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
>    * controllers, and the 547x and 548x families which have only one of them.
>    *
> - * The external 7 fixed interrupts are part the the Edge Port unit of these
> + * The external 7 fixed interrupts are part of the Edge Port unit of these
>    * ColdFire parts. They can be configured as level or edge triggered.
>    *
>    * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>
