Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7054D4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350639AbiFOW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFOW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:58:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF420F5A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:58:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h1so11602841plf.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ld59Qfu20d2ESfU2Lxz+USUdXMklgpmY/S6pk/mnFLY=;
        b=gBwPsVatjxS9weLN66T4RryZfn5kIP607soCOV5eWG5WJN654g2C5f1ZghN+wj+XB4
         rHRIaeEj69bfku2LYHMzg5+VEK21A5dDckPf6nMOFpdCmPB3ZjwfkV6jxfMI2Eo+xhuW
         U78fT6NQhv/ujXEkbwVNT4J1gb7EyFrgr26qmCFQNRHV+6881XeyiZfGi3t2iRlpbsfN
         xiEmgMc7WPxp5JEW3ntRNbLzB6JN3jL3n59kN70ofCrmx5PieDQGE+stNBzjyoTJOhUD
         MJvcgLV+78tc20eG/AZ9UV13DnVSY0HMrgfnU1D45uSMogNe+9lkqyTB8WD4+xoF8oYX
         UU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ld59Qfu20d2ESfU2Lxz+USUdXMklgpmY/S6pk/mnFLY=;
        b=NaGcSm9t77P8R5PlGmJXj2DCdtvoWmehIVMDWv3hLKq/EyYszEkknVh6YTNyp/MqdK
         44oTp7t7NI6aYpCYAPlRMGf0p3WiC5feXZIxZfZKoj+IZi/WMmb+L4RBRzCCuV5C8aeX
         0NF2IxcyKKFJBMneFQaxts/8I1lZ7Rstu9Ep0TqpsquYVd5zrm5ypO2lB1BkDR2vxMLJ
         +6wi82cZ5CCV3hZjHp+V82NBvWAbhxJSJcF1fS1143is+Wh9NA2Ln9fMeaTP2VFOsX98
         W1uH5fgH8U1LXnaV4FU1x4Y+mbZexsgLfNk6w/1yeV1qi1hMUrBJsDB8iothCMSa7e1P
         RcWg==
X-Gm-Message-State: AJIora+sNFv/HQdbwdCTtqwQVKnxv723PvPhEidZFcrLdAhb46SXBf0K
        ow/JK3GGatuJ2pLt21/Mm0A=
X-Google-Smtp-Source: AGRyM1vgbsrQhqMpkMSviBhKgcYYvOXD0y7diJYaFLa8rfozMNLuRVJbPo/7Fz/1gVp+LKsHA5J3Xw==
X-Received: by 2002:a17:90b:4acb:b0:1e8:67df:6c61 with SMTP id mh11-20020a17090b4acb00b001e867df6c61mr12658419pjb.224.1655333931437;
        Wed, 15 Jun 2022 15:58:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u15-20020a170902714f00b00168c1668a49sm164631plm.85.2022.06.15.15.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:58:50 -0700 (PDT)
Message-ID: <d72f2787-c41b-4933-a017-911232ff2f7f@gmail.com>
Date:   Wed, 15 Jun 2022 15:58:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
 <YqmVsMGgxKuIT5rx@e120937-lin> <Yqmo/BiIR4gku0Y+@e120937-lin>
 <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
 <YqoI5hYa97nZwUjl@e120937-lin>
 <f194f9b6-578d-ae08-16c3-6d464da10452@gmail.com>
 <YqoXgsbg6t46rZeI@e120937-lin>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YqoXgsbg6t46rZeI@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 10:32, Cristian Marussi wrote:
> 
> Ok, this was another place where a reply carrying a consistent number of
> non-segmented entries could trigger an jumbo-request to kmalloc...
> 
> ..maybe this is where a transient fw issue can reply with a dramatic
> numbers of possible (non-segmented) levels (num_returned+num_remaining)
> 
> (I filter out replies carrying descriptors for segmented voltage-levels
> that does not come in triplets (returned:3  remaining:0) since they are out
> of spec...but I just hit today on another fw sending such out of spec
> reply for clocks and I will relax such req probably not to break too
> many out-of-spec blobs out in the wild :P)
> 
> So let me know if got new splats...

This turned out to be a nice firmware bug, someone *cough* *cough* 
decided to add some extra "protection" using a temporary buffer and they 
completely forgot the newly added voltage domain service, so we would 
just return stale information, wonderful. This is now fixed.

Thanks a lot for your responsiveness and support.
-- 
Florian
