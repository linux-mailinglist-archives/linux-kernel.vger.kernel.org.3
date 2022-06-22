Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8455474E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354224AbiFVJAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353251AbiFVJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297C37A15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB10B81C20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CB0C34114;
        Wed, 22 Jun 2022 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888415;
        bh=xXD+fcf0G7W/M6s0Dx6PR+PbKve+KAtrMjjS5n3xU9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pW/mZMTwLqPUQrXoAGc4p4NddsInPyIghUxx3v4CuNTOwc9t2hxziu/XDMCVzSBs+
         DkzwdGSlL+/gdrXS5R2LzZ4/yBfCEvaBzlxh9O6dsW5wGSvQAOt+S1BqDH2vIfkBa3
         SldtRLuV8Qwmh5GJq+na01kQHh/5BRbfjf4jR/PBja1Qnb/FscOPUV6HOjeC5QEiHi
         a1lfSHK5YGm09ZWSV6bn7skNm4vCsnKqdSyydH5rmJ3Fdacy7ri3ns8cFwPEHtE7Cx
         vzTtpdKfWxBIINDKPVoq5+I0mYR7sd6yAhn4kDERd+AAibNlzdFBbVYUmxBXfCzEM7
         zUHBb3TfeWIjg==
Message-ID: <1a450b67-1e37-1eac-5906-910cb4deefdf@kernel.org>
Date:   Wed, 22 Jun 2022 11:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm: mach-rockchip: (pm) Add missing of_node_put()
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616021713.3973472-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220616021713.3973472-1-windhl@126.com>
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

On 16/06/2022 04:17, Liang He wrote:
> In rockchip_suspend_init(), of_find_matching_node_and_match() will
> return a node pointer with refcount incremented. We should use
> of_node_put() in fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
> 
>  v2: (1) use real name for Sob (2) use goto-label patch style
>  v1: add of_node_put() for each return
> 

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
