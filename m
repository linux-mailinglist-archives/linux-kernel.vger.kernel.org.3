Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD155CFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiF0QCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiF0QCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:02:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA560D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F47BB818A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E98C3411D;
        Mon, 27 Jun 2022 16:02:07 +0000 (UTC)
Date:   Mon, 27 Jun 2022 12:02:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     John 'Warthog9' Hawley <warthog9@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220627120206.182da050@gandalf.local.home>
In-Reply-To: <0FA59723-8784-4D28-AB5B-049D605095B4@oracle.com>
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
        <20220627114340.4d89842b@gandalf.local.home>
        <0FA59723-8784-4D28-AB5B-049D605095B4@oracle.com>
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

On Mon, 27 Jun 2022 15:51:04 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> I'd like to avoid having to maintain the latest version of
> the tool and its libraries by hand on all of my development
> systems.

But can you just verify that the new ones fix the issue in one of your
builds?

I'm not a fedora maintainer, so I have no control over what they ship. But
if you can prove that the issues you have are resolved when upgrading, then
there's nothing more I can do. It's up to fedora to update the libraries.

If it's still broken in the latest versions, then I can do something. But
without verification, this is just a fedora bug, not an upstream one.

-- Steve
