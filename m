Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEE586F08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHAQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiHAQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:52:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5532AC5C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372751; x=1690908751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyZmdg48PDVNwWkxALGtRxEl2iMOrRkbZm/jqyvlrnE=;
  b=TVJZZZ/M/ZPsSYFRPH8dwZFy0O5PiRKfuXTU34Ne3Iaw1b6ZVJ32io6T
   dAJOHp71lCKyoRe4Jq6z6CubVM8xKo1HlLdfQ0IoKfRC288VD/WH+1fsB
   atp0xaq8fqslgc7LYofqWoG3Egoo+izq1jnKCtOqLux9VXZYfHJfnmvsm
   +7m9E2zwYm/sqr7gQRlSYIJTmHfEXqSCTMDeIVtEGTIyrJHc5k6QRq1CU
   2IS+1AQhwBLAtweIoXnNhiEcSz1GnfKdgaGcZdU0O8vrZ9xvv9L6SyOse
   MMCNc809o5Vt4HhJ2pvOAtg1VvvGMFFZmQRqKvUCg+hw26fy+Y8PN038T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="272237804"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="272237804"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:52:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847892607"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:52:30 -0700
Date:   Mon, 1 Aug 2022 09:52:29 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19
Message-ID: <YugEzRwHDjUd+Qta@agluck-desk3.sc.intel.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 02:43:03PM -0700, Linus Torvalds wrote:
> (*) I'll likely call it 6.0 since I'm starting to worry about getting
> confused by big numbers again.

Are you confused by gradually smaller "big numbers"? Last major release
update went:

        v4.19 v4.20 v5.0

-Tony
