Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DB5A6159
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiH3LKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiH3LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:10:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A31A053;
        Tue, 30 Aug 2022 04:10:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n17so13735855wrm.4;
        Tue, 30 Aug 2022 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KpgP2qAqf0KZkAqvNQ7Evuz6Whcqmhjrgxj7AES/ew4=;
        b=YxyWlugdaEOoY//AT76IwSakYBJd26WbYy29IbOmDS2env9XYf7ICqkx0tUJguUOHu
         g64EfBQHV+KW5VXbCs4Q+xJIPYnbTLxOy18C2Bvze0AvNOh4FvY2Q0QGNIAtYVkIB28w
         wlF0An6tiLeHDXVr8JrCyFK3MBs9sKRXztUhNrPWUBcXFlvpMTHKPr+p/k3XbsIK1ibB
         G6LQavIMnudARUo0ayG3MLTk5C3rD1MxcF/q3kE1atFlwbU48yXmsW/FGPuwY5Cne792
         aRT0zY8eU6Tye9PHzIx9PCDZLo5Q8Ojxg1h11VQsSDaRFBcdQL2tI+39gbFPQ1CfHBcB
         kcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KpgP2qAqf0KZkAqvNQ7Evuz6Whcqmhjrgxj7AES/ew4=;
        b=lomLTaOWDzvCIDd8OSej3X74F+QTt6PXoCCJOcJmXBCZcuS94ALMfbkSb4GrRSVSsB
         7HbW+U5SEhfZkAJr1WUHN7PL3TIb7NF6rTnl3fuSdtDqnw/FL9yU2txyRpcdN1oO88cI
         5anYYQBJERPXSwVVxQKLtIIUzw8MkirniqO8q+Zl39B0ygQy80062W0TY9SJgjAknVYd
         FkI2mGrutS06YbNpDNSmn6u6UhvPoZ+cOdFpO6kDrLC0CQYFOosXj6yKqMJLFY9osxQj
         B6kt0R1gW/p4g/LuKBXDYj/BFU+ftjkxblE6nqh3NP/L6v6ZG7on1jDDBdQVgtqXFTkI
         j6fw==
X-Gm-Message-State: ACgBeo20ayirC9wmio2AiV2XtJx5/0k7PrceZipeNK5e2Xi4yas3NxxM
        xVcsKmefy/TaBnbZPD1l14eXv/BgsrA=
X-Google-Smtp-Source: AA6agR5/R1cJLwxYVCLUahhMwmW8K71m5gbXB/54eAbtUV5b+RKCbRfYtumpKmuhmih0DiU7bfmmHA==
X-Received: by 2002:adf:e38e:0:b0:226:cff1:4b21 with SMTP id e14-20020adfe38e000000b00226cff14b21mr8561304wrm.226.1661857811449;
        Tue, 30 Aug 2022 04:10:11 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j2-20020a056000124200b0022537d826f3sm9314130wrx.23.2022.08.30.04.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 04:10:10 -0700 (PDT)
Message-ID: <18caa4aa-9ed9-b2d8-b375-395b444d0ed5@gmail.com>
Date:   Tue, 30 Aug 2022 13:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build failure after merge of the mediatek tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220830094230.18c76615@canb.auug.org.au>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220830094230.18c76615@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 30/08/2022 01:42, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mediatek tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/soc/mediatek/mtk-svs.c: In function 'svs_get_bank_volts_v3':
> drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
>    887 |                         svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
>        |                                               ^~~~~~~~~
>        |                                               FOLL_GET
> drivers/soc/mediatek/mtk-svs.c: In function 'svs_set_bank_freq_pct_v2':
> drivers/soc/mediatek/mtk-svs.c:1073:25: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
>   1073 |         freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
>        |                         ^~~~~~~~~~
> 
> Caused by commit
> 
>    a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where possible")
> 
> I have used the mediatek tree from next-20220829 for today.
> 

Thanks for the information. We were able to identify the issue (not really 
difficult) and I pushed a fix to my for-next tree. So we should be good by tomorrow.

Cheers,
Matthias
