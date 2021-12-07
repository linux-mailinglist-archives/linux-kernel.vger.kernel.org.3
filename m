Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0A46BA8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhLGMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:03:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59198 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhLGMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:03:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD72CCE1A7B;
        Tue,  7 Dec 2021 11:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D434C341C1;
        Tue,  7 Dec 2021 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638878387;
        bh=WL6Ujukl/ZIDZSWRPbHd+nlmxbXcA1ewcWGPalHNBgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiazURpuJyARip5zMf3bFl+4gkC0Gp6P06d385Ec6naL6dg3inNf0gGiDJhsbLKzn
         mf1AD4F0ZLBkb570EDq7FEN3FDIXG9BZ0AuaobVNqQWz4Go2zSon4EArLUn1zFRzt2
         hmrOVWV4pPY45uB9J0Ih26bGYccvkkLaSXCNiuW9bTgcC717p2Hm7pVk92JN5+4The
         qmGNAxtlioMq7RG9n9Pj4Y6/W+SqkvxIDvSfdUqq4j8G79aaKzktEkiMQ6av6Y3PQA
         ZH3C3dWz8Nf8zymaEqWfhSasnXbUcr8dMNYEXL+F/wmzyFwiyzu2QjgH5cK4A3XajY
         4TXLQfV8/JkzA==
Date:   Tue, 7 Dec 2021 17:29:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi|phy: Add SM8450 UFS & Phy support
Message-ID: <Ya9Mr8SqwPK/uyZz@matsya>
References: <20211201074456.3969849-1-vkoul@kernel.org>
 <yq135nawg3q.fsf@ca-mkp.ca.oracle.com>
 <YapW+EY/IeUk1BLz@matsya>
 <yq1ilw1uout.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ilw1uout.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-12-21, 21:35, Martin K. Petersen wrote:
> 
> Vinod,
> 
> >> No objections from me. However, these patches should go through the
> >> DT and phy trees.
> >
> > Ok I can pick these up wearing my phy maintainer hat, can u pls ack
> > it...
> 
> This series doesn't touch anything under SCSI. But it does look OK to
> me, so...

I would consider scsi dt-update in your bucket :)
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks for that

I have picked the series now.

-- 
~Vinod
