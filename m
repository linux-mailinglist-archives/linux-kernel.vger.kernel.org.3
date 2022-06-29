Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F35604D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiF2Pjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiF2Pja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:39:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ABD37A28
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29053B821D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18D1C34114;
        Wed, 29 Jun 2022 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656517164;
        bh=DWY+ZOEqY30QW9jCDPiHYE3yU8+XoNeGqu5hV9ZWYP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc/YHcSYSpxQ2JCsCyGaAE6hCdHu/sHDk4XdvqmiUshpKCXTvgS/sDW8tZHyO7OOW
         vnQF8V7QiHjXJd139/I7njZ7kgMRcBjxNpVVniW09CRBy0I8n+JoXLxK8pQ5ZASoUD
         fv79CyZhyR+up5lCyVj2vnSkZ7PlARGChzbJAejE=
Date:   Wed, 29 Jun 2022 17:39:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/14] mei: debugfs: add pxp mode to devstate in
 debugfs
Message-ID: <YrxyJROfuLpVYDjF@kroah.com>
References: <20220629112913.1210933-1-alexander.usyskin@intel.com>
 <20220629112913.1210933-14-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629112913.1210933-14-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:29:12PM +0300, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> Add pxp mode devstate to debugfs to monitor
> pxp state machine progress. During debug
> it is important to understand in what state
> the pxp handshake is.

You have 72 columns for changelog text, as your editor will tell you
when you run git commit...

Anyway, it's better than nothing, but really, do you think this is a
good changelog description?  That last sentence means nothing.  I too
think it is important to understand things...

{sigh}

Anyway, you all are pushing this hard for some crazy reason, and it's
only a debugfs file, so it doesn't matter much, but it feels indicative
of other patches from your employer for the past few years so I'll be a
pain and ask for you to fix it up again.

thanks,

greg k-h
