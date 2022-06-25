Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA155ABD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiFYRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2E13F27
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EEEDB80B9D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F950C3411C;
        Sat, 25 Jun 2022 17:45:53 +0000 (UTC)
Date:   Sat, 25 Jun 2022 13:45:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220625134552.08c1a23a@rorschach.local.home>
In-Reply-To: <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
        <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 17:15:07 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> [root@manet ~]# cat /etc/redhat-release 
> Fedora release 35 (Thirty Five)
> [root@manet ~]# trace-cmd version
> 
> trace-cmd version 2.9.2 (not-a-git-repo)

Ug, that's very old. Fedora should be shipping 3.1.1 soon.

Right John? ;-)

-- Steve


> 
> usage:
>   trace-cmd [COMMAND] ...
> 
>   commands:
>      record - record a trace into a trace.dat file
>      set - set a ftrace configuration parameter
> 
>  ...
> 
>      check-events - parse trace event formats
>      dump - read out the meta data from a trace file
> 
> [root@manet ~]# 
