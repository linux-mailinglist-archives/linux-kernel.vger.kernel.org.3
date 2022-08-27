Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE75A3714
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbiH0Kkx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 Aug 2022 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0Kku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:40:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A856E8B1;
        Sat, 27 Aug 2022 03:40:49 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 13F56C0006;
        Sat, 27 Aug 2022 10:40:46 +0000 (UTC)
Message-ID: <3e48ef8d13337ce1c3ec68baffc612fde4740b0e.camel@hadess.net>
Subject: Re: [PATCH v5 2/4] Input: joystick: xpad: Add ABS_PROFILE axis
 value to uapi
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com
Date:   Sat, 27 Aug 2022 12:40:46 +0200
In-Reply-To: <20220825222420.6833-3-nate@yocom.org>
References: <20220825222420.6833-1-nate@yocom.org>
         <20220825222420.6833-3-nate@yocom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-25 at 15:24 -0700, Nate Yocom wrote:
> Add an ABS_PROFILE axis for input devices which need it, e.g. X-Box
> Adaptive Controller and X-Box Elite 2.
> ---
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h
> b/include/uapi/linux/input-event-codes.h
> index dff8e7f17074..7ad931a32970 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -862,6 +862,7 @@
>  #define ABS_TOOL_WIDTH         0x1c
>  
>  #define ABS_VOLUME             0x20
> +#define ABS_PROFILE            0x21
>  
>  #define ABS_MISC               0x28
>  


You probably also want to add it to the absolutes array in
drivers/hid/hid-debug.c.

Again, you might want to wait for confirmation from Dmitry that this is
the right way to do this for the profiles.
