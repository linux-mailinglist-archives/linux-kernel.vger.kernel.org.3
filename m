Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFC4A8799
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbiBCPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiBCPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:22:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D20C061714;
        Thu,  3 Feb 2022 07:22:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E3ED11F45DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901733;
        bh=p3SA4DH8umb5AGfbl4BOeosHW8FgMfO69DMY9bjzJH8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C1MjGbVAur3D4H5dF7bnrH1fW0f1/OxR9t/qgwowt9z9leT+2LdyrLbyISLgAzsGZ
         4H91w4fZkWLGfW2+dl8v3anufV7L+ZugcsaAXss37C3h6SP5q70Pe/SeWsq3Qq0piN
         FtOJV8jAXHiYZLyLcL+lkXviQmW376IjbYtZDLVRpeBM6bwdh4YS7r/D5NFmvKwov+
         MANzBz2Ryz7lWyMzOWFAv0NZN9c3i47MZX1X/EZoAC/HGwkKcL8JU8Z0R7BYhPIoWD
         0z97lPKXB0mWHvo4U4vukpcXP4oU74vlaQgrtF8rYMJ3t0VDLyM8gP7PHxO/AlUXeP
         0nEI9zlPu6mVw==
Message-ID: <d715e450-5576-f340-28fb-ed770607a15f@collabora.com>
Date:   Thu, 3 Feb 2022 16:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11, PATCH 11/19] dt-bindings: interconnect: add MT8195
 interconnect dt-bindings
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-12-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-12-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> Add interconnect provider dt-bindings for MT8195
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

