Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420D4F08F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356901AbiDCLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356871AbiDCLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E882F03A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DBDB80CCE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06785C340F0;
        Sun,  3 Apr 2022 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648984580;
        bh=BeDEXZSi5vdhZc3OXtrMw1Z5DIAO5EKp3ycsQ7dc/AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2azfr38Z8YBpwvC1NAVOh6HgeOtW09MKEUn1T+AX+lfZmh6wJJqc9koP27o1Dhqg
         a1O2nCS7FbH0Z13yHoIqlvoH5qSYW4RxkfdFgtUo+4IyPwcSpOsVYJHOqTBo4zSvDe
         ERJ6nB5sD2UeyqciiDXLk8UBolrqcxtLJvLv65nE=
Date:   Sun, 3 Apr 2022 13:16:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] staging: vt6655: Convert macro PCAvDelayByIO to
 function
Message-ID: <YkmCARvUx7Wg15sH@kroah.com>
References: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
 <b7551e92f42d60ff3bb74b5e28467f09781e3d06.1648882847.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7551e92f42d60ff3bb74b5e28467f09781e3d06.1648882847.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 09:29:49AM +0200, Philipp Hortmann wrote:
> Convert do-while(0) macro PCAvDelayByIO to function and relocate.

That says what you did, but not _why_ you did it.

Please read the kernel documentation again for how to write a good
changelog comment and resend a v2.

thanks,

greg k-h
