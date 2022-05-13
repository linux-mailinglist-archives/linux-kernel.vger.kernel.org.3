Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937D9525E59
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbiEMIqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbiEMIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:45:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698059FD7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:45:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso6551371wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RZ8yTIuVwipuvbXpKbDAO+yIaNvj7+8XD8hFioYNFl4=;
        b=qEjAs6KRQY3PArkmVwn+6xihr+K0c+GcFb2R40zv5/choYpPpcDdnkHtGwzdqSmurE
         AF1wiYK+vF+cKow4n7LOSxJJYIbv69D3gjVC4j+SBX+uW3DdSt+pl3Dag/QkREqHwlUp
         YhryStObqiMZIYWxPO1NS7H/G2JRUpKbpPpdvpalr/WcbFnJ13Cu4MB92RQ8DItjwFq8
         T8F0fVYXfnFuigT8revG9IJbur2s/9X75U3HXlMxEw6cEYx+ohvmbNhYXg2LPnlKXkUs
         IOdrM/NQa2IIZYZIpV1/hJNlFUweVKLk7KbW/BHKFdgTUOO7DRyYmLdOXJk9FDuRMRD3
         x5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZ8yTIuVwipuvbXpKbDAO+yIaNvj7+8XD8hFioYNFl4=;
        b=wMnOGBh+nnbBttAXywodIhhaLOyDLGY95ddwllq7fD3KjJ3MFc+j0LplYwL1g0nKJd
         uHIzP+bkcF3+jtZnno3WdMbvmYn9PBHXyNsHjqdJKcYpqx9XcJUHESWcHhauI8vAjyHF
         lAEV0yuqlzacwe3t9hRfaAXkSRv5IOiu/UjFDNffLS9KTBRWxvS6uUx/KiL0BBq2mCTu
         4n3LakrQNrIC5aIrAS+CbHvbd54tdSn5ftiK3CjHdXcHAw1pwduk9jO1+prEDR9wLHyt
         X3mk8H16J2lYsgKaTfx8X+pQi5owq8BIWAdsHsmnAM0lvN9yXc1wBQ8aHQHVLD7tpdGy
         MrPg==
X-Gm-Message-State: AOAM533kI4m1nHyLeTvSuyI9jaSHFk6SxQGi/u6zQRgP3TsmXF2Z04k6
        yfYjRMma03HEbzovltp+XhO6SA==
X-Google-Smtp-Source: ABdhPJy4/fTItdUhko//AscP+mK3Y8qnApfYBgO5e0+J/cdShWpSgBIOR5L1JhNXonhyJ4RxcOsseg==
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr13990355wmi.116.1652431548987;
        Fri, 13 May 2022 01:45:48 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r15-20020a7bc08f000000b00394615cf468sm4809214wmh.28.2022.05.13.01.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:45:48 -0700 (PDT)
Message-ID: <8ec8905c-3eb5-c2d1-f5f5-b5949d42fcf1@linaro.org>
Date:   Fri, 13 May 2022 10:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 09/11] arm64: dts: marvell: split Methode uDPU DTS
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-9-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-9-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:49, Robert Marko wrote:
> Split the Methode uDPU DTS into a common DTSI as preparation for adding
> support for Methode eDPU which is based on the uDPU to avoid duplication.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
