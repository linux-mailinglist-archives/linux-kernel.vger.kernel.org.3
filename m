Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E394BB9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiBRNL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:11:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiBRNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:11:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA38E7B;
        Fri, 18 Feb 2022 05:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 785DA615FE;
        Fri, 18 Feb 2022 13:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D3AC340E9;
        Fri, 18 Feb 2022 13:11:35 +0000 (UTC)
Message-ID: <1425d3a5-95e4-29c8-4dcf-8d9c7f8fa288@xs4all.nl>
Date:   Fri, 18 Feb 2022 14:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 04/16] media: Remove usage of the deprecated
 "pci-dma-compat.h" API
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        awalls@md.metrocast.net,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a0w51bnDy2whAC8WOCx2=9UB1ViX3veOfhSmQwwLr3VNQ@mail.gmail.com>
 <20220107081003.63c7cea6@coco.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220107081003.63c7cea6@coco.lan>
Content-Type: text/plain; charset=UTF-8
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

On 07/01/2022 08:10, Mauro Carvalho Chehab wrote:
> Em Thu, 6 Jan 2022 19:51:47 -0500
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
>> On Thu, Jan 6, 2022 at 4:50 PM Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>>
>>> In [1], Christoph Hellwig has proposed to remove the wrappers in
>>> include/linux/pci-dma-compat.h.
>>>
>>> Some reasons why this API should be removed have been given by Julia
>>> Lawall in [2].
>>>
>>> A coccinelle script has been used to perform the needed transformation.
>>> It can be found in [3].
>>>
>>> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
>>> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>>> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>  
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Mauro, could you pick this up directly? It has no dependencies on the rest of
>> the series.
> 
> Sure, but I already closed the media merge window. If you prefer to
> apply it directly via your tree, that would be OK for me as well.
> If so, just let me know. On such case:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

I picked it up for inclusion in the media subsystem for 5.18.

Regards,

	Hans

> 
> Regards,
> Mauro

