Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB0473DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhLNHkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:40:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50498 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhLNHkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6370612AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346EC34601;
        Tue, 14 Dec 2021 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639467618;
        bh=spvSZByQK+29iSEGKgTMsJTE72ieXduZWv3Fg8lA06g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwF4sStEVMZne9O9j+TyF+OTJFgn6NQedmvg5xFTZVg+L2dtUiCxsiEZGBJb/44J8
         7emwh091FVE1vnGU1r4ePeP++zEtUCKIZ3ylEfa+ueA6Z1tbaZ2n9UXMMbMz42AGY/
         LJUkT23IlqTJqIA5ST65mo/QYYJn1RTIfVGBnBFG9uGDv0RVmYyMuTa2IajhDWZUMs
         MY6oboRP0bBL1Z5rjN3w8CgkDUz6XcaLtCyfTWFtbkupDm+KEDXRm0s64en3+PiSxp
         j8Ey4q8ho/8COwlp4VWEdwVQj3IXc5cERfoHwLc/SD02SvEFvUrC8QuceXa2oDNIOY
         kn81vlq6jYnOA==
Date:   Tue, 14 Dec 2021 13:10:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: Use IS_ERR_OR_NULL() to clean code
Message-ID: <YbhKXdHRbe0EmGwx@matsya>
References: <20211212142226.23674-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212142226.23674-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-12-21, 14:22, Miaoqian Lin wrote:
> Use IS_ERR_OR_NULL() to make the code cleaner.

Applied, thanks

-- 
~Vinod
