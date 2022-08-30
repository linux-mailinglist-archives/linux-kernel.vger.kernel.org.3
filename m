Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A895A65F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3ONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3ONV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A64E01EF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB346B81C22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB2C433D6;
        Tue, 30 Aug 2022 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661868798;
        bh=ZTk15ZgVYXrQGuome5BmZMDt8/CCStppaB/q541mVbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FC5PtbFCsH/4038LOLUR7Ia9VSEqlv+Pi/d0Lo0RHJ2IMuLJ1ED9mhDQYDxNhz6/9
         eZ/8iaM5cznE7OaOaqYdxQ4rljnUc31x6T/mw0zNdTzPpfSLvlYOKBHEki99y0LVdS
         2vpIHJfewiR1io/tM5SCTsZYDfiFO3zui1MlBuO4=
Date:   Tue, 30 Aug 2022 16:13:12 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI fixes for v6.0
Message-ID: <Yw4a+EbQSiSw7JR/@kroah.com>
References: <c0585d60961ed200f422a9f2124ee269827504e3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0585d60961ed200f422a9f2124ee269827504e3.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:58:16PM +0000, Winiarska, Iwona wrote:
> Hi Greg,
> 
> Those fixes were previously sent after your development tree was already closed.
> It would be great, if you can pull them for Linux v6.0.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-fixes-6.0

Pulled and pushed out, thanks.

greg k-h
