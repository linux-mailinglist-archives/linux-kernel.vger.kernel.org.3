Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0F467CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbhLCRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhLCRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:45:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7DDC061751;
        Fri,  3 Dec 2021 09:42:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 706B8B8266A;
        Fri,  3 Dec 2021 17:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF428C53FCD;
        Fri,  3 Dec 2021 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638553343;
        bh=qITFqiG4aRPHfdbrFqKNAIXEJYa92PD9iA88TTUUpvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTslTplSSM3NgsfkrOcGGYigkM7RR1b//xUEigcwoNqUUzR+P5Z6wb35HzUpJpzof
         QR5qeLn7M7+lqmgnfUiMFJ9UKKyteCoz6kafvHGnoKagMzA34ye0hcI8a1p5TBSR2v
         qSAUKtJFXlqfwxY19FdQAhAWUlKLKxOGKiaRV6e75fvo6LdoI8ajoM0oFmUCDYfX0Q
         io3r3izXCheQzxtsnaFS46q77E7yS1aSajmo0XJJh5sZtbTFxhKIdWLfX705SQyKFD
         ildsABREWdyGvQQOUlYnuuTDilhibn+Lh/y3zD4dpYu6Lk4tPqWL/iNQxuP1JnSXog
         Ih3rpRwkYeZ1A==
Date:   Fri, 3 Dec 2021 23:12:16 +0530
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
Message-ID: <YapW+EY/IeUk1BLz@matsya>
References: <20211201074456.3969849-1-vkoul@kernel.org>
 <yq135nawg3q.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq135nawg3q.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 21:58, Martin K. Petersen wrote:
> 
> Vinod,
> 
> > Add the binding documentation for ufs SM8450 compatible, phy
> > compatible and SM8450 UFS QMP Phy support.
> 
> >  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  1 +
> >  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 32 +++++++++++++++++++
> 
> No objections from me. However, these patches should go through the DT
> and phy trees.

Ok I can pick these up wearing my phy maintainer hat, can u pls ack
it...

Thanks

-- 
~Vinod
