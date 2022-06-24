Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4346C5596FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiFXJqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiFXJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:45:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7B79460
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:45:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ej4so2649757edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/PZ3XOMvkhnYxJnipJbwxRBEHfIP+qGhL45xt0zC5m4=;
        b=eiHnSME3SRCyMlSVOoBz9BQV5ZpeDXeKANxFn0XuA4Fejm7uep4vtZK1s7sjasHj5C
         6K+8aFMoguHWAvYGA7ruiWMUHCIR46vpb0qn0mZDLqj1PLUpaT+I4Vzp4oM020Ub9vvg
         WOtc+LFTx259FAtUqMfRU93YpJadtUH8ZdmlRJghls4WK9yr93RjAurko/X5VBMfz3he
         H1g92DUTYlhCqtOSKlhLeR2HYUdRfzW8mOHXtMVp4EtIcJxpfd+LMhvHOuwimzLTdJwe
         emnXM/5FJDvorbzjmhwv1M8Ix9rDT3D9A8CaLRpRCg3i811JohW7OuRXv42tMhoyc3GH
         oXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/PZ3XOMvkhnYxJnipJbwxRBEHfIP+qGhL45xt0zC5m4=;
        b=Hi81y7bE+j5olENrFrKKRJXOFmPc1RUAosk8FKB/AxpVkc3JdOCpWOkF960i+w1VX6
         Pem9NrDbJjWyjJHOZqxNz1jOxyJ8grbymIYkKZQZOXrF3dKDbohh99nbhK4a7NBC2YAQ
         CS/cJKL4TkSnTHV5Jz/m2v14c8l5UqWjdh0jDoSS9VokydL4XFVnYyA1untwz6kn3jac
         kMoZL8DNNGTUD/EiCU4EWXUz8At9nHzwNoE9CKbMPKRUoqArdAiIc3nb3cvTNyOKuPrp
         dVLFHFlqZagScwM/mCQv72yyys9oQa8/whRA57spG8FSu9qq0fkUydK3SsfkxUvyPfnq
         EP/g==
X-Gm-Message-State: AJIora+rftWt1B6ZiTix6euyJsITH6ECmoIZS6IcjebWUiq3E73/Tol1
        etbSX6jol67rR1PT+KCt/SVkkA==
X-Google-Smtp-Source: AGRyM1sx1ph41d4hnCr0PkPpX3Fmpbye7S6ANOY9g1Ju3MgEJ5imR/2cHlIRJ+PZIajHLOeFImTjGg==
X-Received: by 2002:a50:c209:0:b0:435:6b37:46cb with SMTP id n9-20020a50c209000000b004356b3746cbmr16584506edf.341.1656063952058;
        Fri, 24 Jun 2022 02:45:52 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm799543ejj.160.2022.06.24.02.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 02:45:51 -0700 (PDT)
Message-ID: <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
Date:   Fri, 24 Jun 2022 11:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 04:28, Julius Werner wrote:
> Sorry, wrong email for Krzysztof.
> 
> On Tue, Jun 14, 2022 at 7:25 PM Julius Werner <jwerner@chromium.org> wrote:
>>
>> We (Chromium OS) have been trying to find a way to pass LPDDR memory
>> chip information that is available to the firmware through the FDT
>> (mostly for userspace informational purposes, for now). We have been
>> using and expanding the existing "jedec,lpddr2" and "jedec,lpddr3"
>> bindings for this (e.g. [1]). The goal is to be able to identify the
>> memory layout of the system (how the parts look like, how they're tied
>> together, how much capacity there is in total) as accurately as
>> possible from software-probed values.
>>
>> The existing bindings contain the fields "io-width" and "density",
>> which is terminology directly matching what an LPDDR chip can report
>> to firmware through the "Mode Register" interface, specifically MR8.
>> (The LPDDR specs describing this are not public, but you can see the
>> register definitions in most LPDDR chip datasheets that can be
>> randomly found online, e.g. [2] page 37.) The code in
>> drivers/memory/of_memory.c also suggests that these are supposed to
>> directly correspond to the MR8 values read from the chip, since when
>> of_lpddr2_get_info() copies the device tree values into struct
>> lpddr2_info, it encodes them in a format that directly matches the
>> mode register bit field patterns.
>>
>> The problem with this is that each individual LPDDR chip has its own
>> set of mode registers (per rank) that only describe the density of
>> that particular chip (rank). The host memory controller may have
>> multiple channels (each of which is basically an entirely separate set
>> of physical LPDDR pins on the board), a single channel may be
>> connected to multiple LPDDR chips (e.g. if the memory controller has
>> an outgoing 32-bit channel, that channel could be tied to two 16-bit
>> LPDDR chips by tying the low 16 bits to one and the high 16 bits to
>> the other), and then each of those chips may offer multiple
>> independent ranks (which rank is being accessed at a given time is
>> controlled by a separate chip select pin).
>>
>> So if we just have one "io-width" and one "density" field in the FDT,
>> there's no way to figure out how much memory there's actually
>> connected in total, because that only describes a single LPDDR chip.
>> Worse, there may be chips where different ranks have different
>> densities (e.g. a 6GB dual-rank chip with one 4GB and one 2GB rank),
>> and different channels could theoretically be connected to chips of
>> completely different manufacturers.
>>
>> We need to be able to report the information that's currently encoded
>> in the "jedec,lpddr2" binding separately for each channel+rank
>> combination, and we need to be able to tell how many LPDDR chips are
>> combined under a single memory channel. 

