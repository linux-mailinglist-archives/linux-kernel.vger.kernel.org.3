Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6D505E84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiDRT1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiDRT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C963D6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26B58B8105F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38D7C385AA;
        Mon, 18 Apr 2022 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309899;
        bh=XO6QdT0AxcpOfTrBUN8I/egwTmX28Rqx6jsl8iAbxFE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZyGusz2Ixuba0KZlwLtaw7gFz5yMbl7ZTz0fCUaAXA6wj3fb4eHSBKBmZjPkihQUb
         wlSwqgp0d7Tb4ZAM3idlCf2cYpd2zhiUiSRrTz0ZIz93RXIMUBGEyuWEUi9gPyoUNj
         zHxwW/erY4UkoofX6OLskgqgrLrq90/U2UdDEubdXXXpF/SqHuBVhNJLDtFeMy5m4D
         E8gdmDf/NbQN7EUesis8T/AVn4/08zBZXgs46kU1foFV0wsvaDKGA0J2xGRhG9ZG8Z
         cLUl0ze48T9vAGM3vomn5jmeV+tXBHBy1ReKg1fbYMQCFiMrLjdCUBt7PMjGp5oEtM
         rXDzqhmbt+Xdg==
Message-ID: <39f4141f-3ec8-1929-e029-9916a495e49b@kernel.org>
Date:   Mon, 18 Apr 2022 12:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arc: drop definitions of pgd_index() and pgd_offset{,
 _k}() entirely
Content-Language: en-US
To:     Rolf Eike Beer <eb@emlix.com>, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <3749315.OSCKaROI16@mobilepool36.emlix.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <3749315.OSCKaROI16@mobilepool36.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/22 01:15, Rolf Eike Beer wrote:
> They were in <asm/pgtables.h> and have been removed from there in
> 974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() definitions")
> in favor of the generic version. But that missed that the same definitons
> also existed in <asm/pgtable-levels.h>, where they were (inadvertently?)
> introduced in fe6cb7b043b6 ("ARC: mm: disintegrate pgtable.h into levels
> and flags").
>
> Fixes: 974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() definitions")
> Fixes: fe6cb7b043b6 ("ARC: mm: disintegrate pgtable.h into levels and flags")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Indeed I missed the upstream change when doing the rework for paging levels.

Applied !

Thx,
-Vineet
