Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D556BA10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiGHMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiGHMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA0018375;
        Fri,  8 Jul 2022 05:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658B862731;
        Fri,  8 Jul 2022 12:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F5C341C0;
        Fri,  8 Jul 2022 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657284565;
        bh=y3uOgzP8/1oD6loS+5aG+kabJ0xwbf5tnpouDRqeJ9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLUvr3duWQ4+6vdOFSNT8z543LC7P0xRKqI6yHYtY1i4p0Cm7fnHAnkZCXDtQzZCa
         ZPtyVWI9UnS1wQvzy3/8YIrd6h1PZ2pWlzVLc8uZ0Y+hv+cX9PtImuAgsPThL4DdJ1
         Ntltfdvff7g+ac/EA6DlVwQ+OOI3vu9U6oC3Gvk4=
Date:   Fri, 8 Jul 2022 14:49:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: dwc3: Describe function parameter 'mult'
Message-ID: <Ysgn0hxHkt3pvzAB@kroah.com>
References: <20220703192448.13763-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703192448.13763-1-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 01:24:48AM +0600, Khalid Masum wrote:
> Currently the parameter is not described. Which triggers warning when using
> make htmldocs. Fix it by describing the parameter.
> 
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
>  drivers/usb/dwc3/gadget.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 8716bece1072..e8c86b08cd83 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -657,6 +657,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
>  /**
>   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
>   * @dwc: pointer to the DWC3 context
> + * @mult: multiplier, 'mult' value for SS Isoc EPs
>   *
>   * Calculates the size value based on the equation below:
>   *
> -- 
> 2.36.1
> 

Does not apply to my usb-next branch :(
