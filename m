Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACD511FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbiD0Rm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbiD0RmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:42:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668206D949
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E71B828AB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBE1C385AD;
        Wed, 27 Apr 2022 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651081142;
        bh=28m7Jmv/cP/fZD1raKhoHmAzZkh4E0aSzDdckRwT6ZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7ZoWlobJC5xvGAziA+7AvdRJm0UfBN4J2xnMhAHkyexBIn4sf28UWOOYfofiP+JO
         LLZqd0luZ/XfSv5h3Dt1IL0MFQ1lzk15K0+oZr1DWwAq2DNIlXHNEk53D4L6xDo8kp
         m+v4BqedM8llnYyA03M4lX47FFYkNgNSN5CnsqGU=
Date:   Wed, 27 Apr 2022 10:39:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        rf@opensource.cirrus.com, pmladek@suse.com
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-Id: <20220427103901.7567e7058dcaa3068056b2ed@linux-foundation.org>
In-Reply-To: <Ymldp7E3j29iVlMN@smile.fi.intel.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
        <Ymldp7E3j29iVlMN@smile.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 18:13:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > At many places in kernel, It is necessary to convert sysfs input
> > to corrosponding bool value e.g. "false" or "0" need to be converted
> 
> corresponding
> 
> > to bool false, "true" or "1" need to be converted to bool true,
> > places where such conversion is needed currently check the input
> > string manually, kstrtobool() can be utilized at such places but
> > currently it doesn't have support to accept "false"/"true".
> > 
> > Add support to accept "false"/"true" as valid string in kstrtobool().
> 
> Andrew, this patch still needs a bit of work.

I fixed the two issues you identified in this email.  Is there more to do?


