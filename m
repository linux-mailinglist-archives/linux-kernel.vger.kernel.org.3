Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66FA52DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbiESVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiESVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:15:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD16A04E;
        Thu, 19 May 2022 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XKVl1V+lAFroc7MAeHLoGqePm1FofYZRBNlSFpbUfVo=; b=bZbvpS3bD80DeCoXZ26GUx+O/f
        6cuz75b25cXCO7SD/ODQBYC7bcLyD7KmgB9tYSqEamUnhOhBIe/qLSEpC8h/W466IzbQBNm7l4CX4
        nJcF2snvZbX5kvVcs/UWC+nNsSsmYt5+wfLHSv9+XyLpa8/yuz9oUI88+gWBXXuv3huLmuLTar/MA
        KEm42F+7ih9I7vVOhlHORErJ6AnEK8MhMGegmSNE7opZum02ZzR261J1inU/nc65ejllBdZsR7j8g
        UTDP9sjIcctfNLHT1OcYVePmVQX6TfmO7uzW4KwEbyn9qhW65k2ZtCP0j6QkaWUY7b0BEVykq42EO
        ZNdzAoOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnUV-00D6Vu-Vl; Thu, 19 May 2022 21:15:28 +0000
Date:   Thu, 19 May 2022 22:15:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <Yoazbys+LiG0Uqcc@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:06:24PM +0000, David Laight wrote:
> I suspect this a very good way to blow the kernel stack.
> The highest stack use is already very likely to be inside
> the printf code in an error path somewhere.

...

> Double copying using a temporary buffer isn't the end of the world.

How can you hold both of these positions simultaneously?
