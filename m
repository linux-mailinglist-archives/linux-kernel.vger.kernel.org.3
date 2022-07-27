Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D1582126
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiG0HeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiG0HeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:34:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EDBE34;
        Wed, 27 Jul 2022 00:34:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F3C026601ABE;
        Wed, 27 Jul 2022 08:34:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658907249;
        bh=z8qNM7YJGlGgLr5CtAhQT5G31+zHCWFzXU6yj7DoQRw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=obJ1brsK60dsAyiQVGl3tC8c/dqH6jT8h6XczYe+jJWOD5TXjCvZ7k+YZoYPqv2SF
         d9SRts3+EZEmgCfZoMBurFII3X8GYQHMwZPbP/oeCKOdiFisG+7JQOSp+/DDjGlSGt
         YR73wFCosNkFHu3hVCwzTLyssbl+MGtrAtCqAb2YaJ1vX/zs+INb7IjHiEDgbKRgD9
         0NZzqX7wyZmZ6sgi651J0Belo+wY+gZSsf1MK7YHPiY8o13cQ0WKfGp3E+beQqkX4F
         umbSmHt00/x5gdhR0yCu4+gyUZ2tw6mrLUEdNUpfqH2r341YbP37ZP0jjzNV0lCX3M
         /1hF/5A7b7wAA==
Message-ID: <62fa552b-6117-3f76-d3a1-e08a33f287d1@collabora.com>
Date:   Wed, 27 Jul 2022 09:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/7] Input: mt6779-keypad - prepare double keys support
 with calc_row_col
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
 <20220720-mt8183-keypad-v2-4-6d42c357cb76@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720-mt8183-keypad-v2-4-6d42c357cb76@baylibre.com>
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
> The MediaTek keypad can operate in two modes: single key or double key.
> The driver only supports single key mode. In double key mode, the
> row/column calculation based on the key is different.
> 
> Add a calc_row_col function pointer which will be different based on
> single/double key mode.
> 
> No functional change.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

