Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73351734D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386143AbiEBPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386093AbiEBPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FDFF1;
        Mon,  2 May 2022 08:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DADB81809;
        Mon,  2 May 2022 15:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF51C385AC;
        Mon,  2 May 2022 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651506631;
        bh=NQvbCb+C4wAQFGRknCNY6YIKpWcDLHZNZXxSA8bl4IA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Z4Sll6v2KJtLVIsrvyfapXO/Um5OpswHrBtMGirWGNvi/GuknI1saULkmKyPTFLKV
         K0Vw8GVNZs8YG4ZpJJYF1jJCoZ5Dj3fgX3f4pH7SQ2qVhpTZ5ZKk+X3ypb2W6uY4b3
         oQsQ/VdiyCa1b+7aurtChtRwnUX8/0Zn+y8f6ORgODFLYUvvNTPdmNP+esNXJ7BEUB
         w3zW5V8zA+LIjMjCUJYFygT+BVMMJRLBYGHuXDvXBwiYWLsO/r0DUpPmxaAlpOxom1
         Ulk0ua+OZB1HtK1VDsI97jjZpfqCcSvakt5/mw7FZJzubRFYYExCoiRwBNY8nElIQr
         4VL5OUJAefAIw==
Date:   Mon, 2 May 2022 17:50:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Florian Klink <flokli@flokli.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] HID: lenovo: Add support for ThinkPad
 TrackPoint
In-Reply-To: <20220213214924.32407-1-flokli@flokli.de>
Message-ID: <nycvar.YFH.7.76.2205021750010.30217@cbobk.fhfr.pm>
References: <20220213214924.32407-1-flokli@flokli.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022, Florian Klink wrote:

> This is a re-roll of v3, fixing the block comment alignment warning
> checkpatch.pl is complaining about.
> 
> It's still complaining about line length of the comment next to the
> magic numbers, but as those comments appear the same in hid-bigbenff.c,
> I assume that's fine.

Sorry for the delay. I've now quueued this up in hid.git#for-5.19/lenovo

-- 
Jiri Kosina
SUSE Labs

