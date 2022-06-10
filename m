Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A205463FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiFJKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiFJKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:40:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE51E1742;
        Fri, 10 Jun 2022 03:36:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5164660173B;
        Fri, 10 Jun 2022 11:36:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654857371;
        bh=6OggYDKQ1eAP67H4OaNuo5vXemfJO8Li0A8ayz8MhX8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TSe8jo/qy0zUN37jJh7l259Bj3VizHyPXPNUzkSKwE50FhoDDH7hDyg9kB1/qTnhL
         rA1sE2He+54HrI2SVqxWN1JqtprCbAvrj24uBkBlCDkXKs4m7Bc8UV3V7+6x6mDdyD
         EMSBU6IbRyPp4G2Eefnj+W6Yf9BoToupwmV7m9d5v1uUNvo9Cy6fVT80z/Gb1b4i7g
         BE4F+RvAKY1/qIAhYKZUu69bnOClN0fTXq82AjdD634nyt5z/C+jaXQjSaGt/Wczst
         glpo4A0yKPb/yqOBhVSDZM3MgBJjAc9gs8ZKC7gFO0+4WqPvIchQZtz1pAv8NqZEli
         mzEyZ9eTYL0Dg==
Message-ID: <95c186fe-3d23-f1db-a468-e51bfc27d046@collabora.com>
Date:   Fri, 10 Jun 2022 12:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] usb: mtu3: implement udc_async_callbacks of gadget
 operation
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220609074233.15532-1-chunfeng.yun@mediatek.com>
 <20220609074233.15532-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609074233.15532-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/22 09:42, Chunfeng Yun ha scritto:
> Implement udc_async_callbacks hook function to avoid a race when unnbinding
> gadget drivers, refer to:
> 7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

