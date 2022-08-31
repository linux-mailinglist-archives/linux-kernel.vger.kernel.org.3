Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250B5A794C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiHaIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiHaIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:45:56 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 01:45:54 PDT
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE91A59BC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:45:54 -0700 (PDT)
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 7B6122013F1; Wed, 31 Aug 2022 08:36:23 +0000 (UTC)
Date:   Wed, 31 Aug 2022 10:36:23 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: fix repeated words in comments
Message-ID: <20220831083623.GA25639@isilmar-4.linta.de>
References: <20220830151648.10335-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830151648.10335-1-yuanjilin@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:16:48PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'really'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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

Thanks for your patch. However, the duplication here is on purpose

	https://en.wikipedia.org/wiki/Epizeuxis

Thanks,
	Dominik
