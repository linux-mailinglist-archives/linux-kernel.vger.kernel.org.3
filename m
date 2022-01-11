Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC848ACFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiAKLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiAKLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45186C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5C1DB81A3C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BDDC36AE3;
        Tue, 11 Jan 2022 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641901895;
        bh=YW0OZhYsuewAmzasFLxM84SGdBJVowhYEyedXq2EAYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHPmuV3PFvR4nQEvDbAWej+stThuIUo0tocGtO32+d4Bs+FFEGGGCfezGplYLaCq/
         43EqJqIiAV0OhxP10piu7N+MJouZQ8ds59GNuc5p9o0LXiM3NWiq9thhsa+e7nq3Xq
         AX6yFm3FJPmmZbybgRDJiH30IB9NEibqmLLyqD23Jah0hh+opLwZQt6uz6srrJtyU1
         0qKw6BEUw8h31+/xXKWpvy0ZIoJHdDyM4Tj9bqUwBsdJmUy4jUwK1thygnteQOMXos
         8KJ59UsFlrujuH/E5kGZlXrL3RMHhpfYMdx+n1HYUCozIsjVO2ensY5JUUWL1VKBUb
         pmSgaRjWRZUKg==
From:   Mike Rapoport <rppt@kernel.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Remove #ifdef __KERNEL__ from memblock.h
Date:   Tue, 11 Jan 2022 13:51:16 +0200
Message-Id: <164190183646.2923516.652408637059504387.b4-ty@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111102847.673746-1-karolinadrobnik@gmail.com>
References: <20220111102847.673746-1-karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 10:28:47 +0000, Karolina Drobnik wrote:
> memblock.h is not a uAPI header, so __KERNEL__ guard can be deleted
> 
> 

Applied, thanks!

[1/1] memblock: Remove #ifdef __KERNEL__ from memblock.h
      commit: a59466ee91aaa9d43889a4c51e01de087d188448

Best regards,
-- 
Sincerely yours,
Mike.

