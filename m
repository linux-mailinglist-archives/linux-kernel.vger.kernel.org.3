Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3648A946
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbiAKIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiAKIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:22:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC0C06173F;
        Tue, 11 Jan 2022 00:22:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so4491230pjb.5;
        Tue, 11 Jan 2022 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:reply-to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8s/ubBm4CMzoy773ZTaMXyvoXj9Suifczp18+PqTu/Y=;
        b=nQdpHA+fTsW6/Matv1kTvyM0o0t/GciHubOzxYrt0P60VF5Sh4Ekps2nSoyTA7AANA
         waUCVMOcluHfUdunRqaLnyXbxAfIt3ZOy1lGeCWcinSU5kJO0ZxjEJbU1210/OVFtkLU
         3hN0KjarGxvUYFlqFvmUPgRixwXknGKy7yARmTlN0WiPM5fHX3+gTJtnCfvfRvY6Xrd8
         M3xLj4bEV26JHWXoQezXegxn4FoeZPSJPo9YSZk0ZerpmnFVjsIyMEkQPa+j+aWpqzYF
         EeNdDmq177m+fO3gbq4fgdtwWRCEHA1l/2QTu/6f2glnkQMiuE5PItKevSsgJxZRpgJ9
         xjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:reply-to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=8s/ubBm4CMzoy773ZTaMXyvoXj9Suifczp18+PqTu/Y=;
        b=fJWsadFEaUxUa5VF0BQGjhbxCTlEHV3CQIl4Ca1xN6TGQM43HYHE/W5t1ALZhLlvnc
         +yHMpd4fELYaKCxjpfAx5q+w84d5/kftqtsPjhu4lJzq9My6YDJ0Oby+mZdJDlV323kY
         fzdqyu2EDhqub92QzOXaSqomhesXQWAVmFQLKZHdpOGvdooJpp9lE4Ryba7vMQmjCj6u
         W/8/2RHTF1AUS/nGkwyDKNKwgXkt/0OtBLNcsA3lOum5jaH2iCmmMIEHDNyjaDYG/sOP
         jdOvIyQucg5pQxunipcK79OYf+VKE6N3gUio0Z5nRH4JQbtx3sPpKZ37IKaME/5+4Rf4
         rUjg==
X-Gm-Message-State: AOAM530nmlMMmAwfc8Y3Tr/f3+Y7UALriBCthKk9FJF7IqPaXRBVQwqX
        MyaFnZjVXftysxlrwFydP0M=
X-Google-Smtp-Source: ABdhPJw1SZvgOJwJjhIAzsckFYxYtbdwTEnTvshufFf3hc5ZjORHdDxLQ99Q2bO6bxiPBO5PsO4OcQ==
X-Received: by 2002:a05:6a00:216f:b0:49f:dcb7:2bf2 with SMTP id r15-20020a056a00216f00b0049fdcb72bf2mr3421948pff.19.1641889362075;
        Tue, 11 Jan 2022 00:22:42 -0800 (PST)
Received: from [192.168.1.7] ([124.123.173.144])
        by smtp.gmail.com with ESMTPSA id e20sm9262184pfd.104.2022.01.11.00.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 00:22:41 -0800 (PST)
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Reply-To: 20200416115047.233720-1-paul.kocialkowski@bootlin.com
From:   Suniel Mahesh <suniel.spartan@gmail.com>
Subject: [PATCH 0/4] media: rockchip: rga: PX30 support and YUV2YUV fix
Message-ID: <9e7aa8de-30cf-e3e0-4c5f-e4b989ea8b48@gmail.com>
Date:   Tue, 11 Jan 2022 13:52:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul/All,

I have added this patch series onto linux-next and testing RGA on PX30.

Log Snippet:
root@px30-engicam-px30-core-ctouch2:/# dmesg | grep rga
rockchip-rga ff480000.rga: HW Version: 0x04.00
rockchip-rga ff480000.rga: Registered rockchip-rga as /dev/video0

How do I test this ? In the email you mentioned:

I tested it with a standalone utility setting V4L2_PIX_FMT_YUV420 on 
both output and capture. The issue should be pretty easy to reproduce.

Can you please share more information/any procedure on how to test.

Thanks and Regards
Suniel Mahesh
