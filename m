Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678F511A34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiD0OcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiD0Ob5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:31:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E513F57;
        Wed, 27 Apr 2022 07:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3225FB82795;
        Wed, 27 Apr 2022 14:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3364C385A7;
        Wed, 27 Apr 2022 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651069723;
        bh=HQEf+K93lpEwvVIi3pxJSI52K68XBRJIQrx55pS3WDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9Gig039K96xmSRBZXNII5d1S0VSphvA1sRCFUK7BeExVUH/0sGPhYy4cAsNaTWgW
         oZhBjhy8S8rcUcG2IYO43Edn5IOEHOSLJ2VekPg9b7EnSj1KwTASOoIecCEutcVqxI
         1a7NYi0tn7jIXDTq5uzqiIHi9vqmUopgCveum7Q/pnoVepzpBkUMbmSYzJC2GMjiiL
         plmS63siOhF0dwqNTV6SeDfOK2e2HeamVSYtfcMrZV2WW6MlaX6zb9hvAMgHxEfL0a
         Yv5cOIhCl3OpYtzugrnKnid9+j1ZUCHIfxC0zK1ZnWn68mGnV+5sxb7+bvazZ7VooF
         no3OCCvsBUckQ==
Date:   Wed, 27 Apr 2022 19:58:37 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: qcom-ipcc: add missing
 properties into example
Message-ID: <20220427142837.GC4161@thinkpad>
References: <20220426101837.16201-1-david@ixit.cz>
 <20220426101837.16201-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101837.16201-2-david@ixit.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:18:37PM +0200, David Heidelberg wrote:
> These missing required properties are needed for
> smp2p binding reference checks.
> 
> Also includes cosmetic change to the example formatting.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> v3:
>  - add Krzysztof R-b
> ---
>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index c57dd423e98c..50f9aa72c670 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -76,9 +76,14 @@ examples:
>  
>          smp2p-modem {
>                  compatible = "qcom,smp2p";
> -                interrupts-extended = <&ipcc_mproc IPCC_CLIENT_MPSS
> -                                IPCC_MPROC_SIGNAL_SMP2P IRQ_TYPE_EDGE_RISING>;
> -                mboxes = <&ipcc_mproc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_SMP2P>;
> +                qcom,smem = <443>, <429>;
> +                interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +                                             IPCC_MPROC_SIGNAL_SMP2P
> +                                             IRQ_TYPE_EDGE_RISING>;
> +                mboxes = <&ipcc IPCC_CLIENT_LPASS
> +                                IPCC_MPROC_SIGNAL_SMP2P>;
>  
> +                qcom,local-pid = <0>;
> +                qcom,remote-pid = <2>;
>                  /* Other SMP2P fields */
>          };
> -- 
> 2.35.1
> 
