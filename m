Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262BE517110
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiEBOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiEBOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:01:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61911C38;
        Mon,  2 May 2022 06:57:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y63so15270344oia.7;
        Mon, 02 May 2022 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=bX/h5IsZDrnxmlUVa9F2X9NUwrp0LlnAzchdCe0mKX0=;
        b=SOsC0KS/w47RPhQBd2bRxJ2bMnKiigwAu7L6xLSIxViPFcmz3ses0vdhxom2coTIY7
         lNjtU5HYybmu0AR+m4kqYeixrGgC5CaN4exky6juY35po3lSWfxhfJXfErvwxIRYSIVU
         Q6RQ9CETbMD4WBd2Joy1I8Ue9TF4j+lakqg4eNH858OvIaXOCOIt46qQfgbQxpv103FG
         6n64vJ1f4dvjaMLNyY3ygcKsnxKu3i6PrzUydWkx2uAaH+svHmPkxSJAmQKk9KCQ+FQd
         p2tpdw5uLMbZe16UYQ/NVfbuaYWAS0X490MQGKz/JKNgfNmW2ZmktMe2p1cxYZ6OVCrS
         nzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=bX/h5IsZDrnxmlUVa9F2X9NUwrp0LlnAzchdCe0mKX0=;
        b=pq/4dC1BKyuFXuz1b60zvSVbBEIFeoxOppwT4ipNvPeUsQRBg3EJIjLm1To0a/T4os
         u/6NMk5BM02JWat/s+U6Dqru/MEh8C4siEPMSxLR2IDxeRXaGXZ0eRPH/Y8FQbqJLJnq
         hlrwFi+wHXWgQyHN8ke3nZaPEs2n6AFULMHRvGj4aftY6mVejBZN6fhcd0RRqNLk8cLj
         u+1eQcGJM+Rebv4CiKdiDuBhk8Tqscza+GhbJgegOavNHRASh6iSty7WHq9lfr96eInb
         km49mRt1AruEsk3DJigfORNobuFrNFfe+yQpLOZiOXlqSH5bRBgg3fwO+Hlp1clCsfaB
         D7kg==
X-Gm-Message-State: AOAM531A7IiGhZAC9VSbdec2NYNeApEoZ70TmF2yszOzIQVJn8M8K0rB
        cy2EBHW/C15buBlFLA7YamI=
X-Google-Smtp-Source: ABdhPJyoESxKSMbw5pBg3WkkOCV3lC5SH0+7QRC8sCi8/zegO5Og9ZnFAcmu8xbOM75WrWXhBrE4Ag==
X-Received: by 2002:a05:6808:e8c:b0:322:4b82:d33d with SMTP id k12-20020a0568080e8c00b003224b82d33dmr7250278oil.21.1651499873009;
        Mon, 02 May 2022 06:57:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a056830000200b006060322126dsm2867394otp.61.2022.05.02.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:57:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a2e81680-e62c-dddd-ee58-6f5aa3664d2f@roeck-us.net>
Date:   Mon, 2 May 2022 06:57:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Camel Guo <camel.guo@axis.com>, Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
References: <20220502091942.1083067-1-camel.guo@axis.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (tmp401) Add of_match_table
In-Reply-To: <20220502091942.1083067-1-camel.guo@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 02:19, Camel Guo wrote:
> When tmp401 is built as kernel module, it won't be automatically loaded
> even through there is a device node in the devicetree. e.g:
>      i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> 
>        sensor@4c {
>          compatible = "ti,tmp401";
>          reg = <0x4c>;
>        };
>      };
> In order to make sure it is loaded automatically, this commit adds
> of_match_table for tmp401.
> 

As mentioned before, historically i2c devices would instantiate based
on the i2c match table. You are claiming that this is no longer the case.
The above is no evidence; that would require a log output on an affected
system showing that the sensors are not or no longer longer instantiated.

I am not absolutely opposed to adding the nodes, but the explanation
needs to match reality. If you can not provide evidence from an actual
boot log, I'll have to implement a tmp401 device model in qemu and test
myself. That will take a while.

Guenter
