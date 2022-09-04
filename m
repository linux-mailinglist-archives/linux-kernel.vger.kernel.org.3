Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E017E5AC61A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIDT1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:27:49 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903B2E6B0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:27:48 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5C869200F03;
        Sun,  4 Sep 2022 19:27:46 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 5EEBCA0074; Sun,  4 Sep 2022 20:57:06 +0200 (CEST)
Date:   Sun, 4 Sep 2022 20:57:06 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Fix double word in comments
Message-ID: <YxT1As38WRZcyH0/@shine.dominikbrodowski.net>
References: <20220904155749.29026-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904155749.29026-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Sep 04, 2022 at 11:57:49AM -0400 schrieb Shaomin Deng:
> Delete the repeated word "really" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/pcmcia/ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index ace133b9f7d4..05d18614f6b4 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -1304,7 +1304,7 @@ static int pcmcia_bus_early_resume(struct pcmcia_socket *skt)
>   * physically present, even if the call to this function returns
>   * non-NULL. Furthermore, the device driver most likely is unbound
>   * almost immediately, so the timeframe where pcmcia_dev_present
> - * returns NULL is probably really really small.
> + * returns NULL is probably really small.
>   */
>  struct pcmcia_device *pcmcia_dev_present(struct pcmcia_device *_p_dev)
>  {

Sorry, but no, as I recently explained to someone else:

	https://lore.kernel.org/all/20220831083623.GA25639@isilmar-4.linta.de/

Thanks,
	Dominik
