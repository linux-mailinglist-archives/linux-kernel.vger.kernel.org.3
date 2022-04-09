Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C107B4FA818
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiDINRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiDINRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:17:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19182939CC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:15:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so22267214ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S1kx45CDYtbXE3aPQS22yI8qdr+jqfxleCsscPsVroo=;
        b=l4QBV0ALsMCa7V6Qgs7OAKmW6ZvX8tgBkP3b+1vA5GnBkykASR3TEFGnl7wTNqZOeE
         JyuPUeRxjDlnXG7M8z9lzjzvWVMrM94/fxYwAr1RFL5yRelqr7Ufnw8jtFHKAznJLDvH
         kFInQ7n6yic+bRw0MSOlHSYgyOnglXuV5D2t8SCvayqETm6YvPfzVBqc42rRL8sFP3YH
         jCn8+DNZ+KHwsRuH0mgVhe4kY63vRODpdoBO0PzSldVRY78Kn/oZDgrfJ/i/elz+HQTj
         wZI2wbY73wxdvgor/4ND3PlNtepqdQkcH362r9f1hh9qpLFUTNu95LQbFgyFkSOcUUSm
         SCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S1kx45CDYtbXE3aPQS22yI8qdr+jqfxleCsscPsVroo=;
        b=ur/WpyhY2iG0NDe5kA+ybPfVaoUE7eX1VrFmjxPY/v8hLlmwGsBSw8Pl68rb5eGWBU
         rQj0jJu/J0Z2QqVpSCZgE6x3X+oPScCnHGU1P3IgYJvshJk5vPqwXtVG9uZbpartsqvi
         5/c3KVtan/bX9xGqyv7BFW36Qd0Aoq9h1i0J35cdd/WuA6GthswQvpZFrodDsWUARuqp
         QqBXQBzuiloKRq7FLhIHCCVDiqUzseobkqoSPM0uZBfJjn4WsH8aTAY/paoHsUzUDoO+
         p89Xb866bvBK9pthn8UBEKstTFuZp0+HXdN+xnJovXV10EMihWoNruYXhwg3jE2LQw6I
         dt8g==
X-Gm-Message-State: AOAM532mdylVr143i4YncffyiHeJotpgkkT6BiNGh0stOHxyStG9JCWm
        63cxeqkD6VHTGk1KTq6N6b4gQA==
X-Google-Smtp-Source: ABdhPJyhcWkx5nvbgdb9aN9/K78uAs1TAb9srjwlo+4FYaMTNGRjKYmU9qZumuKsjZpCKJkPNNjdrA==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr22644777ejo.469.1649510133702;
        Sat, 09 Apr 2022 06:15:33 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id mp19-20020a1709071b1300b006dfdfe15cf8sm9940447ejc.196.2022.04.09.06.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:15:33 -0700 (PDT)
Message-ID: <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
Date:   Sat, 9 Apr 2022 15:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>
>> This looks wrong, the block usually should have a specific compatible.
>> Please mention why it does not.
> 
> Well, I did not even have that idea that it could need an explanation.
> 
> There is no "ingenic,jz4780-otg" and none is needed here to make it work.

Make it work in what terms? We talk about hardware description, right?

> 
> Therefore the generic "snps,dwc2" is sufficient.

No, you are mixing now driver behavior (is sufficient) with hardware
description. Most of licensed blocks require the specific compatible to
differentiate it.


Best regards,
Krzysztof
