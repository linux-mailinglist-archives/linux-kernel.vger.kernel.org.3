Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6093E4C4A30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiBYQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiBYQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:12:06 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3024211337;
        Fri, 25 Feb 2022 08:11:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BC9968AA6; Fri, 25 Feb 2022 17:11:30 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:11:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <20220225161130.GA13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-7-kbusch@kernel.org> <YhU+kuMhueXVQvxe@sol.localdomain> <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:09:07PM -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 11:50:42AM -0800, Eric Biggers wrote:
> > On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> > > +config CRYPTO_CRC64_ROCKSOFT
> > > +	tristate "Rocksoft Model CRC64 algorithm"
> > > +	depends on CRC64
> > > +	select CRYPTO_HASH
> > > +	help
> > > +	  Rocksoft Model CRC64 computation is being cast as a crypto
> > > +	  transform. This allows for faster crc64 transforms to be used
> > > +	  if they are available.
> > 
> > The first sentence of this help text doesn't make sense.
> 
> Much of the this patch is a copy from the equivalent T10DIF option,
> which says the same as above. I meant to revist these help texts because
> they don't make sense to me either. I'll be sure to do that for the next
> version.

It might make sense to make CRC_T10DIF an invisible option as well
and drop the help text entirely.
