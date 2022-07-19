Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2B57A3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiGSQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGSQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:11:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40334C610;
        Tue, 19 Jul 2022 09:11:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so13919848pgs.3;
        Tue, 19 Jul 2022 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L/bWFKC09OUbSlFUldAsu82lk40H2LGm0cPcNaK4z9I=;
        b=TwS/+KKMySJMXjiNR11P85Hvd64GJh3Pd5P0xbu/DNdgwi3jCVxvCYF3U5b3lIihpy
         zkY0RTYGlHUElNYl7I/sf5dclnAK56KxZ28WJY9Zg0sX7KAXGDsOLFORO0XFqS4qzDsy
         x1KAIUMT0DRUfo2ij7DZYh5cO/pReClPyyyBfrKud3d960tFfcIrEGNWgTrDLohdkf34
         QoJ2eDf3EEkeKdnB+SwIzCT7pIZOR9or1E1gqyon81AECmpdTNPm/PYhijtbjLqbLvUc
         6ANiN21HHCsM1ikaDFbi3IFA2eIQ0bEI5daE0FrQMGeWlzuIMjs7nKR0teK8uw9fqezB
         nmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L/bWFKC09OUbSlFUldAsu82lk40H2LGm0cPcNaK4z9I=;
        b=xfXAn9BX+NyS8/Ny7JWmF530PTYCtv3Md4DYmEG7L862PVLFqCE23Mn7EeTt9IPcEk
         RViDrYRwXlRmprfgwl2jn/JqtAsn6cfsc9LYdlSNAfF8hqgczEh1DfIz2fGRNj4uKHR8
         LTfXCyVtqMp200fiLm9EVa65Pr6xgmojG+pLUX1wpe+8SVstNwkOaoL/IWyRONxIII6E
         vhMBAILYrvJl5+YIVTE1Kftk+giqX0KpGkoZlCK1JmoGaWD8dYhnDcf4fR/plbBoXrYu
         QdiQyHlcYjQWja0NusShxzGm05t/V7Q7dTO82L0aZiLEk556gKcCRkv6wg2rP3silyEX
         cw9A==
X-Gm-Message-State: AJIora+uy0tJ9BRzP4zcE8xdU8CWFVe1Z041vOCGcq6qejJOlNXbrjsd
        l5NtysUs4jX6se7+LcyAtbnAsxlr/98=
X-Google-Smtp-Source: AGRyM1tJkXNUutoU2FCGEA6IPSvj6Dy/lkAWAgwdi2lSfpTtDkQ4fRsgUv+zoQCiv2KurSEGLT1VrQ==
X-Received: by 2002:a63:87c6:0:b0:41a:3cc2:1f29 with SMTP id i189-20020a6387c6000000b0041a3cc21f29mr6676061pge.96.1658247090952;
        Tue, 19 Jul 2022 09:11:30 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0052ab5d2d398sm11552516pfq.47.2022.07.19.09.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:11:30 -0700 (PDT)
Message-ID: <a78473a8-d4f9-d525-104d-2d08f92a1873@gmail.com>
Date:   Tue, 19 Jul 2022 09:11:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH RESEND] tools/thermal: tmon: include pthread and time
 headers in tmon.h
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        =?UTF-8?Q?Alejandro_Gonz=c3=a1lez?= 
        <alejandro.gonzalez.correo@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20220718031040.44714-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220718031040.44714-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2022 8:10 PM, Florian Fainelli wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Include sys/time.h and pthread.h in tmon.h, so that types
> "pthread_mutex_t" and "struct timeval tv" are known when tmon.h
> references them.
> 
> Without these headers, compiling tmon against musl-libc will fail with
> these errors:
> 
> In file included from sysfs.c:31:0:
> tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
>   extern pthread_mutex_t input_lock;
>          ^~~~~~~~~~~~~~~
> make[3]: *** [<builtin>: sysfs.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> In file included from tui.c:31:0:
> tmon.h:54:17: error: field 'tv' has incomplete type
>    struct timeval tv;
>                   ^~
> make[3]: *** [<builtin>: tui.o] Error 1
> make[2]: *** [Makefile:83: tmon] Error 2
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Acked-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
> Tested-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
> ---
> This patch was first submitted here:
> 
> https://lore.kernel.org/all/20200617235809.6817-1-mmayer@broadcom.com/
> 
> but never applied, meanwhile the issue is still present

Daniel, Rafael, any chance to get that into v5.19-rc7? I should probably 
also have added:

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal 
subsystem")

Thanks!
-- 
Florian
