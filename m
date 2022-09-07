Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298745B0406
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIGMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIGMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:35:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A93326E7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97989B81C44
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3376C433D6;
        Wed,  7 Sep 2022 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662554109;
        bh=yGqiO0IJBO/63VFTjm/PnPfiwO9j++Gy1Fa+NOVtrac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgvxZLLMk8vcd29SWCNlmjWLZc0LOUMVfU7NyN3KgYiDE1ALdguPwIsHxu8hGESOO
         6zGHiRSwO+K4aHPZhyrw/7w3qtuet+uEN1mWFvekgrOohFP/1/myBSt4bAoRuprDTj
         d/zmt/1nVFkK8ztqDyAIEpOV65jzNcGMQPD3agcE=
Date:   Wed, 7 Sep 2022 14:35:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] init.h: fix spelling typo in comment
Message-ID: <YxiP+t/ejJQ5mJE3@kroah.com>
References: <20220905021034.947701-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905021034.947701-1-13667453960@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:10:34AM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

What is "k2ci"?

Please follow the Documentation/process/researcher-guidelines.rst rules
when you use tools like this.

thanks,

greg k-h
