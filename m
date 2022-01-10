Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A80489C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiAJPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:49:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiAJPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7104E1F431E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829781;
        bh=bQtHtp6rQ3lVrczXWSfJ3TrGuKi2AAQoQjw5XoFAl9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qb/IblBJ37oy+oFi+9M7w6TDLsIQuzDgY3q8EWfxk2ERM4a8wJyO2loIPa27Bvu24
         fieqJflCOndRwtCPOINxvS+GSSdbDElTkwm6F85z4/+QXCQX3k9PMD+1JMvX3Cu6sM
         tBvkhKKD6FiFSmmL7r67balrdPXOBbfNnWiWSuy+QzJAZWI98uhkaKqvsY0dyWhe40
         DjjsUFR9dp4OvyU2cHaOpqDQZcZL/4cFgVF2R2YfaqOjuFvkVfDs07UZ/atoCTl+r/
         oTccaoursygsC6dJKDcLLr9wwwyQlm788athdTZ3TUBRhsdJfjUKhU2u2ZF40zRnut
         PE1qX+vFZNOvw==
Subject: Re: [v1 12/16] clk: mediatek: Add MT8186 vdecsys clock support
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
 <20220110134416.5191-13-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1d2d5aed-1b4d-2800-85ff-d9a0887d3263@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-13-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 vdec clock controller which provide clock gate
> control for video decoder.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

