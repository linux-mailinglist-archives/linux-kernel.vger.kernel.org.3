Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367C34BF4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiBVJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiBVJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:29:25 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDEA1598D9;
        Tue, 22 Feb 2022 01:28:56 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id gb39so41043245ejc.1;
        Tue, 22 Feb 2022 01:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PeE1a1F//tvEdJdgsxWWcFkENW4q1JAykI/ZcFTx+qs=;
        b=FGs2aWwNjYSgVHKBVDxmoAXdLfqzKuZooEiJetx2Vpidgx0xZ2xDdTG+P2hnMnHh3T
         gcuxgSpg8COYwztWYZdTwF/fE0Mm5P/wwEczjkZriNADQvEWbiPzzc8cAFEORyypKwui
         lfCJrJBSek0044SUHY0+/reGMZYwlH6Ih5iq4PuqKR2NIBarNgqyIJfQB6vHseIpZ08d
         semRA6TKkDgNYQw60G3LxPWCjCJAZaPwxEJg1DEbUvLdMCXEtlP7OjdkB4uDhKlUpMYu
         vDysYW+w5wuweZn4Wf3gvfBe9wZxY6hV96++XJF2fVuJmlq8aR3PHuzL+XHn92c1+9Ht
         C+Tw==
X-Gm-Message-State: AOAM531Mp2vnUFD7tdxqhXhYKqQemGMPjean9F/BC0RQzKIM9miNMasv
        QmEJR+G3KbP0LM7/Knyu6js=
X-Google-Smtp-Source: ABdhPJzJmU2l1E30KzZIz4Ivn1LSbG3gjHQHGCOqGx/NPQmij6ivUgboEk7KwrWhxez9odMRWzscQA==
X-Received: by 2002:a17:906:3588:b0:6a7:7ac1:cac8 with SMTP id o8-20020a170906358800b006a77ac1cac8mr17964860ejb.342.1645522134642;
        Tue, 22 Feb 2022 01:28:54 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id gs6sm1759289ejb.17.2022.02.22.01.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:28:52 -0800 (PST)
Message-ID: <53a17fe5-4301-676a-03de-f19055a8a904@kernel.org>
Date:   Tue, 22 Feb 2022 10:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Content-Language: en-US
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220221092740.25511-1-antoniu.miclaus@analog.com>
 <20220221092740.25511-2-antoniu.miclaus@analog.com>
 <61e964b4-a406-7721-f3d4-26754c7f865c@kernel.org>
 <CY4PR03MB3399F6E389A3014678849ADC9B3B9@CY4PR03MB3399.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CY4PR03MB3399F6E389A3014678849ADC9B3B9@CY4PR03MB3399.namprd03.prod.outlook.com>
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

On 22/02/2022 10:21, Miclaus, Antoniu wrote:
>>
>> Please do not resend without fixing pointed out issues. It just looks
>> you ignore comments.
>>
>> Please fix or respond to previous comments. Please also fix all common
>> issues recently pointed out for all Analog devices - folks from Analog
>> are making the same mistakes. Reviewing the same mistake is a bit a
>> waste of time. Much more appreciated is when team applies one feedback
>> to all its submissions. IOW, do not repeat the same mistake second time.
>>
>>
>> Best regards,
>> Krzysztof
> 
> I had a look over the previous comments and I saw that some of them were 
> replied by Jonathan already, therefore I fixed only those that were still valid.
> Indeed I missed the "Please put the bindings patch as first in the series",
> my bad on that. Let me know if I missed anything else.

In this patchset you also missed spaces in the subject (after every ':'
character).

Best regards,
Krzysztof
