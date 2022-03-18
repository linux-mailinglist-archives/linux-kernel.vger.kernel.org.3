Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076A4DDAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiCRNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiCRNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:41:53 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36725C74B1;
        Fri, 18 Mar 2022 06:40:33 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p15so3427696lfk.8;
        Fri, 18 Mar 2022 06:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iuWM94KXc3sHuEczLPPtyGXuhzAg1rDstlM1ADE7s3M=;
        b=XlWmW0sIAGbP6Xu+GrZaDkjSLuw0lzLyjAwInxWiKrngPGbK/6NpXJX02sgn4qHXv+
         sIQApvxEnfo7iK+QMcHQlh2LURBnhAv8/JKYyfBqMkriUfDXLGC2vPLpNtZj+7Doh0pb
         rBamfd6bNMkOoQrrjkCjcHTGbXSwRJF+Hv8xzmeMIe92iP8rxU01Q1BDNqHxk9hVpVSt
         INelI/M8Y3WUgYBLWEnM17gAbDa7NWg9opxm4TaHACBoPSBhJ6S36SNOwwh/NOqcwg8w
         kqphkjqsqfInUFSFJ1Hhi2RE3rCE5m+ymKsmekBHJsmbleL+qKcFEWtjXBN/Qcn/soo7
         CHuA==
X-Gm-Message-State: AOAM532EWECyTeBzNxBYXml9T4KrMorQHmpLbdsFmyFvpFS6Hm7awYFd
        ti4iboXV9tEifL58RU90qoY=
X-Google-Smtp-Source: ABdhPJzRWA/Ob0RieST3cFH09R5YU4a/GPnX/2Z2nYswG93mdyAF6PWgwC9uMegY4oc7gHWoPDs9oQ==
X-Received: by 2002:ac2:5389:0:b0:448:90e8:b166 with SMTP id g9-20020ac25389000000b0044890e8b166mr6031739lfh.121.1647610831557;
        Fri, 18 Mar 2022 06:40:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id q26-20020ac24a7a000000b004437f641a32sm854157lfp.15.2022.03.18.06.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:40:31 -0700 (PDT)
Message-ID: <d4d69acd-72d3-dfe1-9a11-d6590d2d90d8@kernel.org>
Date:   Fri, 18 Mar 2022 14:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: virtio: mmio: add optional virtio,wakeup
 property
Content-Language: en-US
To:     Minghao Xue <quic_mingxue@quicinc.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     mst@redhat.com, jasowang@redhat.com, quic_ztu@quicinc.com,
        robh+dt@kernel.org, virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1646733156-19333-1-git-send-email-quic_mingxue@quicinc.com>
 <20220317063515.GA30789@mingxue-gv.qualcomm.com> <YjMJ32SFXTLCuaRY@myrica>
 <20220318021052.GA16300@mingxue-gv.qualcomm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318021052.GA16300@mingxue-gv.qualcomm.com>
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

On 18/03/2022 03:10, Minghao Xue wrote:
> Hi Jean and folks,
> This is just an optional flag which could be used on an embedded system.
> For example, if we want to use an virtio-input device as a virtual power
> key to wake up the virtual machine, we can set this flag in the device
> tree.
> Currently, virio-mmio driver does not implement suspend/resume
> callback(maybe no need). So we want to check this flag and call
> enable_irq_wake()  accordingly in vm_find_vqs().

There is a generic wakeup-source property. How is this one different
that you need a separate one?


Best regards,
Krzysztof
