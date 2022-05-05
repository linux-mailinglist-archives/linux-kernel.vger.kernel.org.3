Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1624C51BDF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357026AbiEEL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiEEL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:27:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D60953B7C;
        Thu,  5 May 2022 04:23:48 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id js14so2741210qvb.12;
        Thu, 05 May 2022 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6U81F3J95/rsKZwfBRMct5IzTiEVBNMXd4/8yYgv1pY=;
        b=h3ZZbjzjpSuW7/PZ8tQDPty8Qynf+MDjS6JNjHEtstVUzL+0nGy2id5rG8A+oivq1L
         9Ond9wLsMUEHqHxInPeFL21Go62hJg3//jT9oAydMsWZpgfr1JQZZSvlOZjMcHj9SN/o
         4GoBJf16VZhWzr6xJJekScoDVgrm8jdRFSRTlCNwVMkj9noWh6bGg57JdkNxtlHiq+OV
         X8LUsHEK2YM7xnhlXJmoGwamHfX2QsUfjoGmmVgcCPLKKSmLEddVTBYL1jQFxNS4NC+U
         TNVD7JjQzpSLlxyGfVXA1TAKJfW43i+rIYd5de/mpgvw23dS6HH4/0PXSFpEnZZmtxrL
         JHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6U81F3J95/rsKZwfBRMct5IzTiEVBNMXd4/8yYgv1pY=;
        b=NTzI2Pnbw1DQ0eMjHlioiOuTOs0zn46p2LkfAsJrZ4NOM19/QY3ioamzOFmFL28CAt
         6EZg/faQ+5DIvObPCDwZssd44F5S8C897gjGBUqrktlGTjWoQUnek+eOJ6iUP0u5Mh+y
         B5txaEz/F/vdbb2hfCB/0/6jO2dQqXfUT9jGNxtHMkyGEnvT8wG0Z6RybvvUVjwFKLZN
         tNf9fNCKclGc2OmE7i0Zzc+qaP+Z641WRrXiuURzuMZk+ZvqOeqkVsF51rf2bybv8q0l
         3peSMNvIKfEvRwHCMWQA9X/7dtHWYVcMNFjckN6Skwm5WWf5YAfNtCPH64B1MH1Jjdu5
         SH1Q==
X-Gm-Message-State: AOAM532itMLgyuenyhlmIo5DeJzaB4Ol02zymzYw5GBIA2jizWkLoCkU
        MWCbNa3l57nR480vha+HaWo=
X-Google-Smtp-Source: ABdhPJwGpx1RTwxpJjGtF0OKzKQcTGoX1QKpDZJVF/fVCD8pLGCgp5rXHRMGH50s7Yvjz4lFgtgGjQ==
X-Received: by 2002:a05:6214:2461:b0:45a:bcbd:bcf7 with SMTP id im1-20020a056214246100b0045abcbdbcf7mr4526808qvb.79.1651749827778;
        Thu, 05 May 2022 04:23:47 -0700 (PDT)
Received: from [10.4.10.4] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a27d500b0069fdbe43a5asm652449qkp.41.2022.05.05.04.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 04:23:47 -0700 (PDT)
Message-ID: <5b8a7e58-1b84-6a6b-cc9e-b4224392b5ef@gmail.com>
Date:   Thu, 5 May 2022 07:23:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 12/15] pinctrl: freescale: Add i.MXRT1170 pinctrl
 driver support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-13-Mr.Bossman075@gmail.com>
 <CACRpkdY2MNkAKhVOQ_Eyq0AwOtEW-seSrxgsJ2D8E78u636A8A@mail.gmail.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <CACRpkdY2MNkAKhVOQ_Eyq0AwOtEW-seSrxgsJ2D8E78u636A8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/22 17:38, Linus Walleij wrote:
> On Thu, Apr 28, 2022 at 11:49 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
> 
>> Add the pinctrl driver support for i.MXRT1170.
>>
>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> ---
>> V1 -> V2:
>>   - Nothing done
> 
> If I get a review from a Freescale maintainer on this driver and the bindings
> I can merge it separately, correct?
That's fine with me.
I cant speak for Abel or Freescale/NXP maintainers though.

Thanks,
Jesse Taube
> Yours,
> Linus Walleij
