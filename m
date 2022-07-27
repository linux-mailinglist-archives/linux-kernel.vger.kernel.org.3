Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D5582129
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiG0Heb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiG0He2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:34:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DD422CC;
        Wed, 27 Jul 2022 00:34:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D2CA6601ABE;
        Wed, 27 Jul 2022 08:34:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658907267;
        bh=6ps4uQowS8HpISETXvtaiicTxwDeXzdtMPrNeVaDsvk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ToEX/wUgUB/m4F2DIP7ruKo6y+qjdkYa3nKiNumxyrfxYQSnZRpIz57UFxXNkTLv5
         v50V4KAS4HbXimDKUYXObvJj6LL8dZ9oJjvbuDppd7NCUxdNqEdcvjqaVaPyUwJBhN
         UMTLo7HkUIKVdTAhY+eEO+wlI5NTIy5vPMb+ZsowOCqcP9mz7KqIb5snaUuKekZHD8
         3fFhkvQsKj72T1eQ/tDhsD8IiKZcCW7Z2X70QNpxh6ZSu6TbZMzYm4d8CIhhTKaeI8
         mirvQmENKSZujpqyBvi22L7EDKvF/Fbo1sC7eOMcjp+mQmhkgSUhNcCDWxbm85GTTj
         4rB8vRSImBbaw==
Message-ID: <47f90532-c115-61ad-1203-5658430b6a7a@collabora.com>
Date:   Wed, 27 Jul 2022 09:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/7] Input: mt6779-keypad - support double keys matrix
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
 <20220720-mt8183-keypad-v2-5-6d42c357cb76@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720-mt8183-keypad-v2-5-6d42c357cb76@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 14:56, Mattijs Korpershoek ha scritto:
> MediaTek keypad has 2 modes of detecting key events:
> - single key: each (row, column) can detect one key
> - double key: each (row, column) is a group of 2 keys
> 
> Double key support exists to minimize cost, since it reduces the number
> of pins required for physical keys.
> 
> Double key is configured by setting BIT(0) of the KP_SEL register.
> 
> Enable double key matrix support based on the mediatek,keys-per-group
> device tree property.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

