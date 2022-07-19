Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF15794B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiGSH6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiGSH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:57:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0FE31DDE;
        Tue, 19 Jul 2022 00:57:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F22E366019EC;
        Tue, 19 Jul 2022 08:57:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658217466;
        bh=nji9qQO/Fe2O7nOAQY8VO3ZafgMoj4sz1HhYEJVZAdc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ix8B24hH/TZI+YEepZqG05xijSJuRWOhrlSEX0WY4I3lJdsjFh1eEHKyftYjvPiPB
         /6Yu9riUXYes7hcmonRoEMV7YX2CMSP4YLVsy8pqWs7EagsVHAKd7G+lrV3n1SX9tr
         DRZFEuvuYYro2MpOuWRYPPfHCxo/fklVffK8hgTrgpQZtih7zTSgbkH28aEbWtSuEf
         6Yz3pAXouf3ILg8LN1P331ibvFHYAJZpBljZnCfFlDritTt+mKhf9OGutCAu5nLxrz
         YBoeRUTkSkS2K9QQa14SLvasvprvi/mhzBmMylNg6TP668V92PDkG88XCd4UcfCFEO
         ovDLCLcCoa2vA==
Message-ID: <26dc9eac-752d-4357-a793-be16554dcff6@collabora.com>
Date:   Tue, 19 Jul 2022 09:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: power: mediatek: Update example to use
 phandle to syscon
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
 <20220711122503.286743-3-angelogioacchino.delregno@collabora.com>
 <20220718180654.GA3260460-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220718180654.GA3260460-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/22 20:06, Rob Herring ha scritto:
> On Mon, Jul 11, 2022 at 02:25:02PM +0200, AngeloGioacchino Del Regno wrote:
>> The preferred way of declaring this node is by using a phandle to
>> syscon: update the example to reflect that.
> 
> Preferred by who? Not me.
>   
> What problem are you trying to solve? Better be a good reason for
> breaking compatibility.
> 
> 

Hello Rob,

I've produced this series after a misunderstanding with Krzysztof (entirely my
bad!), then the discussion [1] went on and I'm handing it to MediaTek to resolve.

Please ignore this series.


[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220704100028.19932-9-tinghan.shen@mediatek.com/

Regards,
Angelo

