Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFF4842C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiADNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiADNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:49:40 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B228C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:49:40 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D6FD2C009; Tue,  4 Jan 2022 14:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1641304176; bh=1qaewoMliUIOWCBFg0odS6ajpeemb562nW7wSu9ZZyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YexELsQJEgNO5m7iGeZlWAIgEcLIKPDheCTVOZ3FNVw4lGnboHwq58ulZYVoDRAWb
         oTulkNKXi8Z7gRGemX0N0NOd8blshqwV1YyD42RyYsqIvfblsMw9m+UZAeZeQNohcT
         KLcBCimY5NNHS5Qnd09zvoaZAjSbSDbU+HrMUnX/wTNAFel2NijNGAx99o1ZB6dUUP
         sfaGHDuljdfO6CCzUnfqfM96tqUoem60Qwy/lp3HoQG4lopDEcDyj0YWkzZ6DDy0nz
         9TC2NnYsQ34BjbWHg3UM5ShKeK3qj9SMVW42gw1HhcUG9c9XdLtuDu0+Ho3iLM9EkT
         NROKSh3faKVlQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5715AC009;
        Tue,  4 Jan 2022 14:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1641304176; bh=1qaewoMliUIOWCBFg0odS6ajpeemb562nW7wSu9ZZyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YexELsQJEgNO5m7iGeZlWAIgEcLIKPDheCTVOZ3FNVw4lGnboHwq58ulZYVoDRAWb
         oTulkNKXi8Z7gRGemX0N0NOd8blshqwV1YyD42RyYsqIvfblsMw9m+UZAeZeQNohcT
         KLcBCimY5NNHS5Qnd09zvoaZAjSbSDbU+HrMUnX/wTNAFel2NijNGAx99o1ZB6dUUP
         sfaGHDuljdfO6CCzUnfqfM96tqUoem60Qwy/lp3HoQG4lopDEcDyj0YWkzZ6DDy0nz
         9TC2NnYsQ34BjbWHg3UM5ShKeK3qj9SMVW42gw1HhcUG9c9XdLtuDu0+Ho3iLM9EkT
         NROKSh3faKVlQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9e56d9f1;
        Tue, 4 Jan 2022 13:49:29 +0000 (UTC)
Date:   Tue, 4 Jan 2022 22:49:14 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9p: add myself as reviewer to MAINTAINERS
Message-ID: <YdRQWtQNO/DA02VW@codewreck.org>
References: <E1n4jXv-000445-GK@lizzy.crudebyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1n4jXv-000445-GK@lizzy.crudebyte.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Tue, Jan 04, 2022 at 01:53:59PM +0100:
> Volunteering as reviewer for 9p patches. As I am quite familiar with the
> 9p code base in the Linux kernel already, plus being current maintainer
> of 9p in QEMU this move probably makes sense.

There honestly isn't much coming in, but it'll be a pleasure to have you
help when you can, I'll push this to Linus with other 5.17 changes in a
couple of weeks :)

I didn't reply to your series for bigger msize, I doubt I'll have time
to do any useful tests for it this round but I'm thinking of taking the
first patch first now as it makes sense independantly.
I feel that the rest needs more attention and will be for next cycle,
sorry for the delay
-- 
Dominique
