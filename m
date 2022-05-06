Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2E51E10E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444441AbiEFVb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442687AbiEFVb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A26EC71
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D891611C1
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 21:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9727FC385AF;
        Fri,  6 May 2022 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651872491;
        bh=hITFWeVq/tL6IgyhQ+DJZ5xQDuyeMVW8xG48CQzOCwY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e7+KACfqd8m2MYjHMKd+lMyQtFdLY46y98gkuHt3j//X6BKwG8IjAX3JKIwLsH+St
         ntahk2HF5SygR0wEO+zIlNAyvCRZhqgVqXQWo5gYAFDAJ8F34K3gRAUW9DfIEbgxVD
         KyH8MpJ31NonErQxiA5pxLmiNh0AdE4w3rLn+WDKQN395eXYa/I0WVeJ/wCkxrfEsZ
         JIFQ+1EExNA/111HVdwmDMpFCnznkRVFVRb65gkrus5RAKUDOSWs184K9aT8TghQ9G
         WrW/7UySv1uYWvb7Y4/vbtDJZ2QzYCUmoOzV708AxYeD+cEUHa5nrfYmoYW5PdBg1L
         P9wwaaSaWucrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4AA375C0948; Fri,  6 May 2022 12:04:31 -0700 (PDT)
Date:   Fri, 6 May 2022 12:04:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -lkmm] tools/memory-model/README: Update klitmus7 compat
 table
Message-ID: <20220506190431.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <2b237126-88d1-17f2-ce94-2cb679f0b285@gmail.com>
 <20220502165058.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <18d2ad1d-c2a5-682a-91e8-2d8067e62b30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d2ad1d-c2a5-682a-91e8-2d8067e62b30@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:55:02AM +0900, Akira Yokosawa wrote:
> On Mon, 2 May 2022 09:50:58 -0700,
> Paul E. McKenney wrote:
> > On Mon, May 02, 2022 at 09:05:09PM +0900, Akira Yokosawa wrote:
> >> EXPORT_SYMBOL of do_exec() was removed in v5.17.  Unfortunately,
> >> kernel modules from klitmus7 7.56 have do_exec() at the end of
> >> each kthread.
> >>
> >> herdtools7 7.56.1 has addressed the issue.
> >>
> >> Update the compatibility table accordingly.
> >>
> >> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >> Cc: Luc Maranget <luc.maranget@inria.fr>
> >> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> >> Cc: stable@vger.kernel.org # v5.17+
> >> ---
> >> Hi Paul,
> >>
> >> herdtools7 release 7.56.1 is available at
> >> https://github.com/herd/herdtools7/releases/tag/7.56.1,
> >> and "opam update/upgrade" should catch it soon.
> 
> With the help of Luc, opam repository has accepted 7.56.1.
> 
> > 
> > Good catch, thank you!
> > 
> >> I think this is worth for v5.18, albeit it is a minor update
> >> in documentation.
> > 
> > Good point, but let me give it some thought.
> 
> On the second thought, as v5.18-rc6 is expected this weekend,
> I'm OK if this update makes the next (v5.19) merge window.
> 
> This is more of a "news" type update and the "Cc: stable" tag
> should work either way.

Sounds like a plan!  I have this commit positioned to be the LKMM
pull request for the upcoming merge window.

							Thanx, Paul
