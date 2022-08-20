Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3559AAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiHTCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiHTCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5512639
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613CF61948
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1E3C433D7;
        Sat, 20 Aug 2022 02:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660961052;
        bh=D0HcQScd0vMplt3OigJziwoB5lCq0pCl/B9CGVf7vbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IoKCcAbocxDKOX4fUjcb4CeA+iYDhCJliGn1eVw1CdCSH2viwvePE43D59SEIsANd
         uAfbECPGxHuWLdJQ5MaGx686eylCVP94I/fDVB8Y3ZTmmJWQv6z0d1u9RPu2F9rWFb
         7cDdPo1QUHHE+5IF1PvB/PI2IhRX6YQBNI/fnoByMwmZBCifiJkUiPRGPxyisDX5l/
         MFwpVzkUXOQTeiQLCaDU2bxKMBJ2ZM4M1bvUplQSkMjfL0Coh4FXEdWAfOBKvoBIux
         FNUoeMV3VNSvSjYXkLUhMLhLIKUutTDL7L6Ud3ey7c5+RDK03aLecAvBGxC3tBFGyp
         Fg7CA+I8/8lrA==
Message-ID: <62a8b7df-9970-c3cd-0050-92321f1348ea@kernel.org>
Date:   Sat, 20 Aug 2022 10:04:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong continue condition in GC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
References: <20220813143709.11909-1-jaegeuk@kernel.org>
 <YwAeGIszLrcNqNbE@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YwAeGIszLrcNqNbE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/20 7:34, Jaegeuk Kim wrote:
> We should decrease the frozen counter.
> 
> Cc: stable@kernel.org
> Fixes: 325163e9892b ("f2fs: add gc_urgent_high_remaining sysfs node")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
