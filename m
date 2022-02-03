Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DD4A8772
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbiBCPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351763AbiBCPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:15:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B690FC06173D;
        Thu,  3 Feb 2022 07:15:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 762451F45D97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901302;
        bh=TW1aAK4Rx2TvsCWhFDSwUvGsU7fwcqvdmrBfOTdWTGM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cEni7tQNqwQgWMW4WvILu5Oag+MjZ+84GJml47xoUU5wl1TExmuAF1FB9+6pwpTEy
         o8Q0c9AbZGURiFHL6R0SczE0SqsnaA5j+QzmEA1p1ukzsCLEpKSErvDHPf0MZZ5X2z
         X3ybpRIsaiewC2MnO5w+hQO4Kc+IUa774UIEXb5ZaR7OrxSYNOtO6ZZyXVNgpO1r3G
         Sfw6kPm1XOohabEv7LynUurobJM4XA3Sm+QqgLBqiVZMAUGl0A2PbHhumGUr3MIpzU
         nWuAFZf0t4XXJLCGvktD32gtdvfKYZVIVIAAKdHNX+l/hdxTb8svTI29B+dF+wI0jk
         QOst/Ydhf78Kg==
Message-ID: <21030007-f135-58ee-ecfb-8ee0fcfdf155@collabora.com>
Date:   Thu, 3 Feb 2022 16:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11, PATCH 03/19] soc: mediatek: add header for mediatek SIP
 interface
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
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-4-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-4-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> From: Henry Chen <henryc.chen@mediatek.com>
> 
> Add a header to collect SIPs and add one SIP call to initialize power
> management hardware for the SIP interface defined to access the SPM
> handling vcore voltage and ddr rate changes on mt8183 (and most likely
> later socs).
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Signed-off-by: Arvin Wang <arvin.wang@mediatek.com>

Please sign-off this and all the other patches that you send.
