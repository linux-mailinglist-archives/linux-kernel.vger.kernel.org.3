Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB94FD8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353650AbiDLJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbiDLJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808361A38;
        Tue, 12 Apr 2022 01:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C043D6157E;
        Tue, 12 Apr 2022 08:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB467C385A5;
        Tue, 12 Apr 2022 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649753308;
        bh=r5lnm0sxojey3xs1AqNSLOGlFrFpusnlCcuKdm7bsqM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tFhl30sTiKTy84INaxUqdMw9Rv9aGynIFb742lgpVSFolADnxvUJ/xMo0QiUVnlbB
         rH3x6jOdG9L9+eZkTuRcsHDhAvVNoPMrfUiJOROkeSYj6ho9DULMPc3Xhq05QFhhuc
         aAxpONgHthrzlRu+8eq3+IkWZLP0cDofoaHWl9oR7pOwY1lVGvVFsg/8wFJT1M1J+I
         B6uqRSUctyCWGjKxayZ+mGQJySQoc8Y6nh8HVGQcM8l1i0CxJQjsOv122W93IbpAIv
         AKAQks2UxcTKe+Q58BWJuF2eSbgpLsWdh9p56GlQXGJHjWuoKolpdzthYYkD2wm1KV
         ikM6KCBmMQ49g==
Message-ID: <36b7de46-7e8b-fbb5-6eeb-89180d358d84@kernel.org>
Date:   Tue, 12 Apr 2022 10:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1649662002.git.lhjeff911@gmail.com>
 <f24781413a8a305b28a1e9c3861263975eebaee6.1649662002.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <f24781413a8a305b28a1e9c3861263975eebaee6.1649662002.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 10:52, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> ---
> Changes in v7:
>  - Modify yaml file.
>  - Change the filename sunplus_thermal to sunplus-thermal.
>  - Change the nvmem-cell-names thermal_calib to calib.
> 
>  .../bindings/thermal/sunplus-thermal.yaml          | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
> 

I commented with v5 [1] how the naming should look like. That's the
Devicetree convention.

You sent v6 without implementing the changes. I pointed out that you did
not follow what I asked for.
Now you sent v7 also without implementing these changes, again.

You also did not discuss it with me, did not come with counter
arguments, other proposals. Therefore it looks like either you
misunderstood me or you ignored my comments.

Let's assume first case, so I will repeat. Name should be one of:
1. sunplus,thermal.yaml
2. sunplus,sp7021-thermal.yaml

Not other names. No other characters, no undescores, no hyphens after
vendor name. If this is unclear, please respond instead of ignoring.

Without implementing the changes:
NAK

[1]
https://lore.kernel.org/linux-devicetree/fe67c7e7-957b-3abf-a929-5ee346657bcf@canonical.com/

Best regards,
Krzysztof
