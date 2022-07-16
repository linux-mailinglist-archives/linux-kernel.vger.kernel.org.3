Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B42576BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGPF0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPF0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA493E77D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A73760B2C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25478C34114;
        Sat, 16 Jul 2022 05:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657949192;
        bh=GKXCcoSZneVBRzdo8ThZPeiaRbHw/x+/tXUxp5tObYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUXuehasiKe0+jcgiZfhyqDViu2i9gdivf0+4xwH75W8uVXAOEhDeTAO7hO376X7a
         NkGK4zfM9HmScyoCQABz064NFcJ7Ix72oo6OiLYW3bp73itOeR2OoAWXG0RCExpL4/
         IvbpVyDybzWltLZkRd9E9OxJr7P+wSbO52ZA9KmY=
Date:   Sat, 16 Jul 2022 07:25:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for 5.20
Message-ID: <YtJLx2a3FU3MeMNK@kroah.com>
References: <29565f20-400e-b64d-148f-b1e958b052e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29565f20-400e-b64d-148f-b1e958b052e3@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 03:15:03AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.20. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:
> 
>   Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.20

Pulled and pushed out, thanks.

greg k-h
