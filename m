Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5ED49782A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiAXE2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiAXE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A595C06173B;
        Sun, 23 Jan 2022 20:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 571D4B80AC4;
        Mon, 24 Jan 2022 04:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0B6C340E1;
        Mon, 24 Jan 2022 04:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642998509;
        bh=a9zcV/HJCtoc58GdDIFo2VYi0DSNMeSdZlZvPfkbNuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVpfITq1YTv8ffdwu1bO6gh1NCM0NSipis+EfHeMLbTJ4TxGWV/4upSMbvsHqZNZR
         PgZry3EBKl7la4pmnEyfAcLjy5NHNYgcqv8UbeAG12r9uvbKIuGStEiIs+vPdDfORD
         eXhZNiJva60Z+nB+5RcortyU/szY4OVMowNXlc9uUwuqfNCNJzJmIoonsSwV2uwqjN
         EYII9HYw3kUt54kdDUSldANQBoWdqJnUwJDl1esXcquk+vYahLqF+JscROkpPb8PcU
         eW7B6+XlBHJGlZYsiyzstSThEs79VFliBQfou744CX6BICEyGHsIZ22tkQR19Hx/i5
         r6LYg3xQ6PJrA==
Date:   Mon, 24 Jan 2022 09:58:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: phy: qcom: ipq806x-usb: convert to BITFIELD
 macro
Message-ID: <Ye4q6cKmFNPhkogD@matsya>
References: <20220117002641.26773-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117002641.26773-1-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-22, 01:26, Ansuel Smith wrote:
> Convert some define to BITFIELD macro to tidy things up.

Applied both, thanks

-- 
~Vinod
