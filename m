Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE54A80A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiBCIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:52:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45598 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiBCIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:52:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EE961896
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95724C340E4;
        Thu,  3 Feb 2022 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643878323;
        bh=IhdI1guY3ecAV2xFiO7dkON7VUWYyCLOMFteL9VrtA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=cO/8LLrPuubfqPVEOvLdI1Vy20UzW5uoKSiIHLjEaWEJwG9MnO19qK/O6tPbCem28
         DeaEmx7fHRy6JTvMITUcHH6TbyfP6r4r3UmhWr4cRE7s8t5/3BMvafrs6h6LvTJ92N
         ZPY3wvnUsGlwwJtK58dsHT214KFCoisnl0bhHzUh1nIc4zCGSyQ1lgOioH93bkzrwL
         H1KPEyMUKtGe4IusHCXySyZwVWQ3GvN++Dt2HTcSoGiEAv7eK6n+oNDngV2dsW2xWF
         g9Pja7jq+qxt1gksODWQPO31KL5uM8bm57TKu2+L6HywAZMr+o0zvknJ+OIn1tFmDh
         2Cjvi1f8OzmTQ==
From:   SeongJae Park <sj@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Doug Berger" <opendmb@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "SeongJae Park" <sj@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Vlastimil Babka" <vbabka@suse.cz>
Subject: Re: Updated git tree for MM patches??
Date:   Thu,  3 Feb 2022 08:52:00 +0000
Message-Id: <20220203085200.21490-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, 2 Feb 2022 16:21:38 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:

> Hi Andrew, Johannes,
> 
> The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:
> 
> git://github.com/hnaz/linux-mm.git
> 
> however it does not look like it has been updated in the past 5 months 
> or so as master still points to 5.17-rc7-mm1
> 
> Is there another git tree that other memory management related 
> subsystems use for development?

I personally fetch and apply the mmotm patches using my simple and buggy
script[1] and periodically upload to my tree[2].

[1] https://github.com/sjp38/mmotm
[2] https://git.kernel.org/sj/h/mmotm-assembled-by-sj


Thanks,
SJ

> 
> Thanks!
> -- 
> Florian
> 
