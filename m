Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133BD528D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiEPSw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345082AbiEPSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:52:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F23EB83;
        Mon, 16 May 2022 11:52:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652727173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aD86N6duEnXjJa8sE+96XgfKrmYJDh6pUQ8+2kW0T4w=;
        b=Pm+mXx87j1ajufcmunnMTRWiGm075XOHoA4ZpZtnq6Jw7QvN3bI926/xg07KmtVe+E0/Cj
        RbV5zl4lPrFE6gAF1S0gJO6E0SZK1CE7VD7OGVBBRgbOHY8UozE/+mk7MfR0XfWT/DXZwZ
        dQbhymPUCOA4KL8iSBJPv+yZYw7qR8KJU0CaQnDFFh5Uzy1T1/j3i/NrFh80fUkSLYW4QR
        y0qsW+E6/uvmfbJJpVwjzrPPgKKlCiUO8pOI8Qox2qxY7KalojEJeDBcsEuB9RWY906lCR
        wyn9PAp07g/fdLI0mqQGJUcBdUck1VAHRLKapBRmbiVI6cHkRx0T65ZDcS8n5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652727173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aD86N6duEnXjJa8sE+96XgfKrmYJDh6pUQ8+2kW0T4w=;
        b=PI7CIio8mQoCEEXktb2auMn/c1mnJfSiaku1HzQQtXRJebUdKqfF6RDmv1DjooeHW4viMW
        DQHwkVusAEwflmCw==
To:     Max Mehl <max.mehl@fsfe.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
In-Reply-To: <1652706350.kh41opdwg4.2220@fsfe.org>
References: <20220516101901.475557433@linutronix.de>
 <1652706350.kh41opdwg4.2220@fsfe.org>
Date:   Mon, 16 May 2022 20:52:52 +0200
Message-ID: <87zgjhpawr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16 2022 at 15:14, Max Mehl wrote:
> Thank you for picking up the effort to add license (and perhaps also
> copyright) info to all files in the Kernel.

Adding copyright notices retroactively is not going to happen
ever. That's just impossible.

>> The exclude of files and directories is hardcoded in the script which makes
>> it hard to maintain and the information cannot be accessed by external tools.
>
> Unfortunately, excluding files (i.e. not adding machine-readable
> license/copyright information to it) would also block reaching full
> compliance with the REUSE best practices. Have you considered making
> them available under GPL-2.0-only or a license similar to public domain
> [^2]?

The LICENSE directory is already handled by spdxcheck as the license
information is read from there. And no, we cannot add a GPL-2.0-only
identifier to all of the files under the LICENSE directory for obvious
reasons.

license-rules.rst is not longer a problem as all incarnations have a
proper SPDX identifier today.

Thanks,

        tglx
