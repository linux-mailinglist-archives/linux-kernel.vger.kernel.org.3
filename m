Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64F55AA752
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiIBFkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiIBFkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D172E6BB;
        Thu,  1 Sep 2022 22:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC045B829E0;
        Fri,  2 Sep 2022 05:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C7C433C1;
        Fri,  2 Sep 2022 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662097228;
        bh=5515oJEpY7e2I8udEF7OHHU204KydB1v52PApM443tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJet8hBnFqqyrC9W0n0b3eThX9T6n4CsDdtz5NdFRHR0HOlUtqamI3yVFGjyN+MWf
         C7hNT1BRP8mgqAe8rE7pVkFxtOAiBv95sRqdzCrXptrE3Es90TAToceIc+OKteMW6L
         gRedBukWWda2YsAjalC9hceCIqp2vJlTsKZrT4knd+1aqyr5teHlUVD18uzNVyVpAQ
         gpX7ABDmgWzEtwApq2mxjuYqTuJC2pHLOCSHZU09d2LqGEa0vfkfeTp051Syn/FH1y
         lgbS447yof5RAiFPFbnC7sFkCUotyevshni8FAfmez3pvcwPnw60V1y4gMfGgk7sSL
         uu6ZTRw6QurRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTzPq-0007lS-PV; Fri, 02 Sep 2022 07:40:30 +0200
Date:   Fri, 2 Sep 2022 07:40:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: Fix broken regulator spec on
 RPMH boards
Message-ID: <YxGXTs0MO6Sg7nit@hovoldconsulting.com>
References: <20220829164952.2672848-1-dianders@chromium.org>
 <Yw8EE/ESDUnIRf8P@hovoldconsulting.com>
 <CAD=FV=VJz2hjvsUhsjBPt9nmm3X62oTdAqMeSFABYJietPPzWw@mail.gmail.com>
 <YxDVNW+EQbHRw16s@hovoldconsulting.com>
 <CAD=FV=VaDNLLjtKswWvhD0JmLpOoVHR05yU8kZESH3yQ0xescA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VaDNLLjtKswWvhD0JmLpOoVHR05yU8kZESH3yQ0xescA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:44:03PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 1, 2022 at 8:52 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Aug 31, 2022 at 07:52:52AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Aug 30, 2022 at 11:47 PM Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 09:49:46AM -0700, Douglas Anderson wrote:
> > > > > Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > > > get_optimum_mode(), not set_load()") several boards were able to
> > > > > change their regulator mode even though they had nothing listed in
> > > > > "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> > > > > stuck at the initial mode. Discussion of this (again, see [1]) has
> > > > > resulted in the decision that the old dts files were wrong and should
> > > > > be fixed to fully restore old functionality.
> > > > >
> > > > > This series attempts to fix everyone. I've kept each board in a
> > > > > separate patch to make stable / backports work easier.
> > > >
> > > > Should you also update the bindings so that this can be caught during
> > > > devicetree validation? That is, to always require
> > > > "regulator-allowed-modes" when "regulator-allow-set-load" is specified.
> > >
> > > Yeah, it's probably a good idea. I'm happy to review a patch that does
> > > that. I'm already quite a few patches deep of submitting random
> > > cleanups because someone mentioned it in a code review. ;-) That's
> > > actually how I got in this mess to begin with. The RPMH change was in
> > > response to a request in a different code review. ...and that came
> > > about in a code review that was posted in response to a comment about
> > > how awkward setting regulator loads was... Need to get back to my day
> > > job.
> >
> > Heh.
> >
> > > In any case, I think these dts patches are ready to land now.
> >
> > Yeah, as the old dtbs are now broken with newer kernels these are indeed
> > needed.
> 
> With the latest patches in the regulator tree things shouldn't be
> _too_ broken even without the dts files. Essentially things will get
> stuck at their initial mode (HPM). So without these patches things
> should all still boot but could possibly end up at a higher power
> state.

Ok, and there's also a warning during boot when that happens so that
it's not a silent regression?

Johan
