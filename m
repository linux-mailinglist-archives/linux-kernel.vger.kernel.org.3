Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7E5693A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiGFUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiGFUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:52:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47A1CB1D;
        Wed,  6 Jul 2022 13:52:46 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5DFC66019A9;
        Wed,  6 Jul 2022 21:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657140765;
        bh=plFfInWaF2jQzdSTym9IBrTK4gHtJFiLIaSgAP0rW5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TSyP7iVStBzIx18dwKvtCyZtx9VysYN+PtKQAWJ4T6zlCCnSi5NjRZAw3znj/Yk+y
         pt/mAjdcaKXdn9Rihd0+wsNOZLEGD8hln6wO6S7e3e/oi8WJkMCu5Dqg5MhD4EsXCz
         dscnYA5fYBemHlVlLV5zqHUCo1zHNK5S5S7yxN//zdyfGCQj6P2Ymq6jxu4NbLoiph
         8kk9JlmJDSPDmQguHoIywkOHtIOMM7aZUF/Q8Rel9tXv0V6QRKypBpPGBobBCXSZml
         aG1K8OJ3iy/yQTxmcU7KAtrWZWampuIhHxDmkmpvvJTH+G/G9dDc1uXvphcJFqGzYN
         o5ZbJ2RrG9MhQ==
Message-ID: <d8dc8a62-93b8-618e-ff18-dd85c8e75464@collabora.com>
Date:   Wed, 6 Jul 2022 23:52:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, kernel test robot <lkp@intel.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
 <20220615135130.227236-3-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220615135130.227236-3-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 16:51, Shreeya Patel wrote:
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata;
> +	u64 lux, div;
> +
> +	ltrf216a_set_power_state(data, true);

All the power-on errors should be handled.

-- 
Best regards,
Dmitry
