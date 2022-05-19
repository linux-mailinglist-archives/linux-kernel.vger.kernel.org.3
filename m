Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EA52C84C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiESAD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiESADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:03:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B197A46C;
        Wed, 18 May 2022 17:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B656B8225A;
        Thu, 19 May 2022 00:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5C0C385A9;
        Thu, 19 May 2022 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918631;
        bh=sV3eHN3f7GLTVlHaLT/mBGjih2EUwa1UeZSc6G+S4f4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aPrXboX0Nt14KiibsUiIHwLx2MnZMyfiNT2T9rKuiYQU3mdMdevXcSgsqckC9bvON
         y/+C1AKWOrJm54poH/92qmfKbqsmabW8Y/4mkfFLDll1pvmLNUMg1fccSW0+H2xB8M
         Vm/9gC2IGo2w4j/4KQbEjVKtpbxBk1fnfKcDgvRtAUq+y9Fm2/3bm6kDvHQ85Tu8f9
         7R1sl/jCq7yqOL+tzhJ5OZAht28UWVs7lWnS0zKIAO746K+LXxV4Wf8X25OADunOCI
         jObrdFKZ2N/jcFXmLBg3lwjwUqXtlKvGvCuohTM/kahaixVSWwoJy4CVfmI7zscCyO
         PxGGUrBljiKtQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220501103520.111561-2-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <20220501103520.111561-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/8] firmware: qcom_scm-legacy: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:03:49 -0700
User-Agent: alot/0.10
Message-Id: <20220519000350.DD5C0C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-01 03:35:14)
> diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_s=
cm-legacy.c
> index 1829ba220576..7854af4abc62 100644
> --- a/drivers/firmware/qcom_scm-legacy.c
> +++ b/drivers/firmware/qcom_scm-legacy.c
> @@ -120,6 +120,9 @@ static void __scm_legacy_do(const struct arm_smccc_ar=
gs *smc,
>  /**
>   * scm_legacy_call() - Sends a command to the SCM and waits for the comm=
and to
>   * finish processing.
> + * @dev:       device
> + * @desc:      descriptor structure containing arguments and return valu=
es
> + * @res:        results from SMC/HVC call

I think only SMC call is possible so drop HVC to not be confusing.

>   *
>   * A note on cache maintenance:
>   * Note that any buffers that are expected to be accessed by the secure =
world
