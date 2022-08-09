Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587F58D5E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiHII6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHII6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:58:31 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6E220FF;
        Tue,  9 Aug 2022 01:58:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 98B2E5C0107;
        Tue,  9 Aug 2022 04:58:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 04:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660035510; x=1660121910; bh=G2NhCb66cb
        19eINodXsc2D+4/M/84dcn7QljyzSwVWg=; b=koXXtds2oHmQJyH6Qn+1botDjJ
        74bB5oOkvE8JpeBjk/n3kQrf0aBVpcPc6aoyg1BAnGtkpJRA1IJtZCOZXmdFY3Jx
        39pOk4ajHm0296SOxEl0oQLmW2+PfSkz3qE9q6h9ijyQuYKriU1eW2ACiQJjYmMy
        Wa84SAXb75NPyH+hU+IfOoEXhYz/iw3hVZhy0HsG1DI0k1ldBFPnYyn5MTpNr5UE
        SwSQJREJMpq6BsimScgy6jYERUvbCSgy6xTNhZIz3f3CSZ56c6eW00mwckuZ9mcB
        7mK401DqvNPwYjkVWEO01JRS+THa1YqOjmO52N5f11VwY6baXIvFZNSaW0wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660035510; x=1660121910; bh=G2NhCb66cb19eINodXsc2D+4/M/8
        4dcn7QljyzSwVWg=; b=WhbaeE9kQ4DppP8fW7HJQiuP+ZXn/vT9/nf4pIIzapN1
        Dzu7MRr5KNSr4lA//H+zA5CTbXfsfLPWLur9IWQ/AoaA5O/oLqXKFSBGbx14/Ar/
        nfXU27f55T9I+nlFYd7jo8IGdb+5WIXvlJnzn7NgmZKDhUGWHGnhL3CR61pyB0mp
        rcEQEx0BodHUnNOAb/0DS8wMRIAjUegWl1T9k63a93ych4O5uM1Xw65gd4kyuP3d
        ShmVGuh+Dp1LMEj3jOqqdndCNW1vyhguxA3o8UTFLjJUHowoBfptLdp+1mfOGpf/
        Ubn7UWHE+btPut7m9RjqrzXGE+wfNsney0CFO0qhIg==
X-ME-Sender: <xms:tiHyYsVow885GSKkXux46b0W1GDfxX3qfLI3OVbphMFFkQFVtuxiVg>
    <xme:tiHyYgm25rmX6L0RCwm2lF4F-K8VIeuBix-19FYfs6-haco4H6DwFrBWJJUcEM1b2
    VVcuhJLLIFdAFJp9Mk>
X-ME-Received: <xmr:tiHyYgbwcwTLwIHw-XiTiOz40iXHHGFw7HjacdMfClFEDu862iEyqSzEm_h7YR-3tcTATw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:tiHyYrUCbs06-eVo_2E4eyIxsI492Sow6veA7H_9ieuVRO7uB2K8lA>
    <xmx:tiHyYmmJZf-jEtV-qMIWHi3GtuSTuYvtQJWU6XF8Jdi9RF3eHE-JtA>
    <xmx:tiHyYgd0YjPKCfGO3NO3heA_N_qaHfq-QvJqTAkKr23joEp_2TkTxQ>
    <xmx:tiHyYoizbMmLfaobailRMrGHufQYraRl2IZov6jCiLe_3QVXlXdfdA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 04:58:24 -0400 (EDT)
Date:   Tue, 09 Aug 2022 20:58:12 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 3/6] asus-wmi: Implement TUF laptop keyboard power
 states
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <0LBCGR.NDLPJAR4JTJQ@ljones.dev>
In-Reply-To: <CAHp75VenHd6JREvxjmcNbeshvgv-S_th9pqBBgQJ+FBgPzgWqA@mail.gmail.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
        <20220809025054.1626339-4-luke@ljones.dev>
        <CAHp75VenHd6JREvxjmcNbeshvgv-S_th9pqBBgQJ+FBgPzgWqA@mail.gmail.com>
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

On Tue, Aug 9 2022 at 10:52:21 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  Adds support for setting various power states of TUF keyboards.
>>  These states are combinations of:
>>  - boot, set if a boot animation is shown on keyboard
>>  - awake, set if the keyboard LEDs are visible while laptop is on
>>  - sleep, set if an animation is displayed while the laptop is 
>> suspended
>>  - keyboard (unknown effect)
>> 
>>  Adds two sysfs attributes to asus-nb-wmi:
>>  - keyboard_rgb_state
>>  - keyboard_rgb_state_index
> 
> ...
> 
>>                  until the keyboard_rgb_save attribute is set 
>> (write-only):
>>                          * 0 - slow
>>                          * 1 - medium
>>  -                       * 2 - fast
>>  \ No newline at end of file
> 
> ^^^
> 
>>  +                       * 2 - fast
>>  +
>>  +What:          /sys/devices/platform/<platform>/keyboard_rgb_state
>>  +Date:          Aug 2022
>>  +KernelVersion: 6.1
>>  +Contact:       "Luke Jones" <luke@ljones.dev>
>>  +Description:
>>  +               Set some RGB keyboard power states (write-only).
>>  +
>>  +               The accepted input is "boot awake sleep keyboard", 
>> where "n n n n n"
>>  +               options are:
>>  +                       * save - 0 or 1, if 0 then settings are not 
>> retained on boot
>>  +                       * boot - 0 or 1, controls if a boot 
>> animation is shown
>>  +                       * awake - 0 or 1, controls if the keyboard 
>> LED are on during awake
>>  +                       * sleep - 0 or 1, controls if a suspended 
>> animation is shown.
>>  +                                               This is only active 
>> if the AC is connected.
>>  +                       * keyboard - 0 or 1, unknown what effect 
>> this really has
>>  \ No newline at end of file
> 
> ^^^
> 
> Be sure of not repeating the same mistake. I.e. add a newline as 
> suggested.
> 
> 
>>  +       flags = 0;
> 
> Seems you ignored my comment here...
> 
>>  +       if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot, 
>> &awake, &sleep, &keyboard) != 5
>>  +               return -EINVAL;
> 
>>  +       save = save == 0 ? 0x0100 : 0x0000;
> 
> ...and here...
> 
>>  +       if (boot)
>>  +               flags |= 0x02;
>>  +       if (awake)
>>  +               flags |= 0x08;
>>  +       if (sleep)
>>  +               flags |= 0x20;
>>  +       if (keyboard)
>>  +               flags |= 0x80;
> 
> ...and here.
> 

Umm... I know for sure I fixed all those. I must have screwed up a git 
rebase :(
I'll fix again.



