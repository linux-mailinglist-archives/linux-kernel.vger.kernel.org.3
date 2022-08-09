Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F958DB57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiHIPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiHIPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:48:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94243115A;
        Tue,  9 Aug 2022 08:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D413B80B7F;
        Tue,  9 Aug 2022 15:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D29C433C1;
        Tue,  9 Aug 2022 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660060098;
        bh=jzxpOtEPbQM8mbY4SedlJQVQXOxJmNcc1pN13oORODs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV15EUVI7mCkEaWl1Zy+XOTgtawbJNPw/pFkEtXA7gD0PYSYcu7g7YtRf2j+M8A0P
         hJ87HwNnj1lAXc+6EDt6FAPQx/tEgm91qH3fllxplCnyNwUmhm5/ozh7bJJGUdwG/f
         MNLDk/pvMAiBrjj3WS2ewvFQTyGV8mAY+Nbaf19Onr6fcZex6Br/Y3N7ZH3/3XL2tR
         eZt4C0RnEerkG9Ea+2u11W91GJrZ2fe49BkTRRxbXg1Y0A2/7NBXjRpZI6kMaIxbJw
         O+B/KxQomxz3/hcpgipI/FHtj8Vd9dDok8OZ60dXA3ZUpv2aFb/PMydSQs2A12djpq
         Pf/r0o8sf3Y0Q==
Received: by pali.im (Postfix)
        id E920FC1F; Tue,  9 Aug 2022 17:48:15 +0200 (CEST)
Date:   Tue, 9 Aug 2022 17:48:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220809154815.ja2mu6ponqxnubsd@pali>
References: <20220713200123.22612-1-pali@kernel.org>
 <20220808202352.iimhb2q6yawi35y6@pali>
 <20a349c9-a479-ad5b-fe33-4758a773972e@linaro.org>
 <20220809131357.u3dfsy3gu3iamiv7@pali>
 <400b78db-17ac-b9d8-fcf9-3a4dc7821ea8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <400b78db-17ac-b9d8-fcf9-3a4dc7821ea8@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2022 18:46:04 Krzysztof Kozlowski wrote:
> On 09/08/2022 16:13, Pali Rohár wrote:
> > On Tuesday 09 August 2022 08:58:50 Krzysztof Kozlowski wrote:
> >> On 08/08/2022 23:23, Pali Rohár wrote:
> >>> PING?
> >>>
> >>> On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> >>>> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> >>>> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> >>>> indicate SoC in example.
> >>>>
> >>>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>>> ---
> >>>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
> >>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> >>>> index f6d6642d81c0..d2ca008de266 100644
> >>>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> >>>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> >>>> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
> >>>>  Boards using a SoC of the Marvell Armada 37xx family must carry the
> >>>>  following root node property:
> >>>>  
> >>>> + - compatible: must contain "marvell,armada3700"
> >>>> +
> >>>> +In addition, boards using the Marvell Armada 3710 SoC shall have the
> >>>> +following property before the previous one:
> >>>> +
> >>
> >> The change is an ABI break, which looks reasonable, but still platform
> >> maintainer should comment on it. Especially on the aspect why the
> >> marvell,armada3710 fallback was chosen at the first place.
> > 
> > I do not think this is ABI break but rather incorrect documentation and
> > bug in some board dts files.
> 
> This documentation is the ABI, especially if actually implemented in the
> DTS files, therefore by all definitions of DT ABI this is an ABI break.

Ok.

> What you are saying about "incorrect documentation and bug in some DTS
> files" is a good reason to break the ABI, but it is still a break.
> 
> Best regards,
> Krzysztof

I think it is now clear what we both mean, just we used different
terminology for the same thing.
