Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A45B02D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIGLYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIGLYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2583AE9DC;
        Wed,  7 Sep 2022 04:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6046461865;
        Wed,  7 Sep 2022 11:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D46C433D7;
        Wed,  7 Sep 2022 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662549848;
        bh=j9TiG0FYxKx+QfwDi42oNlex1bdbf6Sk20wozSSAlUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dXYMUHMxVOaelCcqQMzZkQGcb4Htg5wLqSN4xCtyl7qXbnGmiDxhMjPH0UdR/Lifo
         karJdZkESpxS83bQhudz1k0eJzsbsI1JliZKAyw1D+Tx40LZJKH1Fs9XjIMBn/HVmN
         zAruamsC+T6PhqE9CX+FCrH69JmMfuyqEDfdr1lde3tO507TSqAs4UmWQZ1sXNapyH
         bBConZukwbAtwTwv5aL4SndFx5RnisMGDRtdXNOp2i+uFOyWQMj5yQbq7b5DYTwB04
         co6R3BXtXMi9hCxzWjgCo6WTV82aukYklapsNyKtuTRw8r9vjoMxSXYKLh5s2Ul98O
         QaSnCDtT9eTzQ==
Message-ID: <7a42d3bc-060d-5a5a-c885-38bdb8465fe2@kernel.org>
Date:   Wed, 7 Sep 2022 13:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Patch v2 02/15] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, aakarsh.jain@samsung.com
References: <20220907064715.55778-1-smitha.t@samsung.com>
 <CGME20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911@epcas5p2.samsung.com>
 <20220907064715.55778-3-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220907064715.55778-3-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 08:47, Smitha T Murthy wrote:
> Adds DT schema for s5p-mfc with a new compatible
> string for mfcv12 variant.

This msg is over-complicated. Just: "Add Tesla FSD MFC (MFC v12)
compatible".

> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index 7cd26d4acbe4..a806489a9edd 100644
> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -23,6 +23,7 @@ properties:
>        - samsung,mfc-v8                  # Exynos5800
>        - samsung,exynos5433-mfc          # Exynos5433
>        - samsung,mfc-v10                 # Exynos7880
> +      - samsung,fsd-mfc                 # Tesla FSD

tesla,fsd-mfc

(because FSD is attributed everywhere to Tesla)

Best regards,
Krzysztof
