Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45C474F33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhLOA1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:27:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:46621 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhLOA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJn6jW0z4xhv;
        Wed, 15 Dec 2021 11:26:49 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Xiang wangx <wangxiang@cdjrlc.com>, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211205130925.28389-1-wangxiang@cdjrlc.com>
References: <20211205130925.28389-1-wangxiang@cdjrlc.com>
Subject: Re: [PATCH] macintosh:add const to of_device_id
Message-Id: <163952787936.919625.13845542999009417671.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2021 21:09:25 +0800, Xiang wangx wrote:
> struct of_device_id should normally be const
> 
> 

Applied to powerpc/next.

[1/1] macintosh:add const to of_device_id
      https://git.kernel.org/powerpc/c/8cffe0b0b6b3342d75e5469f07496173feace6bc

cheers
