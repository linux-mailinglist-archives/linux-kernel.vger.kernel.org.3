Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444857BDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGTS32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbiGTS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:29:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D70C4A834
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:29:24 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 872ED6601593;
        Wed, 20 Jul 2022 19:29:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658341762;
        bh=BYHmwKYdmqtFLYQZFIsOLfxw+gBeqzenF2nInIVq+g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTPPUy6HwrcrLfXcBNjPBt4UbkwcAVUa/ebZxwNwl4nYblGG09PHlqacLe6Pg/+5X
         YOohRvbDnR8n24hHA3EXYWv0BDpG7tWicUGxg0WrEdqVf57atoeZX8oZ9rEoDWvTHh
         mez0VaMvhSB2Jg0I1gZ6Kbzt/52mYnzYjSPty0LDt7JWMKhnAT+t50BMHN6zDrx0qF
         8pVhDneQDy2WSUvgY49dy5Qge+f8yKQ8KA0NnlQChDIe/9zn3+QI6kT0Umkgqgcm4N
         SzjemjK6LaJd91nqeTwjRvC1qGzSVAaROWYa8DQmWAweYZ9JpJm6HL0g0yWTzdky8c
         7o7fjUwYc7gdQ==
Date:   Wed, 20 Jul 2022 14:29:16 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/panel-edp: Add panel entry for B120XAN01.0
Message-ID: <20220720182916.drlz5pwcyyi4weav@notapiano>
References: <20220719203857.1488831-1-nfraprado@collabora.com>
 <20220719203857.1488831-3-nfraprado@collabora.com>
 <CAD=FV=URVf6kDm9A8OsFqmy7tdsNsoDTBvfUy8aT=kfzofyDtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=URVf6kDm9A8OsFqmy7tdsNsoDTBvfUy8aT=kfzofyDtA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:41:43PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 19, 2022 at 1:39 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Add panel identification entry for the AUO B120XAN01.0 (product ID:
> > 0x1062) panel.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 675d793d925e..152e00eb846f 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1879,6 +1879,7 @@ static const struct edp_panel_entry edp_panels[] = {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
> 
>  * Sort first by vendor, then by product ID.
> 
> 0x1062 sorts at the top of the AUO panels, not at the bottom.

Right. Will fix on v2.

Thanks,
Nícolas
