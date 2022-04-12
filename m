Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE974FEABB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiDLXWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiDLXWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:22:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E78B7C4F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:54:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x4so27028iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MaajJ7zkusbdyV+RdrDWlPFgB58TUS+DORUYk8eoF/g=;
        b=TpMgOcPtmuIEVvJX34jqYwBQYhcPH4AwL++lPtPYrkCRFm0qyCX22W/igvzfTVH6GB
         VzYY3AENRPq9ySRLJLGfFhPfdusH887EgeBWOdxzzyC4DZLzPq3BbzMoZOmWY19HaVJb
         wJddEZjtM1WV/aQSeMCx7bqCYubjb+JjDfK17lLjXpP3+Oq3o+t+FuzotOsPIqVVUtqO
         um5r4T561F+7sDEm1aOCydynELHNNSqN0XFrMWuiGx64Yry9cnYcVyjmNqQrycTXepDI
         4PfsGLt95uzX9LcJpsEE2GsM7LtUFnAYiG81jVc2xVev1QO3SUTu16WUUJwuHZFDRZeR
         a+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MaajJ7zkusbdyV+RdrDWlPFgB58TUS+DORUYk8eoF/g=;
        b=UndpD+BrKJ/0+3RjF2F3aS42alibSbxZi/inntOvfAhNwZllKojcOrlvZ8amcOjOiL
         e88G15ETWN355NWt0WiHdr4trNKt8h72MYO4L4lnvxlzExgPjCZeI7QNaWqJmkWWPNH/
         iZVn4qtWXXuNrf0APENhse33vo0FPFf7TGUu+RL7+HYzDYIx2N+zvmcmaS041PUYrt7g
         ORE3S+Ktb62dHgfOk44ExI4ZXzEIlL8yUMFjlUaY45s1VB5Ol9fFQYvnukvjE5cgYAcR
         Yg8qGFWw8ipEBGQ0y793hBUgIFJlNrzDIYL4X8/78v4znfJd1tfIJjd92N9xkTGSwfjD
         rLQg==
X-Gm-Message-State: AOAM531b3nrCx/dLqi6m5JBZUHh7PzRX5tPYA+IMbCc1XzzJKO0m9KYZ
        zWgi6TSkF7tOW7Y5UK8EpXi2uWVa31T59Q==
X-Google-Smtp-Source: ABdhPJynMnh8eNdL98xX4EGcrl1aaCQc33c+Db4cAoy4ethF1nhI+kebfx0eGyR/bfWBZ5djz+A8FA==
X-Received: by 2002:a02:c019:0:b0:326:15e9:c97e with SMTP id y25-20020a02c019000000b0032615e9c97emr8299003jai.158.1649804073909;
        Tue, 12 Apr 2022 15:54:33 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm22522527iog.15.2022.04.12.15.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 15:54:33 -0700 (PDT)
Message-ID: <9e92bd27-c7b8-b3c2-6db5-09fe56bbc84e@linaro.org>
Date:   Tue, 12 Apr 2022 17:54:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] interconnect: qcom: sdx55: Drop IP0 interconnects
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220412220033.1273607-3-swboyd@chromium.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220412220033.1273607-3-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 5:00 PM, Stephen Boyd wrote:
> Similar to the sc7180 commit, let's drop the IP0 interconnects here
> because the IP0 resource is also used in the clk-rpmh driver on sdx55.
> It's bad to have the clk framework and interconnect framework control
> the same RPMh resource without any coordination. The rpmh driver in the
> kernel doesn't aggregate resources between clients either, so leaving
> control to clk-rpmh avoids any issues with unused interconnects turning
> off IP0 behind the back of the clk framework.
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: b2150cab9a97 ("clk: qcom: rpmh: add support for SDX55 rpmh IPA clock")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/interconnect/qcom/sdx55.c | 21 ---------------------
>   1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
> index 03d604f84cc5..e3ac25a997b7 100644
> --- a/drivers/interconnect/qcom/sdx55.c
> +++ b/drivers/interconnect/qcom/sdx55.c
> @@ -18,7 +18,6 @@
>   #include "icc-rpmh.h"
>   #include "sdx55.h"
>   
> -DEFINE_QNODE(ipa_core_master, SDX55_MASTER_IPA_CORE, 1, 8, SDX55_SLAVE_IPA_CORE);
>   DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
>   DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
>   DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
> @@ -40,7 +39,6 @@ DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
>   DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
>   DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
>   DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
> -DEFINE_QNODE(ipa_core_slave, SDX55_SLAVE_IPA_CORE, 1, 8);
>   DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
>   DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
>   DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
> @@ -82,7 +80,6 @@ DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
>   DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
>   DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
>   DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> -DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>   DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
>   DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
>   DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
> @@ -219,22 +216,6 @@ static const struct qcom_icc_desc sdx55_system_noc = {
>   	.num_bcms = ARRAY_SIZE(system_noc_bcms),
>   };
>   
> -static struct qcom_icc_bcm *ipa_virt_bcms[] = {
> -	&bcm_ip0,
> -};
> -
> -static struct qcom_icc_node *ipa_virt_nodes[] = {
> -	[MASTER_IPA_CORE] = &ipa_core_master,
> -	[SLAVE_IPA_CORE] = &ipa_core_slave,
> -};
> -
> -static const struct qcom_icc_desc sdx55_ipa_virt = {
> -	.nodes = ipa_virt_nodes,
> -	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> -	.bcms = ipa_virt_bcms,
> -	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> -};
> -
>   static const struct of_device_id qnoc_of_match[] = {
>   	{ .compatible = "qcom,sdx55-mc-virt",
>   	  .data = &sdx55_mc_virt},
> @@ -242,8 +223,6 @@ static const struct of_device_id qnoc_of_match[] = {
>   	  .data = &sdx55_mem_noc},
>   	{ .compatible = "qcom,sdx55-system-noc",
>   	  .data = &sdx55_system_noc},
> -	{ .compatible = "qcom,sdx55-ipa-virt",
> -	  .data = &sdx55_ipa_virt},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, qnoc_of_match);

