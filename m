Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3224591B97
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiHMPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiHMPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4572B265;
        Sat, 13 Aug 2022 08:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76D8DB80689;
        Sat, 13 Aug 2022 15:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5571DC433C1;
        Sat, 13 Aug 2022 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660405388;
        bh=7np7mJqPeBgv041i57B2DM02CHOQuh0GruFHQCNsAZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g8NX46prV5L64TYWoXuLSki7hBqvTAPMfFav3YUVIqZ2j6vUrtRmcq3fxPTvNrF6A
         y9sYm3CWSgNN+Pyw3DarW1QW44u3pKDjflPsdI5ozsM0BeH0J6UYTliC+Q6F5dlqqz
         IxaSrYxkY1rTsBPrKwGbhFXwwDdVxo85PPD2LvbUwIirwEz6JO+SyJVjrOTyx82/c/
         Ybu3MYTBEeC6Dtlt6JWlfwR2rDH5u0cLHcnH5UyUfR2XE5mL0QvZbQrRbDJm7+fXDH
         ed02TYnRMcn/S4QOKgpccJTiz/RpcUDdOUkzUSWP8PuXBUMHblYqBNasQ9uAnFVsYB
         FKp3L9eunhwPg==
Date:   Sat, 13 Aug 2022 16:53:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: bosch,bmg160: correct
 number of pins
Message-ID: <20220813165336.40870468@jic23-huawei>
In-Reply-To: <1ab7b38d-e356-6cb8-f101-9499eb34e026@linaro.org>
References: <20220805075503.16983-1-krzysztof.kozlowski@linaro.org>
        <20220806153221.1a90bd28@jic23-huawei>
        <1ab7b38d-e356-6cb8-f101-9499eb34e026@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 07:48:31 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/08/2022 16:32, Jonathan Cameron wrote:
> > On Fri,  5 Aug 2022 09:55:03 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> BMG160 has two interrupt pins to which interrupts can be freely mapped.
> >> Correct the schema to express such case and fix warnings like:
> >>
> >>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
> >>
> >> However the basic issue still persists - the interrupts should come in a
> >> defined order.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. Accept also INT2 as one interrupt (Jonathan).  
> > 
> > This doesn't work. If we are going to support either interrupt, at the very least
> > we need to require interrupt-names if the first one isn't INT1.  So your fix
> > is right but not enough.
> > 
> > Driver may ignore interrupt-names for now (would be good to have a sanity check in driver
> > though so the driver explicitly checks for INT2 and doesn't use the interrupt if
> > it is INT2 - support for that being for a future 'feature' addition).
> > 
> > A hacky solution would be to require the first one to always be INT1 but that
> > gives us no (backwards compatible) path forwards if someone does have a board
> > where only INT2 is wired.
> > 
> > So minimum change I think will be to provide interrupt-names allowing any of
> > INT1 (default if not specified)
> > INT1, INT2
> > INT2  
> 
> This is exactly what my fix is doing. What else do you need?
> interrupt-names is just a helper which anyway driver does not use, so
> enforcing it now does not change much.

Ok. I guess this sort of papers over it in a vague fashion and
avoids pointing out there that there is breakage in the one interrupt case
beyond a hint in the commit message.

Better than nothing but only a partial fix for the actual issue
(where that issue isn't a binding warning!)

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan


> 
> 
> Best regards,
> Krzysztof

