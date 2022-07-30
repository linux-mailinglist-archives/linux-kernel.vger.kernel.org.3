Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A07585BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiG3Trk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3Tri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:47:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CAB8B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:47:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so9347217edj.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=u8p9xdNn7AphQhSjTR38SZgliksZusGzeLWxWOeSIsI=;
        b=p7a+xQRMZj1sZmp6R2/fug3p+ICh5Q6Yzj5N7E/hCrjJj6hDA0/Vlr9y/GjHCFx71B
         WF/XGYYtQ0Vq5J1cpnEFNAENIjbljP2/X+/E1RoZ/jCw1A4C+hb7ExLtJeqOIsH/8Y5C
         U4UAw4C3rcWoJ5cOELNSzAEog3w/Nu8bs351PIjqw5t9iHS0tg6to4B9TiqrbGzDS1Ks
         fWGXthh6jz1VzFWFBptXX31GZamWzcY+yF8R0Baa9ONbUzK7EciLfn4jXJDJtEd4mR7N
         qy0e/1iqmahn7e7qCwklb+Jej300q1tYzOGDwcW0z+7v2Vx1GTTuZDnxzXTowsF7xdiA
         qa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=u8p9xdNn7AphQhSjTR38SZgliksZusGzeLWxWOeSIsI=;
        b=F23woEkrQJO6SOYDp0UP/++kidammvVrif2eaKdxe8ml/c3MBNzoD2PU+tFE9C55s/
         oKGsU1zEpz6NSdFnt5QWBUNziwlhwu+ZM/2+g3xDVn9JISOVDeS3ysklfLTIg9/4fO/7
         wB5v5etPWfh8TCHAb9n0iLGorPa+DU6RtQTrYoic+VsEzxcMX4QI9LkdTeiGevk9byUA
         7JGtVVcy5cwIkFkjMmD3gDM9qtoJLzCknqSkiakrjRcEwOS0ooA0F1XnmxhPWTQ8IQij
         rsRDnNb8LOIsloiTak6G/FnaTgfDwIUrNfTn94wpWZF30TyzRoqYsgvje+SDDTCj41w6
         FZIA==
X-Gm-Message-State: AJIora8oyonF6aaXVdPfdeSknJy9z82pSNCIf/pBvzf6/w+XCUJ/vRra
        WYspQyAxhitwBauVrnG1hjc=
X-Google-Smtp-Source: AGRyM1up2ueIwyvBrkko8CHKRnUL/UMXztYwr5Le/tXj/HwsNwQeXT+udlbsx0p7JVfYvVEQDvEHaQ==
X-Received: by 2002:a05:6402:287:b0:43c:c604:addb with SMTP id l7-20020a056402028700b0043cc604addbmr8797967edv.201.1659210456477;
        Sat, 30 Jul 2022 12:47:36 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b0043cfb6af49asm4168403edv.16.2022.07.30.12.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 12:47:36 -0700 (PDT)
Message-ID: <41da68e4-67ab-29fd-342b-a5619aaf6110@gmail.com>
Date:   Sat, 30 Jul 2022 21:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: clean up dump_chip_info()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220730150637.3550-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220730150637.3550-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/22 17:06, Michael Straube wrote:
> These two patches clean up the function dump_chip_info() as suggested
> by Greg Kroah-Hartman and Joe Perches.
> 
> Michael Straube (2):
>    staging: r8188eu: convert dump_chip_info() to use netdev_dbg()
>    staging: r8188eu: refactor dump_chip_info()
> 
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 37 ++++++++-----------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
