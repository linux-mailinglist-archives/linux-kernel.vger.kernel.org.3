Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352D458A3BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiHDXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiHDW75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:59:57 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E1239;
        Thu,  4 Aug 2022 15:59:04 -0700 (PDT)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 80A62C0002;
        Thu,  4 Aug 2022 22:58:59 +0000 (UTC)
Message-ID: <52c54503-9533-eb2e-164e-5c76a8b43798@zago.net>
Date:   Thu, 4 Aug 2022 17:58:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] [media] gspca: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, mchehab@kernel.org
Cc:     hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220804115431.51327-1-wangborong@cdjrlc.com>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <20220804115431.51327-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 06:54, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/usb/gspca/finepix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/gspca/finepix.c b/drivers/media/usb/gspca/finepix.c
> index 66c8e5122a0a..bc6133b525e3 100644
> --- a/drivers/media/usb/gspca/finepix.c
> +++ b/drivers/media/usb/gspca/finepix.c
> @@ -129,7 +129,7 @@ static void dostream(struct work_struct *work)
>  				 * for, then it's the end of the
>  				 * frame. Sometimes the jpeg is not complete,
>  				 * but there's nothing we can do. We also end
> -				 * here if the the jpeg ends right at the end
> +				 * here if the jpeg ends right at the end
>  				 * of the frame. */
>  				gspca_frame_add(gspca_dev, LAST_PACKET,
>  						data, len);

Thanks.

Acked-by: frank zago <frank@zago.net>
