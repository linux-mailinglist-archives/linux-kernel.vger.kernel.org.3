Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4F5A27F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiHZMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiHZMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:47:35 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB918C3F4C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:47:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 12F971B7B33D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661518053;
        bh=pHGdbAZ8yHJXcc1IiwPqIukelsWN+xTJDJbDVpn1CRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=5woMm8D34dS2aEs11r5xXmnEOld28yIYtj6anktNXzVuiSg/a88L294Drtkp59XIT
         rh0RgXHpJx5JuU/P40oxVlRkWaX00iHX1x89EN2ASzLYJ+2GkSCPi0vwsN+23hy+Vs
         ft5WgziF6bcodXkfw3sLO5ReJ7RuE8ku9kGSFS18=
Received: from fx408 (localhost [127.0.0.1]) by fx408.security-mail.net
 (Postfix) with ESMTP id 890061B7B338; Fri, 26 Aug 2022 14:47:32 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id E15531B7B32D; Fri, 26 Aug
 2022 14:47:31 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 76B8E27E0396; Fri, 26 Aug 2022
 14:47:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 60DA127E0392; Fri, 26 Aug 2022 14:47:31 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 J28sEK3Be1oG; Fri, 26 Aug 2022 14:47:31 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 50B3227E02FA; Fri, 26 Aug 2022
 14:47:31 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <ff93.6308c0e3.91e7a.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 60DA127E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661518051;
 bh=DQm8/mFotTyNp8oq1JVmzSbODsEZD3nZb0VeJpozQ3Q=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=CpCPYyDFmweQfBYWBwvXalD4GuC2KIARd9zbmIzKAUTYvhtISBMKiRn46Su8Jwtjb
 WIM60CWj/gCEITcH1jTWAJ0g11spMG6vAtgfXnvAJM3YtWRJKP/drblhLvD2mCBHCN
 Pt8ZT5L9Z07oNKTM9r9iUtRkJYqLnlwZZhJGWwnM=
Date:   Fri, 26 Aug 2022 14:47:30 +0200
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: Fix repeated word in comments
Message-ID: <20220826124730.GD10294@tellis.lin.mbt.kalray.eu>
References: <20220826100052.22945-22-jmaselbas@kalray.eu>
 <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
 <a4fbbf75-7fad-3124-6d42-21749b507115@xs4all.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4fbbf75-7fad-3124-6d42-21749b507115@xs4all.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:23:54PM +0200, Hans Verkuil wrote:
> I'm rejecting these patches in patchwork. All (or almost all) are duplicates.
I was expecting this, I didn't search for exiting patches. Sorry for the
noise.

Thanks
> Regards,
> 
> 	Hans
> 
> On 8/26/22 12:24, Jacopo Mondi wrote:
> > Hi Jules
> > 
> >   thanks, but as reported in patchwork and lore
> > https://patchwork.linuxtv.org/project/linux-media/list/?series=&submitter=&state=*&q=mt9v111&archive=both&delegate=
> > https://lore.kernel.org/all/20220824135433.h2udwtnub7mlmtam@uno.localdomain/
> > 
> > This is the 4th patch to fix the same repeated word in a comment.
> > 
> > As I asked to Jilin, are you submitting this as part of a new
> > contributor program ?
> > 
> > Thanks
> >    j
> > 
> > On Fri, Aug 26, 2022 at 12:00:50PM +0200, Jules Maselbas wrote:
> >> Remove redundant word `the`.
> >>
> >> CC: Jacopo Mondi <jacopo@jmondi.org>
> >> CC: linux-media@vger.kernel.org
> >> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> >> ---
> >>  drivers/media/i2c/mt9v111.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
> >> index 2dc4a0f24ce8..7beca0b70b72 100644
> >> --- a/drivers/media/i2c/mt9v111.c
> >> +++ b/drivers/media/i2c/mt9v111.c
> >> @@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
> >>
> >>  	/*
> >>  	 * Set pixel integration time to the whole frame time.
> >> -	 * This value controls the the shutter delay when running with AE
> >> +	 * This value controls the shutter delay when running with AE
> >>  	 * disabled. If longer than frame time, it affects the output
> >>  	 * frame rate.
> >>  	 */
> >> --
> >> 2.17.1
> >>




