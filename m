Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35A509D64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356588AbiDUKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiDUKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:19:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914922124C;
        Thu, 21 Apr 2022 03:17:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 88BB01F454B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650536224;
        bh=zcUtTncErR4CRvVEtBbI5bdyvkZNw/1895mBvZxu+JQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CLFJ2OQnTmpOPkI+qfEMxYHQDG2qMiFXKFgHDWUlhxd2XxxK4NJg8TA8vN6gZvAh9
         vgtYY0masQEDdTj21MnpGPTsjYb8l3PCPFLFWjWR6fG1hG50jyKEVdbH6wXy2qLPX6
         1OuMLPVdKV8FbJBp7GtEv47mehCQVEO8SYxQ3l8GiDF0gwasPxg9Sk0U+jydpJnPqH
         RQA3wS/mk3iGfVQAFLcoV4EhM1Bm9WkeUquB/4KNFhYqNV3D4r8WtQ+BfmeaESh6nC
         EQAjHj44UaAfK3fn7oGl4Ker3MjhBdUp9C36/knC0+1poRtS2izIoQMdqQbnSe9jrX
         a8A7NGNv9x5vg==
Message-ID: <a92d3b46-ace4-2d19-fef9-c59cd1a596ce@collabora.com>
Date:   Thu, 21 Apr 2022 12:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6, 5/5] dt-bindings: pwm: Add interrupts property for
 MediaTek MT8192
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
 <1650284456-16407-6-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1650284456-16407-6-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/04/22 14:20, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add interrupts property of pwm for MediaTek MT8192 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Hello Xinlei,
the pwm-mtk-disp.c driver does not support interrupts.

Please add interrupts support to the driver first, and only then
add that in the dt-bindings.

Regards,
Angelo

