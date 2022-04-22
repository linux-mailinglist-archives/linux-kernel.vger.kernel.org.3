Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252650BA21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448722AbiDVOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448673AbiDVOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:33:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6C275C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:30:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c10so11344358wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ItMjhvb1/hM2jNtzAM/HCEyjHx2yTDf8giphic99II=;
        b=Q+bqKn2kphZ6dkI4mNlHNqszn4boae0E/d/xBKmldgHQrzrmLOUjZyXGzBd9PX2ECn
         IYK84mP/abeHXWDoCOYulcBZO1pgSCfNJkYOr2le+FGi/Z57Q2Y5ZGItIiyJtWrL8eDG
         KuLA6BXfrRFs7ktJ+bLAvO2a2NstJNdVQz5kYdos/hpyNlBoC0ThHhpJR536oxMUJ3Df
         XExXODKubzBTrzjTQkJU2H3APAUCK1JS5B6B8J2fVdQyzRxQcpMXN2Q9h9VmKLrTVdhz
         zy4FcewLm5Q1jsyHbtrO74mdXdjqTF235POz/loiWtUrHaZpO45aE/uLY16JxqvHMDxU
         ciFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ItMjhvb1/hM2jNtzAM/HCEyjHx2yTDf8giphic99II=;
        b=QnAezKvvnXOrWfDumAyyZFX2KetYNy8tsrR9hRoKviP908qqOljWbrEmoZmshkw1ee
         rmGMjoKp4l+iGusghJeOymB2FzXWT+4k2H0BbZlhVyQJzKvvspZvOxHe8WDaam9EY5ZF
         yUKNgiTnsYIc/o2B1/puhTgzOrxF83K952Qfoj8b7IbNWoTIzizpdOft2+unnCmXumbG
         k2kfO1uGg4xj+BrRtoPZ4JnnesVEm7PNEmukAV715WJ1ajBU/ar6ic6oRPN2htmefOAZ
         pGqH7iMB1hCs+cE9yvDu6j+CIPMoBVtzG7EeDG+AhmaeJYl3xrS/g+LktX45Xn1pxEgU
         R5PQ==
X-Gm-Message-State: AOAM532gJ6eKj3WZir5PXUJeoTNyndMyESHCrZThNrujWvU2F2T+k934
        YYv2rT7SkuMAlOJ4dW3m8t3vZ8hrdXLAvg==
X-Google-Smtp-Source: ABdhPJzO4XZzgz0MgPEnN50RQJl3TakwYabgyyn0sJV65Y1f1DF3kHXL1X/rRZ3t7Oi9mzkALEpM+A==
X-Received: by 2002:a05:6000:249:b0:207:ab35:67eb with SMTP id m9-20020a056000024900b00207ab3567ebmr3951299wrz.222.1650637820657;
        Fri, 22 Apr 2022 07:30:20 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id u20-20020a05600c19d400b003929c4bf23asm1730656wmq.44.2022.04.22.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:30:20 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:30:18 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Aliya Rahmani <aliyarahmani786@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] staging: media: zoran: fix warnings reported by
 checkpatch
Message-ID: <YmK7+rQFwxcmMCfQ@Red>
References: <20220418171453.16971-1-aliyarahmani786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220418171453.16971-1-aliyarahmani786@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 18, 2022 at 10:44:50PM +0530, Aliya Rahmani a écrit :
> These patches address style issues found by checkpatch in the
> zoran/videocodec.c file.
> 
> changes since v2:
> PATCH[2/3] : Rework commit description and subject
> PATCH[3/3] : Rework commit description and subject
> 
> Aliya Rahmani (3):
>  staging: media: zoran: use seq_puts() instead of seq_printf()
>  staging: media: zoran: else is not generally useful after a break or return
>  staging: media: zoran: avoid macro argument precedence issues
> 
> drivers/staging/media/zoran/videocodec.c | 9++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
> 

Thanks for your patchs

Only problem is that your patch 1 did not apply, but this was easily fixed for applying.

The whole serie is:
Tested-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Corentin Labbe <clabbe@baylibre.com>

Regards
