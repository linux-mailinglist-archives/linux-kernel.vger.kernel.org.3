Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648D4D959B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiCOHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiCOHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:51:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A812AD8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 230DBB81115
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34440C340EE;
        Tue, 15 Mar 2022 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647330614;
        bh=SYyFnHdQnLb5UOzpXR0K5y/08yWJ9rcxPxc2nwwQ/y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6T6VZFe4yMs+yJ3dTApjuZKh6DuqkJqvBuYuEn7wPImC7QrC5P0XRqx/U/yUBZ90
         UxH1vGFONm9oB7+p7hWaqh6kuwxMNAG3nY+CVvFmyQVzfvC6Jzo3F9hr3kzXArRbE7
         tRzx79xo9+qp/BldrCp745BZHB6vc8P5TztKKDnk=
Date:   Tue, 15 Mar 2022 08:50:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     Li Fei1 <fei1.li@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <YjBFMnLIgrFngBTQ@kroah.com>
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com>
 <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
 <Yics6JbQljlQXRED@kroah.com>
 <CAFcO6XNLfOTp2M3B876YTt+atNTveuqH7Q3ePk3N-T=KkJkiTQ@mail.gmail.com>
 <YjA24K4FVZU6fTMd@kroah.com>
 <CAFcO6XNTSoDdQA-4U91VyZqXkjUL+zyoceN7VGwWQKn+HrbbBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XNTSoDdQA-4U91VyZqXkjUL+zyoceN7VGwWQKn+HrbbBA@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:36:11PM +0800, butt3rflyh4ck wrote:
> Ok, thanks.  By the way, I want to explain, Firstly there is just some
> parameter that should be freed before func returns the -EINVAL error
> in the patch.

What patch?  I see nothing here :(

> I think it was correct, no need to test it. And  secondly the commitor
> Li Fei1 also reviewed the patch code. finally I am sorry that  no arcn
> hso hardware to test it.

I still have no context at all.  Please properly quote your email
threads so that we can all understand and respond properly.

thanks,

greg k-h
