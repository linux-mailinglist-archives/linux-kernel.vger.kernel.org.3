Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5058232F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiG0JeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiG0JeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2033E37;
        Wed, 27 Jul 2022 02:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA516178F;
        Wed, 27 Jul 2022 09:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33584C433D6;
        Wed, 27 Jul 2022 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658914452;
        bh=6JmACeP5ozhHq4rfyR4QydvrbyG2gSDUNRgLQiHN5mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qc1SBcSTBva8z84KNsURkaAhFrDPd1tPb8VbjXJXdhuA54t5SFhzcH7ZF0IsuhzEZ
         h0fsbSCw02rGrQ8+EWVKk7B+xZhUjY5FnrLXl6Ud8iwq5hjVPBPt36Yeoc1E2pI759
         peDyI6yC3oH2WZO9EmLuLllkC2kSH35kKBERzKNU=
Date:   Wed, 27 Jul 2022 11:34:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Message-ID: <YuEGkkWV5s+q4hbf@kroah.com>
References: <1657810516-31143-1-git-send-email-quic_kriskura@quicinc.com>
 <YtAv8R7QlTZCjvRO@kroah.com>
 <YtA78UfeibaQW4pf@google.com>
 <b491bb80-aef5-f90b-4763-68fa5435b6d9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b491bb80-aef5-f90b-4763-68fa5435b6d9@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 27, 2022 at 02:56:06PM +0530, Krishna Kurapati PSSNV wrote:
> Hi Greg,
> 
>   As Mathias pointed out in another thread, no issue was seen so far on
> present QC targets as wakeup-source property was added recently and only for
> SC7180 and SC7280. We ran into some issues like wakeup from system suspend
> in host mode wasn't happening although we enabled wakeup-source in SC7180
> that eventually led us to this bug. But i tried to add debug prints to
> follow the code flow and see that the issue is present on SM8350 as well :
> *"supplier 88e9000.phy-wrapper not ready" *and deferring dwc3 probe.**This
> doesn't seem to be specific to SC7180.

I have no context here at all, sorry.

Remember, some of us get thousands of emails a week to handle and
review.  I don't know what other thread you are talking about, nor what
the issue here is at all, nor even what the patch is.

totally confused,

greg k-h
