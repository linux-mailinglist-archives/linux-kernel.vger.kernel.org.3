Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86C4A5719
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiBAFyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:54:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52338 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiBAFyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:54:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ADA7B82D07;
        Tue,  1 Feb 2022 05:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16274C340EB;
        Tue,  1 Feb 2022 05:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643694859;
        bh=QuK6TVAVfQ6P/afFTQpGmBkdXaSDP6oOtnNPWInv9mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X36YrMSrnDo4MT+ac34hnmwJbck1I8cCa8BSB9+cy9CD9T6haXslA1IEVtFG20Mih
         rl8tF3odxBEH8ZU3NzgI7R4JooDcJsEIvJNvDRyYYY4laCcz69GIGAcPSy26VyISkZ
         JpsdW57OLioKxXsmFWcoiEG5BKIQpEBFDOHAfwkEkAzS6iKOwXIwM16zYvfqTrZMmm
         +jy1KsYRso9r9bIV936nMJzAdXS2ib/3rpO2TMS/HhoGYmjr11uNCO1RNXEI3uFHb7
         iH9rEvu0WzKDZ3AbX582OxqpQ6/pRbuX6LH58uqYR+g0pFFb8rNGkxesT/EdCLk3Z5
         u5cqFuoyQwonQ==
Date:   Tue, 1 Feb 2022 11:24:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <YfjLCCoR4zl+aSEN@matsya>
References: <20220131172450.2528065-1-vkoul@kernel.org>
 <20220131172450.2528065-4-vkoul@kernel.org>
 <b28ad431-a760-ed02-5bcc-3fc421061759@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28ad431-a760-ed02-5bcc-3fc421061759@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-22, 15:04, Subbaraman Narayanamurthy wrote:
> On 1/31/22 9:24 AM, Vinod Koul wrote:
> > From: David Dai <daidavid1@codeaurora.org>
> >
> > PMIC v7 has different offset values and seqeunces, so add support for
> > this new version of PMIC
> >
> > Signed-off-by: David Dai <daidavid1@codeaurora.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Can you please fix the author based on my comments [1]?
> 
> [1] https://lore.kernel.org/linux-arm-msm/8f6645ff-0753-bcd3-f692-6be205cf71b8@quicinc.com/

I seem to have missed this, will update and post v3...

-- 
~Vinod
