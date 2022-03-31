Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C004EDB13
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiCaOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbiCaOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:05:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FA5A165;
        Thu, 31 Mar 2022 07:04:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CB68B1F468F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648735439;
        bh=fy1+tUPoPcfNztYimOdywPSnGkPWW1wOSSxIBddwBMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fcy9oxZuRcaE2Du88OXSRaLsSYrgbXGi1xhLjwvbeSaDdEkjq5OAo0IxZ62G53HpV
         A7PvowXg2nFGtVmaE/bXeK95t6J1CxpH6p8aRYmC5PnOMJk2VzdPjEysFI1Tu5KkiV
         fG7+D/ujjUYeEPKDFhYjUHIMvybGnXhJ4VjEF1BGJ9/Qj2G2dZTbZ5b8LYvTwZBFPd
         ze9QZq5VNtNS0Q/zayrS1TNfiBMFPZgeadEaZtIhQyhq0k/Ub4DqKG2WDQMdhwd9TG
         /m0qqVssG6trma9b0dk4On0DQuecu6Xp9ZK43MvmBrzcre9nGbcaLBvrpMYyME+LBv
         yyCK30O6TVRMA==
Message-ID: <bd7c2c10-aacb-1d7f-7f60-71265ab80fe1@collabora.com>
Date:   Thu, 31 Mar 2022 16:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5, 1/4] dt-bindings: pwm: Convert pwm-mtk-disp.txt to
 mediatek, pwm-disp.yaml format
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        rex-bc.chen@mediatek.com, jitao.shi@mediatek.com
References: <1648730873-18505-1-git-send-email-xinlei.lee@mediatek.com>
 <1648730873-18505-2-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1648730873-18505-2-git-send-email-xinlei.lee@mediatek.com>
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

Il 31/03/22 14:47, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format as suggested by maintainer
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
