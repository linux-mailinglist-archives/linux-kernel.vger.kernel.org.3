Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D289515E87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiD3PEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382916AbiD3PEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2B43389;
        Sat, 30 Apr 2022 08:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507DBB80188;
        Sat, 30 Apr 2022 15:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4BCC385A7;
        Sat, 30 Apr 2022 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651330875;
        bh=Ajnucx/H/ioVOWtM+z252WJjKeKWS+lbUTXB0YVIvko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyIUBA6pqqg/B5wyOdcBDSKNfjtyMoj5sWt3Xdh4pX+zHEGGcxKJ95CN6T0JFdHby
         hV9/K8uobLdNYn/ulaPsgu8Fx2ZaTb2Xue2Dzv8mIqmlZJHvELez5fJErThevr2fUv
         pPLrIsIA43sEFEbS80j0j1nzwT++PjVZBIhE1KHg=
Date:   Sat, 30 Apr 2022 17:01:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/2] module: update dependencies at try_module_get()
Message-ID: <Ym1POJ58psy2UBUo@kroah.com>
References: <cover.1651326000.git.mchehab@kernel.org>
 <a403bfabca4ce587ddd275f2a3c1dfc1d99bda86.1651326000.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a403bfabca4ce587ddd275f2a3c1dfc1d99bda86.1651326000.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 02:41:47PM +0100, Mauro Carvalho Chehab wrote:
> Sometimes, device drivers are bound into each other via try_module_get(),
> making such references invisible when looking at /proc/modules or lsmod.
> 
> Add a function to allow setting up module references for such
> cases, and call it when try_module_get() is used.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

