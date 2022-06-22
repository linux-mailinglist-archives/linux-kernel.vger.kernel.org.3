Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725BA55495D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353057AbiFVJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbiFVJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:02:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56037A16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CBFFB80E07
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACC3C34114;
        Wed, 22 Jun 2022 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888539;
        bh=u1exipxCpHIDn5c9MGsHKmOo4GlMCj/GxM2bh7I36EA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OihW1dZNAt1dVH+5Uh0CqhjGS/0R8ejmNdmIM81QllHV+GkFgKIvWkkHPG3G3pYI8
         i+m3uNv+aP3Y6neCrhgwVMLXDbzcG4yk4G4/oGNeI3OqwZA4uks7xFE9JkuwvcisWH
         kcAfK8+mli2WqiINOxQLCyU7ACL3RykkHHBTbacrtrGPOAzQpo6pkyttCGLy4yEm0N
         pT4iInLq0HIvegXui/FdAtrBTaEyMuvwrXfSVFtMnelqWS2eGGw0k7EXUNlWIKpvBt
         Que5gRd2NzrNk23igz5WHDQG0EtffTUISN3V9N2QPGvJXvdLJz7HmOXmQPE0PW5oNr
         HdwixrE+tRTxA==
Message-ID: <6abb20a4-1858-3e04-ed5b-dff18110e58a@kernel.org>
Date:   Wed, 22 Jun 2022 11:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] irqchip: Add missing of_ndoe_get() in its_of_probe()
Content-Language: en-US
To:     Liang He <windhl@126.com>, tglx@linutronix.de, maz@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622062138.4095598-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220622062138.4095598-1-windhl@126.com>
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

On 22/06/2022 08:21, Liang He wrote:
> We need to add missing of_node_get() for of_find_matching_node() to
> keep refcount balance.
> 
> Note: of_find_matching_node() will decrease the refcount of its first
> arg.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 ++
>  1 file changed, 2 insertions(+)

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
