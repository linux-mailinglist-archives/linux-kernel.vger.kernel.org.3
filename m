Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FB4756D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhLOKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:48:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhLOKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:48:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5A59D1F44248
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639565290; bh=/q/kjkgul5wMQm4dm++HudFeeAybi+3zwNwCfM/2sUk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DGxqFQLkCebVwP6VefxMPW/TwdGu4BQEpkbtwgF+zshNg0irDAfOjnZQN/JLh3q9L
         VjVcV9MyufugN+ij72CJjSqtTdCUpT4jAtCv3lxw+xFKo6fEo++rvlQVh2AUIiGRJd
         1Xy9mO7VyXt5ZGNhkNojt3XxGfwN+PvX7MoJj2ocKD4PukKwQe06Aplx+uj+/XxaQJ
         jTmOUQsnFS+H0iLJ2OPzItFsVN6zoDrNOoTqx6MgC11Geb4yFHV9KJgGNWW8NgBDly
         ahMB+ZAlBLclW+ycbePjIkFcF2XoRjv+xOy2jwi2Zx/0See08bnHw9AL8NtGk2QfsX
         xw6II2cXbKSPQ==
Subject: Re: [PATCH v14, 00/19] Support multi hardware decode using
 of_platform_populate
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211215061552.8523-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <de90218e-95b1-63f0-ab92-07a0386a1058@collabora.com>
Date:   Wed, 15 Dec 2021 11:48:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211215061552.8523-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/12/21 07:15, Yunfei Dong ha scritto:
> This series adds support for multi hardware decode into mtk-vcodec, by first adding use
> of_platform_populate to manage each hardware information: interrupt, clock, register
> bases and power. Secondly add core work queue to deal with core hardware message,
> at the same time, add msg queue for different hardware share messages. Lastly, the
> architecture of different specs are not the same, using specs type to separate them.
> 
> This series has been tested with both MT8183 and MT8173. Decoding was working for both chips.
> 
> Patches 1~3 rewrite get register bases and power on/off interface.
> Patches 4 export decoder pm interfaces.
> Patches 5 add to support 8192.
> Patch 6 support multi hardware.
> Patch 7 separate video encoder and decoder document
> Patch 8-17 add interfaces to support core hardware.
> Patch 18-19 remove mtk_vcodec_release_dec/enc_pm interfaces.

Hello Yunfei,
this series does not apply cleanly on the current linux-next tree.

Can you please rebase?

Thanks,
- Angelo
