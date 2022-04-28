Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A805135D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbiD1N7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347817AbiD1N7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:59:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3C4286ED;
        Thu, 28 Apr 2022 06:55:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2D4CB1F458DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651154151;
        bh=0A+3aw2UPkQ8ovDESnexGar9sBmgEXSnygPWIGyxILc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nP7QpFEAFCOP+N4FdZxDN2KGBkwFF/v4xNXBA6znhP0b3ZBBJbI5sl3Ka1sI4Tn4K
         5moJIeiZC5i16HqKUa53+PYARBHMysSewDEUK4lW/ABsY2PDko+rIH+K4FGmkPWHH6
         s+gfOSnQVvRNnkxxgDtw6X3QDjcsMT6JtBi6io9xfynNpgAiODWURcVpdm99PCLOrC
         9cAajG+1YdXYMUgynsuXy0aGUAlJCK4LPzJIPFdu+c/jfcL1MCQOqQuCY7GDoGlND3
         gpJFmEC521+3Vqfgt/jJizjyLgiHxTsd8FFmMq7pwV4d89OjH3GnDh6IopGSRVwlyI
         31Na9C0j+LiyA==
Message-ID: <2e967249-2735-6bc6-6add-2feeecf6a613@collabora.com>
Date:   Thu, 28 Apr 2022 15:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clk: mediatek: Delete MT8192 msdc gate
Content-Language: en-US
To:     matthias.bgg@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     weiyi.lu@mediatek.com, chun-jie.chen@mediatek.com,
        ikjn@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220422143756.14806-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422143756.14806-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 16:37, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The msdc gate is part of the MMC driver. Delete the not used code.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

This code will never *ever* be used. I agree with removing it for good.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
