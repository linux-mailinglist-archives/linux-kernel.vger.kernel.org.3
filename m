Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8754ED6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiFPWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245332AbiFPWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:41:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B7162111
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:41:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so1980995otg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AWCHew8dJ92FRAa86sjZqg/7uz35kqackjChUgkNjiw=;
        b=Sbn07kQgTXlj8XatmfRNXAU72cQaXb8VxilvqYsKtyR3h6nwF007C4986DhNrSkO+s
         x5OVfHmx3rGoV5XgKxT2TDvBiqTYywKNLRUPPHlr3amgPN+UCeO9vrHZmiMMRFRthmVI
         JbtKX1fCXXSeRR/e1ecfNesPq3ruFPKsZKkL8V2LFSQWvkqSsveykkdd1YWSpsxd9sd8
         nd9TeH5H8oVeM9sjgDlwHNcLy2C6Re7a1hmMUhFs/N8GGl3OeE1cWFJLZnTPlYJ/xHoP
         9ICO8nPy8CaK+XwlEWGmW0qyAZFV/c9tu/yqBdpNFnSB9PJ+4HImJ7khcWbtRRIFOy0T
         v3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AWCHew8dJ92FRAa86sjZqg/7uz35kqackjChUgkNjiw=;
        b=pPuYuaAYUPkTYmybBd4j3q5lvBTaxzRind2+w3JY6ru47L2aYhnlgu6DstgAO2uNvM
         yGZO8iIa65P3BDJbyFOtmJZf1p6ur98JB9fJl8Nb9mEWg8t10zPY2Y8CgjzNEi+BA4nv
         R1EiQMkp7C6K0Eziz6aGf6tXzK73PxIfqWWGco0hy+Bl+1O4t/FFcJ66G1bddYDBQGS2
         322h6Ad2PFI4gAeYt4aAMcqpBGW0ur5YE/oURcB7lkRTCJZWqC+G5rpaNYJ42x2smMSj
         cUO23kUj1FVVaG3Au/1EyRJTITxM0BkQYCDdfqIMHIysTrcYTW/ANkGLBN8mmbD2gS5E
         CtHg==
X-Gm-Message-State: AJIora+25e2JptcZiAuxfBZFJq3lWbZP0OWHzG4eYUsO99A8lKOESKON
        9+FRhCmnNwVUYotWS2MEY2UBTQ==
X-Google-Smtp-Source: AGRyM1vg4mrJ0bSA38QQ60GxwD9BVX0fzA6Z6x2kYxwAP5Zg8De9eraONxzGZct4/qBV37pr7IgO+Q==
X-Received: by 2002:a05:6830:2695:b0:60c:6e16:460f with SMTP id l21-20020a056830269500b0060c6e16460fmr2899781otu.249.1655419275291;
        Thu, 16 Jun 2022 15:41:15 -0700 (PDT)
Received: from ?IPV6:2804:14d:8084:84c6:fe26:c42d:aab9:fa8a? ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id ly14-20020a056870fc8e00b000e686d13889sm1532110oab.35.2022.06.16.15.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:41:14 -0700 (PDT)
Message-ID: <8b040fb2-7edd-6fd1-864e-ee04115c5b1d@usp.br>
Date:   Thu, 16 Jun 2022 19:41:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC 0/3] drm/amd/display: Introduce KUnit to Display Mode
 Library
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jun Lei <jun.lei@amd.com>,
        Nicholas Choi <Nicholas.Choi@amd.com>,
        Harrison Chiu <harrison.chiu@amd.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <20220608010709.272962-1-maira.canal@usp.br>
 <CABVgOSmesj5MGfQrtdWCgXzm1VXRoG0fAMCbkBCAvtqediqAjQ@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CABVgOSmesj5MGfQrtdWCgXzm1VXRoG0fAMCbkBCAvtqediqAjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for your feedback!

On 6/16/22 11:39, David Gow wrote:
> On Wed, Jun 8, 2022 at 9:08 AM Maíra Canal <maira.canal@usp.br> wrote:

>>
>> As kunit_test_suites() defines itself as an init_module(), it conflicts with
>> the existing one at amdgpu_drv. So, if we use kunit_test_suites(), we won't
>> be able to compile the tests as modules and, therefore, won't be able to use
>> IGT to run the tests. This problem with kunit_test_suites() was already
>> discussed in the KUnit mailing list, as can be seen in [7].
> 
> I'm not sure I fully understand why these tests need to be part of the
> amdgpu module, though admittedly I've not played with IGT much. Would
> it be possible to compile these tests as separate modules, which could
> depend on amdgpu (or maybe include the DML stuff directly), and
> therefore not have this conflict? I definitely was able to get these
> tests working under kunit_tool (albeit as built-ins) by using
> kunit_test_suites(). If each suite were built as a separate module (or
> indeed, even if all the tests were in one module, with one list of
> suites), then it should be possible to avoid the init_module()
> conflict. That'd also make it possible to run these tests without
> actually needing the driver to initialise, which seems like it might
> require actual hardware(?)

Initially, we tried the kunit_test_suites() approach. And it did work pretty well for the kunit_tool (although we didn't test any hardware-specific unit test). But when compiling the test as a module, we would get a linking error, pointing out multiple definitions of 'init_module'/'cleanup_module' at kunit_test_suites().

At this point, we thought about a couple of options to resolve this problem:
- Add EXPORT_SYMBOL to the functions we would test. But, this doesn't scale pretty well, because it would pollute AMDGPU code as the tests expand.
- Take the Thunderbolt path and add the tests to the driver stack.

We end up taking the Thunderbolt path as it would be more maintainable.

Compiling the tests as a module is essential to make the tests run at IGT, as IGT essentially loads the module, runs it, and parses the output (a very very simplified explanation of what IGT does). IGT is a very known tool for DRI developers, so we believe that IGT support is crucial for this project.

If you have any other options on how to make the module compilation viable without using the 'thunderbolt'-style, we would be glad to hear your suggestions.

> 
> There are two other reasons the 'thunderbolt'-style technique is one
> we want to avoid:
> 1. It makes it much more difficult to run tests using kunit_tool and
> KUnit-based CI tools: these tests would not run automatically, and if
> they were built-in as-is, they'd need to be
> 2. We're planning to improve module support to replace the
> init_module()-based implementation of kunit_test_suites() with one
> which won't have these conflicts, so the need for this should be
> short-lived.
> 
> If you're curious, an early version of the improved module support can
> be found here, though it's out-of-date enough it won't apply or work
> as-is:
> https://lore.kernel.org/all/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
> 
> Now, that's unlikely to be ready very soon, but I'd be hesitant to
> implement too extensive a system for avoiding kunit_test_suites()
> given at some point it should work and we'll need to migrate back to
> it.

We hope to see in the near future the improved module support from KUnit as it would make the addition of tests much more simple and clean.

Could you explain more about what is missing to make this improved module support come upstream?

> 
> At the very least, having the dependency on KUNIT=m is a very bad
> idea: it should be possible to have tests built as modules, even if
> KUnit itself isn't, and ideally (even if this sort-of implementation
> is required), it _should_ be possible to have these tests be built-in
> if all their dependencies (KUnit, amdgpu) are, which would make it
> possible to run the tests without a userland.
> 

Thank you for the suggestion! We will change the KUNIT dependency.

- Maíra Canal
