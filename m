Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210555693BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiGFU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:59:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5713FAA;
        Wed,  6 Jul 2022 13:59:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E917866019AA;
        Wed,  6 Jul 2022 21:59:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657141145;
        bh=H/HG1e/569OaTdx0xbD3L+HJ2G9cbLOSEVZ97mKSIe8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LagYYZfOTkqzm1LQV6e+CoS9Fa0hDGYBBLMwfwL9n7k3pw2FOj5wfDhYZgteyXEkD
         lnG0uSrlqhRn44kFgcomKnWD3sWjYwbC9yfIhX4GLNdmA/pjuWlN40zgG4XQitz8QC
         ngWO0IzX8hQNjCgdQaIueo0jYAzBIsRfANakjSq1LjM3qEKo9hKAon/An6u9DyubSb
         xeqPfaJ/h7jl0tbdQM5FjdwqiGeC9JDZLxfUotM/eT6fTF2yGCn0pDTl0M81WpM7xs
         RG5dq/cRwtmvoxjDINMSgduKAlTHQUcVBOooXuMESwZzKjf9l9RYeuU6z4cZ3uHs4p
         NGFmpbn906S2g==
Message-ID: <49dc9958-7fa3-5150-bf4c-559c5f4cdc70@collabora.com>
Date:   Wed, 6 Jul 2022 23:59:02 +0300
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
> +static DEFINE_SIMPLE_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
> +				ltrf216a_runtime_resume);

static DEFINE_RUNTIME_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
				 ltrf216a_runtime_resume, NULL);

-- 
Best regards,
Dmitry