Why?

At beginning of your message you kind of mixed two different usages:
1. Knowing the topology of the memory.
2. Figuring out total memory.

Implementing (1) above would probably solve your (2) use case. But if
you only need (2), do you really need to define entire topology?

>> For the former, I'd suggest
>> creating a separate FDT node for each channel, and then creating
>> subnodes under those for each rank that implement the binding. For the
>> latter, I would suggest adding a new property "channel-io-width" which
>> describes the width of the channel from the host memory controller's
>> point of view, so that you can divide that property by the already
>> existing "io-width" property to figure out how many parts are tied
>> together in series in a single channel. The final layout, then, would
>> look something like this:
>>
>> lpddr2-channel0 {

Looks reasonable.

This should be then:
channel@0

and children as well (so rank@0)

>>     rank0 {
>>         compatible = "jedec,lpddr2";
>>         density = <2048>;
>>         channel-io-width = <32>;
>>         io-width = <16>;
>>     };
>>     rank1 {
>>         compatible = "jedec,lpddr2";
>>         density = <1024>;
>>         channel-io-width = <32>;
>>         io-width = <16>;
>>     };

You also need a timings node. I don't think it would be different for
each of ranks, would it?

>> };
>> lpddr2-channel0 {
>>     rank0 {
>>         compatible = "jedec,lpddr2";
>>         density = <2048>;
>>         channel-io-width = <32>;
>>         io-width = <16>;
>>     };
>>     rank1 {
>>         compatible = "jedec,lpddr2";
>>         density = <1024>;
>>         channel-io-width = <32>;
>>         io-width = <16>;
>>     };
>> };
>>
>> This would be describing a dual-channel, dual-rank layout where each
>> 32-bit channel is connected to two 16-bit LPDDR chips in series. The
>> total capacity would be (2048 Mbits * (32/16) chips + 1024 Mbits *
>> (32/16) chips) * 2 channels = 12Gbits.
>>
>> Does this seem reasonable? If nobody has any objections, I can draft
>> up a real patch to change the respective bindings. (The two existing
>> uses in platform device trees would stay how they are until the
>> respective platform maintainers choose to update them, since only they
>> would know the exact configuration. They wouldn't technically violate
>> the changed binding since they still contain the same properties
>> (other than "channel-io-width" which could be declared optional), but
>> they wouldn't represent the total memory layout.)
>>
>> (Also, btw, would it make sense to use this opportunity to combine the
>> "jedec,lpddr2" and "jedec,lpddr3" bindings into a single document?

These bindings are quite different, so combining would result in big
allOf. I am not sure if there is benefit in that.

>> They contain all the same properties and I think it makes sense to
>> keep them in sync, so duplicating the documentation is just
>> unnecessary maintenance overhead. I would also like to add a
>> "jedec,lpddr4" binding that has the same properties.)
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
>> [2] https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/dram/mobile-dram/low-power-dram/lpddr2/2gb_automotive_lpddr2_u89n.pdf


Best regards,
Krzysztof
