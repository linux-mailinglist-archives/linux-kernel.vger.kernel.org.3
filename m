Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E75A9C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiIAPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiIAPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AF402D9;
        Thu,  1 Sep 2022 08:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B829561F19;
        Thu,  1 Sep 2022 15:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDFCC433D6;
        Thu,  1 Sep 2022 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662047540;
        bh=34vESrVVRe/Gvd1WwwkrRcgjvAK0J4ZY6Nipqtoutgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj2arhAoWe07La6XVtPnCUxijvLpgwYBi1YBn9wVtXodcREyNJh44XP192jPrZWEY
         4cQx29s2fH5WooVsi9YwAiyC03/TPXXxUlshA+Z4cLsIFrUHe9SrF7Nw+sgVYiqhmS
         gdnOF9Hboc5uwVEH66H4v17LfcFYE3WF01iw5EI2GyL9uJyhNl1s+a4lEGiaDbnhEr
         vOia4IOspZ+D51srFikbpPekK46b+ZlrQ8VEIklPGuqvunfPsk4uv6YGKVHsaB8XXN
         N8iwFi0MlGcWf7B+Eb3jT2tqt0A/+VR+NqyyqadY+xkkkJrF9OPyK3rJidFPin5cg0
         IslzDQgPs6OIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTmUP-0004Qm-Fa; Thu, 01 Sep 2022 17:52:21 +0200
Date:   Thu, 1 Sep 2022 17:52:21 +0200
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
Message-ID: <YxDVNW+EQbHRw16s@hovoldconsulting.com>
References: <20220829164952.2672848-1-dianders@chromium.org>
 <Yw8EE/ESDUnIRf8P@hovoldconsulting.com>
 <CAD=FV=VJz2hjvsUhsjBPt9nmm3X62oTdAqMeSFABYJietPPzWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VJz2hjvsUhsjBPt9nmm3X62oTdAqMeSFABYJietPPzWw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 07:52:52AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Aug 30, 2022 at 11:47 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 09:49:46AM -0700, Douglas Anderson wrote:
> > > Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > get_optimum_mode(), not set_load()") several boards were able to
> > > change their regulator mode even though they had nothing listed in
> > > "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> > > stuck at the initial mode. Discussion of this (again, see [1]) has
> > > resulted in the decision that the old dts files were wrong and should
> > > be fixed to fully restore old functionality.
> > >
> > > This series attempts to fix everyone. I've kept each board in a
> > > separate patch to make stable / backports work easier.
> >
> > Should you also update the bindings so that this can be caught during
> > devicetree validation? That is, to always require
> > "regulator-allowed-modes" when "regulator-allow-set-load" is specified.
> 
> Yeah, it's probably a good idea. I'm happy to review a patch that does
> that. I'm already quite a few patches deep of submitting random
> cleanups because someone mentioned it in a code review. ;-) That's
> actually how I got in this mess to begin with. The RPMH change was in
> response to a request in a different code review. ...and that came
> about in a code review that was posted in response to a comment about
> how awkward setting regulator loads was... Need to get back to my day
> job.

Heh.

> In any case, I think these dts patches are ready to land now.

Yeah, as the old dtbs are now broken with newer kernels these are indeed
needed.

But regardless of the question of backwards compatibility, it seems that
the bindings should at least reflect that the old DTs are now considered
malformed.

> > Perhaps at least for RPMh as it seemed you found some cases were this
> > wasn't currently needed (even if that sounded like an Linux-specific
> > implementation detail).
> 
> I think you're talking about the RPM vs. RPMH difference? It's
> actually not Linux specific. In RPM the API to the "hardware"
> (actually a remote processor) is to pass the load. In RPMH the API to
> the hardware is to pass a mode. This is why RPMH has
> "regulator-allowed-modes" and "regulator-initial-mode". Both RPM and
> RPMH have "regulator-allow-set-load" though...

Ah, ok. And this was only an issue for Qualcomm DTs, which are the only
users of "regulator-allow-set-load" in mainline.

Johan
