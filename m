Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAF489CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiAJPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38588 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiAJPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D037D1F43326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829852;
        bh=wR16xay4clvUBA/3f26Kgxsmj370GLNzt5+k3MOOQxM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SVghEG/V39naq/7hZY+Uh2KslIPINLj/HLXmKPUPKicbjY5/BBBcdVQlTfjavoNfA
         +Y8bNkXd8KxN+vZRLN4omf/xEAAXJzahzHnaz4MNXVL4rvq2cldfr8bG6eVg4T5blW
         bpoOb0TiEuBh390QCo91wibiIo6ZNVvIj2iwUhAk7C6yHzAbnkoHAK8qL1TdPhOKLW
         6Z14ptPWWqlZQmDL39k5Weuzn+No2RWNrB5jQHVnhBy70pEOxGLoWbXl34gOwYpJQM
         jTsArLlji83IuZjOhy+Ca8vrzVrtBYbsIb2I+z2GyiuAPeD8e0zVPQbzHaQNJ97Qql
         ZHyUO8DRcqlwA==
Subject: Re: [v1 05/16] clk: mediatek: Add MT8186 infrastructure clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
 <20220110134416.5191-6-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <993b0a1b-c78f-2a50-a9e8-fc4ba639b25c@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-6-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
