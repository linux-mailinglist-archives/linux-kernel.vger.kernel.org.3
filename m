Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBE51EDDE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiEHOAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiEHOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63293A1B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 06:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68286118E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 13:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA88C385AC;
        Sun,  8 May 2022 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652018214;
        bh=KDUXg6wQIrBSossaHIc0SccEk18kHyqx02dOTOVJdjA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jKZqcHwaXEeRceMdiv9/HHDWuVo/vPyykTvxv0lzYlM3Cq7k68PHz8nPl6Yzr0El/
         rG3+SruZdMWsfP02uq1m1zwlGwGvQKaiUcRMo0SW1au9YLQQ6XUsdkEf8cbYjY/mOh
         +BIjwMw3vPxlaPdwfouAHr+i5MW/oDvL2q9d+LcJocEZ55QHMPn+1enFw4wYwNOEOz
         gEZD1YzrjVayJKOdoN/4hsMqBmw8WipWXH135EIpWagbM19+Je/c2SOS9T814iggBo
         V4sLZKOqeIG5OXHcWMAZ/7ebpiWnDos3cDzyf/oMf0hMUM+be6xeU0ujSMc8mEzYtl
         xxCxoDV2jrtJg==
Message-ID: <69976972-aa98-752c-88e4-95196762d7c1@kernel.org>
Date:   Sun, 8 May 2022 21:56:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: stop allocating pinned sections if
 EAGAIN happens
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220506232032.1264078-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/7 7:20, Jaegeuk Kim wrote:
> EAGAIN doesn't guarantee to have a free section. Let's report it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
