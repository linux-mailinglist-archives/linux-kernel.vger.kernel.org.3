Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E5489CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiAJPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiAJPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B61D41F4331A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829823;
        bh=jYjbYZqGbt7EhiiaCeQztUBOWoiWqy/ulQcO01YneEE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GyGepuYMFEmnWLgVjnu0VxduBNvOP7EOFw+I9mTa7JlvfdYWLDudW+SMTnnkCqmoU
         fXW5JxTi2a9Tcossr4NhulLEDq/ADvDlY4a7PKFi8xYwpi3eebRSnSNQFpPXI8VRqx
         rJQje1vqjfm6LwEPCJvng2oPOvMu2Nq9bn7IrcvJvhKW8el2F7yu1oPDlEj8AANVG9
         De2xqxekk4Vv3CsLx4fwyG85H0l1BlA0WDLhW3y50rz/S8W4XYDNyk55k8hdnCI1xW
         AVlS1wJCH/F7JnD5kI4xEdHwwS8zSx7ZbHrEsZvstq1q2xjdBxZEjVkynJjNeT6uVc
         BCzatk6HqrWRg==
Subject: Re: [v1 08/16] clk: mediatek: Add MT8186 mfgsys clock support
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
 <20220110134416.5191-9-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <7781382e-023d-89d2-50a2-37b9711889fe@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-9-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 mfg clock controller which provides clock gate
> control for GPU.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

