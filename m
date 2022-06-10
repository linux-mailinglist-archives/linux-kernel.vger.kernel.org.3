Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B495466DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbiFJMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbiFJMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:50:27 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A232ECC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:50:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by dnyon.com (Postfix) with ESMTP id C66D15F2B5;
        Fri, 10 Jun 2022 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1654865423; bh=flH/0+64HwAQ7lE3Z5vuJ6QNCOk21fe4t375+QFJE8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xucxv35rTLY2+LZapa8yH04nSBk4XqD2xEg83VUFzooLacQ8umX/SXfiEoafyWTJl
         xYpH+k7USc+PGC13nXhFMiItm9k3LOnLCNfh9hq/OmOlyDMomkVFHciL+Bsx4i0dDy
         2Fv5ynDmCT1y0798837PcW1HGgnI7Twq1tLKWXcRs/Z9bNcJTr9QW5OhH5rU/ediYT
         VZ7HuDpQ/u1Fk204KRlOK8Vfn4F9RUxZVmwautpukOOSLSAVWvHtGIYRLAx/FtBS5m
         topGZVhvu3GAFlw+gU2p3+B1/fCh41Beirns1XObYbU2FVsOsYhuEXujOjUL+jzeJh
         lDOztlVUNXiDw==
Received: from dnyon.com by localhost (amavisd-new, unix socket) with LMTP
        id rKwCbj4m4o9f; Fri, 10 Jun 2022 12:50:23 +0000 (UTC)
Received: from dnyon.com (43.red-88-5-137.dynamicip.rima-tde.net [88.5.137.43])
        by dnyon.com (Postfix) with ESMTPSA id 904615F2B4;
        Fri, 10 Jun 2022 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1654865423; bh=flH/0+64HwAQ7lE3Z5vuJ6QNCOk21fe4t375+QFJE8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xucxv35rTLY2+LZapa8yH04nSBk4XqD2xEg83VUFzooLacQ8umX/SXfiEoafyWTJl
         xYpH+k7USc+PGC13nXhFMiItm9k3LOnLCNfh9hq/OmOlyDMomkVFHciL+Bsx4i0dDy
         2Fv5ynDmCT1y0798837PcW1HGgnI7Twq1tLKWXcRs/Z9bNcJTr9QW5OhH5rU/ediYT
         VZ7HuDpQ/u1Fk204KRlOK8Vfn4F9RUxZVmwautpukOOSLSAVWvHtGIYRLAx/FtBS5m
         topGZVhvu3GAFlw+gU2p3+B1/fCh41Beirns1XObYbU2FVsOsYhuEXujOjUL+jzeJh
         lDOztlVUNXiDw==
From:   "Alejandro T." <atafalla@dnyon.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Fix typo in Enum element regex
Date:   Fri, 10 Jun 2022 14:50:18 +0200
Message-ID: <13240249.uLZWGnKmhe@alexbook>
In-Reply-To: <YqMo1gGVgWQDBQjJ@sirena.org.uk>
References: <20220609204220.12112-1-atafalla@dnyon.com> <YqMLmMJ7v48me/5H@arm.com> <YqMo1gGVgWQDBQjJ@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On viernes, 10 de junio de 2022 13:19:50 (CEST) Mark Brown wrote:
> On Fri, Jun 10, 2022 at 10:15:04AM +0100, Catalin Marinas wrote:
> > On Thu, Jun 09, 2022 at 10:42:18PM +0200, Alejandro Tafalla wrote:
> > > In the awk script, there was a typo with the comparison operator when
> > > checking if the matched pattern is inside an Enum block.
> > > This prevented the generation of the whole sysreg-defs.h header.
> > > 
> > > -/0b[01]+/ && block = "Enum" {
> > > +/0b[01]+/ && block == "Enum" {
> > 
> > This makes sense but I'm surprised that we haven't noticed it until now
> > (maybe some awk versions treat it as a relational operator).
> 
> What Catlain said - if we weren't generating the full header contents
> I'd expect things to fail to build normally, but it's entirely possible
> this is just happening to work with some implementations and the patch
> is clearly correct.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Hi Mark, thanks for your review. 

Indeed, I'm building the kernel in Alpine, which uses Busybox instead of gawk.



