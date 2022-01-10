Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFA4895C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbiAJJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:55:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4376 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiAJJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:55:42 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JXTd63hGlz67nSs;
        Mon, 10 Jan 2022 17:52:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 10:55:39 +0100
Received: from localhost (10.47.90.214) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 09:55:38 +0000
Date:   Mon, 10 Jan 2022 09:55:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <20220110095543.00001ac0@Huawei.com>
In-Reply-To: <20220109132311.GA2827@standask-GA-A55M-S2HP>
References: <20220109132311.GA2827@standask-GA-A55M-S2HP>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.214]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 14:23:11 +0100
Stanislav Jakubek <stano.jakubek@gmail.com> wrote:

> Add vendor prefix for Huawei (https://www.huawei.com/en/)

Patch description should say why...  Is there an existing binding
using a huawei vendor prefix?

Thanks,

Jonathan


> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index a13d6a19c2b4..18ffa2d7379f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -515,6 +515,8 @@ patternProperties:
>      description: HannStar Display Co.
>    "^holtek,.*":
>      description: Holtek Semiconductor, Inc.
> +  "^huawei,.*":
> +    description: Huawei Technologies Co., Ltd.
>    "^hugsun,.*":
>      description: Shenzhen Hugsun Technology Co. Ltd.
>    "^hwacom,.*":

