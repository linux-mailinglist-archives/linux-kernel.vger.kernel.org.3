Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FB46E988
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbhLIOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbhLIOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:01:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E859C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:58:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d24so9954492wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irzv4Yj6Wo7BalHCoEamumf5BEF2FaBwNYArSGF/1dU=;
        b=wXjXxoruFqKMEKzF6THA77mts51jjQ3H5eXjP5a4IfMYWQ6MOCmf5gJy7aFyoyLTEi
         2xh/nlRDKYcn7hliU7S3L1SH6zV/+DrXKav1W7VzEl5h0xnNdFkGNDyvI5lDTM0FdhMo
         3hiL6WJEOedAslMdSQvPSlabUBKJYkAsDfFP9oyq+xL383JUSApk/y/lIKNv8c4t/d0l
         0EL4FtRHhHeMXR7qn72YGpjFLZ63hcPb+jzNx4LnrZA/ztZuJrXxfDglTdltNkUPbOu/
         pjO3h3iMobWdoySp8XWT2jVDK9x+sA7TzWdZONFckiWbFZ0yasMrCjUdWiL2CwGCN9B2
         ORjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=irzv4Yj6Wo7BalHCoEamumf5BEF2FaBwNYArSGF/1dU=;
        b=ormfla9Foyw4PbzOafpEeu688bM5kSjQ3WQr+Pp6pUwea6merKZZpYOgctyYTySI7c
         XKnvZvr3Y06vovHlBN/YrTw8Vn9hhx5GKMX2VDqU85xmWKEuY2WG9LIBqZPCIQ5mYc0j
         u7Weyf+tneSCsmXg4+DVN6ZQBnQ6Z2apLoUqOcQUOr2xfPrLZG2Ya5EVkakFGJ+OUVIH
         LmlCvudnHE7w1WUSTGtRVp9ymmy/AekT5v7ty+1ZZZVATvIY4EyBSFPaf38+O4XJY1Ck
         tGbKNjAdEkgIloT8AL8Wi+u9xR9iokXxJPukwkuoZLhiPKw+GUiXdFbJugelL4TfvHgI
         tyug==
X-Gm-Message-State: AOAM531NctrYcHK4WYmeV0+DT9OLfNJteoNP5LNUfX35wNQl+bSTVHPN
        84GuRrTAHlnMfFdVsiEIPAaNnw==
X-Google-Smtp-Source: ABdhPJzp/kgnmsNWfTGb+BFTulG/DV8JfG2m4xfygJ3bRV4Q2IE3Lc7NOno7Jc8rpG1imfreCO1eiw==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr6694260wrp.542.1639058296721;
        Thu, 09 Dec 2021 05:58:16 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:ee1f:92e9:bcbf:be87? ([2001:861:44c0:66c0:ee1f:92e9:bcbf:be87])
        by smtp.gmail.com with ESMTPSA id r11sm5895846wrw.5.2021.12.09.05.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:58:16 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: arm: amlogic: add S4 based AQ222 bindings
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vyacheslav Bocharov <adeep@lexina.in>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211208093347.4837-1-xianwei.zhao@amlogic.com>
 <bd981d0c-af5c-2b29-0ae3-df6bf01ea485@baylibre.com>
Organization: Baylibre
Message-ID: <357b657c-161e-9977-976f-387165aa4883@baylibre.com>
Date:   Thu, 9 Dec 2021 14:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bd981d0c-af5c-2b29-0ae3-df6bf01ea485@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 14:55, Neil Armstrong wrote:
> +cc linux-amlogic@lists.infradead.org linux-arm-kernel@lists.infradead.org
> 
> On 08/12/2021 10:33, xianwei.zhao wrote:
>> Add bindings for the new Amlogic S4 SoC family,
>> and the compatible for the Amlogic S4 Based AQ222 board.

What's the SoC commercial name ? s805x2 ? and the board model ? AQ222 and the family ? S4 ?

>>
>> S4 is an application processor designed for hybrid OTT/IP Set To
>> Box(STB) and high-end media box applications, with quad core Cortex-A35.
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> index 36081734f720..63037ebdd7bf 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> @@ -183,6 +183,12 @@ properties:
>>                - amlogic,ad401
>>            - const: amlogic,a1
>>  
>> +      - description: Boards with the Amlogic Meson S4 AQ222 SoC

So it should be:
      - description: Boards with the Amlogic Meson S4 S805X2 SoC

>> +        items:
>> +          - enum:
>> +              - amlogic,aq222
>> +          - const: amlogic,s4
>> +
>>  additionalProperties: true
>>  
>>  ...
>>
>> base-commit: a3ebdcc8fb3d94de390e58ad3da6161826a58a87
>>
> 

Neil
