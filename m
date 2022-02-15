Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99984B6465
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiBOHbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:31:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiBOHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:31:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32822B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7lcqQhlJbBDEMSJpulWqev5fg4OpONMkUkDMH5Z/yHk=; b=BkopGjqPtNaZYB3dIsyEubx9Vc
        p8iWYDXse65XyM6A8m2ohl6Tz+BMs2iudj57cwLu0s+Oi7CVzXhB/iQ2bMoj5LYB3UvE9+M713O0F
        xDDeSPeZvtzpnOMlgn8snH8IR52lASb1H2j8HqhCAIVkgL20zNkpOfdi4/cQgSAe+Kdi7lgvVeEZv
        Uc2Lkr+gSJYuax/L5rdTMI1w6TN8R0+1OYA2S1stZ6cvUDzN7gWJ3+p9CYYfOG+ROJhAlPL7s8Mjp
        kEZGFxw0mCh0cZI09uyxcbhCVyoAewCAKLmC/BpbJq7D1x9rsDrjpkdS7Zfs0XifYbpmKTXIQ+IcB
        jvGHOFGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsJ2-001Ehh-H5; Tue, 15 Feb 2022 07:31:24 +0000
Date:   Mon, 14 Feb 2022 23:31:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_loader: EXTRA_FIRMWARE does not support
 compressed files
Message-ID: <YgtWzLsIzXQX8jP/@bombadil.infradead.org>
References: <20220214222311.9758-1-rdunlap@infradead.org>
 <YgsHtdqm3xRU+QUD@bombadil.infradead.org>
 <29f9b063-96c9-f120-0920-acd088b01b89@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f9b063-96c9-f120-0920-acd088b01b89@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 07:30:22PM -0800, Randy Dunlap wrote:
> 
> 
> On 2/14/22 17:53, Luis Chamberlain wrote:
> > On Mon, Feb 14, 2022 at 02:23:11PM -0800, Randy Dunlap wrote:
> >> Document in the firmware loader Kconfig help text that firmware image
> >> file compression is not supported for builtin EXTRA_FIRMWARE files so
> >> that someone does not waste time trying that.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> ---
> >> Yeah, I wasted some time trying to use an xz compressed file
> >> as builtin EXTRA_FIRMWARE, 
> > 
> > Curious *why* you are using EXTRA_FIRMWARE BTW.
> 
> Hi Luis,
> 
> I need to load i915 firmware very early
> and I am not using an initramfs.

Curious, why don't you use an initramfs? I'm just
trying to gather users of EXTRA_FIRMWARE as I thought
they didn't exist.

  Luis
