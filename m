Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEED57A03A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiGSN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiGSN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:58:17 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3C550F8;
        Tue, 19 Jul 2022 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658236163;
        bh=mzbDTGPsMTQt6Tw0VHLi9lZPP3Z3Pi3Mb0AWAdiJu1w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=winc6PgDk7R4QvMLOUR8xS5i1zqMWhlwe2ixu3FaJEEErneM92A8+ucnXMcO9mqzY
         Q0a63SbQYITGD0rRF1h8LwZabwJu045z/LFiU2VySMyAtQ5lnhmIyQy8XPu9PX5+kO
         9a+TqWsU4OnzpzFepRDtMvsTO/ZWsMR+s2as7D+c=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0112128680F;
        Tue, 19 Jul 2022 09:09:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6vdAABWer626; Tue, 19 Jul 2022 09:09:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658236160;
        bh=mzbDTGPsMTQt6Tw0VHLi9lZPP3Z3Pi3Mb0AWAdiJu1w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=eKjwdlhtqURkUQf3N1TeW7mIBu/rPvYcqqbP5q74w7sD3BELza68awDr3JQfDMPQ8
         W5oqKktbqkJk7Ox3bGXhIPah024loA10lTlaqWHqgVuaUcMyjK3VYhpcvs8+ahEIrX
         sjPago9KeRuUuGlqQmUkdO8xaSQ51StUFvoezbGY=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E3C151280775;
        Tue, 19 Jul 2022 09:09:19 -0400 (EDT)
Message-ID: <a53cf4da2a03af3635bebbfc1bb4ecf0a73bc0e1.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: message: fusion: Fix comment typo
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Wang <wangborong@cdjrlc.com>, sreekanth.reddy@broadcom.com
Cc:     sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:09:17 -0400
In-Reply-To: <20220716042245.35708-1-wangborong@cdjrlc.com>
References: <20220716042245.35708-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-16 at 12:22 +0800, Jason Wang wrote:
> The double `only' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/message/fusion/mptbase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/message/fusion/mptbase.c
> b/drivers/message/fusion/mptbase.c
> index 9b3ba2df71c7..86e7510d7614 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -518,7 +518,7 @@ mpt_reply(MPT_ADAPTER *ioc, u32 pa)
>  
>  	/* Map DMA address of reply header to cpu address.
>  	 * pa is 32 bits - but the dma address may be 32 or 64 bits
> -	 * get offset based only only the low addresses
> +	 * get offset based only the low addresses

What is the point of all this if you're not even going to read the
comment to make sure it makes grammatical sense?  Neither the before
nor after versions do here.

James


