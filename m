Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD65707DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiGKQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGKQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:04:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAB52E4C;
        Mon, 11 Jul 2022 09:04:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so8796516pjr.4;
        Mon, 11 Jul 2022 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jhU46F57Kpsm3lvGS+RUeO4HB1RQGRqBuSXGIQOZlWw=;
        b=I29ieqbgkvvj7s6AihIwRftCxrPtgxLLxr2oSajD7qJ5iQzsmjO2Zg8PmHCYSirQjb
         u8XHFdCHN3knKWFIqqLjNTwmyvX+s9Ik+UnpjpsRHdtOUpIwcVKvSRudmHEYjKfKyIq5
         vAKu/mbJfO+PLvJ9NOOTr2C+8bqZQGwq5+Xmbn+/YjGAQ1rVsI+DPW0s00mmD6SkIDpw
         eX+hgy0LDPYIBlMCtuuY5rQK/rS21jf94qDIfwRZViI2iuqnG0PD+UM21/f1opsVAyIz
         QNO+ROsQY25yZMpqx3RHw62McW7BUPQIFeF5IcLHzpGWVt0DU+1AYPvlGd4bKVKotvhU
         NIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jhU46F57Kpsm3lvGS+RUeO4HB1RQGRqBuSXGIQOZlWw=;
        b=vwHprHGH4/KKdW7N0srerOddoMSVOdMhhIniZWAhbdh9HJ1uKnDTy/cUZfpd2hyZ2G
         iC3wS9ObCP5UcV7uhUZhE0ePOLu83VCgvo2thP+1odc1Dv+NnKc/KQFHtodgybuFQ4pK
         fv7pzHMmHhs+2JOKh9N+f+gwV/TQywOrgJSL7m2dnsZIVj72DyPxAX8SrQABYY3goh7O
         gLXMd/MyMOV2lY6MRBZ0ysm/LpRWu7TbQxa8XQRf4T/mNTqu31bb5MCnKY+ufF07B80R
         soSjuruZ6abldslKMdF+Bh/dKnanygFgSCgFBdAIPGvTzy8+0hQ7TxjUSfog0JEQOWbY
         58Cg==
X-Gm-Message-State: AJIora/9WwA3L7wg17PhzHQMoPSjOyQUzq4xiEC/uI74IOUOKDJp91iA
        FohnIDeazDA9uPW8Zx8U6Jo=
X-Google-Smtp-Source: AGRyM1tE7K3zk6X7mcRkGHtHEjNhMYP1cMqA0DJkX5jLpm9sWbZe/mJY5DFIQUEvjaTSXC+k1cx1mg==
X-Received: by 2002:a17:90b:240b:b0:1ef:8a68:1596 with SMTP id nr11-20020a17090b240b00b001ef8a681596mr18438234pjb.234.1657555482490;
        Mon, 11 Jul 2022 09:04:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id js1-20020a17090b148100b001ef7e5f2a82sm5012057pjb.25.2022.07.11.09.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:04:41 -0700 (PDT)
Message-ID: <ce3f1df4-6919-e666-a8d0-a856e5d7bc3b@gmail.com>
Date:   Mon, 11 Jul 2022 09:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 7/8] spi: bcm63xx-hsspi: bcmbca: Replace
 ARCH_BCM_63XX with ARCH_BCMBCA
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-7-william.zhang@broadcom.com>
 <20220711021131.3289881-1-f.fainelli@gmail.com>
 <Ysv/PNJzSEwRnQVI@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Ysv/PNJzSEwRnQVI@sirena.org.uk>
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

On 7/11/22 03:45, Mark Brown wrote:
> On Sun, Jul 10, 2022 at 07:11:31PM -0700, Florian Fainelli wrote:
>> On Wed,  6 Jul 2022 23:57:58 -0700, William Zhang <william.zhang@broadcom.com> wrote:
>>> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
>>> SPI_BCM63XX_HSSPI depending on ARCH_BCMBCA.
> 
>> Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
> 
> I was rather hoping for an answer on what the situation with
> dependencies was here...

Each patch is independent from one another and there are not 
dependencies on the Broadcom arm-soc tree(s) other than for 
CONFIG_ARCH_BCMBCA which was introduced with v5.19 with 
b32c613b3fda3e1c26119609f1ad6b19178f82f5. That said, I prefer to take 
all patches via the Broadcom arm-soc tree(s) to ensure a timely 
inclusion for our upcoming v5.20 pull request, and ensure that all 
drivers are converted in one release cycle.

If you want to give me your Acked-by or that I drop this and take it via 
the spi tree, please let me know.

Thanks!
-- 
Florian
