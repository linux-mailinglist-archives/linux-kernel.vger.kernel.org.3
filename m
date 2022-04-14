Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03711501CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbiDNUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbiDNUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:39:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DDEBAEF;
        Thu, 14 Apr 2022 13:36:49 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F2EC81F47C45;
        Thu, 14 Apr 2022 21:36:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649968607;
        bh=VfaurAVI7LZtAhAcgIpQXDillMyA92sOQIKlcYKX+w4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bIERMUkxsVha2sBJx7p8apAZ+RcVL3xbBogV2XP9xXlxw7Vao/SANm2Y0aUh4VQGh
         x1eQfNEmKG6bVzf1Hv8Wtn1um3zNg9moE178/DgdiKzPP6u1116FY5uSyWeK6/jQux
         ylvH8cmoWq5p8k7NDAGeEOjFHbD9naoyPGjorRenFxd6Dfwm1xaM4xdrpSKM14d9yC
         ME4uVjrAQ5L5Gtcqt6uXBi9crVZBsYDHpOQM9ErucaoWqhijlecSLlHYDBCmV6jTvj
         nXCCuGwEQxpqz7mSZopDF0v7FVEnfKgMc0H1lafJzpgPEB/LD9L8+VPZAb/i+OzmXA
         WaaTqFHBpqIXw==
Message-ID: <cc6744bc-5e31-3492-1cee-c23e5a60f4f7@collabora.com>
Date:   Thu, 14 Apr 2022 23:36:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v7 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220413094012.13589-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/22 12:40, Ashish Mhetre wrote:
> +static int global_intstatus_to_channel(const struct tegra_mc *mc, u32 status,
> +				       unsigned int *mc_channel)

Add "mc_" prefix
