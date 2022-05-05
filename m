Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5951BA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbiEEIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245743AbiEEIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:37:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD856488AC
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:33:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so4333724edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EkR961EY1CXiCzNgowxxrUhXg4TMH8OHqi0oexOXXrs=;
        b=Mt+y+lKLyTAGxGx+Cc8jLbXo6P9hfMiUjbZCuTTCCuaNtNZJs2Ce2i/GQ7BtCCHYIu
         kmIjpU6HkEkOQhKTFMtrIHmp/6F0WkvZgVqBhEBLoHfGsnfcdYc6OJEpRvrC+I19872y
         NNng+PNxrz3aeiuobZAz/CQDLOFpy+qAjrQnt9+0ADz8tY4uO7l7zCX1lmiSFzAhXV6h
         7QAUe6emtYXxAMjuNg1xlwVbIZT8ypOOtq6sWGhvT5P3Br3PWVoSSfmmMFTQbxAjwDjb
         fYsno5UpExANJUOCyBpGZF3XN9ENrq5LKZAxlJdoWtxQ4v5ocISQqhQnwCkOoxS8T+mD
         lFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EkR961EY1CXiCzNgowxxrUhXg4TMH8OHqi0oexOXXrs=;
        b=kCuTVtyj84KQPEZQt8ZQwuz9TM6e6soG61Kwjys1SJS+WU0/A5PgV/xyfLavKlnPib
         AH8cOvlpSZ6EVeS+37+F/Hig2I64waQgnq9PVHBsoOnA0L3GNOuCLOTZZNO91ZD3ya46
         Cu26xtF1wPDh33RUY2WhXj6ilQbqyMsB9qE7l8v0QPRnJ3737AZrUbJ0hIV0EcMH9ac5
         v+Q7xmcxjCplRCz0/xuAam2fyBTMpBSAUq8qxPmkRZAUSkkc9wCwxPpCMPQRCJ/b9qnw
         5yNMcBjA33xlpMMSVOvxeEw1Lypu1mZAagXf7uz7Ou2p01lE0SQn3Ds6RHL88HU/Tf+V
         4ULA==
X-Gm-Message-State: AOAM532p2Dehck0g0y8MRFkpwmq2e8C/PS1AXggcJTd75lNk6TAiRJqQ
        4Z1c+kvtKZhfcwkTmCe2TnsQlyrOlFC1nGpA
X-Google-Smtp-Source: ABdhPJyF/rcmBBgiWodOMfkAv7sPsey9xQxskdtkaMwmULm+fFtWEOEYwxBPAE/k1fOsSJoVMBZAzA==
X-Received: by 2002:a50:8dca:0:b0:425:e8a3:a79f with SMTP id s10-20020a508dca000000b00425e8a3a79fmr27875839edh.155.1651739604291;
        Thu, 05 May 2022 01:33:24 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906391800b006f3ef214df7sm490116eje.93.2022.05.05.01.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:33:23 -0700 (PDT)
Message-ID: <2dbea4b4-9387-6676-8648-94bae6df3d8a@linaro.org>
Date:   Thu, 5 May 2022 10:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/6] dt-bindings: regulator: Add reg-external-output
 binding
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
References: <20220504065252.6955-1-zev@bewilderbeest.net>
 <20220504065252.6955-2-zev@bewilderbeest.net>
 <YnJ32bG4IkSrRtHV@sirena.org.uk> <YnLjNn9WVhvd4izZ@hatter.bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YnLjNn9WVhvd4izZ@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 22:33, Zev Weiss wrote:
> On Wed, May 04, 2022 at 05:55:53AM PDT, Mark Brown wrote:
>> On Tue, May 03, 2022 at 11:52:48PM -0700, Zev Weiss wrote:
>>> This describes an external output supplied by a regulator, such as a
>>> power outlet on a power distribution unit (PDU).
>>
>> OK, so this is that represnetation of the connection - which raises the
>> question about why the regulator needs a property?

This remained unanswered... the binding looks like approach the problem
from wrong side. It's like defining consumers of clock inside clock
controller. It does not scale, it's not in Devicetree style/intentions.

You should have a dedicated port or connector which takes a regulator as
a supply (and for supply we already have bindings).

We already have only one connector:
git grep connector -- Documentation/devicetree/


(extcon is not the best choice for bindings, it's tied to Linux
implementation, not to hardware)

Best regards,
Krzysztof
