Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33265929B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiHOGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHOGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EF91A809;
        Sun, 14 Aug 2022 23:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9425460BB5;
        Mon, 15 Aug 2022 06:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4522C433C1;
        Mon, 15 Aug 2022 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660545544;
        bh=TFOJp1vE4EfknXi9wQ53SFhmTzbfYhd7U1TppN+usAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vylp12J5lXNlOem4vQ5ENxBNVs9eH/lVPZei2fie2iwd8f27UnBAKsTdO9tDFscgy
         j/b4rp9SXZZgBSM2hZETAuzVMyzJJvG3nQwFUkw8oN0TVnNqsfk5z57BCowwzSmXM2
         DMwwMU0DNdQapu/5f8adDfeAHAmU93KLtqmlV+2U=
Date:   Mon, 15 Aug 2022 08:38:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YvnqA7aGmtvp1kqV@kroah.com>
References: <20220815041145.35629-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041145.35629-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:11:45PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_nvm_validate() contain an array that has functions
> pointers to asmedia_nvm_validate().
> And asmedia_nvm_validate() that recognize supported vendor works in one
> of the following cases:
> Case nvm_upgrade: enable nvm's attribute by setting no_nvm_upgrade
> flag to create nvm_authenticate file node.
> Case nvm_add:add active/non-active NVM devices.
> Case nvm_write:update firmware to non-ative NVM device.
> 
> Our patches were through checkpatch.pl. But the file(switch.c.)
> have existed 13 warning before we patch it.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/thunderbolt/nvm.c    | 147 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  17 ++++
>  drivers/thunderbolt/tb.h     |  18 +++++
>  3 files changed, 182 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
