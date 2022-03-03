Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C954CBED9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiCCN2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCCN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:28:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9C45AC9;
        Thu,  3 Mar 2022 05:27:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3528F61A74;
        Thu,  3 Mar 2022 13:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDF0C340ED;
        Thu,  3 Mar 2022 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646314065;
        bh=dGIwofzMp743lq/H6G0kmTunNZasKG3kTyo9mb8RtCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqQ0xJQfx03q10afTRnX1WtqexTWH7TWB8f+Hq0ExLUtz4/t0JaK3REzp+tVKdGDh
         0SRjxMC0zcAqlgyxCvnSDsxx1w20JF3IpnvnlIKt4+pPSUoj9vYi4Zbms5jnRVnB5e
         vOQVCI9WNzT7riiWbOzRGSL8cFITI3FJ70/YziRelPCrLsQoNj8VC3bst5nX8SVgWK
         DtGT7VUXPw4nvugRAZTx4O9DpOU17ukuAuPqVMur/ocFQWOij7KKYUiBIgAbulZ6Og
         PMzHSvI2/qn+6kZw+mEg8RF2HYfsqQ2OVIoPBaT+gRrnC2caWHAVM42tJywGYW/QqR
         n0rHf5YYMR3mQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPlUc-0000EZ-O7; Thu, 03 Mar 2022 14:27:43 +0100
Date:   Thu, 3 Mar 2022 14:27:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YiDCTqWzdCeNfOdv@hovoldconsulting.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
 <YfgSpArfoL9LUaBO@hovoldconsulting.com>
 <YfgninPOaJhq7dsZ@smile.fi.intel.com>
 <Yfj0lb50vS3ssrsn@hovoldconsulting.com>
 <20220303095432.GB9912@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303095432.GB9912@kili>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:54:32PM +0300, Dan Carpenter wrote:
> On Tue, Feb 01, 2022 at 09:51:33AM +0100, Johan Hovold wrote:
> > On Mon, Jan 31, 2022 at 08:16:42PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 31, 2022 at 05:47:32PM +0100, Johan Hovold wrote:
> > > > On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > > > > > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> > > > 
> > > > > > > I think this misunderstands the problem that Andy is trying to fix.
> > > > > > > 
> > > > > > > The situation: I write a patch.  I post it for review.  A bot does
> > > > > > > something and finds a bug (could be compile-error, could be boot
> > > > > > > problem).  That bot sends a bug report with a suggestion to add
> > > > > > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > > > > > made it upstream, so it looks like the bot reported the "problem"
> > > > > > > that the patch "fixes".
> > > > > > > 
> > > > > > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > > > > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > > > > > makes it look like the bot spotted the original bug, rather than
> > > > > > > spotting a bug in the fix.
> > > > > > > 
> > > > > > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > > > > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > > > > > don't think we need a new kind of trailer to get wrong.
> > > > > > 
> > > > > > It seems like the only way to fix this is to fix the bots. Adding more
> > > > > > documentation is unlikely to help in this case.

> > Perhaps I'm missing something, but if you re-read Mathews description
> > above, it still seems to me like the issue is that the bots are trying
> > to claim credit for finding things that haven't been merged yet.
> > 
> > Your suggestion is to document that the bots should be ignored. My
> > suggestion is to fix the bots.
> 
> Originally the kbuild bot used to not have that notice but adding it
> meant that kbuild bot got a lot more visibility.  The truth is that
> managers love metrics and it helps people get paid.
> 
> The whole point of kbuild-bot was to search the lists and test code
> before it gets merged.  If they just waited and tested linux-next they
> would get their reported by tags because most trees don't rebase.  But
> we're punishing them for being better at their job.  It's a perverse
> incentive.

I hear you. But I also get Matthew's and Andy's point about it not being
quite right to give an automatic test program Reported-by credit for
finding, say, an unused variable in a not yet merged patch. And perhaps
even more so since real reviewers often get no credit at all (but
perhaps a mention in a cover letter).

> We should create a new tag for finding bugs during review.

Yeah, I guess your perverse incentive argument applies equally to human
reviewers even if I'm also reluctant to going down this path.

Johan
