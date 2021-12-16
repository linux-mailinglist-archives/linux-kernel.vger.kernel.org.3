Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B226A476D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhLPJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:27:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43664 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhLPJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:27:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAE4FB8226E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8885C36AE4;
        Thu, 16 Dec 2021 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646829;
        bh=pRLQOsDoyJxHWykiP4JKcqFGZO/3CTBX6BBhg60R6mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtYRcCt0Q1dD82ZTE8kFtDQ+LE/bHDZCAYCgDZm3GQrAa0sbIu25GkAPf6qR6HpjA
         aGQDjClC/Re+Ti3sGLfrCtP4RBr/V3MIW1GmDf62pq09B1Bg7vnBU3eIzxro830B3j
         IW85jtKtZNxJSH6YR3p1uBj8Hwuj9h53BHBzJiay64Fk/hwcWJNkGF8JPIKy4kA9KL
         sWY4jFEZmHQXzmZZfm3VtjeURDBRRBMQLnSEXhgCksiO/jMkweNjmdZDtbsqX0KaDj
         3m4S2teG+/r5zMi3TG6gilMZYeYKgufPQPx0NEDVi4+yd4xoGpN+aloXsK/1XnJrDj
         kmUm8mbyqa/zA==
Date:   Thu, 16 Dec 2021 17:27:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: lx2160a: add optee-tz node
Message-ID: <20211216092704.GD4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-4-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:35AM -0600, Li Yang wrote:
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> 
> Disabled by default in SoC dtsi and enables in board dts files.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
