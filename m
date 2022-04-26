Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B350FA07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348772AbiDZKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348461AbiDZKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:18:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2BD081D;
        Tue, 26 Apr 2022 02:41:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B2D5D5C0191;
        Tue, 26 Apr 2022 05:41:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Apr 2022 05:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1650966105; x=1651052505; bh=F/HwSZkMjQ
        U215/jSuMrCHNew60q6qc4D+yvCngtnX4=; b=a8yLmBPF/MUSVS6zdhZ2NgcLZw
        mFkHYcRrRMaTXa6SQEPdsR9Jyf42Oq87ggTQZziTw8728uuKnoGgiFTI33KyScBo
        ZAfXmnq/wTwpQaR65uZy62PnfxNdiJFJ+qdXHlIMR0hVztaWeIk54ALg1j5k5qr3
        Tq/Dldvguw+zFwBs8okWmmU36LCQN4z2DGvC5n3vJ7FC//vN3uRFEJYvlO4YQpYn
        znjKAIVfZtFQ9WnS+8y9bfPG4L4/DtAa9FCVdgjyPcAaxntiV98hgmtQaYJAT+ap
        VvreX6ebtwJo2RnuRgGiRmvj/lkCtBMtuI+I/W/KKSM8X6TIL9Jxwew9Cg0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650966105; x=
        1651052505; bh=F/HwSZkMjQU215/jSuMrCHNew60q6qc4D+yvCngtnX4=; b=d
        KoA4xIxr72/yBpNaczNYpSVLGKgvyA2/pC1wQCRRkAYiRiSmAvtNUEKp/3mgjQNY
        udAry4rXEnB9fgTS/WL3foI2tcQS1o7gcWUhNZwnSkEW2axjsCkEQa41Hgb+iysa
        +c6DFZRzTfK1PvqNESAT8kZxPYS0PBrs+eOBihyYnSeFSSUJYwYiQ8TNHEQx/CxV
        kSYdTlqkcFzjn5N6DXp9RkCTaf3mF3HLzZT8P1JahxmhFyHJKXkw2+MnEFLAT4Wf
        LPIq1WjRnS55Eiy3g0ABqXcTirp+d7uIdH0wTeuS766jVPPAlA14RhBAkQvZOlET
        Az3I3Psn5Xq8vh27bg96Q==
X-ME-Sender: <xms:Wb5nYo9lyYnV0Vnjg-lGjyS6eFbim0nuF4kx3QmDz3T0QvCLBIcqFg>
    <xme:Wb5nYgvUyIWTuE37AfBPxCfVqmi-JZDw_g4FD7GaV8rBkRAS14EcuIGWvd89g-j-9
    hbYGKjHtXLkLA>
X-ME-Received: <xmr:Wb5nYuCCiGCp0StPOo4CaVt4KeURyZJgzctC3L4FpJkLYoXjWwQWSF7OQIpDZcAnBOSr7k0xkWbaTe9rO_2s55N0wPT1G5gS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Wb5nYodlGOslnH9Z1pGDHYCSeHgryg4rzVt4XjKqIUWQYvt6Q0VqcQ>
    <xmx:Wb5nYtNIUutEUKUgpFtnboSAybyz6ox9uwfYsSElJYfi5dNN838TeQ>
    <xmx:Wb5nYikw4bxunidK8Km5cmS586JAt5mg4H3Du7NlD0sz6CRKjJwbrw>
    <xmx:Wb5nYmjj3RjzNJ72vvEN26junxQtcN3XOMvqUbFqwMHQzPDy1zGYvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 05:41:44 -0400 (EDT)
Date:   Tue, 26 Apr 2022 11:41:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <Yme+VvNEk3xPcJmU@kroah.com>
References: <20220426150842.473be40e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150842.473be40e@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:08:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/drd.c
> 
> between commit:
> 
>   ab7aa2866d29 ("usb: dwc3: Try usb-role-switch first in dwc3_drd_init")
> 
> from the usb.current tree and commit:
> 
>   0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/usb/dwc3/drd.c
> index 8cad9e7d3368,f277bebdaa09..000000000000
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@@ -585,14 -539,11 +539,10 @@@ int dwc3_drd_init(struct dwc3 *dwc
>   	int ret, irq;
>   
>   	if (ROLE_SWITCH &&
>  -	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
>  -		ret = dwc3_setup_role_switch(dwc);
>  -		if (ret < 0)
>  -			return ret;
>  -	} else if (dwc->edev) {
>  +	    device_property_read_bool(dwc->dev, "usb-role-switch"))
>  +		return dwc3_setup_role_switch(dwc);
>  +
> - 	dwc->edev = dwc3_get_extcon(dwc);
> - 	if (IS_ERR(dwc->edev))
> - 		return PTR_ERR(dwc->edev);
> - 
>  +	if (dwc->edev) {
>   		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>   		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>   					       &dwc->edev_nb);



Thanks for the report, I'll handle this when I merge them together after
Linus taks the usb-linus branch.

greg k-h
