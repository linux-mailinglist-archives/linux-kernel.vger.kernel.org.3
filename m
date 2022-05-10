Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B252271B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiEJWqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiEJWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:46:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E904218FEF;
        Tue, 10 May 2022 15:46:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1AE3D9200C4; Wed, 11 May 2022 00:46:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 18A549200C1;
        Tue, 10 May 2022 23:46:26 +0100 (BST)
Date:   Tue, 10 May 2022 23:46:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty tree
In-Reply-To: <20220511075804.79c5b697@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.2205102341030.52331@angie.orcam.me.uk>
References: <20220511075804.79c5b697@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022, Stephen Rothwell wrote:

> After merging the tty tree, yesterday's linux-next build (htmldocs) produced
> these warnings:

 Umm, sorry about that.  I wasn't even aware files under Documentation/ 
are meant to be processed somehow other than through eyeballs nowadays!

 I'll see how to fix the file up and will make the necessary corrections, 
but how shall I post the update?  A replacement patch or an incremental 
change?

 Thanks for letting me know.

  Maciej
