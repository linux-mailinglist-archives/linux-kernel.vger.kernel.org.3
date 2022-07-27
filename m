Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603C58224C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiG0Ikm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0Ikk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C3459BB;
        Wed, 27 Jul 2022 01:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D601561703;
        Wed, 27 Jul 2022 08:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A9C433D6;
        Wed, 27 Jul 2022 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658911239;
        bh=oyw8/wG+87s3/gqEcOnanDmQcIR3EM6OYA1kX1WL54w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9/nV02URDuUYQyW6JLWFSJr6WqkUqvgfzCtT5cr/QR3MqecFw5IcwHjxHROUiBUn
         gEhaFp8lPcPNqgSHfQnSATYNFvwMhwUb+CTl0PA0jdLYPbBjpWfBc9VULMVUfRFB7I
         as+Zw6ek3tORbxGUALLehk+IhY0G7dwsXToD4lbci6HzEk3YDxLqHF2RRRQtVRLvaF
         taQiqtewxhOJ2fU/x/SC3tCZrSc6WMoej4DJLrOFSeM9buyqGsd/LNOEcMsyXP2Gd/
         JJfg1ljt10ZFI8P1QZiI1aHqTd+E494TAf5oYfU2ll7AH9/GIJz9/I3ZTxmtiG2kQl
         IGpLmWnJpWxbg==
Date:   Wed, 27 Jul 2022 16:40:33 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/chipidea: fix repeated words in comments
Message-ID: <20220727084033.GB269370@nchen-desktop>
References: <20220716131630.33151-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716131630.33151-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-16 21:16:30, Jilin Yuan wrote:
>  Delete the redundant word 'power'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/usb/chipidea/otg_fsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index 6ed4b00dba96..61b157b9c662 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -459,7 +459,7 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
>  
>  	if (on) {
> -		/* Enable power power */
> +		/* Enable power */
>  		hw_write(ci, OP_PORTSC, PORTSC_W1C_BITS | PORTSC_PP,
>  							PORTSC_PP);
>  		if (ci->platdata->reg_vbus) {
> -- 

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen
