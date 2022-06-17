Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86254EE53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378857AbiFQAKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:10:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E136212F;
        Thu, 16 Jun 2022 17:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD02EB8268A;
        Fri, 17 Jun 2022 00:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B08EC34114;
        Fri, 17 Jun 2022 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424605;
        bh=cD73xFTYbV7d8FwYS/+LxjiTrj6GgeC/IFBJ0+It07Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsv9SdWuVyJNQeGUF1E0Nr3uDUJB7EeBVN4u0A2d1DNJmaibpJ6rwo//bI+x83hie
         aqyUD+fTDgnqYB6+kjpDVxuVMQbM5ZhBaucwIzgRmR66O2Y73qfViA6R4DUSDKG8ot
         26pywnT/zcUitfw8JYK3Av8QaIknlH0gJhsoG3o3NGo0fh2OsXwG1K5CyBtrn0ZCoa
         yry1hDGnxYxhmOGfpf/4zKhfGF+GHYrpP9OuvTx18I7hEMr+wGmdQPKsPyZPR+hmdR
         gO8VzaiAsi/SeYo6HlyAOkvp3lJcdb51Rvn5HBnbqA7Tstf42V8uC4MJQ1rkXllg6a
         mvXY0iCAi1/Vg==
Date:   Thu, 16 Jun 2022 17:10:04 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-phy@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: phy: List supplies for qcom,edp-phy
Message-ID: <YqvGXNGIzVHp7QtV@matsya>
References: <20220425210643.2420919-1-dianders@chromium.org>
 <20220425140619.2.Iae013f0ff4599294189f3a6e91376fad137bbabf@changeid>
 <CAD=FV=Wbi=CXhPpOUJj=1PdgB8i6Lf1Sfr=T7wrQsgBx790S_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wbi=CXhPpOUJj=1PdgB8i6Lf1Sfr=T7wrQsgBx790S_w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-22, 08:35, Doug Anderson wrote:
> Hi,
> 
> On Mon, Apr 25, 2022 at 2:07 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > We're supposed to list the supplies in the dt bindings but there are
> > none in the eDP PHY bindings.
> >
> > Looking at the driver in Linux, I can see that there seem to be two
> > relevant supplies: "vdda-phy" and "vdda-pll". Let's add those to the
> > bindings.
> >
> > NOTE: from looking at the Qualcomm datasheet for sc7280, it's not
> > immediately clear how to figure out how to fill in these supplies. The
> > only two eDP related supplies are simply described as "power for eDP
> > 0.9V circuits" and "power for eDP 1.2V circuits". From guessing and
> > from comparing how a similar PHY is hooked up on other similar
> > Qualcomm boards, I'll make the educated guess that the 1.2V supply
> > goes to "vdda-phy" and the 0.9V supply goes to "vdda-pll" and I'll use
> > that in the example here.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Even though patch #1 in this series should be dropped, this patch
> (patch #2) is still valid. Vinod: I assume this would land in your
> tree along with the first two patches in Kuogee's series [1], which
> are related. Please let me know if you need me to re-send or anything.

I have applied this patch, thanks

> [1] https://lore.kernel.org/r/1653507433-22585-1-git-send-email-quic_khsieh@quicinc.com/

This needs rebase on phy split which I have picked

-- 
~Vinod
