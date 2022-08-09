Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8558D5D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiHII4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbiHII4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:56:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1722516;
        Tue,  9 Aug 2022 01:56:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 247E05C0069;
        Tue,  9 Aug 2022 04:56:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 04:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660035376; x=1660121776; bh=xpGxjD2A50
        fdV198hvsG7pRw/iujbctYhUQwuP/l34c=; b=X0G/RfiURd4O9ADNGjzBA7Oapu
        V9IzUW+34EDzGgT1MQ1BXpfaXN5tZEtbW1fUW/94zPSC+L70YC5kKzjVfdd8bzRo
        HIOjnYiO0P+mhmvl0V2F8Q5gf8aP+TJY6CGvi4znPhzDCDHdceHf02aMZuuseNdA
        5Kq/G/bSUetH4RwPiI9Z3T6Q292dzYQkpHTjAZ+Ag+ud1v4SzKZ+WNvJk6t/ZpM2
        3l+SxtR3AO3FllQRE/Lm2Fj8wPSQB5ujnQ2lm8lHhO5TzrOLZH6AE/pJIZvPrgND
        B2EHrwKpziZA7ggOteYqusLzvvLV9BhMocYdZBTsn5vZkAsThuubgaj1Y/QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660035376; x=1660121776; bh=xpGxjD2A50fdV198hvsG7pRw/iuj
        bctYhUQwuP/l34c=; b=UyGwNjr97EMolB4dTDz2ap5ZwJLiHUcaoQVZXK0AciJv
        BwSkiu8UxchaL82nP3WwxSLE9lMkDFLlsJbb6WDVoF1pEO0X1Zjwbt2+haR3U9fD
        uXVuDNCP00hLqO7BynPspfDdpZMWzqD6vRroRCnazou5AoXtEhdeQArTSpEG8ta6
        5zG8JRtygApyzL9BSpafIS27vaCfdbSJpMZAqMPkxUHnVzn6XsfJYnrX+3YWAgbM
        +RrgxxSmw5qDHy6oNw/HvDBLR+AY+rTfJDjCPeLH2nw/+A46dJNsMAsRwBgiHFcz
        8OgXX/nrGQgS5LBNsTDYFmU7DYSL0TQ9A/8TpWSEiA==
X-ME-Sender: <xms:LyHyYtEjfdv7TlmkligTpGGebMhTKY3a8VHMvmyKOZMQIbpQjiUPOg>
    <xme:LyHyYiUiGG1u5GYc3ICYFNoPMNgccCiBRrCeeKyCrw41eS9syuN96wsnARkj9nDdy
    jRlvkI8fAM_hWKCN14>
X-ME-Received: <xmr:LyHyYvIfcKmnEHcZx8FFmcuq3rv5AYjrkXXXgVqvuGXIJp2HzaPx-DFvDGWCp8XneWUYaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epfffgfeelieeitddtteeivdetueejhfejfeejteehvefhgeefueeftdehjeeukeelnecu
    ffhomhgrihhnpehuihgtrdgvughunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:LyHyYjFybHWcHAvfvYOEg58dlybi-OZkiVS7kRI1VJlgohYoF26Hug>
    <xmx:LyHyYjVpNG1oirgd9PCRW98K5HC0nEZha8BUjqc5UMyNCV2hct7I_Q>
    <xmx:LyHyYuMFmQkcDTW3-RUCRyhAeHwv7hI61uSCHth8fzMN9zgq0TV5pw>
    <xmx:MCHyYuQk2QMupMQY0v5Uw1KeDla5QJYGKnRZOkDF-1wDi1Xwf6ZVOQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 04:56:11 -0400 (EDT)
Date:   Tue, 09 Aug 2022 20:55:58 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <AHBCGR.7I4U7CDRZ3J83@ljones.dev>
In-Reply-To: <CAHp75VfZeuuQjfM+CY4nxrFJQcfpdHVVzyj6GLjeweT3ycSn5A@mail.gmail.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
        <20220809025054.1626339-2-luke@ljones.dev>
        <CAHp75VfZeuuQjfM+CY4nxrFJQcfpdHVVzyj6GLjeweT3ycSn5A@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Aug 9 2022 at 10:46:33 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  Adds support for TUF laptop RGB control via the multicolor LED API.
>> 
>>  As this is the bas for adjusting only the RGB values, it sets the
>>  default mode of the keyboard to static since there is no way to read
>>  any existing settings from the device. These defaults overwrite the
>>  booted state of the keyboard when the module is loaded.
> 
> ...
> 
>>  +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>  +                               rgb->save | (rgb->mode << 8) | (r 
>> << 16) | (g << 24),
>>  +                               (b) | (rgb->speed << 8),
> 
> Too many parentheses.

Uh, yeah. I was unable to find concrete info on this. I at one point 
experienced an issue where the order of operations *without* 
parentheses ended up as "x | y << (8 | z) << 16". But now I'm not even 
sure if I remember that correctly. I see the order here 
https://www.cs.uic.edu/~i109/Notes/COperatorPrecedenceTable.pdf

I'll do as said and test it to be certain.

> 
>>  +                               &ret);
>>  +       if (err)
>>  +               dev_err(dev, "Unable to set TUF RGB data?\n");
>>  +
>>  +       return err;
> 
> How ret is being used?

Damn.. fixed now.

> 
> --
> With Best Regards,
> Andy Shevchenko


