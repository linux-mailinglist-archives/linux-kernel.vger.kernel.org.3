Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E394FE028
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353522AbiDLMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353032AbiDLMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:15:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C08B6DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:16:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so36630692ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QftC8yM+rUi2GOJON22Vc2R4NpEgVxs6x2hJpLqwdnc=;
        b=YiJgoYeBRq9Y21t33IryYjiuDLJTAioEQ2GbYTsR5cTeWCcL0+egkZjsFoKqqyqASX
         mvHPFm3DGmrcyc2GLutxiyEiei0hcCNw0m7mJS/7wONYLuKhZJ41ReUF9bT9Rd5GQ46f
         vA2PUVZkMTkeRSLxhIMy9Nz+STf5OG0321tjqe2J0RkqP/io4YuwP2teVrs8ff0xGHjl
         TG1uklojBCOUxFJTYjSm5gPs6jrn2Ag62gYS5mGZQOXIKVe4HVGxWG8kwYCA3ObVgWC7
         jEnFQGavM7LdDGKtyWjQVFSWmV7afJq/d/G1C+r4mNp7DUYpvJ30Z3P5LBI/eUFidqvd
         dDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QftC8yM+rUi2GOJON22Vc2R4NpEgVxs6x2hJpLqwdnc=;
        b=hco9C2aD+rbjoBkvHjG7UnGB9CcE7OezI9N//VYo3cx+PheaUqKbCWJnIivmgFPE8g
         M/GcFsoyVu04rICIHu1sy9rGkXvEGZau6dYfZkqTFP4kLRUDDs0SjS8x3VMifVp89ARS
         ZLIuuFAOb4ty3EW2t9o6M15CrRRINKHq5HbAev86yoVG81e57EgjtXRHhShDG9rNLFZo
         lSWSxENEchzPRBi/ONd6EqWovZYEQ0k32JfVe7zI8hdZ7qepgdFQqAfMKdxpTe++lGyi
         CMy77mCc/kkU0LlGY2FaFMQ5oAXl50+idOP1FLPU3ETs1uwCMD4ZLPpXPXjfzNawp4mr
         JoBg==
X-Gm-Message-State: AOAM532nPGyDJM+NX5w7+5r2sDf81h00LHQ8EmAhd8pOfbajw0tm/UGc
        Khy6c+27Dwm08GiMqs3RWZMA0g==
X-Google-Smtp-Source: ABdhPJwTG/0ht3PfH8/lq8uPzYm/e2Ao+H/Xa4o6fo8AnoydrKmhd5cCF0GGtULh9uSw1g9jUUd7OA==
X-Received: by 2002:a17:906:b107:b0:6e0:a25a:af6e with SMTP id u7-20020a170906b10700b006e0a25aaf6emr34159552ejy.359.1649762181893;
        Tue, 12 Apr 2022 04:16:21 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm16534904edu.93.2022.04.12.04.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:16:21 -0700 (PDT)
Message-ID: <d74cd447-ac2f-92d5-f845-ee62d48cbd3b@linaro.org>
Date:   Tue, 12 Apr 2022 13:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX65 interconnect provider
 driver
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, djakov@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649740053-14507-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649740053-14507-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649740053-14507-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 07:07, Rohit Agarwal wrote:
> Add driver for the Qualcomm interconnect buses found in SDX65 based
> platforms.

Thank you for your patch. There is something to discuss/improve.

> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {

It can be array of const pointers, if you rebase on this:
"interconnect: qcom: constify icc_node pointers"
(I just sent it but I am not sure if it made it to the lists)

> +	&bcm_ce0,
> +	&bcm_pn0,
> +	&bcm_pn1,
> +	&bcm_pn2,
> +	&bcm_pn3,
> +	&bcm_pn4,
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn2,
> +	&bcm_sn3,
> +	&bcm_sn5,
> +	&bcm_sn6,
> +	&bcm_sn7,
> +	&bcm_sn8,
> +	&bcm_sn9,
> +	&bcm_sn10,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {

The same.


> +	[MASTER_AUDIO] = &qhm_audio,
> +	[MASTER_BLSP_1] = &qhm_blsp1,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QPIC] = &qhm_qpic,
> +	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
> +	[MASTER_SPMI_FETCHER] = &qhm_spmi_fetcher1,
> +	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
> +	[MASTER_IPA] = &qnm_ipa,
> +	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
> +	[MASTER_MEM_NOC_PCIE_SNOC] = &qnm_memnoc_pcie,
> +	[MASTER_CRYPTO] = &qxm_crypto,
> +	[MASTER_IPA_PCIE] = &xm_ipa2pcie_slv,
> +	[MASTER_PCIE_0] = &xm_pcie,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr,
> +	[MASTER_SDCC_1] = &xm_sdc1,
> +	[MASTER_USB3] = &xm_usb3,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_APPSS] = &qhs_apss,
> +	[SLAVE_AUDIO] = &qhs_audio,
> +	[SLAVE_BLSP_1] = &qhs_blsp1,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
> +	[SLAVE_ECC_CFG] = &qhs_ecc_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_PCIE_PARF] = &qhs_pcie_parf,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QPIC] = &qhs_qpic,
> +	[SLAVE_SDCC_1] = &qhs_sdc1,
> +	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
> +	[SLAVE_SPMI_FETCHER] = &qhs_spmi_fetcher,
> +	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM] = &qhs_tlmm,
> +	[SLAVE_USB3] = &qhs_usb3,
> +	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
> +	[SLAVE_ANOC_SNOC] = &qns_aggre_noc,
> +	[SLAVE_SNOC_MEM_NOC_GC] = &qns_snoc_memnoc,
> +	[SLAVE_IMEM] = &qxs_imem,
> +	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +	[SLAVE_PCIE_0] = &xs_pcie,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sdx65_system_noc = {

All these structures can be const.

Best regards,
Krzysztof
