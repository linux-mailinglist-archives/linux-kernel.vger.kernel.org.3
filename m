Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E954CD26C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiCDKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiCDKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:31:44 -0500
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 02:30:57 PST
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780116BCE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:30:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 889845C0368;
        Fri,  4 Mar 2022 05:25:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 04 Mar 2022 05:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=XPo646Lh4bAU5kxG3smqO0CDWOi5eh
        E4dmIoAiLUrjE=; b=aM+zvgewHBBuWFY0jI9+VlTD5h0RwmPbUhfGfTQ875169S
        O/BYkm+f5Gmh0+1nJAEguccAKlCOeHgN+WyDmBLOXvw6W0fHeCdeGvjfv8kEw2y6
        WMPRu10tUbVb6DPVS2rePVjVKL26hcWdAxv4xnwqdLpLxgmnZWHooGamvB5/oYhm
        f3L0eFRmy8TxWhmJBgiM5vgvMzWQz1Pbo13diU2XcTFCy8jxlD0srDc4979q8ts+
        oTHBXZHxG55avJ8xpFbQKLqbikhWzJzqNIBkG0y4OWt3GQ+wWID+agVcVNfddmp7
        ND3ShSGYHMQ0cF82D0MIYBQCyc5ZcIyxWPz2FVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XPo646Lh4bAU5kxG3
        smqO0CDWOi5ehE4dmIoAiLUrjE=; b=dvG6jG9BHHGf8pbvATEXsXL0EgPg+I63O
        fpUgKLr5PR93kcEbr5Vh19kj32UK071+iOADjRiN3qO1m3y1p+jv0ePdFsj9vd12
        HEBboxKVy4aKLV0yjAbrrqe9cP6ertJ3Qw1+pvAypax8Dmv6dwXMOs9P6iQ2FGDr
        6vgfZdrhpYj/XKj5KZFkA3fvEJDqRSqoviy24GGhnV4d3RRGC+mz+XGPN2m/4mia
        z/t927NflYaQOI/+1CH+30FT6CPa6A8Tn/Kavb068rnNjGoLhwTBu6cw3GZkxfaE
        fz0M23begueXYjGXu+JkNDhgk0QwQJuPsc2O5vXHJ4HzFzUykVppg==
X-ME-Sender: <xms:F-khYnSlAk2AHNGxI9qwfvBx0FqUfmrIqDiIZreYzRjTSA712LSKsA>
    <xme:F-khYozGrJHorvQGcfJ-N5ESqUeC5053XmB-SLmJSjlKZGvIV_DUocETDrp6Etxwy
    dSuejlA-QK8QbHHUn4>
X-ME-Received: <xmr:F-khYs2pYqmROiZMCSYedglBy8zCIFk61APgKUBZZELyKhpcQBhvUKEHOM8G_flyF-4BU7J2rj37G20maM8MWSq0WKNGZ0ARIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:F-khYnDmb1dBzGmfx37UD6KyOM8WxKekyzd_AOsRJiiBQz8zdEvclQ>
    <xmx:F-khYgiCMY90qq-IAGPBpie3nvR7dFPscSq6yTZktqXfT6yWnMMOUA>
    <xmx:F-khYropLsOvZC9uDB2sUUK-TszRxBoq51syJW4RGBHT3O9JuWw5Tw>
    <xmx:F-khYsZPE79YVHAJEB3snnjBLdzKxw7N0z6QAMcF0jmEZX-4ryKrkA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 05:25:26 -0500 (EST)
Date:   Fri, 4 Mar 2022 19:25:23 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: extend card->lock in
 fw_core_handle_bus_reset
Message-ID: <YiHpEx/1LaGuzEMC@workstation>
Mail-Followup-To: Niels Dossche <dossche.niels@gmail.com>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220303183038.54126-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303183038.54126-1-dossche.niels@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 03, 2022 at 07:30:38PM +0100, Niels Dossche wrote:
> card->local_node and card->bm_retries are both always accessed under
> card->lock.
> fw_core_handle_bus_reset has a check whose condition depends on
> card->local_node and whose body writes to card->bm_retries.
> Both of these accesses are not under card->lock. Move the lock acquiring
> of card->lock to before this check such that these accesses do happen
> when card->lock is held.
> fw_destroy_nodes is called inside the check.
> Since fw_destroy_nodes already acquires card->lock inside its function
> body, move this out to the callsites of fw_destroy_nodes.
> Also add a comment to indicate which locking is necessary when calling
> fw_destroy_nodes.
> 
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  drivers/firewire/core-card.c     | 3 +++
>  drivers/firewire/core-topology.c | 9 +++------
>  2 files changed, 6 insertions(+), 6 deletions(-)
 
It looks good to me and is preferable as Niels said.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


I think the patch is for minor code refactoring rather than bug fix
since it is unlikely that the rate condition occurs. The bus_reset_work
is synchronously canceled in the beginning of pci_remove().

```
pci_remove()
->cancel_work_sync(&ohci->bus_reset_work);
->fw_core_remove_card(&ohci->card);
->software_reset(ohci);
->free_irq(dev->irq, ohci);
```

But I have no confidence that the above calls are done in the order by
processor...

> diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
> index 54be88167c60..f3b3953cac83 100644
> --- a/drivers/firewire/core-card.c
> +++ b/drivers/firewire/core-card.c
> @@ -668,6 +668,7 @@ EXPORT_SYMBOL_GPL(fw_card_release);
>  void fw_core_remove_card(struct fw_card *card)
>  {
>  	struct fw_card_driver dummy_driver = dummy_driver_template;
> +	unsigned long flags;
>  
>  	card->driver->update_phy_reg(card, 4,
>  				     PHY_LINK_ACTIVE | PHY_CONTENDER, 0);
> @@ -682,7 +683,9 @@ void fw_core_remove_card(struct fw_card *card)
>  	dummy_driver.stop_iso		= card->driver->stop_iso;
>  	card->driver = &dummy_driver;
>  
> +	spin_lock_irqsave(&card->lock, flags);
>  	fw_destroy_nodes(card);
> +	spin_unlock_irqrestore(&card->lock, flags);
>  
>  	/* Wait for all users, especially device workqueue jobs, to finish. */
>  	fw_card_put(card);
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index b63d55f5ebd3..f40c81534381 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -375,16 +375,13 @@ static void report_found_node(struct fw_card *card,
>  	card->bm_retries = 0;
>  }
>  
> +/* Must be called with card->lock held */
>  void fw_destroy_nodes(struct fw_card *card)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&card->lock, flags);
>  	card->color++;
>  	if (card->local_node != NULL)
>  		for_each_fw_node(card, card->local_node, report_lost_node);
>  	card->local_node = NULL;
> -	spin_unlock_irqrestore(&card->lock, flags);
>  }
>  
>  static void move_tree(struct fw_node *node0, struct fw_node *node1, int port)
> @@ -510,6 +507,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
>  	struct fw_node *local_node;
>  	unsigned long flags;
>  
> +	spin_lock_irqsave(&card->lock, flags);
> +
>  	/*
>  	 * If the selfID buffer is not the immediate successor of the
>  	 * previously processed one, we cannot reliably compare the
> @@ -521,8 +520,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
>  		card->bm_retries = 0;
>  	}
>  
> -	spin_lock_irqsave(&card->lock, flags);
> -
>  	card->broadcast_channel_allocated = card->broadcast_channel_auto_allocated;
>  	card->node_id = node_id;
>  	/*
> -- 
> 2.35.1


Regards

Takashi Sakamoto
