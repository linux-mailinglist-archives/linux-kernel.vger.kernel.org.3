Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F964C5E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiB0Swn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiB0Swk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:52:40 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0157B36;
        Sun, 27 Feb 2022 10:52:03 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so15602982ooi.0;
        Sun, 27 Feb 2022 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g389SAYe0hAJZkmC0RLt66EI40xFc/FeNBhIEw+0+VU=;
        b=QAl7avJ8lmrokQB1U1PI08LlkfQ6AvD534j6IfrB5foQjV/CJqQETQS22eD38kKmfO
         5z05c8t7yk4mRudBRev0sBEBrnE3ojbCmjirB1Gr8rL3zgej7dl7oX8mCWL0weMOR2sf
         iA1zyfcdRjmqp987QlzgTPgXfYKnAwTX+oYxrH0Ci3DRP4A0K1GahMFsV9RSmEJ5y/kk
         oNAbTpOEdWr0Oreprwc3lTbBYFbzpYNFzvHhO/Qu1zbREEgtS7Ft2CSGlQ05bX0PLIro
         qaPP2R8grt9ndJQoH3Fhp8ErkU0xV7MhvqbTENCjuHelVZ4fUtoFw9c0v9oN8tDPh4cA
         V78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g389SAYe0hAJZkmC0RLt66EI40xFc/FeNBhIEw+0+VU=;
        b=FG84q5Afj/fS+hjJwO+QE6Tl9FBm308wPvadQLy0ZKOEZmXAlFVucCjK+mOpKyUBYG
         d/thTLAN8db4WzeUV7XMj4Ix7s+axZx7gpiYwGU81CNM330Id33ugWrN6JCF6VNOITvq
         uqy9I8u43OcQg/GZhx/ZvRSHbJdrUgasysvmFUJZnhHfYrx97HaLx6ZGxgIs7gmcC5C8
         t8hZztpD7s1XlhzUtCpTGb+8O7pq6yKh00ZJljhf/I5hr+XL50IY7VLontxpumILLu/C
         KXGuvC6rmkWqqZ3RvIUL/SxRi4oEWrdRpao2ACufrhlpxifwrH0qmcCcm8argyorIF9n
         FPCg==
X-Gm-Message-State: AOAM533vHUVJ/FQwOI4tr565ydW0QzIC7r66u2qzqDuSw2eWqROL625X
        507VTp/sn5u1Qw54COY7HJGDK4Pc5S8=
X-Google-Smtp-Source: ABdhPJy1HvJuV3xXzuXui7cBmi7vBlWZtfzMRqCto5q2gGLjjYqC0HZzyAa4++hxojj5fg/wB0UiNQ==
X-Received: by 2002:a05:6870:c594:b0:d3:6bff:a925 with SMTP id ba20-20020a056870c59400b000d36bffa925mr6407113oab.1.1645987923260;
        Sun, 27 Feb 2022 10:52:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26-20020a4ae25a000000b0031c268c5436sm3895196oot.16.2022.02.27.10.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 10:52:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ae4f358a-5e44-435a-a569-a5bd1c2128ee@roeck-us.net>
Date:   Sun, 27 Feb 2022 10:52:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] hwmon: add driver for Aquacomputer Farbwerk 360
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220227105926.64862-1-savicaleksa83@gmail.com>
 <a54a19e1-703c-5cdf-0a13-ff3f4cbd81a2@roeck-us.net> <Yhu+ywPYqkzMQUZv@fedora>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yhu+ywPYqkzMQUZv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/22 10:11, Aleksa Savic wrote:
> Thanks. I'll send a v3.
> 


Oh, and please update the subject to something like
"hwmon: (aquacomputer_d5next) Add support for Aquacomputer Farbwerk 360"

Thanks,
Guenter


