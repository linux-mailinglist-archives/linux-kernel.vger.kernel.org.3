Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344D04ED3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiCaGga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCaGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:36:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 566EA103D9D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:34:41 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22V6YNwx023893;
        Thu, 31 Mar 2022 08:34:23 +0200
Date:   Thu, 31 Mar 2022 08:34:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH v2 0/9] Add dynamic memory allocator support for nolibc
Message-ID: <20220331063423.GB23808@1wt.eu>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
 <2504aa03-e3cf-a120-44dc-af70ec7c9d5c@gnuweeb.org>
 <20220330024114.GA18892@1wt.eu>
 <20220330185152.GK4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330185152.GK4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:51:52AM -0700, Paul E. McKenney wrote:
> > > Sorry, forgot to replace === with --- in for each patch.
> > > Should I resend?
> > 
> > Let's see what Paul prefers. sed 's/===/---/' on the mbox should fix
> > it otherwise a resend will be needed.
> 
> Given that I am adding your Acked-by anyway, why not?  ;-)

:-)

> But please check the commits to make sure that this had the desired
> effect.

All of it looks perfect to me, many thanks Paul!

Willy
