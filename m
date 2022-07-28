Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C13583A90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiG1Iqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiG1Iql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:46:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49552E67;
        Thu, 28 Jul 2022 01:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECD2AB8236D;
        Thu, 28 Jul 2022 08:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D3BC433D6;
        Thu, 28 Jul 2022 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658997997;
        bh=PHHs5nIX4IopTV7l9ydxSupubpXxFsPpF3wfP6Uh7PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ky2BTmaXFZnSjp5uBZezKkZ2YCjVBT+RyuWrzm7y0CDJcsvDkInuVyqDmLObAC4l1
         8DB6vrT8AMdcqKlM+5NkasDZ9wAFk9b00iQ1xNRLUD04Mk++wqh0x/9C4hCHhNqtb5
         1ldyhyqnkUC6hQp/vBYybaV4jvD21snPg6O3+jzM=
Date:   Thu, 28 Jul 2022 10:46:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     robh+dt@kernel.org, hverkuil@xs4all.nl,
        nobuhiro1.iwamatsu@toshiba.co.jp, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Add entries for Toshiba Visconti DNN
 image processing accelerator
Message-ID: <YuJM66FM97jjA2L+@kroah.com>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
 <20220722082858.17880-5-yuji2.ishikawa@toshiba.co.jp>
 <Yt6Q3A4tkmu797eX@kroah.com>
 <TYAPR01MB6201F467FB17AD40EE907E7392949@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB6201F467FB17AD40EE907E7392949@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jul 26, 2022 at 06:10:40AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> Sorry for this patch not being well formatted.
> 
> I'll add change log and the signed-off-by tag.
> I should have checked patches with checkpatch.pl as well as testing sources with --file option.

Just a normal call to checkpatch will work, no need for the --file
option.

Also for new stuff, please use the --strict to see more things that you
might also want to fix up.

For future versions, also please cc: me on this series.

thanks,

greg k-h
