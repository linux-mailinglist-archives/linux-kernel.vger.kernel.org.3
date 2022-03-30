Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CDD4EB757
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiC3AIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiC3AIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:08:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B943483;
        Tue, 29 Mar 2022 17:07:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 970AC1F439F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648598823;
        bh=dRavRYMt4OXmhvAe8PF9ABx9qq8MFHZ3LSwNhkacwkE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hh+IQsoK7zvHgnfGfROXkPwo6+B/Do7vmAiYuC7Tr1odb20mC9vKiTdnvuUlO+ALx
         Xy8vbDrdwHf3icILpszpILr+q/QJQOi1E2W8dKrhXZFypLtudxx6vda6dxU0Jemasu
         uR67nsFC7NzvXkQk7sI9gWvCga9b1MJdTJ+tS0TEftojx4SO/scHMBfhtH7CRFbavU
         I4ucJeC+hNVAU4R3ALFMNt4LeUuBPNH8dSjG+yT+1q9pi0j4r0bCZmfXKRjSSJu5UX
         PSpow83MQP2LMDDEriKj7NWEhh6DlYy6uo4GmvajJtwHrtJEfYoJIdp7S+zAuyndWs
         NRGBATme8EXeA==
Message-ID: <04bb5ef2-15c3-d561-3572-76dc803275ef@collabora.com>
Date:   Wed, 30 Mar 2022 03:06:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220316092525.4554-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 12:25, Ashish Mhetre wrote:
> Add new function 'get_int_channel' in tegra_mc_soc struture which is
> implemented by tegra SOCs which support multiple MC channels. This
> function returns the channel which should be used to get the information
> of interrupts.
> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
> Add error specific MC status and address register bits and use them on
> tegra186, tegra194 and tegra234.
> Add error logging for generalized carveout interrupt on tegra186, tegra194
> and tegra234.
> Add error logging for route sanity interrupt on tegra194 an tegra234.
> Add register for higher bits of error address which is available on
> tegra194 and tegra234.
> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
> will be true if soc has register for higher bits of memory controller
> error address. Set it true for tegra194 and tegra234.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reported what? You should add this tag only if patch addresses reported
problem. This patch doesn't address anything, hence the tag is
inappropriate, you should remove it.
