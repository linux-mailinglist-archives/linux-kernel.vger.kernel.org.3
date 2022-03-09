Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4F4D3019
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiCINlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiCINlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:41:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611F53E3F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:40:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BFE8B81EE7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB63C340E8;
        Wed,  9 Mar 2022 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646833233;
        bh=mHr55aecenNFr6na/dMpSP5PwPS2DjTY3yXHnJzL1/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fe+UX8p464k7gF7jwMiq0rJ5YRZeyYCxPvXhPEKfXwttQQZye860cLLbPlchGhv/f
         ko7I/8msJhiXrrDOMCcNUVI3jAg0WjxA+RDoxn/DaReIYB+wPEFntk803/jsL7AQWm
         +WPX0XX/XhXTjehnk+1caz6bCRECrjIpBKh52ELo=
Date:   Wed, 9 Mar 2022 14:40:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6IGC5rGf56OK?= <niejianglei2021@163.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: consolemap: Add missing kfree() in
 con_do_clear_unimap()
Message-ID: <YiiuTg1mvKa1QM+z@kroah.com>
References: <20220303020630.460257-1-niejianglei2021@163.com>
 <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 08:34:47PM +0800, 聂江磊 wrote:

<snip>

Please respond not in html email so it gets to the mailing list, and try
not to top-post.  I'll be glad to respond that way.

thanks,

greg k-h
