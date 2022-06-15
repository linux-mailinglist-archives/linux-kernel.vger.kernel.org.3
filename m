Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76CB54CC25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiFOPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiFOPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:05:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95183A18C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:05:25 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso9023990ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XrsUat+o9/LJuOTX2aEo1c6UCKiQykIvhRb0gI34RDo=;
        b=lq//UHgItHTiby3bJtgdK8d+4WxPCraeTpovO73wwG18S0SWKqgaf5as3Z40hgAc7p
         OfJvf1rf++IpjBKJ6CSBDk0x++Wp++fwX/WgMrQL3mfxGxiEArH1po8nbf68T+n3kkDg
         g8uM7EvtiK/Pho/NXMNUHkp5cH8noXrsDaRaefhYoTXKEj0EbGCOqJXveNjIKEcnY5vt
         QECeu52Mjnia3clU+aBgrWbyXI3jFZZOnFdUp8si3aeFMos98OMEHPojeV1jdSNZjmhT
         eHcrMdC0fCGrT+1BM7uU1hJk/pPpmye9PTHCrJShXEsYiD2XnqJDmsYmZhh0rePZp+AQ
         0jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XrsUat+o9/LJuOTX2aEo1c6UCKiQykIvhRb0gI34RDo=;
        b=P4LzYy4ag2WP8iyJzzUb9YFb0SRym6W249V6gPd/XvFNjCMkblkEZYciEDMg3O2Frq
         PlleVuasQ/uROAZUmL6Fruo1X0euQ+5te0SMdjs5tbhOOSim7Jhc+1MCjp+gRsR3GDkm
         jZcszMysrJLhpl5fsXo+dUfAIrRjp/CFyV9EJgARZntjAmxBUWlWkuSlgH8HJ5QmQatF
         Giuzi+EAj82Rrpm7kxvOXPqFy955aZV0Xyh9/0NOTh5+YMRka4l/ahIzOIo0UzwlIU6U
         fcncfP/dkZE4d5d9M6b12VRU9JNliUHQ6BYK0SB8YB9Jw7Bng8c8JiPW5uz6lS7LFkoY
         6eUw==
X-Gm-Message-State: AJIora/+wLKGqp9ULvFfViDH4qDbj5KmCyt5eO32GugEr5MT6ffyTkNW
        XkvowqW2GzqEgTRlCL+CBwjovA==
X-Google-Smtp-Source: AGRyM1sKk0ZQraqiQaBpBMqcrxQIwxmHAc5xtgCpvjOe9O5wXFYZY7caP6JDQm51urqSb6qWA+JhJw==
X-Received: by 2002:a05:6830:2647:b0:60c:6678:d7cc with SMTP id f7-20020a056830264700b0060c6678d7ccmr109130otu.237.1655305524933;
        Wed, 15 Jun 2022 08:05:24 -0700 (PDT)
Received: from ?IPV6:2804:14d:8084:84c6:fe26:c42d:aab9:fa8a? ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id a18-20020a544e12000000b0032f51af1999sm3447022oiy.42.2022.06.15.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:05:24 -0700 (PDT)
Message-ID: <4296546a-67db-0e54-c75c-cc2b5b203197@usp.br>
Date:   Wed, 15 Jun 2022 12:05:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC 1/3] drm/amd/display: Introduce KUnit to DML
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com,
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
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
References: <20220608010709.272962-1-maira.canal@usp.br>
 <20220608010709.272962-2-maira.canal@usp.br>
 <CAGS_qxpiBOJ5OnQREo33LCtgROSuvTNWgwgkKN4P7TF1+4kcSQ@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CAGS_qxpiBOJ5OnQREo33LCtgROSuvTNWgwgkKN4P7TF1+4kcSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

Thank you for your feedback! We are working on the comments you pointed out.

On 6/7/22 23:36, Daniel Latypov wrote:
> On Tue, Jun 7, 2022 at 6:09 PM Maíra Canal <maira.canal@usp.br> wrote:
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/display_mode_lib_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/display_mode_lib_test.c
>> new file mode 100644
>> index 000000000000..3ea0e7fb13e3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/display_mode_lib_test.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * KUnit tests for dml/display_mode_lib.h
>> + *
>> + * Copyright (C) 2022, Maíra Canal <mairacanal@riseup.net>
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include "../../dc/dml/display_mode_lib.h"
>> +#include "../../dc/dml/display_mode_enums.h"
>> +#include "dml_test.h"
>> +
>> +/**
>> + * DOC: Unit tests for AMDGPU DML display_mode_lib.h
>> + *
>> + * The display_mode_lib.h holds the functions responsible for the instantiation
>> + * and logging of the Display Mode Library (DML).
>> + *
>> + * These KUnit tests were implemented with the intention of assuring the proper
>> + * logging of the DML.
>> + *
>> + */
>> +
>> +static void dml_get_status_message_test(struct kunit *test)
>> +{
> 
> I think this is a case where an exhaustive test might not be warranted.
> The function under test is entirely just a switch statement with
> return statements, so the chances of things going wrong is minimal.
> But that's just my personal preference.

Maybe we left out some explanation on this unit test. This RFC was more of an introduction to our project. We wanted to show you the test structure we plan to develop the unit tests during this summer. Initially, we were thinking of using the typical kunit_test_suites structure, but we end up checking out that it wasn't possible, due to the need to insert the tests inside the AMDGPU stack.

We also agree with you that this test is trivial and it will probably be removed from the final version. We plan to have more functional tests that explore the inner workings of the DML and especially the corner cases as you said.

We apologize if we didn't make it clear in the Cover Letter that this RFC is more of an introduction to the project we pretend to develop in the summer.

If you have suggestions on how we can improve the use of KUnit, it is welcome.

>>
>> +int display_mode_lib_test_init(void)
>> +{
>> +       pr_info("===> Running display_mode_lib KUnit Tests");
>> +       pr_info("**********************************************************");
>> +       pr_info("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **");
>> +       pr_info("**                                                      **");
>> +       pr_info("** display_mode_lib KUnit Tests are being run. This     **");
>> +       pr_info("** means that this is a TEST kernel and should not be   **");
>> +       pr_info("** used for production.                                 **");
>> +       pr_info("**                                                      **");
>> +       pr_info("** If you see this message and you are not debugging    **");
>> +       pr_info("** the kernel, report this immediately to your vendor!  **");
>> +       pr_info("**                                                      **");
>> +       pr_info("**********************************************************");
> 
> David Gow proposed tainting the kernel if we ever try to run a KUnit
> test suite here:
> https://lore.kernel.org/linux-kselftest/20220513083212.3537869-2-davidgow@google.com/
> 
> If that goes in, then this logging might not be as necessary.
> I'm not sure what the status of that change is, but we're at least
> waiting on a v4, I think.

This is going to be great! We will keep an eye on this proposal.

- Maíra Canal


