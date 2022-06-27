Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06C55D92C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiF0Pnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiF0Pns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:43:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79430DF92
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9998ACE1B74
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE8BC3411D;
        Mon, 27 Jun 2022 15:43:42 +0000 (UTC)
Date:   Mon, 27 Jun 2022 11:43:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220627114340.4d89842b@gandalf.local.home>
In-Reply-To: <B902ACBA-9318-418D-A14A-1411E7A8B47D@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
        <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
        <20220625134552.08c1a23a@rorschach.local.home>
        <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
        <20220625190105.750bbb0a@rorschach.local.home>
        <B902ACBA-9318-418D-A14A-1411E7A8B47D@oracle.com>
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

On Sun, 26 Jun 2022 17:09:31 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> [cel@manet lib]$ cd /usr/lib64/
> [cel@manet lib64]$ ls libtrace*
> libtracecmd.so.1  libtracecmd.so.1.0.0  libtraceevent.so.1  libtraceevent.so.1.2.1  libtracefs.so.1  libtracefs.so.1.1.1
> [cel@manet lib64]$

According to https://trace-cmd.org

The latest libraries are:

 libtraceevent 1.6.1
 libtracefs 1.4.1

I'm guessing you may have a buggy version.

-- Steve
