Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCD53715B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiE2O1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiE2O1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:27:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0F5E156;
        Sun, 29 May 2022 07:27:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8852B49B;
        Sun, 29 May 2022 14:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8852B49B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1653834465; bh=50sOo+ZraqVyLzLvKXx59grImfKSYAwBnI+Uwy3gnPI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H9rxojD+HWuaNLl5INayviDksw0eEMogvk7K3jIyadQ/KSbtAuwJAXZ9hXzwGoojz
         veQO8xgbRREDNh+8eWFSlLZ9ujRCENMyn2b0tABwuDBvIGowUMQV9oYH2+CBRLtVLr
         V+KNl8N0kV+zGc+9MbBWH2nHOmM/WG/DpWjkDDih2g0jD2aduzHs/dom5m7V3YY1Oy
         tIuDgdJ/dF0j7+Ud48gq41onxs79zzX+r3/nPZMQF2TbAE0LSGbW0C+uaxOzoLK53d
         jGnwglKizC5e/Lf7KC1vIWBOej38szkCm7L0/+2xkujwjJup9brrnPO9CZh9ML8ebC
         f7v7/JL/Za0WQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs: move Linux logo into a new `images` folder
In-Reply-To: <135d2b02-a888-f3ae-ee16-ef30ab80e529@gmail.com>
References: <20220528153132.8636-1-ojeda@kernel.org>
 <135d2b02-a888-f3ae-ee16-ef30ab80e529@gmail.com>
Date:   Sun, 29 May 2022 08:27:51 -0600
Message-ID: <8735gs9zx4.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 5/28/22 22:31, Miguel Ojeda wrote:
>> Having assets in the top-level `Documentation` directory can make
>> it harder to find the documents one needs, especially if we want
>> to add more of them later on.
>> 
>> Instead, create a new `images` folder inside it that is used
>> to hold assets such as logos.
>> 
>
> Do assets include CSS and JS files?
>
> And if we plan to add non-image assets to images/, that directory will
> be misleading. I suggest to name the directory as assets/.

Can you please point out any CSS or JavaScript files in the kernel tree,
or any that we might expect to have there anytime soon?  I don't think
this is a case we need to be worried about.

Thanks,

jon
