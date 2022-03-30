Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31A94EC690
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbiC3OcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiC3OcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA5640936;
        Wed, 30 Mar 2022 07:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9126B81D4D;
        Wed, 30 Mar 2022 14:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA9C340EE;
        Wed, 30 Mar 2022 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650612;
        bh=rEqGedn9d4MjCXFpyjzFD9lEwuye6EEdw12KNXE3bio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=masp/RftFOVahxK1fGCaeRXO2bjemme7tp1a/r1KeID3UdYKqFCwVA7cQJnXtpue6
         4x7flx2PrGHcZWA+SxzAXYLvmpmQsm71maTi2GA4Kkr1gArpFmNnxbJA9o0Tf/rM6x
         pdj4AgUu9uFpkOsR9VNN87qppghZBKjsAATGOdzoafUW5jniTiknBMWZTtryyJVCsY
         cOaAAkreza92+ayWxADBCzT/JtTWoMmyPZo9I5PxLBEcV8HuOAC9dZpJ5uhVBxhGcU
         7VxDb33q+6Y+F7O/WvxN2so3YpYLyoTFEZje74vIPeHk/ytimoY/JsnxRpPn6URTNq
         xWUaXanS4MqRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 952C940407; Wed, 30 Mar 2022 11:30:09 -0300 (-03)
Date:   Wed, 30 Mar 2022 11:30:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Message-ID: <YkRpcW4PkVH59axm@kernel.org>
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
 <YkRlZhaEgmJ5Q4k/@kernel.org>
 <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
 <YkRo/PtIf9aOqpZV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRo/PtIf9aOqpZV@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 30, 2022 at 11:28:12AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 30, 2022 at 04:22:35PM +0200, Matthieu Baerts escreveu:
> > On 30/03/2022 16:12, Arnaldo Carvalho de Melo wrote:
> > >> Thank you for your patch, I just tested it and it also fixes the issue I
> > >> reported!

> > > I'm taking this as a:

> > > Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

> > > Ok?

> > Yes, OK for me, thank you!

> > I never know what maintainers prefer when there is already a
> > "Reported-by" tag so I didn't specify it but I will do next time.

> Right, I'll stick both R-by and T-by.

> There are cases where people just report and don't test, or just ack.

But when you actually provide the:

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

It makes the lives of maintainers using b4 easier, as it'll collect
those.

About b4: https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

- Arnaldo
