Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6488F49E8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbiA0RVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbiA0RVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:21:19 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F6C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:21:18 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z199so4394730iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=vX9QiDLaYn8bVSU3hlkgLiboqNWqtYndewsSA+nMLWU=;
        b=JoPRJEV4mOazgn8m2YU6as5qPgCFfepMeIoPVMRgVPEJI9Ub8O/yKiINZTEFt0085d
         qIu0oACDLqJyRpHwlz9lBJaoiZSGQItG7DPaOU4RceXwSuEIXm4/gel1MjBfFg6bZqnX
         Wbm6jfdrEluAQ7/aeWZPQxgKa+7GUP1sx6W2erD/Y3oNga6FLO9ABqqM/E3DBHPJP+0X
         nkGkUbWztI+gVxmlCvIrzSI1IQoRijm6l9nllEPku4RJiraJy2S5kIuiYTjOgzZxcNyO
         NQLZUagsIuksu/6besjb75mRVATKA38SNBfLJ8/vzbGRTm4bE6gIDJo06xk1pByH+ABe
         o9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=vX9QiDLaYn8bVSU3hlkgLiboqNWqtYndewsSA+nMLWU=;
        b=6VVFSSCX46pUyZzsn2Qf4gvZHObLNo1cBkIQ8rBTIUHDY+zj11wgh/vd1E6KiLCVwu
         l0ca9zyKfiRet5Dtd7CifVONWOS1HdIUli4aKDT2KQSJ7oIfFDkCzC0kBGUpNYmhrbp9
         K/GkABnnW5+DkCcWc7fS5LVrAGzV3JFkTmo41on/Zqh4Lfez+NUTjFZoNIdQIWsPr3m8
         97TbzCXV8cNng/K6A7CpoSRLrp+iCkgqDnUfu/a/KFCzTC6saKMt47oiMMgQiDcMjDRq
         DVvl/XxGPYxJSNblCPLbVlEuIq0LiOqoaKKkvQdUgcytbmkggf37wCNW+NKOIUW8CT5g
         dVLA==
X-Gm-Message-State: AOAM530wx8b8QIN6XzPmO04JsOC+ZVreox53SLyL/qyAF97dTZ1BM/MI
        GSIyEhjar6aUuEpgew040XxiwdYdamFwrQ==
X-Google-Smtp-Source: ABdhPJy7KI+BSyikaBzBavqRB7HBA1Xp43h7HYOmAzuC/x27dLqkbQUv0Wvk8+CaCv0puT56ueDjzg==
X-Received: by 2002:a02:94e8:: with SMTP id x95mr2327870jah.20.1643304077994;
        Thu, 27 Jan 2022 09:21:17 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y2sm3690848ilj.29.2022.01.27.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:21:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220127064221.1314477-1-hch@lst.de>
References: <20220127064221.1314477-1-hch@lst.de>
Subject: Re: [PATCH] MAINTAINERS: add bio.h to the block section
Message-Id: <164330407734.211725.3209544365057118163.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:21:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 07:42:21 +0100, Christoph Hellwig wrote:
> bio.h is pater of the block layer, so list it in the MAINTAINERS file
> as such.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: add bio.h to the block section
      commit: d216a7289054bd8ef875533658ec5bda8c8f3f4b

Best regards,
-- 
Jens Axboe


