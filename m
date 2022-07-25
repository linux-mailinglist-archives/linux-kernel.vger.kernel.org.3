Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC95806B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiGYV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiGYV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCD24950
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k11so17261539wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LC1MButyAjgvhVwdTxySQfcTsI905HcQoSgMguQbeJE=;
        b=XIuER+QEkXsz5IY+kHqI2bwpSJoq2OQb3wKfqZ+BK5c7jPlBbRxlnq8nlkhnCbbYr7
         GnGARLlnY71J07XrmeQ0i0J2rmmeTLMs72YlQ6lgmd3IIulDnr/vBnjIrD+U0JRBIHxs
         zMY0C01JwXyk7ZRgo06AtAS9x9y0BAQ6zuDsCorpBiNWnLuqJfRLrKkYFwaElNMulpjS
         EG1BOqq9BIYRA0VRAJ1HjUjZCjws1JdY1aA3WCaNq3pCJJyPyiKVBvWBd2wpIz7bCwTB
         u33/Vm7cN9g8DiKlRpfkVYhe2EIjV6e8Kmm2LyHFV2up/PzCUl4tskP84B1W9bCYDlFn
         pZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LC1MButyAjgvhVwdTxySQfcTsI905HcQoSgMguQbeJE=;
        b=doWxmQNc1vWOJPZOZ90thqm+0H0bIlucB2EUEP9uPhGzx1s5wp2L7uDjqbhyeOIwOr
         4x7fhHRXJ6TYTCMuC+TI0bbXRA3k/aL514oTKaPa7uVRzw3xVGLIuruu8ksj2BMLsCQg
         M88MhVPVGkJpAShTC3MJsrPL80n/CMsrMCgbFAOrTutWtRkWd30TIFPA+sbw/PmKzaiq
         dwLUkkLS+eGYCJqHd6Kqp0tXTzdrRdJ3yFfQkRWBOlluv94QLdWnmjhXjlfbXy6nCVCR
         NzIltl0+75VQCjkz50C3c9EpMh9Y6xKNQHmv9qg71jC67+qlZ3Qci/126X+i+aoLLQuI
         UuOA==
X-Gm-Message-State: AJIora9dA1KLJXPSfXUdOtkdC4f7oEhjAS4FCkvxXC7OVy6m4fRNBxQd
        Qt2CmBtrwdvdjnDgC9va6QPsCvHMdh8OWA==
X-Google-Smtp-Source: AGRyM1uhCs8VsFP2JwWvB8LbQsi/wD2WmCWt2Rv2KajohyBY0rFeGaFvWA4ssIOieb9jtBGlLP6edA==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr8496954wrf.208.1658784457841;
        Mon, 25 Jul 2022 14:27:37 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b0021d65675583sm12624688wrr.52.2022.07.25.14.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 14:27:37 -0700 (PDT)
Message-ID: <0ad68731-1891-ced8-2a2e-682b50cc6488@sifive.com>
Date:   Mon, 25 Jul 2022 22:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-GB
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 22:21, Ben Dooks wrote:

Argh, forgot the cover note on this:

Second version of updates for the DesignWare PWM driver to move it
from PCI only to both PCI and OF.

Fixes:

v2:
- fix #pwm-cells count to be 3
- fix indetation
- merge the two clock patches
- add HAS_IOMEM as a config dependency
