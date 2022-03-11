Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451344D6A84
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiCKWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiCKWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:55:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B616254A84
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:41:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s42so9112783pfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ahqlChR4R/wAxZuLbVyGpPDOrLLpoD2GWFAgzdSRBio=;
        b=IoAw069B2W4wIr7xE+LDXabaoa+2tWXedXk/rq6DZFB8IcxmAaWTTW/pBRkvOn7FVC
         +MFMKZyLWIlTANF5Gqi9nD2rsmSG+BtOHVVFdSFdLPHXzJuKRor/a+tb/Ex1COmpfoUa
         CtHR8VLYvXi3kpB3lD69QCKRR+i6byWsp2NzolQjYj5uLyudCkocSjetC7vTwXLfKEr1
         +y1Sj8kpOMM22wwZ1X7TypiPJEyvMh44YrnzznfjehIpm+H1lL6KmmEqGffUmOYav5sV
         Y7KSPE5zJ0fLeth3SxUapx/QT4P/9N0QziscnXZmyEjBIJxUSfwJSi6WgY3ms/S+mjTL
         frGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ahqlChR4R/wAxZuLbVyGpPDOrLLpoD2GWFAgzdSRBio=;
        b=SybkywX8yLRmxNysocC22l76H1Q5fJbxvifAIssyYZUM/zvQ8cFc137j9bbw8U9HUE
         INBkZbWf2We353kFOc0YmfKevruV4Np5jtHda0qJUeaI7dACTxvoDWV2Hbd1UV4WCVSJ
         3Vbak38w/Mo/PNlPRDusfQOwIMz8096khEF+HlEIP1bowlrHGwZgR3QZXHtr4zC16Xp+
         8JEduRGVjX1N16OxvTxNsClH2f96A9R3xpCTAUAo5pSb85UO1+rafZMxhAbgt6p3HxtQ
         sjNnxhkJ6kJukheTZvnEa65bjucORfB1pbMlsP7h8HM4bxtVdBU7VTIEX1wzXdp+uS2I
         jEow==
X-Gm-Message-State: AOAM533KXGt+7MNIMUJDxcy9e/E0U+boez5G47xxEW3PYqpP3jouz+9z
        37Ceax7WqN3p1Z/BrPrXKMo=
X-Google-Smtp-Source: ABdhPJzcMneJKmqDp7c/GtxCPZtgbRZPV12HGejFy7ed9Jh/5L0eg3ehHhaIedcFBVm2GPz2gyoaEA==
X-Received: by 2002:a63:2250:0:b0:372:c564:621b with SMTP id t16-20020a632250000000b00372c564621bmr10402978pgm.601.1647038508797;
        Fri, 11 Mar 2022 14:41:48 -0800 (PST)
Received: from [192.168.43.69] ([182.2.70.192])
        by smtp.gmail.com with ESMTPSA id e10-20020a056a00162a00b004f6fc39c081sm10736172pfc.211.2022.03.11.14.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 14:41:48 -0800 (PST)
Message-ID: <7ea1ca0f-804c-bde8-6c75-5822f260531b@gmail.com>
Date:   Sat, 12 Mar 2022 05:41:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [ammarfaizi2-block:broonie/sound/for-5.18 33/171]
 sound/soc/sof/compress.c:54 snd_sof_compr_fragment_elapsed() warn: variable
 dereferenced before check 'cstream' (see line 48)
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202203120019.KjXsD7LN-lkp@intel.com>
From:   Ammar Faizi <ammarfaizi2@gmail.com>
In-Reply-To: <202203120019.KjXsD7LN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 1:59 AM, Dan Carpenter wrote:
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> sound/soc/sof/compress.c:54 snd_sof_compr_fragment_elapsed() warn: variable dereferenced before check 'cstream' (see line 48)
> 
> vim +/cstream +54 sound/soc/sof/compress.c
> 
> 858f7a5c45cacb Daniel Baluta 2021-10-04  46  void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
> 858f7a5c45cacb Daniel Baluta 2021-10-04  47  {
> 6324cf901e14c6 Daniel Baluta 2022-01-20 @48  	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
>                                                                                    ^^^^^^^^^^^^^^^^^^^^^^
> 6324cf901e14c6 Daniel Baluta 2022-01-20  49  	struct snd_compr_runtime *crtd = cstream->runtime;
>                                                                                   ^^^^^^^^^^^^^^^^^
> Dereference
> 
> 858f7a5c45cacb Daniel Baluta 2021-10-04  50  	struct snd_soc_component *component;
> 6324cf901e14c6 Daniel Baluta 2022-01-20  51  	struct snd_compr_tstamp *tstamp;
> 858f7a5c45cacb Daniel Baluta 2021-10-04  52  	struct snd_sof_pcm *spcm;
> 858f7a5c45cacb Daniel Baluta 2021-10-04  53
> 858f7a5c45cacb Daniel Baluta 2021-10-04 @54  	if (!cstream)
>                                                      ^^^^^^^^
> Checked too late

Hi Dan,

Thanks for reporting, it has already been fixed in commit
    
   7e4bfcf10a03981 ("ASoC: SOF: compress: fix null check after dereference")

   Link: https://git.kernel.org/broonie/sound/c/7e4bfcf10a03981

Regards,
-- 
Ammar Faizi
