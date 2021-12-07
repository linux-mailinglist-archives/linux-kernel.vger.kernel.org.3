Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21FD46BBA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhLGMv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:51:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLGMv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:51:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 167A0B817A2;
        Tue,  7 Dec 2021 12:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9956CC341C6;
        Tue,  7 Dec 2021 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881274;
        bh=FipYZVN6opgkJyf2yaMQFgLB9XPA2FAttOydyqD8x6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rkUyLQgyfaB3QXijxmpvfxVS5a/eWaNbeLldZ2j1nRN864yONm0UI/3oxNKEk0VlC
         Uk1i2rKW0iCacDZzP988P25tDjZEn77aLOdhqNn5am+0+CnMHQzFdcrPiGYYvuoz5i
         elhJQdprxinIKIE7VlIHuEcP50n9TBYYkbWJfynGiHrC5fgQaEDeKPu8tHs1TdWbzx
         frVVdOLDtfDnvO4RVv7UBL/tkuvnR3hqfX5qc2lXF0KOa62soWajTQN+9mx+sJ5eNz
         dRvxLTOVYu/FzsMyOdYmu7xGiiWl8tXPgORf8sfFWb470eTP8yxb4+Vs7mSNAAjgfa
         UthZ820cAgmWg==
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
To:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211206174209.2297565-1-robh@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <e3eb7ba9-d333-31ed-285f-ef528ff0aa09@kernel.org>
Date:   Tue, 7 Dec 2021 14:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206174209.2297565-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2021 19:42, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
> 
> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)
> 
> Add the missing definition for 'rb-gpios'.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
