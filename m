Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB059FD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiHXO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiHXO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0885A8D;
        Wed, 24 Aug 2022 07:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09AC617FB;
        Wed, 24 Aug 2022 14:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8CFC433C1;
        Wed, 24 Aug 2022 14:56:10 +0000 (UTC)
Message-ID: <de68f0cc-2151-4481-2778-da98ffd4aeb0@xs4all.nl>
Date:   Wed, 24 Aug 2022 16:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] pci/cx18: Use 'unsigned int' instead of just 'unsigned'.
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, awalls@md.metrocast.net,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824133149.65002-1-yuanjilin@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220824133149.65002-1-yuanjilin@cdjrlc.com>
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

There are loads of old drivers that do this, it's not worth the effort
to change this.

Sorry.

I'll reject such patches.

Regards,

	Hans

On 24/08/2022 15:31, Jilin Yuan wrote:
> Prefer 'unsigned int' to bare use of 'unsigned'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/media/pci/cx18/cx18-firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/cx18/cx18-firmware.c b/drivers/media/pci/cx18/cx18-firmware.c
> index 1b038b2802bf..b72bcbc1fed6 100644
> --- a/drivers/media/pci/cx18/cx18-firmware.c
> +++ b/drivers/media/pci/cx18/cx18-firmware.c
> @@ -88,7 +88,7 @@ static int load_cpu_fw_direct(const char *fn, u8 __iomem *mem, struct cx18 *cx)
>  {
>  	const struct firmware *fw = NULL;
>  	int i, j;
> -	unsigned size;
> +	unsigned int size;
>  	u32 __iomem *dst = (u32 __iomem *)mem;
>  	const u32 *src;
>  
> @@ -128,7 +128,7 @@ static int load_apu_fw_direct(const char *fn, u8 __iomem *dst, struct cx18 *cx,
>  {
>  	const struct firmware *fw = NULL;
>  	int i, j;
> -	unsigned size;
> +	unsigned int size;
>  	const u32 *src;
>  	struct cx18_apu_rom_seghdr seghdr;
>  	const u8 *vers;
