Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1952041D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiEISHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiEISFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:05:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102313CA33;
        Mon,  9 May 2022 11:01:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso81034pjg.0;
        Mon, 09 May 2022 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Zr4sf3jMmMYEtunS1AGBN0+UBbxqzKWjBhRS7eCzWvU=;
        b=kpaE3+pcIgmBhM8YMFL+srUugcyrQZd15pyIU9uVjAb3Lhku1yhOBaH3E3dcG1ajGt
         d92ozd2RFpublhOQGdgvwPKF338HhuoG5sQzeRZcoLG/QGpgDovlxI4cGG8HlNrMM6tp
         xIf3B70b3eQHR5L/bFGOjd6CM8NirgYmuQzvW9TunWBpoiwfyNGePZIt0vKheZ6+M3Yy
         cm2PzIZjf6BqCRlTyFUTBJ7QpvlDtD4Vo9vyffzeU/a+iHZa/ndF9a5Ono57bqKgQOE7
         AQ1DSY7Tnr0CZELPJNXjpl6SKR43CJvVmSFTvPX0gWcwnamc3qyvaOX0dl1bJlnmOtXY
         Hq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Zr4sf3jMmMYEtunS1AGBN0+UBbxqzKWjBhRS7eCzWvU=;
        b=CeWSUAhn1DFg6aZNCPTOk5N7raB9mTXuYc71jsu7fR4UC9JA8C0DO3Zq1HQKugvjn4
         f/USE2klhFwojFsAFynH1kFtvNffOEGmez4vJeUSHx+BoqZ7ihu2wlG56cbkXllH5cD4
         oy1nTjuHru0EZE/DIPKs7BkEcQ+Fziru9/GqagTOd/+TyScTvTASH/B2LvMrX+KXPA5C
         SdJ7T2FuRWulmK2MrwVxFbD1SGJmx49PXCOYeH0yRrmcgOJbD6SxQT0oPkL2HfyYtdkZ
         P20MRECBPY+HAkFVmptap88XviNydzwJ8VopTl/aQd/ucoQY9ZcCRUjs8YLUqIr/VN7u
         Qnkw==
X-Gm-Message-State: AOAM530I6Nugo3MphZVzrYs/vPK9Y3ZQI27kZCer8Jak0am6f9Eho5kw
        vS5meBko+y/NThI54Dlwtn4Ipp8wOCfcqg==
X-Google-Smtp-Source: ABdhPJyFbQaoXUAhKpnfNQIcQWJd7U/PXfNQ+yWN8cCtKartLmD7dTH2hzlMAQqaxWfS3ClH0R4g+Q==
X-Received: by 2002:a17:90b:4c03:b0:1dc:50f5:e291 with SMTP id na3-20020a17090b4c0300b001dc50f5e291mr19305931pjb.214.1652119312201;
        Mon, 09 May 2022 11:01:52 -0700 (PDT)
Received: from [172.30.1.40] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c10a00b0015e8d4eb27esm141329pli.200.2022.05.09.11.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 11:01:51 -0700 (PDT)
Message-ID: <faad0f87-1367-3a6a-9b99-805feb422c91@gmail.com>
Date:   Tue, 10 May 2022 03:01:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <20220509120337.92472-1-cw00.choi@samsung.com>
 <20220509120337.92472-3-cw00.choi@samsung.com>
In-Reply-To: <20220509120337.92472-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 9. 21:03, Chanwoo Choi wrote:
> - * @this:	the devfreq instance of own device.
> - * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + + * @parent_type	parent type of the device.
> + + * @this:		the devfreq instance of own device.
> + + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER or
> + *			CPUFREQ_TRANSITION_NOTIFIER list.
> + + * @cpu_data:		the state min/max/current frequency of all online cpu's

There are some mistake with unneeded '+'. It will be fixed on next
version but anyway it doesn't affect the passive governor operation.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
