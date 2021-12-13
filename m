Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62894720FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhLMGL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:11:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:52229 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhLMGL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:11:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="218683545"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="218683545"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 22:11:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="603437798"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 22:11:24 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Dec 2021 08:11:21 +0200
Date:   Mon, 13 Dec 2021 08:11:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Discrete Thunderbold Controller 8086:1137 throws DMAR and
 thunderbolt fails to work
Message-ID: <YbbkCdUKwgB0P6y3@lahna>
References: <CABTNMG0zcoCqVue8-3cJQ+iTPkJAgjxEN4FB6_ASX2rgXbWunw@mail.gmail.com>
 <CABTNMG1-ZzoKr024G1beGdZyNONbRp0_1mpeTRnDXcEuE_VNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG1-ZzoKr024G1beGdZyNONbRp0_1mpeTRnDXcEuE_VNkA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:37:10PM +0800, Chris Chiu wrote:
> On Thu, Dec 9, 2021 at 5:39 PM Chris Chiu <chris.chiu@canonical.com> wrote:
> >
> > Hi,
> >     We created a ticket
> > https://bugzilla.kernel.org/show_bug.cgi?id=215265 that is pretty
> > similar to https://bugzilla.kernel.org/show_bug.cgi?id=214259. So I
> > tried the patch on https://lkml.org/lkml/2020/6/17/751 but it doesn't
> > fix the issue. I also tried to boot with the kernel parameter
> > `pci=nocrs` but it changed nothing either. I attached the kernel log
> > with thunderbolt dynamic debug on and lspci output on the ticket. Also
> > tried to disable the intel_iommu, the DMAR failure seems to go away
> > but thunderbolt still fails to work. Can anyone suggest what kind of
> > information is required to help identify the cause of the problem?
> > Thanks
> >
> > Chris
> 
> Gentle ping. Mika, could you give some advice on this? Thanks

Hm, didn't I already answered?

https://lore.kernel.org/linux-usb/YbHVryQ+QTnyMmTB@lahna/
