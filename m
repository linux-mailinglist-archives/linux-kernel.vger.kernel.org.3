Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2ED599837
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiHSI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347974AbiHSI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:58:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF65D83ED
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:58:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h24so4410403wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=Ffq4pm+fBB/gtznE6uzX6IlBd2C6b+2crFJbBiVCYtQ=;
        b=8VkEaXPL3aUVEP3xoIeg33AjWpzKZwXE2gqCdHw5p9R8nSxW4kxlM6fPaINhC5ekFT
         t0uxzysoj5lVT/Kuu4TqZMM1Ky7EdQIyvJcOkkIxFUe4lPghaLZEmSEXPAavpDtQ53op
         O0R5nrfJtG8HS9btNLxeDpgTm5SZZcNnKDZLI8MnV2Df/49wVMu/kTjtZLNtwOlqDRw2
         SYEGuYLcgyfwurUiSH+E2Qqf/QtnLT3wOdEOkVrwVCv3G6CpQS0Z5NeeK/th9PbeE/Qo
         PnkKV1dBYAxeStHgCseXyw58ZqWie+3mDw4WmF3PHj4yaDT45SMCu+WM82pov/cAcJxJ
         MMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Ffq4pm+fBB/gtznE6uzX6IlBd2C6b+2crFJbBiVCYtQ=;
        b=BS5n7A4E6zuHmz7dbuYotkLB9GgKs5+k8pq+afdIWB19lCwGtrZL9ffWTTO603x8EU
         jpdIoAPtSX6EC2TmcER8Z3dLZZBSqsVXWP4TEtTkOdrxz3tDST89xU9D3c+x/+H340kx
         Mj08mY7JLtGSmnenk3Pw78vmRoo7wOmvPnX4XcaJJdRpBLS1w6bzojwgqVXH/hQmVr7R
         za4VE6/5fxb61FqAhyJG8rQZz2mBlAGhUdu3r/aAGx3XplMq9RhGqD+r7PFSecUgYSL3
         iS7TuZSAz3jtlZzZb1jITukPULINi1VK1eTu1EP5GCAYGHl7tu3LE41D6XTEqMoQIMYl
         m+QA==
X-Gm-Message-State: ACgBeo2yy8hKlvcN8THVFgw8VpPZaOwOnn/UEn7nygFMgv2NqcVu/klz
        gJdGkyBT2EFWCtqQGznN8hzBmw==
X-Google-Smtp-Source: AA6agR44T/L9Brv1d9i92rACo/P9wJDvvm/ddfSSTDIy5nJySAfUIW7ZgMh1piSA1Fg7P41G6UNHfw==
X-Received: by 2002:a05:6000:1e0e:b0:220:5c9f:a468 with SMTP id bj14-20020a0560001e0e00b002205c9fa468mr3434353wrb.587.1660899524029;
        Fri, 19 Aug 2022 01:58:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a02:227:fda7:6a0? ([2a01:e0a:982:cbb0:5a02:227:fda7:6a0])
        by smtp.gmail.com with ESMTPSA id o14-20020adfcf0e000000b0021f1ec8776fsm3542436wrj.61.2022.08.19.01.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:58:43 -0700 (PDT)
Message-ID: <6ddb18be-2b89-03ca-a839-4ec97fe9f8d4@baylibre.com>
Date:   Fri, 19 Aug 2022 10:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] media: meson: vdec: add missing
 clk_disable_unprepare on error in vdec_hevc_start()
Content-Language: en-US
To:     Xu Qiang <xuqiang36@huawei.com>, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        mjourdan@baylibre.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, weiyongjun1@huawei.com
References: <20220818065753.104050-1-xuqiang36@huawei.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220818065753.104050-1-xuqiang36@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 08:57, Xu Qiang wrote:
> Add the missing clk_disable_unprepare() before return
> from vdec_hevc_start() in the error handling case.
> 
> Fixes: 823a7300340e (“media: meson: vdec: add common HEVC decoder support”)
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>   drivers/staging/media/meson/vdec/vdec_hevc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_hevc.c b/drivers/staging/media/meson/vdec/vdec_hevc.c
> index 9530e580e57a..afced435c907 100644
> --- a/drivers/staging/media/meson/vdec/vdec_hevc.c
> +++ b/drivers/staging/media/meson/vdec/vdec_hevc.c
> @@ -167,8 +167,12 @@ static int vdec_hevc_start(struct amvdec_session *sess)
>   
>   	clk_set_rate(core->vdec_hevc_clk, 666666666);
>   	ret = clk_prepare_enable(core->vdec_hevc_clk);
> -	if (ret)
> +	if (ret) {
> +		if (core->platform->revision == VDEC_REVISION_G12A ||
> +		    core->platform->revision == VDEC_REVISION_SM1)
> +			clk_disable_unprepare(core->vdec_hevcf_clk);
>   		return ret;
> +	}
>   
>   	if (core->platform->revision == VDEC_REVISION_SM1)
>   		regmap_update_bits(core->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
