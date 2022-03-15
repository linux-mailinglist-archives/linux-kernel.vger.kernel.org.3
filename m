Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA24DA335
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbiCOTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiCOTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:21:40 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56B3A72A;
        Tue, 15 Mar 2022 12:20:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 486CB5D30E;
        Tue, 15 Mar 2022 20:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647372024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=dPNeZhQEBf2PMi45+dp4nB2zJ3oU/+iXDWONotEcGmc=;
        b=Ec9xh1iHziUQdyFoG8JXLqFgo6E/AMTD++oBTTm3sJGo9lkNF6Br4eAuTxCU/08za9nFt2
        t7ZXZtXpy2h7Geid+o+XkXPM4jUEu/tKpNJxf9F2UEZOvIgGaj+ctxYyTKLGE0F03uotrQ
        5CVq/7yjth9BMPKT61j3Ww/N+D/2/ABzELCIS+oN/YYqixPZDErNWPwHOv1YDEb4E2kQYl
        J5XZgacMGrmlEUQ5UJTgrdbCWtO62aaL6h4EN2ClzSCPpWs0z7G7lbzJo5Jynrs2Eg3Xrm
        bB2mMPj/SMpFR8cPRYiDw8IAlCR20DuHUIWvIPdhNMNobGLvQwUFKqJcZKSGLg==
Date:   Tue, 15 Mar 2022 20:20:19 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [ANNOUNCE] 4.19.232-rt104
Message-ID: <20220315192019.4yvkc4ts2rg5dc3q@carbon.lan>
References: <164642254363.3441070.3803906129050387693@puck.lan>
 <20220315184005.GB30901@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315184005.GB30901@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:40:05PM +0100, Pavel Machek wrote:
> > I'm pleased to announce the 4.19.232-rt104 stable release.
> 
> Thanks for all the releases. I believe there's tag missing for
> e9e0405cb34e459b713ed0aca4e3ab5ef61f540e aka 4.19.219-rt98. Tags are
> there for for other releases.

Clark, if you still have the original tag on your local machine, could
you push it? If not I can add the tag, but obviously, it's not matching
then with your signature.
