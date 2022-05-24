Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA52533057
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiEXST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiEXST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:19:26 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52BF72237;
        Tue, 24 May 2022 11:19:21 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8CE9120332;
        Tue, 24 May 2022 20:19:19 +0200 (CEST)
Date:   Tue, 24 May 2022 20:19:18 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220524181918.dadrny7gle7zfcdk@SoMainline.org>
References: <20170323055435.29197-1-bjorn.andersson@linaro.org>
 <20220523163038.GA9124@duo.ucw.cz>
 <20220523220107.6wmpp2ohw63p4mjh@SoMainline.org>
 <20220523221835.GC15554@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523221835.GC15554@duo.ucw.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-24 00:18:35, Pavel Machek wrote:
[...]
> > > I'd really like to see the patch fixing the pattern interface (or
> > > disabling it). I don't want to push the tree to Linus with that bug.
> > 
> > (I couldn't help but be confused for a minute by this being a reply to
> > the original v1 patchset from March 2017 :) )
> > 
> > Does that mean there's still some time to review / pick up [1]
> > (LPG enablement for PM660L)?  And even more so for [2] (fixing the use
> > of a software-pattern variable in the hardware-pattern code) which
> > complements Bjorn's series but hasn't been looked at ever since last
> > year.
> 
> There's still time if the patches are perfect.

How should I know if a patch is perfect when it has been ignored for
over a year [1]?  Only Bjorn has reviewed and tested it.

I'm not asking for an instant merge, but feedback is appreciated.  I
don't see any glaring issues with the patch so I'm kindly (re-)asking
you to point them out so that I can correct the patch.

- Marijn

[1]: https://lore.kernel.org/linux-leds/20210418213427.220638-1-marijn.suijten@somainline.org/
