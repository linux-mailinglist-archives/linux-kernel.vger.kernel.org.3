Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E1531E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiEWWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiEWWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:01:13 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D946170
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:01:10 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0F6FC2013A;
        Tue, 24 May 2022 00:01:09 +0200 (CEST)
Date:   Tue, 24 May 2022 00:01:07 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220523220107.6wmpp2ohw63p4mjh@SoMainline.org>
References: <20170323055435.29197-1-bjorn.andersson@linaro.org>
 <20220523163038.GA9124@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523163038.GA9124@duo.ucw.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-23 18:30:38, Pavel Machek wrote:
> Hi!
> 
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > lookup-table, altering the duty cycle over time - which provides the
> > means for e.g. hardware assisted transitions of LED brightness.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> I'd really like to see the patch fixing the pattern interface (or
> disabling it). I don't want to push the tree to Linus with that bug.

(I couldn't help but be confused for a minute by this being a reply to
the original v1 patchset from March 2017 :) )

Does that mean there's still some time to review / pick up [1]
(LPG enablement for PM660L)?  And even more so for [2] (fixing the use
of a software-pattern variable in the hardware-pattern code) which
complements Bjorn's series but hasn't been looked at ever since last
year.

I wouldn't mind picking up this issue (discussed in the v14 series at
[3]) and unblock you sending the tree to Linus without reverting, if
Bjorn doesn't have the bandwidth for it currently.  But I will need
confirmation that patches sent in my name actually get looked at...
Thanks!

- Marijn

[1]: https://lore.kernel.org/linux-leds/20220511190718.764445-1-marijn.suijten@somainline.org/
[2]: https://lore.kernel.org/linux-leds/20210915080252.69147-1-marijn.suijten@somainline.org/
[3]: https://lore.kernel.org/linux-leds/YnvhleAI5RW0ZvkV@ripper/T/#m6cb0d8df051bbcd3772d068640ccd784678ad47b
