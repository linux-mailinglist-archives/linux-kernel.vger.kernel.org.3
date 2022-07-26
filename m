Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BE580F08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGZIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZIb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:31:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958582B1AF;
        Tue, 26 Jul 2022 01:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40999B80EBA;
        Tue, 26 Jul 2022 08:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1186EC341C0;
        Tue, 26 Jul 2022 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658824286;
        bh=CpixotnHZyHcsyds4w+/sW0X7O3iizEWwOtMNxrL/Gk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pv7ib0wAWrkDbgYhBwKhNmg2ayzKZBBm/bTw/FEJzEvv6B/sY31LB1eHRv2DrF/AJ
         NdsvfAvRj5oAsyFC1rf9VOHihdmSAVcs/m4HjQb2B2Bm/aTyaaNg2uAiEdHixWwCBF
         CdJlFQF3pIcFEroyahqa51th0OhzRWdEMuUDD3hlqCmxJ/xspz74f8HLjoi4R2r3Ce
         Fa3VqCBUtsLN+r5k8A+zxIvOPcYojeLAtCOjK4eA67rLDN8ZJDFct1r0uypYSaCcRT
         +vcfkk1lJBuKoe1QN3knsg8DA4nSHs+Ic7EipUzVBVZXM0HuGBDRpK8iSF2jbAloAI
         ke4yY0sTXssWA==
Message-ID: <08c868b0-6004-7909-01f5-65f9fe4d3a6b@kernel.org>
Date:   Tue, 26 Jul 2022 10:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] rtla: Define syscall numbers for riscv
Content-Language: en-US
To:     Andreas Schwab <schwab@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mvma68wl2ul.fsf@suse.de>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <mvma68wl2ul.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 10:01, Andreas Schwab wrote:
> RISC-V uses the same (generic) syscall numbers as ARM64.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
