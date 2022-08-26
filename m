Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3110D5A27EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiHZMqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiHZMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:46:20 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C000C0B6A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:46:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 64B9A1B7B355
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661517976;
        bh=PCNCr4gLjAzuooND/bjvQI4nTIspFNLeY0C0jqAHZCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Byq7lhYNewtqG2I/Otk8UwNflh0QG0RPCSBNLX4N7Cht8DVLyBXqLaEM1ZAhw6Wjl
         xoGdx+yqJpb2tmtR4utwof9sn9uzUwv/ImgcAW0jkpXS+2cJbAiy6FScXrHI4mLjYq
         7cr2+dXL3y9EZWOqDQ9UcdRMvWqcMIFKbBgFl0uM=
Received: from fx408 (localhost [127.0.0.1]) by fx408.security-mail.net
 (Postfix) with ESMTP id 09D451B7B343; Fri, 26 Aug 2022 14:46:16 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 5C59B1B7B33F; Fri, 26 Aug
 2022 14:46:14 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3FDAC27E02FA; Fri, 26 Aug 2022
 14:46:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 2888427E0392; Fri, 26 Aug 2022 14:46:14 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 IugXXSCcSbbN; Fri, 26 Aug 2022 14:46:14 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1782627E02FA; Fri, 26 Aug 2022
 14:46:14 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <124ec.6308c096.5b61f.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 2888427E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661517974;
 bh=UYA33OxQNeupL628vgL2cqS03Bi2JR/rksKhM9GIj+4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=GL309KhJBsMGe5q62qOR9wXax82QRj2ep2rBAHM9rmFRXO2xvBc2fMIpfxWyR6hpV
 cK4vRmwahv+hH6HFftmfCuXXVaY24zJE7w9LLJCbwh5w90HtOeOUvOiiA3Q9zgRYeT
 iH2w/e4mvzPTNvc+PPWe0bWpnEBhCgaqLcbT2zYU=
Date:   Fri, 26 Aug 2022 14:46:13 +0200
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: Fix repeated word in comments
Message-ID: <20220826124612.GC10294@tellis.lin.mbt.kalray.eu>
References: <20220826100052.22945-22-jmaselbas@kalray.eu>
 <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Fri, Aug 26, 2022 at 12:24:47PM +0200, Jacopo Mondi wrote:
> Hi Jules
> 
>   thanks, but as reported in patchwork and lore
> https://patchwork.linuxtv.org/project/linux-media/list/?series=&submitter=&state=*&q=mt9v111&archive=both&delegate=
> https://lore.kernel.org/all/20220824135433.h2udwtnub7mlmtam@uno.localdomain/
> 
> This is the 4th patch to fix the same repeated word in a comment.
 
> As I asked to Jilin, are you submitting this as part of a new
> contributor program ?
No, I've search for more repeated word after I've found one (in dma-buf heaps).
I then saw that there were already some fixed by Jilin Yuan (and
probably others).

I was expecting that some patches were sent for this, sorry for the noise. 

Cheers
 
> Thanks
>    j
> 
> On Fri, Aug 26, 2022 at 12:00:50PM +0200, Jules Maselbas wrote:
> > Remove redundant word `the`.
> >
> > CC: Jacopo Mondi <jacopo@jmondi.org>
> > CC: linux-media@vger.kernel.org
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > ---
> >  drivers/media/i2c/mt9v111.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
> > index 2dc4a0f24ce8..7beca0b70b72 100644
> > --- a/drivers/media/i2c/mt9v111.c
> > +++ b/drivers/media/i2c/mt9v111.c
> > @@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
> >
> >  	/*
> >  	 * Set pixel integration time to the whole frame time.
> > -	 * This value controls the the shutter delay when running with AE
> > +	 * This value controls the shutter delay when running with AE
> >  	 * disabled. If longer than frame time, it affects the output
> >  	 * frame rate.
> >  	 */
> > --
> > 2.17.1
> >




