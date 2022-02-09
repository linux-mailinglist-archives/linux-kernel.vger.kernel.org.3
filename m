Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8DC4AF097
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiBIMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiBIMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:02:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6389C00190C;
        Wed,  9 Feb 2022 03:49:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f10so3628742lfu.8;
        Wed, 09 Feb 2022 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QBeRENr2FQbgyVzkagx4O7+PMcmaBiH6uuzOD6Tz2Dw=;
        b=WhJc8+QoazTPLczaWaDlkCjMMEYlQnj70F5FPzByxeri9nf/qH8c5DL+PuM2J3x+u0
         CCEBTlTelq6d10vR0ZeE0kRGh39cNbCCq6zw46jsmGCtPFx6vAucp9ONI262klJmMpyQ
         b/N62QOROf4u4hFImF7248A3zm3g/Y7nwyeimofQ/UtOnK18OfMc/l5dVXWUtm3CPucX
         rYyzMG5S08gK3MN09SAxA7XcsRey3djJnxsWq6R2KmQ3Q+NugvCBL65tk3yqQ0Pkf3gp
         Ibrsvp4sOseJUTlmfEDOpbB0SWHtNEvtXpBhvJ6tM5yf+Cv7pLxiPVjiUEgy4lIjwVVr
         dEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QBeRENr2FQbgyVzkagx4O7+PMcmaBiH6uuzOD6Tz2Dw=;
        b=df1KOOg/iobgVP5UAB+kvn5N+3wjBinDaXxPavif5Oo8SltJ1ZOwOYhj8dVjluIS9U
         XYJ1kOdrJxJV5bB2GGVA6jLKtl1Ovd7mLRBaJDQxZ3CDcTqKThBVdPvjev3gcTjQj7X9
         1n0Ihfu4LFSsn2VoCFhoDkeCpFpxASpbbIN74JEHA6zfB1GIx3fldC3HNG95Esa3adxS
         d65p62GiK/sYZBlWhy6rdAz8t0NnnO8J6qO2IFgHH/evjykEIuGRGh/L588Nrd0esIYh
         xbNQT+wv6GcWJhuWcMeiHj4AZVy50qy49pHgbseqMduMiFK1w7yjsxZ2ph8e+W5yBx7S
         gZUw==
X-Gm-Message-State: AOAM530s4BlbBMOSUzgS3KmWGjWOM46OOt6VsRnVcgqK8vL0rppNOQTZ
        o9dCOJQx0OPv3TFWFp7+RcCrFPazM5w=
X-Google-Smtp-Source: ABdhPJyVdmLVvC7MXC4uj0x5D09KV3xerSjcBXmHSY9wQM6pfHH3zJbYqSWZPOQDpsBOaggmgXGTWw==
X-Received: by 2002:a05:6512:ad5:: with SMTP id n21mr1303927lfu.277.1644407351983;
        Wed, 09 Feb 2022 03:49:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id b5sm2455295ljk.123.2022.02.09.03.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 03:49:11 -0800 (PST)
Message-ID: <c33c9de2-ff0f-0ba7-b424-728d316dcca2@gmail.com>
Date:   Wed, 9 Feb 2022 14:49:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id
 properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20211006224659.21434-1-digetx@gmail.com>
 <20211006224659.21434-4-digetx@gmail.com>
 <YWimShkkxkR+bQLK@robh.at.kernel.org>
 <CAODwPW-2othAhTC9a_joBdHScA86iqs-FkZJZDrK5LxrJm8F8Q@mail.gmail.com>
 <d69f99ed-75a4-9b8c-addb-3eaa2b2be6a6@canonical.com>
 <CAODwPW-AMqQ+ZbnvUTuxP5Bbxdcy08GSXnhcLC+V6BW=OPYaqg@mail.gmail.com>
 <6568fd31-113f-1581-4eff-45a4a1eb4e5d@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <6568fd31-113f-1581-4eff-45a4a1eb4e5d@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.02.2022 11:58, Krzysztof Kozlowski пишет:
> On 09/02/2022 00:46, Julius Werner wrote:
>>> Unfortunately I have no clue what patch you talk about ("this patch").
>>> There is no context here, no link except the older LPDDR3.
>>
>> Sorry, I tried to reply to
>> https://lore.kernel.org/all/20211006224659.21434-4-digetx@gmail.com/
>> ([PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id
>> properties) and was hoping that would automatically provide context.
>> That patch added two one-cell properties `revision-id1` and
>> `revision-id2` to "jedec,lpddr2". Earlier in
>> https://www.spinics.net/lists/devicetree/msg413733.html ([PATCH]
>> dt-bindings: ddr: Add optional manufacturer and revision ID to
>> LPDDR3), I had added a single two-cell property `revision-id` for the
>> same purpose to "jedec,lpddr3".
>>
>> I think it would be better if this was consistent between the two
>> types of LPDDR memory. Should I just send a patch that replaces the
>> two revision IDs in "jedec,lpddr2" with a single one according to the
>> principle of "jedec,lpddr3"? Or is it too late for that now and the
>> binding already considered stable and unchangeable?
> 
> Hi Julius,
> 
> Having same bindings for revision ID makes sense. Sadly this was not
> spotted during review, eh, life... Unfortunately the bindings are
> already in a mainline release, so they are considered stable. You can
> however bring patches (bindings + drivers/memory/of + dts) which make
> the revision-id[12] deprecated and introduce new revision-id.
> 
> It should be something similar to what I did for max-freq:
> https://lore.kernel.org/all/20220206135807.211767-7-krzysztof.kozlowski@canonical.com/
> 
> Dmitry,
> Any early comments on such approach from you?

I don't mind, but I also don't see where the revision-id property of
LPDDR3 is used at all. I can't find any device-tree with LPDDR3
revision-id and don't see it being used in the code either. Maybe it's
the LPDDR3 binding that needs to be changed?
I made each LPDDR2 revision-id property to correspond to a dedicated MR
of LPDDR, which feels okay to me to since it matches h/w.
