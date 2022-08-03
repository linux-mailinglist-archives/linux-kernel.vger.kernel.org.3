Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84266588F63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiHCPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiHCPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:31:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE4B5FDC;
        Wed,  3 Aug 2022 08:31:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0D411FB;
        Wed,  3 Aug 2022 08:31:09 -0700 (PDT)
Received: from [10.57.41.156] (unknown [10.57.41.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763093F70D;
        Wed,  3 Aug 2022 08:31:07 -0700 (PDT)
Message-ID: <0d34eb6b-fae9-d0c6-16b2-13be592db3ea@arm.com>
Date:   Wed, 3 Aug 2022 16:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] coresight: docs: Fix a broken reference
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <c7f864854e9e03916017712017ff59132c51c338.1659251193.git.christophe.jaillet@wanadoo.fr>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <c7f864854e9e03916017712017ff59132c51c338.1659251193.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2022 08:06, Christophe JAILLET wrote:
> Since the commit in Fixes: tag, "coresight-cpu-debug.txt" has been turned
> into "arm,coresight-cpu-debug.yaml".
> 
> Update the doc accordingly to avoid a 'make htmldocs' warning
> 
> Fixes: 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  Documentation/trace/coresight/coresight-cpu-debug.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/coresight/coresight-cpu-debug.rst b/Documentation/trace/coresight/coresight-cpu-debug.rst
> index 993dd294b81b..836b35532667 100644
> --- a/Documentation/trace/coresight/coresight-cpu-debug.rst
> +++ b/Documentation/trace/coresight/coresight-cpu-debug.rst
> @@ -117,7 +117,8 @@ divide into below cases:
>  Device Tree Bindings
>  --------------------
>  
> -See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
> +See Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml for
> +details.

LGTM, thanks

Reviewed-by: James Clark <james.clark@arm.com>
>  
>  
>  How to use the module
