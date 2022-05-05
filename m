Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0938951C324
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380935AbiEEPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiEEPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:03:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9C5A15F;
        Thu,  5 May 2022 07:59:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A7CF21F458A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651762768;
        bh=Sf7k/0OhMAAsnIEczTQGZSW4QzFAgs4S4sdWB28tCLI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JAYFAOPLuOcHT2NGoHGyAtRuK2Sg0/UD1HLKA8CEtiAdnyt2Ev+IbRuSbTWb4zhOh
         a/VJysDId5WYcUfYdr7HmbAnVOw/pTJkLkhWZwB4aUXqxZiDY4brtTOtc/fTimUePy
         8NN9vpeqgkcSR1ISUt56zn0dJW0w8ItJAfhsyL4VCXXlcSgA9M9Fp/eFSksxnRaxun
         K65YRx+zSa5wyp3B6pXw1toIV7w6tQTmNbzKPriedDekfHmJjM4LPZA80X1PUZHApt
         0/3J96n3qWRD/ncurNnqgwjqdy4hwIWbE+VeX2URuD5M00+lF9375ZRIcysbhCW5vO
         CrTuwLvX8hGKg==
Message-ID: <eb0cd3f6-6248-0494-9a5d-297c2247a4c4@collabora.com>
Date:   Thu, 5 May 2022 16:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND v2] dt-bindings: gce: add the GCE header file for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org
Cc:     jaswinder.singh@linaro.org, matthias.bgg@gmail.com,
        yongqiang.niu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220505034820.12759-1-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220505034820.12759-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/05/22 05:48, Rex-BC Chen ha scritto:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Add the GCE header file to define GCE subsys ids, hardware event ids
> and constants for MT8186.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

