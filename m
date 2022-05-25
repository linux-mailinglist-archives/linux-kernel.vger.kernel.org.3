Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D25338EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiEYI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiEYI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:57:30 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27526FA2B;
        Wed, 25 May 2022 01:57:28 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 134C2101CCD; Wed, 25 May 2022 09:57:27 +0100 (BST)
Date:   Wed, 25 May 2022 09:57:27 +0100
From:   Sean Young <sean@mess.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lirc build broken [was: [GIT PULL for v5.18-rc1] media updates]
Message-ID: <Yo3vd4QRmwZsRhlH@gofer.mess.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
 <5c691c83-480b-8731-7e6a-7f28536c9a59@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c691c83-480b-8731-7e6a-7f28536c9a59@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:44:38AM +0200, Jiri Slaby wrote:
> On 25. 05. 22, 8:42, Jiri Slaby wrote:
> > On 22. 03. 22, 10:14, Mauro Carvalho Chehab wrote:
> > > Hi Linus,
> > > 
> > > Please pull from:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> > > tags/media/v5.18-1
> > ...
> > > Sean Young (10):
> > ...
> > >        media: lirc: remove unused lirc features
> > 
> > Hi,
> > 
> > this breaks lirc build:
> > > [   59s] lircd.cpp:489:49: error: 'LIRC_CAN_SET_REC_FILTER' was not
> > > declared in this scope; did you mean 'LIRC_CAN_SET_REC_CARRIER'?
> > > [   59s]   489 |                     || (curr_driver->features &
> > > LIRC_CAN_SET_REC_FILTER)) {
> > > [   59s]       |
> > > ^~~~~~~~~~~~~~~~~~~~~~~
> > > [   59s]       |
> > > LIRC_CAN_SET_REC_CARRIER
> > > [   59s] lircd.cpp: In function 'void loop()':
> > > [   59s] lircd.cpp:2069:82: error: 'LIRC_CAN_NOTIFY_DECODE' was not
> > > declared in this scope; did you mean 'DRVCTL_NOTIFY_DECODE'?
> > > [   59s]  2069 |                         if
> > > (curr_driver->drvctl_func && (curr_driver->features &
> > > LIRC_CAN_NOTIFY_DECODE))
> > > [   59s]       |
> > > ^~~~~~~~~~~~~~~~~~~~~~
> > > [   59s]       |
> > > DRVCTL_NOTIFY_DECODE
> > 
> > So the uapi header defines should be brought back, IMO.
> 
> (And lirc fixed at the same time.)

What is broken?


Sean
