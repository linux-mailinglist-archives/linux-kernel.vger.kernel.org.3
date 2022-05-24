Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A96533330
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiEXWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbiEXWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:03:16 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA76620D;
        Tue, 24 May 2022 15:03:15 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 36B4520596;
        Wed, 25 May 2022 00:03:13 +0200 (CEST)
Date:   Wed, 25 May 2022 00:03:12 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/9] drm/msm/dsi_phy: Replace parent names with clk_hw
 pointers
Message-ID: <20220524220312.jrdkolu7eoxtcyju@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Marek <jonathan@marek.ca>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20220523213837.1016542-1-marijn.suijten@somainline.org>
 <CAA8EJprEjOWRh98V3sprjXZJZMeR25Bz1U3a_uX_KhRbU48srQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprEjOWRh98V3sprjXZJZMeR25Bz1U3a_uX_KhRbU48srQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-24 02:43:01, Dmitry Baryshkov wrote:
> Hi,
> 
> On Tue, 24 May 2022 at 00:38, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > As stated in [1] I promised to tackle and send this series.
> >
> > parent_hw pointers are easier to manage and cheaper to use than
> > repeatedly formatting the parent name and subsequently leaving the clk
> > framework to perform lookups based on that name.
> >
> > This series starts out by adding extra constructors for divider, mux and
> > fixed-factor clocks that have parent_hw(s) pointer argument(s) instead
> > of some DT index or name.  Followed by individual patches performing the
> > conversion, one DSI PHY at a time.
> >
> > dsi_phy_28nm_8960 includes an extra fixup to replace "eternal"
> > devm_kzalloc allocations (for the lifetime of the device) with
> > stack-local char arrays, like all the other DSI PHY drivers.
> >
> > I couldn't help but notice that clock names are wildly varying:
> >
> > - Some use underscores in the _clk suffix where others have nothing;
> > - Some have an _ after the %d, others have not;
> > - Some use a _pll suffix after dsi%d or even _phy_pll suffix.
> >
> > Are there any thoughts or feelings towards unifying these?
> > Theoretically no clock names are used anywhere in the kernel, and
> > everything is based on a phandle + index in DT (I have yet to validate
> > this).  Obviously no .name/.fw_name will be updated to not break DT.
> 
> I'd say, leave them as is. Even if they are historical, we don't have
> a strong pressure to change them.

Leave them as it is, or - as suggested below - clean them up?

> Significant number of older platforms still use names to identify the
> clock. And moreover apq8096/msm8960 uses dsi1/dsi2 instead of
> dsi0/dsi1.
> 
> Probably we should call the next cycle "The Cycle of clocks cleaning".
> I can volunteer to take care of 8960/8064/8016/8996, as at least I can
> test them. But if you wish, you (or anybody else of course) can take
> any of these platforms too, just ping me, so that I won't spend time
> duplicating somebody's efforts.

We can at least clean up the names of clocks that are not "exported" by
the drivers.  However, we should also convert all other clk drivers to
utilize DT to define clk dependencies instead of depending on global
names, and already got quite some platforms tackled.  At that point we
can just convert all names (give or take the often discussed "backwards
compatbility" between the kernel and some ancient DT someone may still
be running on their device).

I don't own any device for the SoCs you mentioned, all good from my
side if you take them.  We should probably note down all clock drivers
that still need conversion and split them across devs with physical
access, then I can check what I still have lying around here as well.

> > Which, by the way, is there a particular reason for:
> >
> >   #define DSI_BYTE_PLL_CLK              0
> >   #define DSI_PIXEL_PLL_CLK             1
> >
> > To not be in the dt-bindings and used in the DT?
> 
> Before my restructure of the DSI PHY subsys, each driver defined them
> separately. And the idea of moving them to a dt-bindings header didn't
> come to my mind. Feel free to do so, it looks like a good idea.
> Just as a note, DP PHY also uses 0 for the link clock and 1 for the
> pixel clock. What do you think about having a single header for these
> names?

No worries, it's already much better to have them defined once :), now
we can just go one step further and move it to dt-bindings.  Great to
clean up the "magic constant indices" for the DP PHY as well
(phy-qcom-qmp.c is the only one defining these clocks, right?) and I
think we're fine having them in one header, pending someone suggesting a
name as I have no idea what to call it nor where to put it.  Under
dt-bindings/clock most likely, but what common name would we choose?
Something including qcom and mdss?

> 
> >
> > And with enough future improvements out of the way, let's round out this
> > patch-series by stating that it has been successfully tested on:
> >
> > - Sony Nile Discovery (Xperia XA2 Ultra): 14nm;
> > - Sony Seine PDX201 (Xperia 10II): 14nm;
> > - Sony Loire Suzu (Xperia X): 28nm.
> >
> > And no diff is observed in debugfs's clk_summary.
> >
> > Unfortunately all other devices in my collection with a 7/10nm DSI PHY
> > have a DSC panel which we have yet to get working.
> 
> I will test it on RB3 (10nm) and RB5 (7nm) during one of the next few days.

Lovely, thanks a ton - also for reviewing this so quickly!

- Marijn
