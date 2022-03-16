Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89A4DAC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354556AbiCPIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiCPIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:41:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66064BC4;
        Wed, 16 Mar 2022 01:39:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1D96D1F42CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647419991;
        bh=OBn2nRrFw1dTirvfKDQG9NVJ8Eqyjie73NtNTXIBhSk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gwiAU68gIl2PnAoSpTZuwVmRdEYHTSoD9eRfwg027X8/0MqBSYwiNvvMt+Cdg7vyp
         nsAu4DPoBSMepTgto63T+yf6RJ5VO3bFGMGwqPgZ9n3mqrpZYb9LsSgQt9G+JenDCt
         cmtrK/hr1jeylxdFMPoa9RN+SI6GZMGDPgkia3BDBA30PwuxkipPMhpU0SQFJJk1/S
         KtZptrEYh0CrYFLZ1X6XDaG4tadT765C2R5JBOLJ9xd8/WO+B252LFLnJMP6we2ZRk
         MGB8hKGcecK/qdDJ3HpU38w9J7/WAPuKXRTCrUVDH4lOH5kOFYzITjvsTBsFc9cEJp
         VR6Bz5tmzsMGQ==
Message-ID: <dfca0eb8-9800-9feb-3608-f29c6333b0ce@collabora.com>
Date:   Wed, 16 Mar 2022 09:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 4/4] dt-bindings: pinctrl: mt8192: Add gpio-line-names
 property
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-5-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315211936.442708-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 22:19, Nícolas F. R. A. Prado ha scritto:
> Add the gpio-line-names optional property to the pinctrl-mt8192 binding
> to prevent dt_binding_check warnings when it is present in the pinctrl
> node in the Devicetree.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

