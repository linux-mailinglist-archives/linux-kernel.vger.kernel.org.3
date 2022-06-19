Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79653550ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiFSN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiFSN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:27:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72238A1A1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:27:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g12so3191839ljk.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=USwIgojHd+4gk/AHbWFfWMNbK7HorsIidQTsMQSbCVU=;
        b=Q/hemLjSDMFkO9Tg2NsP1VHpDtRMriHHdj38JIvhf5xuu2VMIEranCy3wePWG/sOwL
         g2ipGRj5Q0JlVqylTQuFi0DqLS2hhbkikTIR7XdWkuSsI+a3dwVSNgDxdvo1N6K1V/qN
         Lp6d0mKXIdday0bhE4F+C3tGVeu/fel5UujWfGf8p4bU23F7xBV1FYGwOMj4/pqdN9Zn
         aJe844J0GEwbElzCJ4fypWgjAqWuLH9QpXDveA7IarAw4aTFj22h9jb2kdC7SHpIpUEV
         xe/jmnXzFAcVUToTNmklLXjQ4a5XUP5HybuECVzsYV+sAD3qwxxr7OIgTS5ivumn81lX
         FQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=USwIgojHd+4gk/AHbWFfWMNbK7HorsIidQTsMQSbCVU=;
        b=oROa8xSxFYAtNxZNHTwIID9a8CwZpUBKKdzgLAbnuZOdk2GIM9q5ub5l00Bb9bVIqz
         bfNv8JzABChv6hOimNdgoInslkxNaneeOZTqQ4Gkca/N6+0CHbxl2Vs0cSE2VR9PxkDL
         wZFRCcPBH49nWODgjTqW4fHeb+rWlxvsa71rOBQJrrg+nH97YwWdNHHe7LJAb2E4mh8a
         ucOBTj3wvSEYLK3+0jxzLK5E3sv6s1qeUXnl+29Egt4TBAk+/s9D+zlx4r5XjCZqJdto
         CJu9w8qmXhNq3UX0zCSkIFre/nwP5RXbs5Mxj81py5QtdZM2uY0w5MRjAgp0y115X+J6
         eYTQ==
X-Gm-Message-State: AJIora/WtGfq4D9etc9StPuGjS7IiuNufo4Dy6vnh4DWlmGxd+p6uegH
        HL0bFZm/k94XrSi/0VdK3ftJUs/IWzZaig==
X-Google-Smtp-Source: AGRyM1u0JcyUxScgBS8laLu9CqwZlVR9LIrBtuS8pvs986OuPSuedixO1Df3jfGCZsSe8Y02oyijgA==
X-Received: by 2002:a2e:b0c6:0:b0:255:7c46:16b7 with SMTP id g6-20020a2eb0c6000000b002557c4616b7mr9577251ljl.383.1655645242642;
        Sun, 19 Jun 2022 06:27:22 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id d18-20020a193852000000b0047f5f292485sm594946lfj.68.2022.06.19.06.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 06:27:22 -0700 (PDT)
Message-ID: <91c9a0de-76f8-37fb-31b4-4401a6e35d48@gmail.com>
Date:   Sun, 19 Jun 2022 16:27:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Staging: r8188eu: core: rtw_xmit: Fixed a few coding
 style issues
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220618204454.16071-1-marcus.yu.56@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220618204454.16071-1-marcus.yu.56@gmail.com>
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

Hi Chang,

On 6/18/22 23:44, Chang Yu wrote:
> Fixed a few coding style issues and spelling errors in the comments.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---

You are doing a lot of different changes in one patch. Please, separate 
each clean up into its own patch




Thanks,
--Pavel Skripkin
