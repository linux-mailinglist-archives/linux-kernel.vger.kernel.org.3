Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D454EE828
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiDAGZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiDAGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:25:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF025C59E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:23:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so1770510edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xQMDBGJX/jflZ53QpHSB8LvVGDDFW1x1dQ4Ucf7ki+I=;
        b=nrwJeBN8hHzwkveYcjMDzL7r0pd3kmP3pk9rP2aTD0OqdjGdkLRB7D1Kavw+U8BATM
         p7bvS/4WHFtb+cGNSozE3xiZ2wUpTf3XI/tJB1kNZp3e9KyF9+9TEKnzfNeRqipJ++y7
         3O0VQqmzMSY2PzXSqiYaRLO3bSWpzY2UQiGkcuBhJAz6ZRj0UILs2QTPix4z2zuEAjmP
         uOyDh7x13Xn2v/vdlfS5396MXJPwn+acbO9Ulieh3n+7oALSuHmts6M3hH4OxvxHLbOq
         GTcl+PJ2Hve0UhB09AFJQRgU4dtUThG2jaC2AeQ+n9MIS82yRvndjO8elv3SH+pweUer
         nJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xQMDBGJX/jflZ53QpHSB8LvVGDDFW1x1dQ4Ucf7ki+I=;
        b=eMmDB+t/9Qmoh2zKTLPy0NuR98IqN18Vf0FOTWp6U737QbgPr4Q9dUTff1dME2HKiq
         BV6diSvc3ylJYk2zmCBONv4OFH7hftwh/DD4Rxe/FwrlaXMjBbd9zRNiG3CQlbiRMSDq
         8ZSdArF/RgmPsYEwa6UhbNP9JF+ppe0l1rifaXGx0OdnfozPb3g2Nae//6Zv+hEU6l7w
         TwS2iWC/i392hwjRCsg4KoSkfAKvuS28/KOkrzfdTjbm4vMk842c4DwreG+tAjfbtWrc
         8NAWt5d9QtUFD8AoLHWFSJOB9nAWEhMgaTbdD3bxjsMwTUGpuLC3vTs0GlfUNzyzSqiS
         WGig==
X-Gm-Message-State: AOAM533Are5hnbM6FTedUQcKsUsHRVHxoDNKRbECB/Z+cOLbLMaHyD/P
        qvlOHV+a1heLV5zPn6Ww0DcbOfaBhZO53qj/
X-Google-Smtp-Source: ABdhPJxMB1TEIOVvp+9kCB/IjTZAOwtiVWwPHZdkhtPIcHDQGxejHUBCt/HIVRegmbHmO9aQXtI3Iw==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr19553120eda.203.1648794231818;
        Thu, 31 Mar 2022 23:23:51 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b006c5ef0494besm647740ejb.86.2022.03.31.23.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 23:23:51 -0700 (PDT)
Message-ID: <f45a7b96-4110-c9e0-f0ba-6c4432977bc2@linaro.org>
Date:   Fri, 1 Apr 2022 08:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: gpio: davinci: list contents of GPIO hogs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220328191153.171241-1-krzysztof.kozlowski@linaro.org>
 <YkZK1OzF5Wq2bDma@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkZK1OzF5Wq2bDma@robh.at.kernel.org>
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

On 01/04/2022 02:44, Rob Herring wrote:
> On Mon, Mar 28, 2022 at 09:11:53PM +0200, Krzysztof Kozlowski wrote:
>> The hogs children should list allowed properties, otherwise any property
>> would be accepted.  Simplify also GPIO hog node name pattern.
> 
> Only if 'gpio-hog' is missing, because the gpio-hog.yaml schema will 
> check every node with that property.
> 
> Hogs are allowed on any GPIO controller, but I don't think we to 
> duplicate what's here on every schema.

I understand, so the patch could be dropped because it requires
gpio-hog, thus the schema will always match.


Best regards,
Krzysztof
