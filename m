Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1AE4D2F32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiCIMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCIMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:41:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970361768F1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:40:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr20so4665583ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=4viH4UeuEG9C8oJaPt+fge86MkXEHZypQjP8U/5N0lo=;
        b=egElFP2MIu29GTJ6QTaE6Ijq5SKRKgUQaLHfnVbn2UpmpO7dK6LFmaQLx72mvOOttK
         iX+t4ZCjNEpd1aGPY9W90zKvP+O0xlT3zzN/+GVassM+JgxoobFnfIRzwUIIiFdqz4w6
         2qyXFP17YP499ckFsUQ3fPMJLBOuomQrP24NXa7qw1lVbB3QV3LZ/tVXkA9mJ8WBuDZw
         mJpP+UaoRxEgZBoVGYABo9u042LhLYBvVzpwy3c0TNI8Q1B7IrEqfCYM2CcYmMWkZ6n9
         AuL1Z7ujg+Zeo2kq4K48Wg/GZy7zQN0Tw5G3nLUSdY1ZLFgnOgKkFRRSRJF3h5iOmOYK
         GZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=4viH4UeuEG9C8oJaPt+fge86MkXEHZypQjP8U/5N0lo=;
        b=5h/jgXQBiAsYBWhx9s8vROLIfR6yGM2B+ivjlAI0cOfVLeyRfoi0WSAVVEvw3JL77P
         iFBZJH5Dv0ne/PiS1mGrGC8P/LnaGqWJXPsSIYdUZzLQJ6pFMz0RGEr5rOIPP6QpSBWL
         eqgTiXXpEZFOdKcMguC/wfmUcrUI/x/KSx8LISr7yhbk+93IenKz8xXSXeYmLjaZlOr7
         3+eYjmdCYgLzVmhhU1vKKGqWXL55da8B8GB7bi/mliQ9F6N4I56+eOg/7GMkbQ+ctgWE
         KYjwxrHbNzBeZ1jamKOSrPoYoRnsmh/2u3X3T/hIvspX8HaVUpYslk8LJH6Io/4Dbz29
         3RNA==
X-Gm-Message-State: AOAM530iHZyvezlC3ph3e1ZY6SaBZAGP+M25Ub8V9CnbVzjzeor7/eHQ
        wQSsMDMSdaoX8d2fXLvqG5s=
X-Google-Smtp-Source: ABdhPJw90fsBED+a4LydG8qPyRvElSIweo299ISkYDvbvR4gHLYtshtVun2fyc1hGMrLUEQU2zkRgg==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr18180007ejc.501.1646829655019;
        Wed, 09 Mar 2022 04:40:55 -0800 (PST)
Received: from [192.168.1.218] ([31.179.128.178])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm701731ejc.24.2022.03.09.04.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:40:54 -0800 (PST)
Message-ID: <f671c80f-f97d-b3a2-0253-2eec21e2c748@gmail.com>
Date:   Wed, 9 Mar 2022 13:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: VDSO is randomized even when ASLR is disabled
Content-Language: en-US
From:   =?UTF-8?Q?Borys_Pop=c5=82awski?= <poplawski.borys@gmail.com>
To:     luto@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <9b82908f-eed1-b6b7-62aa-ecbba7bf048b@gmail.com>
In-Reply-To: <9b82908f-eed1-b6b7-62aa-ecbba7bf048b@gmail.com>
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

Hello,
I would like to get some feedback on this issue. Would such fix be accepted? Should I send a patch?

Best regards,
Borys
