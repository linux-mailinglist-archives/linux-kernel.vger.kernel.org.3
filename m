Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26AF493C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355374AbiASO60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:58:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44536 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355417AbiASO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 302F9B80E09
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62618C340E1;
        Wed, 19 Jan 2022 14:57:42 +0000 (UTC)
Date:   Wed, 19 Jan 2022 09:57:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Yuntao Wang <ytcoode@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Remove redundant assignment to variable ret
Message-ID: <20220119095741.1fff2305@gandalf.local.home>
In-Reply-To: <CAKXUXMzmLZ+RzVJ4AmSd6vCjtoATCq+AC3WRE3xbtD7AkgXvZA@mail.gmail.com>
References: <20220117074117.3770-1-lukas.bulwahn@gmail.com>
        <20220119041737.1805441-1-ytcoode@gmail.com>
        <CAKXUXMzmLZ+RzVJ4AmSd6vCjtoATCq+AC3WRE3xbtD7AkgXvZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 08:15:10 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> > Maybe we should deal with the error return code more appropriately,
> > at least print some warnings?
> >  
> 
> This might be one way of dealing with it.

Actually that is the way it was suppose to be dealt with. I just never got
around to writing the message :-p

-- Steve
