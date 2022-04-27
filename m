Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3151212C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiD0SDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbiD0SDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:03:41 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEB3679E4;
        Wed, 27 Apr 2022 11:00:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e656032735so2827545fac.0;
        Wed, 27 Apr 2022 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w+iH1xab4wTL+42uXpchPfWze+My6KgDF5dcA/kKoW4=;
        b=P6i52awwu76MSa1SUzsMtEu+jOFheEsZppUqyqwJzhZ9qag1W1vTu9vNbRy6XgLVq/
         ptVzDHxMd+jtZSe7vbNm1d1RTao+gTw+/k8zzp2BncEXQViGdQtAYpM7LxfKcA4nweFm
         hNpKPhkb8QdizzC8+RKY5sc05ctB4M/kJhQgfTTOBmiAsNeIr5bVHGrBDFLZvv+axbqs
         j0ovpekQFG2tN0p88JnuO3wBnn35KqHODrxXR/IYk0GO1gjUJNzsVa2BFHv7bqoLH5L5
         g6hHd03c+7ev89Nv+eHn9iXMbUR9AnfO4jhz/NEWKBaVx3Xtxw4C9StQBdboA/GRO3hs
         hilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w+iH1xab4wTL+42uXpchPfWze+My6KgDF5dcA/kKoW4=;
        b=X0A57EiwII7XZYc7x0H6v6xYTVFSzZr/UouLOChQYKC+t8l45lVPzIxAXX1POgZKF6
         zGGSjt40xYISMdmdzqfiE7C1tAml+Z5bsHp3WPc38lGmYyjnzkK+KG1gOai5LT2s/R+/
         UZ6UMupBpwfKpgp4b2cTN9lGbwkc3ehPHEBEfuRLBXp7GAcuEfEI/Weq69a0l2K5XPa7
         HZee2Yt6ZRxUtpLJdNi7HNstAStvccRX7Em6pdxSa+FvEoKOR9/Dv7AJRINvNyItb8j0
         fF7Qz9sBNnffG3VSo96iEXIrOdUn/KB2pH6ok1oGFniDUbp6s3h5bpf4Bl5oLFOukY/s
         WcuA==
X-Gm-Message-State: AOAM530jKCn47BIGwEL9kmw1BxlA2+k1D7kpJVwJ6u+FXQb5dlu8qPI0
        kSRjFJ+z2c/d02Zop0LaSjo=
X-Google-Smtp-Source: ABdhPJyDYgUbJ7/72ydkTciRC3dkHMdZCOH4XDfOWT1PBxw0rCWpea5noaU3gUqViFEE3fUh3k6q7w==
X-Received: by 2002:a05:6870:8901:b0:e1:de1d:e462 with SMTP id i1-20020a056870890100b000e1de1de462mr12514816oao.294.1651082429059;
        Wed, 27 Apr 2022 11:00:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7-20020a056808148700b003252f1da45bsm3762147oiw.38.2022.04.27.11.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 11:00:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a70a2c6d-4e09-0433-75be-172e261c957f@roeck-us.net>
Date:   Wed, 27 Apr 2022 11:00:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
 <20220427143001.1443605-5-eugene.shalygin@gmail.com>
 <CAB95QAQ0jwgQyV+PCVy1swN8hXC9U2oRbtbPqU13oW8_1v9zaw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QAQ0jwgQyV+PCVy1swN8hXC9U2oRbtbPqU13oW8_1v9zaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 09:57, Eugene Shalygin wrote:
> Günter,
> 
> I forgot to add PRIME X470-PRO to the list of supported boards in
> Documentation/hwmon/asus_ec_sensors.rst. Could you, please, add that?
> It should be the first entry. Commit
> 8f8db4b5d10cc4a2a801514e677dd5205651b771. Or should I resend this
> patch?
> 

In this context: Your e-mails always include the following header:

To:     unlisted-recipients:; (no To-header on input)

If I forget to remove it in a reply, this causes a rejection of
the reply by the mailing list and may trigger anti-spam filters.
Please fix your e-mail system/configuration to avoid that.

Thanks,
Guenter
