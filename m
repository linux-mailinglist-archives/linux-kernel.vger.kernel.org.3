Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23680520460
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiEISUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiEISUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:20:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427C1704D;
        Mon,  9 May 2022 11:16:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id A1A081F43FBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652120196;
        bh=0esjJrezivP9EYp59dd6OuPM+PGc8UvFALjMsvmFKsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUh3KDx8N16l+rXRuTIRBtKHsGvmr01Muo2U74eUROqwiqIK9TdjItLT2iPA+pFdw
         ZfEWl/b+6xDzqzGV3Z6Ogh7UxvtzVCTDXt7fNxonKzjLDb4w4GmV+S//PNbGOkP2H0
         +ymJQljlQM1pjjU89yEWu9EMflqiwD7Q2U2oUuTaMDWYS+AtJm8okAb00IzpJD3uGx
         4ORjyRbtV1v6k8OoJ+iHNw8ZRI8gENXeoq1K2bTGTpIAIFzNkmYn9e6GH/dMxLCFLm
         KOQLwgDqJcID6J2UAyWB5UAvWDA12sWsTEb4JJmPOHXvBumyYeQLBjHIZEweYrUive
         9rJIooEZD9GfQ==
Date:   Mon, 9 May 2022 14:16:29 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jiaxin.yu@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, shane.chien@mediatek.com,
        linux-mediatek@lists.infradead.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, kernel@collabora.com, tzungbi@google.com
Subject: Re: [PATCH 0/3] Add missing dt-binding properties for audio
 components on mt8192-asurada
Message-ID: <20220509181629.ettskdxfvwvqaq76@notapiano>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <165211666198.1065748.1151009730882312510.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <165211666198.1065748.1151009730882312510.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 06:17:41PM +0100, Mark Brown wrote:
> On Fri, 29 Apr 2022 16:30:36 -0400, Nícolas F. R. A. Prado wrote:
> > These patches add properties that were missing on the dt-bindings of the
> > audio components used by mt8192-asurada. Namely the i2s-share
> > properties for the sound platform and the #sound-dai-cells on the
> > rt1015p and rt5682 codecs when they're referenced by the machine sound
> > node.
> > 
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
>       commit: e056cf4341ae3f856f1e38da02b27cb04de4c69b
> [2/3] ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
>       commit: 2f45536587e53a7a22024e12fbe97ef13598e623
> [3/3] ASoC: dt-bindings: rt5682: Add #sound-dai-cells
>       commit: 0adccaf1eac91a2c2ee6a54a6de042affe9860f4

Hi Mark,

this series wasn't supposed to be merged yet, I'm in the process of preparing
and sending a v2. Well, for patch 1 at least, which needs some improvements
still. Patches 2 and 3 weren't going to be changed, so those would be fine to
keep merged if you want. 

Thanks,
Nícolas
