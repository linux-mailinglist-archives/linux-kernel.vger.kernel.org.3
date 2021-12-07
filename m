Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35746BA7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhLGL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:58:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57786 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhLGL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:58:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B6A5B8175C;
        Tue,  7 Dec 2021 11:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED9C341C3;
        Tue,  7 Dec 2021 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638878104;
        bh=PPp1WmBDv/bxhlQV4+A8ZPpSWbHnKFwHCmvmSz20uWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sx50Xw46jF7lcCBAeb7ncUVObmNLUj0VKUnh4HMz5By8X6Ijer69g/KovZuykaR8G
         8NXpG7CAah1msyi9d83vtUOzrGp2csA/wV7R7S98iOVWV9JvUOp2T2lF9o8x3+cB6i
         gh7v1/Cj8NcWBW2cdYZd5vagMb777lpTr3tfSTisL2O7b6c4MPQO70EvKmtnx5EjEc
         Ov8DhnS+EkdqLvzlP4QVQoZHbbtdeQW3yZ9aOaUCMGkYyVPerJH/dRaJ4S3uAR5TZO
         /b3I7jwsAqGAOLr1Tl//lS/pjS1jUF6i+OI0bCfvallLY+IPLPH4UKBIy1Lk193ID+
         W8FIiW/NYBAxA==
Date:   Tue, 7 Dec 2021 17:25:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT
 bindings
Message-ID: <Ya9LlGI9Ra7LD/md@matsya>
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-2-vkoul@kernel.org>
 <77838f03-ef45-114b-bfed-2f12e568a644@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77838f03-ef45-114b-bfed-2f12e568a644@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

Thanks for quick review

On 01-12-21, 18:45, Georgi Djakov wrote:

> > +
> > +#define MASTER_QSPI_0				1
> 
> Why not start from 0?

I have not changed from downstream, was there a reason downstream
defined from 1?

-- 
~Vinod
