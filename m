Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87AE58B322
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiHFA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHFA4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:56:21 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 17:56:19 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A3D5193E2;
        Fri,  5 Aug 2022 17:56:19 -0700 (PDT)
Received: from [192.168.1.12] (unknown [81.178.197.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 4B54B14020C;
        Sat,  6 Aug 2022 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1659746912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+H8xUW4Rhn35ZgS8r8sBJ9xnI+2jJ+DSyfpo8/CdlE=;
        b=NT6RaTjguEL+pJQ67McqDUL5SQqhI+oZDFYyZemMvLELpD0dByrPhJxSk7JT1zy03FmaHl
        NsZUMu4beG2SAijx1NYPmgiCg+XcZrPpHrE9QjT8F8ZkK7NR2jF7ak5Y3h9vwDggzufQxn
        lC6VKM5PNDNxd/4+oCEyRtAlVyjGa3U=
Message-ID: <a3ea641b-548e-5858-f8e6-0c84966fc97c@postmarketos.org>
Date:   Sat, 6 Aug 2022 01:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/3] Add support for the Pine64 PinePhone Pro phone
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 06/08/2022 00:44, Tom Fitzhenry wrote:
> PinePhone Pro is a RK3399 based phone produced by Pine64.
Please CC phone-devel@vger.kernel.org for phone related patches
> 
> Add a basic DTS for it. This is a working base that will allow myself and
> others to add more nodes.
> 
> Changes since v1:
> * Simplified the DT to a minimal base.
> * Introduced the RK3399-T OPPs.
> 
> Samuel Dionne-Riel (1):
>    arm64: dts: rockchip: Add RK3399-T opp
> 
> Tom Fitzhenry (2):
>    dt-bindings: arm: rockchip: Add PinePhone Pro bindings
>    arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
> 
>   .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../dts/rockchip/rk3399-pinephone-pro.dts     | 385 ++++++++++++++++++
>   .../arm64/boot/dts/rockchip/rk3399-t-opp.dtsi | 118 ++++++
>   4 files changed, 509 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
> 
