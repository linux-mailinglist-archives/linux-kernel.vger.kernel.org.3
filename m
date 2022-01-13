Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53D148DB59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiAMQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiAMQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:08:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3770C06161C;
        Thu, 13 Jan 2022 08:08:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 13F0D1F45F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642090102;
        bh=l3KQagUbPX/8dzNwAMFTYGee4gg0II9hxQ4x9DR7EoE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GnjZckDdctWoJBFgGNo/PN5SHoTo9YfL+UIkB+P3xJUbETQYy9bLJuuFFrtsrprIH
         fOXmTIIIAjoHQasumgAlWqfHcHMylJ39u7mvEJB+86e+zL3arKTLBrnyEAWO7ihZcz
         fLTHjhdQWG0zJryg3CfiOy1D5ahLZs0mXHeaf8ker6GVECqk74GSijWtEnVn8Io2q7
         NF02Sbt8GLEonsFNCfYZpRungxh8CVeGKOpoKAnQPw7Do2rU2kSkf5ndHDHDs8c6tq
         qQsAdPwoZoAo8W8o3zWcSZpzqFsyZXr2y+bx3RCrnXpdIuMrcur48FkCILUMjvMlrO
         zelsp8mcAtrvQ==
Subject: Re: [PATCH v11 06/22] soc: mediatek: add mtk-mmsys config API for
 mt8195 vdosys1
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20220110084645.31191-1-nancy.lin@mediatek.com>
 <20220110084645.31191-7-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <0ce9149b-f2ee-ef59-12a1-ff7bc5cb4978@collabora.com>
Date:   Thu, 13 Jan 2022 17:08:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084645.31191-7-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:46, Nancy.Lin ha scritto:
> Add mmsys config API. The config API is used for config mmsys reg.
> Some mmsys regs need to be setting according to the HW engine binding
> to the mmsys simultaneously.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

