Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD248E851
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiANK0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:26:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56214 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiANK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:26:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5BCAA1F467BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642156012;
        bh=ZdfY1zj9C2TGhgJieZuhRhmOO2BT0XTecNLWjVgIDhk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iEA9mhmBCN2ODbd4i1vVhLACQxD0kyMi83DOusKoPco3mx4shRD1K7WyeAj50Nvwn
         PPzsPuUNVjLTWfYFaHhoIfInTtk4m7Lh90LWtX3qRf31SGnPG9JX+3peh5XilBqdyb
         Go32UMtdMbDUZat6uX5usOCeoGk949V13aQvLNNWdOSA17dpfenwICr9TzC2gBK9kv
         6SOaTrQ2k1fYgHeMsH5d2JHLGzxoXkBqJn8GV8SQyVCu2j5tmwAio2NFQeGYCWAeAK
         0JmJsPi4amO06tJETv+TvpDn9B29jPBGcxelg/dhjvFMp22ROkp0WbS2/YfNAUJf9L
         GEp+YLlMc1yzg==
Subject: Re: [PATCH] media: mtk-mdp: Remove redundant 'flush_workqueue()'
 calls
To:     Xu Wang <vulab@iscas.ac.cn>, minghsiu.tsai@mediatek.com,
        houlong.wei@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220114082214.41817-1-vulab@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d838768d-6f85-4977-d014-d5f85ae7126f@collabora.com>
Date:   Fri, 14 Jan 2022 11:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220114082214.41817-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 09:22, Xu Wang ha scritto:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

