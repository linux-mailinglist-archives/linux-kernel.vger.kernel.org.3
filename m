Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7853B5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiFBJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiFBJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:14:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B611142;
        Thu,  2 Jun 2022 02:14:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so5610518wrg.12;
        Thu, 02 Jun 2022 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h3ozMSGSLY91vCCX6RM4Vt94QoTLjZG2P99FABikIrk=;
        b=C47POMZmsXkHplUN2H7AibchCLaHIWu9iiiDg3w3qDI2dOULePvWtYP1rRWKntKxXz
         2DLnk8JME9asYJy0NTiqNUOcRG+a9ei+eKWYkuYww/XL+6VHeqYMXeBnwTKrv/2r7bsJ
         BSudDiNuWD/OGzS3uajDojr7zYSpuhLSXQ5Kc/xd03npxt1pgTKufncBApPBVgRzTaCu
         SuONSmFIJO3lCYPJ7W0ZuX0j3mTh1uvFJDStlXrdDgKNDZF48QCYv2dzba0mbv9ojXPy
         5yi7Cx1cCOqwFGwRsV5kk9V7aDnHZZOmP6NuN41ei81pkvo3c5UqlnZse+Wf5AoNXbdq
         lejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h3ozMSGSLY91vCCX6RM4Vt94QoTLjZG2P99FABikIrk=;
        b=siKD9BbkxKVCwWbCX7sDdPGVIJBspCUo7jcD68YWpV/+fn+0JWg839j6KHOlNre+EO
         Q2/NysZISjsebSwC5nBCic8H0zTtWjLq2E09bUwQLkuUPPgHWzda0SDt7dsBFsxovb/J
         UpVq41TW77e64tS9r9ZxRkEnDOij/xVclrMi+w+Grj6Ozj4CYBItyCk6aRzL8VBbkz6u
         hs1ITPu246eSzmUVCbO+AAGdhPhv+IzlFNTJPqGYvNv9dQd0bq2JX5i9AwYzJTW16yTH
         stYa9ocjVax9yoS4OLBv8gWmfZaJqO6PEUGh+m+VCGcxfaCVLwoJMtdwYaLoTlbfNumj
         CCQQ==
X-Gm-Message-State: AOAM530dxmrUzdiDX8nytIrKi4UtosyZ1gFCYpHvpIu4he6NJcPF25IY
        T/gV9eOa1vRZUgpQ7UmOrH8=
X-Google-Smtp-Source: ABdhPJzrgOmQitbgRmTN/vBFpj/cUUA+f94E7v0Fp3rtXxLS43Ip3AcHj/ZVK67hCqqE/7RnutJ04A==
X-Received: by 2002:a05:6000:186b:b0:20f:e2e5:f95f with SMTP id d11-20020a056000186b00b0020fe2e5f95fmr2917797wri.76.1654161245143;
        Thu, 02 Jun 2022 02:14:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d6e01000000b0020d03c14b9csm3724160wrz.1.2022.06.02.02.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:14:04 -0700 (PDT)
Message-ID: <c14d04f1-ee10-f111-9a37-fc32b157bf77@gmail.com>
Date:   Thu, 2 Jun 2022 11:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] tty: serial: atmel: stop using legacy pm ops
Content-Language: fr-FR
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        patrice.chotard@foss.st.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
 <20220525133733.1051714-2-claudiu.beznea@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220525133733.1051714-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Le 25/05/2022 à 15:37, Claudiu Beznea a écrit :
> Stop using legacy PM ops and switch using dev_pm_ops. Along with
> it #ifdef CONFIG_PM are removed and __maybe_unused and pm_ptr() used
> instead. Coding style recommends (at chapter Conditional Compilation)
> to avoid using preprocessor conditional and use __maybe_unused
> instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>



Thanks !
