Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03EA575187
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiGNPPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiGNPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:15:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642EDE8E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:15:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u15so2514071lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=yzcL0XkHls1rjwiZYcO9Tu6ZGfgHnxn6Gz17KtnNeNw=;
        b=G29tTnAV+jUHkZsKGG5bgr3wetjK2grCIqzrxEUluUlVgV0n1iKVGxj2MULb2MjCgM
         PahrPzZM7VCmccmjH3vVfhoPfXThZJZgHJ2iSyw0MZH8B48tt6fKWq3ILCoob2sDDGRh
         FlLwf/DemRND81liqwOQS+prRHW/tAQ8+x2+VxWApQDJeWgAlHMg28QxIfooq9iSVBww
         MFwneZh9AWHGhFnADJ+J0eoPWDgoL0sCkxv5wV9KYVGy904rMA0wlsEkjqDTsU1uCF2F
         ZGQReZ8oAvTmBTjboMp5KO8nY7ozzacLDV8+P/0XNDtoSmOnqTgHkVwQMgJKP9tjstlJ
         97gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=yzcL0XkHls1rjwiZYcO9Tu6ZGfgHnxn6Gz17KtnNeNw=;
        b=HgRZ4/bbY4vNA8uO4iUdVqFMAN4D1tVqYV3UCjXqCyzg2+Bwp+cXCNZf+Iy9xMGkQ/
         K/ACHJCNX//qrsSHlDgXAhLyWGCT1o7YoCOYfcqSyCuplrrjqWllSECjG4WMA9Zmk5gO
         tAIH5Td++OLtC4pVfaeBxqtVHZ7ysEYxw1JhepZ5oV1wOnJen5FMiw8vznbWUwZjRK9m
         f5qelYFGsMuubplpO7+ohy64fZ9vybA587KDl+VjrOjZS38Uts5RaancCQljBbJtuEqE
         fhmDXVJrvr+9q4L6QM+TIMwtZwDaLMoRFyreHjfrD1FP+vN1MgReX8j/HlCTvppxebAb
         jAbA==
X-Gm-Message-State: AJIora/GM/QrnnWqLTXcz2Q+rrvj5du8QCwZmlxNzXoSk8D60VSl/2T0
        xlj7YCd7dSUjLiZX8/5O20e0Hx/EMJdIBg==
X-Google-Smtp-Source: AGRyM1tRc9vJKCQSKHD0HtxcBYzDVFPasvN703th5wF32SJD1oYY04l5js9ZdXoY+0UF26+DkE0HGA==
X-Received: by 2002:a05:651c:2211:b0:25d:5ffd:1e2e with SMTP id y17-20020a05651c221100b0025d5ffd1e2emr4925856ljq.390.1657811737043;
        Thu, 14 Jul 2022 08:15:37 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id m12-20020a056512358c00b004793240041esm401665lfr.277.2022.07.14.08.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:15:36 -0700 (PDT)
Message-ID: <277e0484-60bd-7405-4cd1-acf0a03ef195@linaro.org>
Date:   Thu, 14 Jul 2022 17:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Question: regmap_field_write() - why using update?
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
 <YtAxK1lIooDmdVBP@sirena.org.uk>
 <14b0e150-511c-867a-281a-1d13e7e318e8@linaro.org>
In-Reply-To: <14b0e150-511c-867a-281a-1d13e7e318e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 17:13, Krzysztof Kozlowski wrote:
> On 14/07/2022 17:07, Mark Brown wrote:
>> On Thu, Jul 14, 2022 at 05:01:29PM +0200, Krzysztof Kozlowski wrote:
>>
>>> I am converting my driver using MMIO to regmap from readl/writel and to
>>> my surprise I found that regmap_field_write() does not behave the same
>>> as regmap_write(). I would expect that they are the same, except one
>>> operates on fields.
>>
>>> However regmap_field_write() uses an update method [1] which means it
>>> reads and performs update. regmap_write() simply writes without a read.
>>
>>> I find it inconsistent and a bit confusing. Any reasons for such
>>> behavior so I won't send a patch which breaks 100 of devices?
>>
>> How would you propose to write to a field without reading the rest of
>> the bits in the register?  Otherwise you'd be doing a full register
>> write rather than just a write to the specific field.
> 
> Indeed, I forgot about bits in a field... So it has to be like this or I
> need to use regmap_write(). I find the regmap field API very useful for
> devices with different register layouts, but the actual "fields" part is
> not really needed in my case.

... and few registers (like "clear" registers) actually do not allow to
read.

Best regards,
Krzysztof
