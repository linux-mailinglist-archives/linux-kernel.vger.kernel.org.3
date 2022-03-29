Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8D4EB32F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiC2SLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiC2SL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:11:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAA27B05
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB96B81813
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B40C340ED;
        Tue, 29 Mar 2022 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648577381;
        bh=/pZfUjwnCrvFojpuNSnniNhny5IfONJsKbqaSoUTGXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQkrLMTxowmVwtRXi8+jjcco1uue4Dlnjq97hDbkfpp0ny71FIETW7bxzZ62Qd+Am
         H+tm3tHIroup+XG7mmMnkG4p/bI8eZv1Qu1iBuBPunp5inSQoT4AfXC/2IXWet1B2l
         j6rvuGNPTzq/4m96oUHtdELA7dfDtQzL+ugtVtjSVC91vnl/t0RqtBZaawdmeQ6g1L
         QVSHStAn/90/5k7VEfB6CC2M9MU65AV+E6AIBC69iFZNepUJun6v4ObJpi0L0pqKT2
         ACKS03JR9X02unMsWlirs/0oUlQL70QyLPzdNRGLYKb1AzjO5AciSGsJ9ce6AACg/s
         wwbrjO2HtZbnQ==
Date:   Tue, 29 Mar 2022 11:09:40 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce data read/write showing
 path info
Message-ID: <YkNLZPRMDwmVml1w@google.com>
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <YjkUvRKhyX8AUoTm@google.com>
 <YkJ5anzBIyQkiHfU@google.com>
 <101f4cb6-37bf-0ac3-3838-7aab7e648352@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101f4cb6-37bf-0ac3-3838-7aab7e648352@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29, Chao Yu wrote:
> On 2022/3/29 11:13, Jaegeuk Kim wrote:
> > This was used in Android for a long time. Let's upstream it.
> 
> Could you please explain more about its usage?

I found ioblame and ioshark in android are using it to understand app/file/IO
traffic. Once we have this in AOSP, I'm thinking to change one by one.
The android-mainline is also deprecating the custom tracepoints as well.

https://android-review.googlesource.com/c/kernel/common/+/2045529

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> The code part looks clean.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
