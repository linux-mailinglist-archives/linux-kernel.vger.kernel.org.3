Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92C4F6052
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiDFNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiDFNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:44:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9E6B07F6;
        Wed,  6 Apr 2022 03:51:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5357A1F40EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649242298;
        bh=au3kCGpBvELGj1O6aCEDgSZw3PDmNnTwCgo2ZapgbJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k8lcVf8I9OjzL+Yob0GKMFrCpB3OMWOSdFSJ1vEdCc/3LPY7XhF7g1KGHrHyO7+Je
         akVMl7CsoT5V5aCZINzeQhUH3RmtO9hQyQdMsksPUFuULZiaZVd7i/CI08Yx0999Qc
         uKMhT0MPfHPsCxFNq3wbodLtSinV4mCnKSe+cwWmSz1Bi9RAIMl5ZoguOabgGmDeoM
         W2tiM8+ihWlLanFyMB1oKFA3yGBon14UGi/jwC7d12ikEczIYrXo8dHHsAA2tPDWtP
         zpSLlIDK0j0/ObDa8X5bXKRqjWkuXUbN+HivTzFDsR7F2AgbuzmpX2TksYqkyRS0Na
         bv7dX0vBwdH1Q==
Message-ID: <0e6d110d-0637-2be8-cab0-9d936668fa7b@collabora.com>
Date:   Wed, 6 Apr 2022 12:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] dt-bindings: display: mediatek: Correct disp_aal
 binding for MT8192
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?UTF-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
 <20220406094654.29722-4-rex-bc.chen@mediatek.com>
 <2449070b-d7e1-122f-abe6-4148855a9aba@collabora.com>
 <4ed2dc24d600fa73b91bb411391c98a5bf4f8d8b.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4ed2dc24d600fa73b91bb411391c98a5bf4f8d8b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/04/22 12:48, Rex-BC Chen ha scritto:
> On Wed, 2022-04-06 at 18:40 +0800, AngeloGioacchino Del Regno wrote:
>> Il 06/04/22 11:46, Rex-BC Chen ha scritto:
>>> The driver data for MT8192 is the same with MT8183. Therefore, we
>>> correct it.
>>>
>>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
>> ...though, from what I know, you should also move MT8195 down there!
> 
> Hello Angelo,
> 
> Thanks for your review.
> But for MT8195, disp_aal is using the same compatible with MT8173.
> 
>  From the MT8195 project DTS is using:
> 
> aal0: disp_aal@1c005000 {
> 	compatible = "mediatek,mt8195-disp-aal",
> 		     "mediatek,mt8173-disp-aal";
> 	reg = <0 0x1c005000 0 0x1000>;
> 	interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
> 	power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> 	clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
> 	mediatek,gce-client-reg =
> 		 <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
> };
> 
> BRs,
> Rex
> 

I'm sorry Rex, I've just realized - I was confusing this one with the
8195 gamma binding instead!

Cheers,
Angelo
