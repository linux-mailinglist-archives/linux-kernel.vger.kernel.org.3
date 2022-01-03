Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754CF4830D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiACMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:04:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1941FC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:04:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so136241693edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yUUBr+kBGeBcq3Ep5zPtjMHNJudLazXCTtUrSx+Rq9I=;
        b=DK8r62T0DISJWzPM9qOURdZ603vIi606CyB7DdIUsEIKpnNSLrm2dMkTDMZRrT61aH
         x2XioskTISNsnNtMVThj3ty3IuyhSBY9duwdVHm5ipdii05FFIH2BoJo3aIErSaywonW
         K3fgl0ArCjNz2PHSIQy9fCuhUSdRSKjMOO5STABXWfKOAlrW3Htfp/zsb+Iyp5+Nx8Yd
         RcIOr5e6HrYWSz3CFT+vlOXtxK1jfPfR2bTjxqyfCJoc+bPAJtokpylAe6zY7vjfFID0
         hNbbpVuV+9D43/fVoVAjeTxnbvw8RtL75OXDjSiE1NnHGbqjxgrDtYGpfRb2/StnzPJN
         ipSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yUUBr+kBGeBcq3Ep5zPtjMHNJudLazXCTtUrSx+Rq9I=;
        b=3CoZ1qUwqvzAofwwLW7v4y4MLLcusk7zc6664KAgtB3aPD2IJDlcHaehJgGKfkIh6x
         Vi9DBbgdJp15cGFn/mhl9HSgm6kzXrdYwz0LL7naZXs6M5lmY2p2IscxwmllE+e4vkBV
         Sn1bqiffT94UuGx6BmhfRLBrby6rNZsdY5Rc52N5iuptCX2qjjZnDentR2Z14DfC5JjM
         uywFLOMuvGPINy3OZsRC5WiNsxfsAvvpcv9DJASeCcyjJHkuOO6ZXSzQhU4zT+v+9AZr
         lurPugRoEiyQi64Pw+MNVbOFioEb2UkUZaXcSfxsSPK6pxQnsvBcZgmI2AKbiZFXaexp
         nXzw==
X-Gm-Message-State: AOAM532FvHjxaFdyPu8x5oeLhf2/G68OtRc8syYuVhWvsiQUbEGz/8NG
        JkeaPGkYfeJ+magvyqEYihU=
X-Google-Smtp-Source: ABdhPJy3W6/jrc3G5U8YKTUlFxbeb05FgfPek35YomTxqAudLCMcyTa7nMswQ2AtCARCkNEh8BvA5w==
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr35129231ejc.269.1641211479652;
        Mon, 03 Jan 2022 04:04:39 -0800 (PST)
Received: from t470p (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id o22sm13571400edw.50.2022.01.03.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 04:04:39 -0800 (PST)
Date:   Mon, 3 Jan 2022 13:04:37 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: replace camelcase field CustomerID
Message-ID: <20220103120437.GA222170@t470p>
References: <20220103111131.212261-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103111131.212261-1-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 12:11:32PM +0100, Alberto Merciai wrote:
> Replace camelcase field CustomerID to customer_id, compliant
> with linux kernel coding style.
 
Apologize, don't consider it, wrong branch was used.

Regards,
Alberto Merciai
