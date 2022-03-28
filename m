Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA344E9EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiC1R7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245013AbiC1R71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:59:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA74B1CB3E;
        Mon, 28 Mar 2022 10:57:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so114523pjm.0;
        Mon, 28 Mar 2022 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ru5STglB2zaqzk2ISNkVscCvEPD1049nB4SkKXNL7aY=;
        b=gI3QQv2kSAmpt0UKXi4hyz5Z75cM9QSiYGY0oPgC9FKtldB9ybyCM8sYIqaLMT3FNe
         qHUdNif5/vwutsVRztMny4TW41z6W/Si7RanrTOI1pRUZ8sOVXL8nAVrEoMpkKuyUAx0
         5LFd2LscYC3BPgyetpc7raUTd7A/aI8njpoz7sdDDEnXnW65cAXhUxmSPGkZTV2JVORX
         IfiHjVSUy+RtrqgIRyFJRH3upKTFr7okUfiDFHcpjuRagX7WDneV34HALme3ikb6E2xE
         R7O2+aJJLQS9DtqNs6acuEK4b10ScY/1WWQMXzYFdsPouvwN/EzVBd/bRZcE3boWJgpA
         OdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ru5STglB2zaqzk2ISNkVscCvEPD1049nB4SkKXNL7aY=;
        b=ysQh3D6+prUQK0KVMFwZagJWbSwFqPzygDbstq+lftUSSflDXNEqc5kx4Cm9rZLiVz
         oRknbQvtE++wBHSugRlqLDRh0ctf/VL1drd685/lqLYCVdDb6Z21R7hIiSkefs39Y2TT
         fRkVy2bvW6ZYR59pF1BCwLGj7oeCjKslwScg+iSGnkxNOIaskrN6PrlPo075vf9fecSb
         oOILdyweX1M1ChGyxlR5bbAu3+z6H9CHMLH3hycYKwG9G7vbB0s+KKKE2nzdv6Tbjviw
         NW04Ajw2WWA/cDlJBfHWSh+gfJViNeSYPxd5KuUk26NkIENCsSGdT10dkZ7yLSD2CVzX
         RkXA==
X-Gm-Message-State: AOAM532vS9TS9bZdVzZfbJGkig7FAhSxzA2k0klx2pdpMzRnLo7VydbA
        ERv1gxizkU/lyfnjgC27j0k=
X-Google-Smtp-Source: ABdhPJzVDjJFYqlq4l42s18z0HI6/2ECMzjNyGHvBc313YSSOV6lxUCpmCrPdpNrO+7gP/V+F7YI2w==
X-Received: by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id cp17-20020a170902e79100b00151dbbdaeaemr27081116plb.171.1648490260101;
        Mon, 28 Mar 2022 10:57:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l185-20020a6388c2000000b0038614ed80c0sm14455595pgd.41.2022.03.28.10.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 10:57:39 -0700 (PDT)
Message-ID: <dbb15de0-5e13-3706-47a8-d6edb7c221ee@gmail.com>
Date:   Mon, 28 Mar 2022 10:57:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spi: bcm-qspi: fix MSPI only access with
 bcm_qspi_exec_mem_op()
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220328142442.7553-1-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220328142442.7553-1-kdasu.kdev@gmail.com>
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

On 3/28/22 07:24, Kamal Dasu wrote:
> This fixes case where MSPI controller is used to access spi-nor
> flash and BSPI block is not present.
> 
> Fixes: 5f195ee7d830 ("spi: bcm-qspi: Implement the spi_mem interface")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
