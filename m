Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480125689A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiGFNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiGFNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:38:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B71F601;
        Wed,  6 Jul 2022 06:38:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8A7466019A9;
        Wed,  6 Jul 2022 14:38:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657114717;
        bh=qOtVS41pFz0Cve8LG+rZ2GhjzM5M5kZoqRvDnnf0RBk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fmP6bXbo4NwE3MRbQ27Ib9ENErWkf3QTl7Z28jEeOLe1o/C29AscjQJhM4P5kWJRD
         RfewV9nXGULjUsuoB08jqa1bJhqa9mJEZSXOWvvR0EcfC00hNO04eBfnqYeFvKW0MX
         DYDlmYguGCfGcGeV0cXZfBe1ti7YDySZ+5ywsICO2ryDZ4uQjXE19SM8wgyK4i9ScQ
         C3+p0Pk3IddEr/NCcs2JACVysqr6Xno1O/LDjEGwz1dWszeuvBIV83IAVrSEQ9Gapt
         SOgHc5ECUR3inWCl/95IVAJU59iVWklvznwdlf2CnLxvhQdfWjXol/o1lx6acc81rc
         c1iK12Jxu3Tgg==
Message-ID: <82736173-b3b8-1e1a-3e2e-25d9ca3287eb@collabora.com>
Date:   Wed, 6 Jul 2022 15:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332
 Regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
 <YsV9IerWCoa/xtwM@sirena.org.uk>
 <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
 <YsWG0jfqAf4EqojE@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YsWG0jfqAf4EqojE@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 14:57, Mark Brown ha scritto:
> On Wed, Jul 06, 2022 at 02:49:56PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 06/07/22 14:16, Mark Brown ha scritto:
> 
>>> This previously got 0day failures due to missing dependencies which
>>> need would need a merge with IIRC MFD, I see no reference in the cover
>>> letter to dependencies?
> 
>> The only blocker for this series was the MFD patch, which got picked and
>> it's present in next-20220706 (as you suggested me to resend when things
>> were picked... I decided to wait until they actually landed on -next...)
> 
> Right, I also said I'd need a pull request - if I apply the patches
> without having the MFD bits they depend on in my tree then it will fail
> to build.

I remember writing that to Lee... how do we proceed in this case?
Should we add him to the Cc's of this patch to notify him or..?

P.S.: Sorry, this is the first time that I deal with MFD...
