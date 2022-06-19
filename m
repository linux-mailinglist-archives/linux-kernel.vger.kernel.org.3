Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1166B5507CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 03:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiFSAy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSAyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00E636F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF60160DEB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874FDC3411A;
        Sun, 19 Jun 2022 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655600088;
        bh=x7abiCbuk7wG6GSu3AHKJhPYVCZGlCbAAv7OGXYdF0Q=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OvAsvxp4psgzvMUwuYyixp1E0jUGsrpfqQdfTEpsNMOb2VVMK3uqwwX0JYwd4Siar
         UE52grnjeBe4P3Dcb4oxQJvfqwQEzowGcVjmUBHL8mWglQfqddmIkDJq6PLdO6Czti
         oLcckR0w90VYQ4+VAJsFNbxG3LNS/H0CsEYMEgkXj9aQFhhlESgOz43CHai469QzFC
         2qNi05aEpVR/+m0imTv76+GAGzDBfcBPVyJGK/v/sljnfJU/FKYHrEJYH9uX1HZl5I
         To/8NFGYJ7Bq3CCNjtw5NWLOwHBifm7beUYk/aRjjkMqQEAtMRONWdCZmpskOiEAOm
         jNizIGX7J2Scw==
Message-ID: <d826a043-0e2e-889c-4bae-63738867a3b4@kernel.org>
Date:   Sun, 19 Jun 2022 08:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: do not skip updating inode when
 retrying to flush node page
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220617223106.3517374-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/18 6:31, Jaegeuk Kim wrote:
> Let's try to flush dirty inode again to improve subtle i_blocks mismatch.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
