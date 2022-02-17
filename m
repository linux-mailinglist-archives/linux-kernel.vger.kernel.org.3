Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0664BA071
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiBQM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:58:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiBQM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:58:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E42838F2;
        Thu, 17 Feb 2022 04:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6574E61AFE;
        Thu, 17 Feb 2022 12:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319CEC340E8;
        Thu, 17 Feb 2022 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645102675;
        bh=d7BtWolvXWXZKgrXrFp9Lu+XZhjHbvJjoDM+WOz/nfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lo6f3HSoiLX8WRtC3orTyi+8PFoKhNrQ64Z/ZCHF2gnv2FATdwdHJdpoYiXrQbFS2
         4AdQNmgF2g5t0Kqo6UikU9lB3DlA73BQvQJLtB+YOh56fztaTeYB95wgRiirwJG8eE
         rKeYhOS5soGzeXWuYNBpdlGZO1+7LoDVnsmt5gDW7TRj5VQZRFvkkpJ59436/4kpn3
         g9eFn+DylY2ULa7i3SZv1YcRmHvafNDSKBGocW8DKdeQKx5FU9ydblPNBMXpuc3StM
         gqEiVHNORJ5pdyhHti/yAxc7/xXUay7wUAFLaa443w2JPvpBF/Jr4SC3EvWMVObYne
         0nNBuwzk+Fr2g==
Date:   Thu, 17 Feb 2022 07:05:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 kspp-gustavo tree
Message-ID: <20220217130537.GA930267@embeddedor>
References: <20220217141603.7a0ef4ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217141603.7a0ef4ed@canb.auug.org.au>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:16:03PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/r8188eu/include/ieee80211.h
> 
> between commit:
> 
>   fbe9ccfe809d ("treewide: Replace zero-length arrays with flexible-array members")
> 
> from the kspp-gustavo tree and commit:
> 
>   6c36bcbfcef7 ("staging: r8188eu: remove unused structs from ieee80211.h")
> 
> from the staging tree.
> 
> I fixed it up (the latter removed the structs updated by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

I just fixed this up in my -next tree.

Thanks for the report, Stephen.
--
Gustavo

