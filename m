Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD71489CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiAJPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:51:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiAJPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:51:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8AB661F43326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829860;
        bh=GPoHOGxFvsmNf1Uu4+iXTElcgTIxXJg4rTHKAgRsMhU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JFeM2BtSdJLoacD4nxHZ1hcRLTzVR6if0JVrDFvG3MjccItMMKFoM0woRfGiVv3IL
         Ud1BpJzrKcMfSVS6ArXyXQ/MnkYC6CGUfLwoCxi5CS1va0zJpDYY6kIhSqsAhpOPJ/
         euZFV0ZP4w0i6eIX8xy+czsxFFFs2Mzs9zZKePbPkzUj5eWYKPJ2xI6ks1sp3Ea8+o
         OEKWI/eI3Quvf3P2deXO6Mn8lyGmgnLOPiX4VdUxgRd6y2xM95fFdl0f9YGrv2qCbx
         xQXM0QcBSSjrR6IViwoqH0BZPx/ijBJ9h1JG7PRLyCEwK64mhZLXaJ6REfbwBIzKFw
         TFZY+hyNPazaQ==
Subject: Re: [v1 04/16] clk: mediatek: Add MT8186 topckgen clock support
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
 <20220110134416.5191-5-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <2e0762b9-aea3-dda2-8d55-b9a2232d676f@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-5-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
