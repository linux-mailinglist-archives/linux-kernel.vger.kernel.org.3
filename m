Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D255B1FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiIHOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiIHOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:01:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F391AD5730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:00:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q7so27901237lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TMgGsL+gSTb5XJBqFu66wcGwwJkh5S5/xWrpxcBvqDU=;
        b=mToUPOlVpQ4vZsgXq12bwh81ryjoUdSUzD1W6PHlEbSgkwH/RC9G5jSrhGs+ZeWt0G
         yNcklpYz90hbQzPS0MVftfwWokxYRe53fHMT+a22SV/ZTU/ZO2e9tTlzQM6bzFXyFemF
         ZzE7xbb6uCz1DuClQlkjxgMe7ZT0aNROlv3OC5c823l/tc4/tjz1zMuet8GMuJfyXdaf
         Ol9ifq9Uu/+3HUDddi68Jw0vnycYJX23q2RB7bjqGRAw0kKmJfCky+9gqhB2npVa8FNm
         k6Une9AaYCWjKQpowZTbbHeMaJgJPs7tamWPKaCaseGFPD2xVXwBhqJZt9+2oZ/CIoNx
         cj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TMgGsL+gSTb5XJBqFu66wcGwwJkh5S5/xWrpxcBvqDU=;
        b=T7DlMwiCQ3hLUwP20Hdd/1yQvfsXWklkrWXrWu+GiNAV5i366Re5zhv0A7ovfEhnqM
         jRf8YGyShx1NgA9ZQ3nEou2FQ4TBe8dALlFxGKIUx8V6mU1f8EmuAYvM86lg+o0wSu2g
         hBg2yqWLXgHPAmLfZCLNQQ3VYvRfZQ4mkaNVeoRLGQMOhj7UcJNckZCWtKASNWwBrwgp
         wIF3kGGePIQrNO2ZGy5hr99imbDtPp0HuizRrrBTLeRjwzZffZWPeJ2m29Hl4lIjkdao
         xqHIUAoWVPi3spsBW/q7BzPndlodmY6g6GFYBmPzzX4VYkhXg7U/oWqGX7FkRzz60TlD
         n8Ow==
X-Gm-Message-State: ACgBeo1UPbgBmdeKbvq95/09Rj1SZ2IKarRsTtm/tUrBvuaBd0y5/rjx
        sXKxZj/++sZjBOYhfHZAP/oNcA==
X-Google-Smtp-Source: AA6agR5Y48/seWMsCTcKWB50RoNq21jLNeAya94UYhzjYy8E/EZ3sOEM1FC6g0VNlyEw0ppyZ1TjIw==
X-Received: by 2002:a05:6512:21b2:b0:492:e97d:c5ee with SMTP id c18-20020a05651221b200b00492e97dc5eemr3016147lft.599.1662645638367;
        Thu, 08 Sep 2022 07:00:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z4-20020ac24f84000000b0048cc076a03dsm3041089lfs.237.2022.09.08.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:00:37 -0700 (PDT)
Message-ID: <2e779d36-116d-a3f4-d9ab-178fdbc6e95a@linaro.org>
Date:   Thu, 8 Sep 2022 16:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4 v2] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907232914.243502-1-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907232914.243502-1-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 01:29, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                | 52 +++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++------------
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 32 ++----------
>  3 files changed, 60 insertions(+), 64 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> 
> Changelog:
> 
> - v2:
>   - removed minItems
>   - reordered io-width enum from lowest to highest
>   - moved `$ref` below `mainainers`
>   - removed part about undeprecating manufacturer-id

Looks good for me. With Rob's ack (for this or for v3) I'll take it via
memory controllers.

Best regards,
Krzysztof
