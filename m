Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2B520605
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiEIUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiEIUmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:42:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D418D89;
        Mon,  9 May 2022 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVDi3ZkthDWhU24EgtzN+wCLFG3z5NXVqbnb7DL7KRg=; b=MSu8yd2G1QdsEetiBeGz/X3MKM
        95MHBpcDUIVbe77heF3/WbEV+39tM/Gth0iTVQ2YXNQSdpZ+hLuwy5Yvfg7qNvoqE/FD0fnND5y1D
        Nd0OqoHaem/jn+UyniR/gmp+kRo7GS5JczmtEIpjDS6/1+W944dyqpLsL0ypUb1o7ACx8eItUzN7T
        nv6i0CJCp4GhlzodxwzbvAzpMNrIjGnUWW/ZesZkCeSyuC64rOwnmNFd+ct2DEfYGIZFuYk+NgrVq
        6++7eT9mQ3pukrjrCDRBhq/MXjqgdfKATRraJkN+m9zX4Eww8OKfegheqNNEkVj16ohJN9pddjl9w
        Cx/4S4MQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noA9F-00GBdr-0y; Mon, 09 May 2022 20:38:29 +0000
Date:   Mon, 9 May 2022 13:38:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     mauro.chehab@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Message-ID: <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
References: <cover.1652113087.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652113087.git.mchehab@kernel.org>
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

On Mon, May 09, 2022 at 06:23:35PM +0200, Mauro Carvalho Chehab wrote:
> Currently, kernel/module annotates module dependencies when
> request_symbol is used, but it doesn't cover more complex inter-driver
> dependencies that are subsystem and/or driver-specific.
> 

At this pount v5.18-rc7 is out and so it is too late to soak this
in for the proper level of testing I'd like to see for modules-next.
So I can review this after the next merge window. I'd want to beat
the hell out of this and if possible I'd like to see if we can have
some test coverage for the intended goal and how to break it.

  Luis
