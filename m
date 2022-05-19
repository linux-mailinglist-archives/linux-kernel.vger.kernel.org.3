Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F252D787
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiESPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiESPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB965A0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51FA8618C2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B708C34113;
        Thu, 19 May 2022 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974215;
        bh=tzRUqmBOG/j1qnFGl9Mf3VOLrKBnNATJIoMIm5y8DLU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H62aCog291QEMK1cW22c3HyyS+7mpmPcZ5vI2yPWfGk5wrhlNzZr9I45Ox1FywU/l
         ZBijtlE6xiaZoRmzT65RGW2gXud9mnPHJsB+VQGv3GrScFWh4JhxTkieaJBZx3GpuM
         U2x5CMJ4opRjX80VkOo/96jrvYYhPr6tS+XiWBCptZWy3+hR3exmODHSPo2CYzQb5T
         GABJy/7V8QRvLXMp9SHwDQFK8Ueayf1/W4yLah8vAepLfYMHBiUtAbexd7wvLfnytC
         UpJEFgcH0jf021sqR+uD7oXfEWWvAOK4EiNlND8LdUhTSrvuAK1C97hQtzn2B258la
         RJoZJqzgzJnJw==
Message-ID: <78b1e40e-69cd-465c-ee78-698eb38892be@kernel.org>
Date:   Thu, 19 May 2022 23:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH RESEND] f2fs: make f2fs_read_inline_data() more readable
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220519104010.2814819-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220519104010.2814819-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/19 18:40, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> In f2fs_read_inline_data(), it is confused with checking of
> inline_data flag, as we checked it before calling. So this
> patch add some comments for f2fs_has_inline_data().
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
