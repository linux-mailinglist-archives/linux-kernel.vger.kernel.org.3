Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C0591F53
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiHNJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:45:18 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97379B19
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 02:45:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id A524B2B05FDE;
        Sun, 14 Aug 2022 05:45:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 14 Aug 2022 05:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660470310; x=1660477510; bh=FdFP/H49+r
        ZQsPEMoSpH1blp96NX4j7NVyCsnlQOwKc=; b=qAarWNTRnx4c01YwaTDmDon3cT
        WoeRczFOoEi+9Yn59fFevm4BDrerzL8Qlujy0xfLMkyaoQfIjNfen2HFSFBZFB0Q
        XNoGICGJC2sUobGRe86muQFZE/cYsqOO0j6IYwB2CS835Qsq6BPjKB+oDCW1JO6C
        pvpC0Mrw3QJMLQBeUlYwEfqvZK9YB3kuH9EMynjrZLBo/InM0t4Q81pjJHfQ/p5C
        0GtZsBGQ50dS2bXKJjx8WZiCTf9hqEWVJ5wm05nZnJc0C5bBQAUdT1VxX2j9oC6q
        rMDXsGcuxb3sCu+JA4QRd5t25AOxNytA3uK+r1ikFU+3ya5x2lNxSQ3uOUHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660470310; x=1660477510; bh=FdFP/H49+rZQsPEMoSpH1blp96NX
        4j7NVyCsnlQOwKc=; b=WEq9wKKYIAAfYldO75VsevXwtHARcaxZHLAmNnNZOXvl
        wHUSsxEtGpaNN3dcgybyp8V9bC3iR+WQnHsnaCSZtbGUn7WqOOE+y88ew9CrEtx5
        KccnnLpEFgx2sZNnrD+2QgNax+OUTUxes3cue/UpBUigm0LVysdKx6b2edhOsgZT
        mtz4CGcucgfqJpkzKvq1kD0ja/cYYzlwZt12b6/okBLPFIy7Zoi8WEKLybxgSkEn
        qIF4eT4qV55GGWIEmLBKV3yahBmceZa5NbIFCtOF0zUHfm5JHWY+3COP2i5veLeX
        /JfYijRGOvc4xZPuEv0vc7RWsguBIkKbVSYcmDGkGA==
X-ME-Sender: <xms:JcT4YkO7Ly_4uqAXJmmRm0-QB8iX31G2BqbeQjSuNhwGRG7tSzNZTw>
    <xme:JcT4Yq8JS_2dJZE1m116k-XLejcBKE8CXlzlbLLVZbPd_kPksKcQqN9PjZ4R4de9I
    JgZiTHVVbXg7w>
X-ME-Received: <xmr:JcT4YrSxWurW3qk0bXoJ6qJhvidpvl77Ew5BY3W3fUuP4WgcOp0HUBSzgKCOyGLpztk9TwoIAtvdkYDS2XLufxfhCqR6R8Xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:JcT4YsvNGHOewyt4liefkpERA5-M7Vq3i8D1AjJpE7vjFGZ3CcbNKw>
    <xmx:JcT4YsfF20dlijfbWGKDEFXK07WPoktI5RKo7qnDlHFX-qpPjZjqWQ>
    <xmx:JcT4Yg2cnnLquv9NJZJLdzEdV03CcEz03nJMpGhaVZuubGmvSlm6-g>
    <xmx:JsT4YrrN8xxMcyzbPO3A2899hU6_IbdITtL48JdhfnZS1NRAblIm1CKmmu4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 05:45:09 -0400 (EDT)
Date:   Sun, 14 Aug 2022 11:45:06 +0200
From:   Greg KH <greg@kroah.com>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Message-ID: <YvjEIjXg7KxtTT/0@kroah.com>
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814080416.7531-1-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 02:04:15PM +0600, Khalid Masum wrote:
> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
> populated with properties from FW node props. Make this happen by 
> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use 
> the flag to store the multi_link value from intel_link_startup. Use 
> this flag to initialize bus->multi_link.
> 
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> I do not think adding a new flag for fwnode_handle is a good idea.
> So, what would be the best way to initialize bus->multilink with 
> fwnode props?
> 
>   -- Khalid Masum
> 
>  drivers/soundwire/bus.c   | 4 ++--
>  drivers/soundwire/intel.c | 1 +
>  include/linux/fwnode.h    | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index a2bfb0434a67..80df1672c60b 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -74,9 +74,9 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  
>  	/*
>  	 * Initialize multi_link flag
> -	 * TODO: populate this flag by reading property from FW node
>  	 */
> -	bus->multi_link = false;
> +	bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
> +		== FWNODE_FLAG_MULTI_LINKED;
>  	if (bus->ops->read_prop) {
>  		ret = bus->ops->read_prop(bus);
>  		if (ret < 0) {
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 505c5ef061e3..034d1c523ddf 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1347,6 +1347,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>  		 */
>  		bus->multi_link = true;
>  		bus->hw_sync_min_links = 1;
> +		dev->fwnode->flags |= FWNODE_FLAG_MULTI_LINKED;
>  	}
>  
>  	/* Initialize shim, controller */
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9a81c4410b9f..446a52744953 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -32,6 +32,7 @@ struct device;
>  #define FWNODE_FLAG_NOT_DEVICE			BIT(1)
>  #define FWNODE_FLAG_INITIALIZED			BIT(2)
>  #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
> +#define FWNODE_FLAG_MULTI_LINKED		BIT(4)

What does this commit actually change?

Did you test this on real hardware?

thanks,

greg k-h
