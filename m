Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2756213C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiF3R0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3R0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:26:44 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4B3E5FD;
        Thu, 30 Jun 2022 10:26:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3DF194B7;
        Thu, 30 Jun 2022 17:26:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DF194B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656610003; bh=ei+caOvlg/2HIJ6D0lCC+JmQefKHErSrMXRIWXCQdbE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jHNm3o3pk7EiO4OrBrWRB7786IghQ2dk2tbsU9B16XhyTn3vTWOnzzmV1vavgpN2f
         9ntM0ufTApzemzX5rObg2X9VE685rLMXuMcfIzUpGt9PLiwSJlEskA9Ak/fQI+v9Aa
         sJgrXl68rvlWlr+ox157+ZpKRVRgc2XFRm0KgJmaaAPf8O81O/Gui8VYOwJSWikHbi
         nDDs9MqCgs0oM5T7c+fr47d/oxeWcS2igAHoQu/pwjYa+VevP5RExMt3+bDLgHsaL0
         cALqRXPij2k3HkVEri+xJivdHATF7a5Ft9CRXU9eP/GP2UkkyoWrcc03AsCq+UIF55
         5wCSxrfwtpI8g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [RFC PATCH 00/11] docs: remove submitting-drivers.rst
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
Date:   Thu, 30 Jun 2022 11:26:42 -0600
Message-ID: <87y1xenju5.fsf@meer.lwn.net>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Dear Jonathan, dear Federico, dear Alex, dear Yanteng, dear Hu,
>
> Here is an attempt to delete submitting-drivers with some improvements
> and clean-up in other documentation places to convince ourselves that
> nothing valuable is lost when deleting this checklist.

I am totally in favor of doing this; that document has not served any
real purpose for a long time.  Resend with the translation tweaks and
such, and I'll happily apply it.

> As future work---with this one submitting checklist gone---I see the harder
> follow-up task to synchronize and clean up the various submission hints/
> guidelines/checklists in the remaining kernel documentation that partly
> overlap and differ in detail, their structure (unstructured, unordered
> lists vs. sections and subsections) and their state of being outdated:
>
>   Documentation/process/submit-checklist.rst
>   Documentation/process/submitting-patches.rst
>   MAINTAINERS#Tips for patch submitters
>
> My next task at hand is to read through all three documents, figure out
> what still applies and what is outdated, determine a good common structure
> for all three documents, include cross-links and make them to some extent
> follow a clear consistent policy. E.g., one document is a more detailed
> description of everything mentioned in the short list of another document.
> I will try to work through that in the next months or motivate and guide
> some colleague or mentee to work together with me on that.

This seems like a good exercise as well.  I think the MAINTAINERS text
should go away entirely, that's not really an appropriate place for it.
submit-checklist.rst hasn't seen any real attention for some time; I'm
not sure how useful it really is.

What I would *really* like is a version of submitting-patches.rst that
is not a "War and Peace" sort of reading experience.  That is a lot for
somebody to get through before they can send their first patch...but
it's not easy to make it shorter without losing important stuff.

Thanks,

jon
