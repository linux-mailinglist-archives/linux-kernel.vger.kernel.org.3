Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD66C501858
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiDNQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351871AbiDNQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:04:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA9F70E1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:48:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m16-20020a9d73d0000000b005f8edc0599eso1949489otk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gNYhNOwWsPMWWIjh4znKGHbGnF3f5saGDocombsGcQs=;
        b=T5Q6ylrSXWbi1gB06EGn5ez6ONSx5hgEiLU0Q2LdC77NBM33vhSn2r+Xu7sUzpzekb
         NmXg46p21ji37vW0tC+WHmUkWviZFb5ht0eVDKIwI0laQfK9A+eQwdnw3Erhqfbhh1MF
         8lsapwF0uiJXqyRuYo0L6yeVpQ9OjrCyP2Ly2GL2Y0VGQS1X+fbV52c9krywCsj1rSRO
         3yEZmFvFMaKja8SDEufqMXdLdLDlbWJJ1/NsrLBdcz6oxelp5KjaIHuhaU506eZlIV/Q
         j2sPioebeUQiCbzAu5BzRk6j6U+7mD8d4pXXY7gx6V+juGGqKP30Sb4mj4WIq/lfkeSI
         rizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gNYhNOwWsPMWWIjh4znKGHbGnF3f5saGDocombsGcQs=;
        b=QpLwEEl/hyZBqpIhCfQ1xbXFXd/IYyGwjF12u6V1IoIOLf/aNVsYGy5E97KXdAqhm4
         bEH9ta30yp6Ly5ZaBjZed5pbbtzKquVSkFvF0dsbyJLfETVzkZqV4UowxrxBfaPNIsyZ
         iqgyPOp6ZtS7R9tgBd+krLK+bTCJzh6mrQtVOeEU5IaKsg05pX1AHng0rDHZOyFeibA/
         TSATYwujSirE33Bkov8IkqQTNiZiDjA4UvTyBscoDP9oK2667bQY2UIW3BB63VC+3vqX
         /EW/6TCtTx/MT59rmSZ5NFyLq7UBF+3DyCywT83J7LrAIKl+RABvNU0VWFACjy0bzMIX
         f/tQ==
X-Gm-Message-State: AOAM531EEk0G3WPAGOnSZkDjWwpuYMYqBUUpYlaSbpKo5wInoeAV0vDR
        L9KAxawOuwpS7drNyUQvv8M=
X-Google-Smtp-Source: ABdhPJyHlQ/FlSjp07ypkqiIpCKV/bHSNJPQvAMtEaa5juBrYZtbnPpgBQ8fzekpzBJOid9Tl6FxhQ==
X-Received: by 2002:a9d:7f19:0:b0:601:3f9c:4d1f with SMTP id j25-20020a9d7f19000000b006013f9c4d1fmr896557otq.178.1649951314269;
        Thu, 14 Apr 2022 08:48:34 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id cy36-20020a056870b6a400b000e2c5d0c2bdsm795897oab.7.2022.04.14.08.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:48:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4ecf7d12-0ad9-5055-75c3-adf6e97c67cf@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:48:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/8] staging: r8188eu: fix and clean up some firmware
 code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414104323.6152-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 05:43, Michael Straube wrote:
> This series fixes wrong size of struct rt_firmware_hdr in the first
> patch and does some cleanups in rtl8188e_firmware_download() in the
> other patches.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> v2:
> Added a patch to check size of struct rt_firmware_hdr at compile time.

Please wait a while before submitting new versions until those of us in time 
zones further west get a chance. My objections to the logging change still apply.

NACK

Larry

