Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80254516E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbiFIP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiFIP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:58:41 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072471D4DC2;
        Thu,  9 Jun 2022 08:58:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A8ED8732;
        Thu,  9 Jun 2022 15:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A8ED8732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654790320; bh=UYYa6e09TrnQINuS2KrwL4+6IJnM22V/hh9mWBFbN0w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Za4Ad5eNtuySOd2Sg6mCfyY9k2QfYGFAtJBnEPh3VNi9xFpv3jG53BAgjeXagnp2/
         QrOUwVvmjHWtw9n2yquHV4roeiCzIggA83W/fBOh3XoDdsXkfetBtFs8i5VEoSyT/8
         AD2zSO/FibJFTcaqnyCrHRD2QPxgyMU1aW+m43OtTT/EjDi2pg7onDG0/dOoVuu/DM
         BH+C7IpY0HKTLi2WWGpDqpEL0W9LuT0Cxye206/3jAeXPyyQXIrPNFpsezeEN/39ed
         WR0CFjjlWvwx2OjM6tPmG7SmP0TTQjSqAWUuzz8o4ZcM01AHFMMYVlZ9m2HidAahmd
         E8oDSI5fAmUKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: usb: fix literal block marker in usbmon
 verification example
In-Reply-To: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
References: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
Date:   Thu, 09 Jun 2022 09:58:40 -0600
Message-ID: <87k09p4ymn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Swartz <justin.swartz@risingedge.co.za> writes:

> The "Verify that bus sockets are present" example was not properly
> formatted due to a typo in the literal block marker.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  Documentation/usb/usbmon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/usb/usbmon.rst b/Documentation/usb/usbmon.rst
> index b0bd51080..6d5ec1e62 100644
> --- a/Documentation/usb/usbmon.rst
> +++ b/Documentation/usb/usbmon.rst
> @@ -42,7 +42,7 @@ if usbmon is built into the kernel::
>  	# modprobe usbmon
>  	#
>  
> -Verify that bus sockets are present:
> +Verify that bus sockets are present::
>  

Applied, thanks.

jon
