Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4524BC031
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiBRTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:21:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiBRTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:20:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFF2838DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:20:41 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1819440304
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645212040;
        bh=H0Iwmd8wCuU9HHukGVMrKzFKF37GPFWQBtO1dM10cGA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tnirLOHSVJC/I18fFVGats1KzVhWNAWRGc7yDhQ8AWS3r59/pyfwrIj3SvUlxQnuy
         9bjcvUhfZBePJaTV1XwXMyfubzlK+QQDIU0v3Y53DopCZaShCXWiuEVVjVn1LBB2kt
         2dqxk1/hecXP1iXdnwbbaAVXqY/WteSg1NfsRsNLzfVJe864uT0B3D0dlTRzoiNiuj
         VINR/MrI5/FYwPikSztxo2xJ8hwPeez+FjqMAfRMqYDYJnrsH8OKj7+d5byOzvSJq/
         VdEfLLB7L+X5g2T05Gpi+BViJxDqOkXcGVMlZ953RNKqEl+LGHG5hBNja/cwa4H4Kn
         DCKHIAqJoj2vw==
Received: by mail-ej1-f71.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso3476471ejk.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H0Iwmd8wCuU9HHukGVMrKzFKF37GPFWQBtO1dM10cGA=;
        b=EU5A5n7SIaU6nj84OZb5lds6OHLlpZ4fK7vNskD6dty253Wq7JcV2/M/X3ElYTS+3n
         ex22VXBZ2n/SYPAIL8oK8ckTmdLmdN6jrK6buSQD+trQaVXaMUrRa6zifM19tY+DGbea
         IgDj4s4FSCbMqhp3cMce5bzBKdyE4BpriiZSD3oS2nfT+9KaCcE8DZuQnQVc3FvapW0l
         vStsKThvX+noH5Uv8/+HNJk0BlXoadErsDeIZJbzgvULrv3sT3m/hNYdtlqgfmjfEfYy
         WqpZr9zlTJ9dG6Fagay+AC0HABCZF5yi3Ymir2EmjZxPr06ttcIIQQ45Mqe0gEND/Bip
         dlpQ==
X-Gm-Message-State: AOAM530FSAI1T/SavSk8gL8v8Vx7EnrYisF1OytTMde/Os4qdQbrDuWR
        AfukPbkc4qz8r7DLaQ5Sw+aXtc2IwpuQjVeHLk0xmIZRzTi+52i1zvbggcJKDsC7oy9qj6TiJk2
        jV6goS589RKFBMacCXFI9NM061Sbxaa7iP51GCI3u1A==
X-Received: by 2002:a17:906:b1d0:b0:6cd:fa02:b427 with SMTP id bv16-20020a170906b1d000b006cdfa02b427mr7463369ejb.99.1645212039291;
        Fri, 18 Feb 2022 11:20:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+3tAag5IIivzTuXFNNLBWIeNlv9ap8rmkimlg4Z9CIQb87t2RY7mnVEypnk+2Ca7rgN3Q6g==
X-Received: by 2002:a17:906:b1d0:b0:6cd:fa02:b427 with SMTP id bv16-20020a170906b1d000b006cdfa02b427mr7463358ejb.99.1645212039146;
        Fri, 18 Feb 2022 11:20:39 -0800 (PST)
Received: from [192.168.0.116] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id l24sm5147643edv.88.2022.02.18.11.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 11:20:37 -0800 (PST)
Message-ID: <91a26d60-abeb-6188-2ed2-1145e52ca36e@canonical.com>
Date:   Fri, 18 Feb 2022 20:20:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] power: supply: max17042_battery: Use
 devm_work_autocancel()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 18:37, Christophe JAILLET wrote:
> Use devm_work_autocancel() instead of hand-writing it.
> This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: s/devm_delayed_work_autocancel/devm_work_autocancel/
> 
>  drivers/power/supply/max17042_battery.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
