Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403744BB7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiBRLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:25:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBRLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:25:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A433136861
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 012C4B825B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D99FC340E9;
        Fri, 18 Feb 2022 11:24:53 +0000 (UTC)
Date:   Fri, 18 Feb 2022 11:24:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     cgel.zte@gmail.com
Cc:     will@kernel.org, pasha.tatashin@soleen.com, si.hao@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yang.yang29@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH v2] arm64: kexec: Support the case of VA_BITS=39 in
 trans_pgd_idmap_page()
Message-ID: <Yg+CAXhhkH+HcXXg@arm.com>
References: <20220217083734.1903109-1-si.hao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217083734.1903109-1-si.hao@zte.com.cn>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:37:34AM +0000, cgel.zte@gmail.com wrote:
> From: sihao <si.hao@zte.com.cn>
> 
> fsl64() may get different values due to different physical addresses. Is
> it possible to confirm the value of max_msb with CONFIG_ARM64_VA_BITS?
> 
> Reported-by: sihao <si.hao@zte.com.cn>
> Signed-off-by: sihao <si.hao@zte.com.cn>
> Reviewed-by: CatalinMarinas <catalin.marinas@arm.com>

I have not reviewed this patch yet, so this line shouldn't be here. I'll
have a look next week.

Thanks.

-- 
Catalin
