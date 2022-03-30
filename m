Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67B14EBAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiC3Glf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiC3GlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA15714B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FD9BB81B79
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D4C340EC;
        Wed, 30 Mar 2022 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648622351;
        bh=jOA5DTcR4ysQBXgXzVRHkctJEYYohSxahVIcYzS0xY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODkquS471G0QSSZvRrexAs3p52GBDXyac5o5if+gzWhXA5rZTbFslEC0XG4milNZi
         QhNpOExFcX+s1wMiLh6QziNjYjzGJaA8auysH3KpHIF95hI0e1V1qEAlbOsqbXhfJa
         6i3Qi+XUK3ufvzn0CrYDEvBC0decfajTp9JSpdOQ=
Date:   Wed, 30 Mar 2022 08:39:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix misspelling in comment
Message-ID: <YkP7DGP+nbo2VJ+Z@kroah.com>
References: <1648621413-1263-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648621413-1263-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 02:23:33PM +0800, Haowen Bai wrote:
> This patch fixes some spelling typo in error message reported by checkpatch.pl
> 
> WARNING: 'cacluated' may be misspelled - perhaps 'calculated'?
> WARNING: 'cacluated' may be misspelled - perhaps 'calculated'?
> WARNING: 'writting' may be misspelled - perhaps 'writing'?
> WARNING: 'defualt' may be misspelled - perhaps 'default'?
> WARNING: 'Caculate' may be misspelled - perhaps 'Calculate'?
> WARNING: 'accordign' may be misspelled - perhaps 'according'?
> WARNING: 'regster' may be misspelled - perhaps 'register'?
> WARNING: 'Wirte' may be misspelled - perhaps 'Write'?
> WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
> WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
> WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
> WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?

Please break this up into one-patch-per-misspelled-word.

thanks,

greg k-h
