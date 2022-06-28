Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB755CE01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiF1AcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiF1AcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:32:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343310FF3;
        Mon, 27 Jun 2022 17:32:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so14141527pjl.5;
        Mon, 27 Jun 2022 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OFFvy82t3qS2mWvKMEQ2PiSLGvpukFE2JbAHWF/b/0o=;
        b=NSCcXg1ekuYiFLFIOJztsGrrf6k+Y/n8ieyeC9AuJKRrjhP+8mtp6WwejPs6ymRPCr
         3+qJflUm1uVqFWeK/w0HEf5BqijTsqUmFg2VZxI9rM7nQNtF0sLdUCFnkyWsgQ6KUdZb
         3v2/pkEqEbMMVwSSxAou0C8ixVtoQVE4C2gPxOlIBB0uFBopc3EJEWr7FrAsI607E/r5
         Uz258GrQ4ESmM+gBquhd/ZPfXvC9SRQ8EMF2KLx4JiVVW7ZwmMHy7098bTEBnI2ZqI2P
         J9d58NUejrTgglboOKwIQeUjZ54xY3xQX8pcvkNA2isKfxoSVhCxmtmtSerA+UHsitTo
         321w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFFvy82t3qS2mWvKMEQ2PiSLGvpukFE2JbAHWF/b/0o=;
        b=IwRCVZctYsxo1MGnYbuNOb+gO5/3RTHgEJ6ppnqgtO+WV8m5yQPaQWzDCgrRqs8WKQ
         l8MXHXeSMvMX/H2XnISWkKW0XU8eZqDj4l4EnO08QPywMHazE2QJZ9e4C6HxmSNSICef
         MbdGy80obg3Xb52fYbDiKmHfH7zltXFwGFgwz1QoeFYpYcCD8AI0bbTJ4kQ7o/3HvVCY
         SOeF2gLA84QpBzrrrwQYOcLoMjkAs3PETxsW5xTODzT3qxcL3OKxE2tzlddTUzvW0dJv
         tQFLMu4g3HEOCdJSh2ihbxjLkE4vVsEqr5gG53L9r7PZPyn8jiNDYloGvblfpms8XI7U
         d2jg==
X-Gm-Message-State: AJIora+pSNHpdQJ2wJWkQFKAKWrflL9euXBHk95D5IoHiabo4t7l0OGh
        6Acu6Zuo8aaGyDC5CdsueXU=
X-Google-Smtp-Source: AGRyM1tWsgyFKFnn4ji+g5YZhEaM1wplTOBNsi5KT3WKRaD4wmjJG2KzTXbtuZlDoMCjfrKa2kFccw==
X-Received: by 2002:a17:903:41d2:b0:16a:2cca:4869 with SMTP id u18-20020a17090341d200b0016a2cca4869mr2157470ple.13.1656376323885;
        Mon, 27 Jun 2022 17:32:03 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id x9-20020a634849000000b0040d75537824sm7726863pgk.86.2022.06.27.17.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 17:32:03 -0700 (PDT)
Message-ID: <e2eee869-3e72-ea18-6afc-73fe5bc5dbd3@gmail.com>
Date:   Tue, 28 Jun 2022 07:31:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in leds
Content-Language: en-US
To:     Praghadeesh T K S <praghadeeshthevendria@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, praghadeeshtks@zohomail.in
References: <20220627214311.7817-1-praghadeeshthevendria@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220627214311.7817-1-praghadeeshthevendria@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/28/22 04:43, Praghadeesh T K S wrote:
> Fix following 'make htmldocs' warnings:
> ./Documentation/leds/leds-qcom-lpg.rst: WARNING:
> document isn't included in any toctree
> 
> Signed-off-by: Praghadeesh T K S <praghadeeshthevendria@gmail.com>
> ---
>  Documentation/leds/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> index e5d63b9..b9ca081 100644
> --- a/Documentation/leds/index.rst
> +++ b/Documentation/leds/index.rst
> @@ -26,3 +26,4 @@ LEDs
>     leds-lp55xx
>     leds-mlxcpld
>     leds-sc27xx
> +   leds-qcom-lpg

Hi,

I had already sent the fix at [1] (resend at [2]). Thanks anyway.

[1]: https://lore.kernel.org/linux-doc/20220604015735.249707-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-doc/20220612000125.9777-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
