Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1337257FEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiGYLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiGYLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:55:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129075FC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:55:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso6205161wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vt+9UWINelja7/eVYkTwzACFJWbF+8Sl4+g6ehzdmOA=;
        b=qJZN2x/qxxZE1byccFd9AiFVVdNFBqOYtQ4QrVhKtArgFOv/CBHIZCni6KJe6cGr62
         xwjQlba3Mofw1w+mO1Mc8tbRdiJ/1nuoiGMsheWC18S51+XDFQn+GlsA1AyelJqqoukc
         foFvt9sYQK0yk8DCHBEDcUDs3oDwjCV7u4E5oL6zeqCMd6sp4t74gAkN3amXaIXNrQG3
         mFbqPsoGJqSLHUMGalwXyT2c1RtRfDJ+56DEdp0aUQyHKbKHa32wE/iujGFgQ2C5Vw9R
         EYrvckbF9xg4qBD+nRnzXDpUriax7kznajBiXn0xRn689/099dQfcu831ku8qbusgGHx
         MTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vt+9UWINelja7/eVYkTwzACFJWbF+8Sl4+g6ehzdmOA=;
        b=7qe37qbYDe30pHioJ0FnOIn/M+ocIR1jgo4jamCLqaEQn3K24ohMUjoyaVYIaUxlEO
         sy92b0CfFTTfMwLStJLpHDr0kTDgSMQs1J+X7nTSNEO8GaH2e9L+s7yXb1WwW2Y9B2Xx
         hTf8hHj5zyE6CaOF7jDwLjdkhAH4Tptp8XCFSCeZkjNkSuYfnPjiWnwIM5a8WTmMoKsM
         Pl37T771akhU0m7su5w2mfkpSLLyVH0B6erUX3gWABOB+ScMMatPl4hBrJBV7ugNdWAW
         hDHgZhrzaW4KrOYQzNZWi3vRiMC4F3BEy5Tre+5lbLPsb4hbrgyzNZBt2AHk6IsKj8Ol
         NqiA==
X-Gm-Message-State: AJIora84kyzTjU8JRQrq+7lUrXAJV0D4U0FiR/gDJAwHpo7wTvK5iWiG
        kXM9tFmpGbg02MUimJgvTYmSJA==
X-Google-Smtp-Source: AGRyM1uyMTMBHd+S2NwJGkXCMlnQ9Wp04KeH98Q0zowwEOcqZMiNODRIlJSNFH+jEmFfGXt8DsmGZg==
X-Received: by 2002:a05:600c:34c9:b0:3a3:561d:4f32 with SMTP id d9-20020a05600c34c900b003a3561d4f32mr4235673wmq.30.1658750109452;
        Mon, 25 Jul 2022 04:55:09 -0700 (PDT)
Received: from [192.168.1.6] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm20937729wmm.32.2022.07.25.04.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 04:55:08 -0700 (PDT)
Message-ID: <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
Date:   Mon, 25 Jul 2022 14:55:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

I can take a look and provide a patch to fix that.

But, is this a new warn or it is a consequence of new changes in
opp/core.c ?

