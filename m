Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE55A1F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbiHZDCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiHZDC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:02:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C473C7BA7;
        Thu, 25 Aug 2022 20:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3512CB82F70;
        Fri, 26 Aug 2022 03:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C02C43146;
        Fri, 26 Aug 2022 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661482945;
        bh=aDWk/NLAsxgaYns6YJ3y13aGi/6vCL4IXLiBcKHqoJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYh6N+WoIvNjoVSOVe4OAmKSuAU2BpxaH4uTDmferqVfwOLCl8S4XWq4Mt9qMqOkz
         wAARiiWNH+91hu3f96S3K22lPakbDqp1lAoV48OxGweseJC1qBF0BP1oqI+1qjSs77
         klFZBUqqeQxX3fobNJ7/6iozsdVtFKzr3TvquA6CqTJ7rW0lJ2x4EoGON2WzUFrjvH
         uZEmAnNNLxDG6zdEtbGv1Lq1pG7JSlunHVdbDJHUTNEdNs9aMFepvNmAhqb07VWRHH
         /oFpDlXeCtAK9tuiDM3f8tgWAPcTp8WWSL0U6W+DcQUemwA6hDOfZMNpFd5O3WfXSU
         HRrOUwcGvO0fQ==
Date:   Thu, 25 Aug 2022 22:02:22 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20220826030222.jmgjlsf7p3sx2lld@baldur>
References: <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
 <YwAIGf59H9iKUhXF@builder.lan>
 <CACeCKadt3aoz8MZvy+tGHCxiHOPty4cLcG7AGS+oMEVnREt4sw@mail.gmail.com>
 <YwBei45gx4oVqSql@builder.lan>
 <CACeCKaewr92JcouMgyiL5rKdHf_dDmoWoyoW-U2snCNBkNijQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaewr92JcouMgyiL5rKdHf_dDmoWoyoW-U2snCNBkNijQg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:54:53AM -0700, Prashant Malani wrote:
> On Fri, Aug 19, 2022 at 9:09 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> >
> > We're talking about the static configuration here, where you describe
> > which component are connected together. We can not dynamically switch
> > the Devicetree representation around to match what the Type-C controller
> > negotiates.
> 
> Yes, but we don't need to switch the device tree representation at all.
> The pin routing/connections from the connector (not the cable or the partner),
> to the muxing hardware (QMP phy or anx7625) remains fixed always
> The port driver tells what orientation the peripheral is connected with,
> and the muxing/orientation hardware routes the signals according to that.
> 
> >
> > But why do you need to express the relationship between these 2
> > components with > 1 link in the graph?
> >
> > > The graph is static, since the hardware line routing between components
> > > doesn't change (e.g SSTX1 from the Type-C port is always routed to Pin
> > > X1,X2 on the switch hardware), but that is what the switch is for.
> > > Note that in this case, the expectation is that
> > > the switch driver only registers 1 switch (it can figure out that all
> > > 4 endpoints
> > > go to the same Type-C port).
> > >
> >
> > Why do we need to express this with 4 endpoints and then implement code
> > to discover that the 4 endpoints points to the same remote? Why not just
> > describe the logical relationship between the two components in one
> > endpoint reference?
> 
> The issue I see is with the "supplier" side of that graph relationship
> (i.e the DRM bridge side).
> Since the bridge can be directly connected to a DP panel, the
> endpoints can (technically)
> represent a single DP lane. So, using 4 end-points for the
> usb-c-connector port@1 gives
> us something which is compatible with the bridge side endpoints too
> (regardless of what
> the bridge is connected to on the "output" side).
> Reading the discussion, I agree 4 lanes is over-specifying, and 2
> endpoints is probably
> enough (especially if we can use data-lanes on the bridge side
> to define the number of lanes if needed for DP panel connections).
> 

I'm sorry, but the part I don't understand is what you gain from
representing each physical line in your connection with a
remote-endpoint pair?

What I propose is that you tie the two pieces together with a single
reference. If you need to express the number of data-lanes we have
several places where this is described separately, using the
"data-lanes" property.


With this model, if you have a 1:1 connection you have a single
remote-endpoint pair, if you have a 1:N connection, then you would have
N remote-endpoint pairs.

Regards,
Bjorn
