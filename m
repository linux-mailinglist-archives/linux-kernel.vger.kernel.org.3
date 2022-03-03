Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB324CBA50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCCJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiCCJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:32:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550E16F951;
        Thu,  3 Mar 2022 01:31:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 94AC71F45394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646299903;
        bh=7BamnJwMgtqrT3JoQ68Ebed6Mw0Z4qhgq17wKkO7uZQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DsKwhWmYCfBFjIrDoWzkxPNJKmtBbRcsgc1JMZx9lfNHbf04n0AFN6jYOU5/79Sgw
         nyvDJ6M5EkqPGymiwkWb9kne6FdPEpfJ7vttPbObbeF56henBC6oGc/RTdSSjfFW6+
         VC8zJrNU1oQ4UK0ECsXCpbxrdqn7cMaBEEa6/oHh5jqH6bCErPARX3ha6Zno76b3E+
         mVHxV/HiSCkOtzQ38z1XM+GaVwYW7hIpmZE01VSoCluMtv/2M2vCwEAIzg0+8JiSmH
         crxIXXQ4Kl6XsDKLzr6kxkK6ds2BQl0YGHLhGRoZPLryIOwv7sDw2menm+j746SUHW
         LfIys7ju/p13w==
Message-ID: <28098efc-1de1-b540-b1a3-bf7a92af9511@collabora.com>
Date:   Thu, 3 Mar 2022 10:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 00/12] Add Mediatek Soc DRM (vdosys0) support for
 mt8195
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Jitao shi <jitao.shi@mediatek.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com>
 <CAL_Jsq+6k5EqouAO2Xm=GpBz3Pi-wfB-ixGwfyC+Y+qOrjUFTg@mail.gmail.com>
 <c103927d7dbc3217431c83dc22a44c656c561228.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c103927d7dbc3217431c83dc22a44c656c561228.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/03/22 05:25, Jason-JH Lin ha scritto:
> Hi Rob,
> 
> Thanks for the reviews.
> 
> On Wed, 2022-03-02 at 17:50 -0600, Rob Herring wrote:
>> On Wed, Jan 26, 2022 at 1:19 AM jason-jh.lin <
>> jason-jh.lin@mediatek.com> wrote:
>>>
> 
> [snip]
> 

Hello Rob, Jason-JH,

I have just crafted a patch that fixes everything mentioned here,
if it's easier like this, I can either send it for the maintainer(s)
to apply on top, or squash in Jason-JH's original patch.

If you'd like to get my patch, though, I have one question:
this is touching literally all of the YAML files that Jason-JH is
introducing, so, should I send this as one patch per file (which would be
something around 16 patches) or is just one fixing them all fine?

Cheers,
Angelo
