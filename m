Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7925B0694
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIGO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIGO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444A7C509
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 320FB617D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96623C433D6;
        Wed,  7 Sep 2022 14:29:08 +0000 (UTC)
Date:   Wed, 7 Sep 2022 15:29:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: spectre: increase parameters that can be used
 to turn off bhb mitigation individually
Message-ID: <YxiqsXjQQGe0dNuA@arm.com>
References: <1661514050-22263-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661514050-22263-1-git-send-email-liusong@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 07:40:50PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In our environment, it was found that the mitigation BHB has a great
> impact on the benchmark performance. For example, in the lmbench test,
> the "process fork && exit" test performance drops by 20%.
> So it is necessary to have the ability to turn off the mitigation
> individually through cmdline, thus avoiding having to compile the
> kernel by adjusting the config.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>

If people want to disable this mitigation and know what they are doing,
I have no objection:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I guess that's more like 6.1 material)

-- 
Catalin
