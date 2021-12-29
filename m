Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B374815D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhL2RcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:32:16 -0500
Received: from verein.lst.de ([213.95.11.211]:38294 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241117AbhL2RcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:32:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACACB68AFE; Wed, 29 Dec 2021 18:32:09 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:32:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Holger Kiehl <Holger.Kiehl@dwd.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: bpfilter: write fail messages with 5.15.x and centos 7.9.2009
Message-ID: <20211229173209.GA27943@lst.de>
References: <71e27b99-ef9c-4563-833d-e6eab5419cdb@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e27b99-ef9c-4563-833d-e6eab5419cdb@diagnostix.dwd.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-32 is EPIPE.  But it might be a good idea to include the relevant
maintainers.

On Wed, Dec 29, 2021 at 01:27:58PM +0000, Holger Kiehl wrote:
> Hello,
>
> I just upgraded the kernel from 5.10.x to 5.15.12 on an old Centos
> 7.9.2009 server. The kernel is build on a new fedora 35 system
> via 'make binrpm-pkg'. With this I see the following errors:
>
>    [  232.140766] bpfilter: Loaded bpfilter_umh pid 6327
>    [  232.152144] bpfilter: write fail -32
>    [  232.187175] bpfilter: Loaded bpfilter_umh pid 6330
>    [  232.198540] bpfilter: write fail -32
>    [  232.234604] bpfilter: Loaded bpfilter_umh pid 6332
>    [  232.245916] bpfilter: write fail -32
>    [  232.281883] bpfilter: Loaded bpfilter_umh pid 6337
>    [  232.293222] bpfilter: write fail -32
>    [  232.335798] bpfilter: Loaded bpfilter_umh pid 6380
>    [  232.347157] bpfilter: write fail -32
>    [  244.411821] bpfilter: Loaded bpfilter_umh pid 6712
>    [  244.423216] bpfilter: write fail -32
>
> These appear as soon as something is done via iptables (setting
> something or just viewing). Is this something I need to worry
> about? Under 5.10.81 I did not see these messages.
>
> In Jul 2020 I see a similar report 'bpfilter logging write errors in
> dmesg', but could not find a solution.
>
> Any hint what I can do to fix this?
>
> Thanks,
> Holger
---end quoted text---
