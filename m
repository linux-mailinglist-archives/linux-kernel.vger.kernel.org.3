Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959754BABC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbiBQVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:35:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiBQVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:35:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB914CDBD;
        Thu, 17 Feb 2022 13:35:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A65B9B82522;
        Thu, 17 Feb 2022 21:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECF9C340F6;
        Thu, 17 Feb 2022 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645133697;
        bh=9ZKFzvuxqGDuxePE3PZ3oKNhPCfiECwJr72AD11sbFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2/fEdiI7Xhi3piBuQ1VTw64c6U5/tW4+8NghSs8QoRfCd32mX+hMXVnGH7+m7miF
         UBIW3S3nGRbCJpw6eDMS7Y49iT/GBxXVwUoyXTK+WwBgxCfI9yDTc+5aTXj37mha/z
         ZXrUYJ1esod7SXOHSit3YqX+2XV9T9nishJomHWbpRWWyA55Vkv+Q5zU9YUzOvoZ6A
         NIzghDpjVjdp0QOnqpIGVcw+y8u5x2vqEp9OiP8B55Bor+DQliSFrSnDg/dLCxMWwF
         hBjrJhKSlTFWjO1nG0lCEt/KtxfdCuq59nR91V3MN7onnRvRHVq9o/TzXRu+5uPy/U
         tjP8H0nCwuauA==
Received: by mail-ed1-f49.google.com with SMTP id q17so12051957edd.4;
        Thu, 17 Feb 2022 13:34:57 -0800 (PST)
X-Gm-Message-State: AOAM532LT3Nj3p7epuhwd33IOmnBaS7jjgfLWa5xTdFNicRSAw3WDcFG
        4D6bL63cPwNohqZ/5adKHZOc46p2k4Pyew2PAQ==
X-Google-Smtp-Source: ABdhPJwMwWaIqmzsA7pkOHfJvLLdy1aqNJdJJazYozh0+S0QqJEe9bX4ggabJGlocMvwwqLVXTQQV+g6qFWIIF9KPxo=
X-Received: by 2002:a05:6402:278b:b0:412:80a5:6cb3 with SMTP id
 b11-20020a056402278b00b0041280a56cb3mr4864452ede.157.1645133695579; Thu, 17
 Feb 2022 13:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20220217131234.50328-1-cristian.marussi@arm.com> <20220217131234.50328-5-cristian.marussi@arm.com>
In-Reply-To: <20220217131234.50328-5-cristian.marussi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Feb 2022 15:34:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+JrLtXUoG10O3kcwYNEbzXXYn0HBLsSfm9R+qLajneeA@mail.gmail.com>
Message-ID: <CAL_Jsq+JrLtXUoG10O3kcwYNEbzXXYn0HBLsSfm9R+qLajneeA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic-threshold-us optional property
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        souvik.chakravarty@arm.com,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 7:13 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> SCMI protocols in the platform can optionally signal to the OSPM agent
> the expected execution latency for a specific resource/operation pair.
>
> Introduce an SCMI system wide optional property to describe a global time
> threshold which can be configured on a per-platform base to determine the
> opportunity, or not, for an SCMI command advertised to have a higher
> latency than the threshold, to be considered for atomic operations:
> high-latency SCMI synchronous commands should be preferably issued in the
> usual non-atomic mode.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5:
> - fixed example and removed dtschema warnings/errors :
>   arm,scmi.yaml: properties:atomic-threshold-us:
>         '$ref' should not be valid under {'const': '$ref'}

Seems an old version got picked up for linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/firmware/arm,scmi.yaml:
properties:atomic-threshold-us: '$ref' should not be valid under
{'const': '$ref'}
hint: Standard unit suffix properties don't need a type $ref
from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/firmware/arm,scmi.yaml:
ignoring, error in schema: properties: atomic-threshold-us

> - added default: 0 clause
> v3 --> v4
> - renamed property to atomic-threshold-us
> v1 --> v2
> - rephrased the property description
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)

For this version:

Reviewed-by: Rob Herring <robh@kernel.org>
