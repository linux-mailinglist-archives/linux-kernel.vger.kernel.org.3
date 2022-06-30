Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11302561426
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiF3IFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiF3IFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:05:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E254130D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:05:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so37319917ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ik6FUsCzNZiu9EfbLO72KDalLuo/xuLvHalvhOV/dIo=;
        b=icYGEKccYdgHInp7tFB1pnhXjU18hV9rabV4eo63UYUr7kbNWe1Luob0Q56hhZny06
         CSnX1+qqxWY3m8x7As3Ku17HEike7DGNmxm96b5JEL2+7WjblF05FuxhIE0kjIpxmPTW
         Hu4mNfW87bJgt2ybaCZv0yQNAwlku6Ev2P4hWQYaL7T0QrepVa6RKhxQ4mdAlPSMfIYu
         PA3aGI7TAL/2RGawYGzzKvjKVRWrVN/D9fqfWM77OIi+Q35d9JN8pi3++frjmhMo4UAq
         4PJs9GyK5MW38RIGt1r/oKuMhW5+Xj8qYZ33dSi0yPdqxi8D2rs/UB4v8ywVrk42J9d5
         BHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ik6FUsCzNZiu9EfbLO72KDalLuo/xuLvHalvhOV/dIo=;
        b=71R/pZ7WAtNfZIc2d3MLuc4hneIWlhb364xQS+olES9biqQGmMasy4iyw+ZBYFHv+d
         QAv+lj5Rf7R/0za2FTmcqK1RfkNhq/mDBl95jjq1twbR1an/RikuTXVdNig15BuAWUzL
         FI2TWWRws+hn3a2O6oHjVtI4kci0Zuc+ifNnymK2P3mrCysv0PFnJxh0uue524zRayxf
         /mY7imaEDQSLOuUD41jyqK9wOQUm4i5H5fzom04XqiCFmO7UkDkPMPZvrwbtsDM+5u+D
         yTnYluJIMuI2kFbhuLduKRy7b4dYCrdH8Nz4KKcetn4Djsu1XjSOYxeSAZIkqVhCfy9H
         uNng==
X-Gm-Message-State: AJIora9RkftI2ShISrPYNkXkRKRc9N4XUz9H7Yj8AYN0Ca9w4wzXNhFs
        iM51IvhcjmA82ZiKt6CM+mdy6Q==
X-Google-Smtp-Source: AGRyM1tP/qfGO00LL1laS/lsR3dmHQ5UYROZqBJGZ2LruhAHU+Vv5k0qyGUeWXitMSWJcKXmzVS7Qg==
X-Received: by 2002:a17:906:7482:b0:722:edf9:e72f with SMTP id e2-20020a170906748200b00722edf9e72fmr7608726ejl.92.1656576319111;
        Thu, 30 Jun 2022 01:05:19 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bg6-20020a170906a04600b00722e31fcf42sm8747619ejb.184.2022.06.30.01.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:05:18 -0700 (PDT)
Message-ID: <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
Date:   Thu, 30 Jun 2022 10:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
 <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 03:03, Julius Werner wrote:
>>> For the latter, I would suggest adding a new property "channel-io-width" which
>>
>> No, because io-width is a standard property, so it should be used
>> instead. It could be defined in channel node.
> 
> What exactly do you mean by "standard property" -- do you mean in an
> LPDDR context, or for device tree bindings in general? In other device
> tree bindings, the only thing I can find is `reg-io-width`,

I had impression I saw io-width outside of LPPDR bindings, but
apparently it's only reg-io-width

>  so that's
> not quite the same (and wouldn't seem to preclude calling a field here
> `channel-io-width`, since the width that's talking about is not the
> width of a register).

reg-io-width is not only about register width, but width of access size
or width of IO.


> In LPDDR context, the term "IO width" mostly
> appears specifically for the bit field in Mode Register 8 that
> describes the amount of DQ pins going into one individual LPDDR chip.
> The field that I need to encode for the channel here is explicitly
> *not* that, it's the amount of DQ pins coming *out* of the LPDDR
> controller, and as explained in my original email those two numbers
> need not necessarily be the same when multiple LPDDR chips are hooked
> up in parallel. So, yes, I could call both of these properties
> `io-width` with one in the rank node and one in the channel node...
> but I think giving the latter one a different name (e.g.
> `channel-io-width`) would be better to avoid confusion and provide a
> hint that there's an important difference between these numbers.

Send the bindings, we'll see what the DT binding maintainers will say. :)

> 
>> You also need a timings node. I don't think it would be different for
>> each of ranks, would it?
> 
> I think it might be? I'm honestly not a memory expert so I'm not
> really sure (Jian-Jia in CC might know this?), but since different
> ranks can be asymmetric (even when they're on the same part), I could
> imagine that, say, the larger rank might need slightly longer
> precharge time or something like that. They at least all implement a
> separate set of mode registers, so they could theoretically be
> configured with different latency settings through those.

This feels weird... although maybe one or few parameters of timings
could be different.

How the asymmetric SDRAMs report density? This is a field with
fixed/enum values, so does it mean two-rank-asymmetric module has two
registers, one per each rank and choice of register depends on chip select?

> 
>>>> (Also, btw, would it make sense to use this opportunity to combine the
>>>> "jedec,lpddr2" and "jedec,lpddr3" bindings into a single document?
>>
>> These bindings are quite different, so combining would result in big
>> allOf. I am not sure if there is benefit in that.
> 
> They should basically be 100% identical outside of the timings. I can
> see that jedec,lpddr2 is currently missing the manufacturer-id
> property, that's probably an oversight -- Mode Register 5 with that ID
> exists for LPDDR2 just as well as for LPDDR3, and we're already
> passing the revision IDs which is kinda useless without also passing
> the manufacturer ID as well (because the revision IDs are
> vendor-specific).

Manufacturer ID is taken from compatible. LPDDR3 has it deprecated.

> So merging the bindings would fix that. 

Nothing to fix, it was by choice.

> The only
> other difference I can see are the deprecated
> `revision-id1`/`revision-id2` fields for jedec,lpddr2 -- if I use a
> property inclusion mechanism like Doug suggested, those could stay
> separate in jedec,lpddr2 only (since they're deprecated anyway and
> replaced by `revision-id` in the combined bindings).
> 
> For the timings, I'm okay with keeping them separate.


Best regards,
Krzysztof
