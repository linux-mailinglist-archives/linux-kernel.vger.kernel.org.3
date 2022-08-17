Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01C5596751
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiHQCSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiHQCSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:18:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34137DBC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xCvAW61AQkpGVIzO/D+eoNaokcqxII5Zta5+47Ywhf0=; b=SUqjN4Pd2VKsmgqB3VmO7l1Tr8
        AKOn3HJKax6AdIGABPutg9F7tecdl1DJDLTRh2nYlt2ABfRyMVdRYIA/rAsn/lj5szzgyJ2OTiIN3
        2Rx1IOsykfeSfXbXdkHJtiyj6mWhIuMEBw24uz5mrHwzo8q2cKLZqOOzHUC7lYbCFFd9W1fUK70cN
        j03Zjpe0BTof6w/qghpezZPsvHbU2az5wZYKtxQzezreOn0pIGhXitLQeG6q+Smz7a9Qa8ZYPetRX
        cL6rB8xOspk1G5yKjrf5tOY9oti5fDciS6IWL0689DHcS8IX3frd/Pb2i8RPpiRiFwhv0d4pOG3iL
        X3AB5m6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oO8dA-005ETy-Ok;
        Wed, 17 Aug 2022 02:18:04 +0000
Date:   Wed, 17 Aug 2022 03:18:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve the kernel quality and reduce the amount of BS
 patches
Message-ID: <YvxP3LrvHLhFClBd@ZenIV>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
 <YvxNvpF7n1VqNnbD@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvxNvpF7n1VqNnbD@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:09:02AM +0100, Al Viro wrote:
> this idiocy has gone too far    
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

	Seriously, folks - the stream of patches with no better
explanations than "The Most Holy checkpatch.pl Says So, Must Appease
The Spirits" ought to stop.

	If you are changing something, take care to explain _why_
is the change made.  Reference to a tool that has pointed you
towards the location you are changing does not replace that.
checkpatch.pl is a script.  A dumb one.  It's a bunch of heuristics
that correlate with code being potentially fishy and worth looking
into; those are occasionally useful, but it's not an oracle.
