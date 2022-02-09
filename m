Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398644AEE2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiBIJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbiBIJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:34:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED68E05BA66
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:34:18 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3539C4003D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644397116;
        bh=j1Hd4lmSTFrkTOOqYMK0Qe55KdcJKzmf7To8MW6/JyA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=R1vuwi9m/0P0TmV9pNo4eKaLnScaY9m4dBcKBq5idGVJoyP6rsAe1BJ2PUWtLLaaY
         B6sOJ1yQi3YP0bKab0HZA2myhVkiwq4OI8LZnVP0SJFGAk4LHYmgFU8EEIt215xf2e
         ekOe+gRYzZ/+MqLoDowDuZ0wWiLkFmg/Fu4s1Eztl0sM05iq+pf0aell6o3ex9udzE
         A85TV73/HTQtxqV/RfIDEutxELI2/Qz/WxdGpppsA6cQqJsao5IdJDM9O+u3kd2s5X
         dAJVs+ovnaiC7Xh+Knp8IdNR2Hgkzu1Ift58RQt+xKLi98VmqXrmfXaHkbUf0dM5MS
         J2QqA6o1VGy+A==
Received: by mail-ed1-f69.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso1002025edf.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 00:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j1Hd4lmSTFrkTOOqYMK0Qe55KdcJKzmf7To8MW6/JyA=;
        b=tTBHKUqhbaNAPByrF2bxsm+EXTlhSk3sIMdFAEmtq7tmdIuShqk7C59qHNRKJPuN0M
         oxE25FRyz9GsMp607Wj8fmOtcxVpfuL1qQ8H+rCb/hrbojcTdPvdeQTlC/lziEaj8LWQ
         vEebhojCD0LBkpFdAd1u6i3Lz2NYOFGq2InJ6v9kQQqurzU7qo2czHCZy8400hW8X2Jp
         ZvW5Uy6coSTZwOwYhv9yksTENH6i8rimWIIRcglekCZjny9R7QS+pbsjU81Z8hC+tb9h
         jDvH2mkUtLgIglxkDHEK/2jYwayWU4zwEqq63JbDaZWFhpOlP538Ww0yTpiwBWMtmhSL
         q+4w==
X-Gm-Message-State: AOAM530b+VKGAKzzAmFD5TU7hEYrZMQb4/Au/hTebS6NMBvRDQIf20Bw
        rfNekmvntTZ3espyxEgaivn/dGEaFjpcfWucXPneqajEnGuhJ3j93kc/1azatTmZ8GgA15AhdhW
        0Lo3umxkl3NReasL0h6Hcd1L5dfQSGrCYvjDOqj85jA==
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr1336045edd.287.1644397115850;
        Wed, 09 Feb 2022 00:58:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLa/snmtz5iqx9Hn8j3YbAXkBMWCsfLkv0xITTQmx8XEZnlMbvesoWqn0aMi8P2fY5Dqr93Q==
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr1336029edd.287.1644397115699;
        Wed, 09 Feb 2022 00:58:35 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g11sm3820460ejs.14.2022.02.09.00.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:58:35 -0800 (PST)
Message-ID: <6568fd31-113f-1581-4eff-45a4a1eb4e5d@canonical.com>
Date:   Wed, 9 Feb 2022 09:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id
 properties
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAODwPW-AMqQ+ZbnvUTuxP5Bbxdcy08GSXnhcLC+V6BW=OPYaqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2022 00:46, Julius Werner wrote:
>> Unfortunately I have no clue what patch you talk about ("this patch").
>> There is no context here, no link except the older LPDDR3.
> 
> Sorry, I tried to reply to
> https://lore.kernel.org/all/20211006224659.21434-4-digetx@gmail.com/
> ([PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id
> properties) and was hoping that would automatically provide context.
> That patch added two one-cell properties `revision-id1` and
> `revision-id2` to "jedec,lpddr2". Earlier in
> https://www.spinics.net/lists/devicetree/msg413733.html ([PATCH]
> dt-bindings: ddr: Add optional manufacturer and revision ID to
> LPDDR3), I had added a single two-cell property `revision-id` for the
> same purpose to "jedec,lpddr3".
> 
> I think it would be better if this was consistent between the two
> types of LPDDR memory. Should I just send a patch that replaces the
> two revision IDs in "jedec,lpddr2" with a single one according to the
> principle of "jedec,lpddr3"? Or is it too late for that now and the
> binding already considered stable and unchangeable?

Hi Julius,

Having same bindings for revision ID makes sense. Sadly this was not
spotted during review, eh, life... Unfortunately the bindings are
already in a mainline release, so they are considered stable. You can
however bring patches (bindings + drivers/memory/of + dts) which make
the revision-id[12] deprecated and introduce new revision-id.

It should be something similar to what I did for max-freq:
https://lore.kernel.org/all/20220206135807.211767-7-krzysztof.kozlowski@canonical.com/

Dmitry,
Any early comments on such approach from you?

Best regards,
Krzysztof
