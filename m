Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB1487646
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiAGLLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:11:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39288 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiAGLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:11:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 65FFB1F4612E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641553900;
        bh=m721BsZbFnwbyKTfgTE6FG/GfOsUbk7x/oEzoiDf2p8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GqCxgkc8ru3/o/e+RSltleF5YGSGOijErpc/QDaRcwK6M+3PfMpqIZhusMsFAA7IA
         mbWVKPY166AyxheLsMy2FxMH306niyr3ZC/RrBouMGx5WQwuXFwmUsEJ95S8nObhBE
         cuV3rr2xPhOaFwNay2omUIwUICls36U3tuDv/FiFUOpxtRQJAxLBqWX0jKP4ylO2EA
         1F0RjyzTNjH6VqBHj62+kb/QTWx24Ql4sADV0h9kW22J0OCQQ5o8Q2ppMfMiB675kp
         kZlHs3OHzm16QEMV3pqvRdxCFzBNExf0lgQzNsbJfvlA6nClKpSNO2IebqQqW8E3u9
         l0yiv8lDg2U6A==
Subject: Re: [PATCH v2 1/2] soc: mediatek: pwrap: add pwrap driver for MT8186
 SoC
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220107104633.7500-1-johnson.wang@mediatek.com>
 <20220107104633.7500-2-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <b487865f-086e-9463-a698-82f14c42ff23@collabora.com>
Date:   Fri, 7 Jan 2022 12:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107104633.7500-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 11:46, Johnson Wang ha scritto:
> MT8186 are highly integrated SoC and use PMIC_MT6366 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6366.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

