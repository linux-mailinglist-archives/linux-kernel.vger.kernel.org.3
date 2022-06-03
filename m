Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31DA53C7B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiFCJiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiFCJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:38:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CE3A5EB;
        Fri,  3 Jun 2022 02:38:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id F13D41F45735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654249120;
        bh=JF0dKCc0L02G1KVh5HkaPXlohcDSdspKEYOdcEvE2V4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y5/SkoioXO8xg+2/iOPIiepGG/cYoQYDxYue3HE6KQKKMuXHIu9pNFuMO8o9hq+6N
         2VHJgXFvUfVygfE0xCBRQz4Jo3tBhxhCcyLr0iPtPhqIitY78zHs43S4iIF8d6MeTI
         lpTQBijFmnrNRZqS2jBAoE34jH2hSgufcjnghp4fPhVtpEmAmC4E/L+A0AAgrW+v6X
         jnTSHUP11TQnExnEKo5p78D3WtvFbGfuBIe+0Pv+Dy3tn2IVEzjVQtzTE4x5x3b7SL
         TPG3HoW1Euc4fUlfsmKKRJ0K+WVMMAhDAJ9+2jQ1o9WiyC3c8YBdtcLX+Ez7RgOawh
         S/mtlXQYMNldg==
Message-ID: <930f3721-ab1e-4bab-de1e-eaf83982e3ea@collabora.com>
Date:   Fri, 3 Jun 2022 12:38:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 00/13] Host1x support on Tegra234
Content-Language: en-US
To:     cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220516100213.1536571-1-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 13:02, cyndis@kapsi.fi wrote:
> Hi all,
> 
> This series adds support for Host1x and VIC on the recently released
> Tegra234 (Orin) SoC. It's split into the following parts:
> 
> * Device tree binding updates
> * Cleanup in host1x driver
> * Add programming of new registers and old registers that now need to
>   be programmed to a non-reset value
> * Tegra234 device data and headers
> * Rewrite of the job opcode sequence, and related patches to
>   support MLOCKs on Tegra186+.
> 
> The rewrite of the job opcode sequence brings Tegra186, Tegra194 and
> Tegra234 support to a 'full-featured' status that is necessary to
> support all host1x features in the future. This should not have any
> impact on older SoCs.
> 
> This series should be applied on top of the Host1x context isolation
> series.
> 
> Tested on Jetson AGX Xavier and Jetson AGX Orin.

The code looks okay at a quick glance. Please rebase the patches on top
of latest -next. Perhaps won't hurt to merge all the related patchsets
into a single series for 5.20.

-- 
Best regards,
Dmitry
