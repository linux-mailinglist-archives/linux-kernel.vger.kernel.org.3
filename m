Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06A4BEB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiBUULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBUULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:11:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244DFBC2A;
        Mon, 21 Feb 2022 12:10:40 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o9so16284650ljq.4;
        Mon, 21 Feb 2022 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HGhrkRGOxLTFPp0IvWu9pw9Pr8JdXDbThJB0IGV8xLU=;
        b=q05VbA/LdGRm9JI5iCC7R/6MHFp+p8hZ7hUIYwm0rPqadyc6l2odkS+knjxOCpTps0
         0sn6JFA9ssyLAbfwEVZ7ciYQOPIbSQ5yOe2TxD9CT6N5+syqrdhqYpD45OLJlzm2Aphn
         JWMIYoq2bZI7jWflq8ftt8dKRu1/j97aYVkHlpXv9D4YNke2C7SeuCm/eunLAQ7tRsFX
         sdu2IEu6ZBpIU7OOJF8SAqn4ekdM35Sj9w3AsMIJ1E8b90sR9SghHLRPb23kBgivNu5P
         ePh2N/IYToJOAe6+2X5tRaUkLZuxsHNHOHXQq/T8/dXPZRg2PsASzqtkod4GY6XwfNYk
         i1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HGhrkRGOxLTFPp0IvWu9pw9Pr8JdXDbThJB0IGV8xLU=;
        b=n9gKX7B+Eg91xqysULmY5qVsw9gWW+QVWbnH6vvY6BbAmjKUbxCWAPaY8+hD9WZWB8
         kEXmq2jGno6nYz2Ml4CNHIALK2VLKlpzpwFwTkGWjHLc/J1OV55iPl9dMU2pD5MDN+52
         UXSO4w6w+WgfO8pKeQipdzgcBxKjZBL/oSNlcTpQeBLgmW788yoQNV+X6f8meH5mxLBA
         xc+W7/JBIOsyoE6GSG+rwYOdxzSe1HkEoBPSaB1CoMxi2qqhcsk17si2v4OKWTanrgfV
         /DYB0Qng0BIWZtZvvddYibnspGv0UictHEr6yaseXnCkzVyfy4Fedy7Aj/micg5K5upa
         HUNg==
X-Gm-Message-State: AOAM532gFiYjWK26AASJvNklx7s/jO+TvqK1/MpLnaoug9WENSgxduO/
        CABz6wfiOkSy2mEqmUQdKnU=
X-Google-Smtp-Source: ABdhPJyavA3z3RaF8eqkB6PeyyaK9TqvSWUKI3hfCkhd0iA6vw0WQYVeElevA+YsmAf57wtOSnmtSg==
X-Received: by 2002:a2e:a4d6:0:b0:246:e66:90ed with SMTP id p22-20020a2ea4d6000000b002460e6690edmr15896034ljm.389.1645474238315;
        Mon, 21 Feb 2022 12:10:38 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id d13sm813294lji.26.2022.02.21.12.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:10:37 -0800 (PST)
Message-ID: <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
Date:   Mon, 21 Feb 2022 23:10:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
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

21.02.2022 14:44, Mikko Perttunen пишет:
> On 2/19/22 20:54, Dmitry Osipenko wrote:
>> 19.02.2022 21:49, Dmitry Osipenko пишет:
>>> 18.02.2022 14:39, Mikko Perttunen пишет:
>>>> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
>>>> +{
>>>> +    struct vic *vic = to_vic(client);
>>>> +    int err;
>>>> +
>>>> +    err = vic_load_firmware(vic);
>>>
>>> You can't invoke vic_load_firmware() while RPM is suspended. Either
>>> replace this with RPM get/put or do something else.
> 
> Why not, I'm not seeing any HW accesses in vic_load_firmware? Although
> it looks like it might race with the vic_load_firmware call in
> vic_runtime_resume which probably needs to be fixed.

It was not clear from the function's name that h/w is untouched, I read
"load" as "upload" and then looked at vic_runtime_resume(). I'd rename
vic_load_firmware() to vic_prepare_firmware_image().

And yes, technically lock is needed.
