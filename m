Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33B58AE91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiHERAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHERAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:00:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB018388;
        Fri,  5 Aug 2022 10:00:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f65so3117687pgc.12;
        Fri, 05 Aug 2022 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wnGsrP+ytUGKRn+HBST+F0+IWQ9TRTq4LtQZdPYwsCY=;
        b=WAEBdaakuwSXkSP0CWeTv2+pKoMW9HzIINE+71jbp3s8nhOQFtwx8TP+lZdNnQ00l6
         de4ayiSeib4B+dPF1N0/0HkuVUW6aNnN3x9HRBlJ2iWAWO1lWTELbUau9821t9DZOSRz
         uV4jgogBehGhvQtwJvOV9tPUttZ6TU1rG0029pjMFx5Et1ixrJSRmdHleHEYYaZ1bnpF
         KAfQ47k4Sn+5WMkoBEHZfTNEYncdDsqMWcgPqz9by/npgyT9L+G51SQT4KZ7Q1Tl8aV4
         EhgV620SAqSiVGIM6iv8HjPBVvVnhcFSnhIiZ7HoeGfWQJr8445S2j7eKDXfzdJuY67G
         Y6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wnGsrP+ytUGKRn+HBST+F0+IWQ9TRTq4LtQZdPYwsCY=;
        b=dig12vwEeO60ALiekNk/7CcVqsQRKXpgOK9I9vQd9+ecj7rkhTZeHx96rabh8kEF+t
         45WClDiM4cSNi0VBgE7c6TarIQha7KAx6WWLoMA4wS56hFXppLRdcfy4WX3gIz9jpD0T
         0Q72Dfq6PR60//QPGnvlL7/eMreuoPM8+1KxE7KQ6qJhMft+fROaSt5IfgmdeLRN/wfc
         63xCVb/I9v6fA8OlTzsarqvhwGgxxp+6yRchoZPowAmzMflnyWF+4AXr3PqCoeub5GmK
         2afchj9ArKSFUxABY7S3BBG04xBUK52VPRJf9L6ZLA3iVxY13poX8nCvtjUPQJ9nKpB/
         0Teg==
X-Gm-Message-State: ACgBeo2pWJQnjpMZYMPyWc65mtPUUlQHwQeuLovtsyQNksP27pBULToo
        d5hF498GXAogVASMXqptir9d8aEjq2Q=
X-Google-Smtp-Source: AA6agR6S8GJwW4iE0pmGwjw9AHwKF456NuOp5htqnFK7hNqO8bmRDAiOntWpq6W2tPatbtJ/yURkeA==
X-Received: by 2002:a65:6a46:0:b0:41b:65fa:b09e with SMTP id o6-20020a656a46000000b0041b65fab09emr6613109pgu.292.1659718828848;
        Fri, 05 Aug 2022 10:00:28 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79f12000000b0052ddaffbcc1sm3358611pfr.30.2022.08.05.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:00:28 -0700 (PDT)
Message-ID: <9bc1f1f4-3923-be9e-ee13-9c8252a56643@gmail.com>
Date:   Sat, 6 Aug 2022 01:00:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Please consider Linux 5.20 because it means "I love Linux" in Chinese
 (Re: Linux 5.19)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Cc:     loongarch@lists.linux.dev, linux-next@vger.kernel.org
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/8/1 05:43, Linus Torvalds wrote:
> (*) I'll likely call it 6.0 since I'm starting to worry about getting
> confused by big numbers again.

Could you please consider use 5.20 as next version number instead of 
6.0? "5.20" is a wordplay number in Chinese, which means "I love you". 
Thus "Linux 5.20" can be read as "I love Linux" in Chinese. So I think 
it's good thing to release something like "Linux 5.20 I love linux 
edition", just like "Linux For Workgroups 3.11" in the past.

Best Regards,
Zhang Boyang
