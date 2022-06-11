Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7654707A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348994AbiFKARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 20:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345434AbiFKARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:17:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BF6147
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 947F7B837E8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A90C34114;
        Sat, 11 Jun 2022 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654906658;
        bh=2ml5aH2i09s2I2s7D5cXnP2grpr7Pt+O8phN4fuXq8w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=hTXECurh8LAHyya8IJJ3T5kwvnnjrTbMFkizReyTJzzNR5kmRElPCSCvi+0+GMz6O
         7d2wmWud9VDhdsqwLVqE/4Usg+e/BpUFWT4iSjS8VFSLstPdP5PV415VA8cwGFZgK0
         3EX9GufFDdPrNde5pEXkEQleH7m6wnG/MfhCG/quIuWjn+EoMdTIUTO1xxb4ot7R2O
         gF3DvAe7EYlT5UYEH8YOHO8dsf0iMT03goQlJpseMY4QFofAVaPynMLEBw/qf/+QDT
         vUsE2QyFLFfI7UBva8fzG9rmRDKI7gSgfOy2YxBOhF4Dtyog1LFq1PBlxUQAoGGu69
         XGtFHWyNV3QSg==
Message-ID: <d6582f17-7b0b-67eb-ac02-b88f5185e0b6@kernel.org>
Date:   Fri, 10 Jun 2022 17:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH] ARC: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>, vgupta@kernel.org
Cc:     peterz@infradead.org, will@kernel.org, Julia.Lawall@inria.fr,
        vschneid@redhat.com, deng.changcheng@zte.com.cn,
        libang.linuxer@gmail.com, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220508030224.124797-1-wangborong@cdjrlc.com>
Content-Language: en-US
In-Reply-To: <20220508030224.124797-1-wangborong@cdjrlc.com>
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



On 5/7/22 20:02, Jason Wang wrote:
> Remove one of the repeated 'call' in comment line 396.
>
> Signed-off-by: Jason Wang<wangborong@cdjrlc.com>

Thx for the fix. Added to for-curr

-Vineet
