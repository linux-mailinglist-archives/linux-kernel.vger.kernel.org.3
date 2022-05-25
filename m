Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C04534247
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbiEYRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEYRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:37:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E497B9158D;
        Wed, 25 May 2022 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653500222;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LkCr1nDsG4a9WOPwOju1ojVRo2OtcGaGaOl1mrXFyCo=;
    b=K3J1sP+MSx4Gw/yu+LtUYd9vQc7DGk7hjxZQmHD4RmdNo3qeBVmVpQf3x745IsXgCP
    FDM7jK6aqyQ36IUXkBra1nhrje94CmYAR7oOEh5JswmXMuORuujAFupbd38qs9nq/cVQ
    fK/fcvl27P+B06++6MwzPC27/wyxXEmeP0QULj6Rh2emNKKayXNuvi2DJ5KGPwEvNWw8
    Eo3UGwt+x61M70BS9XIvv4/7ey7KJ89kpogqfnyakiYIgmHaIkdfLT2vUSjw2bGmZvXb
    uIlHZ0RqodPMwnu4O5CVTLyJQKUp+cwuxQP4GqoCLtD9RL3/tZWwOJJHBv1YjZcFOiIQ
    EEqA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKsxlg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4PHb2XpL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 May 2022 19:37:02 +0200 (CEST)
Date:   Wed, 25 May 2022 19:36:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        agross@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, robh@kernel.org, sboyd@kernel.org
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Message-ID: <Yo5pNRq/vBaamk0q@gerhold.net>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
 <YowBtNkZ678ns4Ob@builder.lan>
 <CAA8EJprArSF_363FyS+63XfB=ZK657X81u8TJLTRx5AbTYy1ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprArSF_363FyS+63XfB=ZK657X81u8TJLTRx5AbTYy1ag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 01:18:53AM +0300, Dmitry Baryshkov wrote:
> > We're following the bindings and don't pick board-id or msm-id unless
> > there's a particular reason for it - which typically is that the
> > downstream bootloader requires it - we don't use the properties on the
> > kernel side.
> 
> Or unless we have another reason (like handling a single RB3+RB5 image).
> I suspect PmOS might also like shipping a single image for some/all of
> the supported devices. Or we might use that for the qcom-armv8a OE
> machine.
> 

On a larger scale the qcom,msm-id/board-id properties are not very
useful for automatic DTB selection. This is simply because they are not
unique when you look beyond just the Qualcomm reference boards. I know
at least 3 totally different smartphones (from different vendors) where
the bootloader picks "msm8916-mtp", even though they have little in
common with Qualcomm's original MTP board.

There are also vendors who made up their own broken numbering scheme,
broken bootloaders that pick seemingly random DTBs or start modifying
random properties etc etc. Perhaps it has improved on more recent
devices but somehow I doubt it...

This means that the qcom,msm-id/board-id properties are really just
useful for making the bootloader happy, or if you have a number of
devices in full control. It's not the consistently implemented standard
that would actually be worth promoting for automatic DTB selection.

> >
> > > If the dtbTool support for the bindings is there, then there is no
> > > breakage, because you had to use dtbTool before so you have to use now.
> > >
> >
> > Among all the platforms I maintain, MSM8916 (db410c) is the only one
> > where I use dtbTool - because it refuses to accept the concatenated
> > dtb.
> 
> It's strange, I have been using concatenated dtb with db410c for ages.
> 

There is a patch in Linaro's LK fork for DB410c that selects the
appended DTB even if the qcom,msm-id/board-id properties are missing:
https://git.linaro.org/landing-teams/working/qualcomm/lk.git/commit/?id=3be1d459a546a24f2bf10b9551663a3e69a8214e

If you don't have this commit or something equivalent, appended DTBs
must have the qcom,msm-id/board-id properties for LK to accept them.

Stephan
