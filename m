Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBB5756C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiGNVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiGNVOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:14:17 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10F140BB;
        Thu, 14 Jul 2022 14:14:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 83EC12DC;
        Thu, 14 Jul 2022 21:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 83EC12DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657833256; bh=g6UqU9BuI9PKghppGhHSoFS2wGdHPaXOchKv/HB4sG8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lv+eaiznJZX9T/gIlxJFnKecOzaNoXIfuvLhye03ADhHGuAIczUheQUwDsO+M0LV+
         eQSraSXSeeB9V8zX6/0zEwwMGVz32RldKAg+NCAUEkAAVVZV1CKO45UsvZc14l1LQI
         aIF1dBB+to7MsNsFkxb/TaRMHq7ZXS7gDtzGKF+wLyiT96Zk9T1q63mvKA/yw42pcO
         kq+2JErBNwo293DNwbgmyxayeNpswXHBPMwZ+EP2j7aNrNj81vWp7rjiavYY37ZrFf
         0hSRoYPLgtt/D10IdO4I8Au2KwyoJTSU9h3vZYSRfmhRjnXE9rYFzEf1I0URnJ+o6T
         6uwoBFGeIsFOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <seakeel@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] docs: remove submitting-drivers.rst
In-Reply-To: <CAJy-AmnkRRqC25N1imgqRCHymh8J4ZE=LYx=-3tG4bhAggViSA@mail.gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
 <87sfn44wk4.fsf@meer.lwn.net>
 <CAJy-AmnkRRqC25N1imgqRCHymh8J4ZE=LYx=-3tG4bhAggViSA@mail.gmail.com>
Date:   Thu, 14 Jul 2022 15:14:15 -0600
Message-ID: <878rovz9aw.fsf@meer.lwn.net>
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

Alex Shi <seakeel@gmail.com> writes:

>> Alex, can you fix the remaining references in zh_CN?
>>
>> For zh_TW I'm wondering ... that is increasingly looking like an
>> unmaintained drive-by submission.  I suppose we can just brute-force
>> remove the references, but I once again find myself wondering about the
>> value of this translation.  Is there anybody out there who cares about
>> it who could fix this up properly?
>
> Hi Jon,
>
> Both zh_CN and zh_TW were fixed on
> https://lore.kernel.org/linux-doc/20220714054013.214031-1-alexs@kernel.org/T/#u
>
> Sorry for the issue

No worries, thanks for dealing with it.  That did the trick, and the
series is now applied.

Thanks,

jon
