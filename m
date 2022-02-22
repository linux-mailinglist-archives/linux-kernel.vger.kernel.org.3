Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933274C03A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiBVVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiBVVRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:17:35 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74B9F6C6;
        Tue, 22 Feb 2022 13:17:07 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 7DEC1801C5;
        Tue, 22 Feb 2022 21:17:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id B720F80013;
        Tue, 22 Feb 2022 21:16:32 +0000 (UTC)
Message-ID: <84ccd9ca57a9aab520062eab392b4b96143e9708.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From:   Joe Perches <joe@perches.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Tue, 22 Feb 2022 13:17:02 -0800
In-Reply-To: <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
         <20220222163144.1782447-5-kbusch@kernel.org>
         <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
         <20220222165045.GA14168@lst.de>
         <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
         <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
         <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
         <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
         <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rz4j893t8y7qoqm4mdmsq1oeb7sqh6rf
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B720F80013
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/MQBIBJ3ak6FHbOobHD8P9oS5MQ2QXiHI=
X-HE-Tag: 1645564592-46478
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 13:12 -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 12:31:30PM -0800, Joe Perches wrote:
> > > I'd only use something GENMASK() for bit ranges.
> > > Even then it is often easier to just write the value in hex.
> > 
> > Mostly it's the count of the repeated f that's difficult to
> > quickly verify visually.
> 
> I admit I made this counting mistake in earlier versions of this series.

It's simply hard for humans to do...

https://en.wikipedia.org/wiki/Subitizing


