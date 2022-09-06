Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177D5AEBEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiIFOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbiIFOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8101415A31
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506BE60F89
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2D4C433C1;
        Tue,  6 Sep 2022 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662471816;
        bh=hPRXcLEFIHPYT059+yYJRm2n/GWwq1YoXtAIQHu0q6o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gFpTdM5DwlX7jrJMmI1KZTSuaJ4koybW44opy7BrM3HyWDlYsCkRIuuh13LrXDppp
         yxFy+JSCFO92Eyia9RuGfGAumR7oeA28e9abnvgrCpQ1RErh0nUBaCBNC9ZRuUseOa
         wbFHslwke1h27yQv4XPqIIH+muPLFxyGwhLStPQetGVK14z34jogB77gmyGTr06LII
         DG0wgH5WqikRZDVm/IgcrhjJu5mTONpPwsXMOkixnL7JTwl/VyovkvX72ixvmr4Qcn
         dX2RmVnyYm8YRdagUutg3fMmqTwUhCtQARD5+OAeta7RN43TVpD3IFwQJ9Webv+LXo
         sTZbrFFXoMlFQ==
Message-ID: <3f8c0e42-07dc-4349-5021-bcb75e640094@kernel.org>
Date:   Tue, 6 Sep 2022 15:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] rv/reactor: add __init/__exit annotations to module
 init/exit funcs
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
References: <20220906111846.58738-1-xiujianfeng@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220906111846.58738-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Xiu
On 9/6/22 13:18, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.

Regarding the Subject, this patch is not -next. I would suggest only using -next
when you are fixing something in the linux-next (which is not the case here).

You can also fix this for the printk reactor. Do you mind re-sending this patch
with including the printk reactor?

If you found it using an automatic tool, please add information to the patch.
Also, try to figure out why it pointed to the panic reactor but did not point to
printk.

Add to v2:

Fixes: 135b881ea885 ("rv/reactor: Add the printk reactor")
Fixes: e88043c0ac16 ("rv/reactor: Add the panic reactor")

> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks
-- Daniel
