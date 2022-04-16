Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113DF503564
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiDPI4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiDPI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:56:26 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65DF47CE;
        Sat, 16 Apr 2022 01:53:54 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8A8E74BF;
        Sat, 16 Apr 2022 08:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8A8E74BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650099234; bh=HsO771ugk1OGvu0LlcMtLIQZRZIcHTGp8Tydegq+Uhk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qCCFXp9QUrNPtEsoiX3ONZ1V4ZCwA7FTEji85FCJqZ2f/QKhcaHB3x51M9haREEGt
         Bg1bmy8AVhUBoa5qYO5nGxBK+rWl7B8VDbrWRvA1z7i5tTO66Pji1JRTuTfCRfcZNQ
         QrGGwu+DJkbgvA6vkFWslTGCvtHIlU9OlnISPD//2kp581iTi3psAX6iOlhYBxN7EE
         50Fc7BYcbHRHRPLo6icd34FWECpu08pPcOLxIdOXe3jbX+NJY2qAt8vWgiJF2VmE1V
         sSDoIbh+S5t2KsvXIzsBrKLYSx2k62vJBCoLpPV8wlh4739+9x8FGxIC+DS9ued9U4
         iyjo2NY1GTdfw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/index.rst
In-Reply-To: <YlPps05WaHH2ghmp@zn.tnic>
References: <YlPps05WaHH2ghmp@zn.tnic>
Date:   Sat, 16 Apr 2022 02:53:50 -0600
Message-ID: <87mtgl2yu9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> So I was thinking that maybe there should be a small set of rules -
> don't want to overload submitters :) - about structure and formatting
> of each documentation section/file/etc so that the final product can be
> more useful and I can actually find something in there. :-)

Totally agreed.

When I took on Documentation/, it was one big pile of random stuff.
Since then, I've been pushing to organize things into various "books"
with some success, so that now we have several smaller piles of random
stuff.  I do think it's an improvement, but the job is far from done.

$SOMEBODY really needs to do a pass over the top-level index.rst and
create some better order there, it's been a while.  I'll try to get to
that soon (if nobody beats me to it - a likely outcome :), but it won't
be right away.

thanks,

jon
