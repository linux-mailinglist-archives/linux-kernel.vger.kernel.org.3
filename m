Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C05A6890
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH3QlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiH3QlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8A9DB50
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B7E6170C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC8C433C1;
        Tue, 30 Aug 2022 16:41:03 +0000 (UTC)
Date:   Tue, 30 Aug 2022 17:40:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     bhe@redhat.com, will@kernel.org, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw49m7Hpq+NIZYWw@arm.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830092839.3197-1-ppbuk5246@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:28:39PM +0900, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem range slot in case of crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Does this need a Fixes tag and cc stable?

-- 
Catalin
