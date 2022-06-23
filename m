Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0555750B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiFWIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiFWIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849154756E;
        Thu, 23 Jun 2022 01:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E03B82208;
        Thu, 23 Jun 2022 08:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECCEC3411B;
        Thu, 23 Jun 2022 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655971841;
        bh=R3uCGcBzcPhEjKLhoHYVr0mcT7inFO/vUdrx4pb+wmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpb8gFH2ZoatfRw2fHmWNw0l08XRetd1naHwiFW0SnH5+PLXNAt3WbYdpzFN7PyLR
         pzD04MEf/DFEbSUQ1MGQzaIK5f4MrFoqE9zicARpfwAD9aZ4rxKfmKsi3x89f8HGxq
         JwJEQK6tF7+7Rdml1BXBR2pQd/sIjPDso0xC/6kiD22LCbL/Yv5lrcj1iY7vAmZCXi
         aH0h4rk1zSQtdHP1ker7Mr+lTM2iRnrRi2N6aFCsSvQgHRVDQ5a3rd3EsdVD+zVxtL
         bYZv6hI4Vyh1F4EXWR/DBVc9ntWgGJWLS9WUrgJdUJ6D0F8Q1pBQEpwuvHg3GLbfkN
         tJ2T/s4H7XF4A==
Date:   Thu, 23 Jun 2022 13:40:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 14/16] soundwire: Use acpi_dev_for_each_child()
Message-ID: <YrQf/W/Kmo954hAm@matsya>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <9017824.rMLUfLXkoz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9017824.rMLUfLXkoz@kreacher>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 20:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).

Applied, thanks

-- 
~Vinod
