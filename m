Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7446A56E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348327AbhLFTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348323AbhLFTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:16:56 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6EC061354;
        Mon,  6 Dec 2021 11:13:27 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC7E0385;
        Mon,  6 Dec 2021 19:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC7E0385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638818006; bh=vtJqhT8wWEpKGJqC2oyVtUUevlM5VRcgxZba4H+q3Xk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pI2l69LHcSzzoB5cSXtOXVU4R/b2CowKOeO7Ie+OSTihDPKBc8yLDMrMSe0YLbHIy
         vzRHuwrjKr3rYN+9+XGk7kDCVb+REKzA0cBgC7zayRgAjGYY8ra5fwGoQ9c7sTQ/NP
         U3fxRHLZYO1UYS8f4tBppbWJCSOdKocDq1mogawDei94vQjpG0Zw0hvoZxZYFrztnI
         5MDsfhg08FwjunEE5O0JCpLcGd0Zz3jmVqK6hDKYkWFO0pm+0Sktij2dGhjKAeWQqF
         CQm+GF4PqPaYy/wXTTYFrJEVONSSfw0gptt1J+1veDDNI1qFkHZCECF33MTHZbn4LG
         cckRGNT4Hz0Sw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [GIT PULL] Documentation fixes for 5.16
In-Reply-To: <87y24x39wi.fsf@meer.lwn.net>
References: <87y24x39wi.fsf@meer.lwn.net>
Date:   Mon, 06 Dec 2021 12:13:26 -0700
Message-ID: <874k7l35t5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow I managed to not CC the usual lists on this one, so, for the
record...  

Jonathan Corbet <corbet@lwn.net> writes:

> The following changes since commit b96ff02ab2be1791248237b1bf318aaf62e8b701:
>
>   Documentation/process: fix a cross reference (2021-11-17 06:12:14 -0700)
>
> are available in the Git repository at:
>
>   git://git.lwn.net/linux.git tags/docs-5.16-3
>
> for you to fetch changes up to 333b11e541feeb79e7cce31dd5b280ceded388e4:
>
>   Documentation: Add minimum pahole version (2021-11-29 14:48:00 -0700)
>
> ----------------------------------------------------------------
> A few important documentation fixes, including breakage that comes with
> v1.0 of the ReadTheDocs theme.
>
> ----------------------------------------------------------------
> Akira Yokosawa (1):
>       docs: admin-guide/blockdev: Remove digraph of node-states
>
> Arnaldo Carvalho de Melo (1):
>       Documentation: Add minimum pahole version
>
> Erik Ekman (1):
>       Documentation/process: fix self reference
>
> Mauro Carvalho Chehab (1):
>       docs: conf.py: fix support for Readthedocs v 1.0.0
>
>  Documentation/admin-guide/blockdev/drbd/figures.rst       |  4 ++--
>  .../drbd/{node-states-8.dot => peer-states-8.dot}         |  5 -----
>  Documentation/conf.py                                     | 15 ++++++++++-----
>  Documentation/process/changes.rst                         | 11 +++++++++++
>  Documentation/process/submitting-patches.rst              |  3 ++-
>  5 files changed, 25 insertions(+), 13 deletions(-)
>  rename Documentation/admin-guide/blockdev/drbd/{node-states-8.dot => peer-states-8.dot} (71%)
