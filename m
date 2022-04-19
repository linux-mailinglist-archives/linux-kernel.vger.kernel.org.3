Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234525075D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiDSQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbiDSQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9EE3B018;
        Tue, 19 Apr 2022 09:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF88DB81BDF;
        Tue, 19 Apr 2022 16:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49663C385A9;
        Tue, 19 Apr 2022 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386829;
        bh=Tb4+gvc0BMUd7WNE4C0Od+R6C3ZesJ36is8v5xYE3NY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rL+c7w97tmbha4lzDRMO4ALdbH06PARcZthDKSE/kvFZqrKr9YNryBxM6kHJddAme
         X31LB/MpLEFWFxlnG9IPUpSU8FoCA+uxU/wfTyFxcVmluPCpzqRd6JOHoKic2BF6iS
         v61GS+xjHMQw86VE3Q6NBEeYhcm/jh6he60mrddrQjP1PqyhBxIhJ0zirF74v8fLPV
         D0icNPxC2g84DmdRQQ1FuBG4KPapm+/+9FJE9hpQXVmzmUCZEJxSe3zSuOjbjKSQrL
         HJ4mY9B3GjnRON3eF+mR6jMnplCNUtjZuPEimNNRFGr82GoRMVfw002TdKaIxtlfKK
         RnLihrEJ+Xkug==
Message-ID: <a789eb92-7d4c-7ec5-8f3e-7765c238cb1f@kernel.org>
Date:   Tue, 19 Apr 2022 09:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: Fixes tag needs some work in the arc-current tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220419064023.4cedc139@canb.auug.org.au>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220419064023.4cedc139@canb.auug.org.au>
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

Hi Stephen,

On 4/18/22 13:40, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>    a20aadab6ad6 ("arc: drop definitions of pgd_index() and pgd_offset{, _k}() entirely")
>
> Fixes tag
>
>    Fixes: 974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() definitions")
>
> has these problem(s):
>
>    - SHA1 should be at least 12 digits long
>      This can be fixed for the future by setting core.abbrev to 12 (or
>      more) or (for git v2.11 or later) just making sure it is not set
>      (or set to "auto").

I've fixed this and pushed.

Thx,
-Vineet
