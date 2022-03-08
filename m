Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6526E4D11E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiCHIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiCHIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:16:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA53EBA7;
        Tue,  8 Mar 2022 00:15:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F82360E09;
        Tue,  8 Mar 2022 08:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198DCC340EB;
        Tue,  8 Mar 2022 08:15:41 +0000 (UTC)
Message-ID: <02d10dd1-c517-4cbd-be0b-4fa3f5c5ca60@xs4all.nl>
Date:   Tue, 8 Mar 2022 09:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220308080100.7bee0e45@canb.auug.org.au>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220308080100.7bee0e45@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Huh? I see it in our tree:

Author: Daniel González Cabanelas <dgcbueu@gmail.com>

    Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>

What is missing, though, is my SoB. I see he posted a v2 and I probably
copied that v2 into my branch and forgot to add my SoB.

Mauro, can you add my

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

in our staging tree for this patch?

Regards,

	Hans

On 3/7/22 22:01, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   56cb61f70e54 ("media: cx88-mpeg: clear interrupt status register before streaming video")
> 
> is missing a Signed-off-by from its committer.
> 
