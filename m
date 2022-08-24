Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522D959F60D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiHXJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiHXJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583917647F;
        Wed, 24 Aug 2022 02:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A6B617BE;
        Wed, 24 Aug 2022 09:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD67C433D7;
        Wed, 24 Aug 2022 09:16:40 +0000 (UTC)
Message-ID: <ebb3133b-8252-89a2-306f-7d37591d7c83@xs4all.nl>
Date:   Wed, 24 Aug 2022 11:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: platform: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, mchehab@kernel.org
Cc:     prabhakar.csengg@gmail.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220716043247.41183-1-wangborong@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220716043247.41183-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a duplicate of:

https://patchwork.linuxtv.org/project/linux-media/patch/20220722063341.69913-1-slark_xiao@163.com/

Also note that the subject line is too vague: it suggests that it is a
drivers/media/platform-wide change, instead it is just for the davinci driver.

That should have been part of the subject line.

Anyway, I'll drop this patch in favor of the other one.

Regards,

	Hans

On 16/07/2022 06:32, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/platform/ti/davinci/vpbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
> index 5f0aeb744e81..509ecc84624e 100644
> --- a/drivers/media/platform/ti/davinci/vpbe.c
> +++ b/drivers/media/platform/ti/davinci/vpbe.c
> @@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
>   * vpbe_get_output - Get output
>   * @vpbe_dev: vpbe device ptr
>   *
> - * return current vpbe output to the the index
> + * return current vpbe output to the index
>   */
>  static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
>  {
