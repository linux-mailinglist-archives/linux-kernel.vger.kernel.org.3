Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95F50E30F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiDYO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiDYO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:29:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035319284
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:26:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g21so15979200iom.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y5wBcOfazqbglU7XX1dJt4fZzKnlLY04C3llpIX2pRs=;
        b=FkNXvsGXHZhlPP2iAD7uLQFqxU2NG+MkhcJD7H7ESYyMwmnBCFTYQ+NfMNZsK7Sypn
         GRnki9xT4QEzQtmYi9m7Mxx7dGOMztlxGcPJqL4HKgLpxk+v1ZCeb9qlxQ1BRsXD7A/0
         0Wm404//Vh0R5hDYCFXpynyppgGIroBFEBMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5wBcOfazqbglU7XX1dJt4fZzKnlLY04C3llpIX2pRs=;
        b=Tc6dFi+eDIfRqi+kZnJ6pyuCxlfsLRbOWDIGseZpq00ZHWqu9lB4yllVc0WpEoQue8
         Mj0ryuyI1LUhOhRIgQwzpnbjJxrp/tjWQ1qhDzqO2elveo7BEqhg/k4y+RGDCnU44/JE
         jysNhsGKjCdx8M5OalWzghJn2TA/+6Harda5POoBKG3dlfOck1n2D7tpmjv/PFvMCuhs
         gHn3hnYo/wUBVxSR1PfFcMkODqppVHT+FB7tBeEf208y/SnJ3g+THUmovimPHcaTRYYi
         j0NNNf6mHrzaheFScvsbZqDEVWIsDpz0yJx1Nb65bbeuZfVECBtjYzIqL8LTaANJocGV
         u5YA==
X-Gm-Message-State: AOAM533/a8hYt23Vu8lZwRWKKmYzvhkCS/ExXYI+foFWWL7tstz8gQHx
        gf87/YHTg+6U3m2ix2d16R/DmTjyTrri9w==
X-Google-Smtp-Source: ABdhPJz1GlbD4jJcDwHaCDL32bx5zqfKkG5eIjqaeobQ72MW4LyenSfQL69TR5/qzzopE6aHcr5jnA==
X-Received: by 2002:a05:6638:204e:b0:323:e3b1:1c2c with SMTP id t14-20020a056638204e00b00323e3b11c2cmr7777096jaj.222.1650896767753;
        Mon, 25 Apr 2022 07:26:07 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d8b4f000000b00648f75d0289sm7516486iot.6.2022.04.25.07.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:26:07 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: mv_udc_core: clean up comments
To:     Tom Rix <trix@redhat.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, jakobkoschel@gmail.com,
        christophe.jaillet@wanadoo.fr, peter.chen@kernel.or,
        johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220425131749.1185511-1-trix@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed5a845c-d338-d6b3-dcbf-3ae31fe50991@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 08:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220425131749.1185511-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 7:17 AM, Tom Rix wrote:
> Spelling replacements
> occure occur
> reqest to request
> acces to access
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

I get that this is a trivial spelling patch - however a proper
commit log is still imortant. Please write a proper one and
include some information on how your found these.

thanks,
-- Shuah
