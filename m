Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3147453E35C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiFFGMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiFFGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:12:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B81403F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E13A3B8114B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EF6C34119;
        Mon,  6 Jun 2022 06:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654495918;
        bh=QakzZq9lRiGOvpErXkgEihE7W8tXwKnrBeRHAk/2sZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTAdJEhOVB7hQx+MzknmbvbQiHDBPb0MRvMypEEr3EU/Qy+HBrJwipqF8mcZLTaws
         LFkx2cBVvQ35hzC6UOEatyKPzMIIdAheuDLUfCwIAz5fy8AIYapdptMuglD/DujVwY
         x7jqzBWfOaS3kbITuLr1efS6FdUQTxitiG9Dkud0=
Date:   Mon, 6 Jun 2022 08:11:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] staging: some memory-related patches
Message-ID: <Yp2arAcg3DlgNT5t@kroah.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:56:47PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> This is a collection about some memory-related bugs fixing.
> In brief, there are two types about them.
> First is some memory allocation functions are called without proper
> checking, which may result in wrong memory access in the subsequent
> running or some else.
> Second is lacking proper error handling that does not release some
> allocated resources, which may result in memory leak problems.
> 
> These issuses are similar, so they are put in this series together.
> Note that most of them are sent as each separate patch before, this series
> rebased them to the lasted version. While there are some inherent logical
> relationships between 03~05/11~12.

Can you please look at Documentation/process/researcher-guidelines.rst
and update the changelog texts of these commits to provide the extra
information that this document requires of changes like this?

thanks,

greg k-h
