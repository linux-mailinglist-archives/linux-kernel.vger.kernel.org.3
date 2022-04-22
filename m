Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622150C393
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiDVWaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiDVW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:29:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739442B361A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:23:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so13534160plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HJWZ/u34Bl8haBfGwNBOqNCCfpYcc1PApGIC4xuaxaU=;
        b=YOyd4OdQjfB6fptqigB6STVzdpSRaV1mYCpWyYapaYW1KVIy7Adw5LyhmQjpMYtUCN
         aXRrbEpvr9ndiz14xYVdbPK3BeUKCUWtFLioihWaQ+sNglE9j+EChbbw8fHBRcTY0gYF
         0Xt/2jB6I+EY4fnUakNX7WONh2MWoCetLyKKU3JC6lus+YwubbJvHj2BUQdLxnkuEHCH
         gfdv9xYuiKJ+x/nEeRZuYITRD3XJGX1huLRAj5Kah7vIJmwJIdShgmmyo7IN8D9Yrsn1
         eRLD9JSPEi7TYK+6R7J1zSxCLs/1SiUc19V/KaZCA5Yr8i9qMWECG091E+bNUcrGOQ5W
         WGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HJWZ/u34Bl8haBfGwNBOqNCCfpYcc1PApGIC4xuaxaU=;
        b=doURaSINx9D5wqqYjnr5b+kEDTtPBU1Mhd1r5144FgcDRPfGsnNKWNlDsNk1JH2/YM
         1qlXOqgGegrdyZhArRm/AxUiDo5B4xxdaNv29zr/qGMknOr/O/hzb15b99jPYvvyje/8
         qoM2yQqCsRau6vUmg/rmL6zwc6KVjPtIrxkKZ22Qeev//0C5jZE8xBhXECIk62H5IvuO
         oq2Mjs2DpZtj35Q4NhofbHn+/nD51lkry5OPVQRPWDk2KLQ+J/yzrC6pzcpxogwRa9U5
         ZJuLeFli8yNl5OAWTu05yvE0gx0af71Ac9uecarZFMeHs6d9zp/BkmzYSzY0Z29AbFpJ
         KeQA==
X-Gm-Message-State: AOAM533F/nmDXfXqmfStdmnZQmYQUMhxV4Sz/U8pXg5I3vPbKCoPTsGd
        YsBfiDt5i3bjbFPV+LDltyvKVxzfwI0=
X-Google-Smtp-Source: ABdhPJySICDr8pzXITtZ0oNS16yOQDuWm614TyTRvJ8gGR6tCvbZta4K8GZ0OZRxFfb2kAOaMQK6sQ==
X-Received: by 2002:a17:90a:ec09:b0:1d5:dd77:d050 with SMTP id l9-20020a17090aec0900b001d5dd77d050mr7331944pjy.53.1650662601805;
        Fri, 22 Apr 2022 14:23:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h18-20020a056a001a5200b0050a43bb7ae6sm3564975pfv.161.2022.04.22.14.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 14:23:21 -0700 (PDT)
Message-ID: <16e9c7ab-5822-a874-51dd-e4a8e2cb2724@gmail.com>
Date:   Fri, 22 Apr 2022 14:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] MAINTAINERS: update MAINTAINERS file
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220413192645.7067-1-william.zhang@broadcom.com>
 <20220413192645.7067-5-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220413192645.7067-5-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 12:26, William Zhang wrote:
> Add maintainers, SCM tree, files and directories for the new BCMBCA
> arch. Only add 47622 for this change and will update in the future
> when more SoCs are supported.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to 
https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
-- 
Florian
