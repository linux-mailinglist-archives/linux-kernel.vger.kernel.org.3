Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBE5AC575
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiIDQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiIDQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F22C67F;
        Sun,  4 Sep 2022 09:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C2B60FC8;
        Sun,  4 Sep 2022 16:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BEDC433D6;
        Sun,  4 Sep 2022 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662309511;
        bh=g+NH6rGjbnMe9XXzMDqvPT9umN9QNDguOnO8tOi15l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=beNBzP3syX+CETDwVXZB9q6vNyw3kUZY2wQWE0zRt+FLpZNGSrHO1a8gbyCJCsWW0
         jPOZ/Rc6ffbdKaEQkQvlowFjS0dnOU0N9Ic2NtJGWhTT8v+ScD50KmWpES/D+dHID6
         Ls0Wwa71donWwJEfMaIvXo1icKGJI9/br5oX+Fr8W5sJ50+ztZSu0kq6nJj9TylS1B
         /mSHAVGOKcY82CX87QkC+VF2Z48dvZ08E7Fk9rn1OzIUsV9JcDLLy8SxIUsZJFamdd
         Sb+61QuiUnKk3xde7V8cWqUUShwvC5Q/9MdPxhXR33w7xJuV+S9hPbXdr8BVYUdJQx
         PsNJG2RxmRquw==
Date:   Sun, 4 Sep 2022 17:04:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linmq006@gmail.com, DDRokosov@sberdevices.ru,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] iio:accel:kxcjk-1013: Fix comments typo
Message-ID: <20220904170423.0379d219@jic23-huawei>
In-Reply-To: <20220830151555.27140-1-dengshaomin@cdjrlc.com>
References: <20220830151555.27140-1-dengshaomin@cdjrlc.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 11:15:55 -0400
Shaomin Deng <dengshaomin@cdjrlc.com> wrote:

> Fix double word in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
Already fixed in the iio tree.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 94f7b6ac5c87..adc66b3615c0 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1064,7 +1064,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
>  
>  	/*
>  	 * We will expect the enable and disable to do operation in
> -	 * in reverse order. This will happen here anyway as our
> +	 * reverse order. This will happen here anyway as our
>  	 * resume operation uses sync mode runtime pm calls, the
>  	 * suspend operation will be delayed by autosuspend delay
>  	 * So the disable operation will still happen in reverse of

