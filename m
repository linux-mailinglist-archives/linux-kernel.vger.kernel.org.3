Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F759C0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiHVNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiHVNfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:35:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128522A96C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8500B81221
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8B7C433D6;
        Mon, 22 Aug 2022 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661175307;
        bh=qu81bEpu83VA10aS3AYSiUHtRFuL4LO72HPagtwl6K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpVtLRFuNwVU9uP82xV498EtC+k6chfBhOw+W+WVOVCnkMEKV3kKCf+Xw3QrTk4df
         AXMZKBddw/HvLcuL7kQr0+FJc1YAMjf+HAtjoObJJRwvIPjEsEC9e4s1djd+QYu5q0
         UgAuU7r3eOyi9TSGxnGF9UGzJf8ST+mIgANuIQVfD5o/yt17cRFhzovNx2/Qzvmr+c
         OtOmV0mq9bPsJ6arnYmI3C9/9JQ4/reeZQul1IZDrYwLRlKtODD90k3VQLOk6AR3wO
         8I5EYN+v+NM2sKMa9crla6dd7U0f+G5/179cyVJgtXcqfnUM5HNR+QMTT/UY00jNXK
         wXRbbMGd0RqUw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ7a4-0002R3-2a; Mon, 22 Aug 2022 15:35:04 +0200
Date:   Mon, 22 Aug 2022 15:35:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add AUO B133UAN02.1 panel entry
Message-ID: <YwOGCPFTx0+MNfN2@hovoldconsulting.com>
References: <20220711075202.21775-1-johan+linaro@kernel.org>
 <YtpyeCHojFovBKxv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtpyeCHojFovBKxv@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:48:40AM +0200, Johan Hovold wrote:
> On Mon, Jul 11, 2022 at 09:52:02AM +0200, Johan Hovold wrote:
> > Add an eDP panel entry for AUO B133UAN02.1.
> > 
> > Due to lack of documentation, use the delay_200_500_e50 timings like
> > some other AUO entries for now.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Any comments to this one?
> 
> It looks like it hasn't shown up in the dri-devel patchwork and just
> want to make sure it isn't lost.
> 
> Rob Clark mentioned something about a spam filter on IRC.

This one still hasn't been picked up.

Is this something you can do, Doug? I noticed you applied a couple of
patches to this driver recently.

Or who is really responsible for this driver?

> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index fe3897b86665..30f69cd8f9ee 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1845,6 +1845,7 @@ static const struct panel_delay delay_100_500_e200 = {
> >   * Sort first by vendor, then by product ID.
> >   */
> >  static const struct edp_panel_entry edp_panels[] = {
> > +	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
> >  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
> >  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
> >  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),

Johan
