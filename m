Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C514DA5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbiCOXJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbiCOXJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:09:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7176356;
        Tue, 15 Mar 2022 16:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3168B8190D;
        Tue, 15 Mar 2022 23:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DB0C340E8;
        Tue, 15 Mar 2022 23:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647385676;
        bh=gZ9ETSTbzXKBbGACbqOKyBDoMODbMPnCrQC64VaMDDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsThO9U/ggu/G2r0L7b7UUJRN/to4EWzxAu4scu7wfNCuJwWrTNd/s6Yf/xdgmUfW
         VHzej/vDL8xGBZXfAkmQZzGIqixuQsW0BkmmAaFrL3qaLW+iiHKToNHJ2uO+k6DYCi
         MS1R4pQcbxuj56qsC9GYrpEeKWf+jQVjwbXmegR6UTZA7Shy6tEfliTao27QnJ8zsJ
         Mxk+ylNBErUepN3D0t3DksOXl/G8X9S0BfgJuh9yM5fKesLPkTRQROoXJApigHSCu+
         NBuzW3a7PGmNq9K1L9uZPO5fT/MN1Zi7OowFn5UtGwsf1Hg0OG6MTSVPA0dE1lznlh
         rjeTnGPg5CKcQ==
Received: by pali.im (Postfix)
        id B7847824; Wed, 16 Mar 2022 00:07:53 +0100 (CET)
Date:   Wed, 16 Mar 2022 00:07:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Message-ID: <20220315230753.6xymu77uirjbnn3u@pali>
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
 <5ea0e154-e06e-32b4-be86-f38ce07b8bec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea0e154-e06e-32b4-be86-f38ce07b8bec@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2022 23:00:14 Colin King (gmail) wrote:
> On 15/03/2022 22:46, Pali Rohár wrote:
> > On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
> > > There are several spelling mistakes in comments, function names
> > > and literal strings. Fix these.
> > 
> > I do not think that there are mistakes.
> > 
> > Please look at page 29 of the official bq24150 datasheet:
> > https://www.ti.com/lit/ds/symlink/bq24150.pdf
> 
> Looks like TI are redefining the spelling in the language :-)

Well, that could be truth, or maybe it just means something different.
It is about 10 years ago and I do not remember more details about it.
Anyway, in any case register name is vender and kernel code should match
official register naming for which driver was written...

> > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   drivers/power/supply/bq2415x_charger.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
> > > index 5724001e66b9..b35700071966 100644
> > > --- a/drivers/power/supply/bq2415x_charger.c
> > > +++ b/drivers/power/supply/bq2415x_charger.c
> > > @@ -71,7 +71,7 @@
> > >   #define BQ2415X_BIT_OTG_PL		1
> > >   #define BQ2415X_BIT_OTG_EN		0
> > > -/* vender register */
> > > +/* vendor register */
> > >   #define BQ2415X_MASK_VENDER		(BIT(5)|BIT(6)|BIT(7))
> > >   #define BQ2415X_SHIFT_VENDER		5
> > >   #define BQ2415X_MASK_PN			(BIT(3)|BIT(4))
> > > @@ -491,8 +491,8 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
> > >   	return -1;
> > >   }
> > > -/* return chip vender code */
> > > -static int bq2415x_get_vender_code(struct bq2415x_device *bq)
> > > +/* return chip vendor code */
> > > +static int bq2415x_get_vendor_code(struct bq2415x_device *bq)
> > >   {
> > >   	int ret;
> > > @@ -1501,9 +1501,9 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
> > >   		sprintf(revstr, "1.%d", ret);
> > >   	bq->model = kasprintf(GFP_KERNEL,
> > > -				"chip %s, revision %s, vender code %.3d",
> > > +				"chip %s, revision %s, vendor code %.3d",
> > >   				bq2415x_chip_name[chip], revstr,
> > > -				bq2415x_get_vender_code(bq));
> > > +				bq2415x_get_vendor_code(bq));
> > >   	if (!bq->model) {
> > >   		dev_err(bq->dev, "failed to allocate model name\n");
> > >   		return -ENOMEM;
> > > -- 
> > > 2.35.1
> > > 
> 
