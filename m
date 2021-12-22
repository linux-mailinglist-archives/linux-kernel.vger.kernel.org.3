Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F71F47DB96
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhLVX5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 18:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLVX5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:57:10 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909ADC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 15:57:10 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p65so4966129iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Bnw7wHFCUHYpfW3nSmuDB+TIiRcPmrM94dEyYSAn7Cc=;
        b=6WhmxfTJP4YvSXjDC54AE6Qh8XgEIE+03YCRfh1sidSeeq0yEU5Mf7ge4UBw+SMmQ/
         kDHCNu5VTPZTbmKha9G2M6QzsOZDoIfIHGmE6vJ6WZ+MH375UO1iEcJiYYjbQfCrVl2F
         9AenqQlphhzyYS0GIfm0W+XFbsrnJj4yl84iLryPeyCCY2oz4W+S02hOE3EEdaTNqbUU
         gxRo0W6Y+gnUxMkiSl8rUAe26OQUS7Jf2bU76oBSSB10fctkZuIL9PeSNkCNi+0TkBkh
         NmmhfQDIATAdlAOv8WBXNYjCzZIy9RLC5pFR20ULBK4cy/uaeaNCDhNf6q98QtwAR88R
         Txtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Bnw7wHFCUHYpfW3nSmuDB+TIiRcPmrM94dEyYSAn7Cc=;
        b=ZBJa6OHK8DhhAHxqJrahW6XSFS5Ozq6VFQnzDzMLe8GQqCdQQZBtE1cx2LPxuuhjH5
         aU8xORDxIlKrmHti3bW1BGQPuNiZRRfiBcXUHMEpM/4suoSPAqqcn65MEMzgg1t7Dr2r
         eBgoZ2TozyqW9S9is3pT4BgqANpBuv3T4uQv/WTsBCLY3GQLCHjZytn4VKw6KpxzlRI5
         yyUu605+mour7hNDGQHDps6w2kl0msk4zhPJmfE9eWYoRwMYHLmnoSkALOeTxWeDJjqH
         M7mXhTu9TVR+4VOfKXW5+pJ22AcXR1EajV8syr8yHv3DeYuXauAxAgt2HtMZYHAQWifj
         cudQ==
X-Gm-Message-State: AOAM531HV5K/kq1a9BEms4axFjkLerI5QvdSST+VDxKF+1X4tWVT67Pw
        FkU00jXYppmu/7c3I/w2wL+6rt2BdhMXUA==
X-Google-Smtp-Source: ABdhPJy5zHj1ZVULmWmKPeo/mXMYhX8a9xoTE97n1lFacMU+agzi64Ee9hLUj2KRyB+huoCLoZunxQ==
X-Received: by 2002:a05:6602:2e8d:: with SMTP id m13mr29077iow.68.1640217429764;
        Wed, 22 Dec 2021 15:57:09 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w19sm2509337iov.12.2021.12.22.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:57:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20211222211532.24060-1-rdunlap@infradead.org>
References: <20211222211532.24060-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] bio.h: fix kernel-doc warnings
Message-Id: <164021742879.719922.17581389641150829560.b4-ty@kernel.dk>
Date:   Wed, 22 Dec 2021 16:57:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 13:15:32 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in <linux/bio.h>:
> 
> include/linux/bio.h:136: warning: Function parameter or member 'nbytes' not described in 'bio_advance'
> include/linux/bio.h:136: warning: Excess function parameter 'bytes' description in 'bio_advance'
> include/linux/bio.h:391: warning: No description found for return value of 'bio_next_split'
> 
> 
> [...]

Applied, thanks!

[1/1] bio.h: fix kernel-doc warnings
      commit: 6fd3c510ee4b37f2f9fe3d3cafbfa459e15c5e11

Best regards,
-- 
Jens Axboe


