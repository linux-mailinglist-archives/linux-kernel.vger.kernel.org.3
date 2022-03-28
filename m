Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFB4EA102
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiC1UDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbiC1UCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:02:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778668FB4;
        Mon, 28 Mar 2022 13:00:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E7E6E37A;
        Mon, 28 Mar 2022 20:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E7E6E37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648497648; bh=Snyp6ooM0JYXk19YcbpMhdr8RnS/Lw19Orqa6QdQGts=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MJUsnoi0Om1wtvUQLRqGY/M/Pv0vNDW3VdKdiL7k4LbqE2qvWnFYDekb/tXHvJpWp
         GU4JSyYmHwTbWsXQalCAJlTBbnhViFcpW9GBnyurYWeMzK0+fL38ljEpdhmoVrKfHW
         ryrKuJmkFEKvWfUx+yyYY/xtcIzy/oQfc7SXXZCubziCpryrRA4RtsG+LljxkqlshJ
         EX068KSZQYhMhQ6S9RDpfyeG0UHgmyt69vfVxAoZfHpcCFh218zs+LIfT4hFEl56Ib
         3yhOgXaP3YiUomaE2TY3mVDUf3fAGjTMXSlZKbz9KvmSAzirberU4HPlPncOvjLiI3
         EcXRgqUrWJHUA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 0/6] Better handle dependencies on Sphinx extensions
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
Date:   Mon, 28 Mar 2022 14:00:47 -0600
Message-ID: <87v8vx7spc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Sphinx has its own way to identify the need of rebuilding the documentation.
> It means that extensions need to use an internal API in order to notify about
> the need to consider other files.
>
> The kerneldoc.py extension already does that, maintainers_include.py doesn't
> need (as it uses an API that internally does that), and kfigure.py does it on a
> different way.  So, those are already safe.
>
> However, other extensions don't notify nor implement their own checks,
> so, when a file that was parsed by them is changed, the corresponding 
> documentation won't be rebuilt.
>
> This series add support for it for ABI, features and kernel-include.

Series applied, thanks.

jon
