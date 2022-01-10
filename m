Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F3489C98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiAJPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:49:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiAJPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 246B81F431F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829762;
        bh=UZ86+qtGAZmijY1SJYcDI8C4rEH6l/3FZjTvPIYKrgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H3ids2JuC8ijokX+7+E1n7WgzF5xF70ND1OZ+WN39szw6CaHM+dtNIGdPbe3Hag/L
         SPnxY302NidxgfMBv6lzwPPMfhxyyznI+l0S8ffbj7doxPa7Ml6LAcdnZn5a/qYMds
         V4/eyC4MszEMBDM6XaiVf+QVnw/8g2cLEjT622rs0Ja5uciI0TsNCnm9R1RD864lWT
         pjRswKbclokvF0J3LyteoOdK9yEa96V5ZHUUn9aEACzGa6RgircCyTl0n6FgRgEc7M
         RnqcuLwb2qtlyVdKsiQDddxUUmWoSzoc1FM3bBCyaTIQ79wR37RbQGCvvP9FQMuNyB
         PCHFBXdtopmUQ==
Subject: Re: [v1 14/16] clk: mediatek: Add MT8186 camsys clock support
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
 <20220110134416.5191-15-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <271644d2-e2e6-977f-c7da-173f072a3ce8@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-15-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 camsys clock controllers which provide clock gate
> control for camera IP blocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

