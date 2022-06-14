Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1062054A30F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiFNAGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFNAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185C326D5;
        Mon, 13 Jun 2022 17:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C11C6159B;
        Tue, 14 Jun 2022 00:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FF4C3411C;
        Tue, 14 Jun 2022 00:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655165206;
        bh=upAVz7EmukU/kaHRAHziDMU5WoHHUMhf1N7XhokWaVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gznGevyy8zMTNZ/qPdsQ0cuGIfFf/k2RP+Fde2dfCowtPTD9ei1jOD6lPG0Wgqy29
         mSdyLn2TcbDzIG33tqkdIM/6mHGckeS7PqSC2ggl9Y+fT3wKVMF96TUO37pS9kdfYx
         zQ0+jzj8UJBdqxSAblWHJpf6bDBLtPUBxtODOnt5HQLCvS5RLsGiXmyqUJqz5xAmxW
         9SkGpwXHou65ch/MMxz800AUMvrJnHbK4dpTkyar9XrO1UFoC40rL2UBpAD9BJJufq
         /Kb6jIvw6xJmK/EO6SvNrvtncm4b4T4MXuCtWSGrVUW9xZ9vtjIS6jdLkvXG/UoRSQ
         qbMg4XZmMPJrg==
Date:   Mon, 13 Jun 2022 17:06:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jack Qiu <jack.qiu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the f2fs tree
Message-ID: <YqfRFA1Lt5thPGRg@google.com>
References: <20220614081554.2be34f1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614081554.2be34f1a@canb.auug.org.au>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed. Thanks~

On 06/14, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   dd43bcc205ab ("f2fs: optimize error handling in redirty_blocks")
> 
> is missing a Signed-off-by from its author.
> 
> Maybe all patch postings to the linux-f2fs-devel@lists.sourceforge.net
> should have an explicit From: line at the top of the body.
> 
> -- 
> Cheers,
> Stephen Rothwell


