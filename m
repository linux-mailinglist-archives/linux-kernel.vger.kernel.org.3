Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6958ECED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiHJNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiHJNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551C22298
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFB061454
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD1C433D7;
        Wed, 10 Aug 2022 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660137522;
        bh=WN2qYjC4Bbzk17ZsQf+E7yH/HW9smIm3x112ImizG7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9rWHa97R+I+NNkE7Xjif49Fx+x0fikN6hP6X+gJLipxINhxx4q61/7rJddHp5ScJ
         nKKxOOHE9JjmTUlbkYGcHO5fT5lIM5xObvCP5K07kTNjht47jsQhk1KaVYE2Wim2Om
         YieTWorWpMsKTDjWnEPww0r7PJ6Xb5cxWIc1cHySBu5o5Ivjw8oR84b6fRyxBD3jOs
         7r6J2NoFU7dydDQlP1pJ000VFABO22cJ5rI3rfW8TMtYk5bifGjjlcKei1mWLodF/R
         KmqHfjWSosbL29FkYY5c3wxb9aczjI3zng1hReEJ0aY0KrOoygS7NkqUbs6+HnijQw
         0Iu496tZWYyOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96DB54035A; Wed, 10 Aug 2022 10:18:40 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:18:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Fix reference to perf insert instead of
 perf inject
Message-ID: <YvOwMEfvhcQbs27O@kernel.org>
References: <20220809123258.9086-1-adrian.hunter@intel.com>
 <CAP-5=fVBHQby5+BxA4T7V9iH9edsCJ6i6cfJS62j275Q7ZXuTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVBHQby5+BxA4T7V9iH9edsCJ6i6cfJS62j275Q7ZXuTw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 09, 2022 at 09:50:55AM -0700, Ian Rogers escreveu:
> On Tue, Aug 9, 2022 at 5:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Amend "perf insert" to "perf inject".
> >
> > Fixes: e28fb159f116 ("perf script: Add machine_pid and vcpu")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

