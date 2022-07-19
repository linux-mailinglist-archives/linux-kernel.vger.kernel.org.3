Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD257A21D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiGSOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiGSOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BADF11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91FA7617D5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CBAC341C6;
        Tue, 19 Jul 2022 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658241916;
        bh=hINWidOpy5gL1hmDNbsMG7AYAFVcn/xR5l+UmZQONaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PR1WSaLDKf1or+pdjg9Jpwzs2K5X+r1wuIAo19AcZG+Efdlgied+hHdZOcgGLOKoj
         kks3KYgnQZAUi3MBLX1LkzIIwElm3nj9//j6JqHa0zNsCllDZxy/JAmr72RZkKzv4Y
         457b7KErFQdSCyIcdediQnVeeJsVXM8zLv91g3UlIizYS7iL+27NYinCJR0vj9UtAY
         YkN5buPB5tlV749xaU8tq3wnyBrOGMnqsu83OdjmJqLFfuexxXdqZ2vhFgEbldxFov
         j5t8pjScCztth7fA8a7vU2hWmPfQOG4SCP1VStRwfru2wUmDA+RefgQGv7qLLvQirl
         R/pG+pZOxLfIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 939F440374; Tue, 19 Jul 2022 11:45:12 -0300 (-03)
Date:   Tue, 19 Jul 2022 11:45:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <YtbDeMAdspQg5EA2@kernel.org>
References: <YtQLDvQrBhJNl3n5@kernel.org>
 <28992751-7de9-7900-ae78-be1a5d30c3c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28992751-7de9-7900-ae78-be1a5d30c3c0@redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 19, 2022 at 03:15:58PM +0200, Paolo Bonzini escreveu:
> On 7/17/22 15:13, Arnaldo Carvalho de Melo wrote:
> > tldr; Just FYI, I'm carrying this on the perf tools tree.
> 
> Thanks, I'll add a sync patch myself to the KVM tree.  Do you have a script
> to do that?

we have tools/perf/check-headers.sh that flags differences, then to
address it I copy and send a message, yeah, some scripting here would
help some.

- Arnaldo
