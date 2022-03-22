Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE34E3ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiCVIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCVIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:40:19 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27009EA9;
        Tue, 22 Mar 2022 01:38:52 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so859175wme.0;
        Tue, 22 Mar 2022 01:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0FcdRambMsRKShOfd/k3JzjIzx8GGv4n7YmQbRU/7n0=;
        b=lpDvjwP6pvZL9HmzQ77KoautAOs5kJnLoc02cm3sYA0m84fXOEelWpz7oEnBv1xiFe
         zvgTmEMCek2O/LvrJxbzgQEHWUf6nAO/dE2YwZIP+8fbXSwss59uf/RSQVkM2Lau3v8o
         6PCYH9d7K3ZorZTBAsDsv54PJJqYkH0l1iz3UNQpGAwsSh1yLgz0jFDxRt7tKGnSI7Hh
         CzsWBrLLd0HHK0MNpWz+ZBYzMpiU2ap9+z4+ORrmBW1jR6gnvZfk/uGG2frCrhrvs3eG
         PspKIzCouWb1YrtzwXlgLv1ZNQtls6Y4m4dVDLdSkSM4jtGnysbyiydtyvrtQdhRfhT6
         uMFA==
X-Gm-Message-State: AOAM531S5jzb/YZrPf4ggCgMqz/QMMJA5QNJUxAh94YGF+suS6r8C7nT
        lGWWrzbwUlI4SYx5uIBKO8rug30RGCQ=
X-Google-Smtp-Source: ABdhPJx5cFoT4/ge0DuruG2LnSzEJ79ktilr8/JnWLY7QJDxE5kYgAMTZFcS3KNJQKTEJo5dvxbGKw==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr2551228wmn.187.1647938330451;
        Tue, 22 Mar 2022 01:38:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm1336485wma.48.2022.03.22.01.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 01:38:49 -0700 (PDT)
Message-ID: <7b6fec6a-12ef-7381-b06e-108a7b3ff1e4@kernel.org>
Date:   Tue, 22 Mar 2022 09:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio: mmio: add optional virtio,wakeup
 property
Content-Language: en-US
To:     Minghao Xue <quic_mingxue@quicinc.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
        jasowang@redhat.com, quic_ztu@quicinc.com, robh+dt@kernel.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1646733156-19333-1-git-send-email-quic_mingxue@quicinc.com>
 <20220317063515.GA30789@mingxue-gv.qualcomm.com> <YjMJ32SFXTLCuaRY@myrica>
 <20220318021052.GA16300@mingxue-gv.qualcomm.com>
 <d4d69acd-72d3-dfe1-9a11-d6590d2d90d8@kernel.org>
 <20220322061956.GA1441@mingxue-gv.qualcomm.com>
In-Reply-To: <20220322061956.GA1441@mingxue-gv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 07:19, Minghao Xue wrote:
> Hi Krzysztof,
> 
> Thanks for your comment. First of all, which "generic wakeup-source
> property" do you mean? 

There is only one generic - wakeup-source.

> Could you give an example? I find "wakeup-source"
> property in several binding files. Are you pointing to this? 

Yes, use wakeup-source.

Please avoid top-posting.



Best regards,
Krzysztof
