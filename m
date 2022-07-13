Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533BC572DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiGMF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiGMF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71414735BF;
        Tue, 12 Jul 2022 22:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7F09B81D05;
        Wed, 13 Jul 2022 05:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B401C34114;
        Wed, 13 Jul 2022 05:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657691887;
        bh=+TFecpe9VYqNJy3cLeqbEtIOTbGwOcH+jyHof4F95ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsYLPU1Bjagy0Wep8RytHKxRpNtS30kzPubfzlikEyjPw/ExMjGxAGav4P+/99i36
         OaQOrrzkM2yQPa58rSwFx57FHmxUpG+VEarOKajzEv9kPTBvkIZeAjiuf3mIUPUsnM
         zTDKVhyWMekJyQYgETZGZ2Xivd69UjLMgRa7yDqrEMsD/6RLet6aX9AaZOZg95LwHN
         GZWmFZAKu4zfIJJ74KREfuKVr5Dil0UFdETQbDLNfPVVBCWOJj920BJ7jbQaAXHXog
         VL/gUZv+YVTVcNPrf7EebY0W9Bax8aHtRJVumxqomKF8JExBPOKDM6sKM1yP6r5lnv
         HFIoC4PoOkfJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBVNx-0000Cp-2E; Wed, 13 Jul 2022 07:58:09 +0200
Date:   Wed, 13 Jul 2022 07:58:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <Ys5e8StvLMj5LBLm@hovoldconsulting.com>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
 <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
 <YszcSgnSrbsncw0J@ripper>
 <Ys2K/BH/kAeTBz5t@hovoldconsulting.com>
 <Ys4lnuVncPiWkjbH@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys4lnuVncPiWkjbH@builder.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:53:34PM -0500, Bjorn Andersson wrote:
> On Tue 12 Jul 09:53 CDT 2022, Johan Hovold wrote:
> > On Mon, Jul 11, 2022 at 07:28:26PM -0700, Bjorn Andersson wrote:
> > > On Mon 11 Jul 01:56 PDT 2022, Johan Hovold wrote:

> > > > While addressing the current issue, this looks odd to me. Why not use a
> > > > non-zero parent bus address here instead?
> > > > 
> > > 
> > > I guess we could express the frames relative the timer range, but that
> > > would imply that anyone porting downstream dts snippets would have to
> > > translate these addresses - or more likely would end up just copying the
> > > existing cases.
> > > 
> > > > And please use hex notation consistently for the addresses.
> > > 
> > > That seems like a reasonable ask, I can fix that up. But on both
> > > accounts this matches what I merged for all the other platforms in:
> > > 
> > > 458ebdbb8e5d ("arm64: dts: qcom: timer should use only 32-bit size")
> > > 
> > > 
> > > So I guess we'll also need to go back and fix up the style of all the
> > > other platforms - just because we're not allowed to express the frames
> > > in 64-bits according to the binding...
> > 
> > Would have been easier to just amend the binding. I don't think that
> > #size-cells = 1 constraint is set in stone as it was added when
> > converting to DT schema.
> 
> Rob disagrees with this idea:
> https://lore.kernel.org/all/CAL_JsqJMMCBnukFZLJ8X14s1PwqT=VEwKjDVj8mm4h55pZpcuw@mail.gmail.com/

Ok, thanks for the link. I'd still prefer a non-zero parent-bus address
in that ranges, but we can change that later too.

> > But you probably should amend the commit message and mention that this
> > fixes time keeping. I had recently noticed that something was off
> > (journals rotating, and erratic cursor blinking) but didn't realise that
> > timers were broken until you posted this.
> > 
> 
> That sounds like a good idea, thanks for the suggestion.

I guess you're posting a v2, but otherwise feel free to add my 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

when applying.

Johan
