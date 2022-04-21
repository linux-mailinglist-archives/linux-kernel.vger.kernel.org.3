Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1738E509F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380295AbiDUMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358962AbiDUMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C12D1DC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B5B61C16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D9FC385A5;
        Thu, 21 Apr 2022 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650543487;
        bh=Ec9S8myFSolmnoL4R8AOM4Tbz32Q4M+aYL0/deFs8LA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PtVfVhDmzTvIvnk4HIabBQDxQzLbZTGctfqYkJxpL97E3BoUsILGPTk8aKVyBQrin
         EgTXxEmEmkXz4GOgtuYKvw+fY4uUz6awAOL1ZlyorrE77iGWS4qyhoW1x3Rn7Q17lW
         JU43/RvsDvMc0xNPPNtDKGj1r7jq1Y+GkDPBDdoD1Qxnj2VVT+Fw1zSVVnsgPwEhAL
         Cm3Ca70oD4VHhIM9p996Et+cM+6dw2fu/OGmbxac5m5GRs8ILpfNs+QLRaVtjQYOvF
         k0NRIW/if8RLFV8B3UbCCElQ2hppZHRpzFbT99BvcQK/FBssRrr+LCX9eB3x1mH8T4
         Ti1viXhLTwL8w==
Message-ID: <f34695eb-4390-07bb-055b-6d47580d748b@kernel.org>
Date:   Thu, 21 Apr 2022 14:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: defconfig: Enable modules for arm displays
Content-Language: en-US
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com, enric.balletbo@collabora.com,
        agx@sigxcpu.org, spujar@nvidia.com,
        alexander.stein@ew.tq-group.com, yuzenghui@huawei.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org
References: <20220128100720.87803-1-carsten.haitzler@foss.arm.com>
 <15ceea01-20c3-0fd1-f045-ffa1dd4fb6c3@foss.arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <15ceea01-20c3-0fd1-f045-ffa1dd4fb6c3@foss.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 14:09, Carsten Haitzler wrote:
> Ping - has anyone looked at this?

Hi,

defconfig changes are going via SoC platform maintainers, so judging by
title (arm displays) this will be someone from ARM?

Best regards,
Krzysztof
