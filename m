Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4E53CAC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiFCNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFCNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:42:22 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41207286EE;
        Fri,  3 Jun 2022 06:42:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DAFBC37C;
        Fri,  3 Jun 2022 13:42:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DAFBC37C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654263741; bh=CDEFvP1Jem9noEONiIVLPpUiWeuxuA4FOUJvVBoNyRM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BmHQIy6xlyruDDB97VmmT+z2kXomItXBu+a3hzmfZLYQ03V2gblDOsEcjydBwodUR
         vs2TnoZKGKYizErBui6DzOWmpEJ090dq0OkPrlUNOFMUzm+UdfWlGOrM6o4DPhPOZg
         n7fxQ2+SYW97e6ri4SmiipMxlczarYyDnBrE4L6Tq59ojemmY/ccttKkGySqv4OIi8
         UXK0VAdEdWS9U9XjsXW27k50b1JOVcw76TEJ9aI54lw65MeiS9NF1ipFUDnG9DylzA
         ZjEANsD5/j+Tv+m/POkLsfi2ecVwe1+jrIyRjOqo4VZvsCt1Sv2fCVwP4Db9HqehcE
         7WH1accqk290w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Add leds-qcom-lpg entry to documentation table of
 contents
In-Reply-To: <20220603025735.17953-1-bagasdotme@gmail.com>
References: <20220603025735.17953-1-bagasdotme@gmail.com>
Date:   Fri, 03 Jun 2022 07:42:33 -0600
Message-ID: <87bkv9x3qu.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> After merging linux-leds tree to the mainline [1], htmldocs build produces
> a new warning:
>
> checking consistency... /home/bagas/repo/linux-stable/Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
>
> The warning above is because leds-qcom-lpg.rst is missing in the table of
> contents.
>
> Add the missing entry.

The fix is good but ...

> [1]: https://lore.kernel.org/all/20220531200619.GA8906@duo.ucw.cz/
>
> Fixes: e98a860f65428a ("leds: qcom-lpg: Require pattern to follow documentation")

...I'm confused as to why you used that commit for a Fixes: tag.  It
touched the file in question but didn't add it in the first place; I
think 24e2d05d1b68 is the droid you're looking for.

jon
