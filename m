Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEDE4E1A88
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiCTGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiCTGpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:45:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0B496B1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77108B80D35
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 06:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34F3C340E9;
        Sun, 20 Mar 2022 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647758656;
        bh=dusrF4VlCWfYYYamjBKQmqBPwlcj57b1Mbg7bVk1D1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzuyWQQv019Bx3WnDhsZi5gsyQEMYMu2jAAaiPD38Gq+msk8VlJK7UD4oKzwlTDgb
         1A1X+o2A3Q7i8EEMTP/hhvD91tzsURPO1T/wBhLULaFZz4/SVgm4OqPgnakbt9Mjeq
         TTYyNap2oevUM/fh+4GuHSKD/nA/mPs4E3VOjbHU=
Date:   Sun, 20 Mar 2022 07:44:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ryan C. England" <rcengland@gmail.com>
Cc:     gregkh@linuxfoundation.com, lee.jones@linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: axis-fifo: Fixed parenthesis styling issues
Message-ID: <YjbNO3VHGYbm6Si+@kroah.com>
References: <20220320042340.49222-1-rcengland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320042340.49222-1-rcengland@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 04:23:40AM +0000, Ryan C. England wrote:
> Fixed open parenthesis alignment issues.
> 
> Signed-off-by: Ryan C. England <rcengland@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Where is patch 1/2 in this series?