On 7/25/22 13:27, Viresh Kumar wrote:
> On 22-07-22, 11:01, Naresh Kamboju wrote:
>> I have found this warning on db845c while booting Linux next-20220720.
>> Please find more details in the below link,
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> [    9.769688] WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
>> dev_pm_opp_set_config+0x344/0x620
>> [    9.769698] i2c 16-0010: Fixing up cyclic dependency with acb3000.camss
>> [    9.810991] msm-mdss ae00000.mdss: Adding to iommu group 15
>> [    9.811082] Modules linked in: hci_uart qcom_camss msm(+) videobuf2_dma_sg
>> [    9.823435] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not
>> found, using dummy regulator
>> [    9.827664]  ath10k_snoc(+) btqca v4l2_fwnode btbcm ath10k_core
>> venus_core(+) gpu_sched camcc_sdm845 reset_qcom_pdc v4l2_async
>> v4l2_mem2mem i2c_qcom_geni videobuf2_memops ath drm_dp_aux_bus
>> drm_display_helper videobuf2_v4l2 bluetooth mac80211 i2c_qcom_cci
>> videobuf2_common qcom_rng spi_geni_qcom gpi(+) qcom_q6v5_mss xhci_pci
>> qrtr xhci_pci_renesas cfg80211 rfkill slim_qcom_ngd_ctrl lmh
>> icc_osm_l3 pdr_interface slimbus qcom_wdt display_connector icc_bwmon
>> qcom_q6v5_pas qcom_pil_info qcom_q6v5 qcom_sysmon drm_kms_helper
>> qcom_common qcom_glink_smem qmi_helpers mdt_loader drm socinfo
>> rmtfs_mem fuse
>> [    9.885445] qcom-camss acb3000.camss: Adding to iommu group 16
>> [    9.911179] platform ae94000.dsi: Fixing up cyclic dependency with
>> ae01000.display-controller
>> [[0;32m  OK  [0m] Started D-Bus System Message Bus.[    9.911593]
>> Bluetooth: hci0: setting up wcn399x
>> [    9.928261] CPU: 4 PID: 326 Comm: systemd-udevd Not tainted
>> 5.19.0-rc7-next-20220720 #1
>>
>> [    9.928265] Hardware name: Thundercomm Dragonboard 845c (DT)
>> [    9.928267] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    9.928269] pc : dev_pm_opp_set_config+0x344/0x620
>> [    9.977763] lr : dev_pm_opp_set_config+0x68/0x620
>> [    9.982508] sp : ffff8000089337b0
>> [    9.985846] x29: ffff8000089337b0 x28: ffff800008933c90 x27: ffff3e2780f9bc10
>> [    9.993030] x26: ffffb9048f76dd40 x25: ffffb904d98c8de8 x24: ffff3e278da60080
>> [   10.000226] x23: ffff3e2780f9bc10 x22: ffff8000089338b0 x21: ffff3e278eda0d80
>> [   10.007416] x20: ffff3e2780f9bc10 x19: ffff3e2786ffe000 x18: ffffffffffffffff
>> [   10.014602] x17: 0000000000000000 x16: ffffb904d7d90f50 x15: 6f63713d305f454c
>> [   10.021795] x14: ffffb904d9df6a20 x13: 0000000000000040 x12: 0000000000000228
>> [   10.028981] x11: 0000000000000000 x10: 0000000000000bd0 x9 : ffffb904d7d905e0
>> [   10.036166] x8 : ffff3e27833a8c30 x7 : 0000000000000018 x6 : 0000000000000001
>> [   10.043361] x5 : ffffb904d982f000 x4 : ffff3e27833a8000 x3 : ffffb904d9bf2c20
>> [   10.043365] x2 : 0000000000000000 x1 : ffff3e2786f70d00 x0 : ffff3e2786ffe060
>> [   10.043368] Call trace:
>> [   10.043369]  dev_pm_opp_set_config+0x344/0x620
>> [   10.043373]  devm_pm_opp_set_config+0x24/0x80
>> [   10.043376]  core_get_v4+0x244/0x360 [venus_core]
>> [   10.043393]  venus_probe+0x100/0x470 [venus_core]
>> [   10.043404]  platform_probe+0x74/0xf0
> 
> Stanimir / Bjorn,
> 
> The OPP core expects all configuration options to be provided before the OPP
> table is added. i.e. (for your case here), we need to call
> devm_pm_opp_set_clkname() and devm_pm_opp_attach_genpd(), before calling
> devm_pm_opp_of_add_table(). This is a hard requirement, it was a hard
> requirement earlier (before the new changes in OPP core came in) too, just that
> devm_pm_opp_attach_genpd() was missing the necessary WARN(), which was there in
> every other helper.
> 
> Can someone from Qcom team reorder things a bit provide a patch to fix this
> WARN() ? I will carry that in my tree then.
> 
> It may look like this, I don't want to touch code that I don't understand at
> all:
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index cb48c5ff3dee..c93d2906e4c7 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -875,7 +875,7 @@ static int vcodec_domains_get(struct venus_core *core)
>         }
> 
>  skip_pmdomains:
> -       if (!core->has_opp_table)
> +       if (!core->res->opp_pmdomain)
>                 return 0;
> 
>         /* Attach the power domain for setting performance state */
> @@ -1007,6 +1007,10 @@ static int core_get_v4(struct venus_core *core)
>         if (ret)
>                 return ret;
> 
> +       ret = vcodec_domains_get(core);
> +       if (ret)
> +               return ret;
> +
>         if (core->res->opp_pmdomain) {
>                 ret = devm_pm_opp_of_add_table(dev);
>                 if (!ret) {
> @@ -1017,10 +1021,6 @@ static int core_get_v4(struct venus_core *core)
>                 }
>         }
> 
> -       ret = vcodec_domains_get(core);
> -       if (ret)
> -               return ret;
> -
>         return 0;
>  }
> 

-- 
regards,
Stan
