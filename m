Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1066B493E29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbiASQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:13:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:23987 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346196AbiASQNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642608828; x=1674144828;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qXn4Oyh5Dr++hHrfVGjIZqhc6CE2QEkTFFBFKnICAUk=;
  b=oEUHFQ62l5ULqNYl6Fqkx0yFjTBiF+TWJ6FfGOndGiUB4hWpM5wBseE/
   +rjigbw3e8T+I4fM8x0b0d7UrEoTDuQ0LveLwWPm2ncRGR64M2qbEcOoj
   kIY8smF9s6yqB/qREn+1+IZ1a9ssZTqEUHUk2ECA7lT4CKVKkV4GBO9NL
   jdcDu6OsBP9Ox0kxLEe/GR1g3rdd0YWlyXmwPIJt15Bvg4DpXj1GrYBln
   OQgf+fSbaJ/58fcgvQ6L1OTn4Wv4PvfqjYlhy849h7xrsURetwj1PUA2L
   q4T4Fv+FcrtdCxJZXRo9jw88/DGGI/QC/3DIEDRGZzC7N/+FKjzsZsRu2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244897599"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="244897599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:13:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="532353030"
Received: from elenadel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:13:42 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Sven Schnelle <svens@stackframe.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
In-Reply-To: <40d39363-bae8-93f2-71c6-7d5531f144bf@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <Yef0j8+DBbwC7Kjv@kroah.com>
 <Yef15k2GtC40aJEu@kroah.com>
 <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
 <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
 <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com>
 <8735ljkboo.fsf@x1.stackframe.org>
 <CAKMK7uHHF22+MBz5D2kBv07X2BR76UDi2-JP7eO-f=nm-pymcw@mail.gmail.com>
 <40d39363-bae8-93f2-71c6-7d5531f144bf@gmx.de>
Date:   Wed, 19 Jan 2022 18:13:39 +0200
Message-ID: <87ilufbt58.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> On 1/19/22 16:42, Daniel Vetter wrote:
>> If otoh you get the maintainership first to be able to cram in reverts
>> without discussions, then it's very backwards.
> I'm working on the Linux kernel since at least 23 years and am a maintainer of parts of it.
> I know that and would never push something which is controversal without discussions.

I think the entire MAINTAINERS change was controversial and rushed to
Linus without discussion over a weekend.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
