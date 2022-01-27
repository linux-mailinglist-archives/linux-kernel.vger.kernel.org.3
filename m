Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4649E8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbiA0RT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiA0RT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:19:59 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:19:58 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i1so3078426ils.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xAKdJ/tujRi8fhxhetqf00KEAUhO2dTbL4KlheL+4Hc=;
        b=6EU5YRSoG7moyzjPCSAVdpw8ZS0uYBTReUZyiL94xwbOWz2W89CUw+f4I+0jEcNV2Y
         7IEJY2O7dRroF2BQMB42mgxMQuRvGGxVyiUcKIHUL4lVULAaCZ24sYF4NoAtDPjT7+eK
         QQsw5zEaFOwKIcBenjfegfWUueZyOsgV2wXnSI6XvEvdRW8pYmCb4vyS012p9/4S5yVl
         o8HLOpfs4etfvxKJUk1AAUerJCosyFFjFKemfWKtoNyzgN5V/ycABQvJOJtF5E3+CJks
         33VjtFv/k7emfU6JMbxU0LsewhfLF4dHepry86oyKVSBmE9Pxu0DNFlhnzGB761qOrxL
         MZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xAKdJ/tujRi8fhxhetqf00KEAUhO2dTbL4KlheL+4Hc=;
        b=E+TWnzRts71cy4Bygka925bCaxQHZdYhbTahkJAeU0adDaRH17n87wx4fxt3T8B3rF
         jmWuS7m+/QthGgcYCv9is7/g1Ctwg4rL4liLnfW213qO+GKB2r+ruK4jtnLeqERdpgaR
         HKxLCsIolBZapMw2WRfbCg1zJHnyhDAWK2rkR2tOrmhOwd2FB9y0Wg1Vj8Szeup1p2eB
         A93wSKjXYsSXBvZvy96izw8PHtLBgkBvfdEqW2D8AxTlygU9J3t6qYP1UK9Q5pN4Aco6
         GnX19gTwIt3wt0XLGEr4Dy3tRY9DK3+7vnSe2zMzQe2KPFlVXXC8IUy2y/buUZUPV9+J
         uhoQ==
X-Gm-Message-State: AOAM533xGeVydSbGFlIv8wdi53kwg3sj6Q/V6aqqSbwsM2tZtc7rmHJI
        Un7zVzxvVvAVoxK3OAVUwJ8olg==
X-Google-Smtp-Source: ABdhPJy2TDJL5jdE8PakyZZhULt1VkqtDhWLGh1HIX/PUveSXQs2+dFd0bE58gFjuH9VAx/voobWIg==
X-Received: by 2002:a05:6e02:1a2f:: with SMTP id g15mr3167197ile.271.1643303998291;
        Thu, 27 Jan 2022 09:19:58 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n3sm108985ioz.9.2022.01.27.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:19:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220127064125.1314347-1-hch@lst.de>
References: <20220127064125.1314347-1-hch@lst.de>
Subject: Re: [PATCH] block: fix the kerneldoc for bio_end_io_acct
Message-Id: <164330399766.211332.13316098014683559677.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:19:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 07:41:25 +0100, Christoph Hellwig wrote:
> Document the actually existing parameter name.
> 
> 

Applied, thanks!

[1/1] block: fix the kerneldoc for bio_end_io_acct
      commit: 5ea0af2025e27d9f30f14d2c777eb80b6d5c7296

Best regards,
-- 
Jens Axboe


