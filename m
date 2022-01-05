Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE8484FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiAEJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiAEJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:19:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A7C061784;
        Wed,  5 Jan 2022 01:19:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 94B421F4418B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641374380;
        bh=LtPln65A6ei52Ra5ZjIGNfl8BDcMmtmHYl7VlsiP1xg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WeCznSwpIMye2KpsUdvAVVZNyalPfXKzOTWEV1f9p2m5MTBnUQpbcTbNoekHCpHHM
         maA+JfSIrPNCU6lJwoiaOeFaADAkUuKf4JmcsHWk1zNSQaimunp7ih5W7fC4fzdiAo
         Jbyac8O5RNycRom9gONqtTWkkI1307pWNXGAmhdoQHkBfDi2tLRcVNXIp6q00D7koP
         65Hs6Xz10Jm3hBcxbGk/FnjErk7WEvqyfVFqzqoX1E4zqik6Ir6kjQtAY3mzXxMKHm
         2MpYcYS7WF0fgawmnBeyTWCQeyBY0k7MZCoTuM1SyLJkEzAbbNtgNOIwP9EpiP/mvw
         1qaz/05d5OO/A==
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Support mt8186 scp
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220104114706.27461-1-allen-kh.cheng@mediatek.com>
 <20220104114706.27461-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <5722750a-dc1a-3242-6371-90236b98d07b@collabora.com>
Date:   Wed, 5 Jan 2022 10:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220104114706.27461-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/01/22 12:47, allen-kh.cheng ha scritto:
> Add SCP support for mt8186
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
