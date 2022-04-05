Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE34F4938
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391597AbiDEWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377826AbiDELap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:30:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C3104A70;
        Tue,  5 Apr 2022 03:53:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C6CB91F447BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649155990;
        bh=vbpJujH4YJwR8KBxqqHpYpR3xjSW2I3+dKENzMhmXpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bQgisYcudgfxXVLV96zJHCYHmmfrOLvV61ygGV9/Id5oj1HIMKiMolrGD7QiXlr2I
         1JbjfvjB7eFW0kt2Zz3zuF08/KywQlzbF56SqgyfmuwVaA+UAJ4tCbzzyR2uSUsaKv
         pv+2iDrUpBwgxBo1xxrmf5ZkRjRiEWaD2VQiAhH6EMEI6s6SJHMyKLXoL8SZl9P+W3
         BPbwDERjNXU2OjAVBoraV3ETk8Elk4b2oUz3x32Bcr6i6ynrdKtlklxAw+8w6qZPkC
         H4vMOt585NWWGN5hqp7q7XZI4h0PzKBxYwggt5UDYVHGLvutWdHDrU+CWygNlRydB7
         HvpY8alUliJiw==
Message-ID: <c67bd1e5-19c9-55b3-5b79-e2e6ca0257f5@collabora.com>
Date:   Tue, 5 Apr 2022 12:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/3] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
Content-Language: en-US
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>,
        Yu-Chia Chang <ethan.chang@mediatek.com>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
 <20210617114707.10618-3-ben.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210617114707.10618-3-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/06/21 13:47, Ben Tseng ha scritto:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC and register the maximum temperature
> of sensors and each sensor as a thermal zone.
> 
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>

Hello Ben,

are you still interested in upstreaming this driver?

Having thermal sensors is pretty much important to avoid damaging
the hardware, and MT8195 is being actively upstreamed right now.
Reading thermals is a must.

Regards,
Angelo
