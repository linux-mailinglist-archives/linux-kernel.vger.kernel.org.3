Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2A54B481
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbiFNPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356795AbiFNPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7B2AE0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE8F3B81987
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509BFC3411C;
        Tue, 14 Jun 2022 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655220209;
        bh=DJzRgptSqntBe0V6we2A9fCf1wxGYk8m/6I2t/fmQ/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbYUVhVggvchuvkzErconIL69NoRr5fhds+l7EEFuQxApnif0SxGOlNZpxQk5Bw7M
         yzIpV9YCy0xlnbCeY9iGB4tcRQcV5ZlGNWJyDu+egJlNsbtlLLO6oYxrB30fbPo23y
         IUvbBtBnRuauh43PKJD5iCkp3igl8EZY6ODOghbk=
Date:   Tue, 14 Jun 2022 17:23:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Vetter <jvetter@kalrayinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com, jmaselbas@kalrayinc.com
Subject: Re: [PATCH v2 1/2] msi: The MSI framework only supports 2048
 platform MSIs
Message-ID: <Yqin77ydGHV9N85x@kroah.com>
References: <20220614151411.32674-1-jvetter@kalrayinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614151411.32674-1-jvetter@kalrayinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:14:10PM +0200, Julian Vetter wrote:
> Some devices need more MSIs. To support this the number must be
> increased.

What devices specifically?

How many more did you just increase it by?

How much more memory are you now using?

Why is there a limit in the first place?  Why not just make it dynamic
so that it never runs out in another month or so?

We need lots more specifics here...

thanks,

greg k-h
