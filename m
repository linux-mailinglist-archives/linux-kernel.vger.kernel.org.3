Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4952F34E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbiETSib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353006AbiETSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:38:22 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01365195E9E;
        Fri, 20 May 2022 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653071874;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fNRYO8dhunH6gTFMW4B0+U3cBEjh7ezQfz7spc+5niE=;
    b=AC/laK6HjBc9W5TPCyb0XNB9Y6B1uWIGNow92kzskn+oSrhSIUTQjGumJH3uTHaQGC
    uDYPB2hbRs80PJtyDcBfx1A4RSjfKZHdb0M4N5GRhrSoUzzW4bJZjkY8xrAwB+NwtlFc
    8bKEZgTYwrr1wy38iAPzqrlZUq8oVft5l8QV2wVzQcJbCpAHe9aC+ZGPLfCx98USAlV1
    mkzCLvAthUnENXSRaKn1wFfhpWVaaGxE1KgQ9Rlq1s77Ue79nB1tGsdj0rZTEblxxzBL
    C0wysKnHOjdSpbe7ypm++PolLj9EONC9m2a53CXYer4EjrcD3GEAKXF2HDpe8VyQGEDj
    kWVg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4KIbsHfv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 20:37:54 +0200 (CEST)
Date:   Fri, 20 May 2022 20:37:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v1] dt-bindings: clock: qcom: Relicense to GPL2 + BSD
Message-ID: <YofgAd/nAejaATli@gerhold.net>
References: <20220520124447.31289-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520124447.31289-1-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:44:47PM +0200, Robert Foss wrote:
> Qualcomm has given permission for all the dt-bindings to be dual
> licensed. All of the Linaro authored bindings are easy to change, in
> terms of the permissions & copyrights, so they've been bundled in this
> commit.
> 
> Additionally clean up the syntax of some of the copyright statements.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> There are more Qcom bindings that should have the license updated
> to GPL2+BSD, but since they haven't been authored or copyrighted
> by Linaro, I think I'll have to hunt down the authors individually.
> 
>  include/dt-bindings/clock/qcom,gcc-msm8998.h          | 2 +-
>  include/dt-bindings/clock/qcom,rpmcc.h                | 2 +-
>  include/dt-bindings/clock/qcom,rpmh.h                 | 6 ++++--
> 

At least these 3 have contributors outside Qualcomm and Linaro.
Doesn't this mean you would still need to contact all of them
and see if they are fine with relicensing their contribution?

I don't want to make this more complicated than necessary, but it's
probably better to be careful when it comes to licensing stuff...

(Although personally I think it feels a bit weird to discuss copyright
 for a bunch of "numbered names"...)

Thanks,
Stephan
