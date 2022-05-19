Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A552D733
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiESPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiESPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:14:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6FE8BB7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:14:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h29so9704150lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=itRG1VYF0gL4tx08osqrN69WT0ejZkjkV+TfO9bvWJE=;
        b=XgTq/dYFSFIFbxx2d+NAGEPQm3O+J/Xh081BltdpCukFuUVx5ZvdL5/6n5afgOvTbL
         D2Lsu8XJjBF19F1D3xlemyp4ReN6dVt4EUtw1qfSfIbzQbqBDM2VUzz74YHxrD6h/PLf
         pdXLV3Q4UTGi73BXZ3WPW/TrqxFP3x15KKMdF/VDc/gNJJdh3Ff9G0DeFW2PrDcq/WIO
         UIv0yynTIgEgExj9wF0p0LbfsE+2s/PTFMW+BpSlgDEqB1AAmudQLeKvudY/i2pcbXLu
         iR0JMDdoejKsX2MEBe3udItgXtdQ2kmuNBPY2E3pJXOJ+wvOXHbR63P/cd/LC/oUxyLn
         oPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=itRG1VYF0gL4tx08osqrN69WT0ejZkjkV+TfO9bvWJE=;
        b=52mSzvkp1xSV4VbU3VIxInYmyN/iT8p9npAFwMCD0MR7qSl48nVwLcbx5Lv8C0knzh
         VoopbiidP9EeCuFd06vIap6NImep6SGBbIinA6t7ob+yu+8GwOC14pIa+3mch2XH0igr
         9wK/2a7UGzHW+HWoe7Tx48yRQRx5tKSX691p4tiagbVknmtpzgBAGkxijdmQzPHq1M6G
         2jkrKLg+Rfs9noSwazhA0pFYImWoNw0ZOJUvkq9/SMz2dMwoNSuk/HMfACFgXCaQ+XH8
         r8GmKUKE4+Ij6mE5/X76vWcz+AriJ4rGr0MViObMq/EBymv062hhps2Wew7hoRct6NBY
         oraA==
X-Gm-Message-State: AOAM5300nqLWJoG1CbUwgKf+B9dk5KMxzmOKIqo6E/nQdg0IyZZ+oPQ+
        fELDHn0piM2rsB8MpmgES8KpaQ==
X-Google-Smtp-Source: ABdhPJx+3JBpSb/6KVkLPqV38qJezxmW0DN32Tjcs69+gzGm06TcInLF058I7nwCnnJw0PxwFRw1Gw==
X-Received: by 2002:a05:6512:3e15:b0:477:a28b:3fcf with SMTP id i21-20020a0565123e1500b00477a28b3fcfmr3690979lfv.476.1652973275225;
        Thu, 19 May 2022 08:14:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e99c4000000b0024f3d1dae90sm625817ljj.24.2022.05.19.08.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:14:34 -0700 (PDT)
Message-ID: <92a21768-204d-fc68-8942-99e2bc3df4cf@linaro.org>
Date:   Thu, 19 May 2022 17:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] mailbox: correct kerneldoc
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
 <20220519151334.64t5zsudz7dd35im@bogus>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519151334.64t5zsudz7dd35im@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 17:13, Sudeep Holla wrote:
> On Sun, May 01, 2022 at 12:34:27PM +0200, Krzysztof Kozlowski wrote:
>> Correct kerneldoc warnings like:
>>
>>   drivers/mailbox/arm_mhu_db.c:47:
>>     warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   drivers/mailbox/qcom-ipcc.c:58:
>>     warning: Function parameter or member 'num_chans' not described in 'qcom_ipcc'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/mailbox/arm_mhu_db.c | 2 +-
> 
> I thought I had copied it from arm_mhuc.c but apparently not. Anyways,
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 


Thanks! Could someone pick these two patches?

Best regards,
Krzysztof
