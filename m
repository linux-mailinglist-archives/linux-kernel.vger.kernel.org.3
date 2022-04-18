Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B396504F52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiDRLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiDRLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:22:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21EA5FC2;
        Mon, 18 Apr 2022 04:19:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 83AF61F43CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650280795;
        bh=dpfrdiNYaOj1p/lHwcZN/9PErF3xYaW4kVudBzK29JI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BuZ325OYqr3Dz51xq7jFBKwIEheuTGL0p2u7KYbkYy4p7lCjrvgtfG5vEMqjLjCFb
         t6AHF4eF9tIuk3HEso5etXRXdnQFu0leZNBlXXmyS7EEZcjjSvB+fcjMaAmpctIkGk
         FiANXV+Rkn3sRWia13BNBe51BLEW2Mp0nsSB22D9vOV7p5RDIT+UwMMf009xAlxiiE
         jmpuDgvwmgd88bNXlUnhswfzk0WUr/lz53FfD3RRzz/51VHZTUDjwVU28vRsuiKp67
         vjxmp015P06iYqUVTB9X0WbM4e7SAX7e/WpFDTP/2/k0dPf5e6JodOv/VvLT8QdqF0
         jXh8u3LBbz/Xg==
Message-ID: <f4deb182-ec18-6744-2c4c-adaed4ef7a33@collabora.com>
Date:   Mon, 18 Apr 2022 14:19:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220414214337.311880-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220414214337.311880-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 4/15/22 00:43, Linus Walleij wrote:
> The Broadcom BCM4751 family of (A-)GPS chips have been around for
> some years. The latest iteration BCM4753 is for example mounted
> on the Huawei HiKey970.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/gnss/brcm,bcm4751.yaml           | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml

What are the chances of seeing the kernel driver for BCM4751+? There are
myriads of Android devices using that GPS chip. Previously the
proprietary firmware interface of BCM4751 was an obstacle for addition
of the driver to upstream kernel, did anything change?
