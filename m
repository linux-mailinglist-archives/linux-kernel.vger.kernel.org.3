Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3306557262A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiGLTny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiGLTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:43:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA54A58E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:25:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so8275750pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3D3fqv6wzByH5bXKUxIQGWHd5eDpEOWIwsmvKKRbcJs=;
        b=Ba5+/VD0fuJZ0NtkYS4bezUC6qjy03S4qjemwuD+OXIFCqMMYgAPiMbZpSHb1vclyD
         dv9bnsccfVO+X/m1BQ496Da2I/3aU5eYxSP0VTclsOwWtGUx95X20OHz4IUUJIx0Gsub
         Udcs46Cm6XwKcHU1bRYiWOFgSBinUG6E6oVjf/POziVCOQDv7u1qkGzTpR8OSsGcBCCV
         QMJN8cN2gbaSYv/QSxKi76UPIxyn4aAOIM7ORTvv8Z7ZTwn3M3AeZ9UMyaqidGyNRGFa
         10yNWDUUqT5slKhS0M0H+SKuA18yDes3zazHQHMsn8Zh6kgyaC60rGjevyTQQn0QUaxH
         6vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3D3fqv6wzByH5bXKUxIQGWHd5eDpEOWIwsmvKKRbcJs=;
        b=4Ns3b/wrUX8hZjXkpNeU+ojou4/jqi7ErEFSDTC8wkpMzBSc3+AWtsD5ajz7/kUTCp
         m1X6e+FhNhTN3C958NxfuondBK+Y1dA+yHZIKIn56FqJHMdFPAnwMA3SukXelZCaVkPs
         QROwffwiY1oqZJHOpNkI+i+wcpZlSlrPa3bfIx9RnlCm5ITKuUX4ZjpXEPidRvX5Hnk0
         hwpGHyItH3av0uZj4xTkc2j/x2l2Dc5YgmZfAgVhNr0kVktss4eN8YKWcHo8uRxFvntI
         XQLpJHpYlK4j1q3uSBDAADiRr9WcrRY8H1CclD1H0c0mYti847NKTsDfx2f1QJ4T7OeB
         Buaw==
X-Gm-Message-State: AJIora9ZNCg+07JBn5IXt5IEqDV/lyaUMLIEdfa2tZz3/V58tmI/LI7B
        UXG93RzxUdbkgb929gAjjnw=
X-Google-Smtp-Source: AGRyM1vAcqLqf1vx0dwlhn7m636uKYyArqmp2dKiuzfwg0o/gRMmq/XG1JYaGgGnm5J/1+mp4oJHzA==
X-Received: by 2002:a63:fe42:0:b0:417:b4b6:e4d9 with SMTP id x2-20020a63fe42000000b00417b4b6e4d9mr5678383pgj.611.1657653913010;
        Tue, 12 Jul 2022 12:25:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t17-20020a63eb11000000b0040dffa7e3d7sm6385191pgh.16.2022.07.12.12.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 12:25:12 -0700 (PDT)
Message-ID: <c02b7c76-5c8e-c3de-51a5-ffd809d22b40@gmail.com>
Date:   Tue, 12 Jul 2022 12:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: brcmnand: update STB BRCMNAND driver entry
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, joel.peshkin@broadcom.com,
        kursad.oney@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
References: <20220712191945.4691-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220712191945.4691-1-william.zhang@broadcom.com>
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

On 7/12/22 12:19, William Zhang wrote:
> As the BCMBCA chip uses the same nand controller as STB chip and I
> have been working on this driver internally in Broadcom, I'd like
> to join the maintainer group of this driver and expect to contribute
> changes to support BCMBCA chips, general driver changes and review
> incoming patches as well.
> 
> Update the entry name to genenric Broadcom NAND driver name as well.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
