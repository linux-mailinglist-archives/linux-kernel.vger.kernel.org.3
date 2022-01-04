Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A9484552
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiADPxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:53:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiADPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:53:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E2BED1F43357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311619;
        bh=s0q2aXCgVOP1TMeaYn3L28dPxxpJ9P6lgrqbXsCq3gQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RCXJrAw3yxSFeCMUvtUGFPsbe+sXWzGQLCxu1pfl+rJXmeoLgDW3MXd9JfV++I1fZ
         eewyegId5i42KbDdiEFfBp26+Ukr0Aq0FcMMFD1lXXIIlWdx+EWiyYZaa45XVzJQSL
         ybptmCdwAIgcc5kJ9IVzie8EmsKK1C23JdhW6eXLDzGWZHQX8MJuq4f7895vpmfQ+t
         M1l9rbOE6o9YqSbM/nbihp/8wHeD9w3WNv2dasqzO8hQVLItfXkFmXjyxW2YXCWb2H
         uSaiV6Vp+JvPzFmc1JdTTtsDwVRwvaQowiHWIVm/M0oENI85bSlZ5wV4iEjiBTg5pI
         Pss4FCpBk5Npw==
Subject: Re: [PATCH v3 25/33] iommu/mediatek: Just move code position in
 hw_init
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-26-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4186725d-07ab-07c1-6c58-7b496fa02225@collabora.com>
Date:   Tue, 4 Jan 2022 16:53:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-26-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> No functional change too, prepare for mt8195 IOMMU support bank functions.
> Some global control settings are in bank0 while the other banks have
> their bank independent setting. Here only move the global control
> settings and the independent registers together.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

