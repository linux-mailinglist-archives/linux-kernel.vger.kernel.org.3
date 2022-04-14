Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67532500C69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiDNLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDNLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:53:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2754BD0;
        Thu, 14 Apr 2022 04:51:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1EEEC1F47996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649937067;
        bh=FQo3+DfDK/439bMdjsIJSbbQW7m+3RsLgRDDfki4H+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YtZBD7RNl720F69+xtlmXyfdDxjpi1ksA1V3yHN1HBA6AEH5w+VeB7DI9ibavjKHp
         ZjGwaDwxN6p4gy8x8MbJRnoAamqkn+diH9XzFHyDYHLNqyUhI5IkEXRuv1V9yIzUDU
         AYKcVdlaGGJYKVZd0ruW3n8o5eHJ/KA0XifmgbWE0Zi+B8mz0QSBmBpFmHyQTnPCGV
         qiWeXeq4ZGX5n+lMeRiDzj4II7gDE09xt+ks3FgMSN1jDl1LJ5P3bgAvEVMRBgwHdA
         5FFEZ0UDm6uyqdjercTqlpjz0C2WX369JjI3QCtFbS/aax9x7MO9bYwmNdz+pG65OE
         re3ANfGXiXIIA==
Message-ID: <ee2f0819-8c9e-4160-c4ae-fb4ad0da3f3b@collabora.com>
Date:   Thu, 14 Apr 2022 13:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 1/2] dt-bindings: Add DT schema for Arm Mali Valhall
 GPU
Content-Language: en-US
To:     Nick Fan <Nick.Fan@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        wenst@chromium.org, linux-arm-kernel@lists.infradead.org
References: <20220414025023.11516-1-Nick.Fan@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220414025023.11516-1-Nick.Fan@mediatek.com>
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

Il 14/04/22 04:50, Nick Fan ha scritto:
> Add devicetree schema for Arm Mali Valhall GPU
> 
> Define a compatible string for the Mali Valhall GPU
> for MediaTek's SoC platform.
> 
> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>

Hello Nick,
Unfortunately, this binding is completely wrong.

First of all, there's no arm,mali-valhall driver upstream - this will be managed
by panfrost later, yes, but right now there's no support.
Then, you're also setting opp-microvolt in a way that will never (or, at least,
not anytime soon) be supported by the upstream driver, as it manages only one
supply for devfreq scaling.

Besides, please don't push bindings that have no upstream driver, especially if
these are for downstream drivers requiring proprietary components, while a
completely open source implementation is in the works.

Regards,
Angelo
