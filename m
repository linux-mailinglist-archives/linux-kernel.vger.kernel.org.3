Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D051FF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiEIOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiEIOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:15:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11AB122B53;
        Mon,  9 May 2022 07:11:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B709068AFE; Mon,  9 May 2022 16:11:24 +0200 (CEST)
Date:   Mon, 9 May 2022 16:11:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Conor.Dooley@microchip.com
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <20220509141122.GA14555@lst.de>
References: <20220503172926.08215c77@canb.auug.org.au> <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com> <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 01:33:07PM +0000, Conor.Dooley@microchip.com wrote:
> @Christoph, I know /nothing/ about swiotlb, so if you have any
> suggestions for debugging that you would like me to try, let me
> know please.

Hi Conor,

sorry for dropping this on the flor.  I was at LSF/MM least week and
my plan to go through my backlog today didn't go to plan as I unepectedly
spent half the day at doctors appointments.

The commit looks like a somewhat unusual culprit for a boot failure,
so any chance you could do another manual verifiation pass where
you checkout 6424e31b1c05 and then the commit before it (i.e. as
git checkout 6424e31b1c05^) to make sure it really is this commits?
Some of the commits around it just seems like more likely culprits to
me, so I'd like to really be 100% sure here.  In the meantime I'll
look through the patch.  Also you don't happen to have earlycon support
on this plaform to see if there are any interesting messages on the
serial console?
