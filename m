Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBD473F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhLNJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:26:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38570 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhLNJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:26:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F5A613E9;
        Tue, 14 Dec 2021 09:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA5C34601;
        Tue, 14 Dec 2021 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639474000;
        bh=TOLTm6YtZnnWFSSc+W+XHIn01BkM0SMw7/Ncg+XzZjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyEaldnrWOeLhL3j1I2Idc9pqZy//1mzyvVyJp+5wmoydCIi14ue80RRK5e070new
         828qrukDZtJoofSdOg0kJzcx0RdwSXBHtJbMwTLt0j0TpfUyNBK+DIoTWtqje0ghdP
         PnWXiKOHcrllDIDZNR3MUH3nyXP2WlpQvWgCIESrKu1WjgnCuvb+bRcqJgmlPianO+
         7jAVD/+KE1SphGyKUZrmnfcRVpg+ooltR+41jVw9j7m+2WvbfDsXsGGMOG/fviXT/+
         wdEylmlswA0zpWyt9i3eTtRbZm/PKyVNJBWo2lw3L0QjPMKILj9roUwj0/vMkewfSp
         ena0o6uSTlcsA==
Date:   Tue, 14 Dec 2021 14:56:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     davidcomponentone@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pyh: qcom: fix the application of sizeof to pointer
Message-ID: <YbhjS2Nb8yrT9Nzq@matsya>
References: <8d75af8e322a7e5839d2dd4320b696ee09ec0843.1639100549.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d75af8e322a7e5839d2dd4320b696ee09ec0843.1639100549.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-21, 14:21, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The coccinelle check report:
> ./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
> ERROR: application of sizeof to pointer

- this should be tagged v2
- You should always note the changes done in v2 (after the --- line)
- subsystem name is 'phy' and not pyh
- I have already applied fix e87f13c33e126ab2c72f9acb5ae98fbb93ddfd32

-- 
~Vinod
