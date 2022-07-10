Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339B56D12C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGJUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:00:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5BCBE06;
        Sun, 10 Jul 2022 13:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27D77CE0B17;
        Sun, 10 Jul 2022 20:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA87C3411E;
        Sun, 10 Jul 2022 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657483253;
        bh=w6tJSYNrKJ/3hIAuBny3C5gPPvX4dgzLghBONrfuJ84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNglLUMJnxxjxFLbgHKWHcntBfGbLSldCsc3FbfccFdDJ/jXzg7KaI6omhGOGM9lS
         +fr8xHZpGuxZe0Uw4HTuhmXsuglG9GoqS9yZWR7slYCW1ib0iP6b2RcFCF0nAE0Rsv
         KItxMtEPrDo5jhwQQ14NpRje+0SyU3ZXQ0tIkEpw=
Date:   Sun, 10 Jul 2022 22:00:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] Documentation: Correct IFS reload documentation
Message-ID: <Yssv8a2/wzLlAQQn@kroah.com>
References: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
 <20220710182521.60642-1-tony.luck@intel.com>
 <20220710182521.60642-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710182521.60642-2-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:25:20AM -0700, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> The location where the scan image is stored is incorrect
> in the current documentation. Fix this.
> 
> Fixes: 34604d289167("Documentation: In-Field Scan")

Our tools will complain about this line, please use the correct format
so you don't get grumpy emails from the linux-next maintainer.

thanks,

greg k-h
