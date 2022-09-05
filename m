Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64B95AD5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiIEPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiIEPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817B5E57A;
        Mon,  5 Sep 2022 08:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE367B811F5;
        Mon,  5 Sep 2022 15:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494AAC433D7;
        Mon,  5 Sep 2022 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662390638;
        bh=pmChB25I0/xOioQuvfxS4anHlEB/iWlW/oPqp/l37GY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=exYKUhxTTuUxLlAx8IzrxsRZycm6/RCghmfrKnf2Y+jgggnhvGFRKOfDw938k0eN7
         Ka4/6j2Tuj9Zt3Y7X48mHrSvXPQT9guosY4ssOdTs8TzsrlYLI3Nv0vyGfXCiff25g
         oGcKLVvtoTelM/rTwKUu8ympPdTQ2bUDucZKu/lUv0CpFG/t96Bpd0eBgBtqg4gCAO
         e9FM9ZW6Nw0N97ZcWZGujwsngRoxOZE4XkM26Vr7u4r1qfaD/sKHzGCn3D9ay7+Kck
         qjp+hPfCYI/J9b5M4VtpggZ4OO68EL+fS0AvERDajOWIHN2BUedv9uXH9fFqY8X3Ty
         rErhw2shs1pLw==
Message-ID: <ef807497-6394-8274-71ce-ace51db31398@kernel.org>
Date:   Mon, 5 Sep 2022 23:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, xiang@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, yinxin.x@bytedance.com
References: <20220815034829.3940803-1-sunke32@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220815034829.3940803-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/15 11:48, Sun Ke wrote:
> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> it should return a negative error code instead of 0.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
