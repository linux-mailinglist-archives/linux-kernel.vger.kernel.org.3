Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40FA573D66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiGMTz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiGMTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:55:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514E2C10B;
        Wed, 13 Jul 2022 12:55:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E53A42DC;
        Wed, 13 Jul 2022 19:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E53A42DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742124; bh=kWuy+rhA64DMuaeB8TXkfZuZB3wkP5La509m4dy0efY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mArs6LEWNaAk+iHmyQSAl69AaESH+41g2IDJbSWgJgpuSYtYxyBoaYvKDtFGGUixl
         Dzuf22cFyz32w9jrysA4i+iVXRq9WDjxAp7ScW2+y648C0HyVF6JAp+kUzfPcwZcGx
         l+Sib19W+wht/f8KWBKxML2qiXsCLa3eBX02W5RPaYNxn51t+qhrn+RII7U3v5V+gj
         cGmoaW1IaeeF0ppkXWWfJKei7/BHfSjFfeCE9b94gqahyr8mtpV7KQSnD5C4YFgaol
         Sh8q5KIRJH5HSKZWtap5yAZy7C78fte2CsGh3cDt6Sz4GHHvmySC+EK11ob/VCN1aU
         vrXsmdV1nsLsA==
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
Subject: Re: [PATCH 00/11] docs: remove submitting-drivers.rst
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
Date:   Wed, 13 Jul 2022 13:55:23 -0600
Message-ID: <87sfn44wk4.fsf@meer.lwn.net>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Dear Jonathan, dear Federico, dear Alex, dear Yanteng, dear Hu,
>
> Here is an attempt to delete submitting-drivers with some improvements
> and clean-up in other documentation places to convince ourselves that
> nothing valuable is lost when deleting this checklist.

So my purpose today was to go ahead and apply these patches, but ...

> Patch 1, 2 and 3 is just basic clean-up before adding a new reference (see
> Patch 4). Patch 4 adds the one reference from submitting-drivers, not
> already mentioned elsewhere in the repository. Patch 5 updates a confusing
> statement in devices.rst from earlier .txt/.tex distinction times to the
> new state now with Sphinx & .rst.
>
> Patch 6 finally deletes the outdated document, with a cross-check what is
> covered elsewhere and few open questions (see below).
>
> Patch 7 and 8 have been reworked with the native-speaking doc maintainers;
> they cause no new warnings and are ready to pick,
>
> Patch 9 to 11 are weak attempts to adjust the translation, but they need
> to be taken further by others due to my lack of knowledge on the other
> languages.  They would currently also cause new warnings in the doc-build
> right now. They should not be picked if there is no one to continue
> to adjust the text and fix the warnings on broken references.
>
> I hope that patches 1 to 8 can be picked into doc-next, and then we see
> how to fix up the translations as well.

...even if I do that I get warnings:

  Documentation/translations/zh_CN/process/howto.rst:98: WARNING:
  undefined label: submittingdrivers (if the link has no caption the
  label must precede a section header)

it's actually better if I apply the full series, but there's still a few
of them.  I *really* don't want to add more warnings to the docs build,
so I've backed off for now.

Alex, can you fix the remaining references in zh_CN?

For zh_TW I'm wondering ... that is increasingly looking like an
unmaintained drive-by submission.  I suppose we can just brute-force
remove the references, but I once again find myself wondering about the
value of this translation.  Is there anybody out there who cares about
it who could fix this up properly?

Thanks,

jon
