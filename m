Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1640957E6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiGVSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiGVSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:52:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78B8BA8E;
        Fri, 22 Jul 2022 11:52:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so9968749ejc.11;
        Fri, 22 Jul 2022 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MJnFfzBEUxybZkQ3AxAi8Z56rSmpzOjF0yaefAJxp6k=;
        b=hPZxmL/vWnVURDpuU5aHymrsvWxtm6phB5uYYfvhQzgWt53DdeAhC6HMCunHo6e2Kq
         mbe0VDHybExAiLyV6Roj+1sl82xouib0F8XZ336XCe3Dlptvzu8ARXvTEcYLBsMlUTmt
         wksvhQkz5iuRoFscO0Byg6DO93bByOXCv1VMc0lSDYF9TbCMfdDDdkGKIbThaa94u/OL
         TezSX55mmtFRSebsJFkQRp82X3HxmwQh0+gbyfZCpPbiC2RKvkS5dl+qebIv3t4TqQFh
         twI452qKF3guV7yiAZGx7olOk32zh/oIFlYzmMwLuEFRmIAoXdO+1bVipVyLRgtx5RWF
         QkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MJnFfzBEUxybZkQ3AxAi8Z56rSmpzOjF0yaefAJxp6k=;
        b=d6nPNVI93arqsKaaeV89ift2tG6g9PP+Pwbu2Hb9Viy/tAj8q/CFyBlEtFiTmjSwTY
         vARC3KDfFt0MSgnYo7YOSFaRVulsFK0unmrBc5rjjPJCMdyq01IILdrzo9Z6jVa7fhaW
         dRTIoaFZJjjeL4qNDX2VTlYXtR2UnkpDXnyssnrPTgue6r38uyrUi1HZuCUuO/eoaP5/
         dJDDpcKVPW5JZ4kuKVHdmmvDyayKsmq9E/KGN/yRZATAbglbMKpFXYIhhYFUEQdY7MYH
         NXyGzCuxHsY4DFICVU7GggYczNGWRQ2TRDLRBGm3nccCZgpNga7SsJLCM3s9KBC33AQN
         hZOA==
X-Gm-Message-State: AJIora+LDLl9tnV0sXElNuyGV5+gBvZJQCf4lm6GMWMi7kUPPVU2CsgP
        8Cw44VgQi5Af2V1uUnGaqwQ=
X-Google-Smtp-Source: AGRyM1ujFj4t7DYHcsrPBzRq+6SUk8TcoRlKKxifPrZPe4IvIdWUJ9ZH6r9gh7ZyWEv6S28pODeNMw==
X-Received: by 2002:a17:907:2d26:b0:72f:d05:f530 with SMTP id gs38-20020a1709072d2600b0072f0d05f530mr952752ejc.284.1658515951114;
        Fri, 22 Jul 2022 11:52:31 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6976:6ec9:79b2:9979:d758? (p200300c78f2e69766ec979b29979d758.dip0.t-ipconnect.de. [2003:c7:8f2e:6976:6ec9:79b2:9979:d758])
        by smtp.gmail.com with ESMTPSA id d11-20020a05640208cb00b0043a7c24a669sm2920297edz.91.2022.07.22.11.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:52:30 -0700 (PDT)
Message-ID: <614ce7e3-ff4e-5d76-e940-2aa222535743@gmail.com>
Date:   Fri, 22 Jul 2022 20:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: staging: media: zoran: Deleted dead code
Content-Language: en-US
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220722182622.23719-1-abhijeet.srivastava2308@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220722182622.23719-1-abhijeet.srivastava2308@gmail.com>
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

On 7/22/22 20:26, Abhijeet Srivastava wrote:
> Deleted part of code in block comment
> 
> Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> ---
>   drivers/staging/media/zoran/zoran_driver.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
> index b408c1d4e0a7..836edf623571 100644
> --- a/drivers/staging/media/zoran/zoran_driver.c
> +++ b/drivers/staging/media/zoran/zoran_driver.c
> @@ -746,11 +746,6 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
>   	.vidioc_enum_input		    = zoran_enum_input,
>   	.vidioc_g_input			    = zoran_g_input,
>   	.vidioc_s_input			    = zoran_s_input,
> -
> -/*	.vidioc_enum_output		    = zoran_enum_output,
> - *	.vidioc_g_output		    = zoran_g_output,
> - *	.vidioc_s_output		    = zoran_s_output,
> - */
>   	.vidioc_g_std			    = zoran_g_std,
>   	.vidioc_s_std			    = zoran_s_std,
>   	.vidioc_create_bufs		    = vb2_ioctl_create_bufs,
> @@ -762,13 +757,9 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
>   	.vidioc_streamon		    = vb2_ioctl_streamon,
>   	.vidioc_streamoff		    = vb2_ioctl_streamoff,
>   	.vidioc_enum_fmt_vid_cap	    = zoran_enum_fmt_vid_cap,
> -/*	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,*/
>   	.vidioc_g_fmt_vid_cap		    = zoran_g_fmt_vid_cap,
> -/*	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,*/
>   	.vidioc_s_fmt_vid_cap		    = zoran_s_fmt_vid_cap,
> -/*	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,*/
>   	.vidioc_try_fmt_vid_cap		    = zoran_try_fmt_vid_cap,
> -/*	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,*/
>   	.vidioc_subscribe_event             = v4l2_ctrl_subscribe_event,
>   	.vidioc_unsubscribe_event           = v4l2_event_unsubscribe,
>   };

Why does the subject line start with "media:" The subsystem is 
"staging:" so the subject should start with "staging: media: ..."

I have no clue if this is accepted.

Regards,

Philipp
