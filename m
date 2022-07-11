Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686A56FD91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGKJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiGKJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D2B4197;
        Mon, 11 Jul 2022 02:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E1B61137;
        Mon, 11 Jul 2022 09:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C945C34115;
        Mon, 11 Jul 2022 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657531610;
        bh=7ELGCx4LssDb2Kcwavh1jcH+Hm4i0tljTlzVmh5vsYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dHFDA59PDt+xHjRK7XwdiOrO8zkyQezAdkMRONk1ER61ogo+Bd8F+f61sAO3UV+xo
         JPyHyQmsg4KeHaCRsoHVNyCXfEjOTA9LUi4ypBDfLjSF/MLXW40PShhWexXM1QI6nc
         h/Gp/cShPhisplqHVfVBFswdsSEDDKyduUMsAmoI9/5XJEsIYPfXQ+hEs3/1J1or6A
         iZQkCRX4Tx92Xf2MPAW7S+uGF6XEiC5+mPBVZamzLFVPcx+YrUzRKhwJ7RlYPHRb/Z
         AzbIe5xZ8huZpvFYExUsZ0CWfdmSksOleZeOZL9bj4h274WoPAQEKZYkiOdbQS/Hcf
         ujHWTS4s32Xcw==
Message-ID: <5f05d690-0d9d-25f4-29ee-a7b8c05abe95@kernel.org>
Date:   Mon, 11 Jul 2022 11:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/2] dt-bindings: pwm: Document clk based PWM
 controller
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
References: <20220711062330.4923-1-nikita@trvn.ru>
 <20220711062330.4923-2-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220711062330.4923-2-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 08:23, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --

This is not correct marker.  You miss blank line before it and it should
be '---'.

> Changes in v2:
>  - fix the file name.
> Changes in v4:
>  - Use generic node name in the dt bindings example.
> Changes in v5:
>  - make compatible required
> ---

Best regards,
Krzysztof
