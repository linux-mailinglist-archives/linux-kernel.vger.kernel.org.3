Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9670E4EC9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbiC3Qdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348813AbiC3Qde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6011D15281A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1983DB81BB7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74706C340EC;
        Wed, 30 Mar 2022 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648657906;
        bh=MHCUJhBflGAyFhDxJ0iLf+Kpc16g1jo3zz/DWgsW9G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvamqDVNUylPRkPaiOfmlDWS9ece9sURJxwhJ7u0LtdpjnIh/tKynVISSYg1xfuJx
         A8fZvBpSWdgs/vwkYEw7CJnKePW8b7HLE9nWzEFcJW33luDGgiAoGzepemjxt/8vi0
         pjiug23hmQx++uVEBosf1mPvP+Nm2oLcu1DdAQlg=
Date:   Wed, 30 Mar 2022 18:31:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZC05L+K5paH?= <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE
 micro to simplify misc proc_fops
Message-ID: <YkSF73UsAb6PWAed@kroah.com>
References: <20220327143254.226844-1-wudaemon@163.com>
 <YkFM2Ko21j8Ehca8@kroah.com>
 <4ac4969e.8288.17fdb6206ea.Coremail.wudaemon@163.com>
 <YkR5PkJq27NIdY52@kroah.com>
 <51686fcb.83c6.17fdb7fd327.Coremail.wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51686fcb.83c6.17fdb7fd327.Coremail.wudaemon@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:44:21PM +0800, 吴俊文 wrote:
> sorry ,I just send a picture not text.It refers I show list  the reason why I patch a newer verson?like this:
> 
>   <commit message>
> 
>   ...
> 
>   Signed-off-by: Author <author@mail>
> 
>   ---
> 
>   V2 -> V3: Removed redundant helper function
> 
>   V1 -> V2: Cleaned up coding style and addressed review comments
> 
> 
> 
> 
>   path/to/file | 5+++--
> 
>   ...
> 

As my bot showed, this is documented in the kernel Documentation/ file
for how to do this.  And yes, that does look correct.

thanks,

greg k-h
